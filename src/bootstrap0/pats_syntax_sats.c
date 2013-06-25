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

#include "pats_location.cats"

#include "pats_lexbuf.cats"

#include "pats_location.cats"

#include "pats_location.cats"
/* external codes at top */
/* type definitions */
typedef
struct {
ats_ptr_type atslab_s0taq_loc ;
ats_ptr_type atslab_s0taq_node ;
} anairiats_rec_0 ;

typedef
struct {
ats_ptr_type atslab_d0ynq_loc ;
ats_ptr_type atslab_d0ynq_node ;
} anairiats_rec_1 ;

/* external typedefs */
/* assuming abstract types */
/* sum constructor declarations */
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__SRPIFKINDif_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__SRPIFKINDifdef_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__SRPIFKINDifndef_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__MSKencode_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__MSKdecode_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__MSKxstage_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__CSTSPmyfil_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__CSTSPmyloc_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__CSTSPmyfun_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGint_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGcst_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGvar_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGprf_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGlin_4) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGfun_5) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGclo_6) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0RTQnone_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0RTQsymdot_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0TAQnone_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0TAQsymdot_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0TAQsymcolon_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0YNQnone_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0YNQsymdot_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0YNQsymcolon_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0YNQsymdotcolon_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0RECint_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0RECi0de_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0RECi0de_adj_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__F0XTYinf_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__F0XTYpre_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__F0XTYpos_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPACTassert_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPACTerror_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPACTprint_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPide_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPint_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPchar_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPfloat_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPstring_4) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPstringid_5) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPapp_6) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPfun_7) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPeval_8) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPlist_9) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__E0XPif_10) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__DATSDEF_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__SL0ABELED_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__DL0ABELED_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0RTide_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0RTqid_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0RTapp_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0RTlist_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0RTtype_4) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__SP0Tcstr_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0QUAprop_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0QUAvars_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0TEsrt_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0TEsub_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Eide_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Esqid_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Eopid_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Eint_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Echar_4) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Eextype_5) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Eextkind_6) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Eapp_7) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Elam_8) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Eimp_9) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Elist_10) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Elist2_11) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Etyarr_12) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Etytup_13) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Etyrec_14) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Etyrec_ext_15) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Euni_16) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Eexi_17) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0Eann_18) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__WITHT0YPEsome_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__WITHT0YPEnone_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0CSTARGsta_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0CSTARGdyn_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0VARARGone_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0VARARGall_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0VARARGseq_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0EXPARGone_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0EXPARGall_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__S0EXPARGseq_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__M0ACARGdyn_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__M0ACARGsta_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__DCSTEXTDEFnone_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__DCSTEXTDEFsome_ext_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__DCSTEXTDEFsome_mac_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__DCSTEXTDEFsome_sta_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__LABP0ATnorm_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__LABP0ATomit_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tide_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tdqid_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Topid_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tint_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tchar_4) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tfloat_5) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tstring_6) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tapp_7) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tlist_8) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tlst_9) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Ttup_10) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Trec_11) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tfree_12) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tunfold_13) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Texist_14) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tsvararg_15) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Trefas_16) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Tann_17) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__P0Terr_18) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__I0MPARG_sarglst_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__I0MPARG_svararglst_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__F0ARGdyn_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__F0ARGsta1_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__F0ARGsta2_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__F0ARGmet_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eide_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Edqid_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eopid_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eidext_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eint_4) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Echar_5) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Efloat_6) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Estring_7) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eempty_8) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Ecstsp_9) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eextval_10) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eextfcall_11) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Efoldat_12) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Efreeat_13) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Etmpid_14) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Elet_15) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Edeclseq_16) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Ewhere_17) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eapp_18) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Elist_19) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eifhead_20) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Esifhead_21) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Ecasehead_22) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Escasehead_23) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Elst_24) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Etup_25) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Erec_26) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eseq_27) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Earrsub_28) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Earrpsz_29) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Earrinit_30) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eraise_31) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eeffmask_32) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eeffmask_arg_33) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eshowtype_34) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Evcopyenv_35) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eptrof_36) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eviewat_37) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Esel_lab_38) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Esel_ind_39) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Esexparg_40) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eexist_41) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Elam_42) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Efix_43) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Edelay_44) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Efor_45) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Ewhile_46) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eloopexn_47) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Etrywith_48) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Emacsyn_49) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Eann_50) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__GD0Cone_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__GD0Ctwo_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__GD0Ccons_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cfixity_0) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cnonfix_1) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Csymintr_2) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Csymelim_3) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Coverload_4) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Ce0xpdef_5) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Ce0xpundef_6) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Ce0xpact_7) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cdatsrts_8) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Csrtdefs_9) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cstacsts_10) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cstacons_11) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Ctkindef_12) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Csexpdefs_13) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Csaspdec_14) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cexndecs_15) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cdatdecs_16) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cclassdec_17) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cextype_18) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cextype_19) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cextval_20) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cextcode_21) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cdcstdecs_22) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cmacdefs_23) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cfundecs_24) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cvaldecs_25) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cvardecs_26) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cimpdec_27) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cinclude_28) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cstaload_29) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cdynload_30) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Clocal_31) ;
ATSglobal(ats_sum_type, _2opt_2postiats_2src_2pats_syntax_2esats__D0Cguadecl_32) ;

