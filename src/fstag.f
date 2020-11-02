C> @file
C> @author J @date 2014-10-02
	
C> THIS SUBROUTINE FINDS THE (NUTAG)th OCCURRENCE OF MNEMONIC
C>  UTAG WITHIN THE CURRENT OVERALL SUBSET DEFINITION, STARTING FROM
C>  PARAMETER #(NIN) WITHIN THE SUBSET.  THE SUBROUTINE SEARCHES FORWARD
C>  FROM NIN IF NUTAG IS POSITIVE OR ELSE BACKWARD IF NUTAG IS NEGATIVE.
C>
C> PROGRAM HISTORY LOG:
C> 2014-10-02  J. ATOR    -- ORIGINAL AUTHOR
C> 2014-12-10  J. ATOR    -- USE MODULES INSTEAD OF COMMON BLOCKS
C>
C> USAGE:    CALL FSTAG (LUN, UTAG, NUTAG, NIN, NOUT, IRET)
C>   INPUT ARGUMENT LIST:
C>     LUN      - INTEGER: I/O STREAM INDEX INTO INTERNAL MEMORY ARRAYS
C>     UTAG     - CHARACTER*(*): MNEMONIC
C>     NUTAG    - INTEGER: ORDINAL OCCURRENCE OF UTAG TO SEARCH FOR
C>                WITHIN THE OVERALL SUBSET DEFINITION, COUNTING FROM
C>                PARAMETER #(NIN) WITHIN THE SUBSET.  THE SUBROUTINE
C>                WILL SEARCH IN A FORWARD DIRECTION FROM PARAMETER
C>                #(NIN) IF NUTAG IS POSITIVE OR ELSE IN A BACKWARD
C>                DIRECTION IF NUTAG IS NEGATIVE.
C>     NIN      - INTEGER: LOCATION WITHIN THE OVERALL SUBSET DEFINITION
C>                FROM WHICH TO BEGIN SEARCHING FOR UTAG.
C>
C>   OUTPUT ARGUMENT LIST:
C>     NOUT     - INTEGER: LOCATION OF (NUTAG)th OCCURRENCE OF UTAG
C>     IRET     - INTEGER: RETURN CODE
C>                   0 = NORMAL RETURN
C>                  -1 = REQUESTED MNEMONIC COULD NOT BE FOUND, OR SOME
C>                       OTHER ERROR OCCURRED
C>
C> REMARKS:
C>    THIS ROUTINE CALLS:        PARSTR
C>    THIS ROUTINE IS CALLED BY: GETTAGPR GETTAGRE GETVALNB NEMSPECS
C>                               SETVALNB UFDUMP
C>                               Normally not called by any application
C>                               programs.
C>
	SUBROUTINE FSTAG ( LUN, UTAG, NUTAG, NIN, NOUT, IRET )



	USE MODA_USRINT
	USE MODA_TABLES

	INCLUDE 'burflib.inc'

	CHARACTER*10  TGS(15)

	CHARACTER*(*) UTAG

	DATA MAXTG  /15/

C----------------------------------------------------------------------
C----------------------------------------------------------------------

	IRET = -1

C	Confirm that there is only one mnemonic in the input string.

	CALL PARSTR( UTAG, TGS, MAXTG, NTG, ' ', .TRUE. )
	IF ( NTG .NE .1 ) RETURN

C	Starting from NIN, search either forward or backward for the
C	(NUTAG)th occurrence of UTAG.

	IF ( NUTAG .EQ. 0 ) RETURN
	ISTEP = ISIGN( 1, NUTAG )
	ITAGCT = 0
	NOUT = NIN + ISTEP
	DO WHILE ( ( NOUT .GE. 1 ) .AND. ( NOUT .LE. NVAL(LUN) ) )
	    IF ( TGS(1) .EQ. TAG(INV(NOUT,LUN)) ) THEN
		ITAGCT = ITAGCT + 1
		IF ( ITAGCT .EQ. IABS(NUTAG) ) THEN
		    IRET = 0
		    RETURN 
		ENDIF
	    ENDIF
	    NOUT = NOUT + ISTEP
	ENDDO
	    
	RETURN
	END
