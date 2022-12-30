/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.3 Standard
Automatic Program Generator
� Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 2/26/2014
Author  : WWW.PARANDCO.COM
Company : PARAND
Comments: 


Chip type               : ATmega32A
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 512
*****************************************************/

#include <mega32a.h>

#include <delay.h>

#define ADC_VREF_TYPE 0x40

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return ADCW;
}

// Declare your global variables here

void main(void)
{ int m  ;
int l ;
int n;
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=Out Func1=Out Func0=Out 
// State7=T State6=T State5=T State4=T State3=T State2=0 State1=0 State0=0 
PORTB=0x00;
DDRB=0x07;

// Port C initialization
// Func7=In Func6=In Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=T State6=T State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTC=0x00;
DDRC=0x3F;

// Port D initialization
// Func7=In Func6=In Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=T State6=T State5=0 State4=0 State3=0 State2=0 State1=0 State0=0 
PORTD=0x00;
DDRD=0x3F;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;

// USART initialization
// USART disabled
UCSRB=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC Clock frequency: 1000.000 kHz
// ADC Voltage Reference: AVCC pin
ADMUX=ADC_VREF_TYPE & 0xff;
ADCSRA=0x83;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;

while (1)
      {
      // Place your code here
       m=read_adc(0);
l=read_adc(2);
n=read_adc(3);
PORTD.1=1  ;
PORTD.4=1 ;
PORTC.1=1;
PORTC.4=1;
if (n>500)                                                                                        
{PORTC.2=0;
PORTC.0=1;
PORTC.3=0;
PORTC.5=1;};
if (n<500)
{
PORTC.2=1;
PORTC.0=0;
PORTC.3=0;
PORTC.5=1;};
if(l>500)
{PORTC.2=0;
PORTC.0=0;
PORTC.3=0;
PORTC.5=0;
PORTD.0=0 ;
PORTD.2=1;
delay_ms(3000);
PORTD.0=1 ;
PORTD.2=0;
delay_ms(3000);
PORTD.0=0;
PORTD.2=0 ;
PORTC.2=1;
PORTC.0=0;
PORTC.3=0;
PORTC.5=1;
};
if (n>500)
{PORTC.2=0;
PORTC.0=0;
PORTC.3=0;
PORTC.5=0;
PORTD.0=0 ;
PORTD.2=1;
delay_ms(3000);
PORTD.0=1 ;
PORTD.2=0;
delay_ms(3000);
PORTD.0=0;
PORTD.2=0 ;
PORTC.2=1;
PORTC.0=0;
PORTC.3=0;
PORTC.5=1;
};m=read_adc(0);
l=read_adc(2);
n=read_adc(3);
PORTD.1=1  ;
PORTD.4=1 ;
PORTC.1=1;
PORTC.4=1;
if (n>500)                                                                                        
{PORTC.2=0;
PORTC.0=1;
PORTC.3=0;
PORTC.5=1;};
if (n<500)
{
PORTC.2=1;
PORTC.0=0;
PORTC.3=0;
PORTC.5=1;};
if(l>500)
{PORTC.2=0;
PORTC.0=0;
PORTC.3=0;
PORTC.5=0;
PORTD.0=0 ;
PORTD.2=1;
delay_ms(3000);
PORTD.0=1 ;
PORTD.2=0;
delay_ms(3000);
PORTD.0=0;
PORTD.2=0 ;
PORTC.2=1;
PORTC.0=0;
PORTC.3=0;
PORTC.5=1;
};
if (n>500)
{PORTC.2=0;
PORTC.0=0;
PORTC.3=0;
PORTC.5=0;
PORTD.0=0 ;
PORTD.2=1;
delay_ms(3000);
PORTD.0=1 ;
PORTD.2=0;
delay_ms(3000);
PORTD.0=0;
PORTD.2=0 ;
PORTC.2=1;
PORTC.0=0;
PORTC.3=0;
PORTC.5=1;
};m=read_adc(0);
l=read_adc(2);
n=read_adc(3);
PORTD.1=1  ;
PORTD.4=1 ;
PORTC.1=1;
PORTC.4=1;
if (n>500)                                                                                        
{PORTC.2=0;
PORTC.0=1;
PORTC.3=0;
PORTC.5=1;};
if (n<500)
{
PORTC.2=1;
PORTC.0=0;
PORTC.3=0;
PORTC.5=1;};
if(l>500)
{PORTC.2=0;
PORTC.0=0;
PORTC.3=0;
PORTC.5=0;
PORTD.0=0 ;
PORTD.2=1;
delay_ms(3000);
PORTD.0=1 ;
PORTD.2=0;
delay_ms(3000);
PORTD.0=0;
PORTD.2=0 ;
PORTC.2=1;
PORTC.0=0;
PORTC.3=0;
PORTC.5=1;
};
if (n>500)
{PORTC.2=0;
PORTC.0=0;
PORTC.3=0;
PORTC.5=0;
PORTD.0=0 ;
PORTD.2=1;
delay_ms(3000);
PORTD.0=1 ;
PORTD.2=0;
delay_ms(3000);
PORTD.0=0;
PORTD.2=0 ;
PORTC.2=1;
PORTC.0=0;
PORTC.3=0;
PORTC.5=1;
};
      }
}
