#include <iostream>
#include "lexical.h"
#include "gram.h"
#include "vars.h"
#include "tar.h"
#include "dag_opt.h"
#include "ass_opt.h"
#include "livevar_ana.h"
#define INPUT_FILENAME 1

using namespace std;


int main()
{
    string filename = "prog01.txt";
    if (INPUT_FILENAME)
    {
        cout << "Enter the filename:" << endl;
        cin >> filename;
    }
    filename = gram_main(filename);
    if (!success) return 0;
    int line_count = 0;
    int last_line_count = 0;
    do
    {
        last_line_count = line_count;
        filename = dag_main(filename);
        filename = ass_main(filename, &line_count);
    } while (line_count != last_line_count);
    filename = livevar_main(filename);
    filename = tar_main(filename);
    return 0;
}
