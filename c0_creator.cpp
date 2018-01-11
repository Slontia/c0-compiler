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
#define VAR_MIN -5
#define VAR_RANGE 10
#define PARA_MIN -5
#define PARA_RANGE 10
#define IMMED_MIN -5
#define IMMED_RANGE 10


#define PARA_COUNT_INPUT 2

#define FUNC_COUNT 4
#define LOCAL_ARRAY_COUNT 2
#define LOCAL_VAR_COUNT 3
#define GLOBAL_ARRAY_COUNT 2
#define GLOBAL_VAR_COUNT 3
#if (PARA_COUNT_INPUT > LOCAL_VAR_COUNT)
#define PARA_COUNT LOCAL_VAR_COUNT
#else
#define PARA_COUNT PARA_COUNT_INPUT
#endif

#define DEBUG 0
#if DEBUG
#define OUTPUT(stream) cout << stream;
#else
#define OUTPUT(stream) { ftxt << stream; fcpp << stream; }
#endif
using namespace std;

string cal_ops[] = {"+", "-", "*"};
string comp_ops[] = {"<", ">", "<=", ">=", "==", "!="};
string glo_vars[GLOBAL_VAR_COUNT];
string global_arrays[GLOBAL_ARRAY_COUNT];
string local_vars[LOCAL_VAR_COUNT];
string local_arrays[LOCAL_ARRAY_COUNT];
string funcnames[FUNC_COUNT];
string parameters[PARA_COUNT];

ofstream ftxt;
ofstream fcpp;

template<class T,int N>
void init_string_array(T (&ar)[N], string head, char no = 'a')
{
	for (int i = 0; i < N; i++)
	{
		ar[i] = head + (char)(no + i);
	}
}

void init()
{
	init_string_array(glo_vars, "g_ar_");
	init_string_array(global_arrays, "g_");
	init_string_array(local_vars, "ar_");
	init_string_array(local_arrays, "");
	init_string_array(funcnames, "foo", '0');
	init_string_array(parameters, "para_");
}

int get_random_num(int range, int lower = 0)
{
    return rand() % range + lower;
}

bool get_random_bool()
{
    return rand() % 2;
}

template<class T,int N>
T get_random_ele(T (&ia)[N])
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
	int a = get_random_num(IMMED_RANGE, IMMED_MIN);
    OUTPUT(a);
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
	string array = get_arrayname();
	int index = get_index();
	OUTPUT(array << "[" << index << "]")
}

void print_global_var()
{
	string var = get_random_ele(glo_vars);
    OUTPUT(var)
}

void print_local_var()
{
	string var = get_random_ele(local_vars);
    OUTPUT(var)
}

void print_para_var()
{
	string var = get_random_ele(parameters);
    OUTPUT(var)
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
    /*
    rgetter.put(print_array, to_use ? 30 : 60);
    rgetter.put(print_var, to_use ? 30 : 40);
    rgetter.put(print_immed, to_use ? 15 : 0);
    rgetter.put(print_expression, to_use ? 15 : 0);
    */
    rgetter.put(print_array, to_use ? 0 : 0);
    rgetter.put(print_var, to_use ? 70 : 100);
    rgetter.put(print_immed, to_use ? 15 : 0);
    rgetter.put(print_expression, to_use ? 15 : 0);
    void (*func)() = rgetter.get();
    (*func)();
}

void print_cal_op()
{
	string op = get_random_ele(cal_ops);
    OUTPUT(op);
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

void print_parameters()
{
	OUTPUT("(")
	print_expression();
	for (int i = 0; i < PARA_COUNT; i++)
	{
		OUTPUT(", ")
		print_expression();
	}
	OUTPUT(")")
}

void print_return()
{
	OUTPUT("return ")
	print_expression();
	OUTPUT(";" << endl)
}

void print_print_string(string str)
{
	ftxt << "printf(\"" << str << "\");" << endl;
	fcpp << "cout << \"" << str << "\";" << endl;
}

int print_count = 0;

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
    ftxt << "printf(\" \",";
    fcpp << "cout << \" \" << ";
    print_expression();
    ftxt << ")";
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
    	int num = get_random_num(VAR_RANGE, VAR_MIN);
        OUTPUT(ar[i] << " = " << num << ";" << endl)
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
        	int num = get_random_num(VAR_RANGE, VAR_MIN);
            OUTPUT(ar[i] << "[" << j << "] = " << num << ";" << endl)
        }
    }
}

void print_call(string funcname)
{
	OUTPUT(funcname << "(")
	print_immed();
	OUTPUT(", ");
	print_immed();
	OUTPUT(");" << endl);
}

template <int N>
void print_var_results(string (&ar)[N])
{
	for (int i = 0; i < N; i++)
	{
		ftxt << "printf(\" \", " << ar[i] << ");" << endl;
		fcpp << "cout << \" \" << " << ar[i] << ";" << endl;
	}
}

template <int N>
void print_array_results(string (&ar)[N])
{
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < ARRAY_LEN; j++)
		{
			ftxt << "printf(\" \", " << ar[i] << "[" << j << "]);" << endl;
			fcpp << "cout << \" \" << " << ar[i] << "[" << j << "];" << endl;
		}
	}
}

void print_println()
{
	ftxt << "printf(\"\\n\");" << endl;
	fcpp << "cout << \"\\n\";" << endl;
}

void print_print_all()
{
	print_print_string("\\nglo_vars:");
	print_var_results(glo_vars);
	print_println();
	print_print_string("global_arrays:");
	print_array_results(global_arrays);
	print_println();
	print_print_string("local_vars:");
	print_var_results(local_vars);
	print_println();
	print_print_string("local_arrays:");
	print_array_results(local_arrays);
	print_println();
}

void print_function(string funcname)
{
    OUTPUT("int " << funcname)
    int len = sizeof(parameters) / sizeof(parameters[0]);
    if (len != 0)
    {
        OUTPUT("(int " << parameters[0]);
        for (int i = 1; i < len; i++)
        {
            OUTPUT(", int " << parameters[i]);
        }
        OUTPUT(")" << endl << "{" << endl);
    }
    print_declare_vars(local_vars);
    print_declare_arrays(local_arrays);
    print_init_vars(local_vars);
    print_init_arrays(local_arrays);
    print_instructors(FUNC_INS_COUNT);
    print_print_all();
    print_return();
    OUTPUT("}");
}

void print_main()
{
	ftxt << "void ";
	fcpp << "int ";
	OUTPUT("main()" << endl << "{" << endl)
	print_init_vars(glo_vars);
	print_init_arrays(global_arrays);
	//OUTPUT(funcnames[0] << "(" << get_random_num(PARA_RANGE, PARA_MIN) << ", " << get_random_num(PARA_RANGE, PARA_MIN) << ");" << endl)
	print_call(funcnames[0]);
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
	fcpp << "#include<iostream>\nusing namespace std;\n";
    print_declare_vars(glo_vars);
    print_declare_arrays(global_arrays);
    OUTPUT(endl)
	print_function(funcnames[0]);
	OUTPUT(endl)
	print_main();
}

string creator_main()
{
	srand((unsigned)time(NULL));
	for (int i = 0; i < 1; i++)
	{
		stringstream ss_txt, ss_cpp;
		ss_txt << "prog_" << i << ".txt";
		ss_cpp << "prog_" << i << ".cpp";
		ftxt.open(ss_txt.str().c_str());
		fcpp.open(ss_cpp.str().c_str());

		init();
		print_prog();

		ftxt.close();
		fcpp.close();
	}
	return "prog_0.txt";
}

