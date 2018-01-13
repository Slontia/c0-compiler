#include <iostream>
#include <map>
#include <list>
#include "vars.h"
#include "tar.h"
#include "gram.h"
#include "item.h"
#include "lexical.h"
#include <vector>
#include <sstream>
# define DEBUG 0
# if DEBUG
# define MIPS_LEFT cout << "<==="
# define MIPS_RIGHT "===>" << endl
# else
# define MIPS_LEFT fout
# define MIPS_RIGHT endl
# endif // DEBUG
# define MIPS_OUTPUT(x) MIPS_LEFT << x << MIPS_RIGHT; line_count++
# define IS_VAR(name) (name[0] == '_' || (name[0] >= 'a' && name[0] <= 'z'))
# define IS_TEMP(name) (name[0] == '#')
# define IS_GLOBAL_VAR(name) (!cur_func_ASS->has_var(name) && global_vars.find(name) != global_vars.end())
# define HAS_TEMP(tempname) temp_map.find(tempname) != temp_map.end()
# include "main.h"

using namespace std;

#if NEW_TAR

int line_count = 0;

// temp <- temp
// var <- temp
// temp <- var
// var <- var
class Line
{
public:
    bool active = false;
    vector<string> last_use_names;  // must be temp

    Line(bool active)
    {
        this->active = active;
    }
};

class Block
{
public:
    int def_line;
    string name;
    Block* nature = NULL;
    int last_used_line = -1;

    Block(int line, string name)
    {
        this->def_line = line;
        this->name = name;
    }

    Block* get_nature()
    {
        Block* block = this;
        while (block->nature != NULL)
        {
            block = block->nature;
        }
        return block;
    }
};

FuncItem* cur_func_ASS = NULL;
typedef map<int, Line*> LINE_MAP;
LINE_MAP line_map;
typedef map<string, Block*> BLOCK_MAP;
BLOCK_MAP block_map;
typedef map<string, string> TEMP_MAP;
vector<string> temp_storage;
int new_temp_count = 0;
TEMP_MAP temp_map;
int lineno = 0;
bool skip = false;
stringstream code_storage;

bool has_line(int line)
{
    return (line_map.end() != line_map.find(line));
}

void save_used_to_line(Block* useblock)
{
    if (has_line(useblock->def_line))    // defined by "="
    {
        useblock->last_used_line = lineno;  // seems not necessary
        Line* line = line_map[useblock->def_line];
        line->active = true;    // set line active
    }
}

bool has_block(string name)
{
    return (block_map.find(name) != block_map.end());
}

string use(string usename);

/* @REQUIRES:
 * @MODIFIES: block_map
 * @EFFECTS:
 *  has_block(defname) => remove old block
 *                     => remove all blocks whose nature is defname
 *  usename == "" => nature = NULL
 *  usename != "" => nature = get_block(usename)
 */
string def(int line, string defname, string usename = "")
{
    Block* defblock = NULL;
    if (has_block(defname))
    {
        // disable natures pointing to defblock
        defblock = block_map[defname];
        BLOCK_MAP::iterator it = block_map.begin();
        while (it != block_map.end())
        {
            if (it->second->nature == defblock)
            {
                it->second->nature = NULL;
            }
            it++;
        }
        defblock->def_line = line;  // refresh def_line
        if (has_line(defblock->last_used_line) && defblock->name[0] == '#')
        {
            line_map[defblock->last_used_line]->last_use_names
            .push_back(defblock->name);
            defblock->last_used_line = -1;
        }
    }
    else
    {
        // create defblock
        defblock = new Block(line, defname);
        block_map[defname] = defblock;
    }
    if (usename == "")  // cal
    {
        defblock->nature = NULL;
    }
    else if (has_block(usename))    // assign
    {
        //cout << usename << " ";
        defblock->nature = block_map[usename];
        use(usename);
        return defblock->get_nature()->name;
    }
    else    // assign
    {
        //cout << usename << " ";
        defblock->nature = new Block(-1, usename);
        block_map[usename] = defblock->nature;
        return defblock->get_nature()->name;
    }
    return "";
}

/* @REQUIRES:
 * @MODIFIES: block_map
 * @EFFECTS:
 *  has_block(usename) => set nature used
 *                  => return nature's name
 *  !has_block(usename) => just return usename
 */
string use(string usename)
{
    if (has_block(usename))
    {
        Block* useblock_nature = block_map[usename]->get_nature();
        // cout << "use:" << usename << endl;
        save_used_to_line(useblock_nature);
        return useblock_nature->name;
    }
    else
    {
        return usename;
    }
}

