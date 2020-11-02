C> @file
C> @author WOOLLEN @date 1994-01-06
      
C> THIS SUBROUTINE RETURNS THE BIT-WISE REPRESENTATION OF THE
C>   FXY VALUE CORRESPONDING TO, SEQUENTIALLY, A PARTICULAR (IENT'th)
C>   "CHILD" MNEMONIC OF A TABLE D SEQUENCE ("PARENT") MNEMONIC.
C>
C> PROGRAM HISTORY LOG:
C> 1994-01-06  J. WOOLLEN -- ORIGINAL AUTHOR
C> 1995-06-28  J. WOOLLEN -- INCREASED THE SIZE OF INTERNAL BUFR TABLE
C>                           ARRAYS IN ORDER TO HANDLE BIGGER FILES
C> 1998-07-08  J. WOOLLEN -- REPLACED CALL TO CRAY LIBRARY ROUTINE
C>                           "ABORT" WITH CALL TO NEW INTERNAL BUFRLIB
C>                           ROUTINE "BORT"
C> 1999-11-18  J. WOOLLEN -- THE NUMBER OF BUFR FILES WHICH CAN BE
C>                           OPENED AT ONE TIME INCREASED FROM 10 TO 32
C>                           (NECESSARY IN ORDER TO PROCESS MULTIPLE
C>                           BUFR FILES UNDER THE MPI)
C> 2003-11-04  J. ATOR    -- ADDED DOCUMENTATION
C> 2003-11-04  S. BENDER  -- ADDED REMARKS/BUFRLIB ROUTINE
C>                           INTERDEPENDENCIES
C> 2003-11-04  D. KEYSER  -- UNIFIED/PORTABLE FOR WRF; ADDED HISTORY
C>                           DOCUMENTATION; OUTPUTS MORE COMPLETE
C>                           DIAGNOSTIC INFO WHEN ROUTINE TERMINATES
C>                           ABNORMALLY
C> 2014-12-10  J. ATOR    -- USE MODULES INSTEAD OF COMMON BLOCKS
C>
C> USAGE:    CALL UPTDD (ID, LUN, IENT, IRET)
C>   INPUT ARGUMENT LIST:
C>     ID       - INTEGER: POSITIONAL INDEX OF PARENT MNEMONIC WITHIN
C>                INTERNAL BUFR TABLE D ARRAY TABD
C>     LUN      - INTEGER: I/O STREAM INDEX INTO INTERNAL MEMORY ARRAYS
C>     IENT     - INTEGER: ORDINAL INDICATOR OF CHILD MNEMONIC TO RETURN
C>                FROM WITHIN TABD(ID,LUN) SEQUENCE:
C>                       0 = return a count of the total number of child
C>                           mnemonics within TABD(ID,LUN)
C>
C>   OUTPUT ARGUMENT LIST:
C>     IRET     - INTEGER: RETURN VALUE (SEE REMARKS)
C>
C> REMARKS:
C>    THE INTERPRETATION OF THE RETURN VALUE IRET DEPENDS UPON THE INPUT
C>    VALUE IENT, AS FOLLOWS:
C>
C>    IF ( IENT = 0 ) THEN
C>       IRET = a count of the total number of child mnemonics within
C>              TABD(ID,LUN)
C>    ELSE
C>       IRET = the bit-wise representation of the FXY value
C>              corresponding to the IENT'th child mnemonic of
C>              TABD(ID,LUN)
C>    END IF
C>
C>
C>    THIS ROUTINE CALLS:        BORT     IUPM
C>    THIS ROUTINE IS CALLED BY: NEMTBD   RESTD
C>                               Normally not called by any application
C>                               programs.
C>
      SUBROUTINE UPTDD(ID,LUN,IENT,IRET)



      USE MODA_TABABD

      INCLUDE 'burflib.inc'

      COMMON /DXTAB / MAXDX,IDXV,NXSTR(10),LDXA(10),LDXB(10),LDXD(10),
     .                LD30(10),DXSTR(10)

      CHARACTER*128 BORT_STR
      CHARACTER*56  DXSTR

C-----------------------------------------------------------------------
C-----------------------------------------------------------------------

      LDD = LDXD(IDXV+1)+1

C  CHECK IF IENT IS IN BOUNDS
C  --------------------------

      NDSC = IUPM(TABD(ID,LUN)(LDD:LDD),8)

      IF(IENT.EQ.0) THEN
         IRET = NDSC
         GOTO 100
      ELSEIF(IENT.LT.0 .OR. IENT.GT.NDSC) THEN
         GOTO 900
      ENDIF

C  RETURN THE DESCRIPTOR INDICATED BY IENT
C  ---------------------------------------

      IDSC = LDD+1 + (IENT-1)*2
      IRET = IUPM(TABD(ID,LUN)(IDSC:IDSC),16)

C  EXITS
C  -----

100   RETURN
900   WRITE(BORT_STR,'("BUFRLIB: UPTDD - VALUE OF THIRD ARGUMENT IENT'//
     . ' (INPUT) IS OUT OF RANGE (IENT =",I4,")")') IENT
      CALL BORT(BORT_STR)
      END
