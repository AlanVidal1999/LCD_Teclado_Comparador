#include "p16F887.inc"  
 	__CONFIG	_CONFIG1,	_INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOR_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF 
 	__CONFIG	_CONFIG2,	_BOR40V & _WRT_OFF
 
RES_VECT CODE 0x0000  
    BCF PORTA,0		
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		
    CALL time
    BCF PORTA,1
    CALL time
  
    GOTO    START                   

MAIN_PROG CODE                      

i EQU 0x20
j EQU 0x21
k EQU 0x25
m EQU 0x26
x equ 0x30
y equ 0x31
z equ 0x32
a equ 0x33 
R1 equ 0x34
R2 equ 0x35
AUX equ 0x36
ENTER equ 0x37

START

    BANKSEL PORTA ;
    CLRF PORTA 
    BANKSEL ANSEL ;
    CLRF ANSEL 
    CLRF ANSELH
    BANKSEL TRISA ;
    CLRF TRISA
    CLRF TRISB
    MOVLW b'11111111'
    MOVWF TRISC
    CLRF TRISD
    CLRF TRISE
    BCF STATUS,RP1
    BCF STATUS,RP0
    GOTO INICIO
    
INITLCD
    CLRF PORTA
    CLRF PORTB
    CLRF PORTC
    CLRF PORTD
    CLRF PORTE
    CLRF ENTER
    CLRF R1
    CLRF R2
    CLRF AUX
    BCF PORTA,0		;reset
    MOVLW 0x01
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    
    MOVLW 0x0C		;first line
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
         
    MOVLW 0x3C		;cursor mode
    MOVWF PORTB
    
    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
INICIO	  
    CALL INITLCD
    CALL Interfaz
    CALL Renglon_1
    BTFSS ENTER, 0
    GOTO $-2
    CLRF ENTER
    CALL Renglon_2
    BTFSS ENTER, 0
    GOTO $-2
    CALL Comparar
    
    BSF PORTD, 0
    BTFSS PORTC, 3
    GOTO $-1
    CALL NUMERO_1
    BCF PORTD, 0
    
    GOTO INICIO

Interfaz:
    
    BCF PORTA,0		
    CALL time
    MOVLW 0x80	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    MOVLW 'u'
    MOVWF PORTB
    CALL exec
    MOVLW 'm'
    MOVWF PORTB
    CALL exec
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    MOVLW 'r'
    MOVWF PORTB
    CALL exec
    MOVLW 'o'
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    MOVLW 'A'
    MOVWF PORTB
    CALL exec
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    BCF PORTA,0		
    CALL time
    MOVLW 0xC0	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW 'N'
    MOVWF PORTB
    CALL exec
    MOVLW 'u'
    MOVWF PORTB
    CALL exec
    MOVLW 'm'
    MOVWF PORTB
    CALL exec
    MOVLW 'e'
    MOVWF PORTB
    CALL exec
    MOVLW 'r'
    MOVWF PORTB
    CALL exec
    MOVLW 'o'
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    MOVLW 'B'
    MOVWF PORTB
    CALL exec
    MOVLW ':'
    MOVWF PORTB
    CALL exec
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    
    MOVLW ' '
    MOVWF PORTB
    CALL exec
    RETURN
    
Comparar:
    MOVFW R1
    SUBWF R2, 0
    BTFSC STATUS, C
    GOTO $+2
    GOTO $+3 
    CALL MENOR_IGUAL
    RETURN
    CALL Mayor
    RETURN
    
Mayor:
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8E	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '>'
    MOVWF PORTB
    CALL exec
    RETURN
    
MENOR_IGUAL:
    
    BTFSC STATUS, Z ; Z = 1
    CALL IGUAL
    BTFSS STATUS, Z ; Z = 0
    CALL MENOR
    RETURN
    
MENOR:
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8E	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '<'
    MOVWF PORTB
    CALL exec
    RETURN
    
IGUAL:
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8E	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '='
    MOVWF PORTB
    CALL exec
    RETURN

