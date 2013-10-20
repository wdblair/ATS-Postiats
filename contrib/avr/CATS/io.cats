#ifndef _AVR_LIBATS_IO_HEADER
#define _AVR_LIBATS_IO_HEADER

#include <avr/sfr_defs.h>
#include <avr/common.h>
#include <avr/version.h>

#define _MMIO_ADDR_BYTE(mem_addr) (volatile uint8_t*)(mem_addr)
#define _MMIO_ADDR_WORD(mem_addr) (volatile uint16_t*)(mem_addr)
#define _MMIO_ADDR_DWORD(mem_addr) (volatile uint32_t*)(mem_addr)

#define _SFR_ADDR_MEM8(mem_addr) _MMIO_ADDR_BYTE(mem_addr)
#define _SFR_ADDR_MEM16(mem_addr) _MMIO_ADDR_WORD(mem_addr)
#define _SFR_ADDR_MEM32(mem_addr) _MMIO_ADDR_DWORD(mem_addr)

#define _SFR_ADDR_IO8(io_addr)  _MMIO_ADDR_BYTE((io_addr) + __SFR_OFFSET)
#define _SFR_ADDR_IO16(io_addr) _MMIO_ADDR_WORD((io_addr) + __SFR_OFFSET)

#define loop_until_bit_is_set_8bit(reg, bit)                  \
  do {} while(!((*(volatile uint8_t *)reg) & _BV(bit)))

#define avr_libats_setval_8bit(reg, val) ((*(volatile uint8_t *)reg) = (uint8_t)val)

#define avr_libats_setval_16bit(high, low, value)               \
  do {                                                          \
    *(volatile uint8_t *)high = (uint8_t)((value >> 8) & 0xff);    \
    *(volatile uint8_t *)low = (uint8_t)(value & 0xff);            \
  } while(0)

#define avr_libats_value_8bit(reg) (*(volatile uint8_t*)reg)

#define avr_libats_setbits0_8bit(reg, b0) (*(volatile uint8_t*)reg |= (_BV(b0)))

#define avr_libats_setbits1_8bit(reg, b0, b1) (*(volatile uint8_t*)reg |= (_BV(b0) | _BV(b1)))


#define avr_libats_setbits2_8bit(reg, b0, b1, b2) (*(volatile uint8_t*)reg |= (_BV(b0) | _BV(b1) | _BV(b2)))


#define avr_libats_setbits3_8bit(reg, b0, b1, b2, b3) (*(volatile uint8_t*)reg |= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3)))


#define avr_libats_setbits4_8bit(reg, b0, b1, b2, b3, b4) (*(volatile uint8_t*)reg |= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4)))


#define avr_libats_setbits5_8bit(reg, b0, b1, b2, b3, b4, b5) (*(volatile uint8_t*)reg |= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5)))


#define avr_libats_setbits6_8bit(reg, b0, b1, b2, b3, b4, b5, b6) (*(volatile uint8_t*)reg |= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6)))


#define avr_libats_setbits7_8bit(reg, b0, b1, b2, b3, b4, b5, b6, b7) (*(volatile uint8_t*)reg |= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6) | _BV(b7)))


#define avr_libats_maskbits0_8bit(reg, b0) (*(volatile uint8_t*)reg &= (_BV(b0)))


#define avr_libats_maskbits1_8bit(reg, b0, b1) (*(volatile uint8_t*)reg &= (_BV(b0) | _BV(b1)))


#define avr_libats_maskbits2_8bit(reg, b0, b1, b2) (*(volatile uint8_t*)reg &= (_BV(b0) | _BV(b1) | _BV(b2)))


#define avr_libats_maskbits3_8bit(reg, b0, b1, b2, b3) (*(volatile uint8_t*)reg &= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3)))


#define avr_libats_maskbits4_8bit(reg, b0, b1, b2, b3, b4) (*(volatile uint8_t*)reg &= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4)))


#define avr_libats_maskbits5_8bit(reg, b0, b1, b2, b3, b4, b5) (*(volatile uint8_t*)reg &= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5)))


#define avr_libats_maskbits6_8bit(reg, b0, b1, b2, b3, b4, b5, b6) (*(volatile uint8_t*)reg &= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6)))


