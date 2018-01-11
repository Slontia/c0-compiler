#include<iostream>
using namespace std;
int g_ar_a;
int g_ar_b;
int g_ar_c;
int g_a[2];
int g_b[2];

int foo0(int para_a, int para_b)
{
int ar_a;
int ar_b;
int ar_c;
int a[2];
int b[2];
ar_a = 0;
ar_b = 4;
ar_c = -3;
a[0] = -5;
a[1] = 1;
b[0] = 0;
b[1] = 2;

{
ar_b = (g_ar_b);
ar_b = (ar_a);
g_ar_a = ((para_b));
cout << " " << (para_a * g_ar_a);
para_a = (-4 + ar_b);
para_b = (ar_b);
cout << " " << ((ar_c * ar_b + g_ar_b - ar_c + ar_b) * 1);
ar_c = (-1);
cout << " " << (-3);
ar_b = (g_ar_a + ar_a);
}
cout << "\nglobal_vars:";
cout << " " << g_ar_a;
cout << " " << g_ar_b;
cout << " " << g_ar_c;
cout << "\n";
cout << "global_arrays:";
cout << " " << g_a[0];
cout << " " << g_a[1];
cout << " " << g_b[0];
cout << " " << g_b[1];
cout << "\n";
cout << "local_vars:";
cout << " " << ar_a;
cout << " " << ar_b;
cout << " " << ar_c;
cout << "\n";
cout << "local_arrays:";
cout << " " << a[0];
cout << " " << a[1];
cout << " " << b[0];
cout << " " << b[1];
cout << "\n";
return (g_ar_c);
}
int main()
{
g_ar_a = 3;
g_ar_b = -1;
g_ar_c = -1;
g_a[0] = -5;
g_a[1] = 4;
g_b[0] = 1;
g_b[1] = -5;
foo0(-3, -2);
}