# 1 "ardllocf.F"
	SUBROUTINE ARDLLOCF

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    ARDLLOCF
C   PRGMMR: ATOR             ORG: NP12       DATE: 2014-12-04
C
C ABSTRACT:  THIS SUBROUTINE FREES ANY MEMORY THAT WAS DYNAMICALLY
C   ALLOCATED BY PREVIOUS CALLS TO BUFR ARCHIVE LIBRARY ROUTINES
C   ARALLOCF OR ARALLOCC.
C
C   NOTE THAT THIS SUBROUTINE IS CALLED WITHIN BUFR ARCHIVE LIBRARY
C   SUBROUTINE EXITBUFR AS PART OF THE PROCESS TO RESET THE LIBRARY AND
C   PREPARE IT FOR POTENTIAL RE-ALLOCATION OF NEW ARRAY SPACE VIA ONE OR
C   MORE SUBSEQUENT CALLS TO SUBROUTINES ISETPRM AND OPENBF.  THIS
C   SUBROUTINE SHOULD ONLY BE CALLED DIRECTLY BY AN APPLICATION PROGRAM
C   IF THE PROGRAM IS COMPLETELY FINISHED WITH ALL CALLS TO ALL OTHER
C   BUFR ARCHIVE LIBRARY ROUTINES, BECAUSE THE MEMORY FREED HEREIN WILL
C   RENDER THE LIBRARY AS EFFECTIVELY UNUSABLE FOR THE REMAINDER OF THE
C   LIFE OF THE APPLICATION PROGRAM.  HOWEVER, THIS MAY BE A USEFUL
C   OPTION FOR APPLICATION PROGRAMS WHICH WANT TO MOVE ON TO OTHER
C   UNRELATED TASKS WITHOUT CONTINUING TO TIE UP A SIGNIFICANT AMOUNT
C   OF DYNAMICALLY-ALLOCATED HEAP MEMORY RELATED TO THIS LIBRARY.
C   OTHERWISE, ALL SUCH MEMORY WILL BE FREED AUTOMATICALLY ONCE THE
C   APPLICATION PROGRAM TERMINATES.
C
C PROGRAM HISTORY LOG:
C 2014-12-04  J. ATOR    -- ORIGINAL AUTHOR
C
C USAGE:    CALL ARDLLOCF
C
C REMARKS:
C    THIS ROUTINE CALLS:        ARDLLOCC
C    THIS ROUTINE IS CALLED BY: EXITBUFR
C                               Also called by application programs.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN
C   MACHINE:  PORTABLE TO ALL PLATFORMS
C
C$$$

# 290


	RETURN
	END
