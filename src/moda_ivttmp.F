	MODULE MODA_IVTTMP

#ifndef MAXJL_H
#define MAXJL_H
	  USE MODV_MAXJL
#endif

#ifdef DYNAMIC_ALLOCATION
	  CHARACTER*10, ALLOCATABLE :: TTMP(:)
	  INTEGER, ALLOCATABLE :: ITMP(:) 
	  REAL*8, ALLOCATABLE :: VTMP(:)
#else
	  CHARACTER*10 :: TTMP(MAXJL)
	  INTEGER :: ITMP(MAXJL) 
	  REAL*8 :: VTMP(MAXJL)
#endif

	END MODULE
