echo Agora montando, compilando, e juntando seu kernel:
nasm -f elf32 -o start.o start.asm

			gcc -Wall -O -fstrength-reduce -fomit-frame-pointer             
            -finline-functions -nostdinc -fno-builtin -fno-pie 
            -I./include -c -m32                                
            -o main.o main.c

			gcc -Wall -O -fstrength-reduce -fomit-frame-pointer             
            -finline-functions -nostdinc -fno-builtin -fno-pie 
            -I./include -c -m32                                
            -o scrn.o scrn.c

			gcc -Wall -O -fstrength-reduce -fomit-frame-pointer             
            -finline-functions -nostdinc -fno-builtin -fno-pie 
            -I./include -c -m32                                
            -o gdt.o gdt.c
             
            gcc -Wall -O -fstrength-reduce -fomit-frame-pointer             
            -finline-functions -nostdinc -fno-builtin -fno-pie 
            -I./include -c -m32                                
            -o idt.o idt.c

ld -m elf_i386 -T link.ld -o kernel.bin start.o 
echo Feito!
