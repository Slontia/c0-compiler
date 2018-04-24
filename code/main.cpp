#include <iostream>
#include <sstream>
#include "lexical.h"
#include "gram.h"
#include "vars.h"
#include "dag_opt.h"
#include "ass_opt.h"
#include "livevar_ana.h"
#include "rem_opt.h"
#include "c0_compiler.h"
#include "main.h"
#define CACHE_SIZE 3
#define FILE_PATH "./output/"
#if NEW_TAR
#include "tar.h"
#else
#include "old_tar.h"
#endif // NEW_TAR

using namespace std;

int line_count_cache[CACHE_SIZE] = {0};
int file_count = 0;

bool output_is_stable()
{
    for (int i = 0; i < CACHE_SIZE - 1; i++)
    {
        if (line_count_cache[i] != line_count_cache[i+1])
        {
            line_count_cache[i+1] = line_count_cache[i];
            return false;
        }
    }
    return true;
}

string get_filename(string info)
{
    stringstream ss;
    ss << FILE_PATH << "medi_" << file_count++ << "_" << info << ".txt";
    return ss.str();
}

string get_logname()
{
    return (string)FILE_PATH + "livevar_log.txt";
}

string get_tarname(bool is_new = true)
{
    if (is_new)
    return (string)FILE_PATH + "target.asm";
    else
    return (string)FILE_PATH + "old_target.asm";
}

int main()
{
    string filename = "";
    if (!AUTO_TEST)
    {
        cout << "Enter the filename:" << endl;
        cin >> filename;
    }
    else
    {
        filename = creator_main();
    }
    filename = gram_main(filename);

    #if NEW_TAR
    if (!success) return 0;
    do
    {
        filename = dag_main(filename);
        filename = ass_main(filename, &line_count_cache[0]);
    } while (!output_is_stable());
    filename = livevar_main(filename);
    filename = brjp_main(filename);
    #endif

    tar_main(filename);
    return 0;
}
