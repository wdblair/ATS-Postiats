#define USE_SMT 1

staload _ = "./pats_smt_yices.dats"

local
  staload "libc/SATS/gmp.sats"
  staload "pats_lintprgm_myint_intinf.dats"

  //Sort shouldn't be a parameter, since I only use integers for now
  implement $SMT.make_numeral<intinfknd> (ctx, num, srt) = wff where {
    extern fun yices_mpz (_: &mpz_vt): formula = "mac#"
    //
    prval () = midec (num)
    prval pfat_num = num.1
    //
    val wff = yices_mpz(!(num.2))
    //
    prval () = num.1 := pfat_num
    prval () = mienc (num)
    //
  }
in end