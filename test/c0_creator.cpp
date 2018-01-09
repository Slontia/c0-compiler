#include <iostream>
#include <map>
#include <vector>
#include <stdlib.h>
#include <time.h>
#include <fstream>
#include <sstream>
#define ARRAY_LEN 2
#define MAX_POINT 100
#define IF_INS_COUNT 10
#define FUNC_INS_COUNT 30
#define DEBUG 0
#if DEBUG
#define OUTPUT(stream) cout << stream;
#else
#define OUTPUT(stream) { ftxt << stream; fcpp << stream; }
#endif
using namespace std;

string global_vars[] = {"glo_a", "glo_b", "glo_c"};
string global_arrays[] = {"glo_array_a", "glo_array_b"};
string local_vars[] = {"a", "b", "c"};
string local_arrays[] = {"array_a", "array_b"};
string cal_ops[] = {"+", "-", "*"};
string comp_ops[] = {"<", ">", "<=", ">=", "==", "!="};
string funcnames[] = {"foo1", "foo2", "foo3", "foo4"};
string paras[] = {"para_a", "para_b"};

ofstream ftxt;
ofstream fcpp;

int get_random_num(int range, int lower = 0)
{
    return rand() % range + lower;
}

bool get_random_bool()
{
    return rand() % 2;
}

template<class T,int N>
T get_random_ele( T (&ia)[N])
{
    int index = get_random_num(N);
    return ia[index];
}


template <typename T>
class RandomGetter
{
private:
	typedef map<T, int> ODD_MAP;
	ODD_MAP odd_map;

public:
	RandomGetter(){}

	void put(T item, int point)
	{
		odd_map.insert(pair<T, int>(item, point));
	}

	// {{print_array, 50},{print_var, 40}, {print_item, 9}}
	T get()
	{
		int rand_result = get_random_num(MAX_POINT, 1);
		int odd_sum = 0;
		typename ODD_MAP::iterator it = odd_map.begin();
		while (it != odd_map.end())
		{
			odd_sum += it->second;
			if (odd_sum >= rand_result)
			{
				return it->first;
			}
			it++;
		}
		return odd_map.begin()->first; // insurance
	}
};

void print_immed()
{
    OUTPUT(get_random_num(10, 1))
}

int get_index()
{
	return get_random_num(ARRAY_LEN);
}

string get_arrayname()
{
    bool is_global = get_random_bool();
    return get_random_ele(is_global ? global_arrays : local_arrays);
}

void print_array()
{
	OUTPUT(get_arrayname() << "[" << get_index() << "]")
}

void print_global_var()
{
    OUTPUT(get_random_ele(global_vars))
}

void print_local_var()
{
    OUTPUT(get_random_ele(local_vars))
}

void print_para_var()
{
    OUTPUT(get_random_ele(paras))
}

void print_var()
{
    typedef void(*handle)();
    RandomGetter<handle> rgetter;
    rgetter.put(print_global_var, 30);
    rgetter.put(print_local_var, 50);
    rgetter.put(print_para_var, 20);
    void (*func)() = rgetter.get();
    (*func)();
}

void print_expression();
void print_item(bool to_use)
{
    typedef void(*handle)();
    RandomGetter<handle> rgetter;
    rgetter.put(print_array, to_use ? 30 : 60);
    rgetter.put(print_var, to_use ? 30 : 40);
    rgetter.put(print_immed, to_use ? 15 : 0);
    rgetter.put(print_expression, to_use ? 15 : 0);
    void (*func)() = rgetter.get();
    (*func)();
}

void print_cal_op()
{
    OUTPUT(get_random_ele(cal_ops))
}

void print_expression()
{
    OUTPUT("(")
    print_item(true);
    while (get_random_num(100) <= 50)
    {
        OUTPUT(" ")
        print_cal_op();
        OUTPUT(" ")
        print_item(true);
    }
    OUTPUT(")");
}

