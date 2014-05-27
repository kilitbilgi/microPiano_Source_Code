
_delay:

;microPiano.c,42 :: 		void delay(){
;microPiano.c,43 :: 		Delay_ms(5000);
	MOV	#509, W8
	MOV	#41213, W7
L_delay0:
	DEC	W7
	BRA NZ	L_delay0
	DEC	W8
	BRA NZ	L_delay0
	NOP
	NOP
;microPiano.c,44 :: 		}
L_end_delay:
	RETURN
; end of _delay

_delay1:

;microPiano.c,47 :: 		void delay1(){
;microPiano.c,48 :: 		Delay_ms(15000);
	MOV	#1526, W8
	MOV	#58107, W7
L_delay12:
	DEC	W7
	BRA NZ	L_delay12
	DEC	W8
	BRA NZ	L_delay12
	NOP
;microPiano.c,49 :: 		}
L_end_delay1:
	RETURN
; end of _delay1

_clrscr:

;microPiano.c,52 :: 		void clrscr(){
;microPiano.c,53 :: 		Glcd_Fill(0x00);
	PUSH	W10
	CLR	W10
	CALL	_Glcd_Fill
;microPiano.c,54 :: 		}
L_end_clrscr:
	POP	W10
	RETURN
; end of _clrscr

_M_Open_File_Read:

;microPiano.c,57 :: 		void M_Open_File_Read() {
;microPiano.c,60 :: 		Mmc_Fat_Reset(&size);                 // To read file, procedure returns size of file
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	MOV	#lo_addr(_size), W10
	CALL	_Mmc_Fat_Reset
;microPiano.c,61 :: 		for (k = 1; k <= size; k++) {
	MOV	#1, W0
	MOV	#0, W1
	MOV	W0, _k
	MOV	W1, _k+2
L_M_Open_File_Read4:
	MOV	_k, W1
	MOV	_k+2, W2
	MOV	#lo_addr(_size), W0
	CP	W1, [W0++]
	CPB	W2, [W0--]
	BRA LEU	L__M_Open_File_Read40
	GOTO	L_M_Open_File_Read5
L__M_Open_File_Read40:
;microPiano.c,62 :: 		Mmc_Fat_Read(&notes);
	MOV	#lo_addr(_notes), W10
	CALL	_Mmc_Fat_Read
;microPiano.c,63 :: 		Glcd_Write_Text(notes,2,2,2);
	MOV.B	#2, W13
	MOV.B	#2, W12
	MOV.B	#2, W11
	MOV	_notes, W10
	CALL	_Glcd_Write_Text
;microPiano.c,61 :: 		for (k = 1; k <= size; k++) {
	MOV	#1, W1
	MOV	#0, W2
	MOV	#lo_addr(_k), W0
	ADD	W1, [W0], [W0++]
	ADDC	W2, [W0], [W0--]
;microPiano.c,64 :: 		}
	GOTO	L_M_Open_File_Read4
L_M_Open_File_Read5:
;microPiano.c,65 :: 		}
L_end_M_Open_File_Read:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _M_Open_File_Read

_GLCDFirstSong:
	LNK	#8

;microPiano.c,68 :: 		void GLCDFirstSong(){
;microPiano.c,70 :: 		clrscr();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	CALL	_clrscr
;microPiano.c,71 :: 		song_name = "Artik Sevmeyecegim";
; song_name start address is: 2 (W1)
	MOV	#lo_addr(?lstr1_microPiano), W1
;microPiano.c,72 :: 		note1 = "mi-fa-sol-fa-mi-re-mi";
	MOV	#lo_addr(?lstr2_microPiano), W0
	MOV	W0, [W14+0]
;microPiano.c,73 :: 		note2 = "mi-fa-sol-la-si-do-si";
	MOV	#lo_addr(?lstr3_microPiano), W0
	MOV	W0, [W14+2]
;microPiano.c,74 :: 		note3 = "la-si-do-re-do-si-la";
	MOV	#lo_addr(?lstr4_microPiano), W0
	MOV	W0, [W14+4]
;microPiano.c,75 :: 		note4 = "sol-la-si-do-si-la";
	MOV	#lo_addr(?lstr5_microPiano), W0
	MOV	W0, [W14+6]
;microPiano.c,78 :: 		Glcd_Write_Text(song_name,2,0,2);
	MOV.B	#2, W13
	CLR	W12
	MOV.B	#2, W11
	MOV	W1, W10
; song_name end address is: 2 (W1)
	CALL	_Glcd_Write_Text
;microPiano.c,81 :: 		Glcd_Write_Text(note1,2,2,2);
	MOV.B	#2, W13
	MOV.B	#2, W12
	MOV.B	#2, W11
	MOV	[W14+0], W10
	CALL	_Glcd_Write_Text
;microPiano.c,82 :: 		Glcd_Write_Text(note2,2,3,2);
	MOV.B	#2, W13
	MOV.B	#3, W12
	MOV.B	#2, W11
	MOV	[W14+2], W10
	CALL	_Glcd_Write_Text
;microPiano.c,83 :: 		Glcd_Write_Text(note3,2,4,2);
	MOV.B	#2, W13
	MOV.B	#4, W12
	MOV.B	#2, W11
	MOV	[W14+4], W10
	CALL	_Glcd_Write_Text
;microPiano.c,84 :: 		Glcd_Write_Text(note4,2,5,2);
	MOV.B	#2, W13
	MOV.B	#5, W12
	MOV.B	#2, W11
	MOV	[W14+6], W10
	CALL	_Glcd_Write_Text
;microPiano.c,85 :: 		}
L_end_GLCDFirstSong:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _GLCDFirstSong

_GLCDSecondSong:
	LNK	#8

;microPiano.c,88 :: 		void GLCDSecondSong(){
;microPiano.c,90 :: 		song_name = "Neseli Ol Ki Genc Kalasin";
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
; song_name start address is: 2 (W1)
	MOV	#lo_addr(?lstr6_microPiano), W1
;microPiano.c,91 :: 		note1 = "Do-do-re-mi-mi-re-re";
	MOV	#lo_addr(?lstr7_microPiano), W0
	MOV	W0, [W14+0]
;microPiano.c,92 :: 		note2 = "do-re-mi-do-mi-mi-fa";
	MOV	#lo_addr(?lstr8_microPiano), W0
	MOV	W0, [W14+2]
;microPiano.c,93 :: 		note3 = "sol-sol-fa-mi-fa-sol";
	MOV	#lo_addr(?lstr9_microPiano), W0
	MOV	W0, [W14+4]
;microPiano.c,94 :: 		note4 = "sol-do-do-re-mi-mi";
	MOV	#lo_addr(?lstr10_microPiano), W0
	MOV	W0, [W14+6]
;microPiano.c,97 :: 		Glcd_Write_Text(song_name,2,0,2);
	MOV.B	#2, W13
	CLR	W12
	MOV.B	#2, W11
	MOV	W1, W10
; song_name end address is: 2 (W1)
	CALL	_Glcd_Write_Text
;microPiano.c,100 :: 		Glcd_Write_Text(note1,2,2,2);
	MOV.B	#2, W13
	MOV.B	#2, W12
	MOV.B	#2, W11
	MOV	[W14+0], W10
	CALL	_Glcd_Write_Text
;microPiano.c,101 :: 		Glcd_Write_Text(note2,2,3,2);
	MOV.B	#2, W13
	MOV.B	#3, W12
	MOV.B	#2, W11
	MOV	[W14+2], W10
	CALL	_Glcd_Write_Text
;microPiano.c,102 :: 		Glcd_Write_Text(note3,2,4,2);
	MOV.B	#2, W13
	MOV.B	#4, W12
	MOV.B	#2, W11
	MOV	[W14+4], W10
	CALL	_Glcd_Write_Text
;microPiano.c,103 :: 		Glcd_Write_Text(note4,2,5,2);
	MOV.B	#2, W13
	MOV.B	#5, W12
	MOV.B	#2, W11
	MOV	[W14+6], W10
	CALL	_Glcd_Write_Text
;microPiano.c,104 :: 		}
L_end_GLCDSecondSong:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	ULNK
	RETURN
; end of _GLCDSecondSong

_startPiano:

;microPiano.c,107 :: 		void startPiano(){
;microPiano.c,108 :: 		while(1){
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
L_startPiano7:
;microPiano.c,110 :: 		if(Button(&PORTF,7,1,1))
	MOV	#1, W13
	MOV	#1, W12
	MOV	#7, W11
	MOV	#lo_addr(PORTF), W10
	CALL	_Button
	CP0	W0
	BRA NZ	L__startPiano44
	GOTO	L_startPiano9
L__startPiano44:
;microPiano.c,111 :: 		Sound_Play(261.6, 300);
	MOV	#300, W11
	MOV	#261, W10
	CALL	_Sound_Play
L_startPiano9:
;microPiano.c,112 :: 		while(PORTF.F7);
L_startPiano10:
	BTSS	PORTF, #7
	GOTO	L_startPiano11
	GOTO	L_startPiano10
L_startPiano11:
;microPiano.c,115 :: 		if(Button(&PORTF,6,1,1))
	MOV	#1, W13
	MOV	#1, W12
	MOV	#6, W11
	MOV	#lo_addr(PORTF), W10
	CALL	_Button
	CP0	W0
	BRA NZ	L__startPiano45
	GOTO	L_startPiano12
L__startPiano45:
;microPiano.c,116 :: 		Sound_Play(293.6, 300);
	MOV	#300, W11
	MOV	#293, W10
	CALL	_Sound_Play
L_startPiano12:
;microPiano.c,117 :: 		while(PORTF.F6);
L_startPiano13:
	BTSS	PORTF, #6
	GOTO	L_startPiano14
	GOTO	L_startPiano13
L_startPiano14:
;microPiano.c,120 :: 		if(Button(&PORTF,5,1,1))
	MOV	#1, W13
	MOV	#1, W12
	MOV	#5, W11
	MOV	#lo_addr(PORTF), W10
	CALL	_Button
	CP0	W0
	BRA NZ	L__startPiano46
	GOTO	L_startPiano15
L__startPiano46:
;microPiano.c,121 :: 		Sound_Play(329.6, 300);
	MOV	#300, W11
	MOV	#329, W10
	CALL	_Sound_Play
L_startPiano15:
;microPiano.c,122 :: 		while(PORTF.F5);
L_startPiano16:
	BTSS	PORTF, #5
	GOTO	L_startPiano17
	GOTO	L_startPiano16
L_startPiano17:
;microPiano.c,125 :: 		if(Button(&PORTF,4,1,1))
	MOV	#1, W13
	MOV	#1, W12
	MOV	#4, W11
	MOV	#lo_addr(PORTF), W10
	CALL	_Button
	CP0	W0
	BRA NZ	L__startPiano47
	GOTO	L_startPiano18
L__startPiano47:
;microPiano.c,126 :: 		Sound_Play(349.28, 300);
	MOV	#300, W11
	MOV	#349, W10
	CALL	_Sound_Play
L_startPiano18:
;microPiano.c,127 :: 		while(PORTF.F4);
L_startPiano19:
	BTSS	PORTF, #4
	GOTO	L_startPiano20
	GOTO	L_startPiano19
L_startPiano20:
;microPiano.c,130 :: 		if(Button(&PORTF,3,1,1))
	MOV	#1, W13
	MOV	#1, W12
	MOV	#3, W11
	MOV	#lo_addr(PORTF), W10
	CALL	_Button
	CP0	W0
	BRA NZ	L__startPiano48
	GOTO	L_startPiano21
L__startPiano48:
;microPiano.c,131 :: 		Sound_Play(392.28, 300);
	MOV	#300, W11
	MOV	#392, W10
	CALL	_Sound_Play
L_startPiano21:
;microPiano.c,132 :: 		while(PORTF.F3);
L_startPiano22:
	BTSS	PORTF, #3
	GOTO	L_startPiano23
	GOTO	L_startPiano22
L_startPiano23:
;microPiano.c,135 :: 		if(Button(&PORTF,2,1,1))
	MOV	#1, W13
	MOV	#1, W12
	MOV	#2, W11
	MOV	#lo_addr(PORTF), W10
	CALL	_Button
	CP0	W0
	BRA NZ	L__startPiano49
	GOTO	L_startPiano24
L__startPiano49:
;microPiano.c,136 :: 		Sound_Play(440.00, 300);
	MOV	#300, W11
	MOV	#440, W10
	CALL	_Sound_Play
L_startPiano24:
;microPiano.c,137 :: 		while(PORTF.F2);
L_startPiano25:
	BTSS	PORTF, #2
	GOTO	L_startPiano26
	GOTO	L_startPiano25
L_startPiano26:
;microPiano.c,140 :: 		if(Button(&PORTF,1,1,1))
	MOV	#1, W13
	MOV	#1, W12
	MOV	#1, W11
	MOV	#lo_addr(PORTF), W10
	CALL	_Button
	CP0	W0
	BRA NZ	L__startPiano50
	GOTO	L_startPiano27
L__startPiano50:
;microPiano.c,141 :: 		Sound_Play(493.00, 300);
	MOV	#300, W11
	MOV	#493, W10
	CALL	_Sound_Play
L_startPiano27:
;microPiano.c,142 :: 		while(PORTF.F1);
L_startPiano28:
	BTSS	PORTF, #1
	GOTO	L_startPiano29
	GOTO	L_startPiano28
L_startPiano29:
;microPiano.c,145 :: 		if(Button(&PORTF,0,1,1))
	MOV	#1, W13
	MOV	#1, W12
	CLR	W11
	MOV	#lo_addr(PORTF), W10
	CALL	_Button
	CP0	W0
	BRA NZ	L__startPiano51
	GOTO	L_startPiano30
L__startPiano51:
;microPiano.c,146 :: 		Sound_Play(523.00, 300);
	MOV	#300, W11
	MOV	#523, W10
	CALL	_Sound_Play
L_startPiano30:
;microPiano.c,147 :: 		while(PORTF.F0);
L_startPiano31:
	BTSS	PORTF, #0
	GOTO	L_startPiano32
	GOTO	L_startPiano31
L_startPiano32:
;microPiano.c,150 :: 		if(Button(&PORTF,8,1,1))
	MOV	#1, W13
	MOV	#1, W12
	MOV	#8, W11
	MOV	#lo_addr(PORTF), W10
	CALL	_Button
	CP0	W0
	BRA NZ	L__startPiano52
	GOTO	L_startPiano33
L__startPiano52:
;microPiano.c,151 :: 		Sound_Play(587.20, 300);
	MOV	#300, W11
	MOV	#587, W10
	CALL	_Sound_Play
L_startPiano33:
;microPiano.c,152 :: 		while(PORTF.F8);
L_startPiano34:
	BTSS	PORTF, #8
	GOTO	L_startPiano35
	GOTO	L_startPiano34
L_startPiano35:
;microPiano.c,154 :: 		}
	GOTO	L_startPiano7
;microPiano.c,155 :: 		}
L_end_startPiano:
	RETURN
; end of _startPiano

_GLCDWelcome:

;microPiano.c,157 :: 		void GLCDWelcome(){
;microPiano.c,159 :: 		welcome = "Welcome to MicroPiano";
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
; welcome start address is: 6 (W3)
	MOV	#lo_addr(?lstr11_microPiano), W3
;microPiano.c,160 :: 		clrscr();
	CALL	_clrscr
;microPiano.c,162 :: 		Glcd_Write_Text(welcome,2,1,2);
	MOV.B	#2, W13
	MOV.B	#1, W12
	MOV.B	#2, W11
	MOV	W3, W10
; welcome end address is: 6 (W3)
	CALL	_Glcd_Write_Text
;microPiano.c,165 :: 		welcome = "Song is loading";
; welcome start address is: 0 (W0)
	MOV	#lo_addr(?lstr12_microPiano), W0
;microPiano.c,166 :: 		Glcd_Write_Text(welcome,2,3,2);
	MOV.B	#2, W13
	MOV.B	#3, W12
	MOV.B	#2, W11
	MOV	W0, W10
; welcome end address is: 0 (W0)
	CALL	_Glcd_Write_Text
;microPiano.c,169 :: 		welcome = "Project by Burak&Mali";
; welcome start address is: 0 (W0)
	MOV	#lo_addr(?lstr13_microPiano), W0
;microPiano.c,170 :: 		Glcd_Write_Text(welcome,2,4,2);
	MOV.B	#2, W13
	MOV.B	#4, W12
	MOV.B	#2, W11
	MOV	W0, W10
; welcome end address is: 0 (W0)
	CALL	_Glcd_Write_Text
;microPiano.c,173 :: 		delay1();
	CALL	_delay1
;microPiano.c,176 :: 		clrscr();
	CALL	_clrscr
;microPiano.c,177 :: 		}
L_end_GLCDWelcome:
	POP	W13
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _GLCDWelcome

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;microPiano.c,179 :: 		void main() {
;microPiano.c,180 :: 		ADPCFG = 0xFFFF;      // Configure AN pins as digital
	PUSH	W10
	PUSH	W11
	MOV	#65535, W0
	MOV	WREG, ADPCFG
;microPiano.c,181 :: 		TRISG = 0xffff;
	MOV	#65535, W0
	MOV	WREG, TRISG
;microPiano.c,182 :: 		Glcd_init();
	CALL	_Glcd_Init
;microPiano.c,184 :: 		clrscr();
	CALL	_clrscr
;microPiano.c,186 :: 		GLCDWelcome();
	CALL	_GLCDWelcome
;microPiano.c,189 :: 		GLCDFirstSong();
	CALL	_GLCDFirstSong
;microPiano.c,191 :: 		PORTC = 0xAA;
	MOV	#170, W0
	MOV	WREG, PORTC
;microPiano.c,192 :: 		Sound_Init(&PORTC, 1);
	MOV	#1, W11
	MOV	#lo_addr(PORTC), W10
	CALL	_Sound_Init
;microPiano.c,195 :: 		startPiano();
	CALL	_startPiano
;microPiano.c,196 :: 		}
L_end_main:
	POP	W11
	POP	W10
L__main_end_loop:
	BRA	L__main_end_loop
; end of _main
