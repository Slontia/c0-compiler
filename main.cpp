#include <iostream>
#include "lexical.h"
#include "gram.h"
#include "vars.h"

using namespace std;
FILE* progf = fopen("prog.txt", "r");
ofstream fout;
int main() {
    fout.open("output.txt");
    gram_main();
    return 0;
}