void store_medi(vector<string> code)
{
    int len = code.size();
    // cout << code_storage.str() << endl;
    code_storage << code[0];
    // cout << code_storage.str() << endl;
    for (int i = 1; i < len; i++)
    {
        code_storage << " " << code[i];
    }
    code_storage << "\n";
    // cout << code_storage.str() << endl;
    lineno++;
}

void init_blocks()
{
    new_temp_count = 0;
    temp_storage.clear();
    LINE_MAP::iterator line_it = line_map.begin();
    while (line_it != line_map.end())
    {
        line_it->second->last_use_names.clear();
        delete(line_it->second);
        line_it++;
    }
    line_map.clear();
    BLOCK_MAP::iterator block_it = block_map.begin();
    while (block_it != block_map.end())
    {
        delete(block_it->second);
        block_it++;
    }
    block_map.clear();
    temp_map.clear();
    lineno = 0;
    skip = false;
}

string get_new_temp(string tempname)
{
    if (temp_map.find(tempname) != temp_map.end())
    {
        // has temp
        return temp_map[tempname];
    }
    else if (!temp_storage.empty())
    {
        temp_map[tempname] = temp_storage.front();
        temp_storage.erase(temp_storage.begin());
        return temp_map[tempname];
    }
    else
    {
        int tempno = new_temp_count++;
        stringstream ss;
        ss << "#" << tempno;
        temp_map[tempname] = ss.str();
        return temp_map[tempname];
    }
}

void remove_temp(string tempname)
{
    TEMP_MAP::iterator it = temp_map.find(tempname);
    if (it != temp_map.end())
    {
        MIPS_OUTPUT("@free " << it->second);
        temp_storage.push_back(it->second);
        temp_map.erase(it);
    }
}

void save_vars()
{
    BLOCK_MAP::iterator it = block_map.begin();
    while (it != block_map.end())
    {
        if (IS_VAR(it->first) && has_line(it->second->def_line))
        {
            line_map[it->second->def_line]->active = true;
        }
        it++;
    }
}

void snatch_new_temp(string oldtemp, string newtemp)
{
    TEMP_MAP::iterator it = temp_map.begin();
    while (it != temp_map.end())
    {
        string cur_newtemp = it->second;
        if (cur_newtemp == newtemp)
        {
            temp_map.erase(it);
            break;
        }
        it++;
    }
    //cout << oldtemp << "\t" << newtemp << endl;
    temp_map.insert(TEMP_MAP::value_type(oldtemp, newtemp));
}

bool is_last_use(string oldname, int lineno)
{
    vector<string>::iterator it = line_map[lineno]->last_use_names.begin();
    while (it != line_map[lineno]->last_use_names.end())
    {
        if (*it == oldname) // found
        {
            return true;
        }
        it++;
    }
    return false;
}

template <class A, class B>
bool has_key(const map<A, B> &m, const A key)
{
    return (m.find(key) != m.end());
}

void set_last_use_before_output(bool is_return)
{
    BLOCK_MAP::iterator it = block_map.begin();
    while (it != block_map.end())
    {
        if (((!is_return && IS_VAR(it->first)) || IS_GLOBAL_VAR(it->first))
                && has_line(it->second->def_line))
        {
            line_map[it->second->def_line]->active = true;
        }
        else if (IS_TEMP(it->first) && has_line(it->second->last_used_line))
        {
            // cout << it->second->last_used_line << endl;
            line_map[it->second->last_used_line]->last_use_names
            .push_back(it->first);
        }
        it++;
    }
}

