#include <system.h>

/* Este guardará a trilha de quanto tiques que o sistema
*  tem sido corrido */
int timer_ticks = 0;

/* Trata o temporizador. Neste caso, é muito simples: nós
*  incrementamos a variável 'timer_ticks' sempre que o temporizador
*  dispara. Por padrão, o temporizador dispara 18.222 tempos
*  por segundo. Como 18.222Hz? Algum engenheiro na IBM deve
*  ter fumado alguma coisa simplesmente */
void timer_handler(struct regs *r)
{
    /* Incrementa nosso 'tick count' */
    timer_ticks++;

    /* Todo 18ª vez (aproximadamente 1 segundo), nós vamos
    *  mostrar uma mensagem na tela */
    if (timer_ticks % 18 == 0)
    {
    	move_cursor_clock();
        return_to_cursor();
    }
}

/* Atribui o relógio do sistema instalando o temporizador
*  no IRQ0 */
void timer_install()
{
    /* Instala 'timer_handler' no IRQ0 */
    irq_install_handler(0, timer_handler);
}

/* Este ficar continuamente no laço até o tempo dado
*  ser alcançado */
void timer_wait(int ticks)
{
    unsigned long eticks;

    eticks = timer_ticks + ticks;
    while(timer_ticks < eticks);
}
