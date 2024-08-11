#ifndef __STRING_H
#define __STRING_H

#include <__size_t.h>
#include <__NULL.h>

void *memcpy(void * __restrict s1, const void * __restrict s2, size_t n);
int memcmp(const void *s1, const void *s2, size_t n);
void *memset(void *s, int c, size_t n);

#endif // __STRING_H
