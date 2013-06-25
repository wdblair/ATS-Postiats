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
/* external codes at top */
/* type definitions */
/* external typedefs */
/* assuming abstract types */
/* sum constructor declarations */
/* exn constructor declarations */
#ifdef _ATS_AVR

#define _2opt_2postiats_2src_2pats_effect_2esats__staload() 

#else

/* static load function */

extern ats_void_type _2opt_2postiats_2src_2pats_basics_2esats__staload (void) ;

ats_void_type
_2opt_2postiats_2src_2pats_effect_2esats__staload () {
static int _2opt_2postiats_2src_2pats_effect_2esats__staload_flag = 0 ;
if (_2opt_2postiats_2src_2pats_effect_2esats__staload_flag) return ;
_2opt_2postiats_2src_2pats_effect_2esats__staload_flag = 1 ;

_2opt_2postiats_2src_2pats_basics_2esats__staload () ;

return ;
} /* staload function */


#endif/* external codes at mid */
/* external codes at bot */

/* ****** ****** */

/* end of [/opt/postiats/src/pats_effect_sats.c] */
