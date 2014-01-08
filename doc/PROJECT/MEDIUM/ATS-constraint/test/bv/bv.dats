staload "bv.sats"

assume uint8_t0ype (b:bv8) = $extype "uint8"

implement is_power_of_two (b) =
  (b land (b - (bv8)1u)) = (bv8)0u