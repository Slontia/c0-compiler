#include <iostream>
#include "lexical.h"
#include "gram.h"
#include "vars.h"
#include "tar.h"

using namespace std;


int main() {
    gram_main();
    if (!success) return 0;
    tar_main();

    return 0;
}
