/*
 * lcd.c
 *
 * Created: 25/09/2019 9:02:47 SA
 * Author: quang van
 */
#include <mega128.h>
#include <alcd.h>
#include <io.h>
#include <delay.h>
#include <string.h>
#include <stdio.h>
unsigned char i;
//char chuoi[16] ="HELLO WORLD    ";
void main(void)
{
DDRD.2=0x00;
PORTD.2=0xff;
DDRD.3=0x00;
PORTD.3=0xff;
DDRD.4=0x00;
PORTD.4=0xff;
DDRD.5=0x00;
PORTD.5=0xff;
lcd_init(16);
while (1)
{ 
    
    for(i=0;i<15;i++)
    {        
        lcd_clear();
        lcd_gotoxy(i,0);
        lcd_putsf("HELLO WORLD    ");
        delay_ms(200);
    }
    for(i=0;i<15;i++)
    {        
        lcd_clear();
        lcd_gotoxy(i,1);
        lcd_putsf("HELLO WORLD    ");
        delay_ms(200);
    }
    for(i=15;i>0;i--)
    {        
        lcd_clear();
        lcd_gotoxy(i,1);
        lcd_putsf("HELLO WORLD    ");
        delay_ms(200);
    }
    for(i=15;i>0;i--)
    {        
        lcd_clear();
        lcd_gotoxy(i,0);
        lcd_putsf("HELLO WORLD    ");
        delay_ms(200);
    } 
}
}

