#include <system.h>

void __stack_chk_fail() {}

unsigned char *memcpy(unsigned char *dest, const unsigned char *src, int count)
{
    for(int i = 0; i < count; i++){
        dest[i] = src[i];
    }

    return dest;
}


unsigned char *memset(unsigned char *dest, unsigned char val, int count)
{
    for(int i = 0; i < count; i++){
        dest[i] = val;
    }

    return dest;
}

unsigned short *memsetw(unsigned short *dest, unsigned short val, int count)
{
    for(int i = 0; i < count; i++){
        dest[i] = val;
    }

    return dest;
}

int strlen(const char *str)
{
    int length = 0;

    while(str[length] != '\0'){
        length++;
    }

    return length;
}

unsigned char inportb (unsigned short _port)
{
    unsigned char rv;
    __asm__ __volatile__ ("inb %1, %0" : "=a" (rv) : "dN" (_port));
    return rv;
}


void outportb (unsigned short _port, unsigned char _data)
{
    __asm__ __volatile__ ("outb %1, %0" : : "dN" (_port), "a" (_data));
}

/* Este é uma função main() muito simples. Todo que faz é um
*  laço infinito. Este vai ser usado para nosso laço 'ocioso' */
int main()
{
    for (;;);

    return 0;
}
