(*
  All template definitions for IO ports, interrupt service routines, and
  such.
*)

%{#
#include "CATS/io.cats"
%}

staload "SATS/atomic.sats"

sortdef mcu = tkind

stacst atmega328p : mcu

abst@ype register(mcu, width:int) = $extype "volatile void *"

fun value {m: mcu} (
  r: register(m, 8)
): uint8 = "mac#"

macdef F_CPU = $extval([f:pos] ulint f, "F_CPU")

fun {m:mcu} PINB (): register(m, 8)


fun {m:mcu} DDRB (): register(m, 8)


fun {m:mcu} PORTB (): register(m, 8)


fun {m:mcu} PINC (): register(m, 8)


fun {m:mcu} DDRC (): register(m, 8)


fun {m:mcu} PORTC (): register(m, 8)


fun {m:mcu} PIND (): register(m, 8)


fun {m:mcu} DDRD (): register(m, 8)


fun {m:mcu} PORTD (): register(m, 8)


fun {m:mcu} TIFR0 (): register(m, 8)


fun {m:mcu} TIFR1 (): register(m, 8)


fun {m:mcu} TIFR2 (): register(m, 8)


fun {m:mcu} PCIFR (): register(m, 8)


fun {m:mcu} EIFR (): register(m, 8)


fun {m:mcu} EIMSK (): register(m, 8)


fun {m:mcu} GPIOR0 (): register(m, 8)


fun {m:mcu} EECR (): register(m, 8)


fun {m:mcu} EEDR (): register(m, 8)


fun {m:mcu} EEARL (): register(m, 8)


fun {m:mcu} EEARH (): register(m, 8)


fun {m:mcu} GTCCR (): register(m, 8)


fun {m:mcu} TCCR0A (): register(m, 8)


fun {m:mcu} TCCR0B (): register(m, 8)


fun {m:mcu} TCNT0 (): register(m, 8)


fun {m:mcu} OCR0A (): register(m, 8)


fun {m:mcu} OCR0B (): register(m, 8)


fun {m:mcu} GPIOR1 (): register(m, 8)


fun {m:mcu} GPIOR2 (): register(m, 8)


fun {m:mcu} SPCR (): register(m, 8)


fun {m:mcu} SPSR (): register(m, 8)


fun {m:mcu} SPDR (): register(m, 8)


fun {m:mcu} ACSR (): register(m, 8)


fun {m:mcu} SMCR (): register(m, 8)


fun {m:mcu} MCUSR (): register(m, 8)


fun {m:mcu} MCUCR (): register(m, 8)


fun {m:mcu} SPMCSR (): register(m, 8)


fun {m:mcu} WDTCSR (): register(m, 8)


fun {m:mcu} CLKPR (): register(m, 8)


fun {m:mcu} PRR (): register(m, 8)


fun {m:mcu} OSCCAL (): register(m, 8)


fun {m:mcu} PCICR (): register(m, 8)


fun {m:mcu} EICRA (): register(m, 8)


fun {m:mcu} PCMSK0 (): register(m, 8)


fun {m:mcu} PCMSK1 (): register(m, 8)


fun {m:mcu} PCMSK2 (): register(m, 8)


fun {m:mcu} TIMSK0 (): register(m, 8)


fun {m:mcu} TIMSK1 (): register(m, 8)


fun {m:mcu} TIMSK2 (): register(m, 8)


fun {m:mcu} ADCL (): register(m, 8)


fun {m:mcu} ADCH (): register(m, 8)


fun {m:mcu} ADCSRA (): register(m, 8)


fun {m:mcu} ADCSRB (): register(m, 8)


fun {m:mcu} ADMUX (): register(m, 8)


fun {m:mcu} DIDR0 (): register(m, 8)


fun {m:mcu} DIDR1 (): register(m, 8)


fun {m:mcu} TCCR1A (): register(m, 8)


fun {m:mcu} TCCR1B (): register(m, 8)


fun {m:mcu} TCCR1C (): register(m, 8)


