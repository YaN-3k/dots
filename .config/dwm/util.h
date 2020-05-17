/* See LICENSE file for copyright and license details. */
#ifndef UTIL_H_
#define UTIL_H_

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX(A, B)               ((A) > (B) ? (A) : (B))
#define MIN(A, B)               ((A) < (B) ? (A) : (B))
#define BETWEEN(X, A, B)        ((A) <= (X) && (X) <= (B))

void die(const char *fmt, ...);
void *ecalloc(size_t nmemb, size_t size);

#endif
