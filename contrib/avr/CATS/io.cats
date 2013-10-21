#ifndef _AVR_LIBATS_IO_HEADER
#define _AVR_LIBATS_IO_HEADER

#include <avr/sfr_defs.h>
#include <avr/common.h>
#include <avr/version.h>

#include "CATS/io_bits.cats"

#define _MMIO_ADDR_BYTE(mem_addr) (volatile uint8_t*)(mem_addr)
#define _MMIO_ADDR_WORD(mem_addr) (volatile uint16_t*)(mem_addr)
#define _MMIO_ADDR_DWORD(mem_addr) (volatile uint32_t*)(mem_addr)

#define _SFR_ADDR_MEM8(mem_addr) _MMIO_ADDR_BYTE(mem_addr)
#define _SFR_ADDR_MEM16(mem_addr) _MMIO_ADDR_WORD(mem_addr)
#define _SFR_ADDR_MEM32(mem_addr) _MMIO_ADDR_DWORD(mem_addr)

#define _SFR_ADDR_IO8(io_addr)  _MMIO_ADDR_BYTE((io_addr) + __SFR_OFFSET)
#define _SFR_ADDR_IO16(io_addr) _MMIO_ADDR_WORD((io_addr) + __SFR_OFFSET)

#define loop_until_bit_is_set_8bit(reg, bit)            \
  do {} while(!((*_MMIO_ADDR_BYTE(reg)) & _BV(bit)))

#define avr_libats_setval_8bit(reg, val) ((* _MMIO_ADDR_BYTE(reg)) = (uint8_t)val)
#define avr_libats_setval_16bit(reg, value) (* _MMIO_ADDR_WORD(reg) = value)

#define avr_libats_value_8bit(reg) (*_MMIO_ADDR_BYTE(reg))

#endif