fun {m:mcu} TCNT1L (): register(m, 8)


fun {m:mcu} TCNT1H (): register(m, 8)


fun {m:mcu} ICR1L (): register(m, 8)


fun {m:mcu} ICR1H (): register(m, 8)


fun {m:mcu} OCR1AL (): register(m, 8)


fun {m:mcu} OCR1AH (): register(m, 8)


fun {m:mcu} OCR1BL (): register(m, 8)


fun {m:mcu} OCR1BH (): register(m, 8)


fun {m:mcu} TCCR2A (): register(m, 8)


fun {m:mcu} TCCR2B (): register(m, 8)


fun {m:mcu} TCNT2 (): register(m, 8)


fun {m:mcu} OCR2A (): register(m, 8)


fun {m:mcu} OCR2B (): register(m, 8)


fun {m:mcu} ASSR (): register(m, 8)


fun {m:mcu} TWBR (): register(m, 8)


fun {m:mcu} TWSR (): register(m, 8)


fun {m:mcu} TWAR (): register(m, 8)


fun {m:mcu} TWDR (): register(m, 8)


fun {m:mcu} TWCR (): register(m, 8)

fun {m:mcu} TWAMR (): register(m, 8)

fun {m:mcu} UCSR0A (): register(m, 8)

fun {m:mcu} UCSR0B (): register(m, 8)

fun {m:mcu} UCSR0C (): register(m, 8)

fun {m:mcu} UBRR0L (): register(m, 8)

fun {m:mcu} UBRR0H (): register(m, 8)

fun {m:mcu} UDR0 (): register(m, 8)

(* ****** ****** *)

//Interrupt Service Routines

fun TIMER0_OVF_vect (pf: !atomic | (**)): void = "TIMER0_OVF_vect"

(* ****** ****** *)

//Bit manipulation routines

symintr setval

fun setval_8bit {m:mcu} (
  r: register(m, 8), value: natLt(256)
): void = "mac#avr_libats_setval_8bit"

overload setval with setval_8bit

symintr setbits

fun setbits0_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8)
): void = "mac#avr_libats_setbits0_8bit"


overload setbits with setbits0_8bit

fun setbits1_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8)
): void = "mac#avr_libats_setbits1_8bit"


overload setbits with setbits1_8bit

fun setbits2_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8)
): void = "mac#avr_libats_setbits2_8bit"


overload setbits with setbits2_8bit

fun setbits3_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8)
): void = "mac#avr_libats_setbits3_8bit"


overload setbits with setbits3_8bit

fun setbits4_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8)
): void = "mac#avr_libats_setbits4_8bit"


overload setbits with setbits4_8bit

fun setbits5_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8)
): void = "mac#avr_libats_setbits5_8bit"


overload setbits with setbits5_8bit

fun setbits6_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8)
): void = "mac#avr_libats_setbits6_8bit"


overload setbits with setbits6_8bit

fun setbits7_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8), b7: natLt(8)
): void = "mac#avr_libats_setbits7_8bit"


overload setbits with setbits7_8bit

symintr maskbits

fun maskbits0_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8)
): void = "mac#avr_libats_maskbits0_8bit"


overload maskbits with maskbits0_8bit

fun maskbits1_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8)
): void = "mac#avr_libats_maskbits1_8bit"


overload maskbits with maskbits1_8bit

fun maskbits2_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8)
): void = "mac#avr_libats_maskbits2_8bit"


overload maskbits with maskbits2_8bit

fun maskbits3_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8)
): void = "mac#avr_libats_maskbits3_8bit"


overload maskbits with maskbits3_8bit

fun maskbits4_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8)
): void = "mac#avr_libats_maskbits4_8bit"


overload maskbits with maskbits4_8bit

fun maskbits5_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8)
): void = "mac#avr_libats_maskbits5_8bit"


overload maskbits with maskbits5_8bit

fun maskbits6_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8)
): void = "mac#avr_libats_maskbits6_8bit"


overload maskbits with maskbits6_8bit

