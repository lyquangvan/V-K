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
unsigned char i,a,b;
//char chuoi[16] ="HELLO WORLD    ";
void main(void)
{
char chuoi[16] ="HELLO WORLD    ";
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
    lcd_clear();
    if(!PIND.3)
    {
        while(1)
        {            
            a=chuoi[0];
            for(i=0;i<15;i++)
            {   
            lcd_gotoxy(i,0);
            lcd_putchar(chuoi[i]);
            chuoi[i]=chuoi[i+1];
            delay_ms(25);      
            }
            chuoi[14]=a;        
            if(!PIND.5)
            {   
                lcd_clear();
                break;
            }
        } 
    }
    if(!PIND.5)
    {
        while(1)
        {      
            a=chuoi[14];
            for(i=14;i>=1;i--)
            {   
                lcd_gotoxy(i,1);
                lcd_putchar(chuoi[i]);
                chuoi[i]=chuoi[i-1];
                delay_ms(25);     
            }                 
            chuoi[0]=a;       
            if(!PIND.3)
            {         
                lcd_clear();
                break;   
            }
        } 
    }
}
}

