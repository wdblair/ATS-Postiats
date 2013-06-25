/*
**
** The C code is generated by ATS/Anairiats
** The compilation time is: 2013-6-24: 22h:57m
**
*/

/* include some .h files */
#ifndef _ATS_HEADER_NONE
#include "ats_config.h"
#include "ats_basics.h"
#include "ats_types.h"
#include "ats_exception.h"
#include "ats_memory.h"
#endif /* _ATS_HEADER_NONE */

/* include some .h files for avr */
#ifdef _ATS_AVR
#include "ats/basics.h"
#endif /* _ATS_AVR */
/* include some .cats files */
#ifndef _ATS_PRELUDE_NONE
#include "prelude/CATS/basics.cats"
#include "prelude/CATS/bool.cats"
#include "prelude/CATS/byte.cats"
#include "prelude/CATS/char.cats"
#include "prelude/CATS/float.cats"
#include "prelude/CATS/integer.cats"
#include "prelude/CATS/integer_fixed.cats"
#include "prelude/CATS/integer_ptr.cats"
#include "prelude/CATS/lazy.cats"
#include "prelude/CATS/lazy_vt.cats"
#include "prelude/CATS/pointer.cats"
#include "prelude/CATS/printf.cats"
#include "prelude/CATS/reference.cats"
#include "prelude/CATS/sizetype.cats"
#include "prelude/CATS/string.cats"
#include "prelude/CATS/array.cats"
#include "prelude/CATS/list.cats"
#include "prelude/CATS/matrix.cats"
#include "prelude/CATS/option.cats"
#endif /* _ATS_PRELUDE_NONE */
/* prologues from statically loaded files */

#include "libc/CATS/gmp.cats"

#include "pats_location.cats"

#include "pats_location.cats"

#include "pats_location.cats"

#include "pats_lexbuf.cats"

#include "pats_location.cats"

#include "pats_location.cats"

#include "libc/CATS/gmp.cats"

#include "pats_location.cats"

#include "pats_location.cats"

#include "pats_location.cats"

#include "pats_lexbuf.cats"

#include "pats_location.cats"

#include "pats_location.cats"
/* external codes at top */
/* type definitions */
typedef
struct {
ats_ptr_type atslab_s2hole_srt ;
ats_int_type atslab_s2hole_stamp ;
} anairiats_rec_0 ;

/* external typedefs */
/* external dynamic constructor declarations */
/* external dynamic constant declarations */
ATSextern_fun(ats_bool_type, atspre_lte_int_int) (ats_int_type, ats_int_type) ;
ATSextern_fun(ats_int_type, atspre_isucc) (ats_int_type) ;
ATSextern_fun(ats_int_type, atspre_iadd) (ats_int_type, ats_int_type) ;
ATSextern_fun(ats_int_type, atspre_isub) (ats_int_type, ats_int_type) ;
ATSextern_fun(ats_bool_type, atspre_igt) (ats_int_type, ats_int_type) ;
ATSextern_fun(ats_ptr_type, atspre_ptr_alloc_tsz) (ats_size_type) ;
ATSextern_fun(ats_void_type, atspre_ptr_zero_tsz) (ats_ref_type, ats_size_type) ;
ATSextern_fun(ats_ptr_type, atspre_ref_make_elt_tsz) (ats_ref_type, ats_size_type) ;
ATSextern_fun(ats_ptr_type, atspre_ref_make_view_ptr) (ats_ptr_type) ;
ATSextern_fun(ats_ptr_type, ListSubscriptException_make) () ;
ATSextern_fun(ats_void_type, _2opt_2postiats_2src_2pats_stamp_2esats__fprint_stamp) (ats_ptr_type, ats_int_type) ;
ATSextern_fun(ats_int_type, _2opt_2postiats_2src_2pats_stamp_2esats__s2hole_stamp_make) () ;
ATSextern_fun(ats_int_type, _2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_get_stamp) (ats_ptr_type) ;

/* external dynamic terminating constant declarations */
#ifdef _ATS_PROOFCHECK
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2SATS_2list_2esats__list_length_is_nonnegative_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2SATS_2list_vt_2esats__list_vt_length_is_nonnegative_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
extern
ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
#endif /* _ATS_PROOFCHECK */

/* assuming abstract types */
int _2opt_2postiats_2src_2pats_staexp2_2esats__sasp__s2hole_type = 0 ;

/* sum constructor declarations */
/* exn constructor declarations */
/* global dynamic (non-functional) constant declarations */
/* internal function declarations */
static
ats_ptr_type ptr_alloc_01234_anairiats_rec_0 () ;

/* partial value template declarations */
/* static temporary variable declarations */
/* external value variable declarations */

/* function implementations */

/*
// /opt/ats0210/prelude/DATS/pointer.dats: 1817(line=56, offs=24) -- 1850(line=56, offs=57)
*/
ATSstaticdec()
ats_ptr_type
ptr_alloc_01234_anairiats_rec_0 () {
/* local vardec */
ATSlocal (ats_ptr_type, tmp3) ;

__ats_lab_ptr_alloc_01234_anairiats_rec_0:
tmp3 = atspre_ptr_alloc_tsz (sizeof(anairiats_rec_0)) ;
return (tmp3) ;
} /* end of [ptr_alloc_01234_anairiats_rec_0] */

