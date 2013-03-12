staload "SATS/io.sats"
staload "SATS/interrupt.sats"

implement {m} save_interrupts() = value(SREG())