void print_return()
{
	OUTPUT("return ")
	print_expression();
	OUTPUT(";" << endl)
}

void print_assign()
{
    print_item(false);
    OUTPUT(" = ")
    print_expression();
    OUTPUT(";" << endl)
}

void print_comp_op()
{
    OUTPUT(get_random_ele(comp_ops))
}

void print_conf()
{
    print_expression();
    OUTPUT(" ")
    print_comp_op();
    OUTPUT(" ")
    print_expression();
}

void print_printf()
{
    OUTPUT("printf")
    print_expression();
    OUTPUT(";" << endl)
}

void print_if();
void print_instructors(int count)
{
    OUTPUT(endl << "{" << endl)
    for (int i = 0; i < count; i++)
    {
        typedef void(*handle)();
        RandomGetter<handle> rgetter;
        rgetter.put(print_assign, 85);
        rgetter.put(print_if, 5);
        rgetter.put(print_printf, 10);
        (*(rgetter.get()))();
    }
    OUTPUT("}" << endl)
}

template<int N>
void print_declare_vars(string (&ar)[N])
{
    for (int i = 0; i < N; i++)
    {
        OUTPUT("int " << ar[i] << ";" << endl)
    }
}

template<int N>
void print_init_vars(string (&ar)[N])
{
    for (int i = 0; i < N; i++)
    {
        OUTPUT(ar[i] << " = " << get_random_num(100) << ";" << endl)
    }
}

template<int N>
void print_declare_arrays(string (&ar)[N])
{
    for (int i = 0; i < N; i++)
    {
        OUTPUT("int " << ar[i] << "[" << ARRAY_LEN << "];" << endl)
    }
}

template<int N>
void print_init_arrays(string (&ar)[N])
{
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < ARRAY_LEN; j++)
        {
            OUTPUT(ar[i] << "[" << j << "] = " << get_random_num(100) << ";" << endl)
        }
    }
}

void print_call(string funcname)
{
	OUTPUT(funcname << "(")
	print_expression();
	OUTPUT(", ");
	print_expression();
	OUTPUT(");" << endl);
}

void print_function(string funcname)
{
    OUTPUT("int " << funcname)
    int len = sizeof(paras) / sizeof(paras[0]);
    if (len != 0)
    {
        OUTPUT("(int " << paras[0]);
        for (int i = 1; i < len; i++)
        {
            OUTPUT(", int " << paras[i]);
        }
        OUTPUT(")" << endl << "{" << endl);
    }
    print_declare_vars(local_vars);
    print_declare_arrays(local_arrays);
    print_init_vars(local_vars);
    print_init_arrays(local_arrays);
    print_instructors(FUNC_INS_COUNT);
    print_return();
    OUTPUT("}");
}

void print_main()
{
	ftxt << "void ";
	fcpp << "int ";
	OUTPUT("main()" << endl << "{" << endl)
	print_init_vars(global_vars);
	print_init_arrays(global_arrays);
	OUTPUT("foo1(" << get_random_num(20, -10) << ", " << get_random_num(20, -10) << ");" << endl)
	OUTPUT("}")
}

void print_if()
{
    OUTPUT("if (")
    print_conf();
    OUTPUT(")")
    print_instructors(IF_INS_COUNT);
    OUTPUT("else")
    print_instructors(IF_INS_COUNT);
}




void print_prog()
{
    print_declare_vars(global_vars);
    print_declare_arrays(global_arrays);
    OUTPUT(endl)
	print_function("foo1");
	OUTPUT(endl)
	print_main();
}

int main()
{
	srand((unsigned)time(NULL));
	for (int i = 0; i < 1; i++)
	{
		stringstream ss_txt, ss_cpp;
		ss_txt << "prog_" << i << ".txt";
		ss_cpp << "prog_" << i << ".cpp";
		ftxt.open(ss_txt.str().c_str());
		fcpp.open(ss_cpp.str().c_str());
		print_prog();
		ftxt.close();
		fcpp.close();
	}
}
