#define __SFR_OFFSET 0x00
#include <avr/io.h>

.global program
.global asmloop

program:

    ldi  r18, 0xC0      ;Loads C0h on auxiliary registrator
    out  DDRD, r18      ;Output PD7 and PD6
    ldi  r18, 0x30      ;Loads 30h on auxiliary registrator
    out  PORTD, r18     ;Sets PD4 & PD5 as intern  pullups
    ret                 ;Returns subroutine

asmloop:
  
    call read_key       ;Calling subroutine
    
    rjmp asmloop        ;Infinite loop

read_key:

    sbis  PIND,5        ;Is bit5 PIND low?
    rjmp  led1_on       ;Yes, go to led1_on
    cbi   PORTD,7       ;Clear PD7
    sbis  PIND,4        ;Is bit4 PIND low?
    rjmp  led2_on       ;Yes, go to led2_on
    cbi   PORTD,6       ;Clear PD6
    ret                 ;Return

led1_on:

    sbi  PORTD,7        ;Sets PD7
    ret                 ;Return

led2_on:

    sbi  PORTD,6        ;Sets PD6
    ret                 ;Return