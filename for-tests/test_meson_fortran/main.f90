! This is a poor-man translation of the C program used in other tests.
! I'm definitely not fluent in Fortran ;)

program test_libcint
  implicit none
  integer :: atm(18), bas(40), shells(2)
  double precision :: env(71), buff(15)
  integer natm, nbas, si, sj, ibas, jbas, ielm
  
  ! what?!?
  integer,external :: CINTcgto_cart
  
  print *, 'SIZEOF(integer)=', SIZEOF(natm)
  
  ! water STO-3G
  natm = 3
  atm = [&
    8,20,0,0,0,0, &
    1,23,0,0,0,0, &
    1,26,0,0,0,0 &
  ]
  
  nbas = 5
  bas = [&
    0,0,6,1,0,29,50,0, &
    0,0,6,1,0,35,56,0, &
    0,1,3,1,0,41,62,0, &
    1,0,3,1,0,44,65,0, &
    2,0,3,1,0,47,68,0 &
  ]
  
  env = [&
    ! twenty zeros
    .0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0,.0d0, &
    ! positions
    .0d0,.0d0,0.226017d0, &
    .0d0,1.439618d0, -0.904064d0, &
    .0d0,-1.439618d0, -0.904064d0, &
    ! exponents:
    130.709320d0,23.808861d0,6.443608d0,5.033151d0,1.169596d0,0.380389d0, &
    130.709320d0,23.808861d0,6.443608d0,5.033151d0,1.169596d0,0.380389d0, &
    5.033151d0,1.169596d0,0.380389d0, &
    3.425251d0,0.623914d0,0.168855d0, &
    3.425251d0,0.623914d0,0.168855d0, &
    ! coefs:
    15.072747d0,14.577702d0,4.543234d0,.0d0,.0d0,.0d0, &
    .0d0,.0d0,.0d0,-0.848697d0,1.135201d0,0.856753d0, &
    3.429066d0,2.156289d0,0.341592d0, &
    0.981707d0,0.949464d0,0.295906d0, &
    0.981707d0,0.949464d0,0.295906d0 &
  ]
  
  do ibas=1, nbas
    si = CINTcgto_cart(ibas-1, bas)
    do jbas=1, ibas
      sj = CINTcgto_cart(jbas-1, bas)
      print '(a,i0,a,i0,a,i0,a,i0,a)', "ibas=", ibas - 1, " (N=", si, "), jbas=", jbas - 1, " (N=", sj, ")"
      shells = [ibas - 1, jbas - 1]
      call cint1e_ovlp_cart(buff, shells, atm, natm, bas, nbas, env)
      do ielm=1, si
        print '(*(f8.5))', abs(buff(1 + (ielm-1) * si:(ielm-1) * si + min(ielm, sj)))
      enddo
    enddo
  enddo
  
end program test_libcint
