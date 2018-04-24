#ifndef DAG_OPT_H_INCLUDED
#define DAG_OPT_H_INCLUDED

#include <iostream>
#include <map>
#include <vector>
using namespace std;

class Node;
class FuncItem;

typedef map<string, Node*> NODE_MAP;
extern NODE_MAP node_map;
extern vector<Node*> nodes;
extern int temp_count;
extern FuncItem* cur_func_DAG;

class Node {
public:
    int no;
    Node* lptr;
    Node* rptr;
    bool is_leaf;
    string content;
    bool is_certain;
    string name;

    Node(string value);
    Node(string op, Node* lptr, Node* rptr);
    void make_certain();
};

void read_medis();
NODE_MAP::iterator export_code(NODE_MAP::iterator it);
NODE_MAP::iterator record_code(NODE_MAP::iterator it);
void refresh_global_vars();
void refresh_vars();
void init_DAG();
bool has_node(string name);
void add_to_map(string name, Node* nodeptr);
void set_node(string name, Node* nodeptr, bool);
Node* get_node(string name);
void set_name(Node* node);
string get_name(Node* node);
string get_name(string old_name);
void build_DAG(vector<string> code);
string dag_main(string);
string use_new_name(string name);

#endif // DAG_OPT_H_INCLUDED
