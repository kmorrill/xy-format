
os.ldr@0x8c03fb08:     file format binary


Disassembly of section .data:

8c03fb08 <.data>:
8c03fb08:	00 e8 37 00 	LINK 0xdc;		/* (220) */
8c03fb0c:	60 05       	[--SP] = (R7:4);
8c03fb0e:	66 6f       	SP += -0x14;		/* (-20) */
8c03fb10:	23 61       	R3 = 0x24 (X);		/*		R3=0x0(  0) */
8c03fb12:	56 30       	R2 = SP;
8c03fb14:	5a 51       	R5 = R2 + R3;
8c03fb16:	38 30       	R7 = R0;
8c03fb18:	21 30       	R4 = R1;
8c03fb1a:	30 30       	R6 = R0;
8c03fb1c:	05 30       	R0 = R5;
8c03fb1e:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8c03fb20:	00 e3 8c 9a 	CALL 0x0x8c053038;
8c03fb24:	0d 30       	R1 = R5;
8c03fb26:	04 30       	R0 = R4;
8c03fb28:	00 e3 f4 8f 	CALL 0x0x8c051b10;
8c03fb2c:	05 30       	R0 = R5;
8c03fb2e:	00 e3 85 8f 	CALL 0x0x8c051a38;
8c03fb32:	56 30       	R2 = SP;
8c03fb34:	83 61       	R3 = 0x30 (X);		/*		R3=0x0(  0) */
8c03fb36:	07 30       	R0 = R7;
8c03fb38:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8c03fb3a:	5a 51       	R5 = R2 + R3;
8c03fb3c:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8c03fb3e:	31 e6 12 00 	[SP + 0x48] = R1;
8c03fb42:	37 e6 11 00 	[SP + 0x44] = R7;
8c03fb46:	b7 e6 34 00 	B[SP + 0x34] = R7;
8c03fb4a:	0d 30       	R1 = R5;
8c03fb4c:	ff e3 da f7 	CALL 0x0x8c03eb00;
8c03fb50:	00 0c       	CC = R0 == 0x0;
8c03fb52:	31 10       	IF !CC JUMP 0x0x8c03fbb4;
8c03fb54:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c03fb58:	fc 1e 00 00 
8c03fb5c:	98 0c       	CC = R0 < 0x3;
8c03fb5e:	1b 10       	IF !CC JUMP 0x0x8c03fb94;
8c03fb60:	30 e4 12 00 	R0 = [SP + 0x48];
8c03fb64:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8c03fb66:	01 0a       	CC = R1 <= R0 (IU);
8c03fb68:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c03fb6a:	08 18       	IF CC JUMP 0x0x8c03fb7a;
8c03fb6c:	b7 e6 34 00 	B[SP + 0x34] = R7;
8c03fb70:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03fb72:	20 05       	(R7:4) = [SP++];
8c03fb74:	01 e8 00 00 	UNLINK;
8c03fb78:	10 00       	RTS;
8c03fb7a:	70 a3       	R0 = [SP + 0x34];
8c03fb7c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03fb80:	e4 e3 00 00 
8c03fb84:	b7 e6 34 00 	B[SP + 0x34] = R7;
8c03fb88:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03fb8a:	20 05       	(R7:4) = [SP++];
8c03fb8c:	01 e8 00 00 	UNLINK;
8c03fb90:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c03fb92:	10 00       	RTS;
8c03fb94:	36 b1       	[SP + 0x10] = R6;
8c03fb96:	09 da 90 11 	P1=294680708;
8c03fb9a:	84 78 00 00 
8c03fb9e:	f1 bc       	[SP + 0xc] = P1;
8c03fba0:	22 e1 d2 01 	R2 = 0x1d2 (X);		/*		R2=0x1d2(466) */
8c03fba4:	01 da 90 11 	R1=294680312;
8c03fba8:	f8 76 00 00 
8c03fbac:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8c03fbae:	00 e3 e3 04 	CALL 0x0x8c040574;
8c03fbb2:	d7 2f       	JUMP.S 0x0x8c03fb60;
8c03fbb4:	56 30       	R2 = SP;
8c03fbb6:	23 e1 4c 00 	R3 = 0x4c (X);		/*		R3=0x4c( 76) */
8c03fbba:	9a 50       	R2 = R2 + R3;
8c03fbbc:	ba b0       	[FP + 0x8] = R2;
8c03fbbe:	b8 a0       	R0 = [FP + 0x8];
8c03fbc0:	00 e3 50 76 	CALL 0x0x8c04e860;
8c03fbc4:	0d 30       	R1 = R5;
8c03fbc6:	e5 64       	R5 += 0x1c;		/* ( 28) */
8c03fbc8:	09 68       	P1 = 0x1 (X);		/*		P1=0x0(  0) */
8c03fbca:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || [SP + 0xc] = P1 || NOP;
8c03fbce:	f1 bc 00 00 
8c03fbd2:	05 30       	R0 = R5;
8c03fbd4:	00 e3 36 81 	CALL 0x0x8c04fe40;
8c03fbd8:	00 0c       	CC = R0 == 0x0;
8c03fbda:	63 10       	IF !CC JUMP 0x0x8c03fca0;
8c03fbdc:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c03fbe0:	fc 1e 00 00 
8c03fbe4:	98 0c       	CC = R0 < 0x3;
8c03fbe6:	49 10       	IF !CC JUMP 0x0x8c03fc78;
8c03fbe8:	98 0c       	CC = R0 < 0x3;
8c03fbea:	17 10       	IF !CC JUMP 0x0x8c03fc18;
8c03fbec:	b8 a0       	R0 = [FP + 0x8];
8c03fbee:	ff e3 55 ff 	CALL 0x0x8c03fa98;
8c03fbf2:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8c03fbf4:	32 e4 12 00 	R2 = [SP + 0x48];
8c03fbf8:	11 0a       	CC = R1 <= R2 (IU);
8c03fbfa:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c03fbfc:	b8 17       	IF !CC JUMP 0x0x8c03fb6c (BP);
8c03fbfe:	70 a3       	R0 = [SP + 0x34];
8c03fc00:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03fc04:	e4 e3 00 00 
8c03fc08:	b7 e6 34 00 	B[SP + 0x34] = R7;
8c03fc0c:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03fc0e:	20 05       	(R7:4) = [SP++];
8c03fc10:	01 e8 00 00 	UNLINK;
8c03fc14:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c03fc16:	10 00       	RTS;
8c03fc18:	23 e1 78 00 	R3 = 0x78 (X);		/*		R3=0x78(120) */
8c03fc1c:	03 c8 00 18 	MNOP || R6 = [FP + 0x8] || R1 = [FP + 0x8];
8c03fc20:	be a0 b9 a0 
8c03fc24:	1e 50       	R0 = R6 + R3;
8c03fc26:	00 e3 67 79 	CALL 0x0x8c04eef4;
8c03fc2a:	03 c8 00 18 	MNOP || P2 = [FP -0x38] || R3 = [FP -0x24];
8c03fc2e:	2a b9 73 b9 
8c03fc32:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8c03fc34:	4f 32       	P1 = FP;
8c03fc36:	1e 0a       	CC = R6 <= R3 (IU);
8c03fc38:	41 6e       	P1 += -0x38;		/* (-56) */
8c03fc3a:	ca 07       	IF CC P1 = P2;
8c03fc3c:	08 da 90 11 	P0=294680300;
8c03fc40:	ec 76 00 00 
8c03fc44:	31 bd       	[SP + 0x10] = P1;
8c03fc46:	f0 bc       	[SP + 0xc] = P0;
8c03fc48:	22 e1 dc 01 	R2 = 0x1dc (X);		/*		R2=0x1dc(476) */
8c03fc4c:	01 da 90 11 	R1=294680312;
8c03fc50:	f8 76 00 00 
8c03fc54:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8c03fc56:	00 e3 8f 04 	CALL 0x0x8c040574;
8c03fc5a:	70 b9       	R0 = [FP -0x24];
8c03fc5c:	06 0a       	CC = R6 <= R0 (IU);
8c03fc5e:	07 18       	IF CC JUMP 0x0x8c03fc6c;
8c03fc60:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8c03fc62:	67 bb       	[FP -0x28] = R7;
8c03fc64:	b7 e6 c8 00 	B[SP + 0xc8] = R7;
8c03fc68:	70 bb       	[FP -0x24] = R0;
8c03fc6a:	c1 2f       	JUMP.S 0x0x8c03fbec;
8c03fc6c:	20 b9       	R0 = [FP -0x38];
8c03fc6e:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03fc72:	e4 e3 00 00 
8c03fc76:	f5 2f       	JUMP.S 0x0x8c03fc60;
8c03fc78:	36 b1       	[SP + 0x10] = R6;
8c03fc7a:	09 da 90 11 	P1=294680740;
8c03fc7e:	a4 78 00 00 
8c03fc82:	f1 bc       	[SP + 0xc] = P1;
8c03fc84:	22 e1 db 01 	R2 = 0x1db (X);		/*		R2=0x1db(475) */
8c03fc88:	01 da 90 11 	R1=294680312;
8c03fc8c:	f8 76 00 00 
8c03fc90:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8c03fc92:	00 e3 71 04 	CALL 0x0x8c040574;
8c03fc96:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c03fc9a:	fc 1e 00 00 
8c03fc9e:	a5 2f       	JUMP.S 0x0x8c03fbe8;
8c03fca0:	b8 a0       	R0 = [FP + 0x8];
8c03fca2:	ff e3 fb fe 	CALL 0x0x8c03fa98;
8c03fca6:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8c03fca8:	30 e4 12 00 	R0 = [SP + 0x48];
8c03fcac:	01 0a       	CC = R1 <= R0 (IU);
8c03fcae:	09 18       	IF CC JUMP 0x0x8c03fcc0;
8c03fcb0:	b7 e6 34 00 	B[SP + 0x34] = R7;
8c03fcb4:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03fcb6:	20 05       	(R7:4) = [SP++];
8c03fcb8:	01 e8 00 00 	UNLINK;
8c03fcbc:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c03fcbe:	10 00       	RTS;
8c03fcc0:	70 a3       	R0 = [SP + 0x34];
8c03fcc2:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03fcc6:	e4 e3 00 00 
8c03fcca:	b7 e6 34 00 	B[SP + 0x34] = R7;
8c03fcce:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03fcd0:	20 05       	(R7:4) = [SP++];
8c03fcd2:	01 e8 00 00 	UNLINK;
8c03fcd6:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c03fcd8:	10 00       	RTS;
8c03fcda:	01 30       	R0 = R1;
8c03fcdc:	08 32       	P1 = R0;
8c03fcde:	00 e8 04 00 	LINK 0x10;		/* (16) */
8c03fce2:	0a 30       	R1 = R2;
8c03fce4:	02 60       	R2 = 0x0 (X);		/*		R2=0x1db(475) */
8c03fce6:	7b 60       	R3 = 0xf (X);		/*		R3=0x78(120) */
8c03fce8:	41 0c       	CC = P1 == 0x0;
8c03fcea:	0c 18       	IF CC JUMP 0x0x8c03fd02;
8c03fcec:	4a b1       	[P1 + 0x14] = R2;
8c03fcee:	8a e6 04 00 	B[P1 + 0x4] = R2;
8c03fcf2:	8b b1       	[P1 + 0x18] = R3;
8c03fcf4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c03fcf8:	b8 00 03 00 
8c03fcfc:	f3 b0       	[SP + 0xc] = R3;
8c03fcfe:	ff e3 39 f6 	CALL 0x0x8c03e970;
8c03fd02:	01 e8 00 00 	UNLINK;
8c03fd06:	10 00       	RTS;
8c03fd08:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c03fd0c:	60 05       	[--SP] = (R7:4);
8c03fd0e:	a6 6f       	SP += -0xc;		/* (-12) */
8c03fd10:	82 ce 02 ca 	R5 = ROT R2 BY 0x0 || [SP + 0x24] = R1 || NOP;
8c03fd14:	71 b2 00 00 
8c03fd18:	02 0c       	CC = R2 == 0x0;
8c03fd1a:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R4 = [SP + 0x24] || NOP;
8c03fd1e:	74 a2 00 00 
8c03fd22:	0d 18       	IF CC JUMP 0x0x8c03fd3c;
8c03fd24:	3a 30       	R7 = R2;
8c03fd26:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R2 = [SP + 0x30] || NOP;
8c03fd2a:	32 a3 00 00 
8c03fd2e:	06 30       	R0 = R6;
8c03fd30:	ff e3 d5 ff 	CALL 0x0x8c03fcda;
8c03fd34:	ff 67       	R7 += -0x1;		/* ( -1) */
8c03fd36:	07 0c       	CC = R7 == 0x0;
8c03fd38:	e4 64       	R4 += 0x1c;		/* ( 28) */
8c03fd3a:	f6 17       	IF !CC JUMP 0x0x8c03fd26 (BP);
8c03fd3c:	e0 60       	R0 = 0x1c (X);		/*		R0=0x0(  0) */
8c03fd3e:	71 a2       	R1 = [SP + 0x24];
8c03fd40:	66 6c       	SP += 0xc;		/* ( 12) */
8c03fd42:	e8 40       	R0 *= R5;
8c03fd44:	20 05       	(R7:4) = [SP++];
8c03fd46:	01 e8 00 00 	UNLINK;
8c03fd4a:	01 50       	R0 = R1 + R0;
8c03fd4c:	10 00       	RTS;
8c03fd4e:	00 00       	NOP;
8c03fd50:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c03fd54:	60 05       	[--SP] = (R7:4);
8c03fd56:	a6 6f       	SP += -0xc;		/* (-12) */
8c03fd58:	11 08       	CC = R1 == R2;
8c03fd5a:	82 ce 02 ca 	R5 = ROT R2 BY 0x0 || [SP + 0x24] = R0 || R0 = [SP + 0x30];
8c03fd5e:	70 b2 30 a3 
8c03fd62:	13 18       	IF CC JUMP 0x0x8c03fd88;
8c03fd64:	82 ce 01 c4 	R2 = ROT R1 BY 0x0 || R6 = [SP + 0x30] || NOP;
8c03fd68:	36 a3 00 00 
8c03fd6c:	3a 30       	R7 = R2;
8c03fd6e:	e4 60       	R4 = 0x1c (X);		/*		R4=0x0(  0) */
8c03fd70:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [SP + 0x24] || NOP;
8c03fd74:	70 a2 00 00 
8c03fd78:	ff e3 b1 ff 	CALL 0x0x8c03fcda;
8c03fd7c:	a7 50       	R2 = R7 + R4;
8c03fd7e:	15 08       	CC = R5 == R2;
8c03fd80:	a6 51       	R6 = R6 + R4;
8c03fd82:	3a 30       	R7 = R2;
8c03fd84:	f6 17       	IF !CC JUMP 0x0x8c03fd70 (BP);
8c03fd86:	06 30       	R0 = R6;
8c03fd88:	66 6c       	SP += 0xc;		/* ( 12) */
8c03fd8a:	20 05       	(R7:4) = [SP++];
8c03fd8c:	01 e8 00 00 	UNLINK;
8c03fd90:	10 00       	RTS;
8c03fd92:	00 00       	NOP;