void output_medis(bool is_return = false)
{
    set_last_use_before_output(is_return);

    string line;
    int l = 0;
    // cout << code_storage.str() << endl;
    while (getline(code_storage, line))
    {
        if (!has_line(l))
        {
            MIPS_OUTPUT(line);
        }
        else if (line_map[l]->active)
        {
            istringstream is(line);
            stringstream ss;
            string str;
            is >> str;
            TEMP_MAP cur_temp_map;
            string def_oldtemp = "";
            bool def_got_temp = true;
            if (IS_TEMP(str))
            {
                def_oldtemp = str;
                if (has_key(temp_map, def_oldtemp))
                {
                    cur_temp_map.insert(TEMP_MAP::value_type(def_oldtemp, temp_map[def_oldtemp]));
                    def_got_temp = true;
                }
                else
                {
                    def_got_temp = false;
                }
            }
            // read line
            while (is >> str)
            {
                // got temp
                if (IS_TEMP(str) && !has_key(cur_temp_map, str))
                {
                    // insert into map
                    cur_temp_map.insert(TEMP_MAP::value_type
                        (str, get_new_temp(str)));
                    // if 'def' = 'use'
                    if (def_oldtemp == str)
                    {
                        def_got_temp = true;
                    }
                }
            }
            // clear list use temp
            TEMP_MAP::iterator it = cur_temp_map.begin();
            while (it != cur_temp_map.end())
            {
                string old_temp = it->first;
                string new_temp = it->second;
                // 'def' have not got temp and can got now
                if (!def_got_temp && is_last_use(old_temp, l))
                {
                    // change temp map
                    snatch_new_temp(def_oldtemp, new_temp);
                    // insert into cur temp map
                    cur_temp_map.insert(TEMP_MAP::value_type(def_oldtemp, new_temp));
                    def_got_temp = true;
                }
                else if (is_last_use(old_temp, l))
                {
                    // remove key 'old temp' from temp map
                    remove_temp(old_temp);
                }
                it++;
            }
            if (!def_got_temp)
            {
                cur_temp_map.insert(TEMP_MAP::value_type(def_oldtemp, get_new_temp(def_oldtemp)));
            }
            // reset istringstream
            is.clear();
            is.str(line);
            is >> str;
            if (IS_TEMP(str))
            {
                str = cur_temp_map[str];
            }
            ss << str;
            // read and output
            while (is >> str)
            {
                ss << " ";
                if (IS_TEMP(str))
                {
                    str = cur_temp_map[str];
                }
                ss << str;
            }
            MIPS_OUTPUT(ss.str());
        }
        l++;
    }
    code_storage.clear();
}

bool outed = false;

// @REQUIRES: len(strs) == 5
void expre_opt(vector<string>* strs)
{
    if (strs->size() != 5 || (*strs)[0][0] == '@')
    {
        return;
    }
    string tar = (*strs)[0];
    string op = (*strs)[3];
    string cal1 = (*strs)[2];
    string cal2 = (*strs)[4];
    string result = "";
    if (is_num(cal1) && is_num(cal2) && op != "ARSET")
    {
        int num1, num2, result_value;
        sscanf(cal1.c_str(), "%d", &num1);
        sscanf(cal2.c_str(), "%d", &num2);
        if (op == "SUB") result_value = num1 - num2;
        else if (op == "ADD") result_value = num1 + num2;
        else if (op == "DIV")
        {
            if (num2 == 0)
            {
                warning("may division by zero");
                result_value = 0;
            }
            else
            {
                result_value = num1 / num2;
            }
        }
        else if (op == "MUL") result_value = num1 * num2;
        else if (op == "GT") result_value = (num1 > num2);
        else if (op == "GE") result_value = (num1 >= num2);
        else if (op == "LT") result_value = (num1 < num2);
        else if (op == "LE") result_value = (num1 <= num2);
        else if (op == "EQ") result_value = (num1 == num2);
        else if (op == "NE") result_value = (num1 != num2);
        else error_debug((string)"unknown op \'" + op + "\' in expression opt");
        stringstream ss;
        ss << result_value;
        result = ss.str();
    }
    else if (op == "ADD")
    {
        if (cal1 == "0") result = cal2;
        else if (cal2 == "0") result = cal1;
    }
    else if (op == "SUB") // a = b - b
    {
        if (cal1 == cal2) result = "0";
        else if (cal2 == "0") result = cal1;
    }
    else if (op == "MUL")
    {
        if (cal1 == "0" || cal2 == "0") result = "0";
        else if (cal1 == "1") result = cal2;
        else if (cal2 == "1") result = cal1;
    }
    else if (op == "DIV")
    {
        if (cal1 == "0") result = "0";
        else if (cal2 == "1") result = cal1;
        else if (cal1 == cal2) result = "1";
    }
    else if (op == "NE" && cal1 == cal2)
    {
        result = "0";
    }
    else if (op == "EQ" && cal1 == cal2)
    {
        result = "1";
    }
    if (result != "")
    {
        strs->clear();
        strs->push_back(tar);
        strs->push_back("=");
        strs->push_back(result);
        // if (!outed) cout << tar <<" = " << result << endl;
    }
}


list<string> call_stack;


