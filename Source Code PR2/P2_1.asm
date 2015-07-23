;===============================================================================================
;
;	Author					: Cytron Technologies
;   Project					: DIY Project
;	Project Descrription	: PR2 (7-Segment)
;	Date					: 26 May 2009
;
;===============================================================================================

;===============================================================================================
; Project Description
;===============================================================================================
;   This file is a basic code template for assembly code generation   
;   on the PICmicro PIC16F84A. This file contains the basic code      
;   building blocks to build upon.                                      
;                                                                     
;   If interrupts are not used all code presented between the ORG     
;   0x004 directive and the label main can be removed. In addition    
;   the variable assignments for 'w_temp' and 'status_temp' can       
;   be removed.                                                                               
;                                                                     
;   Refer to the MPASM User's Guide for additional information on     
;   features of the assembler (Document DS33014).                     
;                                                                    
;   Refer to the respective PICmicro data sheet for additional        
;   information on the instruction set.                               
;                                                                     
;   Template file assembled with MPLAB V8.30.00 and MPASM V5.30.10.   
;  
;================================================================================================                                                                   
       
;================================================================================================
;                                                                     
;    Files required:                                                  
;                                                                     
;================================================================================================                                                                    
;                                                                                                                                         
;    Notes:                                                           
;     1. For beginner, the parts that you need to edit are: BANK, TRIS, PORT, DELAY                                                                 
;     2. All the general I/O pin only can use as input or output with the prior setting at TRIS.                                                                 
;     3. Let say in this case, we use pin 1,2 and 3 (RA2, RA3, RA4) as input and pin 10,11,12 (RB4, RB5, RB6) as output. So, we must 
;        set TRISA,2 TRISA,3 TRISA,4 to '1' and TRISB,4 TRISB,5 TRISB,6 to '0'(in assembly, set '1' we use BSF, set '0' we use BCF
;        which we can write in this way: 
;										BSF 	TRISA,2                                                      
;                                        BSF	TRISA,3
;									     BSF	TRISA,4  
;
; 										 BCF	TRISB,4
;										 BCF	TRISB,5
;										 BCF    TRISB,6
;     4. But, pls remember that before you can change TRISA, you need to switch from BANK0 to BANK1, then switch back to BANK0 after
;        setting the TRISA.BANK0 is used to control the actual operation of the PIC.For example to tell the PIC which bits of Port 
;        are input and which are output.BANK1 is used to manipulated the data. 
;     5. Bare in mind that in programming, we read the input; and write the output. 
;     6. In assembly, to read we use BTFSC or BTFSS; while to write we use MOVLW, MOVWF, CLF, BSF or BCF. (and other type of 
;        insrtuction that you can refer to PIC datasheet)   
;     7. DELAY is a kind of method that we used to use it to delay our PIC for some operation.
;	  8. We already prepare the DELAY subroutine, you just CALL DELAY when you need it.
;     9. You also can change the delay time by changing the value in DELAY subroutine. (the maximum value is 255)          
;
;===================================================================================================


	list      p=16F84A            ; list directive to define processor
	#include <p16F84A.inc>        ; processor specific variable definitions

	__CONFIG   0X3FF2

; '__CONFIG' directive is used to embed configuration data within .asm file.
; The lables following the directive are located in the respective .inc file.
; See respective data sheet for additional information on configuration word.




;============================================================================================ 
; VARIABLE DEFINITION
;============================================================================================

D1			EQU		0X20	;FOR DELAY
D2			EQU		0X21	;FOR DELAY
D3			EQU		0X22	;FOR DELAY



;===========================================================================================
; WRITE YOUR PROGRAM HERE
;===========================================================================================
		ORG     0x000             ; processor reset vector
  		goto    main              ; go to beginning of program

main

; initialize of your PIC, setting the general I/O in TRIS		

		BSF		STATUS,5				;SWITCH TO BANK1 ;BIT 5 OF STATUS REGISTER IS SET TO 1
		CLRF	TRISB					;SET PORTB AS OUTPUT
		BSF		TRISA,2					;SET RA2 AS INPUT
		BSF		TRISA,3					;SET RA3 AS INPUT
		BSF		TRISA,4					;SET RA4 AS INPUT
		BCF		STATUS,5				;SWITCH TO BANK0 ;BIT 5 OF STATUS REGISTER IS SET TO 0

		MOVLW	B'11111111'
		MOVWF	PORTB					;SET ALL 8 PIN IN PORTB TO HIGH(1)

;the main program begin here

START
		MOVLW		B'11110000'			;DISPLAY '0'
		MOVWF		PORTB
		CALL		DELAY
		MOVLW		B'11110001'			;DISPLAY '1'
		MOVWF		PORTB
		CALL		DELAY
		MOVLW		B'11110010'			;DISPLAY '2'		
		MOVWF		PORTB
		CALL		DELAY
		MOVLW		B'11110011'			;DISPLAY '3'
		MOVWF		PORTB
		CALL		DELAY
		MOVLW		B'11110100'			;DISPLAY '4'
		MOVWF		PORTB
		CALL		DELAY
		MOVLW		B'11110101'			;DISPLAY '5'
		MOVWF		PORTB
		CALL		DELAY
		MOVLW		B'11110110'			;DISPLAY '6'
		MOVWF		PORTB
		CALL		DELAY
		MOVLW		B'11110111'			;DISPLAY '7'
		MOVWF		PORTB
		CALL		DELAY
		MOVLW		B'11111000'			;DISPLAY '8'
		MOVWF		PORTB
		CALL		DELAY
		MOVLW		B'11111001'			;DISPLAY '9'
		MOVWF		PORTB
		CALL		DELAY
		GOTO		START				;after display'9',program will jump to START subroutine to display '0'
										;untill reset button pressed.



;================================================================================================
; DELAY SUBROUTINE
;================================================================================================
DELAY		MOVLW	D'255'			;PAUSE FOR ABOUT 500mS (u can change the 200, 3, 1 value to obtain different delay timing)
			MOVWF	D3
			MOVLW	D'150'
			MOVWF	D2
			MOVLW	D'20'
			MOVWF	D1
			DECFSZ	D1
			GOTO	$-1
			DECFSZ	D2
			GOTO	$-5
			DECFSZ	D3
			GOTO	$-9
			RETURN


	    	END                     ; directive 'end of program'

