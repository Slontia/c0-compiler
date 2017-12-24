#include <iostream>
#include <map>
#include "vars.h"
#include "tar.h"
#include <vector>
#include <sstream>
using namespace std;

// temp <- temp
// var <- temp
// temp <- var
// var <- var

typedef struct {
    bool used;
    string name;
    int def_line;
} Temp_block;

map<int, Temp_block> temp_map;

void use(string name)
{
}


void read_medis_()
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
        }
        else if (strs[0] == "@para")
        {
        }
        else if (strs[0] == "@func")
        {
        }
        else if (strs[0] == "@push")
        {
        }
        else if (strs[0] == "@call")
        {
        }
        else if (strs[0] == "@get")
        {
        }
        else if (strs[0] == "@ret")
        {
        }
        else if (strs[0] == "@be")
        {
        }
        else if (strs[0] == "@bz")
        {
        }
        else if (strs[0] == "@j")
        {
        }
        else if (strs[0] == "@jal")
        {
        }
        else if (strs[0] == "@printf")
        {
        }
        else if (strs[0] == "@scanf")
        {
        }
        else if (strs[0] == "@exit")
        {
        }
        else if (strs[1] == ":")
        {
        }
        else if (strs.size() == 3)
        {

        }
        else if (strs.size() == 5)
        {

        }
        else
        {

        }
    }
}

string ass_main(string filename) {
    fin.open((filename + ".txt").c_str());
    string ass_filename = filename + "_ASS";
    fout.open((ass_filename + ".txt").c_str());

}
