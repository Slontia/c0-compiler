#include <iostream>
#include "lexical.h"
#include "gram.h"
#include "vars.h"
#include "tar.h"
#include "dag_opt.h"

using namespace std;


int main()
{
    gram_main();
    if (!success) return 0;
    dag_main();
    tar_main();

    return 0;
}