/* exn constructor declarations */
#ifdef _ATS_AVR

#define _2opt_2postiats_2src_2pats_syntax_2esats__staload() 

#else

/* static load function */

extern ats_void_type ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_basics_2esats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_location_2esats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_lexing_2esats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_symbol_2esats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_label_2esats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_fixity_2esats__staload (void) ;
extern ats_void_type _2opt_2postiats_2src_2pats_filename_2esats__staload (void) ;

ats_void_type
_2opt_2postiats_2src_2pats_syntax_2esats__staload () {
static int _2opt_2postiats_2src_2pats_syntax_2esats__staload_flag = 0 ;
if (_2opt_2postiats_2src_2pats_syntax_2esats__staload_flag) return ;
_2opt_2postiats_2src_2pats_syntax_2esats__staload_flag = 1 ;

ATS_2d0_2e2_2e10_2prelude_2DATS_2list_2edats__staload () ;
_2opt_2postiats_2src_2pats_basics_2esats__staload () ;
_2opt_2postiats_2src_2pats_location_2esats__staload () ;
_2opt_2postiats_2src_2pats_lexing_2esats__staload () ;
_2opt_2postiats_2src_2pats_symbol_2esats__staload () ;
_2opt_2postiats_2src_2pats_label_2esats__staload () ;
_2opt_2postiats_2src_2pats_fixity_2esats__staload () ;
_2opt_2postiats_2src_2pats_filename_2esats__staload () ;

_2opt_2postiats_2src_2pats_syntax_2esats__SRPIFKINDif_0.tag = 0 ;
_2opt_2postiats_2src_2pats_syntax_2esats__SRPIFKINDifdef_1.tag = 1 ;
_2opt_2postiats_2src_2pats_syntax_2esats__SRPIFKINDifndef_2.tag = 2 ;
_2opt_2postiats_2src_2pats_syntax_2esats__MSKencode_0.tag = 0 ;
_2opt_2postiats_2src_2pats_syntax_2esats__MSKdecode_1.tag = 1 ;
_2opt_2postiats_2src_2pats_syntax_2esats__MSKxstage_2.tag = 2 ;
_2opt_2postiats_2src_2pats_syntax_2esats__CSTSPmyfil_0.tag = 0 ;
_2opt_2postiats_2src_2pats_syntax_2esats__CSTSPmyloc_1.tag = 1 ;
_2opt_2postiats_2src_2pats_syntax_2esats__CSTSPmyfun_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGint_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGcst_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGvar_2.tag = 2 ;
_2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGprf_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGlin_4.tag = 4 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGfun_5.tag = 5 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0FFTAGclo_6.tag = 6 ;
_2opt_2postiats_2src_2pats_syntax_2esats__S0RTQnone_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0RTQsymdot_1.tag = 1 ;
_2opt_2postiats_2src_2pats_syntax_2esats__S0TAQnone_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0TAQsymdot_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0TAQsymcolon_2.tag = 2 ;
_2opt_2postiats_2src_2pats_syntax_2esats__D0YNQnone_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0YNQsymdot_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0YNQsymcolon_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0YNQsymdotcolon_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0RECint_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0RECi0de_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0RECi0de_adj_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__F0XTYinf_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__F0XTYpre_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__F0XTYpos_2.tag = 2 ;
_2opt_2postiats_2src_2pats_syntax_2esats__E0XPACTassert_0.tag = 0 ;
_2opt_2postiats_2src_2pats_syntax_2esats__E0XPACTerror_1.tag = 1 ;
_2opt_2postiats_2src_2pats_syntax_2esats__E0XPACTprint_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPide_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPint_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPchar_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPfloat_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPstring_4.tag = 4 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPstringid_5.tag = 5 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPapp_6.tag = 6 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPfun_7.tag = 7 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPeval_8.tag = 8 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPlist_9.tag = 9 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__E0XPif_10.tag = 10 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__DATSDEF_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__SL0ABELED_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__DL0ABELED_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0RTide_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0RTqid_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0RTapp_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0RTlist_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0RTtype_4.tag = 4 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__SP0Tcstr_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0QUAprop_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0QUAvars_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0TEsrt_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0TEsub_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Eide_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Esqid_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Eopid_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Eint_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Echar_4.tag = 4 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Eextype_5.tag = 5 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Eextkind_6.tag = 6 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Eapp_7.tag = 7 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Elam_8.tag = 8 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Eimp_9.tag = 9 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Elist_10.tag = 10 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Elist2_11.tag = 11 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Etyarr_12.tag = 12 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Etytup_13.tag = 13 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Etyrec_14.tag = 14 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Etyrec_ext_15.tag = 15 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Euni_16.tag = 16 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Eexi_17.tag = 17 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0Eann_18.tag = 18 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__WITHT0YPEsome_0.tag = 0 ;
_2opt_2postiats_2src_2pats_syntax_2esats__WITHT0YPEnone_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0CSTARGsta_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0CSTARGdyn_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0VARARGone_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0VARARGall_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0VARARGseq_2.tag = 2 ;
_2opt_2postiats_2src_2pats_syntax_2esats__S0EXPARGone_0.tag = 0 ;
_2opt_2postiats_2src_2pats_syntax_2esats__S0EXPARGall_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__S0EXPARGseq_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__M0ACARGdyn_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__M0ACARGsta_1.tag = 1 ;
_2opt_2postiats_2src_2pats_syntax_2esats__DCSTEXTDEFnone_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__DCSTEXTDEFsome_ext_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__DCSTEXTDEFsome_mac_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__DCSTEXTDEFsome_sta_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__LABP0ATnorm_0.tag = 0 ;
_2opt_2postiats_2src_2pats_syntax_2esats__LABP0ATomit_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tide_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tdqid_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Topid_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tint_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tchar_4.tag = 4 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tfloat_5.tag = 5 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tstring_6.tag = 6 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tapp_7.tag = 7 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tlist_8.tag = 8 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tlst_9.tag = 9 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Ttup_10.tag = 10 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Trec_11.tag = 11 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tfree_12.tag = 12 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tunfold_13.tag = 13 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Texist_14.tag = 14 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tsvararg_15.tag = 15 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Trefas_16.tag = 16 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__P0Tann_17.tag = 17 ;
_2opt_2postiats_2src_2pats_syntax_2esats__P0Terr_18.tag = 18 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__I0MPARG_sarglst_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__I0MPARG_svararglst_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__F0ARGdyn_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__F0ARGsta1_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__F0ARGsta2_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__F0ARGmet_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eide_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Edqid_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eopid_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eidext_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eint_4.tag = 4 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Echar_5.tag = 5 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Efloat_6.tag = 6 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Estring_7.tag = 7 ;
_2opt_2postiats_2src_2pats_syntax_2esats__D0Eempty_8.tag = 8 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Ecstsp_9.tag = 9 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eextval_10.tag = 10 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eextfcall_11.tag = 11 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Efoldat_12.tag = 12 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Efreeat_13.tag = 13 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Etmpid_14.tag = 14 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Elet_15.tag = 15 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Edeclseq_16.tag = 16 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Ewhere_17.tag = 17 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eapp_18.tag = 18 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Elist_19.tag = 19 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eifhead_20.tag = 20 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Esifhead_21.tag = 21 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Ecasehead_22.tag = 22 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Escasehead_23.tag = 23 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Elst_24.tag = 24 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Etup_25.tag = 25 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Erec_26.tag = 26 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eseq_27.tag = 27 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Earrsub_28.tag = 28 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Earrpsz_29.tag = 29 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Earrinit_30.tag = 30 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eraise_31.tag = 31 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eeffmask_32.tag = 32 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eeffmask_arg_33.tag = 33 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eshowtype_34.tag = 34 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Evcopyenv_35.tag = 35 ;
_2opt_2postiats_2src_2pats_syntax_2esats__D0Eptrof_36.tag = 36 ;
_2opt_2postiats_2src_2pats_syntax_2esats__D0Eviewat_37.tag = 37 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Esel_lab_38.tag = 38 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Esel_ind_39.tag = 39 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Esexparg_40.tag = 40 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eexist_41.tag = 41 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Elam_42.tag = 42 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Efix_43.tag = 43 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Edelay_44.tag = 44 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Efor_45.tag = 45 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Ewhile_46.tag = 46 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eloopexn_47.tag = 47 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Etrywith_48.tag = 48 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Emacsyn_49.tag = 49 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Eann_50.tag = 50 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__GD0Cone_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__GD0Ctwo_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__GD0Ccons_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cfixity_0.tag = 0 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cnonfix_1.tag = 1 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Csymintr_2.tag = 2 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Csymelim_3.tag = 3 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Coverload_4.tag = 4 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Ce0xpdef_5.tag = 5 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Ce0xpundef_6.tag = 6 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Ce0xpact_7.tag = 7 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cdatsrts_8.tag = 8 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Csrtdefs_9.tag = 9 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cstacsts_10.tag = 10 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cstacons_11.tag = 11 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Ctkindef_12.tag = 12 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Csexpdefs_13.tag = 13 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Csaspdec_14.tag = 14 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cexndecs_15.tag = 15 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cdatdecs_16.tag = 16 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cclassdec_17.tag = 17 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cextype_18.tag = 18 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cextype_19.tag = 19 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cextval_20.tag = 20 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cextcode_21.tag = 21 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cdcstdecs_22.tag = 22 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cmacdefs_23.tag = 23 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cfundecs_24.tag = 24 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cvaldecs_25.tag = 25 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cvardecs_26.tag = 26 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cimpdec_27.tag = 27 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cinclude_28.tag = 28 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cstaload_29.tag = 29 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cdynload_30.tag = 30 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Clocal_31.tag = 31 ;
// _2opt_2postiats_2src_2pats_syntax_2esats__D0Cguadecl_32.tag = 32 ;
return ;
} /* staload function */


#endif/* external codes at mid */
/* external codes at bot */

/* ****** ****** */

/* end of [/opt/postiats/src/pats_syntax_sats.c] */
