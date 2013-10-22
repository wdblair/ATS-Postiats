staload "SATS/io.sats"

sortdef pwm_mode = tkind

stacst fast : pwm_mode
stacst phase_correct : pwm_mode

sortdef timer = tkind

stacst t0 : timer
stacst t2 : timer

sortdef pwm_channel = tkind 

stacst a : pwm_channel
stacst b : pwm_channel

fun {m:mcu} {mode: pwm_mode} {t: timer}
pwm_start (): void

fun {m:mcu} {t: timer} {ch: pwm_channel}
pwm_set_duty (d: natLt(256)): void
