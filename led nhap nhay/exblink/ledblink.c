/*
 * ledblink.c
 *
 * Created: 11/09/2019 4:46:36 CH
 * Author: quang van
 */

#include <mega128.h>
#include <delay.h>

unsigned char temp;
void main(void)
{
DDRE.5=1;
temp=0;
while (1)
      {
      PORTE=temp;
      delay_ms(10);
      temp++;
      }
}

    

