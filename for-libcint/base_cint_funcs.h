/*
 * Copyright (C) 2019-  Qiming Sun <osirpt.sun@gmail.com>
 *
 * Function signature
 */


#include <cint.h>

#if !defined HAVE_DEFINED_CINTINTEGRALFUNCTION
#define HAVE_DEFINED_CINTINTEGRALFUNCTION
typedef void CINTOptimizerFunction(CINTOpt **opt,
                                   FINT *atm, FINT natm, FINT *bas, FINT nbas, double *env);
typedef CACHE_SIZE_T CINTIntegralFunction(double *out, FINT *dims, FINT *shls,
                                  FINT *atm, FINT natm, FINT *bas, FINT nbas, double *env,
                                  CINTOpt *opt, double *cache);
#endif

/* Plain ERI (ij|kl) */
extern CINTOptimizerFunction int2e_optimizer;
extern CINTIntegralFunction int2e_cart;
extern CINTIntegralFunction int2e_sph;
extern CINTIntegralFunction int2e_spinor;

/* <i|OVLP |j> */
extern CINTOptimizerFunction int1e_ovlp_optimizer;
extern CINTIntegralFunction int1e_ovlp_cart;
extern CINTIntegralFunction int1e_ovlp_sph;
extern CINTIntegralFunction int1e_ovlp_spinor;

/* <i|NUC |j> */
extern CINTOptimizerFunction int1e_nuc_optimizer;
extern CINTIntegralFunction int1e_nuc_cart;
extern CINTIntegralFunction int1e_nuc_sph;
extern CINTIntegralFunction int1e_nuc_spinor;


