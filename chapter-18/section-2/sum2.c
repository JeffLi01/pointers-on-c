#include <stdarg.h>

int sum2(unsigned int n, va_list vl)
{
    unsigned int index;
    int sum = 0;

    for (index = 0; index < n; index++) {
        sum += va_arg(vl, int);;
    }
    return sum;
}
