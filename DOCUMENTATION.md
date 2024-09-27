# DOCUMENTAÇÃO

Este arquivo fornece informações detalhadas sobre a estrutura do código, dependências e como executar o projeto.

## Estrutura do código

```bash
kernel-OS
│
├── /arch           # Código específico para arquitetura (ex: x86)
│   └── x86
│       ├── gdt.c       # Define segmentos de memória e seus privilégios
│       ├── idt.c       # Mapeia interrupções e exceções para suas respectivas rotinas de tratamento
│       ├── irq.c       # Lida com interrupções de hardware, como teclado e temporizador
│       ├── isrs.c      # Funções chamadas para lidar com interrupções e exceções específicas
│       └── start.asm   # Código de inicialização em Assembly, responsável por configurar o ambiente de execução antes de passar o controle para o C
│
├── /drivers        # Drivers para dispositivos de hardware
│   ├── kb.c        # Driver para teclado (keyboard)
│   ├── timer.c     # Driver para o gerenciamento do tempo
│   └── scrn.c      # Driver para gerenciamento de tela (screen)
│
├── /kernel         # Núcleo do kernel
│   └── main.c      # Função principal e inicialização do kernel
│
├── /include        # Headers e definições compartilhadas
│   └── *.h         # Arquivos .h 
│
├── /scripts        # Scripts e arquivos de configuração       
│   ├── build.sh    # Script de construção 
│   └── link.ld     # Script de linkagem
│
├── makefile        # Arquivo de construção principal (substitui o build.sh)
└── README.md       # Descrição do projeto
```


## Dependências

As ferramentas essenciais para compilar e executar o kernel são:

- **NASM**: Montador para código _Assembly_, utilizado na conversão do código fonte em _Assembly_ para binário executável.

- **QEMU**: Emulador e virtualizador que permite a execução e teste do kernel em um ambiente simulado, facilitando o desenvolvimento sem a necessidade de hardware real.

- **Bison**: Gerador de analisadores sintáticos (_parser generator_) para a construção de compiladores e interpretadores.

- **Binutils**: Conjunto de ferramentas para manipulação de arquivos binários, incluindo montadores (assemblers) e linkers. Essencial para a criação e manipulação dos executáveis do kernel.

## Como executar?

Para compilar e executar o kernel, siga os passos abaixo:

1. **Instale as dependências necessárias:**
	
	```bash
	sudo apt-get install nasm qemu bison binutils

2. **Clone o repositório:**

	```bash
	git clone https://github.com/kailanyas/kernel-OS.git
	cd kernel-OS
	
3. **Compile o kernel:**

Utilize o makefile para compilar o kernel. Esse script automatiza o processo de montagem, compilação e linkagem.

	```bash
	make
	
4. **Execute o kernel:**

Após a compilação bem-sucedida, você pode iniciar o kernel em um ambiente QEMU usando o seguinte comando:

	```bash
	qemu-system-x86_64 -kernel kernel.bin


Vale ressaltar que este projeto foi realizado, testado e executado no **Linux**!