#define avr_libats_maskbits7_8bit(reg, b0, b1, b2, b3, b4, b5, b6, b7) (*(volatile uint8_t*)reg &= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6) | _BV(b7)))


#define avr_libats_clearbits0_8bit(reg, b0) (*(volatile uint8_t*)reg &= ~(_BV(b0)))


#define avr_libats_clearbits1_8bit(reg, b0, b1) (*(volatile uint8_t*)reg &= ~(_BV(b0) | _BV(b1)))


#define avr_libats_clearbits2_8bit(reg, b0, b1, b2) (*(volatile uint8_t*)reg &= ~(_BV(b0) | _BV(b1) | _BV(b2)))


#define avr_libats_clearbits3_8bit(reg, b0, b1, b2, b3) (*(volatile uint8_t*)reg &= ~(_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3)))


#define avr_libats_clearbits4_8bit(reg, b0, b1, b2, b3, b4) (*(volatile uint8_t*)reg &= ~(_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4)))


#define avr_libats_clearbits5_8bit(reg, b0, b1, b2, b3, b4, b5) (*(volatile uint8_t*)reg &= ~(_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5)))


#define avr_libats_clearbits6_8bit(reg, b0, b1, b2, b3, b4, b5, b6) (*(volatile uint8_t*)reg &= ~(_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6)))


#define avr_libats_clearbits7_8bit(reg, b0, b1, b2, b3, b4, b5, b6, b7) (*(volatile uint8_t*)reg &= ~(_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6) | _BV(b7)))


#define avr_libats_clear_and_setbits0_8bit(reg, b0) (*(volatile uint8_t*)reg = (_BV(b0)))


#define avr_libats_clear_and_setbits1_8bit(reg, b0, b1) (*(volatile uint8_t*)reg = (_BV(b0) | _BV(b1)))


#define avr_libats_clear_and_setbits2_8bit(reg, b0, b1, b2) (*(volatile uint8_t*)reg = (_BV(b0) | _BV(b1) | _BV(b2)))


#define avr_libats_clear_and_setbits3_8bit(reg, b0, b1, b2, b3) (*(volatile uint8_t*)reg = (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3)))


#define avr_libats_clear_and_setbits4_8bit(reg, b0, b1, b2, b3, b4) (*(volatile uint8_t*)reg = (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4)))


#define avr_libats_clear_and_setbits5_8bit(reg, b0, b1, b2, b3, b4, b5) (*(volatile uint8_t*)reg = (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5)))


#define avr_libats_clear_and_setbits6_8bit(reg, b0, b1, b2, b3, b4, b5, b6) (*(volatile uint8_t*)reg = (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6)))


#define avr_libats_clear_and_setbits7_8bit(reg, b0, b1, b2, b3, b4, b5, b6, b7) (*(volatile uint8_t*)reg = (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6) | _BV(b7)))


#define avr_libats_flipbits0_8bit(reg, b0) (*(volatile uint8_t*)reg ^= (_BV(b0)))


#define avr_libats_flipbits1_8bit(reg, b0, b1) (*(volatile uint8_t*)reg ^= (_BV(b0) | _BV(b1)))


#define avr_libats_flipbits2_8bit(reg, b0, b1, b2) (*(volatile uint8_t*)reg ^= (_BV(b0) | _BV(b1) | _BV(b2)))


#define avr_libats_flipbits3_8bit(reg, b0, b1, b2, b3) (*(volatile uint8_t*)reg ^= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3)))


#define avr_libats_flipbits4_8bit(reg, b0, b1, b2, b3, b4) (*(volatile uint8_t*)reg ^= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4)))


#define avr_libats_flipbits5_8bit(reg, b0, b1, b2, b3, b4, b5) (*(volatile uint8_t*)reg ^= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5)))


#define avr_libats_flipbits6_8bit(reg, b0, b1, b2, b3, b4, b5, b6) (*(volatile uint8_t*)reg ^= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6)))


#define avr_libats_flipbits7_8bit(reg, b0, b1, b2, b3, b4, b5, b6, b7) (*(volatile uint8_t*)reg ^= (_BV(b0) | _BV(b1) | _BV(b2) | _BV(b3) | _BV(b4) | _BV(b5) | _BV(b6) | _BV(b7)))



#endif
