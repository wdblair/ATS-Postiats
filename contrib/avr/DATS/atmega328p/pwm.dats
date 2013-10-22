staload "SATS/io.sats"
staload "SATS/timer.sats"
staload "SATS/pwm.sats"

staload "DATS/atmega328p/io.dats"

stadef m = atmega328p

implement pwm_start<m><phase_correct><timer0>() = begin
    setbits (TCCR0A<m>(), WGM00, COM0A1, COM0B1);
    setbits (TCCR0B<m>(), CS00);
    setbits (DDRD<m>(), DDD5, DDD6);
    setval (OCR0A<m>(), 0);
    setval (OCR0B<m>(), 0);
end

implement pwm_start<m><phase_correct><timer2>() = begin
    setbits (TCCR2A<m>(), WGM20, COM2A1, COM2B1);
    setbits (TCCR2B<m>(), CS20);
    setbits (DDRD<m>(), DDD3);
    setbits (DDRB<m>(), DDB3);
    setval (OCR2A<m>(), 0);
    setval (OCR2B<m>(), 0);
end

implement pwm_set_duty<m><timer0><a> (d) = begin
  setval (OCR0A<m>(), d);
end
implement pwm_set_duty<m><timer0><b> (d) = begin
  setval (OCR0B<m>(), d);
end

implement pwm_set_duty<m><timer2><a> (d) = begin
  setval (OCR2A<m>(), d);
end

implement pwm_set_duty<m><timer2><b> (d) = begin
  setval (OCR2B<m>(), d);
end