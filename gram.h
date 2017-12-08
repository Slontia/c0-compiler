#ifndef GRAM_H_INCLUDED
#define GRAM_H_INCLUDED

#define MAX_PARA_COUNT 100
#include <iostream>
#include <fstream>

#include <map>
#include <vector>

using namespace std;

class Item;

class FuncItem;
typedef map<string, FuncItem*> FUNC_MAP;
extern FUNC_MAP funcs;

int gram_main();

#endif // GRAM_H_INCLUDED
