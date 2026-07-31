#pragma once
#include <stddef.h>

extern "C" {
size_t strlen(const char* str);
void*  memset(void* dest, int c, size_t n);
void*  memcpy(void* dest, const void* src, size_t n);
void*  memmove(void* dest, const void* src, size_t n);
}