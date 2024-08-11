#ifndef __STDC_STRING_H__
#define __STDC_STRING_H__

#include <__size_t.h>
#include <__NULL.h>

void *memcpy(void * restrict s1, const void * restrict s2, size_t n);

int memcmp(const void *s1, const void *s2, size_t n);

void *memset(void *s, int c, size_t n);

#endif // __STDC_STRING_H__
