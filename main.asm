;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;
;
;-------------------------------------------------------------------------------
      .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
      .def    RESET                   ; Export program entry-point to
                                      ; make it known to linker.
;-------------------------------------------------------------------------------
      .text                           ; Assemble into program memory.
      .retain                         ; Override ELF conditional linking
                                      ; and retain current section.
      .retainrefs                     ; And retain any sections that have
                                      ; references to current section.

;-------------------------------------------------------------------------------
RESET    mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT  mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer


;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------

init:        bis.b #01h, &P1DIR         ;Set P1.0 as output 
		bic.b #01h, &P1OUT         ;Initializing P1.0 as ‘0’(LED is OFF) 
		CLR.w P2OUT                ; Clearing the port2
		mov.b #0FFh, &P2DIR        ;Set P2 as input 
		bis.b #BIT2, &P1SEL0       ;
		bis.b #BIT2, &P1SEL1       ;(SEL0,SEL1) = 11  P1 is analog input
		bic.w #0001h, &PM5CTL0     ;GPIO Power ON (to remove from high impedance state)
		mov.w   #0210h, &ADCCTL0   ; Configure ADC0: ADC is ON, ADC Sample and hold(16 ADC Clock cycle),Conversion is disabled 
		mov.w   #0220h, &ADCCTL1     ; Configure ADC1
		mov.w   #0020h, &ADCCTL2     ; Configure ADC2
		mov.w   #0002h, &ADCMCTL0    ; Configure ADCCM

convert:
		mov.w   #0213h, &ADCCTL0     ; Enable and start conversion 
here:
		bit.w   #BIT0, &ADCIFG
		jz here                      ; Wait until conversion is complete
		mov.w ADCMEM0, P2OUT         ; Move the value in MEMO to P2 (LED Output)
		jmp  convert                    ; Jump to convert
		nop                             ; No operation
                                                                     
;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
      .global __STACK_END
      .sect   .stack
            
;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
       .sect   ".reset"                ; MSP430 RESET Vector
       .short  RESET
