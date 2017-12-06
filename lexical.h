#ifndef LEXICAL_H_INCLUDED
#define LEXICAL_H_INCLUDED

#include <iostream>
#include <fstream>
#include "vars.h"


using namespace std;

void error(string info);
void error_debug(string info);
string symbol2string(Symbol sym);
bool getsym();
int lexical_main();
bool next_end();

#endif // LEXICAL_H_INCLUDED
