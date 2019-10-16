/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 02/10/2019
Author  : 
Company : 
Comments: 


Chip type               : ATmega128
Program type            : Application
AVR Core Clock frequency: 8,000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 1024
*******************************************************/

#include <mega128.h>
#include <delay.h>
#in

// Declare your global variables here
void main(void)
{
DDRB.5=0xFF;
TCCR1A |=1<<WGM11 | 1<<COM1A1 | 1<<COM1a0;
TCCR1B |=1<<WGM12 | 1<<WGM13 | 1<<CS10;
ICR1=19999;

while (1)
      {
      // Place your code here
      OCR1A=ICR1-800;
      delay_ms(100);
      OCR1A=TCR1-2200;
      delay_ms(100);
      }
}