Renglon_1:
    BSF PORTD, 2
    BTFSC PORTC, 0
    CALL UNO_1
    BTFSC PORTC, 1
    CALL CUATRO_1
    BTFSC PORTC, 2
    CALL SIETE_1
    BCF PORTD, 2
    
    BSF PORTD, 1
    BTFSC PORTC, 0
    CALL DOS_1
    BTFSC PORTC, 1
    CALL CINCO_1
    BTFSC PORTC, 2
    CALL OCHO_1
    BTFSC PORTC, 3
    CALL CERO_1
    BCF PORTD, 1
    
    BSF PORTD, 0
    BTFSC PORTC, 0
    CALL TRES_1
    BTFSC PORTC, 1
    CALL SEIS_1
    BTFSC PORTC, 2
    CALL NUEVE_1
    BTFSC PORTC, 3
    CALL NUMERO_1
    BCF PORTD, 0
    
    RETURN
    
NUMERO_1:
    BSF ENTER, 0
    BTFSC PORTC, 3
    GOTO $-1
    RETURN
    
CERO_1:
    MOVLW d'0'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 3
    GOTO $-1
    RETURN
    
UNO_1:
    MOVLW d'1'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 0
    GOTO $-1
    RETURN

DOS_1:
    MOVLW d'2'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 0
    GOTO $-1
    RETURN

TRES_1:
    MOVLW d'3'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 0
    GOTO $-1
    RETURN

CUATRO_1:
    MOVLW d'4'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 1
    GOTO $-1
    RETURN
    
CINCO_1:
    MOVLW d'5'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 1
    GOTO $-1
    RETURN
    
SEIS_1:
    MOVLW d'6'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '6'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 1
    GOTO $-1
    RETURN
    
SIETE_1:
    MOVLW d'7'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 2
    GOTO $-1
    RETURN
    
OCHO_1:
    MOVLW d'8'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '8'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 2
    GOTO $-1
    RETURN
    
NUEVE_1:
    MOVLW d'9'
    MOVWF R1
    BCF PORTA,0		
    CALL time
    
    MOVLW 0x8B	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '9'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 2
    GOTO $-1
    RETURN
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Renglon_2:
    BSF PORTD, 2
    BTFSC PORTC, 0
    CALL UNO_2
    BTFSC PORTC, 1
    CALL CUATRO_2
    BTFSC PORTC, 2
    CALL SIETE_2
    BCF PORTD, 2
    
    BSF PORTD, 1
    BTFSC PORTC, 0
    CALL DOS_2
    BTFSC PORTC, 1
    CALL CINCO_2
    BTFSC PORTC, 2
    CALL OCHO_2
    BTFSC PORTC, 3
    CALL CERO_2
    BCF PORTD, 1
    
    BSF PORTD, 0
    BTFSC PORTC, 0
    CALL TRES_2
    BTFSC PORTC, 1
    CALL SEIS_2
    BTFSC PORTC, 2
    CALL NUEVE_2
    BTFSC PORTC, 3
    CALL NUMERO_1
    BCF PORTD, 0
    
    RETURN

    
CERO_2:
    MOVLW d'0'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '0'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 3
    GOTO $-1
    RETURN
    
UNO_2:
    MOVLW d'1'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '1'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 0
    GOTO $-1
    RETURN

DOS_2:
    MOVLW d'2'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '2'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 0
    GOTO $-1
    RETURN

TRES_2:
    MOVLW d'3'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '3'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 0
    GOTO $-1
    RETURN

CUATRO_2:
    MOVLW d'4'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '4'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 1
    GOTO $-1
    RETURN
    
CINCO_2:
    MOVLW d'5'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '5'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 1
    GOTO $-1
    RETURN
    
SEIS_2:
    MOVLW d'6'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '6'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 1
    GOTO $-1
    RETURN
    
SIETE_2:
    MOVLW d'7'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '7'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 2
    GOTO $-1
    RETURN
    
OCHO_2:
    MOVLW d'8'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '8'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 2
    GOTO $-1
    RETURN
    
NUEVE_2:
    MOVLW d'9'
    MOVWF R2
    BCF PORTA,0		
    CALL time
    
    MOVLW 0xCB	
    MOVWF PORTB
    CALL exec
    
    BSF PORTA,0		
    CALL time
    
    MOVLW '9'
    MOVWF PORTB
    CALL exec
    BTFSC PORTC, 2
    GOTO $-1
    RETURN
    
exec

    BSF PORTA,1		;exec
    CALL time
    BCF PORTA,1
    CALL time
    RETURN
    
time
    CLRF i
    MOVLW d'10'
    MOVWF j
ciclo    
    MOVLW d'80'
    MOVWF i
    DECFSZ i
    GOTO $-1
    DECFSZ j
    GOTO ciclo
    RETURN

    

   
			
    END
