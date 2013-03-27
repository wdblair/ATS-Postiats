staload "SATS/io.sats"

%{#
#include "CATS/usart.cats"
%}

fun {m:mcu} init (
  baud: uint
): void

fun {m:mcu} rx (): char

fun {m:mcu} tx (c: char): int

fun ubrr_of_baud (baud: uint): uint 
  = "mac#avr_libats_ubrr_of_baud"