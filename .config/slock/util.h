/* macros */
#define LEN(a)			(sizeof(a) / sizeof(a)[0])

#undef explicit_bzero
void explicit_bzero(void *, size_t);
