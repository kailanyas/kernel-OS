; Ponto de entrada do kernel. Pode-se chamar a main aqui.
[GLOBAL start]
[BITS 32]
start:
    mov esp, _sys_stack     ; Aponta a pilha para sua nova área de pilha
    jmp stublet

; Está parte TEM que ser alinhada de 4Bytes, assim resolve-se a questão usando 'ALIGN 4'
ALIGN 4
mboot:
    ; Macros multiboot para fazer umas poucas linhas mais tarde serem mais legíveis
    MULTIBOOT_PAGE_ALIGN	equ 1<<0
    MULTIBOOT_MEMORY_INFO	equ 1<<1
    MULTIBOOT_AOUT_KLUDGE	equ 1<<16
    MULTIBOOT_HEADER_MAGIC	equ 0x1BADB002
    MULTIBOOT_HEADER_FLAGS	equ MULTIBOOT_PAGE_ALIGN | MULTIBOOT_MEMORY_INFO | MULTIBOOT_AOUT_KLUDGE
    MULTIBOOT_CHECKSUM	equ -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)
    EXTERN code, bss, end

    ; Este é o cabeçalho do Multiboot GRUB. Uma assinatura de boot
    dd MULTIBOOT_HEADER_MAGIC
    dd MULTIBOOT_HEADER_FLAGS
    dd MULTIBOOT_CHECKSUM

    ; AOUT kludge - precisa ser endereços físicos. Faça uma nota disto:
    ; O script de linker preenche os dados para uns destes!
    dd mboot
    dd code
    dd bss
    dd end
    dd start

; Este é um laço sem fim.
stublet:
    extern main
    call main
    jmp $
    
; Código para carregar a GDT
global gdt_flush     ; Permite que o codigo em C veja essa funcao
extern gp            ; Diz que '_gp' está em outro arquivo
gdt_flush:
    lgdt [gp]        ; Carrega GDT com nosso ponteiro especial '_gp'
    mov ax, 0x10      ; 0x10 é o offset na GDT para nosso segmento de dados
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    jmp 0x08:flush2   ; 0x08 é o offset para nosso segmento de código: Salto longo!
flush2:
    ret               ; Retorna para o código C!
    
; Carrega a IDT 
global idt_load
extern idtp
idt_load:
    lidt [idtp]
    ret

; Rotina para Serviço de Interrupção (ISRs)
global isr0
global isr1
global isr2
global isr3
global isr4
global isr5
global isr6
global isr7
global isr8
global isr9
global isr10
global isr11
global isr12
global isr13
global isr14
global isr15
global isr16
global isr17
global isr18
global isr19
global isr20
global isr21
global isr22
global isr23
global isr24
global isr25
global isr26
global isr27
global isr28
global isr29
global isr30
global isr31

; 0: Divide By Zero Exception
isr0:
    cli
    push byte 0    ; Uma ponta normal de ISR retira uma cópia do código de erro para guardar uma moldura de pilha uniforme
    push byte 0
    jmp isr_common_stub

; 1: Debug Exception
isr1:
    cli
    push byte 0
    push byte 1
    jmp isr_common_stub

; 2: Non Maskable Interrupt Exception
isr2:
    cli
    push byte 0
    push byte 2
    jmp isr_common_stub

; 3: Breakpoint Exception
isr3:
  cli
    push byte 0
    push byte 3
    jmp isr_common_stub

; 4: Into Detected Overflow Exception
isr4:
    cli
    push byte 0
    push byte 4
    jmp isr_common_stub

; 5: Out of Bounds Exception
isr5:
    cli
    push byte 0
    push byte 5
    jmp isr_common_stub

; 6: Invalid Opcode Exception
isr6:
    cli
    push byte 0
    push byte 6
    jmp isr_common_stub

; 7: No Coprocessor Exception
isr7:
    cli
    push byte 0
    push byte 7
    jmp isr_common_stub

; 8: Double Fault Exception (Com código de Erro!)
isr8:
    cli
    push byte 8        ; Note que nós NÃO puxamos um valor na pilha neste um! Este puxa um já! Use esta ponta para exceções este retira códigos de erro!
    jmp isr_common_stub

; 9: Coprocessor Segment Overrun Exception
isr9:
    cli
    push byte 9
    jmp isr_common_stub

; 10: Bad TSS Exception
isr10:
    cli
    push byte 10
    jmp isr_common_stub

; 11: Segment Not Present Exception
isr11:
    cli
    push byte 11
    jmp isr_common_stub

; 12: Stack Fault Exception
isr12:
    cli
    push byte 12
    jmp isr_common_stub

; 13: General Protection Fault Exception
isr13:
    cli
    push byte 13
    jmp isr_common_stub

; 14: Page Fault Exception
isr14:
    cli
    push byte 14
    jmp isr_common_stub

; 15: Unknown Interrupt Exception
isr15:
    cli
    push byte 15
    jmp isr_common_stub

; 16: Coprocessor Fault Exception
isr16:
    cli
    push byte 16
    jmp isr_common_stub

; 17: Alignment Check Exception
isr17:
    cli
    push byte 17
    jmp isr_common_stub

; 18: Machine Check Exception
isr18:
    cli
    push byte 18
    jmp isr_common_stub

; 19: Reserved Exceptions
isr19:
    cli
    push byte 19
    jmp isr_common_stub

; 20: Reserved Exceptions
isr20:
    cli
    push byte 20
    jmp isr_common_stub

; 21: Reserved Exceptions
isr21:
    cli
    push byte 21
    jmp isr_common_stub

; 22: Reserved Exceptions
isr22:
    cli
    push byte 22
    jmp isr_common_stub

; 23: Reserved Exceptions
isr23:
    cli
    push byte 23
    jmp isr_common_stub

; 24: Reserved Exceptions
isr24:
    cli
    push byte 24
    jmp isr_common_stub

; 25: Reserved Exceptions
isr25:
    cli
    push byte 25
    jmp isr_common_stub

; 26: Reserved Exceptions
isr26:
    cli
    push byte 26
    jmp isr_common_stub

; 27: Reserved Exceptions
isr27:
    cli
    push byte 27
    jmp isr_common_stub

; 28: Reserved Exceptions
isr28:
    cli
    push byte 28
    jmp isr_common_stub

; 29: Reserved Exceptions
isr29:
    cli
    push byte 29
    jmp isr_common_stub

; 30: Reserved Exceptions
isr30:
    cli
    push byte 30
    jmp isr_common_stub

; 31: Reserved Exceptions
isr31:
    cli
    push byte 31
    jmp isr_common_stub

extern fault_handler

isr_common_stub:
    pusha
    push ds
    push es
    push fs
    push gs
    mov ax, 0x10   ; Carrega o descritor de Segmento de Dados do Kernel!
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov eax, esp   ; Puxa nossa pilha
    push eax
    mov eax, fault_handler
    call eax       ; Uma chamada especial, preserva o registrador 'eip'
    pop eax
    pop gs
    pop fs
    pop es
    pop ds
    popa
    add esp, 8     ; Limpa o código de erro puxado e o número da ISR puxada
    iret
    
; Está é uma definição do sua seção de BSS.
SECTION .bss
    resb 8192               ; Este reserva 8KBytes da memória aqui
_sys_stack:
