#include<iostream>
using namespace std;
int g_ar_a;
int g_ar_b;
int g_ar_c;
int g_a[2];
int g_b[2];

int foo0(int para_a, int para_b, int para_c, int para_d, int para_e)
{
int ar_a;
int ar_b;
int ar_c;
int a[2];
int b[2];
ar_a = -1;
ar_b = 0;
ar_c = 4;
a[0] = 3;
a[1] = -4;
b[0] = 4;
b[1] = -1;

{
g_b[0] = (a[1] * a[1] - -4 * 0);
if ((4) == (ar_c + g_b[0]))
{
a[1] = (ar_a * ar_b);
}
else
{
b[1] = (ar_c);
}
g_a[1] = (g_ar_b);
a[1] = (-3);
ar_b = (g_ar_a * 4 - 1);
b[1] = ((ar_a + g_a[1] + ((b[1]) + ar_b + ((g_b[1])) + -4 + (b[1] + 1))));
b[0] = (a[0] - g_b[1]);
cout << " " << (g_ar_c * -5 * -1 - ar_a);
ar_a = (((g_ar_b - g_ar_b - ((g_ar_c))) * -4));
ar_c = (-3);
g_ar_b = (1);
a[1] = (3);
if ((3 + 4 * b[1] - (ar_b + para_d) * -2) <= (4 * a[0] * g_a[0] * (0) + a[1] * a[0] * ((a[0])) * g_a[0] + -3))
{
g_b[1] = (g_a[1] + ar_b);
}
else
{
if ((a[1]) < (g_b[0]))
{
cout << " " << (b[1] + -2);
}
else
{
ar_c = (g_b[0] - g_ar_b + g_a[1]);
}
}
if ((ar_a + ar_a) < (g_ar_b))
{
b[0] = (-2);
}
else
{
cout << " " << (g_a[1]);
}
if ((ar_a) < (-4 + -3 + 3))
{
g_a[1] = (2);
}
else
{
b[0] = (4 + -5 + ar_a);
}
ar_c = ((para_b) * a[0]);
ar_b = (2);
if ((b[1]) > (b[1]))
{
if ((g_ar_c - 1 * g_ar_a) < (ar_b))
{
b[1] = (-5);
}
else
{
cout << " " << (para_a);
}
}
else
{
a[1] = (ar_c);
}
a[1] = (a[1] * 0 - ar_a + -4 - 0);
g_ar_a = (ar_a - -1 * ar_b);
g_b[1] = (1 * para_d);
cout << " " << (-1 * g_a[1]);
if ((g_ar_a - 1) != (-4))
{
b[1] = (g_b[1] + g_ar_b * ar_c);
}
else
{
g_a[1] = (b[1] + -4 * g_ar_a);
}
g_b[0] = (g_ar_a);
a[1] = (0 + g_ar_b + ar_b - -4);
g_ar_b = ((a[1]) * ((ar_a)) - g_a[0] + b[0] + 4 + a[1] * ar_a);
a[0] = (b[0] - g_a[0]);
if ((para_c - 0 - (2)) < (g_a[1] * a[1] * ar_a * -2 - -2 - (((ar_a)) * g_a[0] + g_b[0] * (g_a[1] * -5))))
{
g_b[0] = (-1 * 1 + a[1]);
}
else
{
ar_c = (g_a[1] + 0);
}
cout << " " << (para_d * para_b - ((2 + g_b[1] - para_e)) + (a[0]));
a[0] = (b[1]);
}
cout << "\nglo_vars:";
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
return (ar_b);
}
int main()
{
g_ar_a = -3;
g_ar_b = 4;
g_ar_c = 2;
g_a[0] = -5;
g_a[1] = -5;
g_b[0] = -4;
g_b[1] = -5;
foo0(foo0(3, -1, -3, -1, 2), 1, 3, 1, -3);
}