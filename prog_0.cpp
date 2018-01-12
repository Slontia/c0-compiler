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
ar_a = -2;
ar_b = -5;
ar_c = 0;
a[0] = 3;
a[1] = 3;
b[0] = 0;
b[1] = -3;

{
para_e = (ar_c);
if ((ar_c) <= ((g_ar_a) * (ar_a + (ar_b + g_a[0])) * b[1]))
{
a[0] = (b[1]);
}
else
{
g_a[0] = ((4 + g_b[0] + g_a[1] * 0) - (3 + g_b[1]));
}
g_a[0] = (((-3 * -2 * g_ar_b) - 0));
ar_c = (g_b[0] * 4 - g_b[1] + ar_c * (a[1] + 2) * ar_c * para_d * g_a[1]);
if ((-5) >= (a[1]))
{
para_d = (g_ar_b);
}
else
{
g_a[1] = (b[1] + para_c - (0) - (ar_a * (g_b[0]) * (g_b[0] * -1)));
}
ar_b = (g_a[0]);
ar_b = (g_b[1] - -1 + 2);
if ((g_ar_a) == (2 * g_ar_a))
{
cout << " " << (ar_b);
}
else
{
b[1] = ((b[1]) + g_b[1] * g_b[1] - g_a[0]);
}
g_ar_b = ((ar_c) + (g_a[1] * g_a[1]));
g_a[0] = ((g_b[0]));
b[1] = (ar_a);
g_a[1] = (g_ar_a + g_ar_a);
g_ar_b = ((1) + -2);
b[0] = (a[0] - (2));
g_a[1] = (a[0]);
para_a = (ar_b * ar_c + ar_c);
if ((b[1]) < (-2))
{
if (((ar_c - (g_ar_b) - 3 + g_a[1] * -4)) < (-3 * (g_a[1] - g_a[1] + b[1] + a[0])))
{
b[0] = (ar_b);
}
else
{
ar_a = ((-3 + 2 * a[0] + -3 + -4) - (b[1] + a[0] * ar_a + 4));
}
}
else
{
if (((ar_a) - g_b[0] + -1) < (g_b[0] + -3))
{
g_ar_c = (ar_c * -3);
}
else
{
if ((b[0] - g_b[0] * -1) != ((1 * (para_b)) + ar_b))
{
g_ar_b = (g_ar_a);
}
else
{
b[1] = (ar_a);
}
}
}
g_b[1] = (ar_a - g_b[0]);
g_ar_b = ((a[1]));
g_b[1] = (g_ar_c);
b[1] = (g_a[0]);
cout <<endl << ar_a << endl;
ar_a = (-1 - (ar_b * g_b[1] + para_e - a[1]));
cout <<endl << ar_a << endl;
g_a[1] = ((g_b[0] + -5 * g_b[1] - g_b[1]));
g_a[1] = (g_b[0] * g_ar_c);
b[1] = (b[1] + (0 * para_e - (0) * (-2 - a[1] * 0 + g_a[0])));
g_b[0] = (g_b[0] * 0 + ar_b);
g_b[0] = (b[0] - b[1] + g_b[1]);
g_b[1] = (para_e * (a[0] * g_a[1]) * ar_c);
g_b[1] = (-1);
para_a = (ar_b);
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
return (g_ar_b);
}
int main()
{
g_ar_a = -3;
g_ar_b = 1;
g_ar_c = -3;
g_a[0] = -3;
g_a[1] = 4;
g_b[0] = -3;
g_b[1] = -4;
foo0(foo0(-3, 4, 2, 1, -2), -2, -5, -4, 2);
}
