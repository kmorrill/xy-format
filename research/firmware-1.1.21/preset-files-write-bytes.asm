
os.ldr@0x8c03ecd4:     file format binary


Disassembly of section .data:

8c03ecd4 <.data>:
8c03ecd4:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8c03ecd8:	e5 05       	[--SP] = (R7:4, P5:5);
8c03ecda:	66 6f       	SP += -0x14;		/* (-20) */
8c03ecdc:	82 ce 02 ce 	R7 = ROT R2 BY 0x0 || [FP + 0x8] = R1 || NOP;
8c03ece0:	b9 b0 00 00 
8c03ece4:	01 da 90 11 	R1=294680272;
8c03ece8:	d0 76 00 00 
8c03ecec:	61 64       	R1 += 0xc;		/* ( 12) */
8c03ecee:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8c03ecf2:	b8 00 02 00 
8c03ecf6:	28 32       	P5 = R0;
8c03ecf8:	20 30       	R4 = R0;
8c03ecfa:	ff e3 65 fc 	CALL 0x0x8c03e5c4;
8c03ecfe:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8c03ed02:	b8 00 01 00 
8c03ed06:	08 08       	CC = R0 == R1;
8c03ed08:	58 10       	IF !CC JUMP 0x0x8c03edb8;
8c03ed0a:	24 64       	R4 += 0x4;		/* (  4) */
8c03ed0c:	a8 a1       	R0 = [P5 + 0x18];
8c03ed0e:	0c 32       	P1 = R4;
8c03ed10:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8c03ed12:	06 0a       	CC = R6 <= R0 (IU);
8c03ed14:	04 30       	R0 = R4;
8c03ed16:	02 10       	IF !CC JUMP 0x0x8c03ed1a;
8c03ed18:	08 91       	R0 = [P1];
8c03ed1a:	01 da 90 11 	R1=294680272;
8c03ed1e:	d0 76 00 00 
8c03ed22:	00 de ed 8f 	CALL.A 0x8fed0348;
8c03ed26:	48 03 00 00 
8c03ed2a:	0c 32       	P1 = R4;
8c03ed2c:	00 0c       	CC = R0 == 0x0;
8c03ed2e:	28 30       	R5 = R0;
8c03ed30:	24 18       	IF CC JUMP 0x0x8c03ed78;
8c03ed32:	07 0d       	CC = R7 <= 0x0;
8c03ed34:	06 60       	R6 = 0x0 (X);		/*		R6=0x0(  0) */
8c03ed36:	15 10       	IF !CC JUMP 0x0x8c03ed60;
8c03ed38:	05 30       	R0 = R5;
8c03ed3a:	00 de ed 8f 	CALL.A 0x8fed00ae;
8c03ed3e:	ae 00 00 00 
8c03ed42:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03ed44:	37 08       	CC = R7 == R6;
8c03ed46:	a5 05       	(R7:4, P5:5) = [SP++];
8c03ed48:	01 e8 00 00 	UNLINK;
8c03ed4c:	00 02       	R0 = CC;
8c03ed4e:	10 00       	RTS;
8c03ed50:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03ed52:	a5 05       	(R7:4, P5:5) = [SP++];
8c03ed54:	01 e8 00 00 	UNLINK;
8c03ed58:	10 00       	RTS;
8c03ed5a:	00 00       	NOP;
8c03ed5c:	00 00       	NOP;
8c03ed5e:	00 00       	NOP;
8c03ed60:	82 ce 07 c4 	R2 = ROT R7 BY 0x0 || [SP + 0xc] = R0 || R0 = [FP + 0x8];
8c03ed64:	f0 b0 b8 a0 
8c03ed68:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8c03ed6a:	00 de ed 8f 	CALL.A 0x8fed0780;
8c03ed6e:	80 07 00 00 
8c03ed72:	30 30       	R6 = R0;
8c03ed74:	e2 2f       	JUMP.S 0x0x8c03ed38;
8c03ed76:	00 00       	NOP;
8c03ed78:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c03ed7c:	fc 1e 00 00 
8c03ed80:	98 0c       	CC = R0 < 0x3;
8c03ed82:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c03ed84:	e6 1f       	IF CC JUMP 0x0x8c03ed50 (BP);
8c03ed86:	a8 a1       	R0 = [P5 + 0x18];
8c03ed88:	06 0a       	CC = R6 <= R0 (IU);
8c03ed8a:	02 10       	IF !CC JUMP 0x0x8c03ed8e;
8c03ed8c:	0c 91       	R4 = [P1];
8c03ed8e:	09 da 90 11 	P1=294680384;
8c03ed92:	40 77 00 00 
8c03ed96:	34 b1       	[SP + 0x10] = R4;
8c03ed98:	f1 bc       	[SP + 0xc] = P1;
8c03ed9a:	22 e1 c0 01 	R2 = 0x1c0 (X);		/*		R2=0x1c0(448) */
8c03ed9e:	01 da 90 11 	R1=294680312;
8c03eda2:	f8 76 00 00 
8c03eda6:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8c03eda8:	00 e3 e6 0b 	CALL 0x0x8c040574;
8c03edac:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03edae:	a5 05       	(R7:4, P5:5) = [SP++];
8c03edb0:	01 e8 00 00 	UNLINK;
8c03edb4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c03edb6:	10 00       	RTS;
8c03edb8:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0xc] = R0 || NOP;
8c03edbc:	f0 b0 00 00 
8c03edc0:	47 30       	R0 = FP;
8c03edc2:	20 67       	R0 += -0x1c;		/* (-28) */
8c03edc4:	02 60       	R2 = 0x0 (X);		/*		R2=0x1c0(448) */
8c03edc6:	ff e3 70 ff 	CALL 0x0x8c03eca6;
8c03edca:	47 30       	R0 = FP;
8c03edcc:	40 67       	R0 += -0x18;		/* (-24) */
8c03edce:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8c03edd0:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || R2 = [FP -0x4] || R1 = [SP + 0x2c];
8c03edd4:	f2 b9 f1 a2 
8c03edd8:	16 0a       	CC = R6 <= R2 (IU);
8c03edda:	01 07       	IF CC R0 = R1;
8c03eddc:	ff e3 48 f9 	CALL 0x0x8c03e06c;
8c03ede0:	f0 b9       	R0 = [FP -0x4];
8c03ede2:	06 0a       	CC = R6 <= R0 (IU);
8c03ede4:	07 18       	IF CC JUMP 0x0x8c03edf2;
8c03ede6:	f5 b3       	[SP + 0x3c] = R5;
8c03ede8:	b5 e6 2c 00 	B[SP + 0x2c] = R5;
8c03edec:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8c03edee:	f0 bb       	[FP -0x4] = R0;
8c03edf0:	8d 2f       	JUMP.S 0x0x8c03ed0a;
8c03edf2:	f0 a2       	R0 = [SP + 0x2c];
8c03edf4:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03edf8:	e4 e3 00 00 
8c03edfc:	f5 2f       	JUMP.S 0x0x8c03ede6;
8c03edfe:	00 00       	NOP;
