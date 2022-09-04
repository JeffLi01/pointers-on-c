#include <stdarg.h>

int sum2(unsigned int n, va_list vl);

int sum1(unsigned int n, ...)
{
    int sum;
    va_list vl;
    va_start(vl, n);
    sum = sum2(n, vl);
    va_end(vl);
    return sum;
}
