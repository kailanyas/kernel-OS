#ifndef __SYSTEM_H
#define __SYSTEM_H

// main.c
extern unsigned char *memcpy(unsigned char *dest, const unsigned char *src, int count);
extern unsigned char *memset(unsigned char *dest, unsigned char val, int count);
extern unsigned short *memsetw(unsigned short *dest, unsigned short val, int count);
extern int strlen(const char *str);
extern unsigned char inportb (unsigned short _port);
extern void outportb (unsigned short _port, unsigned char _data);

// scrn.c
extern void cls();
extern void putch(unsigned char c);
extern void puts(unsigned char *str);
extern void settextcolor(unsigned char forecolor, unsigned char backcolor);
extern void init_video();

// gdt.c
extern void gdt_set_gate(int num, unsigned long base, unsigned long limit, unsigned char access, unsigned char gran);
void gdt_install();

// idt.c
extern void idt_set_gate(unsigned char num, unsigned long base, unsigned short sel, unsigned char flags);
extern void idt_install();

// isrs.c
struct regs
{
    unsigned int ds, es, fs, gs;                          /* últimos segmentos puxados */
    unsigned int edi, esi, ebp, esp, ebx, edx, ecx, eax;  /* puxado por 'pusha' */
    unsigned int int_no, err_code;                        /* nosso 'push byte #' e ecodes (códigos de erro) faz isto */
    unsigned int eip, cs, eflags, useresp, ss;            /* puxados pelo processador automaticamente */
};
extern void isrs_install();
extern void fault_handler(struct regs *r);
extern void isr0();
extern void isr1();
extern void isr2();
extern void isr3();
extern void isr4();
extern void isr5();
extern void isr6();
extern void isr7();
extern void isr8();
extern void isr9();
extern void isr10();
extern void isr11();
extern void isr12();
extern void isr13();
extern void isr14();
extern void isr15();
extern void isr16();
extern void isr17();
extern void isr18();
extern void isr19();
extern void isr20();
extern void isr21();
extern void isr22();
extern void isr23();
extern void isr24();
extern void isr25();
extern void isr26();
extern void isr27();
extern void isr28();
extern void isr29();
extern void isr30();
extern void isr31();

// irq.c
void irq_install_handler(int irq, void (*handler)(struct regs *r));
void irq_uninstall_handler(int irq);
void irq_remap(void);
void irq_install();
void irq_handler(struct regs *r);
extern void irq0();
extern void irq1();
extern void irq2();
extern void irq3();
extern void irq4();
extern void irq5();
extern void irq6();
extern void irq7();
extern void irq8();
extern void irq9();
extern void irq10();
extern void irq11();
extern void irq12();
extern void irq13();
extern void irq14();
extern void irq15();

// timer.c
void timer_handler(struct regs *r);
void timer_install();
void timer_wait(int ticks);

#endif
