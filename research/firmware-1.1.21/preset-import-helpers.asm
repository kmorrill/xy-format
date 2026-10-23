
os.ldr@0x8d4dbb00:     file format binary


Disassembly of section .data:

8d4dbb00 <.data>:
8d4dbb00:	21 67       	R1 += -0x1c;		/* (-28) */
8d4dbb02:	77 30       	R6 = FP;
8d4dbb04:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dbb08:	14 33 00 00 
8d4dbb0c:	a6 67       	R6 += -0xc;		/* (-12) */
8d4dbb0e:	08 30       	R1 = R0;
8d4dbb10:	06 30       	R0 = R6;
8d4dbb12:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4dbb16:	f0 2b 00 00 
8d4dbb1a:	05 30       	R0 = R5;
8d4dbb1c:	04 e3 08 b0 	CALL 0x0x8d571b2c;
8d4dbb20:	28 32       	P5 = R0;
8d4dbb22:	29 e1 64 38 	P1 = 0x3864 (X);		/*		P1=0x3864(14436) */
8d4dbb26:	45 60       	R5 = 0x8 (X);		/*		R5=0x0(  0) */
8d4dbb28:	0d 5b       	P4 = P5 + P1;
8d4dbb2a:	0c 30       	R1 = R4;
8d4dbb2c:	06 30       	R0 = R6;
8d4dbb2e:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4dbb32:	e4 30 00 00 
8d4dbb36:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4dbb3a:	88 1d 00 00 
8d4dbb3e:	0c 64       	R4 += 0x1;		/* (  1) */
8d4dbb40:	82 ce 80 80 	R0 = R0 << 0x10 || R1 = [FP + 0xc] || NOP;
8d4dbb44:	f9 a0 00 00 
8d4dbb48:	ac 08       	CC = R4 < R5;
8d4dbb4a:	03 c8 00 18 	MNOP || [P4++] = R0 || R0 = [FP + 0x8];
8d4dbb4e:	20 92 b8 a0 
8d4dbb52:	ec 1f       	IF CC JUMP 0x0x8d4dbb2a (BP);
8d4dbb54:	02 da 00 40 	R2=1073741824;
8d4dbb58:	00 00 00 00 
8d4dbb5c:	03 da 99 59 	R3=1503238554;
8d4dbb60:	9a 99 00 00 
8d4dbb64:	2b e6 42 0e 	[P5 + 0x3908] = R3;
8d4dbb68:	2a e6 41 0e 	[P5 + 0x3904] = R2;
8d4dbb6c:	04 e3 c8 bb 	CALL 0x0x8d5732fc;
8d4dbb70:	04 cc 12 44 	R2 = R2 - R2 (NS) || R5 = [FP + 0x8] || R1 = [FP + 0xc];
8d4dbb74:	bd a0 f9 a0 
8d4dbb78:	39 68       	P1 = 0x7 (X);		/*		P1=0x3864(14436) */
8d4dbb7a:	f1 bc       	[SP + 0xc] = P1;
8d4dbb7c:	68 43       	R0 = R5.B (Z);
8d4dbb7e:	ff e3 7d d3 	CALL 0x0x8d4d6278;
8d4dbb82:	06 30       	R0 = R6;
8d4dbb84:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dbb88:	38 1a 00 00 
8d4dbb8c:	07 30       	R0 = R7;
8d4dbb8e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dbb92:	38 1a 00 00 
8d4dbb96:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dbb98:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dbb9a:	01 e8 00 00 	UNLINK;
8d4dbb9e:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4dbba0:	10 00       	RTS;
8d4dbba2:	07 30       	R0 = R7;
8d4dbba4:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dbba8:	38 1a 00 00 
8d4dbbac:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dbbae:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dbbb0:	01 e8 00 00 	UNLINK;
8d4dbbb4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4dbbb6:	10 00       	RTS;
8d4dbbb8:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d4dbbba:	01 08       	CC = R1 == R0;
8d4dbbbc:	87 1f       	IF CC JUMP 0x0x8d4dbaca (BP);
8d4dbbbe:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dbbc0:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dbbc2:	01 e8 00 00 	UNLINK;
8d4dbbc6:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4dbbc8:	10 00       	RTS;
8d4dbbca:	00 00       	NOP;
8d4dbbcc:	00 e8 09 00 	LINK 0x24;		/* (36) */
8d4dbbd0:	60 05       	[--SP] = (R7:4);
8d4dbbd2:	20 30       	R4 = R0;
8d4dbbd4:	44 64       	R4 += 0x8;		/* (  8) */
8d4dbbd6:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dbbd8:	04 30       	R0 = R4;
8d4dbbda:	01 da 03 84 	R1=-2080152896;
8d4dbbde:	c0 62 00 00 
8d4dbbe2:	00 de 05 8c 	CALL.A 0x8c0526cc;
8d4dbbe6:	cc 26 00 00 
8d4dbbea:	77 30       	R6 = FP;
8d4dbbec:	e6 66       	R6 += -0x24;		/* (-36) */
8d4dbbee:	01 da 03 84 	R1=-2080152896;
8d4dbbf2:	c0 62 00 00 
8d4dbbf6:	28 30       	R5 = R0;
8d4dbbf8:	41 64       	R1 += 0x8;		/* (  8) */
8d4dbbfa:	06 30       	R0 = R6;
8d4dbbfc:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4dbc00:	a8 19 00 00 
8d4dbc04:	05 30       	R0 = R5;
8d4dbc06:	0e 30       	R1 = R6;
8d4dbc08:	00 de 05 8c 	CALL.A 0x8c051b42;
8d4dbc0c:	42 1b 00 00 
8d4dbc10:	28 30       	R5 = R0;
8d4dbc12:	05 0c       	CC = R5 == 0x0;
8d4dbc14:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4dbc16:	02 da 03 84 	R2=-2080152896;
8d4dbc1a:	c0 62 00 00 
8d4dbc1e:	03 60       	R3 = 0x0 (X);		/*		R3=0x0(  0) */
8d4dbc20:	1f 18       	IF CC JUMP 0x0x8d4dbc5e;
8d4dbc22:	0d 60       	R5 = 0x1 (X);		/*		R5=0x0(  0) */
8d4dbc24:	03 0c       	CC = R3 == 0x0;
8d4dbc26:	15 10       	IF !CC JUMP 0x0x8d4dbc50;
8d4dbc28:	07 0c       	CC = R7 == 0x0;
8d4dbc2a:	0c 10       	IF !CC JUMP 0x0x8d4dbc42;
8d4dbc2c:	06 30       	R0 = R6;
8d4dbc2e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dbc32:	38 1a 00 00 
8d4dbc36:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dbc38:	05 30       	R0 = R5;
8d4dbc3a:	20 05       	(R7:4) = [SP++];
8d4dbc3c:	01 e8 00 00 	UNLINK;
8d4dbc40:	10 00       	RTS;
8d4dbc42:	47 30       	R0 = FP;
8d4dbc44:	40 67       	R0 += -0x18;		/* (-24) */
8d4dbc46:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dbc4a:	38 1a 00 00 
8d4dbc4e:	ef 2f       	JUMP.S 0x0x8d4dbc2c;
8d4dbc50:	47 30       	R0 = FP;
8d4dbc52:	a0 67       	R0 += -0xc;		/* (-12) */
8d4dbc54:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dbc58:	38 1a 00 00 
8d4dbc5c:	e6 2f       	JUMP.S 0x0x8d4dbc28;
8d4dbc5e:	82 64       	R2 += 0x10;		/* ( 16) */
8d4dbc60:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP + 0xc] = R2 || NOP;
8d4dbc64:	fa b0 00 00 
8d4dbc68:	01 da 03 84 	R1=-2080152896;
8d4dbc6c:	c0 62 00 00 
8d4dbc70:	00 de 05 8c 	CALL.A 0x8c0526cc;
8d4dbc74:	cc 26 00 00 
8d4dbc78:	b8 b0       	[FP + 0x8] = R0;
8d4dbc7a:	7f 30       	R7 = FP;
8d4dbc7c:	47 67       	R7 += -0x18;		/* (-24) */
8d4dbc7e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0xc] || NOP;
8d4dbc82:	f9 a0 00 00 
8d4dbc86:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4dbc8a:	a8 19 00 00 
8d4dbc8e:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4dbc92:	b8 a0 00 00 
8d4dbc96:	00 de 05 8c 	CALL.A 0x8c051b42;
8d4dbc9a:	42 1b 00 00 
8d4dbc9e:	00 0c       	CC = R0 == 0x0;
8d4dbca0:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8d4dbca2:	03 60       	R3 = 0x0 (X);		/*		R3=0x0(  0) */
8d4dbca4:	bf 17       	IF !CC JUMP 0x0x8d4dbc22 (BP);
8d4dbca6:	04 30       	R0 = R4;
8d4dbca8:	01 da 03 84 	R1=-2080152896;
8d4dbcac:	c0 62 00 00 
8d4dbcb0:	00 de 05 8c 	CALL.A 0x8c0526cc;
8d4dbcb4:	cc 26 00 00 
8d4dbcb8:	b8 b0       	[FP + 0x8] = R0;
8d4dbcba:	07 da 03 84 	R7=-2080152896;
8d4dbcbe:	c0 62 00 00 
8d4dbcc2:	67 30       	R4 = FP;
8d4dbcc4:	a4 67       	R4 += -0xc;		/* (-12) */
8d4dbcc6:	c7 64       	R7 += 0x18;		/* ( 24) */
8d4dbcc8:	0f 30       	R1 = R7;
8d4dbcca:	04 30       	R0 = R4;
8d4dbccc:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4dbcd0:	a8 19 00 00 
8d4dbcd4:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4dbcd8:	b8 a0 00 00 
8d4dbcdc:	00 de 05 8c 	CALL.A 0x8c051b42;
8d4dbce0:	42 1b 00 00 
8d4dbce4:	00 0c       	CC = R0 == 0x0;
8d4dbce6:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8d4dbce8:	0b 60       	R3 = 0x1 (X);		/*		R3=0x0(  0) */
8d4dbcea:	9c 13       	IF !CC JUMP 0x0x8d4dbc22;
8d4dbcec:	9c 2f       	JUMP.S 0x0x8d4dbc24;
8d4dbcee:	00 00       	NOP;
8d4dbcf0:	00 00       	NOP;
8d4dbcf2:	00 00       	NOP;
8d4dbcf4:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4dbcf8:	04 cc 09 42 	R1 = R1 - R1 (NS) || [SP + 0xc] = P5 || NOP;
8d4dbcfc:	f5 bc 00 00 
8d4dbd00:	28 32       	P5 = R0;
8d4dbd02:	68 a0       	R0 = [P5 + 0x4];
8d4dbd04:	80 0c       	CC = R0 < 0x0;
8d4dbd06:	04 18       	IF CC JUMP 0x0x8d4dbd0e;
8d4dbd08:	71 60       	R1 = 0xe (X);		/*		R1=0x0(  0) */
8d4dbd0a:	88 08       	CC = R0 < R1;
8d4dbd0c:	01 02       	R1 = CC;
8d4dbd0e:	01 0c       	CC = R1 == 0x0;
8d4dbd10:	08 18       	IF CC JUMP 0x0x8d4dbd20;
8d4dbd12:	f5 ac       	P5 = [SP + 0xc];
8d4dbd14:	01 e8 00 00 	UNLINK;
8d4dbd18:	10 00       	RTS;
8d4dbd1a:	00 00       	NOP;
8d4dbd1c:	00 00       	NOP;
8d4dbd1e:	00 00       	NOP;
8d4dbd20:	00 da 03 84 	R0=-2080152160;
8d4dbd24:	a0 65 00 00 
8d4dbd28:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d4dbd2c:	a4 05 00 00 
8d4dbd30:	03 c8 00 18 	MNOP || P5 = [SP + 0xc] || R0 = [P5 + 0x4];
8d4dbd34:	f5 ac 68 a0 
8d4dbd38:	01 e8 00 00 	UNLINK;
8d4dbd3c:	10 00       	RTS;
8d4dbd3e:	00 00       	NOP;
8d4dbd40:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dbd44:	f5 05       	[--SP] = (R7:6, P5:5);
8d4dbd46:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dbd48:	28 32       	P5 = R0;
8d4dbd4a:	38 30       	R7 = R0;
8d4dbd4c:	ff e3 d4 ff 	CALL 0x0x8d4dbcf4;
8d4dbd50:	04 e3 68 ba 	CALL 0x0x8d573220;
8d4dbd54:	08 32       	P1 = R0;
8d4dbd56:	29 e4 48 00 	R1 = [P5 + 0x120];
8d4dbd5a:	07 30       	R0 = R7;
8d4dbd5c:	89 b2       	[P1 + 0x28] = R1;
8d4dbd5e:	a9 e4 24 01 	R1 = B[P5 + 0x124] (Z);
8d4dbd62:	89 e6 2c 00 	B[P1 + 0x2c] = R1;
8d4dbd66:	ff e3 c7 ff 	CALL 0x0x8d4dbcf4;
8d4dbd6a:	46 43       	R6 = R0.B (Z);
8d4dbd6c:	07 30       	R0 = R7;
8d4dbd6e:	ff e3 c3 ff 	CALL 0x0x8d4dbcf4;
8d4dbd72:	04 e3 8b bb 	CALL 0x0x8d573488;
8d4dbd76:	10 30       	R2 = R0;
8d4dbd78:	29 e4 48 00 	R1 = [P5 + 0x120];
8d4dbd7c:	06 30       	R0 = R6;
8d4dbd7e:	ff e3 f1 d2 	CALL 0x0x8d4d6360;
8d4dbd82:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dbd84:	b5 05       	(R7:6, P5:5) = [SP++];
8d4dbd86:	01 e8 00 00 	UNLINK;
8d4dbd8a:	10 00       	RTS;
8d4dbd8c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dbd90:	f5 05       	[--SP] = (R7:6, P5:5);
8d4dbd92:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dbd94:	28 32       	P5 = R0;
8d4dbd96:	38 30       	R7 = R0;
8d4dbd98:	ff e3 ae ff 	CALL 0x0x8d4dbcf4;
8d4dbd9c:	04 e3 42 ba 	CALL 0x0x8d573220;
8d4dbda0:	08 32       	P1 = R0;
8d4dbda2:	29 e4 46 00 	R1 = [P5 + 0x118];
8d4dbda6:	07 30       	R0 = R7;
8d4dbda8:	09 b2       	[P1 + 0x20] = R1;
8d4dbdaa:	a9 e4 1c 01 	R1 = B[P5 + 0x11c] (Z);
8d4dbdae:	89 e6 24 00 	B[P1 + 0x24] = R1;
8d4dbdb2:	ff e3 a1 ff 	CALL 0x0x8d4dbcf4;
8d4dbdb6:	46 43       	R6 = R0.B (Z);
8d4dbdb8:	07 30       	R0 = R7;
8d4dbdba:	ff e3 9d ff 	CALL 0x0x8d4dbcf4;
8d4dbdbe:	04 e3 8d bb 	CALL 0x0x8d5734d8;
8d4dbdc2:	10 30       	R2 = R0;
8d4dbdc4:	29 e4 46 00 	R1 = [P5 + 0x118];
8d4dbdc8:	06 30       	R0 = R6;
8d4dbdca:	ff e3 25 d3 	CALL 0x0x8d4d6414;
8d4dbdce:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dbdd0:	b5 05       	(R7:6, P5:5) = [SP++];
8d4dbdd2:	01 e8 00 00 	UNLINK;
8d4dbdd6:	10 00       	RTS;
8d4dbdd8:	0a 32       	P1 = R2;
8d4dbdda:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dbdde:	70 05       	[--SP] = (R7:6);
8d4dbde0:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dbde2:	01 32       	P0 = R1;
8d4dbde4:	89 a1       	R1 = [P1 + 0x18];
8d4dbde6:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8d4dbde8:	51 32       	P2 = P1;
8d4dbdea:	21 6c       	P1 += 0x4;		/* (  4) */
8d4dbdec:	08 0a       	CC = R0 <= R1 (IU);
8d4dbdee:	49 30       	R1 = P1;
8d4dbdf0:	02 10       	IF !CC JUMP 0x0x8d4dbdf4;
8d4dbdf2:	09 91       	R1 = [P1];
8d4dbdf4:	03 c8 00 18 	MNOP || R2 = [P0 + 0x18] || R6 = [P2 + 0x14];
8d4dbdf8:	82 a1 56 a1 
8d4dbdfc:	10 0a       	CC = R0 <= R2 (IU);
8d4dbdfe:	82 ce 06 c4 	R2 = ROT R6 BY 0x0 || R7 = [P0 + 0x14] || NOP;
8d4dbe02:	47 a1 00 00 
8d4dbe06:	20 6c       	P0 += 0x4;		/* (  4) */
8d4dbe08:	40 30       	R0 = P0;
8d4dbe0a:	02 10       	IF !CC JUMP 0x0x8d4dbe0e;
8d4dbe0c:	00 91       	R0 = [P0];
8d4dbe0e:	b7 09       	CC = R7 < R6 (IU);
8d4dbe10:	17 07       	IF CC R2 = R7;
8d4dbe12:	00 de 02 04 	CALL.A 0x04023068;
8d4dbe16:	68 30 00 00 
8d4dbe1a:	00 0c       	CC = R0 == 0x0;
8d4dbe1c:	0c 10       	IF !CC JUMP 0x0x8d4dbe34;
8d4dbe1e:	b7 09       	CC = R7 < R6 (IU);
8d4dbe20:	f8 63       	R0 = -0x1 (X);		/*		R0=0x0(  0) */
8d4dbe22:	03 18       	IF CC JUMP 0x0x8d4dbe28;
8d4dbe24:	3e 08       	CC = R6 == R7;
8d4dbe26:	10 02       	ILLEGAL;
8d4dbe28:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dbe2a:	30 05       	(R7:6) = [SP++];
8d4dbe2c:	01 e8 00 00 	UNLINK;
8d4dbe30:	f8 4e       	R0 >>= 0x1f;
8d4dbe32:	10 00       	RTS;
8d4dbe34:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dbe36:	30 05       	(R7:6) = [SP++];
8d4dbe38:	01 e8 00 00 	UNLINK;
8d4dbe3c:	f8 4e       	R0 >>= 0x1f;
8d4dbe3e:	10 00       	RTS;
8d4dbe40:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dbe44:	f4 05       	[--SP] = (R7:6, P5:4);
8d4dbe46:	29 32       	P5 = R1;
8d4dbe48:	86 6f       	SP += -0x10;		/* (-16) */
8d4dbe4a:	30 30       	R6 = R0;
8d4dbe4c:	26 32       	P4 = R6;
8d4dbe4e:	01 da e3 38 	R1=954437177;
8d4dbe52:	39 8e 00 00 
8d4dbe56:	04 cc 00 40 	R0 = R0 - R0 (NS) || R2 = [P5 + 0x8] || R3 = [P5 + 0x4];
8d4dbe5a:	aa a0 6b a0 
8d4dbe5e:	9a 52       	R2 = R2 - R3;
8d4dbe60:	82 c6 0a 0f 	R7 = R2 >>> 0x1f;
8d4dbe64:	79 ca 91 20 	(R3:2) = R2 * R1 (IS,NS) || [P4 + 0x4] = R0 || NOP;
8d4dbe68:	60 b0 00 00 
8d4dbe6c:	82 ce e3 03 	R1 = R3 >>> 0x4 || [P4 + 0x8] = R0 || NOP;
8d4dbe70:	a0 b0 00 00 
8d4dbe74:	04 cc 0f 42 	R1 = R1 - R7 (NS) || [P4 + 0xc] = R0 || NOP;
8d4dbe78:	e0 b0 00 00 
8d4dbe7c:	01 0c       	CC = R1 == 0x0;
8d4dbe7e:	1b 18       	IF CC JUMP 0x0x8d4dbeb4;
8d4dbe80:	00 da 8e 03 	R0=59652323;
8d4dbe84:	e3 38 00 00 
8d4dbe88:	88 09       	CC = R0 < R1 (IU);
8d4dbe8a:	07 10       	IF !CC JUMP 0x0x8d4dbe98;
8d4dbe8c:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4dbe90:	24 2b 00 00 
8d4dbe94:	00 00       	NOP;
8d4dbe96:	00 00       	NOP;
8d4dbe98:	20 e1 48 00 	R0 = 0x48 (X);		/*		R0=0x48( 72) */
8d4dbe9c:	71 c2 c8 21 	R7 = R1 * R0 (IS,NS);
8d4dbea0:	07 30       	R0 = R7;
8d4dbea2:	ff e3 99 92 	CALL 0x0x8d4ce3d4;
8d4dbea6:	04 cc 07 02 	R1 = R0 + R7 (NS) || [P4 + 0x4] = R0 || NOP;
8d4dbeaa:	60 b0 00 00 
8d4dbeae:	e1 b0       	[P4 + 0xc] = R1;
8d4dbeb0:	a0 b0       	[P4 + 0x8] = R0;
8d4dbeb2:	08 60       	R0 = 0x1 (X);		/*		R0=0x48( 72) */
8d4dbeb4:	00 0c       	CC = R0 == 0x0;
8d4dbeb6:	09 10       	IF !CC JUMP 0x0x8d4dbec8;
8d4dbeb8:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dbeba:	b4 05       	(R7:6, P5:4) = [SP++];
8d4dbebc:	01 e8 00 00 	UNLINK;
8d4dbec0:	10 00       	RTS;
8d4dbec2:	00 00       	NOP;
8d4dbec4:	00 00       	NOP;
8d4dbec6:	00 00       	NOP;
8d4dbec8:	03 c8 00 18 	MNOP || [SP + 0xc] = R6 || R0 = [P5 + 0x4];
8d4dbecc:	f6 b0 68 a0 
8d4dbed0:	03 c8 00 18 	MNOP || R1 = [P5 + 0x8] || R2 = [P4 + 0x4];
8d4dbed4:	a9 a0 62 a0 
8d4dbed8:	00 e3 68 03 	CALL 0x0x8d4dc5a8;
8d4dbedc:	a0 b0       	[P4 + 0x8] = R0;
8d4dbede:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dbee0:	b4 05       	(R7:6, P5:4) = [SP++];
8d4dbee2:	01 e8 00 00 	UNLINK;
8d4dbee6:	10 00       	RTS;
8d4dbee8:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4dbeec:	00 e3 06 00 	CALL 0x0x8d4dbef8;
8d4dbef0:	01 e8 00 00 	UNLINK;
8d4dbef4:	10 00       	RTS;
8d4dbef6:	00 00       	NOP;
8d4dbef8:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dbefc:	60 05       	[--SP] = (R7:4);
8d4dbefe:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dbf00:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [SP + 0x24] = R1 || NOP;
8d4dbf04:	71 b2 00 00 
8d4dbf08:	24 e1 48 00 	R4 = 0x48 (X);		/*		R4=0x48( 72) */
8d4dbf0c:	3a 30       	R7 = R2;
8d4dbf0e:	31 30       	R6 = R1;
8d4dbf10:	70 a2       	R0 = [SP + 0x24];
8d4dbf12:	01 08       	CC = R1 == R0;
8d4dbf14:	10 18       	IF CC JUMP 0x0x8d4dbf34;
8d4dbf16:	22 50       	R0 = R2 + R4;
8d4dbf18:	28 30       	R5 = R0;
8d4dbf1a:	07 30       	R0 = R7;
8d4dbf1c:	00 e3 52 00 	CALL 0x0x8d4dbfc0;
8d4dbf20:	04 cc 34 02 	R1 = R6 + R4 (NS) || R2 = [SP + 0x24] || NOP;
8d4dbf24:	72 a2 00 00 
8d4dbf28:	0a 08       	CC = R2 == R1;
8d4dbf2a:	e7 51       	R7 = R7 + R4;
8d4dbf2c:	25 50       	R0 = R5 + R4;
8d4dbf2e:	31 30       	R6 = R1;
8d4dbf30:	f4 17       	IF !CC JUMP 0x0x8d4dbf18 (BP);
8d4dbf32:	15 30       	R2 = R5;
8d4dbf34:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dbf36:	20 05       	(R7:4) = [SP++];
8d4dbf38:	01 e8 00 00 	UNLINK;
8d4dbf3c:	02 30       	R0 = R2;
8d4dbf3e:	10 00       	RTS;
8d4dbf40:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dbf44:	e3 05       	[--SP] = (R7:4, P5:3);
8d4dbf46:	32 30       	R6 = R2;
8d4dbf48:	31 08       	CC = R1 == R6;
8d4dbf4a:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dbf4c:	15 18       	IF CC JUMP 0x0x8d4dbf76;
8d4dbf4e:	39 30       	R7 = R1;
8d4dbf50:	21 64       	R1 += 0x4;		/* (  4) */
8d4dbf52:	29 32       	P5 = R1;
8d4dbf54:	84 60       	R4 = 0x10 (X);		/*		R4=0x48( 72) */
8d4dbf56:	05 60       	R5 = 0x0 (X);		/*		R5=0x0(  0) */
8d4dbf58:	23 69       	P3 = 0x24 (X);		/*		P3=0x0(  0) */
8d4dbf5a:	65 32       	P4 = P5;
8d4dbf5c:	85 6c       	P5 += 0x10;		/* ( 16) */
8d4dbf5e:	68 a0       	R0 = [P5 + 0x4];
8d4dbf60:	04 0a       	CC = R4 <= R0 (IU);
8d4dbf62:	0f 18       	IF CC JUMP 0x0x8d4dbf80;
8d4dbf64:	78 60       	R0 = 0xf (X);		/*		R0=0x48( 72) */
8d4dbf66:	27 65       	R7 += 0x24;		/* ( 36) */
8d4dbf68:	68 b0       	[P5 + 0x4] = R0;
8d4dbf6a:	5d 89       	[P5 ++ P3] = R5;
8d4dbf6c:	3e 08       	CC = R6 == R7;
8d4dbf6e:	ad e6 cc ff 	B[P5 + -0x34] = R5;
8d4dbf72:	24 6d       	P4 += 0x24;		/* ( 36) */
8d4dbf74:	f5 17       	IF !CC JUMP 0x0x8d4dbf5e (BP);
8d4dbf76:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dbf78:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dbf7a:	01 e8 00 00 	UNLINK;
8d4dbf7e:	10 00       	RTS;
8d4dbf80:	20 91       	R0 = [P4];
8d4dbf82:	ff e3 31 92 	CALL 0x0x8d4ce3e4;
8d4dbf86:	ef 2f       	JUMP.S 0x0x8d4dbf64;
8d4dbf88:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dbf8c:	68 05       	[--SP] = (R7:5);
8d4dbf8e:	2a 30       	R5 = R2;
8d4dbf90:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dbf92:	29 08       	CC = R1 == R5;
8d4dbf94:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || R0 = [SP + 0x2c] || R6 = [SP + 0x2c];
8d4dbf98:	f0 a2 f6 a2 
8d4dbf9c:	0c 18       	IF CC JUMP 0x0x8d4dbfb4;
8d4dbf9e:	06 0c       	CC = R6 == 0x0;
8d4dbfa0:	05 18       	IF CC JUMP 0x0x8d4dbfaa;
8d4dbfa2:	0f 30       	R1 = R7;
8d4dbfa4:	06 30       	R0 = R6;
8d4dbfa6:	ff e3 23 fc 	CALL 0x0x8d4db7ec;
8d4dbfaa:	27 65       	R7 += 0x24;		/* ( 36) */
8d4dbfac:	3d 08       	CC = R5 == R7;
8d4dbfae:	26 65       	R6 += 0x24;		/* ( 36) */
8d4dbfb0:	f7 17       	IF !CC JUMP 0x0x8d4dbf9e (BP);
8d4dbfb2:	06 30       	R0 = R6;
8d4dbfb4:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dbfb6:	28 05       	(R7:5) = [SP++];
8d4dbfb8:	01 e8 00 00 	UNLINK;
8d4dbfbc:	10 00       	RTS;
8d4dbfbe:	00 00       	NOP;
8d4dbfc0:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d4dbfc4:	e3 05       	[--SP] = (R7:4, P5:3);
8d4dbfc6:	86 6f       	SP += -0x10;		/* (-16) */
8d4dbfc8:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0x34] = R1 || NOP;
8d4dbfcc:	71 b3 00 00 
8d4dbfd0:	03 c8 00 18 	MNOP || P4 = [SP + 0x34] || [FP + 0xc] = R0;
8d4dbfd4:	74 af f8 b0 
8d4dbfd8:	fd ac       	P5 = [FP + 0xc];
8d4dbfda:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4dbfde:	b8 00 03 00 
8d4dbfe2:	f3 b0       	[SP + 0xc] = R3;
8d4dbfe4:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dbfe8:	70 e9 00 00 
8d4dbfec:	03 c8 00 18 	MNOP || R1 = [P4 + 0x1c] || [FP + 0x8] = P4;
8d4dbff0:	e1 a1 bc bc 
8d4dbff4:	03 c8 00 18 	MNOP || P2 = [FP + 0x8] || [P5 + 0x1c] = R1;
8d4dbff8:	ba ac e9 b1 
8d4dbffc:	a0 e4 20 00 	R0 = B[P4 + 0x20] (Z);
8d4dc000:	a8 e6 20 00 	B[P5 + 0x20] = R0;
8d4dc004:	3d bd       	[FP + 0x10] = P5;
8d4dc006:	24 6d       	P4 += 0x24;		/* ( 36) */
8d4dc008:	25 6d       	P5 += 0x24;		/* ( 36) */
8d4dc00a:	6c 08       	CC = P4 == P5;
8d4dc00c:	3c ad       	P4 = [FP + 0x10];
8d4dc00e:	63 18       	IF CC JUMP 0x0x8d4dc0d4;
8d4dc010:	07 da e3 38 	R7=954437177;
8d4dc014:	39 8e 00 00 
8d4dc018:	03 c8 00 18 	MNOP || R4 = [P2 + 0x2c] || R5 = [P2 + 0x28];
8d4dc01c:	d4 a2 95 a2 
8d4dc020:	04 cc 25 46 	R3 = R4 - R5 (NS) || P3 = [P2 + 0x28] || R6 = [P4 + 0x28];
8d4dc024:	93 ae a6 a2 
8d4dc028:	82 c6 0b 05 	R2 = R3 >>> 0x1f;
8d4dc02c:	79 c2 1f 20 	(R1:0) = R3 * R7 (IS,NS);
8d4dc030:	82 ce e9 03 	R1 = R1 >>> 0x3 || R0 = [P4 + 0x2c] || NOP;
8d4dc034:	e0 a2 00 00 
8d4dc038:	04 cc 0a 44 	R2 = R1 - R2 (NS) || [SP + 0x30] = R0 || NOP;
8d4dc03c:	30 b3 00 00 
8d4dc040:	02 0c       	CC = R2 == 0x0;
8d4dc042:	e4 18       	IF CC JUMP 0x0x8d4dc20a;
8d4dc044:	30 52       	R0 = R0 - R6;
8d4dc046:	82 c6 08 07 	R3 = R0 >>> 0x1f;
8d4dc04a:	79 c2 07 20 	(R1:0) = R0 * R7 (IS,NS);
8d4dc04e:	19 4d       	R1 >>>= 0x3;
8d4dc050:	d9 52       	R3 = R1 - R3;
8d4dc052:	1a 0a       	CC = R2 <= R3 (IU);
8d4dc054:	26 32       	P4 = R6;
8d4dc056:	a1 18       	IF CC JUMP 0x0x8d4dc198;
8d4dc058:	06 0c       	CC = R6 == 0x0;
8d4dc05a:	00 60       	R0 = 0x0 (X);		/*		R0=0x48( 72) */
8d4dc05c:	0d 18       	IF CC JUMP 0x0x8d4dc076;
8d4dc05e:	e8 a0       	R0 = [P5 + 0xc];
8d4dc060:	30 52       	R0 = R0 - R6;
8d4dc062:	82 c6 08 03 	R1 = R0 >>> 0x1f;
8d4dc066:	79 ca 07 20 	(R1:0) = R0 * R7 (IS,NS) || [SP + 0x2c] = R1 || NOP;
8d4dc06a:	f1 b2 00 00 
8d4dc06e:	82 c6 e9 01 	R0 = R1 >>> 0x3;
8d4dc072:	f1 a2       	R1 = [SP + 0x2c];
8d4dc074:	08 52       	R0 = R0 - R1;
8d4dc076:	02 0a       	CC = R2 <= R0 (IU);
8d4dc078:	44 10       	IF !CC JUMP 0x0x8d4dc100;
8d4dc07a:	27 61       	R7 = 0x24 (X);		/*		R7=0x0(  0) */
8d4dc07c:	30 a3       	R0 = [SP + 0x30];
8d4dc07e:	71 c2 5f 20 	R1 = R3 * R7 (IS,NS);
8d4dc082:	8d 51       	R6 = R5 + R1;
8d4dc084:	35 08       	CC = R5 == R6;
8d4dc086:	1e 18       	IF CC JUMP 0x0x8d4dc0c2;
8d4dc088:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d4dc08c:	b8 00 00 00 
8d4dc090:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d4dc094:	f0 b0 00 00 
8d4dc098:	44 30       	R0 = P4;
8d4dc09a:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4dc09c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dc0a0:	70 e9 00 00 
8d4dc0a4:	04 cc 2f 0a 	R5 = R5 + R7 (NS) || P1 = [FP + 0x8] || R0 = [P3 + 0x1c];
8d4dc0a8:	b9 ac d8 a1 
8d4dc0ac:	e0 b1       	[P4 + 0x1c] = R0;
8d4dc0ae:	2e 08       	CC = R6 == R5;
8d4dc0b0:	98 e4 20 00 	R0 = B[P3 + 0x20] (Z);
8d4dc0b4:	a0 e6 20 00 	B[P4 + 0x20] = R0;
8d4dc0b8:	23 6d       	P3 += 0x24;		/* ( 36) */
8d4dc0ba:	24 6d       	P4 += 0x24;		/* ( 36) */
8d4dc0bc:	e6 17       	IF !CC JUMP 0x0x8d4dc088 (BP);
8d4dc0be:	a8 a0       	R0 = [P5 + 0x8];
8d4dc0c0:	cc a2       	R4 = [P1 + 0x2c];
8d4dc0c2:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d4dc0c6:	f0 b0 00 00 
8d4dc0ca:	14 30       	R2 = R4;
8d4dc0cc:	45 30       	R0 = P5;
8d4dc0ce:	ff e3 5d ff 	CALL 0x0x8d4dbf88;
8d4dc0d2:	a8 b0       	[P5 + 0x8] = R0;
8d4dc0d4:	03 c8 00 18 	MNOP || R0 = [FP + 0xc] || R1 = [SP + 0x34];
8d4dc0d8:	f8 a0 71 a3 
8d4dc0dc:	a1 65       	R1 += 0x34;		/* ( 52) */
8d4dc0de:	a0 65       	R0 += 0x34;		/* ( 52) */
8d4dc0e0:	00 e3 a0 00 	CALL 0x0x8d4dc220;
8d4dc0e4:	03 c8 00 18 	MNOP || P1 = [FP + 0x8] || R0 = [FP + 0xc];
8d4dc0e8:	b9 ac f8 a0 
8d4dc0ec:	38 ad       	P0 = [FP + 0x10];
8d4dc0ee:	09 e4 11 00 	R1 = [P1 + 0x44];
8d4dc0f2:	01 e6 11 00 	[P0 + 0x44] = R1;
8d4dc0f6:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc0f8:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dc0fa:	01 e8 00 00 	UNLINK;
8d4dc0fe:	10 00       	RTS;
8d4dc100:	06 0c       	CC = R6 == 0x0;
8d4dc102:	10 18       	IF CC JUMP 0x0x8d4dc122;
8d4dc104:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R2 = [SP + 0x30] || NOP;
8d4dc108:	32 a3 00 00 
8d4dc10c:	45 30       	R0 = P5;
8d4dc10e:	ff e3 19 ff 	CALL 0x0x8d4dbf40;
8d4dc112:	68 a0       	R0 = [P5 + 0x4];
8d4dc114:	ff e3 68 91 	CALL 0x0x8d4ce3e4;
8d4dc118:	b8 ac       	P0 = [FP + 0x8];
8d4dc11a:	03 c8 00 18 	MNOP || R4 = [P0 + 0x2c] || R5 = [P0 + 0x28];
8d4dc11e:	c4 a2 85 a2 
8d4dc122:	ac 52       	R2 = R4 - R5;
8d4dc124:	82 c6 0a 0b 	R5 = R2 >>> 0x1f;
8d4dc128:	79 c2 17 20 	(R1:0) = R2 * R7 (IS,NS);
8d4dc12c:	82 c6 e9 01 	R0 = R1 >>> 0x3;
8d4dc130:	28 52       	R0 = R0 - R5;
8d4dc132:	06 60       	R6 = 0x0 (X);		/*		R6=0x0(  0) */
8d4dc134:	04 cc 1b 46 	R3 = R3 - R3 (NS) || [P5 + 0x4] = R6 || NOP;
8d4dc138:	6e b0 00 00 
8d4dc13c:	04 cc 24 48 	R4 = R4 - R4 (NS) || [P5 + 0xc] = R3 || NOP;
8d4dc140:	eb b0 00 00 
8d4dc144:	00 0c       	CC = R0 == 0x0;
8d4dc146:	ac b0       	[P5 + 0x8] = R4;
8d4dc148:	18 18       	IF CC JUMP 0x0x8d4dc178;
8d4dc14a:	01 da 1c 07 	R1=119304647;
8d4dc14e:	c7 71 00 00 
8d4dc152:	81 09       	CC = R1 < R0 (IU);
8d4dc154:	05 10       	IF !CC JUMP 0x0x8d4dc15e;
8d4dc156:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4dc15a:	24 2b 00 00 
8d4dc15e:	21 61       	R1 = 0x24 (X);		/*		R1=0x0(  0) */
8d4dc160:	0e 60       	R6 = 0x1 (X);		/*		R6=0x0(  0) */
8d4dc162:	71 c2 c1 21 	R7 = R0 * R1 (IS,NS);
8d4dc166:	07 30       	R0 = R7;
8d4dc168:	ff e3 36 91 	CALL 0x0x8d4ce3d4;
8d4dc16c:	04 cc 07 02 	R1 = R0 + R7 (NS) || [P5 + 0x4] = R0 || NOP;
8d4dc170:	68 b0 00 00 
8d4dc174:	e9 b0       	[P5 + 0xc] = R1;
8d4dc176:	a8 b0       	[P5 + 0x8] = R0;
8d4dc178:	06 0c       	CC = R6 == 0x0;
8d4dc17a:	ad 1f       	IF CC JUMP 0x0x8d4dc0d4 (BP);
8d4dc17c:	03 c8 00 18 	MNOP || P0 = [FP + 0x8] || R3 = [P5 + 0x4];
8d4dc180:	b8 ac 6b a0 
8d4dc184:	f3 b0       	[SP + 0xc] = R3;
8d4dc186:	45 30       	R0 = P5;
8d4dc188:	03 c8 00 18 	MNOP || R1 = [P0 + 0x28] || R2 = [P0 + 0x2c];
8d4dc18c:	81 a2 c2 a2 
8d4dc190:	ff e3 fc fe 	CALL 0x0x8d4dbf88;
8d4dc194:	a8 b0       	[P5 + 0x8] = R0;
8d4dc196:	9f 2f       	JUMP.S 0x0x8d4dc0d4;
8d4dc198:	2c 08       	CC = R4 == R5;
8d4dc19a:	32 a3       	R2 = [SP + 0x30];
8d4dc19c:	1e 18       	IF CC JUMP 0x0x8d4dc1d8;
8d4dc19e:	26 61       	R6 = 0x24 (X);		/*		R6=0x0(  0) */
8d4dc1a0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d4dc1a4:	b8 00 00 00 
8d4dc1a8:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d4dc1ac:	f0 b0 00 00 
8d4dc1b0:	44 30       	R0 = P4;
8d4dc1b2:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4dc1b4:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dc1b8:	70 e9 00 00 
8d4dc1bc:	04 cc 2e 0a 	R5 = R5 + R6 (NS) || R0 = [P3 + 0x1c] || NOP;
8d4dc1c0:	d8 a1 00 00 
8d4dc1c4:	e0 b1       	[P4 + 0x1c] = R0;
8d4dc1c6:	2c 08       	CC = R4 == R5;
8d4dc1c8:	98 e4 20 00 	R0 = B[P3 + 0x20] (Z);
8d4dc1cc:	a0 e6 20 00 	B[P4 + 0x20] = R0;
8d4dc1d0:	23 6d       	P3 += 0x24;		/* ( 36) */
8d4dc1d2:	24 6d       	P4 += 0x24;		/* ( 36) */
8d4dc1d4:	e6 17       	IF !CC JUMP 0x0x8d4dc1a0 (BP);
8d4dc1d6:	aa a0       	R2 = [P5 + 0x8];
8d4dc1d8:	4c 30       	R1 = P4;
8d4dc1da:	45 30       	R0 = P5;
8d4dc1dc:	ff e3 b2 fe 	CALL 0x0x8d4dbf40;
8d4dc1e0:	03 c8 00 18 	MNOP || P0 = [FP + 0x8] || R6 = [P5 + 0x4];
8d4dc1e4:	b8 ac 6e a0 
8d4dc1e8:	25 61       	R5 = 0x24 (X);		/*		R5=0x0(  0) */
8d4dc1ea:	03 c8 00 18 	MNOP || R0 = [P0 + 0x2c] || R1 = [P0 + 0x28];
8d4dc1ee:	c0 a2 81 a2 
8d4dc1f2:	88 52       	R2 = R0 - R1;
8d4dc1f4:	82 c6 0a 07 	R3 = R2 >>> 0x1f;
8d4dc1f8:	79 c2 17 20 	(R1:0) = R2 * R7 (IS,NS);
8d4dc1fc:	82 c6 e9 01 	R0 = R1 >>> 0x3;
8d4dc200:	18 52       	R0 = R0 - R3;
8d4dc202:	e8 40       	R0 *= R5;
8d4dc204:	06 50       	R0 = R6 + R0;
8d4dc206:	a8 b0       	[P5 + 0x8] = R0;
8d4dc208:	66 2f       	JUMP.S 0x0x8d4dc0d4;
8d4dc20a:	06 08       	CC = R6 == R0;
8d4dc20c:	64 1b       	IF CC JUMP 0x0x8d4dc0d4;
8d4dc20e:	45 30       	R0 = P5;
8d4dc210:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R2 = [SP + 0x30] || NOP;
8d4dc214:	32 a3 00 00 
8d4dc218:	ff e3 94 fe 	CALL 0x0x8d4dbf40;
8d4dc21c:	e6 b2       	[P4 + 0x2c] = R6;
8d4dc21e:	5b 2f       	JUMP.S 0x0x8d4dc0d4;
8d4dc220:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4dc224:	e4 05       	[--SP] = (R7:4, P5:4);
8d4dc226:	20 32       	P4 = R0;
8d4dc228:	29 32       	P5 = R1;
8d4dc22a:	86 6f       	SP += -0x10;		/* (-16) */
8d4dc22c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [FP + 0xc] = R0 || NOP;
8d4dc230:	f8 b0 00 00 
8d4dc234:	05 da e3 38 	R5=954437177;
8d4dc238:	39 8e 00 00 
8d4dc23c:	65 08       	CC = P5 == P4;
8d4dc23e:	88 18       	IF CC JUMP 0x0x8d4dc34e;
8d4dc240:	03 c8 00 18 	MNOP || R1 = [P5 + 0x8] || R3 = [P5 + 0x4];
8d4dc244:	a9 a0 6b a0 
8d4dc248:	04 cc 0b 4c 	R6 = R1 - R3 (NS) || [SP + 0x28] = R1 || R1 = [P4 + 0x8];
8d4dc24c:	b1 b2 a1 a0 
8d4dc250:	79 ca 35 21 	(R5:4) = R6 * R5 (IS,NS) || [FP + 0x8] = R1 || R0 = [P4 + 0x4];
8d4dc254:	b9 b0 60 a0 
8d4dc258:	82 c6 0e 05 	R2 = R6 >>> 0x1f;
8d4dc25c:	82 c6 e5 03 	R1 = R5 >>> 0x4;
8d4dc260:	04 cc 0a 42 	R1 = R1 - R2 (NS) || R2 = [FP + 0x8] || NOP;
8d4dc264:	ba a0 00 00 
8d4dc268:	01 0c       	CC = R1 == 0x0;
8d4dc26a:	f7 18       	IF CC JUMP 0x0x8d4dc458;
8d4dc26c:	82 53       	R6 = R2 - R0;
8d4dc26e:	05 da e3 38 	R5=954437177;
8d4dc272:	39 8e 00 00 
8d4dc276:	79 c2 35 21 	(R5:4) = R6 * R5 (IS,NS);
8d4dc27a:	82 c6 0e 05 	R2 = R6 >>> 0x1f;
8d4dc27e:	82 c6 e5 0d 	R6 = R5 >>> 0x4;
8d4dc282:	96 52       	R2 = R6 - R2;
8d4dc284:	11 0a       	CC = R1 <= R2 (IU);
8d4dc286:	04 cc 36 4c 	R6 = R6 - R6 (NS) || [FP + 0x10] = R2 || NOP;
8d4dc28a:	3a b1 00 00 
8d4dc28e:	b5 18       	IF CC JUMP 0x0x8d4dc3f8;
8d4dc290:	00 0c       	CC = R0 == 0x0;
8d4dc292:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4dc294:	10 18       	IF CC JUMP 0x0x8d4dc2b4;
8d4dc296:	e2 a0       	R2 = [P4 + 0xc];
8d4dc298:	82 52       	R2 = R2 - R0;
8d4dc29a:	82 c6 0a 0b 	R5 = R2 >>> 0x1f;
8d4dc29e:	f5 b2       	[SP + 0x2c] = R5;
8d4dc2a0:	04 da e3 38 	R4=954437177;
8d4dc2a4:	39 8e 00 00 
8d4dc2a8:	79 c2 14 21 	(R5:4) = R2 * R4 (IS,NS);
8d4dc2ac:	82 c6 e5 05 	R2 = R5 >>> 0x4;
8d4dc2b0:	f4 a2       	R4 = [SP + 0x2c];
8d4dc2b2:	a2 52       	R2 = R2 - R4;
8d4dc2b4:	11 0a       	CC = R1 <= R2 (IU);
8d4dc2b6:	71 18       	IF CC JUMP 0x0x8d4dc398;
8d4dc2b8:	00 0c       	CC = R0 == 0x0;
8d4dc2ba:	82 ce 07 c4 	R2 = ROT R7 BY 0x0 || R1 = [SP + 0x28] || NOP;
8d4dc2be:	b1 a2 00 00 
8d4dc2c2:	0b 18       	IF CC JUMP 0x0x8d4dc2d8;
8d4dc2c4:	b9 a0       	R1 = [FP + 0x8];
8d4dc2c6:	ff e3 c5 eb 	CALL 0x0x8d4d9a50;
8d4dc2ca:	60 a0       	R0 = [P4 + 0x4];
8d4dc2cc:	ff e3 8c 90 	CALL 0x0x8d4ce3e4;
8d4dc2d0:	03 c8 00 18 	MNOP || R1 = [P5 + 0x8] || R3 = [P5 + 0x4];
8d4dc2d4:	a9 a0 6b a0 
8d4dc2d8:	04 cc 0b 44 	R2 = R1 - R3 (NS) || [P4 + 0x4] = R6 || NOP;
8d4dc2dc:	66 b0 00 00 
8d4dc2e0:	00 da e3 38 	R0=954437177;
8d4dc2e4:	39 8e 00 00 
8d4dc2e8:	79 ca 10 20 	(R1:0) = R2 * R0 (IS,NS) || [P4 + 0x8] = R6 || NOP;
8d4dc2ec:	a6 b0 00 00 
8d4dc2f0:	82 ce 0a 07 	R3 = R2 >>> 0x1f || [P4 + 0xc] = R6 || NOP;
8d4dc2f4:	e6 b0 00 00 
8d4dc2f8:	82 c6 e1 01 	R0 = R1 >>> 0x4;
8d4dc2fc:	18 52       	R0 = R0 - R3;
8d4dc2fe:	00 0c       	CC = R0 == 0x0;
8d4dc300:	30 10       	IF !CC JUMP 0x0x8d4dc360;
8d4dc302:	06 0c       	CC = R6 == 0x0;
8d4dc304:	25 18       	IF CC JUMP 0x0x8d4dc34e;
8d4dc306:	03 c8 00 18 	MNOP || R0 = [P5 + 0x8] || R1 = [P5 + 0x4];
8d4dc30a:	a8 a0 69 a0 
8d4dc30e:	01 08       	CC = R1 == R0;
8d4dc310:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || [FP + 0x8] = R0 || R5 = [P4 + 0x4];
8d4dc314:	b8 b0 65 a0 
8d4dc318:	12 18       	IF CC JUMP 0x0x8d4dc33c;
8d4dc31a:	24 e1 48 00 	R4 = 0x48 (X);		/*		R4=0x48( 72) */
8d4dc31e:	25 50       	R0 = R5 + R4;
8d4dc320:	35 30       	R6 = R5;
8d4dc322:	28 30       	R5 = R0;
8d4dc324:	06 30       	R0 = R6;
8d4dc326:	00 e3 b2 00 	CALL 0x0x8d4dc48a;
8d4dc32a:	04 cc 3c 02 	R1 = R7 + R4 (NS) || R2 = [FP + 0x8] || NOP;
8d4dc32e:	ba a0 00 00 
8d4dc332:	0a 08       	CC = R2 == R1;
8d4dc334:	a6 51       	R6 = R6 + R4;
8d4dc336:	25 50       	R0 = R5 + R4;
8d4dc338:	39 30       	R7 = R1;
8d4dc33a:	f4 17       	IF !CC JUMP 0x0x8d4dc322 (BP);
8d4dc33c:	03 c8 00 18 	MNOP || [P4 + 0x8] = R5 || R0 = [FP + 0xc];
8d4dc340:	a5 b0 f8 a0 
8d4dc344:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc346:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dc348:	01 e8 00 00 	UNLINK;
8d4dc34c:	10 00       	RTS;
8d4dc34e:	f8 a0       	R0 = [FP + 0xc];
8d4dc350:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc352:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dc354:	01 e8 00 00 	UNLINK;
8d4dc358:	10 00       	RTS;
8d4dc35a:	00 00       	NOP;
8d4dc35c:	00 00       	NOP;
8d4dc35e:	00 00       	NOP;
8d4dc360:	01 da 8e 03 	R1=59652323;
8d4dc364:	e3 38 00 00 
8d4dc368:	81 09       	CC = R1 < R0 (IU);
8d4dc36a:	07 10       	IF !CC JUMP 0x0x8d4dc378;
8d4dc36c:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4dc370:	24 2b 00 00 
8d4dc374:	00 00       	NOP;
8d4dc376:	00 00       	NOP;
8d4dc378:	21 e1 48 00 	R1 = 0x48 (X);		/*		R1=0x48( 72) */
8d4dc37c:	71 c2 c1 21 	R7 = R0 * R1 (IS,NS);
8d4dc380:	07 30       	R0 = R7;
8d4dc382:	ff e3 29 90 	CALL 0x0x8d4ce3d4;
8d4dc386:	04 cc 07 02 	R1 = R0 + R7 (NS) || [P4 + 0x4] = R0 || NOP;
8d4dc38a:	60 b0 00 00 
8d4dc38e:	e1 b0       	[P4 + 0xc] = R1;
8d4dc390:	a0 b0       	[P4 + 0x8] = R0;
8d4dc392:	0e 60       	R6 = 0x1 (X);		/*		R6=0x0(  0) */
8d4dc394:	b7 2f       	JUMP.S 0x0x8d4dc302;
8d4dc396:	00 00       	NOP;
8d4dc398:	25 e1 48 00 	R5 = 0x48 (X);		/*		R5=0x48( 72) */
8d4dc39c:	82 ce 00 c4 	R2 = ROT R0 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d4dc3a0:	39 a1 00 00 
8d4dc3a4:	e9 40       	R1 *= R5;
8d4dc3a6:	cb 51       	R7 = R3 + R1;
8d4dc3a8:	03 30       	R0 = R3;
8d4dc3aa:	0f 30       	R1 = R7;
8d4dc3ac:	ff e3 a6 fd 	CALL 0x0x8d4dbef8;
8d4dc3b0:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [P5 + 0x8] || R4 = [P4 + 0x8];
8d4dc3b4:	a8 a0 a4 a0 
8d4dc3b8:	07 08       	CC = R7 == R0;
8d4dc3ba:	04 cc 25 00 	R0 = R4 + R5 (NS) || [FP + 0x8] = R0 || NOP;
8d4dc3be:	b8 b0 00 00 
8d4dc3c2:	0f 18       	IF CC JUMP 0x0x8d4dc3e0;
8d4dc3c4:	34 30       	R6 = R4;
8d4dc3c6:	20 30       	R4 = R0;
8d4dc3c8:	06 30       	R0 = R6;
8d4dc3ca:	00 e3 60 00 	CALL 0x0x8d4dc48a;
8d4dc3ce:	04 cc 3d 02 	R1 = R7 + R5 (NS) || R2 = [FP + 0x8] || NOP;
8d4dc3d2:	ba a0 00 00 
8d4dc3d6:	0a 08       	CC = R2 == R1;
8d4dc3d8:	ae 51       	R6 = R6 + R5;
8d4dc3da:	2c 50       	R0 = R4 + R5;
8d4dc3dc:	39 30       	R7 = R1;
8d4dc3de:	f4 17       	IF !CC JUMP 0x0x8d4dc3c6 (BP);
8d4dc3e0:	03 c8 00 18 	MNOP || [P4 + 0x8] = R4 || R0 = [FP + 0xc];
8d4dc3e4:	a4 b0 f8 a0 
8d4dc3e8:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc3ea:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dc3ec:	01 e8 00 00 	UNLINK;
8d4dc3f0:	10 00       	RTS;
8d4dc3f2:	00 00       	NOP;
8d4dc3f4:	00 00       	NOP;
8d4dc3f6:	00 00       	NOP;
8d4dc3f8:	82 ce 00 c4 	R2 = ROT R0 BY 0x0 || R1 = [SP + 0x28] || NOP;
8d4dc3fc:	b1 a2 00 00 
8d4dc400:	03 30       	R0 = R3;
8d4dc402:	ff e3 7b fd 	CALL 0x0x8d4dbef8;
8d4dc406:	82 ce 07 c4 	R2 = ROT R7 BY 0x0 || R1 = [P4 + 0x8] || NOP;
8d4dc40a:	a1 a0 00 00 
8d4dc40e:	ff e3 21 eb 	CALL 0x0x8d4d9a50;
8d4dc412:	03 c8 00 18 	MNOP || R0 = [P5 + 0x8] || R1 = [P5 + 0x4];
8d4dc416:	a8 a0 69 a0 
8d4dc41a:	04 cc 01 44 	R2 = R0 - R1 (NS) || R7 = [P4 + 0x4] || NOP;
8d4dc41e:	67 a0 00 00 
8d4dc422:	05 da e3 38 	R5=954437177;
8d4dc426:	39 8e 00 00 
8d4dc42a:	79 c2 15 20 	(R1:0) = R2 * R5 (IS,NS);
8d4dc42e:	82 c6 0a 07 	R3 = R2 >>> 0x1f;
8d4dc432:	82 c6 e1 01 	R0 = R1 >>> 0x4;
8d4dc436:	18 52       	R0 = R0 - R3;
8d4dc438:	26 e1 48 00 	R6 = 0x48 (X);		/*		R6=0x48( 72) */
8d4dc43c:	f0 40       	R0 *= R6;
8d4dc43e:	07 50       	R0 = R7 + R0;
8d4dc440:	03 c8 00 18 	MNOP || [P4 + 0x8] = R0 || R0 = [FP + 0xc];
8d4dc444:	a0 b0 f8 a0 
8d4dc448:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc44a:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dc44c:	01 e8 00 00 	UNLINK;
8d4dc450:	10 00       	RTS;
8d4dc452:	00 00       	NOP;
8d4dc454:	00 00       	NOP;
8d4dc456:	00 00       	NOP;
8d4dc458:	82 ce 00 c4 	R2 = ROT R0 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4dc45c:	b9 a0 00 00 
8d4dc460:	08 08       	CC = R0 == R1;
8d4dc462:	76 1b       	IF CC JUMP 0x0x8d4dc34e;
8d4dc464:	b8 a0       	R0 = [FP + 0x8];
8d4dc466:	ff e3 41 fd 	CALL 0x0x8d4dbee8;
8d4dc46a:	82 ce 07 c4 	R2 = ROT R7 BY 0x0 || R1 = [P4 + 0x8] || NOP;
8d4dc46e:	a1 a0 00 00 
8d4dc472:	30 30       	R6 = R0;
8d4dc474:	ff e3 ee ea 	CALL 0x0x8d4d9a50;
8d4dc478:	03 c8 00 18 	MNOP || [P4 + 0x8] = R6 || R0 = [FP + 0xc];
8d4dc47c:	a6 b0 f8 a0 
8d4dc480:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc482:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dc484:	01 e8 00 00 	UNLINK;
8d4dc488:	10 00       	RTS;
8d4dc48a:	00 0c       	CC = R0 == 0x0;
8d4dc48c:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d4dc490:	03 18       	IF CC JUMP 0x0x8d4dc496;
8d4dc492:	00 e3 5b 00 	CALL 0x0x8d4dc548;
8d4dc496:	01 e8 00 00 	UNLINK;
8d4dc49a:	10 00       	RTS;
8d4dc49c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dc4a0:	ec 05       	[--SP] = (R7:5, P5:4);
8d4dc4a2:	29 32       	P5 = R1;
8d4dc4a4:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dc4a6:	20 32       	P4 = R0;
8d4dc4a8:	00 da e3 38 	R0=954437177;
8d4dc4ac:	39 8e 00 00 
8d4dc4b0:	06 60       	R6 = 0x0 (X);		/*		R6=0x48( 72) */
8d4dc4b2:	03 c8 00 18 	MNOP || R1 = [P5 + 0x8] || R2 = [P5 + 0x4];
8d4dc4b6:	a9 a0 6a a0 
8d4dc4ba:	51 52       	R1 = R1 - R2;
8d4dc4bc:	82 ce 09 05 	R2 = R1 >>> 0x1f || [P4 + 0x4] = R6 || NOP;
8d4dc4c0:	66 b0 00 00 
8d4dc4c4:	79 ca 08 20 	(R1:0) = R1 * R0 (IS,NS) || [P4 + 0x8] = R6 || NOP;
8d4dc4c8:	a6 b0 00 00 
8d4dc4cc:	82 ce e9 01 	R0 = R1 >>> 0x3 || [P4 + 0xc] = R6 || NOP;
8d4dc4d0:	e6 b0 00 00 
8d4dc4d4:	10 52       	R0 = R0 - R2;
8d4dc4d6:	00 0c       	CC = R0 == 0x0;
8d4dc4d8:	20 10       	IF !CC JUMP 0x0x8d4dc518;
8d4dc4da:	06 0c       	CC = R6 == 0x0;
8d4dc4dc:	18 18       	IF CC JUMP 0x0x8d4dc50c;
8d4dc4de:	03 c8 00 18 	MNOP || R6 = [P5 + 0x4] || R5 = [P5 + 0x8];
8d4dc4e2:	6e a0 ad a0 
8d4dc4e6:	2e 08       	CC = R6 == R5;
8d4dc4e8:	67 a0       	R7 = [P4 + 0x4];
8d4dc4ea:	0b 18       	IF CC JUMP 0x0x8d4dc500;
8d4dc4ec:	07 0c       	CC = R7 == 0x0;
8d4dc4ee:	05 18       	IF CC JUMP 0x0x8d4dc4f8;
8d4dc4f0:	0e 30       	R1 = R6;
8d4dc4f2:	07 30       	R0 = R7;
8d4dc4f4:	ff e3 7c f9 	CALL 0x0x8d4db7ec;
8d4dc4f8:	26 65       	R6 += 0x24;		/* ( 36) */
8d4dc4fa:	35 08       	CC = R5 == R6;
8d4dc4fc:	27 65       	R7 += 0x24;		/* ( 36) */
8d4dc4fe:	f7 17       	IF !CC JUMP 0x0x8d4dc4ec (BP);
8d4dc500:	a7 b0       	[P4 + 0x8] = R7;
8d4dc502:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dc504:	ac 05       	(R7:5, P5:4) = [SP++];
8d4dc506:	01 e8 00 00 	UNLINK;
8d4dc50a:	10 00       	RTS;
8d4dc50c:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dc50e:	ac 05       	(R7:5, P5:4) = [SP++];
8d4dc510:	01 e8 00 00 	UNLINK;
8d4dc514:	10 00       	RTS;
8d4dc516:	00 00       	NOP;
8d4dc518:	01 da 1c 07 	R1=119304647;
8d4dc51c:	c7 71 00 00 
8d4dc520:	81 09       	CC = R1 < R0 (IU);
8d4dc522:	05 10       	IF !CC JUMP 0x0x8d4dc52c;
8d4dc524:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4dc528:	24 2b 00 00 
8d4dc52c:	21 61       	R1 = 0x24 (X);		/*		R1=0x48( 72) */
8d4dc52e:	0e 60       	R6 = 0x1 (X);		/*		R6=0x48( 72) */
8d4dc530:	71 c2 c1 21 	R7 = R0 * R1 (IS,NS);
8d4dc534:	07 30       	R0 = R7;
8d4dc536:	ff e3 4f 8f 	CALL 0x0x8d4ce3d4;
8d4dc53a:	04 cc 07 02 	R1 = R0 + R7 (NS) || [P4 + 0x4] = R0 || NOP;
8d4dc53e:	60 b0 00 00 
8d4dc542:	e1 b0       	[P4 + 0xc] = R1;
8d4dc544:	a0 b0       	[P4 + 0x8] = R0;
8d4dc546:	ca 2f       	JUMP.S 0x0x8d4dc4da;
8d4dc548:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dc54c:	e4 05       	[--SP] = (R7:4, P5:4);
8d4dc54e:	38 30       	R7 = R0;
8d4dc550:	2f 32       	P5 = R7;
8d4dc552:	31 30       	R6 = R1;
8d4dc554:	26 32       	P4 = R6;
8d4dc556:	86 6f       	SP += -0x10;		/* (-16) */
8d4dc558:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4dc55a:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d4dc55c:	6a b1       	[P5 + 0x14] = R2;
8d4dc55e:	aa e6 04 00 	B[P5 + 0x4] = R2;
8d4dc562:	ab b1       	[P5 + 0x18] = R3;
8d4dc564:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4dc568:	b8 00 03 00 
8d4dc56c:	f3 b0       	[SP + 0xc] = R3;
8d4dc56e:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dc572:	70 e9 00 00 
8d4dc576:	e0 a1       	R0 = [P4 + 0x1c];
8d4dc578:	e8 b1       	[P5 + 0x1c] = R0;
8d4dc57a:	a0 e4 20 00 	R0 = B[P4 + 0x20] (Z);
8d4dc57e:	25 61       	R5 = 0x24 (X);		/*		R5=0x48( 72) */
8d4dc580:	a8 e6 20 00 	B[P5 + 0x20] = R0;
8d4dc584:	6e 50       	R1 = R6 + R5;
8d4dc586:	2f 50       	R0 = R7 + R5;
8d4dc588:	ff e3 8a ff 	CALL 0x0x8d4dc49c;
8d4dc58c:	a4 61       	R4 = 0x34 (X);		/*		R4=0x48( 72) */
8d4dc58e:	27 50       	R0 = R7 + R4;
8d4dc590:	66 50       	R1 = R6 + R4;
8d4dc592:	ff e3 57 fc 	CALL 0x0x8d4dbe40;
8d4dc596:	20 e4 11 00 	R0 = [P4 + 0x44];
8d4dc59a:	28 e6 11 00 	[P5 + 0x44] = R0;
8d4dc59e:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc5a0:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dc5a2:	01 e8 00 00 	UNLINK;
8d4dc5a6:	10 00       	RTS;
8d4dc5a8:	00 e8 05 00 	LINK 0x14;		/* (20) */
8d4dc5ac:	b3 a2       	R3 = [SP + 0x28];
8d4dc5ae:	f3 b0       	[SP + 0xc] = R3;
8d4dc5b0:	00 e3 06 00 	CALL 0x0x8d4dc5bc;
8d4dc5b4:	01 e8 00 00 	UNLINK;
8d4dc5b8:	10 00       	RTS;
8d4dc5ba:	00 00       	NOP;
8d4dc5bc:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dc5c0:	60 05       	[--SP] = (R7:4);
8d4dc5c2:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dc5c4:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [SP + 0x24] = R1 || NOP;
8d4dc5c8:	71 b2 00 00 
8d4dc5cc:	24 e1 48 00 	R4 = 0x48 (X);		/*		R4=0x48( 72) */
8d4dc5d0:	3a 30       	R7 = R2;
8d4dc5d2:	31 30       	R6 = R1;
8d4dc5d4:	70 a2       	R0 = [SP + 0x24];
8d4dc5d6:	01 08       	CC = R1 == R0;
8d4dc5d8:	10 18       	IF CC JUMP 0x0x8d4dc5f8;
8d4dc5da:	22 50       	R0 = R2 + R4;
8d4dc5dc:	28 30       	R5 = R0;
8d4dc5de:	07 30       	R0 = R7;
8d4dc5e0:	ff e3 55 ff 	CALL 0x0x8d4dc48a;
8d4dc5e4:	04 cc 34 02 	R1 = R6 + R4 (NS) || R2 = [SP + 0x24] || NOP;
8d4dc5e8:	72 a2 00 00 
8d4dc5ec:	0a 08       	CC = R2 == R1;
8d4dc5ee:	e7 51       	R7 = R7 + R4;
8d4dc5f0:	25 50       	R0 = R5 + R4;
8d4dc5f2:	31 30       	R6 = R1;
8d4dc5f4:	f4 17       	IF !CC JUMP 0x0x8d4dc5dc (BP);
8d4dc5f6:	15 30       	R2 = R5;
8d4dc5f8:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dc5fa:	20 05       	(R7:4) = [SP++];
8d4dc5fc:	01 e8 00 00 	UNLINK;
8d4dc600:	02 30       	R0 = R2;
8d4dc602:	10 00       	RTS;
8d4dc604:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dc608:	e3 05       	[--SP] = (R7:4, P5:3);
8d4dc60a:	20 32       	P4 = R0;
8d4dc60c:	46 6f       	SP += -0x18;		/* (-24) */
8d4dc60e:	21 30       	R4 = R1;
8d4dc610:	00 da 24 09 	R0=153391688;
8d4dc614:	48 92 00 00 
8d4dc618:	3a 30       	R7 = R2;
8d4dc61a:	a1 a0       	R1 = [P4 + 0x8];
8d4dc61c:	08 0a       	CC = R0 <= R1 (IU);
8d4dc61e:	ff 18       	IF CC JUMP 0x0x8d4dc81c;
8d4dc620:	65 a0       	R5 = [P4 + 0x4];
8d4dc622:	60 61       	R0 = 0x2c (X);		/*		R0=0x48( 72) */
8d4dc624:	ff e3 d8 8e 	CALL 0x0x8d4ce3d4;
8d4dc628:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R3 = [FP + 0x14] || NOP;
8d4dc62c:	7b a1 00 00 
8d4dc630:	2e 32       	P5 = R6;
8d4dc632:	17 30       	R2 = R7;
8d4dc634:	01 68       	P1 = 0x0 (X);		/*		P1=0x3864(14436) */
8d4dc636:	0d 30       	R1 = R5;
8d4dc638:	45 0c       	CC = P5 == 0x0;
8d4dc63a:	06 18       	IF CC JUMP 0x0x8d4dc646;
8d4dc63c:	f5 b0       	[SP + 0xc] = R5;
8d4dc63e:	33 b1       	[SP + 0x10] = R3;
8d4dc640:	71 bd       	[SP + 0x14] = P1;
8d4dc642:	ff e3 a7 f8 	CALL 0x0x8d4db790;
8d4dc646:	03 c8 00 18 	MNOP || R0 = [P4 + 0x8] || R1 = [P4 + 0x4];
8d4dc64a:	a0 a0 61 a0 
8d4dc64e:	0f 08       	CC = R7 == R1;
8d4dc650:	08 64       	R0 += 0x1;		/* (  1) */
8d4dc652:	03 c8 00 18 	MNOP || P1 = [P4 + 0x4] || [P4 + 0x8] = R0;
8d4dc656:	61 ac a0 b0 
8d4dc65a:	db 18       	IF CC JUMP 0x0x8d4dc810;
8d4dc65c:	04 0c       	CC = R4 == 0x0;
8d4dc65e:	0f 32       	P1 = R7;
8d4dc660:	d1 18       	IF CC JUMP 0x0x8d4dc802;
8d4dc662:	0e 93       	[P1] = R6;
8d4dc664:	61 ac       	P1 = [P4 + 0x4];
8d4dc666:	08 91       	R0 = [P1];
8d4dc668:	07 08       	CC = R7 == R0;
8d4dc66a:	ca 18       	IF CC JUMP 0x0x8d4dc7fe;
8d4dc66c:	04 cc 12 44 	R2 = R2 - R2 (NS) || P1 = [P5 + 0x4] || NOP;
8d4dc670:	69 ac 00 00 
8d4dc674:	0b 60       	R3 = 0x1 (X);		/*		R3=0x0(  0) */
8d4dc676:	88 e5 28 00 	R0 = B[P1 + 0x28] (X);
8d4dc67a:	00 0c       	CC = R0 == 0x0;
8d4dc67c:	1e 10       	IF !CC JUMP 0x0x8d4dc6b8;
8d4dc67e:	c0 e0 1b 00 	LSETUP_IMM(bottom=0x8d4dc6b4) LC0 count_fields=0x0/0x0;
8d4dc682:	6f a0       	R7 = [P5 + 0x4];
8d4dc684:	17 32       	P2 = R7;
8d4dc686:	50 ac       	P0 = [P2 + 0x4];
8d4dc688:	41 91       	P1 = [P0];
8d4dc68a:	41 30       	R0 = P1;
8d4dc68c:	07 08       	CC = R7 == R0;
8d4dc68e:	65 18       	IF CC JUMP 0x0x8d4dc758;
8d4dc690:	88 e5 28 00 	R0 = B[P1 + 0x28] (X);
8d4dc694:	00 0c       	CC = R0 == 0x0;
8d4dc696:	1e 10       	IF !CC JUMP 0x0x8d4dc6d2;
8d4dc698:	93 e6 28 00 	B[P2 + 0x28] = R3;
8d4dc69c:	8b e6 28 00 	B[P1 + 0x28] = R3;
8d4dc6a0:	69 ac       	P1 = [P5 + 0x4];
8d4dc6a2:	49 ac       	P1 = [P1 + 0x4];
8d4dc6a4:	8a e6 28 00 	B[P1 + 0x28] = R2;
8d4dc6a8:	69 ac       	P1 = [P5 + 0x4];
8d4dc6aa:	4d ac       	P5 = [P1 + 0x4];
8d4dc6ac:	69 ac       	P1 = [P5 + 0x4];
8d4dc6ae:	88 e5 28 00 	R0 = B[P1 + 0x28] (X);
8d4dc6b2:	00 0c       	CC = R0 == 0x0;
8d4dc6b4:	02 10       	IF !CC JUMP 0x0x8d4dc6b8;
8d4dc6b6:	e4 2f       	JUMP.S 0x0x8d4dc67e;
8d4dc6b8:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || P1 = [P4 + 0x4] || NOP;
8d4dc6bc:	61 ac 00 00 
8d4dc6c0:	09 60       	R1 = 0x1 (X);		/*		R1=0x48( 72) */
8d4dc6c2:	49 ac       	P1 = [P1 + 0x4];
8d4dc6c4:	89 e6 28 00 	B[P1 + 0x28] = R1;
8d4dc6c8:	c6 6c       	SP += 0x18;		/* ( 24) */
8d4dc6ca:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dc6cc:	01 e8 00 00 	UNLINK;
8d4dc6d0:	10 00       	RTS;
8d4dc6d2:	45 30       	R0 = P5;
8d4dc6d4:	11 91       	R1 = [P2];
8d4dc6d6:	01 08       	CC = R1 == R0;
8d4dc6d8:	19 32       	P3 = R1;
8d4dc6da:	25 18       	IF CC JUMP 0x0x8d4dc724;
8d4dc6dc:	69 ac       	P1 = [P5 + 0x4];
8d4dc6de:	8b e6 28 00 	B[P1 + 0x28] = R3;
8d4dc6e2:	69 ac       	P1 = [P5 + 0x4];
8d4dc6e4:	49 ac       	P1 = [P1 + 0x4];
8d4dc6e6:	8a e6 28 00 	B[P1 + 0x28] = R2;
8d4dc6ea:	69 ac       	P1 = [P5 + 0x4];
8d4dc6ec:	49 ac       	P1 = [P1 + 0x4];
8d4dc6ee:	8b ac       	P3 = [P1 + 0x8];
8d4dc6f0:	18 91       	R0 = [P3];
8d4dc6f2:	88 b0       	[P1 + 0x8] = R0;
8d4dc6f4:	58 91       	P0 = [P3];
8d4dc6f6:	80 e5 29 00 	R0 = B[P0 + 0x29] (X);
8d4dc6fa:	00 0c       	CC = R0 == 0x0;
8d4dc6fc:	02 10       	IF !CC JUMP 0x0x8d4dc700;
8d4dc6fe:	41 bc       	[P0 + 0x4] = P1;
8d4dc700:	48 a0       	R0 = [P1 + 0x4];
8d4dc702:	58 b0       	[P3 + 0x4] = R0;
8d4dc704:	60 ac       	P0 = [P4 + 0x4];
8d4dc706:	41 30       	R0 = P1;
8d4dc708:	20 6c       	P0 += 0x4;		/* (  4) */
8d4dc70a:	01 91       	R1 = [P0];
8d4dc70c:	01 08       	CC = R1 == R0;
8d4dc70e:	07 18       	IF CC JUMP 0x0x8d4dc71c;
8d4dc710:	4a ac       	P2 = [P1 + 0x4];
8d4dc712:	11 91       	R1 = [P2];
8d4dc714:	42 32       	P0 = P2;
8d4dc716:	01 08       	CC = R1 == R0;
8d4dc718:	42 6c       	P2 += 0x8;		/* (  8) */
8d4dc71a:	c2 06       	IF !CC P0 = P2;
8d4dc71c:	43 93       	[P0] = P3;
8d4dc71e:	59 93       	[P3] = P1;
8d4dc720:	4b bc       	[P1 + 0x4] = P3;
8d4dc722:	c5 2f       	JUMP.S 0x0x8d4dc6ac;
8d4dc724:	98 a0       	R0 = [P3 + 0x8];
8d4dc726:	10 93       	[P2] = R0;
8d4dc728:	99 ac       	P1 = [P3 + 0x8];
8d4dc72a:	88 e5 29 00 	R0 = B[P1 + 0x29] (X);
8d4dc72e:	00 0c       	CC = R0 == 0x0;
8d4dc730:	02 10       	IF !CC JUMP 0x0x8d4dc734;
8d4dc732:	4a bc       	[P1 + 0x4] = P2;
8d4dc734:	50 a0       	R0 = [P2 + 0x4];
8d4dc736:	58 b0       	[P3 + 0x4] = R0;
8d4dc738:	60 ac       	P0 = [P4 + 0x4];
8d4dc73a:	6a 32       	P5 = P2;
8d4dc73c:	20 6c       	P0 += 0x4;		/* (  4) */
8d4dc73e:	00 91       	R0 = [P0];
8d4dc740:	38 08       	CC = R0 == R7;
8d4dc742:	07 18       	IF CC JUMP 0x0x8d4dc750;
8d4dc744:	50 ac       	P0 = [P2 + 0x4];
8d4dc746:	48 32       	P1 = P0;
8d4dc748:	40 6c       	P0 += 0x8;		/* (  8) */
8d4dc74a:	00 91       	R0 = [P0];
8d4dc74c:	38 08       	CC = R0 == R7;
8d4dc74e:	c1 06       	IF !CC P0 = P1;
8d4dc750:	43 93       	[P0] = P3;
8d4dc752:	9a bc       	[P3 + 0x8] = P2;
8d4dc754:	53 bc       	[P2 + 0x4] = P3;
8d4dc756:	c3 2f       	JUMP.S 0x0x8d4dc6dc;
8d4dc758:	81 ac       	P1 = [P0 + 0x8];
8d4dc75a:	88 e5 28 00 	R0 = B[P1 + 0x28] (X);
8d4dc75e:	00 0c       	CC = R0 == 0x0;
8d4dc760:	0c 10       	IF !CC JUMP 0x0x8d4dc778;
8d4dc762:	93 e6 28 00 	B[P2 + 0x28] = R3;
8d4dc766:	8b e6 28 00 	B[P1 + 0x28] = R3;
8d4dc76a:	69 ac       	P1 = [P5 + 0x4];
8d4dc76c:	49 ac       	P1 = [P1 + 0x4];
8d4dc76e:	8a e6 28 00 	B[P1 + 0x28] = R2;
8d4dc772:	69 ac       	P1 = [P5 + 0x4];
8d4dc774:	4d ac       	P5 = [P1 + 0x4];
8d4dc776:	9b 2f       	JUMP.S 0x0x8d4dc6ac;
8d4dc778:	45 30       	R0 = P5;
8d4dc77a:	91 a0       	R1 = [P2 + 0x8];
8d4dc77c:	01 08       	CC = R1 == R0;
8d4dc77e:	19 32       	P3 = R1;
8d4dc780:	25 18       	IF CC JUMP 0x0x8d4dc7ca;
8d4dc782:	69 ac       	P1 = [P5 + 0x4];
8d4dc784:	8b e6 28 00 	B[P1 + 0x28] = R3;
8d4dc788:	69 ac       	P1 = [P5 + 0x4];
8d4dc78a:	49 ac       	P1 = [P1 + 0x4];
8d4dc78c:	8a e6 28 00 	B[P1 + 0x28] = R2;
8d4dc790:	69 ac       	P1 = [P5 + 0x4];
8d4dc792:	4a ac       	P2 = [P1 + 0x4];
8d4dc794:	53 91       	P3 = [P2];
8d4dc796:	98 a0       	R0 = [P3 + 0x8];
8d4dc798:	10 93       	[P2] = R0;
8d4dc79a:	99 ac       	P1 = [P3 + 0x8];
8d4dc79c:	88 e5 29 00 	R0 = B[P1 + 0x29] (X);
8d4dc7a0:	00 0c       	CC = R0 == 0x0;
8d4dc7a2:	02 10       	IF !CC JUMP 0x0x8d4dc7a6;
8d4dc7a4:	4a bc       	[P1 + 0x4] = P2;
8d4dc7a6:	50 a0       	R0 = [P2 + 0x4];
8d4dc7a8:	58 b0       	[P3 + 0x4] = R0;
8d4dc7aa:	60 ac       	P0 = [P4 + 0x4];
8d4dc7ac:	42 30       	R0 = P2;
8d4dc7ae:	41 a0       	R1 = [P0 + 0x4];
8d4dc7b0:	01 08       	CC = R1 == R0;
8d4dc7b2:	20 6c       	P0 += 0x4;		/* (  4) */
8d4dc7b4:	07 18       	IF CC JUMP 0x0x8d4dc7c2;
8d4dc7b6:	50 ac       	P0 = [P2 + 0x4];
8d4dc7b8:	48 32       	P1 = P0;
8d4dc7ba:	40 6c       	P0 += 0x8;		/* (  8) */
8d4dc7bc:	01 91       	R1 = [P0];
8d4dc7be:	01 08       	CC = R1 == R0;
8d4dc7c0:	c1 06       	IF !CC P0 = P1;
8d4dc7c2:	43 93       	[P0] = P3;
8d4dc7c4:	9a bc       	[P3 + 0x8] = P2;
8d4dc7c6:	53 bc       	[P2 + 0x4] = P3;
8d4dc7c8:	72 2f       	JUMP.S 0x0x8d4dc6ac;
8d4dc7ca:	18 91       	R0 = [P3];
8d4dc7cc:	90 b0       	[P2 + 0x8] = R0;
8d4dc7ce:	59 91       	P1 = [P3];
8d4dc7d0:	88 e5 29 00 	R0 = B[P1 + 0x29] (X);
8d4dc7d4:	00 0c       	CC = R0 == 0x0;
8d4dc7d6:	02 10       	IF !CC JUMP 0x0x8d4dc7da;
8d4dc7d8:	4a bc       	[P1 + 0x4] = P2;
8d4dc7da:	50 a0       	R0 = [P2 + 0x4];
8d4dc7dc:	58 b0       	[P3 + 0x4] = R0;
8d4dc7de:	61 ac       	P1 = [P4 + 0x4];
8d4dc7e0:	6a 32       	P5 = P2;
8d4dc7e2:	21 6c       	P1 += 0x4;		/* (  4) */
8d4dc7e4:	08 91       	R0 = [P1];
8d4dc7e6:	38 08       	CC = R0 == R7;
8d4dc7e8:	07 18       	IF CC JUMP 0x0x8d4dc7f6;
8d4dc7ea:	50 ac       	P0 = [P2 + 0x4];
8d4dc7ec:	00 91       	R0 = [P0];
8d4dc7ee:	38 08       	CC = R0 == R7;
8d4dc7f0:	48 32       	P1 = P0;
8d4dc7f2:	40 6c       	P0 += 0x8;		/* (  8) */
8d4dc7f4:	c8 06       	IF !CC P1 = P0;
8d4dc7f6:	4b 93       	[P1] = P3;
8d4dc7f8:	5a 93       	[P3] = P2;
8d4dc7fa:	53 bc       	[P2 + 0x4] = P3;
8d4dc7fc:	c3 2f       	JUMP.S 0x0x8d4dc782;
8d4dc7fe:	0e 93       	[P1] = R6;
8d4dc800:	36 2f       	JUMP.S 0x0x8d4dc66c;
8d4dc802:	8e b0       	[P1 + 0x8] = R6;
8d4dc804:	61 ac       	P1 = [P4 + 0x4];
8d4dc806:	88 a0       	R0 = [P1 + 0x8];
8d4dc808:	07 08       	CC = R7 == R0;
8d4dc80a:	31 17       	IF !CC JUMP 0x0x8d4dc66c (BP);
8d4dc80c:	8e b0       	[P1 + 0x8] = R6;
8d4dc80e:	2f 2f       	JUMP.S 0x0x8d4dc66c;
8d4dc810:	4e b0       	[P1 + 0x4] = R6;
8d4dc812:	61 ac       	P1 = [P4 + 0x4];
8d4dc814:	0e 93       	[P1] = R6;
8d4dc816:	61 ac       	P1 = [P4 + 0x4];
8d4dc818:	8e b0       	[P1 + 0x8] = R6;
8d4dc81a:	29 2f       	JUMP.S 0x0x8d4dc66c;
8d4dc81c:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4dc820:	24 2b 00 00 
8d4dc824:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dc828:	e3 05       	[--SP] = (R7:4, P5:3);
8d4dc82a:	20 32       	P4 = R0;
8d4dc82c:	86 6f       	SP += -0x10;		/* (-16) */
8d4dc82e:	29 30       	R5 = R1;
8d4dc830:	39 30       	R7 = R1;
8d4dc832:	30 30       	R6 = R0;
8d4dc834:	65 ac       	P5 = [P4 + 0x4];
8d4dc836:	08 60       	R0 = 0x1 (X);		/*		R0=0x48( 72) */
8d4dc838:	6b ac       	P3 = [P5 + 0x4];
8d4dc83a:	99 e5 29 00 	R1 = B[P3 + 0x29] (X);
8d4dc83e:	01 0c       	CC = R1 == 0x0;
8d4dc840:	11 10       	IF !CC JUMP 0x0x8d4dc862;
8d4dc842:	53 30       	R2 = P3;
8d4dc844:	0f 30       	R1 = R7;
8d4dc846:	06 30       	R0 = R6;
8d4dc848:	62 64       	R2 += 0xc;		/* ( 12) */
8d4dc84a:	ff e3 c7 fa 	CALL 0x0x8d4dbdd8;
8d4dc84e:	4b 32       	P1 = P3;
8d4dc850:	00 0c       	CC = R0 == 0x0;
8d4dc852:	43 6c       	P3 += 0x8;		/* (  8) */
8d4dc854:	69 32       	P5 = P1;
8d4dc856:	cb 07       	IF CC P1 = P3;
8d4dc858:	4b 91       	P3 = [P1];
8d4dc85a:	99 e5 29 00 	R1 = B[P3 + 0x29] (X);
8d4dc85e:	01 0c       	CC = R1 == 0x0;
8d4dc860:	f1 1f       	IF CC JUMP 0x0x8d4dc842 (BP);
8d4dc862:	47 43       	R7 = R0.B (Z);
8d4dc864:	07 0c       	CC = R7 == 0x0;
8d4dc866:	75 bf       	[SP + 0x34] = P5;
8d4dc868:	21 18       	IF CC JUMP 0x0x8d4dc8aa;
8d4dc86a:	61 ac       	P1 = [P4 + 0x4];
8d4dc86c:	55 30       	R2 = P5;
8d4dc86e:	0b 60       	R3 = 0x1 (X);		/*		R3=0x0(  0) */
8d4dc870:	09 60       	R1 = 0x1 (X);		/*		R1=0x48( 72) */
8d4dc872:	08 91       	R0 = [P1];
8d4dc874:	10 08       	CC = R0 == R2;
8d4dc876:	59 18       	IF CC JUMP 0x0x8d4dc928;
8d4dc878:	a8 e5 29 00 	R0 = B[P5 + 0x29] (X);
8d4dc87c:	00 0c       	CC = R0 == 0x0;
8d4dc87e:	51 10       	IF !CC JUMP 0x0x8d4dc920;
8d4dc880:	68 91       	P0 = [P5];
8d4dc882:	80 e5 29 00 	R0 = B[P0 + 0x29] (X);
8d4dc886:	00 0c       	CC = R0 == 0x0;
8d4dc888:	36 10       	IF !CC JUMP 0x0x8d4dc8f4;
8d4dc88a:	81 ac       	P1 = [P0 + 0x8];
8d4dc88c:	88 e5 29 00 	R0 = B[P1 + 0x29] (X);
8d4dc890:	00 0c       	CC = R0 == 0x0;
8d4dc892:	0b 10       	IF !CC JUMP 0x0x8d4dc8a8;
8d4dc894:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4dc8a2) LC0 count_fields=0x0/0x0;
8d4dc898:	41 32       	P0 = P1;
8d4dc89a:	81 ac       	P1 = [P0 + 0x8];
8d4dc89c:	88 e5 29 00 	R0 = B[P1 + 0x29] (X);
8d4dc8a0:	00 0c       	CC = R0 == 0x0;
8d4dc8a2:	03 10       	IF !CC JUMP 0x0x8d4dc8a8;
8d4dc8a4:	81 ac       	P1 = [P0 + 0x8];
8d4dc8a6:	f7 2f       	JUMP.S 0x0x8d4dc894;
8d4dc8a8:	70 bf       	[SP + 0x34] = P0;
8d4dc8aa:	06 30       	R0 = R6;
8d4dc8ac:	82 ce 05 c4 	R2 = ROT R5 BY 0x0 || R1 = [SP + 0x34] || R4 = [SP + 0x34];
8d4dc8b0:	71 a3 74 a3 
8d4dc8b4:	61 64       	R1 += 0xc;		/* ( 12) */
8d4dc8b6:	ff e3 91 fa 	CALL 0x0x8d4dbdd8;
8d4dc8ba:	00 0c       	CC = R0 == 0x0;
8d4dc8bc:	0b 10       	IF !CC JUMP 0x0x8d4dc8d2;
8d4dc8be:	b0 e6 3c 00 	B[SP + 0x3c] = R0;
8d4dc8c2:	b4 b3       	[SP + 0x38] = R4;
8d4dc8c4:	b0 a3       	R0 = [SP + 0x38];
8d4dc8c6:	f1 a3       	R1 = [SP + 0x3c];
8d4dc8c8:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc8ca:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dc8cc:	01 e8 00 00 	UNLINK;
8d4dc8d0:	10 00       	RTS;
8d4dc8d2:	09 60       	R1 = 0x1 (X);		/*		R1=0x48( 72) */
8d4dc8d4:	b1 e6 3c 00 	B[SP + 0x3c] = R1;
8d4dc8d8:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R5 || NOP;
8d4dc8dc:	f5 b0 00 00 
8d4dc8e0:	55 30       	R2 = P5;
8d4dc8e2:	0f 30       	R1 = R7;
8d4dc8e4:	ff e3 90 fe 	CALL 0x0x8d4dc604;
8d4dc8e8:	f1 a3       	R1 = [SP + 0x3c];
8d4dc8ea:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc8ec:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dc8ee:	01 e8 00 00 	UNLINK;
8d4dc8f2:	10 00       	RTS;
8d4dc8f4:	4d 32       	P1 = P5;
8d4dc8f6:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d4dc90c) LC0 count_fields=0x0/0x0;
8d4dc8fa:	48 ac       	P0 = [P1 + 0x4];
8d4dc8fc:	80 e5 29 00 	R0 = B[P0 + 0x29] (X);
8d4dc900:	00 0c       	CC = R0 == 0x0;
8d4dc902:	07 10       	IF !CC JUMP 0x0x8d4dc910;
8d4dc904:	41 30       	R0 = P1;
8d4dc906:	01 91       	R1 = [P0];
8d4dc908:	01 08       	CC = R1 == R0;
8d4dc90a:	03 10       	IF !CC JUMP 0x0x8d4dc910;
8d4dc90c:	48 32       	P1 = P0;
8d4dc90e:	f4 2f       	JUMP.S 0x0x8d4dc8f6;
8d4dc910:	71 bf       	[SP + 0x34] = P1;
8d4dc912:	72 af       	P2 = [SP + 0x34];
8d4dc914:	90 e5 29 00 	R0 = B[P2 + 0x29] (X);
8d4dc918:	00 0c       	CC = R0 == 0x0;
8d4dc91a:	c8 07       	IF CC P1 = P0;
8d4dc91c:	71 bf       	[SP + 0x34] = P1;
8d4dc91e:	c6 2f       	JUMP.S 0x0x8d4dc8aa;
8d4dc920:	a8 a0       	R0 = [P5 + 0x8];
8d4dc922:	70 b3       	[SP + 0x34] = R0;
8d4dc924:	c3 2f       	JUMP.S 0x0x8d4dc8aa;
8d4dc926:	00 00       	NOP;
8d4dc928:	b3 e6 3c 00 	B[SP + 0x3c] = R3;
8d4dc92c:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R5 || NOP;
8d4dc930:	f5 b0 00 00 
8d4dc934:	ff e3 68 fe 	CALL 0x0x8d4dc604;
8d4dc938:	f1 a3       	R1 = [SP + 0x3c];
8d4dc93a:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dc93c:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dc93e:	01 e8 00 00 	UNLINK;
8d4dc942:	10 00       	RTS;
8d4dc944:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4dc948:	f5 bc       	[SP + 0xc] = P5;
8d4dc94a:	28 32       	P5 = R0;
8d4dc94c:	60 61       	R0 = 0x2c (X);		/*		R0=0x48( 72) */
8d4dc94e:	ff e3 43 8d 	CALL 0x0x8d4ce3d4;
8d4dc952:	00 32       	P0 = R0;
8d4dc954:	00 0c       	CC = R0 == 0x0;
8d4dc956:	03 18       	IF CC JUMP 0x0x8d4dc95c;
8d4dc958:	01 60       	R1 = 0x0 (X);		/*		R1=0x48( 72) */
8d4dc95a:	01 93       	[P0] = R1;
8d4dc95c:	08 30       	R1 = R0;
8d4dc95e:	20 64       	R0 += 0x4;		/* (  4) */
8d4dc960:	00 0c       	CC = R0 == 0x0;
8d4dc962:	08 32       	P1 = R0;
8d4dc964:	03 18       	IF CC JUMP 0x0x8d4dc96a;
8d4dc966:	00 60       	R0 = 0x0 (X);		/*		R0=0x48( 72) */
8d4dc968:	08 93       	[P1] = R0;
8d4dc96a:	01 30       	R0 = R1;
8d4dc96c:	41 64       	R1 += 0x8;		/* (  8) */
8d4dc96e:	01 0c       	CC = R1 == 0x0;
8d4dc970:	09 32       	P1 = R1;
8d4dc972:	03 18       	IF CC JUMP 0x0x8d4dc978;
8d4dc974:	01 60       	R1 = 0x0 (X);		/*		R1=0x48( 72) */
8d4dc976:	09 93       	[P1] = R1;
8d4dc978:	09 60       	R1 = 0x1 (X);		/*		R1=0x48( 72) */
8d4dc97a:	81 e6 28 00 	B[P0 + 0x28] = R1;
8d4dc97e:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0x4] = R0 || NOP;
8d4dc982:	68 b0 00 00 
8d4dc986:	81 e6 29 00 	B[P0 + 0x29] = R1;
8d4dc98a:	69 ac       	P1 = [P5 + 0x4];
8d4dc98c:	49 bc       	[P1 + 0x4] = P1;
8d4dc98e:	69 ac       	P1 = [P5 + 0x4];
8d4dc990:	49 93       	[P1] = P1;
8d4dc992:	69 ac       	P1 = [P5 + 0x4];
8d4dc994:	89 bc       	[P1 + 0x8] = P1;
8d4dc996:	a8 b0       	[P5 + 0x8] = R0;
8d4dc998:	f5 ac       	P5 = [SP + 0xc];
8d4dc99a:	01 e8 00 00 	UNLINK;
8d4dc99e:	10 00       	RTS;
8d4dc9a0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dc9a4:	e4 05       	[--SP] = (R7:4, P5:4);
8d4dc9a6:	29 32       	P5 = R1;
8d4dc9a8:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dc9aa:	38 30       	R7 = R0;
8d4dc9ac:	84 60       	R4 = 0x10 (X);		/*		R4=0x48( 72) */
8d4dc9ae:	7d 60       	R5 = 0xf (X);		/*		R5=0x48( 72) */
8d4dc9b0:	a8 e5 29 00 	R0 = B[P5 + 0x29] (X);
8d4dc9b4:	00 0c       	CC = R0 == 0x0;
8d4dc9b6:	1a 10       	IF !CC JUMP 0x0x8d4dc9ea;
8d4dc9b8:	06 60       	R6 = 0x0 (X);		/*		R6=0x48( 72) */
8d4dc9ba:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [P5 + 0x8] || NOP;
8d4dc9be:	a9 a0 00 00 
8d4dc9c2:	ff e3 ef ff 	CALL 0x0x8d4dc9a0;
8d4dc9c6:	03 c8 00 18 	MNOP || P4 = [P5] || R0 = [P5 + 0x24];
8d4dc9ca:	6c 91 68 a2 
8d4dc9ce:	04 0a       	CC = R4 <= R0 (IU);
8d4dc9d0:	12 18       	IF CC JUMP 0x0x8d4dc9f4;
8d4dc9d2:	6d b2       	[P5 + 0x24] = R5;
8d4dc9d4:	2e b2       	[P5 + 0x20] = R6;
8d4dc9d6:	ae e6 10 00 	B[P5 + 0x10] = R6;
8d4dc9da:	45 30       	R0 = P5;
8d4dc9dc:	ff e3 04 8d 	CALL 0x0x8d4ce3e4;
8d4dc9e0:	a0 e5 29 00 	R0 = B[P4 + 0x29] (X);
8d4dc9e4:	00 0c       	CC = R0 == 0x0;
8d4dc9e6:	6c 32       	P5 = P4;
8d4dc9e8:	e9 1f       	IF CC JUMP 0x0x8d4dc9ba (BP);
8d4dc9ea:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dc9ec:	a4 05       	(R7:4, P5:4) = [SP++];
8d4dc9ee:	01 e8 00 00 	UNLINK;
8d4dc9f2:	10 00       	RTS;
8d4dc9f4:	28 a1       	R0 = [P5 + 0x10];
8d4dc9f6:	ff e3 f7 8c 	CALL 0x0x8d4ce3e4;
8d4dc9fa:	ec 2f       	JUMP.S 0x0x8d4dc9d2;
8d4dc9fc:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dca00:	fd 05       	[--SP] = (R7:7, P5:5);
8d4dca02:	28 32       	P5 = R0;
8d4dca04:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dca06:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4dca08:	69 ac       	P1 = [P5 + 0x4];
8d4dca0a:	49 a0       	R1 = [P1 + 0x4];
8d4dca0c:	ff e3 ca ff 	CALL 0x0x8d4dc9a0;
8d4dca10:	69 ac       	P1 = [P5 + 0x4];
8d4dca12:	49 bc       	[P1 + 0x4] = P1;
8d4dca14:	03 c8 00 18 	MNOP || P1 = [P5 + 0x4] || [P5 + 0x8] = R7;
8d4dca18:	69 ac af b0 
8d4dca1c:	49 93       	[P1] = P1;
8d4dca1e:	69 ac       	P1 = [P5 + 0x4];
8d4dca20:	89 bc       	[P1 + 0x8] = P1;
8d4dca22:	68 a0       	R0 = [P5 + 0x4];
8d4dca24:	ff e3 e0 8c 	CALL 0x0x8d4ce3e4;
8d4dca28:	6f b0       	[P5 + 0x4] = R7;
8d4dca2a:	af b0       	[P5 + 0x8] = R7;
8d4dca2c:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dca2e:	bd 05       	(R7:7, P5:5) = [SP++];
8d4dca30:	01 e8 00 00 	UNLINK;
8d4dca34:	10 00       	RTS;
8d4dca36:	00 00       	NOP;
8d4dca38:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d4dca3c:	e3 05       	[--SP] = (R7:4, P5:3);
8d4dca3e:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dca40:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P1 = [FP + 0x14] || [FP + 0xc] = R0;
8d4dca44:	79 ad f8 b0 
8d4dca48:	39 b1       	[FP + 0x10] = R1;
8d4dca4a:	03 c8 00 18 	MNOP || R5 = [P1 + 0x4] || R4 = [P1 + 0x8];
8d4dca4e:	4d a0 8c a0 
8d4dca52:	25 08       	CC = R5 == R4;
8d4dca54:	60 18       	IF CC JUMP 0x0x8d4dcb14;
8d4dca56:	f9 ac       	P1 = [FP + 0xc];
8d4dca58:	4c ac       	P4 = [P1 + 0x4];
8d4dca5a:	63 ac       	P3 = [P4 + 0x4];
8d4dca5c:	6c 32       	P5 = P4;
8d4dca5e:	98 e5 29 00 	R0 = B[P3 + 0x29] (X);
8d4dca62:	00 0c       	CC = R0 == 0x0;
8d4dca64:	10 10       	IF !CC JUMP 0x0x8d4dca84;
8d4dca66:	73 30       	R6 = P3;
8d4dca68:	66 64       	R6 += 0xc;		/* ( 12) */
8d4dca6a:	15 30       	R2 = R5;
8d4dca6c:	07 30       	R0 = R7;
8d4dca6e:	0e 30       	R1 = R6;
8d4dca70:	ff e3 b4 f9 	CALL 0x0x8d4dbdd8;
8d4dca74:	00 0c       	CC = R0 == 0x0;
8d4dca76:	ad 18       	IF CC JUMP 0x0x8d4dcbd0;
8d4dca78:	43 6c       	P3 += 0x8;		/* (  8) */
8d4dca7a:	5b 91       	P3 = [P3];
8d4dca7c:	98 e5 29 00 	R0 = B[P3 + 0x29] (X);
8d4dca80:	00 0c       	CC = R0 == 0x0;
8d4dca82:	f2 1f       	IF CC JUMP 0x0x8d4dca66 (BP);
8d4dca84:	a8 e5 29 00 	R0 = B[P5 + 0x29] (X);
8d4dca88:	00 0c       	CC = R0 == 0x0;
8d4dca8a:	4d 32       	P1 = P5;
8d4dca8c:	04 18       	IF CC JUMP 0x0x8d4dca94;
8d4dca8e:	f9 ac       	P1 = [FP + 0xc];
8d4dca90:	49 ac       	P1 = [P1 + 0x4];
8d4dca92:	21 6c       	P1 += 0x4;		/* (  4) */
8d4dca94:	4b 91       	P3 = [P1];
8d4dca96:	98 e5 29 00 	R0 = B[P3 + 0x29] (X);
8d4dca9a:	00 0c       	CC = R0 == 0x0;
8d4dca9c:	15 10       	IF !CC JUMP 0x0x8d4dcac6;
8d4dca9e:	bd bc       	[FP + 0x8] = P5;
8d4dcaa0:	53 30       	R2 = P3;
8d4dcaa2:	0d 30       	R1 = R5;
8d4dcaa4:	07 30       	R0 = R7;
8d4dcaa6:	62 64       	R2 += 0xc;		/* ( 12) */
8d4dcaa8:	ff e3 98 f9 	CALL 0x0x8d4dbdd8;
8d4dcaac:	6b 32       	P5 = P3;
8d4dcaae:	00 0c       	CC = R0 == 0x0;
8d4dcab0:	43 6c       	P3 += 0x8;		/* (  8) */
8d4dcab2:	4d 32       	P1 = P5;
8d4dcab4:	cb 07       	IF CC P1 = P3;
8d4dcab6:	b8 ac       	P0 = [FP + 0x8];
8d4dcab8:	4b 91       	P3 = [P1];
8d4dcaba:	e8 07       	IF CC P5 = P0;
8d4dcabc:	bd bc       	[FP + 0x8] = P5;
8d4dcabe:	98 e5 29 00 	R0 = B[P3 + 0x29] (X);
8d4dcac2:	00 0c       	CC = R0 == 0x0;
8d4dcac4:	ee 1f       	IF CC JUMP 0x0x8d4dcaa0 (BP);
8d4dcac6:	6c 08       	CC = P4 == P5;
8d4dcac8:	00 60       	R0 = 0x0 (X);		/*		R0=0x48( 72) */
8d4dcaca:	20 18       	IF CC JUMP 0x0x8d4dcb0a;
8d4dcacc:	d0 e0 1d 00 	LSETUP_IMM(bottom=0x8d4dcb06) LC1 count_fields=0x0/0x0;
8d4dcad0:	08 64       	R0 += 0x1;		/* (  1) */
8d4dcad2:	a1 e5 29 00 	R1 = B[P4 + 0x29] (X);
8d4dcad6:	01 0c       	CC = R1 == 0x0;
8d4dcad8:	16 10       	IF !CC JUMP 0x0x8d4dcb04;
8d4dcada:	a0 ac       	P0 = [P4 + 0x8];
8d4dcadc:	81 e5 29 00 	R1 = B[P0 + 0x29] (X);
8d4dcae0:	01 0c       	CC = R1 == 0x0;
8d4dcae2:	65 10       	IF !CC JUMP 0x0x8d4dcbac;
8d4dcae4:	41 91       	P1 = [P0];
8d4dcae6:	60 32       	P4 = P0;
8d4dcae8:	89 e5 29 00 	R1 = B[P1 + 0x29] (X);
8d4dcaec:	01 0c       	CC = R1 == 0x0;
8d4dcaee:	0b 10       	IF !CC JUMP 0x0x8d4dcb04;
8d4dcaf0:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4dcafe) LC0 count_fields=0x0/0x0;
8d4dcaf4:	61 32       	P4 = P1;
8d4dcaf6:	61 91       	P1 = [P4];
8d4dcaf8:	89 e5 29 00 	R1 = B[P1 + 0x29] (X);
8d4dcafc:	01 0c       	CC = R1 == 0x0;
8d4dcafe:	03 10       	IF !CC JUMP 0x0x8d4dcb04;
8d4dcb00:	61 91       	P1 = [P4];
8d4dcb02:	f7 2f       	JUMP.S 0x0x8d4dcaf0;
8d4dcb04:	65 08       	CC = P5 == P4;
8d4dcb06:	02 18       	IF CC JUMP 0x0x8d4dcb0a;
8d4dcb08:	e2 2f       	JUMP.S 0x0x8d4dcacc;
8d4dcb0a:	00 0c       	CC = R0 == 0x0;
8d4dcb0c:	09 18       	IF CC JUMP 0x0x8d4dcb1e;
8d4dcb0e:	e5 64       	R5 += 0x1c;		/* ( 28) */
8d4dcb10:	2c 08       	CC = R4 == R5;
8d4dcb12:	a2 17       	IF !CC JUMP 0x0x8d4dca56 (BP);
8d4dcb14:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dcb16:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dcb18:	01 e8 00 00 	UNLINK;
8d4dcb1c:	10 00       	RTS;
8d4dcb1e:	77 30       	R6 = FP;
8d4dcb20:	46 66       	R6 += -0x38;		/* (-56) */
8d4dcb22:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d4dcb26:	39 a1 00 00 
8d4dcb2a:	02 da 03 84 	R2=-2080152856;
8d4dcb2e:	e8 62 00 00 
8d4dcb32:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4dcb36:	94 f1 00 00 
8d4dcb3a:	06 30       	R0 = R6;
8d4dcb3c:	0e 30       	R1 = R6;
8d4dcb3e:	15 30       	R2 = R5;
8d4dcb40:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4dcb42:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d4dcb46:	e4 f0 00 00 
8d4dcb4a:	86 60       	R6 = 0x10 (X);		/*		R6=0x48( 72) */
8d4dcb4c:	80 b9       	R0 = [FP -0x20];
8d4dcb4e:	06 0a       	CC = R6 <= R0 (IU);
8d4dcb50:	29 18       	IF CC JUMP 0x0x8d4dcba2;
8d4dcb52:	01 60       	R1 = 0x0 (X);		/*		R1=0x48( 72) */
8d4dcb54:	b1 e6 2c 00 	B[SP + 0x2c] = R1;
8d4dcb58:	04 cc 12 44 	R2 = R2 - R2 (NS) || R1 = [FP -0x4] || NOP;
8d4dcb5c:	f1 b9 00 00 
8d4dcb60:	47 30       	R0 = FP;
8d4dcb62:	03 c8 00 18 	MNOP || [SP + 0x3c] = R2 || R2 = [FP -0x18];
8d4dcb66:	f2 b3 a2 b9 
8d4dcb6a:	0e 0a       	CC = R6 <= R1 (IU);
8d4dcb6c:	40 67       	R0 += -0x18;		/* (-24) */
8d4dcb6e:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d4dcb70:	02 07       	IF CC R0 = R2;
8d4dcb72:	83 bb       	[FP -0x20] = R3;
8d4dcb74:	00 de 03 8c 	CALL.A 0x8c03e040;
8d4dcb78:	40 e0 00 00 
8d4dcb7c:	f0 b9       	R0 = [FP -0x4];
8d4dcb7e:	06 0a       	CC = R6 <= R0 (IU);
8d4dcb80:	0d 18       	IF CC JUMP 0x0x8d4dcb9a;
8d4dcb82:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
8d4dcb84:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP -0x4] = R2 || NOP;
8d4dcb88:	f2 bb 00 00 
8d4dcb8c:	04 cc 00 40 	R0 = R0 - R0 (NS) || [FP -0x8] = R1 || NOP;
8d4dcb90:	e1 bb 00 00 
8d4dcb94:	b0 e6 48 00 	B[SP + 0x48] = R0;
8d4dcb98:	bb 2f       	JUMP.S 0x0x8d4dcb0e;
8d4dcb9a:	a0 b9       	R0 = [FP -0x18];
8d4dcb9c:	ff e3 24 8c 	CALL 0x0x8d4ce3e4;
8d4dcba0:	f1 2f       	JUMP.S 0x0x8d4dcb82;
8d4dcba2:	f0 a2       	R0 = [SP + 0x2c];
8d4dcba4:	ff e3 20 8c 	CALL 0x0x8d4ce3e4;
8d4dcba8:	d5 2f       	JUMP.S 0x0x8d4dcb52;
8d4dcbaa:	00 00       	NOP;
8d4dcbac:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d4dcbc2) LC0 count_fields=0x0/0x0;
8d4dcbb0:	61 ac       	P1 = [P4 + 0x4];
8d4dcbb2:	89 e5 29 00 	R1 = B[P1 + 0x29] (X);
8d4dcbb6:	01 0c       	CC = R1 == 0x0;
8d4dcbb8:	09 10       	IF !CC JUMP 0x0x8d4dcbca;
8d4dcbba:	4c 30       	R1 = P4;
8d4dcbbc:	8a a0       	R2 = [P1 + 0x8];
8d4dcbbe:	0a 08       	CC = R2 == R1;
8d4dcbc0:	03 10       	IF !CC JUMP 0x0x8d4dcbc6;
8d4dcbc2:	61 32       	P4 = P1;
8d4dcbc4:	f4 2f       	JUMP.S 0x0x8d4dcbac;
8d4dcbc6:	61 32       	P4 = P1;
8d4dcbc8:	9e 2f       	JUMP.S 0x0x8d4dcb04;
8d4dcbca:	61 32       	P4 = P1;
8d4dcbcc:	9c 2f       	JUMP.S 0x0x8d4dcb04;
8d4dcbce:	00 00       	NOP;
8d4dcbd0:	a8 e5 29 00 	R0 = B[P5 + 0x29] (X);
8d4dcbd4:	00 0c       	CC = R0 == 0x0;
8d4dcbd6:	03 10       	IF !CC JUMP 0x0x8d4dcbdc;
8d4dcbd8:	63 32       	P4 = P3;
8d4dcbda:	50 2f       	JUMP.S 0x0x8d4dca7a;
8d4dcbdc:	16 30       	R2 = R6;
8d4dcbde:	0d 30       	R1 = R5;
8d4dcbe0:	07 30       	R0 = R7;
8d4dcbe2:	ff e3 fb f8 	CALL 0x0x8d4dbdd8;
8d4dcbe6:	00 0c       	CC = R0 == 0x0;
8d4dcbe8:	eb 06       	IF !CC P5 = P3;
8d4dcbea:	f7 2f       	JUMP.S 0x0x8d4dcbd8;
8d4dcbec:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dcbf0:	70 05       	[--SP] = (R7:6);
8d4dcbf2:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dcbf4:	38 30       	R7 = R0;
8d4dcbf6:	00 de 05 8c 	CALL.A 0x8c051056;
8d4dcbfa:	56 10 00 00 
8d4dcbfe:	21 60       	R1 = 0x4 (X);		/*		R1=0x48( 72) */
8d4dcc00:	08 08       	CC = R0 == R1;
8d4dcc02:	07 18       	IF CC JUMP 0x0x8d4dcc10;
8d4dcc04:	08 60       	R0 = 0x1 (X);		/*		R0=0x48( 72) */
8d4dcc06:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dcc08:	30 05       	(R7:6) = [SP++];
8d4dcc0a:	01 e8 00 00 	UNLINK;
8d4dcc0e:	10 00       	RTS;
8d4dcc10:	07 30       	R0 = R7;
8d4dcc12:	00 de 05 8c 	CALL.A 0x8c051c90;
8d4dcc16:	90 1c 00 00 
8d4dcc1a:	01 da 03 84 	R1=-2080152992;
8d4dcc1e:	60 62 00 00 
8d4dcc22:	38 30       	R7 = R0;
8d4dcc24:	00 de 02 04 	CALL.A 0x040231b4;
8d4dcc28:	b4 31 00 00 
8d4dcc2c:	00 0c       	CC = R0 == 0x0;
8d4dcc2e:	06 da 03 84 	R6=-2080152992;
8d4dcc32:	60 62 00 00 
8d4dcc36:	e8 1f       	IF CC JUMP 0x0x8d4dcc06 (BP);
8d4dcc38:	07 30       	R0 = R7;
8d4dcc3a:	01 da 03 84 	R1=-2080152992;
8d4dcc3e:	60 62 00 00 
8d4dcc42:	41 64       	R1 += 0x8;		/* (  8) */
8d4dcc44:	00 de 02 04 	CALL.A 0x040231b4;
8d4dcc48:	b4 31 00 00 
8d4dcc4c:	00 0c       	CC = R0 == 0x0;
8d4dcc4e:	07 10       	IF !CC JUMP 0x0x8d4dcc5c;
8d4dcc50:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dcc52:	30 05       	(R7:6) = [SP++];
8d4dcc54:	01 e8 00 00 	UNLINK;
8d4dcc58:	08 60       	R0 = 0x1 (X);		/*		R0=0x48( 72) */
8d4dcc5a:	10 00       	RTS;
8d4dcc5c:	07 30       	R0 = R7;
8d4dcc5e:	01 da 03 84 	R1=-2080152992;
8d4dcc62:	60 62 00 00 
8d4dcc66:	81 64       	R1 += 0x10;		/* ( 16) */
8d4dcc68:	00 de 02 04 	CALL.A 0x040231b4;
8d4dcc6c:	b4 31 00 00 
8d4dcc70:	00 0c       	CC = R0 == 0x0;
8d4dcc72:	07 10       	IF !CC JUMP 0x0x8d4dcc80;
8d4dcc74:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dcc76:	30 05       	(R7:6) = [SP++];
8d4dcc78:	01 e8 00 00 	UNLINK;
8d4dcc7c:	10 60       	R0 = 0x2 (X);		/*		R0=0x48( 72) */
8d4dcc7e:	10 00       	RTS;
8d4dcc80:	c6 64       	R6 += 0x18;		/* ( 24) */
8d4dcc82:	07 30       	R0 = R7;
8d4dcc84:	0e 30       	R1 = R6;
8d4dcc86:	00 de 02 04 	CALL.A 0x040231b4;
8d4dcc8a:	b4 31 00 00 
8d4dcc8e:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dcc90:	30 05       	(R7:6) = [SP++];
8d4dcc92:	01 e8 00 00 	UNLINK;
8d4dcc96:	00 0c       	CC = R0 == 0x0;
8d4dcc98:	09 60       	R1 = 0x1 (X);		/*		R1=0x48( 72) */
8d4dcc9a:	18 60       	R0 = 0x3 (X);		/*		R0=0x48( 72) */
8d4dcc9c:	01 06       	IF !CC R0 = R1;
8d4dcc9e:	10 00       	RTS;
8d4dcca0:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d4dcca4:	79 61       	R1 = 0x2f (X);		/*		R1=0x48( 72) */
8d4dcca6:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4dccaa:	b8 00 02 00 
8d4dccae:	ff e3 bb d4 	CALL 0x0x8d4d7624;
8d4dccb2:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d4dccb6:	b8 00 01 00 
8d4dccba:	01 e8 00 00 	UNLINK;
8d4dccbe:	08 08       	CC = R0 == R1;
8d4dccc0:	00 02       	R0 = CC;
8d4dccc2:	10 00       	RTS;
8d4dccc4:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dccc8:	f5 05       	[--SP] = (R7:6, P5:5);
8d4dccca:	28 32       	P5 = R0;
8d4dcccc:	38 30       	R7 = R0;
8d4dccce:	01 30       	R0 = R1;
8d4dccd0:	31 30       	R6 = R1;
8d4dccd2:	86 6f       	SP += -0x10;		/* (-16) */
8d4dccd4:	01 da 03 84 	R1=-2080152852;
8d4dccd8:	ec 62 00 00 
8d4dccdc:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4dcce0:	88 bf 00 00 
8d4dcce4:	00 0c       	CC = R0 == 0x0;
8d4dcce6:	00 60       	R0 = 0x0 (X);		/*		R0=0x48( 72) */
8d4dcce8:	68 b1       	[P5 + 0x14] = R0;
8d4dccea:	a8 e6 04 00 	B[P5 + 0x4] = R0;
8d4dccee:	78 60       	R0 = 0xf (X);		/*		R0=0x48( 72) */
8d4dccf0:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P5 + 0x18] = R0 || NOP;
8d4dccf4:	a8 b1 00 00 
8d4dccf8:	01 da 03 84 	R1=-2080152852;
8d4dccfc:	ec 62 00 00 
8d4dcd00:	0c 18       	IF CC JUMP 0x0x8d4dcd18;
8d4dcd02:	07 30       	R0 = R7;
8d4dcd04:	61 64       	R1 += 0xc;		/* ( 12) */
8d4dcd06:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4dcd0a:	76 a3 00 00 
8d4dcd0e:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dcd10:	b5 05       	(R7:6, P5:5) = [SP++];
8d4dcd12:	01 e8 00 00 	UNLINK;
8d4dcd16:	10 00       	RTS;
8d4dcd18:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d4dcd1c:	b8 00 01 00 
8d4dcd20:	f1 b0       	[SP + 0xc] = R1;
8d4dcd22:	0e 30       	R1 = R6;
8d4dcd24:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4dcd26:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dcd2a:	70 e9 00 00 
8d4dcd2e:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dcd30:	b5 05       	(R7:6, P5:5) = [SP++];
8d4dcd32:	01 e8 00 00 	UNLINK;
8d4dcd36:	10 00       	RTS;
8d4dcd38:	00 00       	NOP;
8d4dcd3a:	00 00       	NOP;
8d4dcd3c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dcd40:	ed 05       	[--SP] = (R7:5, P5:5);
8d4dcd42:	31 30       	R6 = R1;
8d4dcd44:	28 32       	P5 = R0;
8d4dcd46:	38 30       	R7 = R0;
8d4dcd48:	86 6f       	SP += -0x10;		/* (-16) */
8d4dcd4a:	06 30       	R0 = R6;
8d4dcd4c:	01 da 03 84 	R1=-2080152832;
8d4dcd50:	00 63 00 00 
8d4dcd54:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4dcd58:	88 bf 00 00 
8d4dcd5c:	28 30       	R5 = R0;
8d4dcd5e:	05 0c       	CC = R5 == 0x0;
8d4dcd60:	18 18       	IF CC JUMP 0x0x8d4dcd90;
8d4dcd62:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4dcd64:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P5 + 0x14] = R2 || NOP;
8d4dcd68:	6a b1 00 00 
8d4dcd6c:	aa e6 04 00 	B[P5 + 0x4] = R2;
8d4dcd70:	01 da 03 84 	R1=-2080152832;
8d4dcd74:	00 63 00 00 
8d4dcd78:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
8d4dcd7a:	aa b1       	[P5 + 0x18] = R2;
8d4dcd7c:	41 64       	R1 += 0x8;		/* (  8) */
8d4dcd7e:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4dcd82:	76 a3 00 00 
8d4dcd86:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dcd88:	ad 05       	(R7:5, P5:5) = [SP++];
8d4dcd8a:	01 e8 00 00 	UNLINK;
8d4dcd8e:	10 00       	RTS;
8d4dcd90:	01 da 03 84 	R1=-2080152832;
8d4dcd94:	00 63 00 00 
8d4dcd98:	61 64       	R1 += 0xc;		/* ( 12) */
8d4dcd9a:	06 30       	R0 = R6;
8d4dcd9c:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4dcda0:	88 bf 00 00 
8d4dcda4:	00 0c       	CC = R0 == 0x0;
8d4dcda6:	17 18       	IF CC JUMP 0x0x8d4dcdd4;
8d4dcda8:	78 60       	R0 = 0xf (X);		/*		R0=0x48( 72) */
8d4dcdaa:	01 da 03 84 	R1=-2080152832;
8d4dcdae:	00 63 00 00 
8d4dcdb2:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P5 + 0x18] = R0 || NOP;
8d4dcdb6:	a8 b1 00 00 
8d4dcdba:	6d b1       	[P5 + 0x14] = R5;
8d4dcdbc:	ad e6 04 00 	B[P5 + 0x4] = R5;
8d4dcdc0:	a1 64       	R1 += 0x14;		/* ( 20) */
8d4dcdc2:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4dcdc6:	76 a3 00 00 
8d4dcdca:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dcdcc:	ad 05       	(R7:5, P5:5) = [SP++];
8d4dcdce:	01 e8 00 00 	UNLINK;
8d4dcdd2:	10 00       	RTS;
8d4dcdd4:	06 30       	R0 = R6;
8d4dcdd6:	01 da 03 84 	R1=-2080152832;
8d4dcdda:	00 63 00 00 
8d4dcdde:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4dcde0:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4dcde4:	88 bf 00 00 
8d4dcde8:	00 0c       	CC = R0 == 0x0;
8d4dcdea:	6d b1       	[P5 + 0x14] = R5;
8d4dcdec:	ad e6 04 00 	B[P5 + 0x4] = R5;
8d4dcdf0:	78 60       	R0 = 0xf (X);		/*		R0=0x48( 72) */
8d4dcdf2:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P5 + 0x18] = R0 || NOP;
8d4dcdf6:	a8 b1 00 00 
8d4dcdfa:	13 18       	IF CC JUMP 0x0x8d4dce20;
8d4dcdfc:	01 da 03 84 	R1=-2080152832;
8d4dce00:	00 63 00 00 
8d4dce04:	07 30       	R0 = R7;
8d4dce06:	21 65       	R1 += 0x24;		/* ( 36) */
8d4dce08:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4dce0c:	76 a3 00 00 
8d4dce10:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dce12:	ad 05       	(R7:5, P5:5) = [SP++];
8d4dce14:	01 e8 00 00 	UNLINK;
8d4dce18:	10 00       	RTS;
8d4dce1a:	00 00       	NOP;
8d4dce1c:	00 00       	NOP;
8d4dce1e:	00 00       	NOP;
8d4dce20:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d4dce24:	b8 00 01 00 
8d4dce28:	f1 b0       	[SP + 0xc] = R1;
8d4dce2a:	0e 30       	R1 = R6;
8d4dce2c:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4dce2e:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dce32:	70 e9 00 00 
8d4dce36:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dce38:	ad 05       	(R7:5, P5:5) = [SP++];
8d4dce3a:	01 e8 00 00 	UNLINK;
8d4dce3e:	10 00       	RTS;
