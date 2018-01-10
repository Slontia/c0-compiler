#include <iostream>
#include <list>
#include <vector>
#include "lexical.h"
#include <sstream>
# define DEBUG 0
# if DEBUG
# define MIPS_LEFT cout << "<==="
# define MIPS_RIGHT "===>"
# else
# define MIPS_LEFT fout
# define MIPS_RIGHT endl
# endif // DEBUG
# define MIPS_OUTPUT(x) MIPS_LEFT << x << MIPS_RIGHT
using namespace std;

list<string> line_heap;

typedef struct
{
    string tar;
    string branch_head;
} Conf_recorder;
Conf_recorder conf_rec;

string label = "";

typedef enum
{
    CONF, JUMP, FREE
} Status;
Status status = FREE;

bool try_store_conf(vector<string> conf_strs)
{
    string op = conf_strs[3];
    string cal1 = conf_strs[2];
    string cal2 = conf_strs[4];
    string tar = conf_strs[0];
    bool store = false;
    if (op == "EQ")
    {
        store = true;
        conf_rec.tar = tar;
        conf_rec.branch_head = (string)"@bne " + cal1 + " " + cal2;
    }
    else if (op == "NE")
    {
        store = true;
        conf_rec.tar = tar;
        conf_rec.branch_head = (string)"@be " + cal1 + " " + cal2;
    }
    else if (op == "GE")
    {
        if (cal1 == "0")
        {
            store = true;
            conf_rec.tar = tar;
            conf_rec.branch_head = (string)"@bgtz " + cal2;
        }
        else if (cal2 == "0")
        {
            store = true;
            conf_rec.tar = tar;
            conf_rec.branch_head = (string)"@bltz " + cal1;
        }
    }
    else if (op == "LE")
    {
        if (cal1 == "0")
        {
            store = true;
            conf_rec.tar = tar;
            conf_rec.branch_head = (string)"@bltz " + cal2;
        }
        else if (cal2 == "0")
        {
            store = true;
            conf_rec.tar = tar;
            conf_rec.branch_head = (string)"@bgtz " + cal1;
        }
    }
    else if (op == "GT")
    {
        if (cal1 == "0")
        {
            store - true;
            conf_rec.tar = tar;
            conf_rec.branch_head = (string)"@bgez " + cal2;

        }
        else if (cal2 == "0")
        {
            store = true;
            conf_rec.tar = tar;
            conf_rec.branch_head = (string)"@blez " + cal1;
        }
    }
    else if (op == "LT")
    {
        if (cal1 == "0")
        {
            store = true;
            conf_rec.tar = tar;
            conf_rec.branch_head = (string)"@blez " + cal2;

        }
        else if (cal2 == "0")
        {
            store = true;
            conf_rec.tar = tar;
            conf_rec.branch_head = (string)"@bgez " + cal1;
        }
    }
    if (store)
    {
        status = CONF;
    }
    return store;
}

void output_heap(bool skip)
{
    list<string>::iterator it = line_heap.begin();
    if (it == line_heap.end())
    {
        error_debug("empty line_heap in rem");
    }
    if (skip)
    {
        it++;
    }
    while (it != line_heap.end()) // skip branch | jump
    {
        MIPS_OUTPUT(*it); // output line in heap
        it++;
    }
    line_heap.clear();
}

void brjp_read_medis()
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

        // find label
        if (line[0] != '@' && strs[1] == ":") // label
        {
            if (status == JUMP && label == strs[0])
            {
                // output heap
                output_heap(true);
                MIPS_OUTPUT(line); // output this line
                status = FREE;
            }
            else if (status == JUMP)
            {
                // store
                line_heap.push_back(line);
            }
            else if (status == FREE)
            {
                MIPS_OUTPUT(line);
            }
            else
            {
                error_debug((string)"label \'" + strs[0] + "\' meet CONF");
            }
            continue;
        }

        // clear heap
        if (status == JUMP)
        {
            output_heap(false);
            status = FREE;
        }

        // switch other midis
        if (strs[0] == "@be" )
        {
            label = strs[3];
            line_heap.push_back(line);
            status = JUMP;
        }
        else if (strs[0] == "@bz" )
        {
            string branch_line = line;
            label = strs[2];
            if (status == CONF)
            {
                if (conf_rec.tar == strs[1])
                {
                    branch_line = conf_rec.branch_head + " " + label;
                }
                else
                {
                    error_debug("branch name does not match in brjp. expected: \'"
                        + conf_rec.tar + "\' actual: \'" + strs[1] + "\'");
                }
            }
            line_heap.push_back(branch_line);
            status = JUMP;
        }
        else if (strs[0] == "@j" )
        {
            line_heap.push_back(line);
            label = strs[1];
            status = JUMP;
        }
        else if (line[0] != '@' && strs.size() == 5 ) // cal
        {
            if (!try_store_conf(strs))
            {
                MIPS_OUTPUT(line);
            }
        }
        else
        {
            MIPS_OUTPUT(line);
        }
    }
}

string brjp_main(string filename)
{
    fin.open(filename.c_str());
    string brjp_filename = get_filename("BRJP");
    fout.open(brjp_filename.c_str());
    brjp_read_medis();
    fout.close();
    fin.close();
    return brjp_filename;
}
