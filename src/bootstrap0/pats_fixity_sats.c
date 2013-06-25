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
/* prologues from statically loaded files */

#include "pats_location.cats"
/* external codes at top */
/* type definitions */
/* external typedefs */
/* assuming abstract types */
/* sum constructor declarations */
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__ASSOCnon_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__ASSOClft_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__ASSOCrgt_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__FXTYnon_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__FXTYinf_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__FXTYpre_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__FXTYpos_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__FXITMatm_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__FXITMopr_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__FXOPRinf_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__FXOPRpre_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_fixity_2esats__FXOPRpos_2) ;

/* exn constructor declarations */
#ifdef _ATS_AVR

#define _2opt_2postiats_2src_2pats_fixity_2esats__staload() 

#else

/* static load function */

extern ats_void_type _2opt_2postiats_2src_2pats_location_2esats__staload (void) ;

ats_void_type
_2opt_2postiats_2src_2pats_fixity_2esats__staload () {
static int _2opt_2postiats_2src_2pats_fixity_2esats__staload_flag = 0 ;
if (_2opt_2postiats_2src_2pats_fixity_2esats__staload_flag) return ;
_2opt_2postiats_2src_2pats_fixity_2esats__staload_flag = 1 ;

_2opt_2postiats_2src_2pats_location_2esats__staload () ;

_2opt_2postiats_2src_2pats_fixity_2esats__ASSOCnon_0.tag = 0 ;
_2opt_2postiats_2src_2pats_fixity_2esats__ASSOClft_1.tag = 1 ;
_2opt_2postiats_2src_2pats_fixity_2esats__ASSOCrgt_2.tag = 2 ;
_2opt_2postiats_2src_2pats_fixity_2esats__FXTYnon_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_fixity_2esats__FXTYinf_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_fixity_2esats__FXTYpre_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_fixity_2esats__FXTYpos_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_fixity_2esats__FXITMatm_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_fixity_2esats__FXITMopr_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_fixity_2esats__FXOPRinf_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_fixity_2esats__FXOPRpre_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_fixity_2esats__FXOPRpos_2.tag = 2 ;
return ;
} /* staload function */


#endif/* external codes at mid */
/* external codes at bot */

/* ****** ****** */

/* end of [/opt/postiats/src/pats_fixity_sats.c] */
