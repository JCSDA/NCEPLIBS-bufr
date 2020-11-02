C> @file
C> @author WOOLLEN @date 1994-01-06
      
C> THIS FUNCTION DECODES A REAL NUMBER FROM A CHARACTER
C>   STRING.  IF THE DECODE FAILS, THEN THE VALUE BMISS IS
C>   RETURNED.  NOTE THAT, UNLIKE FOR SUBROUTINE STRNUM, THE INPUT
C>   STRING MAY CONTAIN A LEADING SIGN CHARACTER (E.G. '+', '-').
C>
C> PROGRAM HISTORY LOG:
C> 1994-01-06  J. WOOLLEN -- ORIGINAL AUTHOR
C> 1998-07-08  J. WOOLLEN -- REPLACED CALL TO CRAY LIBRARY ROUTINE
C>                           "ABORT" WITH CALL TO NEW INTERNAL BUFRLIB
C>                           ROUTINE "BORT"
C> 1999-11-18  J. WOOLLEN -- RENAMED THIS FUNCTION FROM "VAL$" TO "VALX"
C>                           TO REMOVE THE POSSIBILITY OF THE "$" SYMBOL
C>                           CAUSING PROBLEMS ON OTHER PLATFORMS
C> 2003-11-04  J. ATOR    -- ADDED DOCUMENTATION
C> 2003-11-04  S. BENDER  -- ADDED REMARKS/BUFRLIB ROUTINE
C>                           INTERDEPENDENCIES
C> 2003-11-04  D. KEYSER  -- UNIFIED/PORTABLE FOR WRF; ADDED HISTORY
C>                           DOCUMENTATION; OUTPUTS MORE COMPLETE
C>                           DIAGNOSTIC INFO WHEN ROUTINE TERMINATES
C>                           ABNORMALLY; CHANGED CALL FROM BORT TO BORT2
C> 2009-04-21  J. ATOR    -- USE ERRWRT
C>
C> USAGE:    VALX (STR)
C>   INPUT ARGUMENT LIST:
C>     STR      - CHARACTER*(*): STRING CONTAINING ENCODED REAL VALUE
C>
C>   OUTPUT ARGUMENT LIST:
C>     VALX     - REAL: DECODED VALUE
C>
C> REMARKS:
C>    THIS ROUTINE CALLS:        BORT2    ERRWRT   RJUST
C>    THIS ROUTINE IS CALLED BY: GETTBH   NEMTBB   UPFTBV
C>                               Normally not called by any application
C>                               programs but it could be.
C>
      FUNCTION VALX(STR)



      INCLUDE 'burflib.inc'

      CHARACTER*(*) STR
      CHARACTER*128 BORT_STR1,BORT_STR2
      CHARACTER*99  BSTR
      CHARACTER*8   FMT

      COMMON /QUIET / IPRT

C----------------------------------------------------------------------
C----------------------------------------------------------------------

      LENS = LEN(STR)
      IF(LENS.GT.99) GOTO 900
      BSTR(1:LENS) = STR
      RJ = RJUST(BSTR(1:LENS))
      WRITE(FMT,'(''(F'',I2,''.0)'')') LENS
      VALX = BMISS
      READ(BSTR,FMT,ERR=800) VAL
      VALX = VAL
      GOTO 100
800   IF(IPRT.GE.0) THEN
      CALL ERRWRT('+++++++++++++++++++++WARNING+++++++++++++++++++++++')
      CALL ERRWRT('BUFRLIB: VALX - ERROR READING STRING:')
      CALL ERRWRT(BSTR(1:LENS))
      CALL ERRWRT('RETURN WITH VALX = MISSING')
      CALL ERRWRT('+++++++++++++++++++++WARNING+++++++++++++++++++++++')
      CALL ERRWRT(' ')
      ENDIF

C  EXITS
C  -----

100   RETURN
900   WRITE(BORT_STR1,'("STRING IS: ",A)') STR
      WRITE(BORT_STR2,'("BUFRLIB: VALX - STRING LENGTH EXCEEDS LIMIT '//
     . ' OF 99 CHARACTERS")')
      CALL BORT2(BORT_STR1,BORT_STR2)
      END
