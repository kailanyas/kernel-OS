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

; Está é uma definição do sua seção de BSS.
SECTION .bss
    resb 8192               ; Este reserva 8KBytes da memória aqui
_sys_stack:
