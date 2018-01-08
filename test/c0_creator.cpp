#include <iostream>
#include <map>
#include <vector>
#include <stdlib.h>
#include <time.h>
#include <fstream>
#include <sstream>
#define ARRAY_LEN 2
#define MAX_POINT 100
using namespace std;

string global_vars[] = {"glo_a", "glo_b", "glo_c"};
string global_arrays[] = {"glo_array_a", "glo_array_b"};
string local_vars[] = {"a", "b", "c", "d"};
string local_arrays[] = {"array_a", "array_b"};
string cal_ops[] = {"+", "-", "*", "/"};
string comp_ops[] = {"<", ">", "<=", ">=", "==", "!="};

ofstream fout;

int get_random_num(int range)
{
    return rand() % range;
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
		int rand_result = get_random_num(MAX_POINT) + 1;
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
    cout << rand() % 10;
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
	cout << get_arrayname() << "[" << get_index() << "]";
}

void print_var()
{
    bool is_global = get_random_bool();
    cout << get_random_ele(is_global ? global_vars : local_vars);
}

void print_expression();
void print_item(bool with_para = true)
{
    typedef void(*handle)();
    RandomGetter<handle> rgetter;
    rgetter.put(print_array, with_para ? 30 : 60);
    rgetter.put(print_var, with_para ? 30 : 40);
    rgetter.put(print_immed, with_para ? 15 : 0);
    rgetter.put(print_expression, with_para ? 15 : 0);
    void (*func)() = rgetter.get();
    if (func != NULL)
    {
        (*func)();
    }
}

void print_cal_op()
{
    cout << get_random_ele(cal_ops);
}

void print_expression()
{
    cout << "(";
    print_item();
    while (get_random_num(100) < 70)
    {
        cout << " ";
        print_cal_op();
        cout << " ";
        print_item(true);
    }
    cout << ")";
}

void print_assign()
{
    print_item(false);
    cout << " = ";
    print_expression();
    cout << ";" << endl;
}

void print_comp_op()
{
    cout << get_random_ele(comp_ops);
}

void print_conf()
{
    print_expression();
    cout << " ";
    print_comp_op();
    cout << " ";
    print_expression();
}

void print_printf()
{
    cout << "printf";
    print_expression();
    cout << ";" << endl;
}

void print_if();
void print_instructors()
{
    cout << "{" << endl;
    while (get_random_num(100) < 90)
    {
        typedef void(*handle)();
        RandomGetter<handle> rgetter;
        rgetter.put(print_assign, 80);
        rgetter.put(print_if, 10);
        rgetter.put(print_printf, 10);
        (*(rgetter.get()))();
    }
    cout << "}" << endl;
}

void print_function()
{

}

void print_if()
{
    cout << "if (";
    print_conf();
    cout << ")";
    print_instructors();
}

void print_while()
{

}



void print_prog()
{
    //PrintValues(global_arrays);
	//print_array();
	print_if();
}

int main()
{
	srand((unsigned)time(NULL));
	for (int i = 0; i < 1; i++)
	{
		stringstream ss;
		ss << "prog_" << i << ".txt";
		fout.open(ss.str().c_str());
		print_prog();
		fout.close();
	}
}
