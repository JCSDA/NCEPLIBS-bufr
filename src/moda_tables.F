	MODULE MODA_TABLES

#ifndef MAXJL_H
#define MAXJL_H
	  USE MODV_MAXJL
#endif

	  INTEGER :: MAXTAB
	  INTEGER :: NTAB
#ifdef DYNAMIC_ALLOCATION
	  CHARACTER*10, ALLOCATABLE :: TAG(:)
	  CHARACTER*3, ALLOCATABLE :: TYP(:)
	  INTEGER, ALLOCATABLE :: KNT(:)
	  INTEGER, ALLOCATABLE :: JUMP(:) 
	  INTEGER, ALLOCATABLE :: LINK(:)
	  INTEGER, ALLOCATABLE :: JMPB(:)
	  INTEGER, ALLOCATABLE :: IBT(:)
	  INTEGER, ALLOCATABLE :: IRF(:)
	  INTEGER, ALLOCATABLE :: ISC(:)
	  INTEGER, ALLOCATABLE :: ITP(:)
	  REAL*8, ALLOCATABLE :: VALI(:)
	  INTEGER, ALLOCATABLE :: KNTI(:)
	  INTEGER, ALLOCATABLE :: ISEQ(:,:)
	  INTEGER, ALLOCATABLE :: JSEQ(:)
#else
	  CHARACTER*10 :: TAG(MAXJL)
	  CHARACTER*3 :: TYP(MAXJL)
	  INTEGER :: KNT(MAXJL)
	  INTEGER :: JUMP(MAXJL) 
	  INTEGER :: LINK(MAXJL)
	  INTEGER :: JMPB(MAXJL)
	  INTEGER :: IBT(MAXJL)
	  INTEGER :: IRF(MAXJL)
	  INTEGER :: ISC(MAXJL)
	  INTEGER :: ITP(MAXJL)
	  REAL*8 :: VALI(MAXJL)
	  INTEGER :: KNTI(MAXJL)
	  INTEGER :: ISEQ(MAXJL,2)
	  INTEGER :: JSEQ(MAXJL)
#endif

	END MODULE
