	SUBROUTINE NEMDEFS ( LUNIT, NEMO, CELEM, CUNIT, IRET )

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    NEMDEFS
C   PRGMMR: J. ATOR          ORG: NP12       DATE: 2014-10-02
C
C ABSTRACT:  GIVEN A TABLE B MNEMONIC, THIS SUBROUTINE RETURNS THE
C   ELEMENT NAME AND UNITS ASSOCIATED WITH THAT MNEMONIC.  THIS
C   SUBROUTINE CAN BE CALLED AT ANY TIME FOLLOWING THE CALL TO BUFR
C   ARCHIVE LIBRARY SUBROUTINE OPENBF FOR THE ASSOCIATED LUNIT.
C
C PROGRAM HISTORY LOG:
C 2014-10-02  J. ATOR    -- ORIGINAL VERSION
C 2014-12-10  J. ATOR    -- USE MODULES INSTEAD OF COMMON BLOCKS
C
C USAGE:    CALL NEMDEFS (LUNIT, NEMO, CELEM, CUNIT, IRET )
C   INPUT ARGUMENT LIST:
C     LUNIT    - INTEGER: FORTRAN LOGICAL UNIT NUMBER FOR BUFR FILE
C     NEMO     - CHARACTER*(*): TABLE B MNEMONIC
C
C   OUTPUT ARGUMENT LIST:
C     CELEM    - CHARACTER*55: ELEMENT NAME ASSOCIATED WITH NEMO
C     CUNIT    - CHARACTER*24: UNITS ASSOCIATED WITH NEMO
C     IRET     - INTEGER: RETURN CODE
C                   0 = NORMAL RETURN
C                  -1 = REQUESTED MNEMONIC COULD NOT BE FOUND, OR SOME
C                       OTHER ERROR OCCURRED
C
C REMARKS:
C    THIS ROUTINE CALLS:        NEMTAB   STATUS
C    THIS ROUTINE IS CALLED BY: None
C                               Normally called only by application
C                               programs
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 77
C   MACHINE:  PORTABLE TO ALL PLATFORMS
C
C$$$

	USE MODA_TABABD

	INCLUDE 'bufrlib.prm'

	CHARACTER*1   TAB

	CHARACTER*(*) NEMO, CELEM, CUNIT

C----------------------------------------------------------------------
C----------------------------------------------------------------------

	IRET = -1

C	Get LUN from LUNIT.

	CALL STATUS( LUNIT, LUN, IL, IM )
	IF ( IL .EQ. 0 ) RETURN

C	Find the requested mnemonic in the internal Table B arrays.

	CALL NEMTAB( LUN, NEMO, IDN, TAB, ILOC )
	IF ( ( ILOC .EQ. 0 ) .OR. ( TAB .NE. 'B' ) ) RETURN

C	Get the element name and units of the requested mnemonic.

	CELEM = ' '
	LS = MIN(LEN(CELEM),55)
	CELEM(1:LS) = TABB(ILOC,LUN)(16:15+LS)

	CUNIT = ' '
	LS = MIN(LEN(CUNIT),24)
	CUNIT(1:LS) = TABB(ILOC,LUN)(71:70+LS)

	IRET = 0

	RETURN
	END