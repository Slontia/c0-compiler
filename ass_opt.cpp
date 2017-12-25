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
#define IS_GLOBAL_VAR(name) !cur_func_ASS->has_var(name) && global_vars.find(name) != global_vars.end()
using namespace std;

// temp <- temp
// var <- temp
// temp <- var
// var <- var

class Block {
public:
    int def_line;
    string name;
    Block* nature = NULL;

    Block(int line, string name)
    {
        this->def_line = line;
        this->name = name;
    }

    Block* get_nature()
    {
        Block* block = this;
        while (block->nature != NULL) {
            block = block->nature;
        }
        return block;
    }
};

FuncItem* cur_func_ASS = NULL;
vector<bool> code_actives;
typedef map<string, Block*> BLOCK_MAP;
BLOCK_MAP block_map;
int lineno = 0;
bool skip = false;
stringstream code_storage;

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
        if (useblock_nature->def_line >= 0)
        {
            code_actives[useblock_nature->def_line] = true;
        }
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
    code_storage << code[0];
    for (int i = 1; i < len; i++)
    {
        code_storage << " " << code[i];
    }
    code_storage << endl;
    lineno++;
}

void init_blocks()
{
    code_actives.clear();
    block_map.clear();
    lineno = 0;
    skip = false;
}

void output_medis()
{
    // 1. set vars used

    int output_lineno = 0;

    // 2. output if active

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
            init_blocks();
            cur_func_ASS = get_func(strs[1]);
            MIPS_OUTPUT(line);
        }
        else if (strs[0] == "@push" && !skip)
        {   // use
            code_actives.push_back(true);
            strs[1] = use(strs[1]);
            store_medi(strs);
        }
        else if (strs[0] == "@call" && !skip)
        {   //
            code_actives.push_back(true);
            BLOCK_MAP::iterator it = block_map.begin();
            while (it != block_map.end())
            {
                if (IS_GLOBAL_VAR(it->first))
                {
                    def(lineno, it->first);    // may be modified in function called
                    if (it->second->def_line >= 0)
                    {
                        code_actives[it->second->def_line] = true;
                        // save last assignment
                    }
                }
            }
            store_medi(strs);
        }
        else if (strs[0] == "@get" && !skip)
        {   // def
            code_actives.push_back(true);
            def(lineno, strs[1]);
            store_medi(strs);
        }
        else if (strs[0] == "@ret" && !skip)
        {   // use | output | skip
            code_actives.push_back(true);
            strs[1] = use(strs[1]);
            store_medi(strs);
            output_medis();
            skip = true;
        }
        else if (strs[0] == "@be" && !skip)
        {   // use
            code_actives.push_back(true);
            strs[1] = use(strs[1]);
            strs[2] = use(strs[2]);
            store_medi(strs);
        }
        else if (strs[0] == "@bz" && !skip)
        {   // use
            code_actives.push_back(true);
            strs[1] = use(strs[1]);
            store_medi(strs);
        }
        else if (strs[0] == "@j" && !skip)
        {   // output | skip
            output_medis();
            MIPS_OUTPUT(line);
            skip = true;
        }
        else if (strs[0] == "@jal" && !skip)
        {
            MIPS_OUTPUT(line);
        }
        else if (strs[0] == "@printf" && !skip)
        {   // use
            code_actives.push_back(true);
            if (strs[1] != "string")
            {
                strs[2] = use(strs[2]);
            }
            store_medi(strs);
        }
        else if (strs[0] == "@scanf" && !skip)
        {   // def
            code_actives.push_back(true);
            def(lineno, strs[2]);
            store_medi(strs);
        }
        else if (strs[0] == "@exit")
        {
        }
        else if (strs[1] == ":")
        {   // output | stop
            init_blocks();
            output_medis();
            MIPS_OUTPUT(line);
        }
        else if (strs.size() == 3 && !skip)
        {   // def
            code_actives.push_back(false);
            def(lineno, strs[0], strs[2]);
            store_medi(strs);
        }
        else if (strs.size() == 5 && !skip)
        {   // def | use
            code_actives.push_back(false);
            strs[2] = use(strs[2]);
            strs[4] = use(strs[4]);
            def(lineno, strs[0]);
            store_medi(strs);
        }
        else
        {
            error_debug("cal len not 3 or 5 in ass");
        }
    }
}

string ass_main(string filename) {
    fin.open((filename + ".txt").c_str());
    string ass_filename = filename + "_ASS";
    fout.open((ass_filename + ".txt").c_str());
    ass_read_medis();
    fout.close();
    fin.close();
    return ass_filename;
}