/*
// /opt/postiats/src/pats_staexp2_hole.dats: 1904(line=66, offs=17) -- 2171(line=76, offs=4)
*/
ATSglobaldec()
ats_ptr_type
_2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_make_srt (ats_ptr_type arg0) {
/* local vardec */
ATSlocal (ats_ptr_type, tmp0) ;
ATSlocal (ats_int_type, tmp1) ;
ATSlocal (ats_ptr_type, tmp2) ;
ATSlocal (ats_ptr_type, tmp4) ;

__ats_lab__2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_make_srt:
tmp1 = _2opt_2postiats_2src_2pats_stamp_2esats__s2hole_stamp_make () ;
tmp2 = ptr_alloc_01234_anairiats_rec_0 () ;
tmp4 = ats_selsin_mac(tmp2, atslab_2) ;
ats_selptr_mac(ats_castptr_mac(anairiats_rec_0, tmp4), atslab_s2hole_srt) = arg0 ;
ats_selptr_mac(ats_castptr_mac(anairiats_rec_0, tmp4), atslab_s2hole_stamp) = tmp1 ;
tmp0 = atspre_ref_make_view_ptr (tmp4) ;
return (tmp0) ;
} /* end of [_2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_make_srt] */

/*
// /opt/postiats/src/pats_staexp2_hole.dats: 2226(line=79, offs=16) -- 2316(line=81, offs=4)
*/
ATSglobaldec()
ats_ptr_type
_2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_get_srt (ats_ptr_type arg0) {
/* local vardec */
ATSlocal (ats_ptr_type, tmp5) ;
ATSlocal (ats_ptr_type, tmp6) ;

__ats_lab__2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_get_srt:
tmp6 = ats_selsin_mac(ats_castfn_mac(ats_ptr_type, arg0), atslab_1) ;
tmp5 = ats_selptr_mac(ats_castptr_mac(anairiats_rec_0, tmp6), atslab_s2hole_srt) ;
return (tmp5) ;
} /* end of [_2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_get_srt] */

/*
// /opt/postiats/src/pats_staexp2_hole.dats: 2372(line=84, offs=18) -- 2464(line=86, offs=4)
*/
ATSglobaldec()
ats_int_type
_2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_get_stamp (ats_ptr_type arg0) {
/* local vardec */
ATSlocal (ats_int_type, tmp7) ;
ATSlocal (ats_ptr_type, tmp8) ;

__ats_lab__2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_get_stamp:
tmp8 = ats_selsin_mac(ats_castfn_mac(ats_ptr_type, arg0), atslab_1) ;
tmp7 = ats_selptr_mac(ats_castptr_mac(anairiats_rec_0, tmp8), atslab_s2hole_stamp) ;
return (tmp7) ;
} /* end of [_2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_get_stamp] */

/*
// /opt/postiats/src/pats_staexp2_hole.dats: 2565(line=94, offs=3) -- 2681(line=100, offs=4)
*/
ATSglobaldec()
ats_void_type
_2opt_2postiats_2src_2pats_staexp2_2esats__fprint_s2hole (ats_ptr_type arg0, ats_ptr_type arg1) {
/* local vardec */
// ATSlocal_void (tmp9) ;
ATSlocal (ats_int_type, tmp10) ;

__ats_lab__2opt_2postiats_2src_2pats_staexp2_2esats__fprint_s2hole:
tmp10 = _2opt_2postiats_2src_2pats_staexp2_2esats__s2hole_get_stamp (arg1) ;
/* tmp9 = */ _2opt_2postiats_2src_2pats_stamp_2esats__fprint_stamp (arg0, tmp10) ;
return /* (tmp9) */ ;
} /* end of [_2opt_2postiats_2src_2pats_staexp2_2esats__fprint_s2hole] */

#ifdef _ATS_AVR

#define _2opt_2postiats_2src_2pats_staexp2_hole_2edats__staload() 

#else

/* static load function */

extern ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2pointer_2edats__staload (void) ;
extern ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2reference_2edats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_counter_2esats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_stamp_2esats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_staexp2_2esats__staload (void) ;

ats_void_type
_2opt_2postiats_2src_2pats_staexp2_hole_2edats__staload () {
static int _2opt_2postiats_2src_2pats_staexp2_hole_2edats__staload_flag = 0 ;
if (_2opt_2postiats_2src_2pats_staexp2_hole_2edats__staload_flag) return ;
_2opt_2postiats_2src_2pats_staexp2_hole_2edats__staload_flag = 1 ;

ATS_2d0_2e2_2e10_2prelude_2DATS_2pointer_2edats__staload () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2reference_2edats__staload () ;
_2opt_2postiats_2src_2pats_counter_2esats__staload () ;
_2opt_2postiats_2src_2pats_stamp_2esats__staload () ;
_2opt_2postiats_2src_2pats_staexp2_2esats__staload () ;

return ;
} /* staload function */


#endif/* dynamic load function */

// dynload flag declaration
extern ats_int_type _2opt_2postiats_2src_2pats_staexp2_hole_2edats__dynload_flag ;

ats_void_type
_2opt_2postiats_2src_2pats_staexp2_hole_2edats__dynload () {
_2opt_2postiats_2src_2pats_staexp2_hole_2edats__dynload_flag = 1 ;
_2opt_2postiats_2src_2pats_staexp2_hole_2edats__staload () ;

#ifdef _ATS_PROOFCHECK
ATS_2d0_2e2_2e10_2prelude_2SATS_2list_2esats__list_length_is_nonnegative_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2SATS_2list_vt_2esats__list_vt_length_is_nonnegative_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats____assert_prfck () ;
#endif /* _ATS_PROOFCHECK */

/* marking static variables for GC */

/* marking external values for GC */

/* code for dynamic loading */
return ;
} /* end of [dynload function] */

/* external codes at mid */
/* external codes at bot */

/* ****** ****** */

/* end of [/opt/postiats/src/pats_staexp2_hole_dats.c] */
