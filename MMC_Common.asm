
_UART1_Write_Line:

;MMC_Common.c,40 :: 		void UART1_Write_Line(char *uart_text) {
;MMC_Common.c,41 :: 		UART1_Write_Text(uart_text);
	PUSH	W10
	CALL	_UART1_Write_Text
;MMC_Common.c,42 :: 		UART1_Write(13);
	MOV	#13, W10
	CALL	_UART1_Write
;MMC_Common.c,43 :: 		UART1_Write(10);
	MOV	#10, W10
	CALL	_UART1_Write
;MMC_Common.c,44 :: 		}
L_end_UART1_Write_Line:
	POP	W10
	RETURN
; end of _UART1_Write_Line

_PrintHex:

;MMC_Common.c,47 :: 		void PrintHex(unsigned char i) {
;MMC_Common.c,50 :: 		hi = i & 0xF0;               // High nibble
	PUSH	W10
	ZE	W10, W1
	MOV	#240, W0
	AND	W1, W0, W0
;MMC_Common.c,51 :: 		hi = hi >> 4;
	ZE	W0, W0
	LSR	W0, #4, W0
;MMC_Common.c,52 :: 		hi = hi + '0';
	ZE	W0, W1
	MOV	#48, W0
	ADD	W1, W0, W1
; hi start address is: 4 (W2)
	MOV.B	W1, W2
;MMC_Common.c,53 :: 		if (hi>'9') hi=hi+7;
	MOV.B	#57, W0
	CP.B	W1, W0
	BRA GTU	L__PrintHex6
	GOTO	L__PrintHex2
L__PrintHex6:
; hi start address is: 4 (W2)
	ADD.B	W2, #7, W2
; hi end address is: 4 (W2)
; hi end address is: 4 (W2)
	GOTO	L_PrintHex0
L__PrintHex2:
L_PrintHex0:
;MMC_Common.c,54 :: 		lo = (i & 0x0F) + '0';       // Low nibble
; hi start address is: 4 (W2)
	ZE	W10, W0
	AND	W0, #15, W1
	MOV	#48, W0
	ADD	W1, W0, W1
; lo start address is: 6 (W3)
	MOV.B	W1, W3
;MMC_Common.c,55 :: 		if (lo>'9') lo=lo+7;
	MOV.B	#57, W0
	CP.B	W1, W0
	BRA GTU	L__PrintHex7
	GOTO	L__PrintHex3
L__PrintHex7:
; lo start address is: 0 (W0)
	ADD.B	W3, #7, W0
; lo end address is: 6 (W3)
; lo end address is: 0 (W0)
	GOTO	L_PrintHex1
L__PrintHex3:
	MOV.B	W3, W0
L_PrintHex1:
;MMC_Common.c,57 :: 		UART1_Write(hi);
; lo start address is: 0 (W0)
	ZE	W2, W10
; hi end address is: 4 (W2)
	CALL	_UART1_Write
;MMC_Common.c,58 :: 		UART1_Write(lo);
	ZE	W0, W10
; lo end address is: 0 (W0)
	CALL	_UART1_Write
;MMC_Common.c,59 :: 		}
L_end_PrintHex:
	POP	W10
	RETURN
; end of _PrintHex