fun maskbits7_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8), b7: natLt(8)
): void = "mac#avr_libats_maskbits7_8bit"


overload maskbits with maskbits7_8bit

symintr clearbits

fun clearbits0_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8)
): void = "mac#avr_libats_clearbits0_8bit"


overload clearbits with clearbits0_8bit

fun clearbits1_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8)
): void = "mac#avr_libats_clearbits1_8bit"


overload clearbits with clearbits1_8bit

fun clearbits2_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8)
): void = "mac#avr_libats_clearbits2_8bit"


overload clearbits with clearbits2_8bit

fun clearbits3_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8)
): void = "mac#avr_libats_clearbits3_8bit"


overload clearbits with clearbits3_8bit

fun clearbits4_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8)
): void = "mac#avr_libats_clearbits4_8bit"


overload clearbits with clearbits4_8bit

fun clearbits5_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8)
): void = "mac#avr_libats_clearbits5_8bit"


overload clearbits with clearbits5_8bit

fun clearbits6_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8)
): void = "mac#avr_libats_clearbits6_8bit"


overload clearbits with clearbits6_8bit

fun clearbits7_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8), b7: natLt(8)
): void = "mac#avr_libats_clearbits7_8bit"


overload clearbits with clearbits7_8bit

symintr clear_and_setbits

fun clear_and_setbits0_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8)
): void = "mac#avr_libats_clear_and_setbits0_8bit"


overload clear_and_setbits with clear_and_setbits0_8bit

fun clear_and_setbits1_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8)
): void = "mac#avr_libats_clear_and_setbits1_8bit"


overload clear_and_setbits with clear_and_setbits1_8bit

fun clear_and_setbits2_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8)
): void = "mac#avr_libats_clear_and_setbits2_8bit"


overload clear_and_setbits with clear_and_setbits2_8bit

fun clear_and_setbits3_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8)
): void = "mac#avr_libats_clear_and_setbits3_8bit"


overload clear_and_setbits with clear_and_setbits3_8bit

fun clear_and_setbits4_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8)
): void = "mac#avr_libats_clear_and_setbits4_8bit"


overload clear_and_setbits with clear_and_setbits4_8bit

fun clear_and_setbits5_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8)
): void = "mac#avr_libats_clear_and_setbits5_8bit"


overload clear_and_setbits with clear_and_setbits5_8bit

fun clear_and_setbits6_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8)
): void = "mac#avr_libats_clear_and_setbits6_8bit"


overload clear_and_setbits with clear_and_setbits6_8bit

fun clear_and_setbits7_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8), b7: natLt(8)
): void = "mac#avr_libats_clear_and_setbits7_8bit"


overload clear_and_setbits with clear_and_setbits7_8bit

symintr flipbits

fun flipbits0_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8)
): void = "mac#avr_libats_flipbits0_8bit"


overload flipbits with flipbits0_8bit

fun flipbits1_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8)
): void = "mac#avr_libats_flipbits1_8bit"


overload flipbits with flipbits1_8bit

fun flipbits2_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8)
): void = "mac#avr_libats_flipbits2_8bit"


overload flipbits with flipbits2_8bit

fun flipbits3_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8)
): void = "mac#avr_libats_flipbits3_8bit"


overload flipbits with flipbits3_8bit

fun flipbits4_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8)
): void = "mac#avr_libats_flipbits4_8bit"


overload flipbits with flipbits4_8bit

fun flipbits5_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8)
): void = "mac#avr_libats_flipbits5_8bit"


overload flipbits with flipbits5_8bit

fun flipbits6_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8)
): void = "mac#avr_libats_flipbits6_8bit"


overload flipbits with flipbits6_8bit

fun flipbits7_8bit {m: mcu} (
    r: register(m, 8), b0: natLt(8), b1: natLt(8), b2: natLt(8), b3: natLt(8), b4: natLt(8), b5: natLt(8), b6: natLt(8), b7: natLt(8)
): void = "mac#avr_libats_flipbits7_8bit"


overload flipbits with flipbits7_8bit