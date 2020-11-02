C> @file
C> @author WOOLLEN @date 1994-01-06
      
C> THIS SUBROUTINE OPENS AND INITIALIZES A NEW BUFR MESSAGE
C>   WITHIN MEMORY.  IT SHOULD ONLY BE CALLED WHEN LOGICAL UNIT LUNIT
C>   HAS BEEN OPENED FOR OUTPUT OPERATIONS.  IT IS SIMILAR TO BUFR
C>   ARCHIVE LIBRARY SUBROUTINE OPENMG, HOWEVER UNLIKE OPENMG, IT WILL
C>   NOT OPEN A NEW MESSAGE IF THERE IS ALREADY A BUFR MESSAGE OPEN
C>   WITHIN MEMORY FOR THIS LUNIT WHICH HAS THE SAME SUBSET AND JDATE
C>   VALUES (IN WHICH CASE IT DOES NOTHING AND RETURNS TO THE CALLING
C>   ROUTINE/PROGRAM).  OTHERWISE, IF THERE IS ALREADY A BUFR MESSAGE
C>   OPEN WITHIN MEMORY FOR THIS LUNIT BUT WHICH HAS A DIFFERENT SUBSET
C>   OR JDATE VALUE, THEN THAT MESSAGE WILL BE CLOSED AND FLUSHED TO
C>   LUNIT BEFORE OPENING THE NEW ONE.
C>
C> PROGRAM HISTORY LOG:
C> 1994-01-06  J. WOOLLEN -- ORIGINAL AUTHOR
C> 1998-07-08  J. WOOLLEN -- REPLACED CALL TO CRAY LIBRARY ROUTINE
C>                           "ABORT" WITH CALL TO NEW INTERNAL BUFRLIB
C>                           ROUTINE "BORT"; MODIFIED TO MAKE Y2K
C>                           COMPLIANT
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
C> USAGE:    CALL OPENMB (LUNIT, SUBSET, JDATE)
C>   INPUT ARGUMENT LIST:
C>     LUNIT    - INTEGER: FORTRAN LOGICAL UNIT NUMBER FOR BUFR FILE
C>     SUBSET   - CHARACTER*(*): TABLE A MNEMONIC FOR TYPE OF BUFR MESSAGE
C>                BEING OPENED
C>     JDATE    - INTEGER: DATE-TIME STORED WITHIN SECTION 1 OF BUFR
C>                MESSAGE BEING OPENED, IN FORMAT OF EITHER YYMMDDHH OR
C>                YYYYMMDDHH, DEPENDING ON DATELEN() VALUE
C>
C> REMARKS:
C>    THIS ROUTINE CALLS:        BORT     CLOSMG   I4DY     MSGINI
C>                               NEMTBA   STATUS   USRTPL   WTSTAT
C>    THIS ROUTINE IS CALLED BY: None
C>                               Normally called only by application
C>                               programs.
C>
      SUBROUTINE OPENMB(LUNIT,SUBSET,JDATE)



      USE MODA_MSGCWD

      INCLUDE 'burflib.inc'

      CHARACTER*(*) SUBSET
      LOGICAL       OPEN

C-----------------------------------------------------------------------
C-----------------------------------------------------------------------

C  CHECK THE FILE STATUS
C  ---------------------

      CALL STATUS(LUNIT,LUN,IL,IM)
      IF(IL.EQ.0) GOTO 900
      IF(IL.LT.0) GOTO 901

C  GET SOME SUBSET PARTICULARS
C  ---------------------------

c  .... Given SUBSET, returns MTYP,MSTB,INOD
      CALL NEMTBA(LUN,SUBSET,MTYP,MSTB,INOD)
      OPEN = IM.EQ.0.OR.INOD.NE.INODE(LUN).OR.I4DY(JDATE).NE.IDATE(LUN)

C  MAYBE(?) OPEN A NEW OR DIFFERENT TYPE OF MESSAGE
C  ------------------------------------------------

      IF(OPEN) THEN
         CALL CLOSMG(LUNIT)
         CALL WTSTAT(LUNIT,LUN,IL, 1)
c  .... Set pos. index for new Tbl A mnem.
         INODE(LUN) = INOD
c  .... Set date for new message
         IDATE(LUN) = I4DY(JDATE)

C  INITIALIZE THE OPEN MESSAGE
C  ---------------------------

         CALL MSGINI(LUN)
         CALL USRTPL(LUN,1,1)
      ENDIF

C  EXITS
C  -----

      RETURN
900   CALL BORT('BUFRLIB: OPENMB - OUTPUT BUFR FILE IS CLOSED, IT '//
     . 'MUST BE OPEN FOR OUTPUT')
901   CALL BORT('BUFRLIB: OPENMB - OUTPUT BUFR FILE IS OPEN FOR '//
     . 'INPUT, IT MUST BE OPEN FOR OUTPUT')
      END
