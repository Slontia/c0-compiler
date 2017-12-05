#ifndef GRAM_H_INCLUDED
#define GRAM_H_INCLUDED

#define MAX_PARA_COUNT 100
#include <iostream>
#include <fstream>

#include <map>
#include <vector>

using namespace std;

class Item;



extern map<string, Item> global_signs;



class act_recorder {
public:
    vector<Item> items;
};

int gram_main();

#endif // GRAM_H_INCLUDED
