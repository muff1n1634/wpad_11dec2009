#ifndef __STDC_STRING_H__
#define __STDC_STRING_H__

#include <__internal/__size_t.h>
#include <__internal/__NULL.h>

extern void *memcpy(void * restrict s1, const void * restrict s2, size_t n);

extern int memcmp(const void *s1, const void *s2, size_t n);

extern void *memset(void *s, int c, size_t n);

#endif // __STDC_STRING_H__
