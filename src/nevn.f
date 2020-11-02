C> @file
C> @author WOOLLEN @date 2003-11-04
      
C> THIS FUNCTION LOOKS FOR ALL STACKED DATA EVENTS FOR A
C>   SPECIFIED DATA VALUE AND LEVEL WITHIN THE PORTION OF THE CURRENT
C>   SUBSET BUFFER BOUNDED BY THE INDICES INV1 AND INV2.  ALL SUCH
C>   EVENTS ARE ACCUMULATED AND RETURNED TO THE CALLING PROGRAM WITHIN
C>   ARRAY USR.  THE VALUE OF THE FUNCTION ITSELF IS THE TOTAL NUMBER
C>   OF EVENTS FOUND.
C>
C> PROGRAM HISTORY LOG:
C> 2003-11-04  J. WOOLLEN -- ORIGINAL AUTHOR (WAS IN VERIFICATION
C>                           VERSION)
C> 2003-11-04  D. KEYSER  -- UNIFIED/PORTABLE FOR WRF; ADDED
C>                           DOCUMENTATION (INCLUDING HISTORY); OUTPUTS
C>                           MORE COMPLETE DIAGNOSTIC INFO WHEN ROUTINE
C>                           TERMINATES ABNORMALLY
C> 2009-03-31  J. WOOLLEN -- ADDED ADDITIONAL DOCUMENTATION
C> 2014-12-10  J. ATOR    -- USE MODULES INSTEAD OF COMMON BLOCKS
C>
C> USAGE:    NEVN (NODE, LUN, INV1, INV2, I1, I2, I3, USR)
C>   INPUT ARGUMENT LIST:
C>     NODE     - INTEGER: JUMP/LINK TABLE INDEX OF NODE TO RETURN
C>                STACKED VALUES FOR
C>     LUN      - INTEGER: I/O STREAM INDEX INTO INTERNAL MEMORY ARRAYS
C>     INV1     - INTEGER: STARTING INDEX OF THE PORTION OF THE SUBSET
C>                BUFFER IN WHICH TO LOOK FOR STACK VALUES
C>     INV2     - INTEGER: ENDING INDEX OF THE PORTION OF THE SUBSET
C>                BUFFER IN WHICH TO LOOK FOR STACK VALUES
C>     I1       - INTEGER: LENGTH OF FIRST DIMENSION OF USR
C>     I2       - INTEGER: LENGTH OF SECOND DIMENSION OF USR
C>     I3       - INTEGER: LENGTH OF THIRD DIMENSION OF USR
C>
C>   OUTPUT ARGUMENT LIST:
C>     USR      - REAL*8:(I1,I2,I3) STARTING ADDRESS OF DATA VALUES READ
C>                FROM DATA SUBSET, EVENTS ARE RETURNED IN THE THIRD
C>                DIMENSION FOR A PARTICULAR DATA VALUE AND LEVEL IN THE
C>                FIRST AND SECOND DIMENSIONS
C>     NEVN     - INTEGER: NUMBER OF EVENTS IN STACK (MUST BE LESS THAN
C>                OR EQUAL TO I3)
C>
C> REMARKS:
C>    IMPORTANT: THIS ROUTINE SHOULD ONLY BE CALLED BY ROUTINE UFBIN3,
C>               WHICH, ITSELF, IS CALLED ONLY BY VERIFICATION
C>               APPLICATION PROGRAM GRIDTOBS, WHERE IT WAS PREVIOUSLY
C>               AN IN-LINE SUBROUTINE.  IN GENERAL, NEVN DOES NOT WORK
C>               PROPERLY IN OTHER APPLICATION PROGRAMS AT THIS TIME.
C>
C>    THIS ROUTINE CALLS:        BORT     INVWIN   LSTJPB
C>    THIS ROUTINE IS CALLED BY: UFBIN3
C>                               Should NOT be called by any
C>                               application programs!!!
C>
      FUNCTION NEVN(NODE,LUN,INV1,INV2,I1,I2,I3,USR)



      USE MODA_USRINT

      INCLUDE 'burflib.inc'

      CHARACTER*128 BORT_STR
      DIMENSION     USR(I1,I2,I3)
      REAL*8        USR

C----------------------------------------------------------------------
C----------------------------------------------------------------------

      NEVN = 0

C  FIND THE ENCLOSING EVENT STACK DESCRIPTOR
C  -----------------------------------------

      NDRS = LSTJPB(NODE,LUN,'DRS')
      IF(NDRS.LE.0) GOTO 100

      INVN = INVWIN(NDRS,LUN,INV1,INV2)
      IF(INVN.EQ.0) GOTO 900

      NEVN = VAL(INVN,LUN)
      IF(NEVN.GT.I3) GOTO 901

C  SEARCH EACH STACK LEVEL FOR THE REQUESTED NODE AND COPY THE VALUE
C  -----------------------------------------------------------------

      N2 = INVN + 1

      DO L=1,NEVN
        N1 = N2
        N2 = N2 + VAL(N1,LUN)
        DO N=N1,N2
        IF(INV(N,LUN).EQ.NODE) USR(1,1,L) = VAL(N,LUN)
        ENDDO
      ENDDO

C  EXITS
C  -----

100   RETURN
900   CALL BORT('BUFRLIB: NEVN - CAN''T FIND THE EVENT STACK!!!!!!')
901   WRITE(BORT_STR,'("BUFRLIB: NEVN - THE NO. OF EVENTS FOR THE '//
     . 'REQUESTED STACK (",I3,") EXCEEDS THE VALUE OF THE 3RD DIM. OF'//
     . ' THE USR ARRAY (",I3,")")') NEVN,I3
      CALL BORT(BORT_STR)
      END
