C> @file
C> @author WOOLLEN @date 2012-09-15
      
C> SETBMISS WILL ALLOW AN APPLICATION TO DEFINE THE SPECIAL
C>           VALUE "BMISS" WHICH DENOTES MISSING VALUES BOTH FOR READING
C>           FROM BUFR FILES AND FOR WRITING TO BUFR FILES. THE DEFAULT
C>           BUFRLIB MISSING VALUE IS SET TO 10E10 IN SUBROUTINE BFRINI.
C>
C> PROGRAM HISTORY LOG:
C> 2012-09-15  J. WOOLLEN -- ORIGINAL AUTHOR
C>
C> USAGE:    CALL SETBMISS(XMISS)
C>
C>   INPUT ARGUMENTS:
C>     XMISS - REAL*8 MISSING VALUE TO BE USED
C>
C>   OUTPUT ARGUMENTS:
C>
C> REMARKS:
C>    THIS ROUTINE CALLS: OPENBF
C>
C>    THIS ROUTINE IS CALLED BY: None
C>                               (Normally called only by application
C>                               programs)
C>
      SUBROUTINE SETBMISS(XMISS)



      INCLUDE 'burflib.inc'

      REAL*8 XMISS

c-----------------------------------------------------------------------
c-----------------------------------------------------------------------

      CALL OPENBF(0,'FIRST',0)

      BMISS = XMISS

      RETURN
      END
