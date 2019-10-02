/*
 * su dung tung button.c
 *
 * Created: 19/09/2019 10:31:29 CH
 * Author: quang van
 */

#include <mega128.h>
#include <delay.h>
#include <io.h>
unsigned char temp;
void main(void)
{
DDRE.5=0xff;
DDRD.2=0x00;
PORTD.2=0xff;
DDRD.3=0x00;
PORTD.3=0xff;
DDRD.4=0x00;
PORTD.4=0xff;
DDRD.5=0x00;
PORTD.5=0xff;
PORTE.5=1;
//count=0;
while (1)
{
    if(!PIND.3)
    {                    
        PORTE.5=0;
    }
    if(!PIND.5)             
    {
        PORTE.5=1;
    }  
    if(!PIND.2)
    {                   
        temp=0;
        while(1)
        {
            PORTE=temp;
            delay_ms(10);
            temp++;
            if((!PIND.3)||(!PIND.4)||(!PIND.5))
            {
                break;
            }
        }
    }    
    if(!PIND.4)
    {                   
        temp=0;
        while(1)
        {
            PORTE=temp;
            delay_ms(1);
            temp++;
            if((!PIND.3)||(!PIND.2)||(!PIND.5))
            {
                break;
            }
        }
    }                
}
}