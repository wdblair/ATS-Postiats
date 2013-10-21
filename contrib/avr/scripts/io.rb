#!/usr/bin/env ruby

#A helper script to generate some repetative code.

settings = {
  setbits: {
    assign: "|="
  },
  maskbits: {
    assign: "&="
  },
  clearbits: {
    assign: "&=",
    filter: "~"
  },
  flipbits: {
    assign: "^="
  },
  clear_and_setbits: {
    assign: "=",
  }
}

functions = [:setbits, :maskbits, :clearbits, :clear_and_setbits, :flipbits]

make_bits_sats = lambda { |file|

  functions.each { |f|
    fn_tmpl =<<FUNCTION
fun __name__ {m: mcu} (
    r: register(m, 8), __bits__
): void = "mac#avr_libats___name__"
FUNCTION
    
    name = f.to_s
    file.puts("symintr #{name}\n\n")
    8.times { |i|
      bits = (0..i).map { |b|
        "b#{b}: natLt(8)"
      }.join(", ")
      n = name + i.to_s + "_8bit"
      file.puts(fn_tmpl.gsub(/__name__/,n).gsub(/__bits__/,bits)+"\n\n")
      file.puts("overload #{name} with #{n}\n\n")
    }
  }
}

make_bits_cats = lambda { |file|
  functions.each { |f|
    mac_tmpl =<<MACRO
#define avr_libats___name__(reg, __labels__) (*_MMIO_ADDR_BYTE(reg) __assign__ __filter__(__bits__))
MACRO
    
    name = f.to_s
    8.times { |i|
      bits = (0..i).map { |b|
        "b#{b}"
      }
      
      labels = bits.join(", ")
      sum = bits.map{ |b|
        "_BV(#{b})"
      }.join(" | ")

      n = name+i.to_s + "_8bit"
      file.puts (
                 mac_tmpl.gsub(/__name__/,n).gsub(/__labels__/,labels)
                   .gsub(/__assign__/,settings[f][:assign] || "")
                   .gsub(/__filter__/,settings[f][:filter] || "")
                   .gsub(/__bits__/,sum) + "\n\n"
                 )
    }
  }
}

#Just work with the atmega328p for now.
def make_pin_sats file
  reg_tmpl  = "fun {m:mcu} __name__ (): register(m, __width__)\n\n"

  isreg = false
  open("/usr/avr/include/avr/iom328p.h", "r").each_line { |line|
    #pins
    if m = /^#define ([A-Z0-9_]+) (\d)/.match(line)
      #file.puts(pin_tmpl.gsub(/__name__/, m[1]).gsub(/__value__/, "int "+m[2]))
    #registers
    elsif n = /^#define ([A-Z0-9_]+) _SFR_(MEM|IO)(8|16)\((0[xX][0-9a-fA-f]+)\)/.match(line)
      res = reg_tmpl.gsub(/__name__/, n[1]).gsub(/__width__/, n[3]).gsub(/__address__/, n[4])
      file.puts(res)
      isreg = true
    #add an extra newline after we hit all of a register's pins.
    elsif isreg
      isreg = false
      file.puts "\n"
    end
  }
end

def make_pin_dats file
  reg_tmpl  = "implement __name__<atmega328p>() = $extval(register(atmega328p, __width__), \"_SFR_ADDR___type____width__(__address__)\")"
  pin_tmpl = 'macdef __name__ = $extval(int __value__, "__value__")'
  
  isreg = false
  open("/usr/avr/include/avr/iom328p.h", "r").each_line { |line|
    #pins
    if m = /^#define ([A-Z0-9_]+) (\d)/.match(line)
      file.puts(pin_tmpl.gsub(/__name__/, m[1]).gsub(/__value__/, m[2]))
    #registers
    elsif n = /^#define ([A-Z0-9_]+) _SFR_(MEM|IO)(8|16)\((0[xX][0-9a-fA-f]+)\)/.match(line)
      res = reg_tmpl.gsub(/__name__/, n[1]).gsub(/__type__/, n[2]).gsub(/__width__/, n[3]).gsub(/__address__/, n[4])
      file.puts(res)
      isreg = true
    #add an extra newline after we hit all of a register's pins.
    elsif isreg
      isreg = false
      file.puts "\n"
    end
  }
  
end

open("io_bits.sats", "w+") { |s|
  make_bits_sats.call(s)
}

open("io_bits.cats","w+") { |c|
  make_bits_cats.call(c)
}

open("iom328p.sats","w+") { |s|
  make_pin_sats(s)
}

open("iom328p.dats", "w+") { |s|
  make_pin_dats(s)
}