void ass_read_medis()
{
    string line;
    while(getline(fin, line))
    {
        istringstream is(line);
        string str;
        vector<string> strs;
        while (is >> str)
        {
            strs.push_back(str);
        }

        expre_opt(&strs);
        if (strs[0] == "@var" || strs[0] == "@array")
        {
            MIPS_OUTPUT(line);
        }
        else if (strs[0] == "@para")
        {
            MIPS_OUTPUT(line);
        }
        else if (strs[0] == "@func")
        {
            output_medis();
            init_blocks();
            cur_func_ASS = get_func(strs[1]);
            MIPS_OUTPUT(line);
        }
        else if (strs[0] == "@push" && !skip)
        {
            // use
            line_map[lineno] = new Line(true);
            strs[1] = use(strs[1]);
            call_stack.push_back(strs[1]);
            store_medi(strs);
        }
        else if (strs[0] == "@call" && !skip)
        {
            // use paras
            int len = get_func(strs[1])->get_para_count();
            for (int i = 0; i < len; i++)
            {
                use(call_stack.front());
                call_stack.pop_front();
            }
            // store line
            line_map[lineno] = new Line(true);
            BLOCK_MAP::iterator it = block_map.begin();
            while (it != block_map.end())
            {
                if (IS_GLOBAL_VAR(it->first))
                {
                    save_used_to_line(it->second);
                    def(lineno, it->first);    // may be modified in function called
                }
                it++;
            }
            store_medi(strs);
        }
        else if (strs[0] == "@get" && !skip)
        {
            // def
            line_map[lineno] = new Line(true);
            def(lineno, strs[1]);
            store_medi(strs);
        }
        else if (strs[0] == "@ret" && !skip)
        {
            // use | output | skip
            line_map[lineno] = new Line(true);
            if (strs.size() > 1)
            {
                strs[1] = use(strs[1]);
            }
            store_medi(strs);
            output_medis(true);
            skip = true;
        }
        else if (strs[0] == "@be" && !skip)
        {
            // use
            line_map[lineno] = new Line(true);
            strs[1] = use(strs[1]);
            strs[2] = use(strs[2]);
            store_medi(strs);
            save_vars();
        }
        else if (strs[0] == "@bz" && !skip)
        {
            if (is_num(strs[1]) != 0)
            {
                continue;
            }
            // use
            line_map[lineno] = new Line(true);
            strs[1] = use(strs[1]);
            store_medi(strs);
            save_vars();
        }
        else if (strs[0] == "@j" && !skip)
        {
            // output | skip
            line_map[lineno] = new Line(true);
            output_medis();
            MIPS_OUTPUT(line);
            skip = true;
        }
        else if (strs[0] == "@jal" && !skip)
        {
            MIPS_OUTPUT(line);
        }
        else if (strs[0] == "@printf" && !skip)
        {
            // use
            line_map[lineno] = new Line(true);
            if (strs[1] != "string")
            {
                strs[2] = use(strs[2]);
            }
            store_medi(strs);
        }
        else if (strs[0] == "@scanf" && !skip)
        {
            // def
            line_map[lineno] = new Line(true);
            def(lineno, strs[2]);
            store_medi(strs);
        }
        else if (strs[0] == "@exit")
        {
            output_medis(true);
            init_blocks();
            MIPS_OUTPUT(line);
        }
        else if (strs[0] == "@free") {}
        else if (strs[1] == ":")
        {
            // output | stop
            output_medis();
            init_blocks();
            MIPS_OUTPUT(line);
        }
        else if (strs.size() == 3 && !skip)
        {
            // def | use
            line_map[lineno] = new Line(false);
            strs[2] = def(lineno, strs[0], strs[2]);
            store_medi(strs);
        }
        else if (strs.size() == 5 && !skip)
        {
            // def | use
            strs[2] = use(strs[2]);
            strs[4] = use(strs[4]);
            if (strs[3] == "ARSET")
            {
                line_map[lineno] = new Line(true);
            }
            else
            {
                line_map[lineno] = new Line(false);
                def(lineno, strs[0]);
            }
            store_medi(strs);
        }
        else if (!skip)
        {
            error_debug("cal len not 3 or 5 in ass");
        }
    }
    outed = true;
}

string ass_main(string filename, int *lc)
{
    init_blocks();
    line_count = 0;
    fin.open(filename.c_str());
    string ass_filename = get_filename("ASS");
    fout.open(ass_filename.c_str());
    ass_read_medis();
    fout.close();
    fin.close();
    *lc = line_count;
    return ass_filename;
}

#endif
