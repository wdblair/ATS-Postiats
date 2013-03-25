%{^
declare_isr(TIMER0_OVF_vect);
%}

implement TIMER0_OVF_vect(pf | ) = timer_overflow<timer0><m>(pf | )