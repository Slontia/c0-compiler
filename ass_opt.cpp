#include <iostream>
#include <map>
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
# define MIPS_OUTPUT(x) MIPS_LEFT << x << MIPS_RIGHT
# define IS_VAR(name) (name[0] == '_' || (name[0] >= 'a' && name[0] <= 'z'))
# define IS_TEMP(name) (name[0] == '#')
# define IS_GLOBAL_VAR(name) !cur_func_ASS->has_var(name) && global_vars.find(name) != global_vars.end()
# define HAS_TEMP(tempname) temp_map.find(tempname) != temp_map.end()
using namespace std;

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

/* @REQUIRES:
 * @MODIFIES: block_map
 * @EFFECTS:
 *  has_block(defname) => remove old block
 *                     => remove all blocks whose nature is defname
 *  usename == "" => nature = NULL
 *  usename != "" => nature = get_block(usename)
 */
void def(int line, string defname, string usename = "")
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
        defblock->nature = block_map[usename];
    }
    else    // assign
    {
        defblock->nature = new Block(-1, usename);
        block_map[usename] = defblock->nature;
    }
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

void output_medis(bool is_return = false)
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
            if (IS_TEMP(str))
            {
                str = get_new_temp(str);
            }
            ss << str;
            while (is >> str)
            {
                ss << " ";
                if (IS_TEMP(str))
                {
                    str = get_new_temp(str);
                }
                ss << str;
            }
            MIPS_OUTPUT(ss.str());
            int len = line_map[l]->last_use_names.size();
            for (int i = 0; i < len; i++)
            {
                remove_temp(line_map[l]->last_use_names[i]);
            }
        }
        l++;
    }
    code_storage.clear();

    // 3. refresh temp map

}

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

        // cout << line << endl;

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
            store_medi(strs);
        }
        else if (strs[0] == "@call" && !skip)
        {
            //
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
        else if (strs[1] == ":")
        {
            // output | stop
            output_medis();
            init_blocks();
            MIPS_OUTPUT(line);
        }
        else if (strs.size() == 3 && !skip)
        {
            // def
            line_map[lineno] = new Line(false);
            def(lineno, strs[0], strs[2]);
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
}

string ass_main(string filename)
{
    fin.open((filename + ".txt").c_str());
    string ass_filename = filename + "_ASS";
    fout.open((ass_filename + ".txt").c_str());
    ass_read_medis();
    fout.close();
    fin.close();
    return ass_filename;
}
