CC_OPTIONS := -Wall -O -fstrength-reduce -fomit-frame-pointer \
              -finline-functions -nostdinc -fno-builtin -fno-pie \
              -I./include -c -m32

OUTPUT = kernel.bin

build:
	@echo 'Montando, compilando, e juntando o kernel'
	
	@echo 'Compilando start.asm ...'
	@# Não deve compilar com "-f aout" pois dá problema no
	@# momento da ligação, deve-se compilar tudo no mesmo
	@# formato: elf32
	nasm -f elf32 -o start.o arch/x86/start.asm
	
	@echo 'Compilando main.c ...'
	gcc $(CC_OPTIONS) -o main.o kernel/main.c
	
	@echo 'Compilando scrn.c ...'
	gcc $(CC_OPTIONS) -o scrn.o drivers/scrn.c
	
	@echo 'Compilando gdt.c ...'
	gcc $(CC_OPTIONS) -o gdt.o arch/x86/gdt.c
	
	@echo 'Compilando idt.c ...'
	gcc $(CC_OPTIONS) -o idt.o arch/x86/idt.c
	
	@echo 'Compilando isrs.c ...'
	gcc $(CC_OPTIONS) -o isrs.o arch/x86/isrs.c
	
	@echo 'Compilando irq.c ...'
	gcc $(CC_OPTIONS) -o irq.o arch/x86/irq.c
	
	@echo 'Compilando timer.c ...'
	gcc $(CC_OPTIONS) -o timer.o drivers/timer.c
	
	@echo 'Compilando kb.c ...'
	gcc $(CC_OPTIONS) -o kb.o drivers/kb.c
	
	@echo 'Unindo os arquivos...'
	ld -m elf_i386 -T scripts/link.ld -o $(OUTPUT) start.o main.o scrn.o gdt.o idt.o isrs.o irq.o timer.o kb.o
	
	@#A medida que for seguindo o tutorial, vá colocando os demais arquivos na linha acima:
	@#start.o scrn.o gdt.o idt.o isrs.o irq.o timer.o kb.o cmds.o
	@echo 'Feito!'
