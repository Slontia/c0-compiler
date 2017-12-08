#ifndef TAR_H_INCLUDED
#define TAR_H_INCLUDED
#include <iostream>
#include <map>

using namespace std;


typedef struct {
    int offset = 0;
    int use_count = 0;
    string name = "";
    bool save = false;
}Reg_recorder;


void tar_main();

#endif // TAR_H_INCLUDED
