
os.ldr@0x8d57ad90:     file format binary


Disassembly of section .data:

8d57ad90 <.data>:
8d57ad90:	22 60       	R2 = 0x4 (X);		/*		R2=0x0(  0) */
8d57ad92:	07 c4 0a 42 	R1 = MIN (R1, R2);
8d57ad96:	e2 63       	R2 = -0x4 (X);		/*		R2=0x0(  0) */
8d57ad98:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d57ad9c:	07 c4 0a 02 	R1 = MAX (R1, R2);
8d57ada0:	40 43       	R0 = R0.B (Z);
8d57ada2:	ff e3 d1 b1 	CALL 0x0x8d571144;
8d57ada6:	01 e8 00 00 	UNLINK;
8d57adaa:	10 00       	RTS;
8d57adac:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d57adb0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d57adb4:	f7 b0 00 00 
8d57adb8:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8d57adba:	8f 08       	CC = R7 < R1;
8d57adbc:	10 18       	IF CC JUMP 0x0x8d57addc;
8d57adbe:	68 60       	R0 = 0xd (X);		/*		R0=0x0(  0) */
8d57adc0:	07 08       	CC = R7 == R0;
8d57adc2:	08 18       	IF CC JUMP 0x0x8d57add2;
8d57adc4:	04 cc 00 40 	R0 = R0 - R0 (NS) || R7 = [SP + 0xc] || NOP;
8d57adc8:	f7 a0 00 00 
8d57adcc:	01 e8 00 00 	UNLINK;
8d57add0:	10 00       	RTS;
8d57add2:	f7 a0       	R7 = [SP + 0xc];
8d57add4:	01 e8 00 00 	UNLINK;
8d57add8:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d57adda:	10 00       	RTS;
8d57addc:	ff e3 b6 c2 	CALL 0x0x8d573348;
8d57ade0:	00 0c       	CC = R0 == 0x0;
8d57ade2:	ee 13       	IF !CC JUMP 0x0x8d57adbe;
8d57ade4:	f7 a0       	R7 = [SP + 0xc];
8d57ade6:	01 e8 00 00 	UNLINK;
8d57adea:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d57adec:	10 00       	RTS;
8d57adee:	00 00       	NOP;
8d57adf0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d57adf4:	60 05       	[--SP] = (R7:4);
8d57adf6:	a6 6f       	SP += -0xc;		/* (-12) */
8d57adf8:	38 30       	R7 = R0;
8d57adfa:	21 30       	R4 = R1;
8d57adfc:	ff e3 d8 ff 	CALL 0x0x8d57adac;
8d57ae00:	00 0c       	CC = R0 == 0x0;
8d57ae02:	25 60       	R5 = 0x4 (X);		/*		R5=0x0(  0) */
8d57ae04:	11 60       	R1 = 0x2 (X);		/*		R1=0x0(  0) */
8d57ae06:	29 06       	IF !CC R5 = R1;
8d57ae08:	e6 63       	R6 = -0x4 (X);		/*		R6=0x0(  0) */
8d57ae0a:	f1 63       	R1 = -0x2 (X);		/*		R1=0x0(  0) */
8d57ae0c:	4a 60       	R2 = 0x9 (X);		/*		R2=0x0(  0) */
8d57ae0e:	31 06       	IF !CC R6 = R1;
8d57ae10:	17 08       	CC = R7 == R2;
8d57ae12:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d57ae14:	78 43       	R0 = R7.B (Z);
8d57ae16:	29 07       	IF CC R5 = R1;
8d57ae18:	31 07       	IF CC R6 = R1;
8d57ae1a:	ff e3 6b a7 	CALL 0x0x8d56fcf0;
8d57ae1e:	04 50       	R0 = R4 + R0;
8d57ae20:	85 08       	CC = R5 < R0;
8d57ae22:	03 18       	IF CC JUMP 0x0x8d57ae28;
8d57ae24:	07 c4 06 0a 	R5 = MAX (R0, R6);
8d57ae28:	07 30       	R0 = R7;
8d57ae2a:	0d 30       	R1 = R5;
8d57ae2c:	ff e3 b2 ff 	CALL 0x0x8d57ad90;
8d57ae30:	66 6c       	SP += 0xc;		/* ( 12) */
8d57ae32:	05 30       	R0 = R5;
8d57ae34:	20 05       	(R7:4) = [SP++];
8d57ae36:	01 e8 00 00 	UNLINK;
8d57ae3a:	10 00       	RTS;
8d57ae3c:	00 e8 00 00 	LINK 0x0;		/* (0) */
