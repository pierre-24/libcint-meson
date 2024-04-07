#include <stdio.h>
#include <stdlib.h>

#include <cint_funcs.h>

#define MIN(a,b) ((a<b)? a:b)

int main() {
  printf("sizeof(FINT)=%ld\n", sizeof(FINT));

  /* water, STO-3G USING
  
  ```c
    printf("int atm[%d =%d*6 ] = {\n", bs->natm * 6, bs->natm);
    for (int iatm = 0; iatm < bs->natm; ++iatm) {
        printf("  ");
        for (int ipos = 0; ipos < 6; ++ipos)
            printf("%d,", bs->atm[iatm * 6 + ipos]);
        printf("\n");
    }
    printf("};\n");

    printf("int bas[%d =%d*8] = {\n", bs->nbas * 8, bs->nbas);
    for (int ibas = 0; ibas < bs->nbas; ++ibas) {
        printf("  ");
        for (int ipos = 0; ipos < 8; ++ipos)
            printf("%d,", bs->bas[ibas * 8 + ipos]);
        printf("\n");
    }
    printf("};\n");

    printf("double env[%ld] = {\n", bs->env_size);
    for(size_t ipos=0; ipos < bs->env_size; ipos++) {
        printf("%f,", bs->env[ipos]);
    }
    printf("};\n");
  ```
  */
  
  FINT natm = 3;
  FINT atm[18 /* =3*6 */] = {
    8,20,0,0,0,0,
    1,23,0,0,0,0,
    1,26,0,0,0,0,
  };
  
  FINT nbas = 5;
  FINT bas[40 /* =5*8 */] = {
    0,0,6,1,0,29,50,0,
    0,0,6,1,0,35,56,0,
    0,1,3,1,0,41,62,0,
    1,0,3,1,0,44,65,0,
    2,0,3,1,0,47,68,0,
  };
  double env[71] = {
    /* twenty zeros */ .0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,.0,
    /* pos O        */ .0,.0,0.226017, 
    /* pos H1       */ .0,1.439618, -0.904064, 
    /* pos H2       */ .0,-1.439618, -0.904064,
    /* 21 exponents */ 
      /* 1st basis */ 130.709320,23.808861,6.443608,5.033151,1.169596,0.380389, 
      /* 2nd basis */ 130.709320,23.808861,6.443608,5.033151,1.169596,0.380389,
      /* 3rd basis */ 5.033151,1.169596,0.380389,
      /* 4th basis */ 3.425251,0.623914,0.168855,
      /* 5th basis */ 3.425251,0.623914,0.168855,
    /* 21 coefs. (renormalized) */ 
      /* 1st basis */ 15.072747,14.577702,4.543234,.0,.0,.0,
      /* 2nd basis */ .0,.0,.0,-0.848697,1.135201,0.856753,
      /* 3rd basis */ 3.429066,2.156289,0.341592,
      /* 4th basis */ 0.981707,0.949464,0.295906,
      /* 5th basis */ 0.981707,0.949464,0.295906,
  };
  
  FINT si, sj;
  double buff[CART_MAX * CART_MAX];
  
  for(FINT ibas=0; ibas < nbas; ibas++) {
    si = CINTcgtos_cart(ibas, bas);
    for(FINT jbas=0; jbas <= ibas; jbas++) {
      sj = CINTcgtos_cart(jbas, bas);
      printf("ibas=%d (N=%d), jbas=%d (N=%d)\n", ibas, si, jbas, sj);
      int1e_ovlp_cart(buff, NULL, (FINT[]) {ibas, jbas}, atm, natm, bas, nbas, env, NULL, NULL);
      for (FINT ielm=0; ielm < si; ielm++) {
        for(FINT jelm=0; jelm < MIN(sj, ielm + 1); jelm++)
          printf(" %.5f", buff[ielm * si + jelm]);
        printf("\n");
      }
    }
  }
}
