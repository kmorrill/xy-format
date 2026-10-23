
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d560bbc <.data+0x94b9c>:
8d560bbc:	00 e8 16 00 	LINK 0x58;		/* (88) */
8d560bc0:	e3 05       	[--SP] = (R7:4, P5:3);
8d560bc2:	66 6f       	SP += -0x14;		/* (-20) */
8d560bc4:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [FP + 0x10] = R1 || NOP;
8d560bc8:	39 b1 00 00 
8d560bcc:	03 c8 00 18 	MNOP || P4 = [FP + 0x10] || [FP + 0xc] = R2;
8d560bd0:	3c ad fa b0 
8d560bd4:	30 b3       	[SP + 0x30] = R0;
8d560bd6:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
8d560bd8:	7e 60       	R6 = 0xf (X);		/*		R6=0x0(  0) */
8d560bda:	a1 a0       	R1 = [P4 + 0x8];
8d560bdc:	8a 09       	CC = R2 < R1 (IU);
8d560bde:	60 10       	IF !CC JUMP 0x0x8d560c9e;
8d560be0:	0d da 06 84 	P5=-2079940540;
8d560be4:	44 a0 00 00 
8d560be8:	03 c8 00 18 	MNOP || P1 = [P4 + 0x4] || R1 = [SP + 0x30];
8d560bec:	61 ac 31 a3 
8d560bf0:	46 30       	R0 = SP;
8d560bf2:	a3 61       	R3 = 0x34 (X);		/*		R3=0x0(  0) */
8d560bf4:	18 50       	R0 = R0 + R3;
8d560bf6:	03 c8 00 18 	MNOP || P3 = [P1] || R3 = [P1];
8d560bfa:	4b 91 0b 91 
8d560bfe:	7a 61       	R2 = 0x2f (X);		/*		R2=0x0(  0) */
8d560c00:	67 30       	R4 = FP;
8d560c02:	bb b0       	[FP + 0x8] = R3;
8d560c04:	fc e3 d4 09 	CALL 0x0x8d4e1fac;
8d560c08:	44 66       	R4 += -0x38;		/* (-56) */
8d560c0a:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R1 = [P3 + 0xc] || NOP;
8d560c0e:	d9 a0 00 00 
8d560c12:	ff e3 d1 f8 	CALL 0x0x8d55fdb4;
8d560c16:	04 30       	R0 = R4;
8d560c18:	20 67       	R0 += -0x1c;		/* (-28) */
8d560c1a:	08 30       	R1 = R0;
8d560c1c:	14 30       	R2 = R4;
8d560c1e:	c0 65       	R0 += 0x38;		/* ( 56) */
8d560c20:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d560c24:	e4 f0 00 00 
8d560c28:	80 b9       	R0 = [FP -0x20];
8d560c2a:	05 0a       	CC = R5 <= R0 (IU);
8d560c2c:	58 18       	IF CC JUMP 0x0x8d560cdc;
8d560c2e:	77 bb       	[FP -0x24] = R7;
8d560c30:	b7 e6 54 00 	B[SP + 0x54] = R7;
8d560c34:	03 c8 00 18 	MNOP || R0 = [FP -0x3c] || [FP -0x20] = R6;
8d560c38:	10 b9 86 bb 
8d560c3c:	05 0a       	CC = R5 <= R0 (IU);
8d560c3e:	4b 18       	IF CC JUMP 0x0x8d560cd4;
8d560c40:	b7 e6 38 00 	B[SP + 0x38] = R7;
8d560c44:	03 c8 00 18 	MNOP || P0 = [FP -0x18] || [FP -0x3c] = R6;
8d560c48:	a8 b9 16 bb 
8d560c4c:	03 c8 00 18 	MNOP || [FP -0x40] = R7 || R3 = [FP -0x4];
8d560c50:	07 bb f3 b9 
8d560c54:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d560c58:	fc 1e 00 00 
8d560c5c:	98 0c       	CC = R0 < 0x3;
8d560c5e:	29 10       	IF !CC JUMP 0x0x8d560cb0;
8d560c60:	03 c8 00 18 	MNOP || R2 = [FP -0x4] || R3 = [FP -0x18];
8d560c64:	f2 b9 a3 b9 
8d560c68:	47 30       	R0 = FP;
8d560c6a:	15 0a       	CC = R5 <= R2 (IU);
8d560c6c:	40 67       	R0 += -0x18;		/* (-24) */
8d560c6e:	03 07       	IF CC R0 = R3;
8d560c70:	00 de 03 8c 	CALL.A 0x8c03e040;
8d560c74:	40 e0 00 00 
8d560c78:	03 c8 00 18 	MNOP || R1 = [FP + 0x8] || R0 = [FP + 0x10];
8d560c7c:	b9 a0 38 a1 
8d560c80:	ff e3 d8 f8 	CALL 0x0x8d55fe30;
8d560c84:	f0 b9       	R0 = [FP -0x4];
8d560c86:	05 0a       	CC = R5 <= R0 (IU);
8d560c88:	10 18       	IF CC JUMP 0x0x8d560ca8;
8d560c8a:	b7 e6 70 00 	B[SP + 0x70] = R7;
8d560c8e:	03 c8 00 18 	MNOP || R0 = [P4 + 0x8] || R1 = [FP + 0xc];
8d560c92:	a0 a0 f9 a0 
8d560c96:	81 09       	CC = R1 < R0 (IU);
8d560c98:	e7 bb       	[FP -0x8] = R7;
8d560c9a:	f6 bb       	[FP -0x4] = R6;
8d560c9c:	a6 1f       	IF CC JUMP 0x0x8d560be8 (BP);
8d560c9e:	a6 6c       	SP += 0x14;		/* ( 20) */
8d560ca0:	a3 05       	(R7:4, P5:3) = [SP++];
8d560ca2:	01 e8 00 00 	UNLINK;
8d560ca6:	10 00       	RTS;
8d560ca8:	a0 b9       	R0 = [FP -0x18];
8d560caa:	fb e3 9d 6b 	CALL 0x0x8d4ce3e4;
8d560cae:	ee 2f       	JUMP.S 0x0x8d560c8a;
8d560cb0:	4f 32       	P1 = FP;
8d560cb2:	1d 0a       	CC = R5 <= R3 (IU);
8d560cb4:	41 6f       	P1 += -0x18;		/* (-24) */
8d560cb6:	c8 07       	IF CC P1 = P0;
8d560cb8:	f5 bc       	[SP + 0xc] = P5;
8d560cba:	31 bd       	[SP + 0x10] = P1;
8d560cbc:	22 e1 c8 00 	R2 = 0xc8 (X);		/*		R2=0xc8(200) */
8d560cc0:	01 da 06 84 	R1=-2079940696;
8d560cc4:	a8 9f 00 00 
8d560cc8:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d560cca:	00 de 04 8c 	CALL.A 0x8c040574;
8d560cce:	74 05 00 00 
8d560cd2:	c7 2f       	JUMP.S 0x0x8d560c60;
8d560cd4:	b0 a3       	R0 = [SP + 0x38];
8d560cd6:	fb e3 87 6b 	CALL 0x0x8d4ce3e4;
8d560cda:	b3 2f       	JUMP.S 0x0x8d560c40;
8d560cdc:	30 b9       	R0 = [FP -0x34];
8d560cde:	fb e3 83 6b 	CALL 0x0x8d4ce3e4;
8d560ce2:	a6 2f       	JUMP.S 0x0x8d560c2e;
