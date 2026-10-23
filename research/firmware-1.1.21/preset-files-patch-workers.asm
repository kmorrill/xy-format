
os.ldr@0x8d4dda00:     file format binary


Disassembly of section .data:

8d4dda00 <.data>:
8d4dda00:	00 18       	IF CC JUMP 0x0x8d4dda00;
8d4dda02:	f3 b9       	R3 = [FP -0x4];
8d4dda04:	a2 b9       	R2 = [FP -0x18];
8d4dda06:	1f 0a       	CC = R7 <= R3 (IU);
8d4dda08:	0a 07       	IF CC R1 = R2;
8d4dda0a:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4dda0e:	76 a3 00 00 
8d4dda12:	06 30       	R0 = R6;
8d4dda14:	01 e3 e8 07 	CALL 0x0x8d4fe9e4;
8d4dda18:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R0 = [FP -0x20] || NOP;
8d4dda1c:	80 b9 00 00 
8d4dda20:	07 0a       	CC = R7 <= R0 (IU);
8d4dda22:	1f 18       	IF CC JUMP 0x0x8d4dda60;
8d4dda24:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || [FP -0x20] = R4;
8d4dda28:	f0 b9 84 bb 
8d4dda2c:	07 0a       	CC = R7 <= R0 (IU);
8d4dda2e:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x24] = R5 || NOP;
8d4dda32:	75 bb 00 00 
8d4dda36:	b5 e6 3c 00 	B[SP + 0x3c] = R5;
8d4dda3a:	08 18       	IF CC JUMP 0x0x8d4dda4a;
8d4dda3c:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4dda40:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dda42:	20 05       	(R7:4) = [SP++];
8d4dda44:	01 e8 00 00 	UNLINK;
8d4dda48:	10 00       	RTS;
8d4dda4a:	a0 b9       	R0 = [FP -0x18];
8d4dda4c:	ff e3 cc 84 	CALL 0x0x8d4ce3e4;
8d4dda50:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4dda54:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dda56:	06 30       	R0 = R6;
8d4dda58:	20 05       	(R7:4) = [SP++];
8d4dda5a:	01 e8 00 00 	UNLINK;
8d4dda5e:	10 00       	RTS;
8d4dda60:	f0 a3       	R0 = [SP + 0x3c];
8d4dda62:	ff e3 c1 84 	CALL 0x0x8d4ce3e4;
8d4dda66:	df 2f       	JUMP.S 0x0x8d4dda24;
8d4dda68:	30 a2       	R0 = [SP + 0x20];
8d4dda6a:	ff e3 bd 84 	CALL 0x0x8d4ce3e4;
8d4dda6e:	b9 2f       	JUMP.S 0x0x8d4dd9e0;
8d4dda70:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4dda74:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d4dda78:	f7 b0 00 00 
8d4dda7c:	00 de 05 8c 	CALL.A 0x8c051056;
8d4dda80:	56 10 00 00 
8d4dda84:	21 60       	R1 = 0x4 (X);		/*		R1=0x0(  0) */
8d4dda86:	08 08       	CC = R0 == R1;
8d4dda88:	08 18       	IF CC JUMP 0x0x8d4dda98;
8d4dda8a:	04 cc 00 40 	R0 = R0 - R0 (NS) || R7 = [SP + 0xc] || NOP;
8d4dda8e:	f7 a0 00 00 
8d4dda92:	01 e8 00 00 	UNLINK;
8d4dda96:	10 00       	RTS;
8d4dda98:	07 30       	R0 = R7;
8d4dda9a:	00 de 05 8c 	CALL.A 0x8c051c90;
8d4dda9e:	90 1c 00 00 
8d4ddaa2:	01 da 03 84 	R1=-2080152560;
8d4ddaa6:	10 64 00 00 
8d4ddaaa:	38 30       	R7 = R0;
8d4ddaac:	00 de 02 04 	CALL.A 0x040231b4;
8d4ddab0:	b4 31 00 00 
8d4ddab4:	00 0c       	CC = R0 == 0x0;
8d4ddab6:	01 da 03 84 	R1=-2080152560;
8d4ddaba:	10 64 00 00 
8d4ddabe:	09 10       	IF !CC JUMP 0x0x8d4ddad0;
8d4ddac0:	f7 a0       	R7 = [SP + 0xc];
8d4ddac2:	01 e8 00 00 	UNLINK;
8d4ddac6:	00 da 55 15 	R0=357913941;
8d4ddaca:	55 55 00 00 
8d4ddace:	10 00       	RTS;
8d4ddad0:	41 64       	R1 += 0x8;		/* (  8) */
8d4ddad2:	07 30       	R0 = R7;
8d4ddad4:	00 de 02 04 	CALL.A 0x040231b4;
8d4ddad8:	b4 31 00 00 
8d4ddadc:	00 0c       	CC = R0 == 0x0;
8d4ddade:	01 da 03 84 	R1=-2080152560;
8d4ddae2:	10 64 00 00 
8d4ddae6:	09 10       	IF !CC JUMP 0x0x8d4ddaf8;
8d4ddae8:	f7 a0       	R7 = [SP + 0xc];
8d4ddaea:	01 e8 00 00 	UNLINK;
8d4ddaee:	00 da ff 3f 	R0=1073741823;
8d4ddaf2:	ff ff 00 00 
8d4ddaf6:	10 00       	RTS;
8d4ddaf8:	07 30       	R0 = R7;
8d4ddafa:	81 64       	R1 += 0x10;		/* ( 16) */
8d4ddafc:	00 de 02 04 	CALL.A 0x040231b4;
8d4ddb00:	b4 31 00 00 
8d4ddb04:	f7 a0       	R7 = [SP + 0xc];
8d4ddb06:	01 e8 00 00 	UNLINK;
8d4ddb0a:	00 0c       	CC = R0 == 0x0;
8d4ddb0c:	01 da 55 15 	R1=357913941;
8d4ddb10:	55 55 00 00 
8d4ddb14:	00 da aa 6a 	R0=1789569705;
8d4ddb18:	a9 aa 00 00 
8d4ddb1c:	01 06       	IF !CC R0 = R1;
8d4ddb1e:	10 00       	RTS;
8d4ddb20:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4ddb24:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d4ddb28:	f7 b0 00 00 
8d4ddb2c:	00 de 05 8c 	CALL.A 0x8c051056;
8d4ddb30:	56 10 00 00 
8d4ddb34:	08 0c       	CC = R0 == 0x1;
8d4ddb36:	09 18       	IF CC JUMP 0x0x8d4ddb48;
8d4ddb38:	f7 a0       	R7 = [SP + 0xc];
8d4ddb3a:	01 e8 00 00 	UNLINK;
8d4ddb3e:	00 da ff 3f 	R0=1073741816;
8d4ddb42:	f8 ff 00 00 
8d4ddb46:	10 00       	RTS;
8d4ddb48:	07 30       	R0 = R7;
8d4ddb4a:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4ddb4e:	88 1d 00 00 
8d4ddb52:	21 61       	R1 = 0x24 (X);		/*		R1=0x0(  0) */
8d4ddb54:	07 cc 01 40 	R0 = MIN (R0, R1) || R7 = [SP + 0xc] || NOP;
8d4ddb58:	f7 a0 00 00 
8d4ddb5c:	e1 62       	R1 = -0x24 (X);		/*		R1=0x0(  0) */
8d4ddb5e:	07 c4 01 00 	R0 = MAX (R0, R1);
8d4ddb62:	01 e8 00 00 	UNLINK;
8d4ddb66:	20 65       	R0 += 0x24;		/* ( 36) */
8d4ddb68:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4ddb6a:	07 c4 01 00 	R0 = MAX (R0, R1);
8d4ddb6e:	01 da c0 01 	R1=29417584;
8d4ddb72:	70 e0 00 00 
8d4ddb76:	c8 40       	R0 *= R1;
8d4ddb78:	01 da e0 00 	R1=14708792;
8d4ddb7c:	38 70 00 00 
8d4ddb80:	04 c4 01 20 	R0 = R0 + R1 (S);
8d4ddb84:	10 00       	RTS;
8d4ddb86:	08 32       	P1 = R0;
8d4ddb88:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4ddb8c:	08 91       	R0 = [P1];
8d4ddb8e:	01 e8 00 00 	UNLINK;
8d4ddb92:	80 4d       	R0 >>>= 0x10;
8d4ddb94:	10 00       	RTS;
8d4ddb96:	08 32       	P1 = R0;
8d4ddb98:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4ddb9c:	20 e1 49 00 	R0 = 0x49 (X);		/*		R0=0x49( 73) */
8d4ddba0:	09 91       	R1 = [P1];
8d4ddba2:	01 e8 00 00 	UNLINK;
8d4ddba6:	41 4d       	R1 >>>= 0x8;
8d4ddba8:	c8 40       	R0 *= R1;
8d4ddbaa:	b8 4d       	R0 >>>= 0x17;
8d4ddbac:	e0 66       	R0 += -0x24;		/* (-36) */
8d4ddbae:	10 00       	RTS;
8d4ddbb0:	08 32       	P1 = R0;
8d4ddbb2:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4ddbb6:	20 e1 81 00 	R0 = 0x81 (X);		/*		R0=0x81(129) */
8d4ddbba:	09 91       	R1 = [P1];
8d4ddbbc:	01 e8 00 00 	UNLINK;
8d4ddbc0:	41 4d       	R1 >>>= 0x8;
8d4ddbc2:	c8 40       	R0 *= R1;
8d4ddbc4:	b8 4d       	R0 >>>= 0x17;
8d4ddbc6:	f8 67       	R0 += -0x1;		/* ( -1) */
8d4ddbc8:	10 00       	RTS;
8d4ddbca:	00 00       	NOP;
8d4ddbcc:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4ddbd0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d4ddbd4:	f7 b0 00 00 
8d4ddbd8:	00 de 05 8c 	CALL.A 0x8c05101a;
8d4ddbdc:	1a 10 00 00 
8d4ddbe0:	00 0c       	CC = R0 == 0x0;
8d4ddbe2:	0d 10       	IF !CC JUMP 0x0x8d4ddbfc;
8d4ddbe4:	07 30       	R0 = R7;
8d4ddbe6:	00 de 05 8c 	CALL.A 0x8c051042;
8d4ddbea:	42 10 00 00 
8d4ddbee:	00 0c       	CC = R0 == 0x0;
8d4ddbf0:	00 60       	R0 = 0x0 (X);		/*		R0=0x81(129) */
8d4ddbf2:	05 10       	IF !CC JUMP 0x0x8d4ddbfc;
8d4ddbf4:	f7 a0       	R7 = [SP + 0xc];
8d4ddbf6:	01 e8 00 00 	UNLINK;
8d4ddbfa:	10 00       	RTS;
8d4ddbfc:	07 30       	R0 = R7;
8d4ddbfe:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4ddc02:	88 1d 00 00 
8d4ddc06:	38 0c       	CC = R0 == -0x1;
8d4ddc08:	04 cc 09 42 	R1 = R1 - R1 (NS) || R7 = [SP + 0xc] || NOP;
8d4ddc0c:	f7 a0 00 00 
8d4ddc10:	0d 18       	IF CC JUMP 0x0x8d4ddc2a;
8d4ddc12:	08 64       	R0 += 0x1;		/* (  1) */
8d4ddc14:	01 da fe 00 	R1=16647160;
8d4ddc18:	f8 03 00 00 
8d4ddc1c:	c8 40       	R0 *= R1;
8d4ddc1e:	01 da 7f 00 	R1=8323580;
8d4ddc22:	fc 01 00 00 
8d4ddc26:	04 c4 01 22 	R1 = R0 + R1 (S);
8d4ddc2a:	01 30       	R0 = R1;
8d4ddc2c:	01 e8 00 00 	UNLINK;
8d4ddc30:	10 00       	RTS;
8d4ddc32:	08 32       	P1 = R0;
8d4ddc34:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4ddc38:	20 e1 09 10 	R0 = 0x1009 (X);		/*		R0=0x1009(4105) */
8d4ddc3c:	09 91       	R1 = [P1];
8d4ddc3e:	01 e8 00 00 	UNLINK;
8d4ddc42:	41 4d       	R1 >>>= 0x8;
8d4ddc44:	0a c6 01 40 	R0 = EXTRACT (R1, R0.L) (X);
8d4ddc48:	10 00       	RTS;
8d4ddc4a:	00 00       	NOP;
8d4ddc4c:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4ddc50:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d4ddc54:	f7 b0 00 00 
8d4ddc58:	00 de 05 8c 	CALL.A 0x8c05101a;
8d4ddc5c:	1a 10 00 00 
8d4ddc60:	00 0c       	CC = R0 == 0x0;
8d4ddc62:	0d 10       	IF !CC JUMP 0x0x8d4ddc7c;
8d4ddc64:	07 30       	R0 = R7;
8d4ddc66:	00 de 05 8c 	CALL.A 0x8c051042;
8d4ddc6a:	42 10 00 00 
8d4ddc6e:	00 0c       	CC = R0 == 0x0;
8d4ddc70:	00 60       	R0 = 0x0 (X);		/*		R0=0x1009(4105) */
8d4ddc72:	05 10       	IF !CC JUMP 0x0x8d4ddc7c;
8d4ddc74:	f7 a0       	R7 = [SP + 0xc];
8d4ddc76:	01 e8 00 00 	UNLINK;
8d4ddc7a:	10 00       	RTS;
8d4ddc7c:	07 30       	R0 = R7;
8d4ddc7e:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4ddc82:	88 1d 00 00 
8d4ddc86:	f7 a0       	R7 = [SP + 0xc];
8d4ddc88:	01 e8 00 00 	UNLINK;
8d4ddc8c:	01 da ff 00 	R1=16777215;
8d4ddc90:	ff ff 00 00 
8d4ddc94:	c8 40       	R0 *= R1;
8d4ddc96:	01 da 7f 00 	R1=8388607;
8d4ddc9a:	ff ff 00 00 
8d4ddc9e:	04 c4 01 20 	R0 = R0 + R1 (S);
8d4ddca2:	10 00       	RTS;
8d4ddca4:	00 e8 14 00 	LINK 0x50;		/* (80) */
8d4ddca8:	e3 05       	[--SP] = (R7:4, P5:3);
8d4ddcaa:	45 60       	R5 = 0x8 (X);		/*		R5=0x0(  0) */
8d4ddcac:	66 6f       	SP += -0x14;		/* (-20) */
8d4ddcae:	a9 08       	CC = R1 < R5;
8d4ddcb0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0x30] = R1 || NOP;
8d4ddcb4:	31 b3 00 00 
8d4ddcb8:	18 32       	P3 = R0;
8d4ddcba:	02 1c       	IF CC JUMP 0x0x8d4ddcbe (BP);
8d4ddcbc:	36 26       	JUMP.S 0x0x8d4de928;
8d4ddcbe:	47 64       	R7 += 0x8;		/* (  8) */
8d4ddcc0:	3f b1       	[FP + 0x10] = R7;
8d4ddcc2:	01 da 03 84 	R1=-2080152536;
8d4ddcc6:	28 64 00 00 
8d4ddcca:	06 da 03 84 	R6=-2080152536;
8d4ddcce:	28 64 00 00 
8d4ddcd2:	e7 61       	R7 = 0x3c (X);		/*		R7=0x0(  0) */
8d4ddcd4:	38 a1       	R0 = [FP + 0x10];
8d4ddcd6:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4ddcda:	c0 27 00 00 
8d4ddcde:	00 0c       	CC = R0 == 0x0;
8d4ddce0:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP + 0x10] || NOP;
8d4ddce4:	38 a1 00 00 
8d4ddce8:	02 1c       	IF CC JUMP 0x0x8d4ddcec (BP);
8d4ddcea:	eb 25       	JUMP.S 0x0x8d4de8c0;
8d4ddcec:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8d4ddcee:	02 0c       	CC = R2 == 0x0;
8d4ddcf0:	0f 18       	IF CC JUMP 0x0x8d4ddd0e;
8d4ddcf2:	50 b9       	R0 = [FP -0x2c];
8d4ddcf4:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4ddcf6:	01 0a       	CC = R1 <= R0 (IU);
8d4ddcf8:	02 14       	IF !CC JUMP 0x0x8d4ddcfc (BP);
8d4ddcfa:	dc 25       	JUMP.S 0x0x8d4de8b2;
8d4ddcfc:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4ddcfe:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP -0x30] = R2 || NOP;
8d4ddd02:	42 bb 00 00 
8d4ddd06:	78 60       	R0 = 0xf (X);		/*		R0=0x1009(4105) */
8d4ddd08:	b1 e6 40 00 	B[SP + 0x40] = R1;
8d4ddd0c:	50 bb       	[FP -0x2c] = R0;
8d4ddd0e:	07 0c       	CC = R7 == 0x0;
8d4ddd10:	07 da 03 84 	R7=-2080152232;
8d4ddd14:	58 65 00 00 
8d4ddd18:	04 1c       	IF CC JUMP 0x0x8d4ddd20 (BP);
8d4ddd1a:	af 25       	JUMP.S 0x0x8d4de878;
8d4ddd1c:	00 00       	NOP;
8d4ddd1e:	00 00       	NOP;
8d4ddd20:	82 ce 06 c8 	R4 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4ddd24:	38 a1 00 00 
8d4ddd28:	a6 64       	R6 += 0x14;		/* ( 20) */
8d4ddd2a:	0e 30       	R1 = R6;
8d4ddd2c:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4ddd30:	c0 27 00 00 
8d4ddd34:	00 0c       	CC = R0 == 0x0;
8d4ddd36:	05 14       	IF !CC JUMP 0x0x8d4ddd40 (BP);
8d4ddd38:	80 25       	JUMP.S 0x0x8d4de838;
8d4ddd3a:	00 00       	NOP;
8d4ddd3c:	00 00       	NOP;
8d4ddd3e:	00 00       	NOP;
8d4ddd40:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4ddd44:	38 a1 00 00 
8d4ddd48:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddd4c:	14 33 00 00 
8d4ddd50:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4ddd54:	88 1d 00 00 
8d4ddd58:	98 0c       	CC = R0 < 0x3;
8d4ddd5a:	18 e6 60 00 	[P3 + 0x180] = R0;
8d4ddd5e:	08 30       	R1 = R0;
8d4ddd60:	04 14       	IF !CC JUMP 0x0x8d4ddd68 (BP);
8d4ddd62:	4b 25       	JUMP.S 0x0x8d4de7f8;
8d4ddd64:	00 00       	NOP;
8d4ddd66:	00 00       	NOP;
8d4ddd68:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP + 0xc] = R4 || NOP;
8d4ddd6c:	fc b0 00 00 
8d4ddd70:	c4 66       	R4 += -0x28;		/* (-40) */
8d4ddd72:	63 32       	P4 = P3;
8d4ddd74:	b4 b3       	[SP + 0x38] = R4;
8d4ddd76:	84 6d       	P4 += 0x30;		/* ( 48) */
8d4ddd78:	44 30       	R0 = P4;
8d4ddd7a:	22 e1 e8 00 	R2 = 0xe8 (X);		/*		R2=0xe8(232) */
8d4ddd7e:	00 de 02 04 	CALL.A 0x04022ea8;
8d4ddd82:	a8 2e 00 00 
8d4ddd86:	06 da 00 40 	R6=1073741824;
8d4ddd8a:	00 00 00 00 
8d4ddd8e:	07 da 00 40 	R7=1073741824;
8d4ddd92:	00 00 00 00 
8d4ddd96:	03 da 00 40 	R3=1073741824;
8d4ddd9a:	00 00 00 00 
8d4ddd9e:	02 da 00 40 	R2=1073741824;
8d4ddda2:	00 00 00 00 
8d4ddda6:	1e e6 3b 00 	[P3 + 0xec] = R6;
8d4dddaa:	1f e6 44 00 	[P3 + 0x110] = R7;
8d4dddae:	1b e6 37 00 	[P3 + 0xdc] = R3;
8d4dddb2:	1a e6 39 00 	[P3 + 0xe4] = R2;
8d4dddb6:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R0 = [FP + 0x10] || R1 = [SP + 0x38];
8d4dddba:	38 a1 b1 a3 
8d4dddbe:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4dddc2:	c0 27 00 00 
8d4dddc6:	03 c8 00 18 	MNOP || R4 = [FP + 0xc] || R1 = [SP + 0x38];
8d4dddca:	fc a0 b1 a3 
8d4dddce:	00 0c       	CC = R0 == 0x0;
8d4dddd0:	e4 64       	R4 += 0x1c;		/* ( 28) */
8d4dddd2:	de 18       	IF CC JUMP 0x0x8d4ddf8e;
8d4dddd4:	38 a1       	R0 = [FP + 0x10];
8d4dddd6:	77 30       	R6 = FP;
8d4dddd8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddddc:	14 33 00 00 
8d4ddde0:	c6 66       	R6 += -0x28;		/* (-40) */
8d4ddde2:	08 30       	R1 = R0;
8d4ddde4:	06 30       	R0 = R6;
8d4ddde6:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4dddea:	f0 2b 00 00 
8d4dddee:	6c 32       	P5 = P4;
8d4dddf0:	0c 30       	R1 = R4;
8d4dddf2:	06 30       	R0 = R6;
8d4dddf4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dddf8:	14 33 00 00 
8d4dddfc:	0f 30       	R1 = R7;
8d4dddfe:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4dde02:	e4 30 00 00 
8d4dde06:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4dde0a:	ff e3 1b f8 	CALL 0x0x8d4dce40;
8d4dde0e:	0f 64       	R7 += 0x1;		/* (  1) */
8d4dde10:	af 08       	CC = R7 < R5;
8d4dde12:	03 c8 00 18 	MNOP || [P5++] = R0 || R1 = [FP + 0xc];
8d4dde16:	28 92 f9 a0 
8d4dde1a:	eb 1f       	IF CC JUMP 0x0x8d4dddf0 (BP);
8d4dde1c:	20 e1 a8 ff 	R0 = -0x58 (X);		/*		R0=0xffffffa8(-88) */
8d4dde20:	fb a0       	R3 = [FP + 0xc];
8d4dde22:	41 50       	R1 = R1 + R0;
8d4dde24:	22 e1 68 00 	R2 = 0x68 (X);		/*		R2=0x68(104) */
8d4dde28:	06 30       	R0 = R6;
8d4dde2a:	d3 51       	R7 = R3 + R2;
8d4dde2c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dde30:	14 33 00 00 
8d4dde34:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4dde38:	ff e3 1c fe 	CALL 0x0x8d4dda70;
8d4dde3c:	18 e6 18 00 	[P3 + 0x60] = R0;
8d4dde40:	06 30       	R0 = R6;
8d4dde42:	01 da 03 84 	R1=-2080151972;
8d4dde46:	5c 66 00 00 
8d4dde4a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dde4e:	14 33 00 00 
8d4dde52:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4dde56:	ff e3 f5 f7 	CALL 0x0x8d4dce40;
8d4dde5a:	01 da 03 84 	R1=-2080152536;
8d4dde5e:	28 64 00 00 
8d4dde62:	18 e6 19 00 	[P3 + 0x64] = R0;
8d4dde66:	21 65       	R1 += 0x24;		/* ( 36) */
8d4dde68:	06 30       	R0 = R6;
8d4dde6a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dde6e:	14 33 00 00 
8d4dde72:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4dde76:	ff e3 e5 f7 	CALL 0x0x8d4dce40;
8d4dde7a:	01 da 03 84 	R1=-2080152536;
8d4dde7e:	28 64 00 00 
8d4dde82:	18 e6 1a 00 	[P3 + 0x68] = R0;
8d4dde86:	81 65       	R1 += 0x30;		/* ( 48) */
8d4dde88:	06 30       	R0 = R6;
8d4dde8a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dde8e:	14 33 00 00 
8d4dde92:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4dde96:	ff e3 d5 f7 	CALL 0x0x8d4dce40;
8d4dde9a:	22 e1 b4 ff 	R2 = -0x4c (X);		/*		R2=0xffffffb4(-76) */
8d4dde9e:	fb a0       	R3 = [FP + 0xc];
8d4ddea0:	18 e6 1b 00 	[P3 + 0x6c] = R0;
8d4ddea4:	53 50       	R1 = R3 + R2;
8d4ddea6:	06 30       	R0 = R6;
8d4ddea8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddeac:	14 33 00 00 
8d4ddeb0:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4ddeb4:	ff e3 36 fe 	CALL 0x0x8d4ddb20;
8d4ddeb8:	01 da 03 84 	R1=-2080152536;
8d4ddebc:	28 64 00 00 
8d4ddec0:	18 e6 40 00 	[P3 + 0x100] = R0;
8d4ddec4:	c1 65       	R1 += 0x38;		/* ( 56) */
8d4ddec6:	06 30       	R0 = R6;
8d4ddec8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddecc:	14 33 00 00 
8d4dded0:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4dded4:	ff e3 b6 f7 	CALL 0x0x8d4dce40;
8d4dded8:	18 e6 3f 00 	[P3 + 0xfc] = R0;
8d4ddedc:	06 30       	R0 = R6;
8d4ddede:	01 da 03 84 	R1=-2080151952;
8d4ddee2:	70 66 00 00 
8d4ddee6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddeea:	14 33 00 00 
8d4ddeee:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4ddef2:	ff e3 a7 f7 	CALL 0x0x8d4dce40;
8d4ddef6:	18 e6 3c 00 	[P3 + 0xf0] = R0;
8d4ddefa:	06 30       	R0 = R6;
8d4ddefc:	01 da 03 84 	R1=-2080151928;
8d4ddf00:	88 66 00 00 
8d4ddf04:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddf08:	14 33 00 00 
8d4ddf0c:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4ddf10:	ff e3 98 f7 	CALL 0x0x8d4dce40;
8d4ddf14:	22 e1 40 00 	R2 = 0x40 (X);		/*		R2=0x40( 64) */
8d4ddf18:	fb a0       	R3 = [FP + 0xc];
8d4ddf1a:	18 e6 3d 00 	[P3 + 0xf4] = R0;
8d4ddf1e:	53 50       	R1 = R3 + R2;
8d4ddf20:	06 30       	R0 = R6;
8d4ddf22:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddf26:	14 33 00 00 
8d4ddf2a:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4ddf2e:	ff e3 89 f7 	CALL 0x0x8d4dce40;
8d4ddf32:	22 e1 50 00 	R2 = 0x50 (X);		/*		R2=0x50( 80) */
8d4ddf36:	fb a0       	R3 = [FP + 0xc];
8d4ddf38:	18 e6 3e 00 	[P3 + 0xf8] = R0;
8d4ddf3c:	53 50       	R1 = R3 + R2;
8d4ddf3e:	06 30       	R0 = R6;
8d4ddf40:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddf44:	14 33 00 00 
8d4ddf48:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4ddf4c:	ff e3 7a f7 	CALL 0x0x8d4dce40;
8d4ddf50:	22 e1 5c 00 	R2 = 0x5c (X);		/*		R2=0x5c( 92) */
8d4ddf54:	fb a0       	R3 = [FP + 0xc];
8d4ddf56:	18 e6 41 00 	[P3 + 0x104] = R0;
8d4ddf5a:	53 50       	R1 = R3 + R2;
8d4ddf5c:	06 30       	R0 = R6;
8d4ddf5e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddf62:	14 33 00 00 
8d4ddf66:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4ddf6a:	ff e3 6b f7 	CALL 0x0x8d4dce40;
8d4ddf6e:	18 e6 42 00 	[P3 + 0x108] = R0;
8d4ddf72:	0f 30       	R1 = R7;
8d4ddf74:	06 30       	R0 = R6;
8d4ddf76:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4ddf7a:	c0 27 00 00 
8d4ddf7e:	00 0c       	CC = R0 == 0x0;
8d4ddf80:	02 1c       	IF CC JUMP 0x0x8d4ddf84 (BP);
8d4ddf82:	28 23       	JUMP.S 0x0x8d4de5d2;
8d4ddf84:	06 30       	R0 = R6;
8d4ddf86:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4ddf8a:	38 1a 00 00 
8d4ddf8e:	6c 32       	P5 = P4;
8d4ddf90:	d6 61       	R6 = 0x3a (X);		/*		R6=0x0(  0) */
8d4ddf92:	d7 61       	R7 = 0x3a (X);		/*		R7=0x0(  0) */
8d4ddf94:	28 90       	R0 = [P5++];
8d4ddf96:	80 0c       	CC = R0 < 0x0;
8d4ddf98:	02 14       	IF !CC JUMP 0x0x8d4ddf9c (BP);
8d4ddf9a:	13 23       	JUMP.S 0x0x8d4de5c0;
8d4ddf9c:	ff 67       	R7 += -0x1;		/* ( -1) */
8d4ddf9e:	07 0c       	CC = R7 == 0x0;
8d4ddfa0:	fa 17       	IF !CC JUMP 0x0x8d4ddf94 (BP);
8d4ddfa2:	21 e1 b4 00 	R1 = 0xb4 (X);		/*		R1=0xb4(180) */
8d4ddfa6:	03 c8 00 18 	MNOP || R2 = [FP + 0xc] || R0 = [FP + 0x10];
8d4ddfaa:	fa a0 38 a1 
8d4ddfae:	ca 51       	R7 = R2 + R1;
8d4ddfb0:	0f 30       	R1 = R7;
8d4ddfb2:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4ddfb6:	c0 27 00 00 
8d4ddfba:	00 0c       	CC = R0 == 0x0;
8d4ddfbc:	02 1c       	IF CC JUMP 0x0x8d4ddfc0 (BP);
8d4ddfbe:	0d 22       	JUMP.S 0x0x8d4de3d8;
8d4ddfc0:	21 e1 ec 00 	R1 = 0xec (X);		/*		R1=0xec(236) */
8d4ddfc4:	03 c8 00 18 	MNOP || R2 = [FP + 0xc] || R0 = [FP + 0x10];
8d4ddfc8:	fa a0 38 a1 
8d4ddfcc:	ca 51       	R7 = R2 + R1;
8d4ddfce:	0f 30       	R1 = R7;
8d4ddfd0:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4ddfd4:	c0 27 00 00 
8d4ddfd8:	00 0c       	CC = R0 == 0x0;
8d4ddfda:	03 14       	IF !CC JUMP 0x0x8d4ddfe0 (BP);
8d4ddfdc:	f6 21       	JUMP.S 0x0x8d4de3c8;
8d4ddfde:	00 00       	NOP;
8d4ddfe0:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP + 0x10] || R7 = [FP + 0xc];
8d4ddfe4:	38 a1 ff a0 
8d4ddfe8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ddfec:	14 33 00 00 
8d4ddff0:	57 30       	R2 = FP;
8d4ddff2:	c2 66       	R2 += -0x28;		/* (-40) */
8d4ddff4:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d4ddff8:	ba b0 00 00 
8d4ddffc:	b8 a0       	R0 = [FP + 0x8];
8d4ddffe:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4de002:	f0 2b 00 00 
8d4de006:	23 e1 98 fe 	R3 = -0x168 (X);		/*		R3=0xfffffe98(-360) */
8d4de00a:	04 cc 3b 02 	R1 = R7 + R3 (NS) || R0 = [FP + 0x8] || NOP;
8d4de00e:	b8 a0 00 00 
8d4de012:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de016:	14 33 00 00 
8d4de01a:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de01e:	ff e3 af fc 	CALL 0x0x8d4dd97c;
8d4de022:	22 e1 f0 00 	R2 = 0xf0 (X);		/*		R2=0xf0(240) */
8d4de026:	18 e6 48 00 	[P3 + 0x120] = R0;
8d4de02a:	04 cc 3a 02 	R1 = R7 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4de02e:	b8 a0 00 00 
8d4de032:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de036:	14 33 00 00 
8d4de03a:	00 de 05 8c 	CALL.A 0x8c0520dc;
8d4de03e:	dc 20 00 00 
8d4de042:	98 e6 24 01 	B[P3 + 0x124] = R0;
8d4de046:	18 e4 48 00 	R0 = [P3 + 0x120];
8d4de04a:	00 e3 f2 f7 	CALL 0x0x8d4fd02e;
8d4de04e:	00 0c       	CC = R0 == 0x0;
8d4de050:	07 10       	IF !CC JUMP 0x0x8d4de05e;
8d4de052:	01 60       	R1 = 0x0 (X);		/*		R1=0xec(236) */
8d4de054:	50 60       	R0 = 0xa (X);		/*		R0=0xffffffa8(-88) */
8d4de056:	99 e6 24 01 	B[P3 + 0x124] = R1;
8d4de05a:	18 e6 48 00 	[P3 + 0x120] = R0;
8d4de05e:	29 e1 70 00 	P1 = 0x70 (X);		/*		P1=0x70(112) */
8d4de062:	4b 5b       	P5 = P3 + P1;
8d4de064:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4de066:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4de06a:	b8 a0 00 00 
8d4de06e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de072:	14 33 00 00 
8d4de076:	0f 30       	R1 = R7;
8d4de078:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4de07c:	e4 30 00 00 
8d4de080:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de084:	ff e3 de f6 	CALL 0x0x8d4dce40;
8d4de088:	0f 64       	R7 += 0x1;		/* (  1) */
8d4de08a:	af 08       	CC = R7 < R5;
8d4de08c:	03 c8 00 18 	MNOP || [P5++] = R0 || R0 = [FP + 0x8];
8d4de090:	28 92 b8 a0 
8d4de094:	e9 1f       	IF CC JUMP 0x0x8d4de066 (BP);
8d4de096:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4de09a:	38 1a 00 00 
8d4de09e:	21 e1 f8 00 	R1 = 0xf8 (X);		/*		R1=0xf8(248) */
8d4de0a2:	03 c8 00 18 	MNOP || R2 = [FP + 0xc] || R0 = [FP + 0x10];
8d4de0a6:	fa a0 38 a1 
8d4de0aa:	ca 51       	R7 = R2 + R1;
8d4de0ac:	0f 30       	R1 = R7;
8d4de0ae:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de0b2:	c0 27 00 00 
8d4de0b6:	00 0c       	CC = R0 == 0x0;
8d4de0b8:	81 19       	IF CC JUMP 0x0x8d4de3ba;
8d4de0ba:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4de0be:	38 a1 00 00 
8d4de0c2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de0c6:	14 33 00 00 
8d4de0ca:	57 30       	R2 = FP;
8d4de0cc:	a2 67       	R2 += -0xc;		/* (-12) */
8d4de0ce:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d4de0d2:	ba b0 00 00 
8d4de0d6:	7f 30       	R7 = FP;
8d4de0d8:	c7 66       	R7 += -0x28;		/* (-40) */
8d4de0da:	b8 a0       	R0 = [FP + 0x8];
8d4de0dc:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4de0e0:	f0 2b 00 00 
8d4de0e4:	23 e1 98 fe 	R3 = -0x168 (X);		/*		R3=0xfffffe98(-360) */
8d4de0e8:	03 c8 00 18 	MNOP || R2 = [FP + 0xc] || R0 = [FP + 0x8];
8d4de0ec:	fa a0 b8 a0 
8d4de0f0:	5a 50       	R1 = R2 + R3;
8d4de0f2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de0f6:	14 33 00 00 
8d4de0fa:	00 de 05 8c 	CALL.A 0x8c051c90;
8d4de0fe:	90 1c 00 00 
8d4de102:	08 30       	R1 = R0;
8d4de104:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa8(-88) */
8d4de106:	04 cc 1b 46 	R3 = R3 - R3 (NS) || [FP -0x10] = R0 || NOP;
8d4de10a:	c0 bb 00 00 
8d4de10e:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x14] = R3 || NOP;
8d4de112:	b3 bb 00 00 
8d4de116:	b2 e6 5c 00 	B[SP + 0x5c] = R2;
8d4de11a:	07 30       	R0 = R7;
8d4de11c:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4de120:	76 a3 00 00 
8d4de124:	07 30       	R0 = R7;
8d4de126:	06 e3 0f 2a 	CALL 0x0x8d5a3544;
8d4de12a:	82 60       	R2 = 0x10 (X);		/*		R2=0xf0(240) */
8d4de12c:	c1 b9       	R1 = [FP -0x10];
8d4de12e:	0a 0a       	CC = R2 <= R1 (IU);
8d4de130:	18 e6 46 00 	[P3 + 0x118] = R0;
8d4de134:	3f 19       	IF CC JUMP 0x0x8d4de3b2;
8d4de136:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4de13a:	b8 a0 00 00 
8d4de13e:	b2 e6 5c 00 	B[SP + 0x5c] = R2;
8d4de142:	21 e1 f0 00 	R1 = 0xf0 (X);		/*		R1=0xf0(240) */
8d4de146:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8d4de148:	04 cc 1b 46 	R3 = R3 - R3 (NS) || R2 = [FP + 0xc] || [FP -0x10] = R7;
8d4de14c:	fa a0 c7 bb 
8d4de150:	04 cc 11 02 	R1 = R2 + R1 (NS) || [FP -0x14] = R3 || NOP;
8d4de154:	b3 bb 00 00 
8d4de158:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de15c:	14 33 00 00 
8d4de160:	00 de 05 8c 	CALL.A 0x8c0520dc;
8d4de164:	dc 20 00 00 
8d4de168:	98 e6 1c 01 	B[P3 + 0x11c] = R0;
8d4de16c:	18 e4 46 00 	R0 = [P3 + 0x118];
8d4de170:	3a 60       	R2 = 0x7 (X);		/*		R2=0xf0(240) */
8d4de172:	10 08       	CC = R0 == R2;
8d4de174:	07 10       	IF !CC JUMP 0x0x8d4de182;
8d4de176:	01 60       	R1 = 0x0 (X);		/*		R1=0xf0(240) */
8d4de178:	08 60       	R0 = 0x1 (X);		/*		R0=0xffffffa8(-88) */
8d4de17a:	99 e6 1c 01 	B[P3 + 0x11c] = R1;
8d4de17e:	18 e6 46 00 	[P3 + 0x118] = R0;
8d4de182:	29 e1 90 00 	P1 = 0x90 (X);		/*		P1=0x90(144) */
8d4de186:	4b 5b       	P5 = P3 + P1;
8d4de188:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4de18a:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4de18e:	b8 a0 00 00 
8d4de192:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de196:	14 33 00 00 
8d4de19a:	0f 30       	R1 = R7;
8d4de19c:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4de1a0:	e4 30 00 00 
8d4de1a4:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de1a8:	ff e3 4c f6 	CALL 0x0x8d4dce40;
8d4de1ac:	0f 64       	R7 += 0x1;		/* (  1) */
8d4de1ae:	af 08       	CC = R7 < R5;
8d4de1b0:	03 c8 00 18 	MNOP || [P5++] = R0 || R0 = [FP + 0x8];
8d4de1b4:	28 92 b8 a0 
8d4de1b8:	e9 1f       	IF CC JUMP 0x0x8d4de18a (BP);
8d4de1ba:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4de1be:	38 1a 00 00 
8d4de1c2:	18 e4 4a 00 	R0 = [P3 + 0x128];
8d4de1c6:	e9 60       	R1 = 0x1d (X);		/*		R1=0xf0(240) */
8d4de1c8:	08 08       	CC = R0 == R1;
8d4de1ca:	c4 10       	IF !CC JUMP 0x0x8d4de352;
8d4de1cc:	03 c8 00 18 	MNOP || R1 = [SP + 0x38] || R0 = [FP + 0x10];
8d4de1d0:	b1 a3 38 a1 
8d4de1d4:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de1d8:	c0 27 00 00 
8d4de1dc:	00 0c       	CC = R0 == 0x0;
8d4de1de:	ba 18       	IF CC JUMP 0x0x8d4de352;
8d4de1e0:	57 30       	R2 = FP;
8d4de1e2:	c2 66       	R2 += -0x28;		/* (-40) */
8d4de1e4:	03 c8 00 18 	MNOP || [FP + 0x8] = R2 || R7 = [FP + 0xc];
8d4de1e8:	ba b0 ff a0 
8d4de1ec:	23 e1 fc 00 	R3 = 0xfc (X);		/*		R3=0xfc(252) */
8d4de1f0:	04 cc 3b 0e 	R7 = R7 + R3 (NS) || R1 = [SP + 0x38] || R0 = [FP + 0x10];
8d4de1f4:	b1 a3 38 a1 
8d4de1f8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de1fc:	14 33 00 00 
8d4de200:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4de204:	b8 a0 00 00 
8d4de208:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4de20c:	f0 2b 00 00 
8d4de210:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4de214:	b8 a0 00 00 
8d4de218:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de21c:	c0 27 00 00 
8d4de220:	00 0c       	CC = R0 == 0x0;
8d4de222:	93 18       	IF CC JUMP 0x0x8d4de348;
8d4de224:	20 e1 00 01 	R0 = 0x100 (X);		/*		R0=0x100(256) */
8d4de228:	f9 a0       	R1 = [FP + 0xc];
8d4de22a:	01 50       	R0 = R1 + R0;
8d4de22c:	29 e1 50 00 	P1 = 0x50 (X);		/*		P1=0x50( 80) */
8d4de230:	70 b3       	[SP + 0x34] = R0;
8d4de232:	4b 5b       	P5 = P3 + P1;
8d4de234:	25 60       	R5 = 0x4 (X);		/*		R5=0x0(  0) */
8d4de236:	04 60       	R4 = 0x0 (X);		/*		R4=0x0(  0) */
8d4de238:	03 c8 00 18 	MNOP || R1 = [SP + 0x38] || R0 = [FP + 0x10];
8d4de23c:	b1 a3 38 a1 
8d4de240:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de244:	14 33 00 00 
8d4de248:	0f 30       	R1 = R7;
8d4de24a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de24e:	14 33 00 00 
8d4de252:	0c 30       	R1 = R4;
8d4de254:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4de258:	e4 30 00 00 
8d4de25c:	71 a3       	R1 = [SP + 0x34];
8d4de25e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de262:	14 33 00 00 
8d4de266:	ff e3 f3 fc 	CALL 0x0x8d4ddc4c;
8d4de26a:	0c 64       	R4 += 0x1;		/* (  1) */
8d4de26c:	ac 08       	CC = R4 < R5;
8d4de26e:	28 92       	[P5++] = R0;
8d4de270:	e4 1f       	IF CC JUMP 0x0x8d4de238 (BP);
8d4de272:	29 e1 70 00 	P1 = 0x70 (X);		/*		P1=0x70(112) */
8d4de276:	20 60       	R0 = 0x4 (X);		/*		R0=0x100(256) */
8d4de278:	4b 5b       	P5 = P3 + P1;
8d4de27a:	f8 b0       	[FP + 0xc] = R0;
8d4de27c:	24 60       	R4 = 0x4 (X);		/*		R4=0x0(  0) */
8d4de27e:	03 c8 00 18 	MNOP || R1 = [SP + 0x38] || R0 = [FP + 0x10];
8d4de282:	b1 a3 38 a1 
8d4de286:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de28a:	14 33 00 00 
8d4de28e:	0f 30       	R1 = R7;
8d4de290:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de294:	14 33 00 00 
8d4de298:	f9 a0       	R1 = [FP + 0xc];
8d4de29a:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4de29e:	e4 30 00 00 
8d4de2a2:	71 a3       	R1 = [SP + 0x34];
8d4de2a4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de2a8:	14 33 00 00 
8d4de2ac:	ff e3 d0 fc 	CALL 0x0x8d4ddc4c;
8d4de2b0:	03 c8 00 18 	MNOP || R2 = [FP + 0xc] || [P5++] = R0;
8d4de2b4:	fa a0 28 92 
8d4de2b8:	fc 67       	R4 += -0x1;		/* ( -1) */
8d4de2ba:	0a 64       	R2 += 0x1;		/* (  1) */
8d4de2bc:	04 0c       	CC = R4 == 0x0;
8d4de2be:	fa b0       	[FP + 0xc] = R2;
8d4de2c0:	df 17       	IF !CC JUMP 0x0x8d4de27e (BP);
8d4de2c2:	29 e1 60 00 	P1 = 0x60 (X);		/*		P1=0x60( 96) */
8d4de2c6:	4b 5b       	P5 = P3 + P1;
8d4de2c8:	04 60       	R4 = 0x0 (X);		/*		R4=0x0(  0) */
8d4de2ca:	03 c8 00 18 	MNOP || R1 = [SP + 0x38] || R0 = [FP + 0x10];
8d4de2ce:	b1 a3 38 a1 
8d4de2d2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de2d6:	14 33 00 00 
8d4de2da:	0f 30       	R1 = R7;
8d4de2dc:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de2e0:	14 33 00 00 
8d4de2e4:	0c 30       	R1 = R4;
8d4de2e6:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4de2ea:	e4 30 00 00 
8d4de2ee:	0f 30       	R1 = R7;
8d4de2f0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de2f4:	14 33 00 00 
8d4de2f8:	ff e3 6a fc 	CALL 0x0x8d4ddbcc;
8d4de2fc:	0c 64       	R4 += 0x1;		/* (  1) */
8d4de2fe:	ac 08       	CC = R4 < R5;
8d4de300:	28 92       	[P5++] = R0;
8d4de302:	e4 1f       	IF CC JUMP 0x0x8d4de2ca (BP);
8d4de304:	29 e1 80 00 	P1 = 0x80 (X);		/*		P1=0x80(128) */
8d4de308:	4b 5b       	P5 = P3 + P1;
8d4de30a:	24 60       	R4 = 0x4 (X);		/*		R4=0x0(  0) */
8d4de30c:	03 c8 00 18 	MNOP || R1 = [SP + 0x38] || R0 = [FP + 0x10];
8d4de310:	b1 a3 38 a1 
8d4de314:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de318:	14 33 00 00 
8d4de31c:	0f 30       	R1 = R7;
8d4de31e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de322:	14 33 00 00 
8d4de326:	0c 30       	R1 = R4;
8d4de328:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4de32c:	e4 30 00 00 
8d4de330:	0f 30       	R1 = R7;
8d4de332:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de336:	14 33 00 00 
8d4de33a:	ff e3 49 fc 	CALL 0x0x8d4ddbcc;
8d4de33e:	fd 67       	R5 += -0x1;		/* ( -1) */
8d4de340:	05 0c       	CC = R5 == 0x0;
8d4de342:	28 92       	[P5++] = R0;
8d4de344:	0c 64       	R4 += 0x1;		/* (  1) */
8d4de346:	e3 17       	IF !CC JUMP 0x0x8d4de30c (BP);
8d4de348:	b8 a0       	R0 = [FP + 0x8];
8d4de34a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4de34e:	38 1a 00 00 
8d4de352:	30 af       	P0 = [SP + 0x30];
8d4de354:	09 da 03 84 	P1=-2080151856;
8d4de358:	d0 66 00 00 
8d4de35c:	00 da 00 40 	R0=1073741824;
8d4de360:	00 00 00 00 
8d4de364:	18 e6 34 00 	[P3 + 0xd0] = R0;
8d4de368:	41 5e       	P1 = P1 + (P0 << 0x2);
8d4de36a:	08 91       	R0 = [P1];
8d4de36c:	02 da 00 40 	R2=1073741824;
8d4de370:	00 00 00 00 
8d4de374:	01 da 00 40 	R1=1073741824;
8d4de378:	00 00 00 00 
8d4de37c:	18 e6 35 00 	[P3 + 0xd4] = R0;
8d4de380:	1a e6 32 00 	[P3 + 0xc8] = R2;
8d4de384:	19 e6 33 00 	[P3 + 0xcc] = R1;
8d4de388:	20 90       	R0 = [P4++];
8d4de38a:	80 0c       	CC = R0 < 0x0;
8d4de38c:	0a 18       	IF CC JUMP 0x0x8d4de3a0;
8d4de38e:	fe 67       	R6 += -0x1;		/* ( -1) */
8d4de390:	06 0c       	CC = R6 == 0x0;
8d4de392:	fb 17       	IF !CC JUMP 0x0x8d4de388 (BP);
8d4de394:	08 60       	R0 = 0x1 (X);		/*		R0=0x100(256) */
8d4de396:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4de398:	a3 05       	(R7:4, P5:3) = [SP++];
8d4de39a:	01 e8 00 00 	UNLINK;
8d4de39e:	10 00       	RTS;
8d4de3a0:	00 da 03 84 	R0=-2080151824;
8d4de3a4:	f0 66 00 00 
8d4de3a8:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d4de3ac:	a4 05 00 00 
8d4de3b0:	ef 2f       	JUMP.S 0x0x8d4de38e;
8d4de3b2:	70 b9       	R0 = [FP -0x24];
8d4de3b4:	ff e3 18 80 	CALL 0x0x8d4ce3e4;
8d4de3b8:	bf 2e       	JUMP.S 0x0x8d4de136;
8d4de3ba:	01 60       	R1 = 0x0 (X);		/*		R1=0xf0(240) */
8d4de3bc:	08 60       	R0 = 0x1 (X);		/*		R0=0x100(256) */
8d4de3be:	99 e6 1c 01 	B[P3 + 0x11c] = R1;
8d4de3c2:	18 e6 46 00 	[P3 + 0x118] = R0;
8d4de3c6:	fe 2e       	JUMP.S 0x0x8d4de1c2;
8d4de3c8:	01 60       	R1 = 0x0 (X);		/*		R1=0xf0(240) */
8d4de3ca:	50 60       	R0 = 0xa (X);		/*		R0=0x100(256) */
8d4de3cc:	99 e6 24 01 	B[P3 + 0x124] = R1;
8d4de3d0:	18 e6 48 00 	[P3 + 0x120] = R0;
8d4de3d4:	65 2e       	JUMP.S 0x0x8d4de09e;
8d4de3d6:	00 00       	NOP;
8d4de3d8:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4de3dc:	38 a1 00 00 
8d4de3e0:	7f 30       	R7 = FP;
8d4de3e2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de3e6:	14 33 00 00 
8d4de3ea:	c7 66       	R7 += -0x28;		/* (-40) */
8d4de3ec:	08 30       	R1 = R0;
8d4de3ee:	07 30       	R0 = R7;
8d4de3f0:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4de3f4:	f0 2b 00 00 
8d4de3f8:	22 e1 c0 00 	R2 = 0xc0 (X);		/*		R2=0xc0(192) */
8d4de3fc:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R3 = [FP + 0xc] || NOP;
8d4de400:	fb a0 00 00 
8d4de404:	93 50       	R2 = R3 + R2;
8d4de406:	ba b0       	[FP + 0x8] = R2;
8d4de408:	b9 a0       	R1 = [FP + 0x8];
8d4de40a:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de40e:	c0 27 00 00 
8d4de412:	00 0c       	CC = R0 == 0x0;
8d4de414:	76 10       	IF !CC JUMP 0x0x8d4de500;
8d4de416:	22 e1 e4 00 	R2 = 0xe4 (X);		/*		R2=0xe4(228) */
8d4de41a:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R3 = [FP + 0xc] || NOP;
8d4de41e:	fb a0 00 00 
8d4de422:	93 50       	R2 = R3 + R2;
8d4de424:	ba b0       	[FP + 0x8] = R2;
8d4de426:	b9 a0       	R1 = [FP + 0x8];
8d4de428:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de42c:	c0 27 00 00 
8d4de430:	00 0c       	CC = R0 == 0x0;
8d4de432:	07 10       	IF !CC JUMP 0x0x8d4de440;
8d4de434:	07 30       	R0 = R7;
8d4de436:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4de43a:	38 1a 00 00 
8d4de43e:	c1 2d       	JUMP.S 0x0x8d4ddfc0;
8d4de440:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de444:	b9 a0 00 00 
8d4de448:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de44c:	14 33 00 00 
8d4de450:	57 30       	R2 = FP;
8d4de452:	22 67       	R2 += -0x1c;		/* (-28) */
8d4de454:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d4de458:	ba b0 00 00 
8d4de45c:	b8 a0       	R0 = [FP + 0x8];
8d4de45e:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4de462:	f0 2b 00 00 
8d4de466:	23 e1 c4 00 	R3 = 0xc4 (X);		/*		R3=0xc4(196) */
8d4de46a:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4de46e:	f9 a0 b8 a0 
8d4de472:	59 50       	R1 = R1 + R3;
8d4de474:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de478:	14 33 00 00 
8d4de47c:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de480:	ff e3 e0 f4 	CALL 0x0x8d4dce40;
8d4de484:	22 e1 cc 00 	R2 = 0xcc (X);		/*		R2=0xcc(204) */
8d4de488:	fb a0       	R3 = [FP + 0xc];
8d4de48a:	18 e6 2c 00 	[P3 + 0xb0] = R0;
8d4de48e:	04 cc 1a 02 	R1 = R3 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4de492:	b8 a0 00 00 
8d4de496:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de49a:	14 33 00 00 
8d4de49e:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de4a2:	ff e3 cf f4 	CALL 0x0x8d4dce40;
8d4de4a6:	22 e1 d4 00 	R2 = 0xd4 (X);		/*		R2=0xd4(212) */
8d4de4aa:	fb a0       	R3 = [FP + 0xc];
8d4de4ac:	18 e6 2d 00 	[P3 + 0xb4] = R0;
8d4de4b0:	04 cc 1a 02 	R1 = R3 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4de4b4:	b8 a0 00 00 
8d4de4b8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de4bc:	14 33 00 00 
8d4de4c0:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de4c4:	ff e3 be f4 	CALL 0x0x8d4dce40;
8d4de4c8:	22 e1 dc 00 	R2 = 0xdc (X);		/*		R2=0xdc(220) */
8d4de4cc:	fb a0       	R3 = [FP + 0xc];
8d4de4ce:	18 e6 2e 00 	[P3 + 0xb8] = R0;
8d4de4d2:	04 cc 1a 02 	R1 = R3 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4de4d6:	b8 a0 00 00 
8d4de4da:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de4de:	14 33 00 00 
8d4de4e2:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de4e6:	ff e3 ad f4 	CALL 0x0x8d4dce40;
8d4de4ea:	18 e6 2f 00 	[P3 + 0xbc] = R0;
8d4de4ee:	b8 a0       	R0 = [FP + 0x8];
8d4de4f0:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4de4f4:	38 1a 00 00 
8d4de4f8:	9e 2f       	JUMP.S 0x0x8d4de434;
8d4de4fa:	00 00       	NOP;
8d4de4fc:	00 00       	NOP;
8d4de4fe:	00 00       	NOP;
8d4de500:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de504:	b9 a0 00 00 
8d4de508:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de50c:	14 33 00 00 
8d4de510:	57 30       	R2 = FP;
8d4de512:	22 67       	R2 += -0x1c;		/* (-28) */
8d4de514:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d4de518:	ba b0 00 00 
8d4de51c:	b8 a0       	R0 = [FP + 0x8];
8d4de51e:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4de522:	f0 2b 00 00 
8d4de526:	23 e1 c4 00 	R3 = 0xc4 (X);		/*		R3=0xc4(196) */
8d4de52a:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4de52e:	f9 a0 b8 a0 
8d4de532:	59 50       	R1 = R1 + R3;
8d4de534:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de538:	14 33 00 00 
8d4de53c:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de540:	ff e3 80 f4 	CALL 0x0x8d4dce40;
8d4de544:	22 e1 cc 00 	R2 = 0xcc (X);		/*		R2=0xcc(204) */
8d4de548:	fb a0       	R3 = [FP + 0xc];
8d4de54a:	18 e6 14 00 	[P3 + 0x50] = R0;
8d4de54e:	04 cc 1a 02 	R1 = R3 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4de552:	b8 a0 00 00 
8d4de556:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de55a:	14 33 00 00 
8d4de55e:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de562:	ff e3 6f f4 	CALL 0x0x8d4dce40;
8d4de566:	22 e1 d4 00 	R2 = 0xd4 (X);		/*		R2=0xd4(212) */
8d4de56a:	fb a0       	R3 = [FP + 0xc];
8d4de56c:	18 e6 15 00 	[P3 + 0x54] = R0;
8d4de570:	04 cc 1a 02 	R1 = R3 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4de574:	b8 a0 00 00 
8d4de578:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de57c:	14 33 00 00 
8d4de580:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de584:	ff e3 5e f4 	CALL 0x0x8d4dce40;
8d4de588:	22 e1 dc 00 	R2 = 0xdc (X);		/*		R2=0xdc(220) */
8d4de58c:	fb a0       	R3 = [FP + 0xc];
8d4de58e:	18 e6 16 00 	[P3 + 0x58] = R0;
8d4de592:	04 cc 1a 02 	R1 = R3 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4de596:	b8 a0 00 00 
8d4de59a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de59e:	14 33 00 00 
8d4de5a2:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de5a6:	ff e3 4d f4 	CALL 0x0x8d4dce40;
8d4de5aa:	18 e6 17 00 	[P3 + 0x5c] = R0;
8d4de5ae:	b8 a0       	R0 = [FP + 0x8];
8d4de5b0:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4de5b4:	38 1a 00 00 
8d4de5b8:	2f 2f       	JUMP.S 0x0x8d4de416;
8d4de5ba:	00 00       	NOP;
8d4de5bc:	00 00       	NOP;
8d4de5be:	00 00       	NOP;
8d4de5c0:	00 da 03 84 	R0=-2080151912;
8d4de5c4:	98 66 00 00 
8d4de5c8:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d4de5cc:	a4 05 00 00 
8d4de5d0:	e6 2c       	JUMP.S 0x0x8d4ddf9c;
8d4de5d2:	0f 30       	R1 = R7;
8d4de5d4:	06 30       	R0 = R6;
8d4de5d6:	7f 30       	R7 = FP;
8d4de5d8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de5dc:	14 33 00 00 
8d4de5e0:	27 67       	R7 += -0x1c;		/* (-28) */
8d4de5e2:	08 30       	R1 = R0;
8d4de5e4:	07 30       	R0 = R7;
8d4de5e6:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4de5ea:	f0 2b 00 00 
8d4de5ee:	22 e1 74 00 	R2 = 0x74 (X);		/*		R2=0x74(116) */
8d4de5f2:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R3 = [FP + 0xc] || NOP;
8d4de5f6:	fb a0 00 00 
8d4de5fa:	93 50       	R2 = R3 + R2;
8d4de5fc:	ba b0       	[FP + 0x8] = R2;
8d4de5fe:	b9 a0       	R1 = [FP + 0x8];
8d4de600:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de604:	c0 27 00 00 
8d4de608:	00 0c       	CC = R0 == 0x0;
8d4de60a:	c7 10       	IF !CC JUMP 0x0x8d4de798;
8d4de60c:	22 e1 90 00 	R2 = 0x90 (X);		/*		R2=0x90(144) */
8d4de610:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R3 = [FP + 0xc] || NOP;
8d4de614:	fb a0 00 00 
8d4de618:	93 50       	R2 = R3 + R2;
8d4de61a:	ba b0       	[FP + 0x8] = R2;
8d4de61c:	b9 a0       	R1 = [FP + 0x8];
8d4de61e:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de622:	c0 27 00 00 
8d4de626:	00 0c       	CC = R0 == 0x0;
8d4de628:	88 10       	IF !CC JUMP 0x0x8d4de738;
8d4de62a:	22 e1 9c 00 	R2 = 0x9c (X);		/*		R2=0x9c(156) */
8d4de62e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R3 = [FP + 0xc] || NOP;
8d4de632:	fb a0 00 00 
8d4de636:	93 50       	R2 = R3 + R2;
8d4de638:	ba b0       	[FP + 0x8] = R2;
8d4de63a:	b9 a0       	R1 = [FP + 0x8];
8d4de63c:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de640:	c0 27 00 00 
8d4de644:	00 0c       	CC = R0 == 0x0;
8d4de646:	49 10       	IF !CC JUMP 0x0x8d4de6d8;
8d4de648:	22 e1 a8 00 	R2 = 0xa8 (X);		/*		R2=0xa8(168) */
8d4de64c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R3 = [FP + 0xc] || NOP;
8d4de650:	fb a0 00 00 
8d4de654:	93 50       	R2 = R3 + R2;
8d4de656:	ba b0       	[FP + 0x8] = R2;
8d4de658:	b9 a0       	R1 = [FP + 0x8];
8d4de65a:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de65e:	c0 27 00 00 
8d4de662:	00 0c       	CC = R0 == 0x0;
8d4de664:	0a 10       	IF !CC JUMP 0x0x8d4de678;
8d4de666:	07 30       	R0 = R7;
8d4de668:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4de66c:	38 1a 00 00 
8d4de670:	8a 2c       	JUMP.S 0x0x8d4ddf84;
8d4de672:	00 00       	NOP;
8d4de674:	00 00       	NOP;
8d4de676:	00 00       	NOP;
8d4de678:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de67c:	b9 a0 00 00 
8d4de680:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de684:	14 33 00 00 
8d4de688:	22 e1 80 00 	R2 = 0x80 (X);		/*		R2=0x80(128) */
8d4de68c:	fb a0       	R3 = [FP + 0xc];
8d4de68e:	53 50       	R1 = R3 + R2;
8d4de690:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de694:	14 33 00 00 
8d4de698:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de69c:	ff e3 d2 f3 	CALL 0x0x8d4dce40;
8d4de6a0:	18 e6 43 00 	[P3 + 0x10c] = R0;
8d4de6a4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de6a8:	b9 a0 00 00 
8d4de6ac:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de6b0:	14 33 00 00 
8d4de6b4:	22 e1 88 00 	R2 = 0x88 (X);		/*		R2=0x88(136) */
8d4de6b8:	fb a0       	R3 = [FP + 0xc];
8d4de6ba:	53 50       	R1 = R3 + R2;
8d4de6bc:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de6c0:	14 33 00 00 
8d4de6c4:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de6c8:	ff e3 bc f3 	CALL 0x0x8d4dce40;
8d4de6cc:	18 e6 44 00 	[P3 + 0x110] = R0;
8d4de6d0:	cb 2f       	JUMP.S 0x0x8d4de666;
8d4de6d2:	00 00       	NOP;
8d4de6d4:	00 00       	NOP;
8d4de6d6:	00 00       	NOP;
8d4de6d8:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de6dc:	b9 a0 00 00 
8d4de6e0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de6e4:	14 33 00 00 
8d4de6e8:	22 e1 80 00 	R2 = 0x80 (X);		/*		R2=0x80(128) */
8d4de6ec:	fb a0       	R3 = [FP + 0xc];
8d4de6ee:	53 50       	R1 = R3 + R2;
8d4de6f0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de6f4:	14 33 00 00 
8d4de6f8:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de6fc:	ff e3 a2 f3 	CALL 0x0x8d4dce40;
8d4de700:	18 e6 3a 00 	[P3 + 0xe8] = R0;
8d4de704:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de708:	b9 a0 00 00 
8d4de70c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de710:	14 33 00 00 
8d4de714:	22 e1 88 00 	R2 = 0x88 (X);		/*		R2=0x88(136) */
8d4de718:	fb a0       	R3 = [FP + 0xc];
8d4de71a:	53 50       	R1 = R3 + R2;
8d4de71c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de720:	14 33 00 00 
8d4de724:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de728:	ff e3 8c f3 	CALL 0x0x8d4dce40;
8d4de72c:	18 e6 3b 00 	[P3 + 0xec] = R0;
8d4de730:	8c 2f       	JUMP.S 0x0x8d4de648;
8d4de732:	00 00       	NOP;
8d4de734:	00 00       	NOP;
8d4de736:	00 00       	NOP;
8d4de738:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de73c:	b9 a0 00 00 
8d4de740:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de744:	14 33 00 00 
8d4de748:	22 e1 80 00 	R2 = 0x80 (X);		/*		R2=0x80(128) */
8d4de74c:	fb a0       	R3 = [FP + 0xc];
8d4de74e:	53 50       	R1 = R3 + R2;
8d4de750:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de754:	14 33 00 00 
8d4de758:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de75c:	ff e3 72 f3 	CALL 0x0x8d4dce40;
8d4de760:	18 e6 38 00 	[P3 + 0xe0] = R0;
8d4de764:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de768:	b9 a0 00 00 
8d4de76c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de770:	14 33 00 00 
8d4de774:	22 e1 88 00 	R2 = 0x88 (X);		/*		R2=0x88(136) */
8d4de778:	fb a0       	R3 = [FP + 0xc];
8d4de77a:	53 50       	R1 = R3 + R2;
8d4de77c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de780:	14 33 00 00 
8d4de784:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de788:	ff e3 5c f3 	CALL 0x0x8d4dce40;
8d4de78c:	18 e6 39 00 	[P3 + 0xe4] = R0;
8d4de790:	4d 2f       	JUMP.S 0x0x8d4de62a;
8d4de792:	00 00       	NOP;
8d4de794:	00 00       	NOP;
8d4de796:	00 00       	NOP;
8d4de798:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de79c:	b9 a0 00 00 
8d4de7a0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de7a4:	14 33 00 00 
8d4de7a8:	22 e1 80 00 	R2 = 0x80 (X);		/*		R2=0x80(128) */
8d4de7ac:	fb a0       	R3 = [FP + 0xc];
8d4de7ae:	53 50       	R1 = R3 + R2;
8d4de7b0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de7b4:	14 33 00 00 
8d4de7b8:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de7bc:	ff e3 42 f3 	CALL 0x0x8d4dce40;
8d4de7c0:	18 e6 36 00 	[P3 + 0xd8] = R0;
8d4de7c4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4de7c8:	b9 a0 00 00 
8d4de7cc:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de7d0:	14 33 00 00 
8d4de7d4:	22 e1 88 00 	R2 = 0x88 (X);		/*		R2=0x88(136) */
8d4de7d8:	fb a0       	R3 = [FP + 0xc];
8d4de7da:	53 50       	R1 = R3 + R2;
8d4de7dc:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de7e0:	14 33 00 00 
8d4de7e4:	19 e4 60 00 	R1 = [P3 + 0x180];
8d4de7e8:	ff e3 2c f3 	CALL 0x0x8d4dce40;
8d4de7ec:	18 e6 37 00 	[P3 + 0xdc] = R0;
8d4de7f0:	0e 2f       	JUMP.S 0x0x8d4de60c;
8d4de7f2:	00 00       	NOP;
8d4de7f4:	00 00       	NOP;
8d4de7f6:	00 00       	NOP;
8d4de7f8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4de7fc:	fc 1e 00 00 
8d4de800:	98 0c       	CC = R0 < 0x3;
8d4de802:	00 60       	R0 = 0x0 (X);		/*		R0=0x100(256) */
8d4de804:	02 10       	IF !CC JUMP 0x0x8d4de808;
8d4de806:	c8 2d       	JUMP.S 0x0x8d4de396;
8d4de808:	09 da 03 84 	P1=-2080151992;
8d4de80c:	48 66 00 00 
8d4de810:	31 b1       	[SP + 0x10] = R1;
8d4de812:	f1 bc       	[SP + 0xc] = P1;
8d4de814:	22 e1 1d 01 	R2 = 0x11d (X);		/*		R2=0x11d(285) */
8d4de818:	18 60       	R0 = 0x3 (X);		/*		R0=0x100(256) */
8d4de81a:	01 da 03 84 	R1=-2080152232;
8d4de81e:	58 65 00 00 
8d4de822:	00 de 04 8c 	CALL.A 0x8c040574;
8d4de826:	74 05 00 00 
8d4de82a:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4de82c:	a3 05       	(R7:4, P5:3) = [SP++];
8d4de82e:	01 e8 00 00 	UNLINK;
8d4de832:	00 60       	R0 = 0x0 (X);		/*		R0=0x100(256) */
8d4de834:	10 00       	RTS;
8d4de836:	00 00       	NOP;
8d4de838:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4de83c:	fc 1e 00 00 
8d4de840:	98 0c       	CC = R0 < 0x3;
8d4de842:	00 60       	R0 = 0x0 (X);		/*		R0=0x100(256) */
8d4de844:	02 10       	IF !CC JUMP 0x0x8d4de848;
8d4de846:	a8 2d       	JUMP.S 0x0x8d4de396;
8d4de848:	09 da 03 84 	P1=-2080152008;
8d4de84c:	38 66 00 00 
8d4de850:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = P1 || NOP;
8d4de854:	f1 bc 00 00 
8d4de858:	22 e1 16 01 	R2 = 0x116 (X);		/*		R2=0x116(278) */
8d4de85c:	18 60       	R0 = 0x3 (X);		/*		R0=0x100(256) */
8d4de85e:	00 de 04 8c 	CALL.A 0x8c040574;
8d4de862:	74 05 00 00 
8d4de866:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4de868:	a3 05       	(R7:4, P5:3) = [SP++];
8d4de86a:	01 e8 00 00 	UNLINK;
8d4de86e:	00 60       	R0 = 0x0 (X);		/*		R0=0x100(256) */
8d4de870:	10 00       	RTS;
8d4de872:	00 00       	NOP;
8d4de874:	00 00       	NOP;
8d4de876:	00 00       	NOP;
8d4de878:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4de87c:	fc 1e 00 00 
8d4de880:	98 0c       	CC = R0 < 0x3;
8d4de882:	00 60       	R0 = 0x0 (X);		/*		R0=0x100(256) */
8d4de884:	02 10       	IF !CC JUMP 0x0x8d4de888;
8d4de886:	88 2d       	JUMP.S 0x0x8d4de396;
8d4de888:	09 da 03 84 	P1=-2080152032;
8d4de88c:	20 66 00 00 
8d4de890:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = P1 || NOP;
8d4de894:	f1 bc 00 00 
8d4de898:	22 e1 11 01 	R2 = 0x111 (X);		/*		R2=0x111(273) */
8d4de89c:	18 60       	R0 = 0x3 (X);		/*		R0=0x100(256) */
8d4de89e:	00 de 04 8c 	CALL.A 0x8c040574;
8d4de8a2:	74 05 00 00 
8d4de8a6:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4de8a8:	a3 05       	(R7:4, P5:3) = [SP++];
8d4de8aa:	01 e8 00 00 	UNLINK;
8d4de8ae:	00 60       	R0 = 0x0 (X);		/*		R0=0x100(256) */
8d4de8b0:	10 00       	RTS;
8d4de8b2:	00 b9       	R0 = [FP -0x40];
8d4de8b4:	ff e3 98 7d 	CALL 0x0x8d4ce3e4;
8d4de8b8:	22 2a       	JUMP.S 0x0x8d4ddcfc;
8d4de8ba:	00 00       	NOP;
8d4de8bc:	00 00       	NOP;
8d4de8be:	00 00       	NOP;
8d4de8c0:	01 da 03 84 	R1=-2080152536;
8d4de8c4:	28 64 00 00 
8d4de8c8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de8cc:	14 33 00 00 
8d4de8d0:	00 de 05 8c 	CALL.A 0x8c051004;
8d4de8d4:	04 10 00 00 
8d4de8d8:	00 0c       	CC = R0 == 0x0;
8d4de8da:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP + 0x10] || NOP;
8d4de8de:	38 a1 00 00 
8d4de8e2:	03 10       	IF !CC JUMP 0x0x8d4de8e8;
8d4de8e4:	04 2a       	JUMP.S 0x0x8d4ddcec;
8d4de8e6:	00 00       	NOP;
8d4de8e8:	01 da 03 84 	R1=-2080152536;
8d4de8ec:	28 64 00 00 
8d4de8f0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de8f4:	14 33 00 00 
8d4de8f8:	5e 30       	R3 = SP;
8d4de8fa:	fb 51       	R7 = R3 + R7;
8d4de8fc:	08 30       	R1 = R0;
8d4de8fe:	07 30       	R0 = R7;
8d4de900:	00 de 05 8c 	CALL.A 0x8c051cca;
8d4de904:	ca 1c 00 00 
8d4de908:	01 da 03 84 	R1=-2080152536;
8d4de90c:	28 64 00 00 
8d4de910:	07 30       	R0 = R7;
8d4de912:	61 64       	R1 += 0xc;		/* ( 12) */
8d4de914:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4de918:	88 bf 00 00 
8d4de91c:	00 0c       	CC = R0 == 0x0;
8d4de91e:	0a 60       	R2 = 0x1 (X);		/*		R2=0x111(273) */
8d4de920:	02 14       	IF !CC JUMP 0x0x8d4de924 (BP);
8d4de922:	e5 29       	JUMP.S 0x0x8d4ddcec;
8d4de924:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4de926:	e4 29       	JUMP.S 0x0x8d4ddcee;
8d4de928:	00 da 03 84 	R0=-2080152068;
8d4de92c:	fc 65 00 00 
8d4de930:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d4de934:	a4 05 00 00 
8d4de938:	c3 29       	JUMP.S 0x0x8d4ddcbe;
8d4de93a:	00 00       	NOP;
8d4de93c:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d4de940:	e5 05       	[--SP] = (R7:4, P5:5);
8d4de942:	20 30       	R4 = R0;
8d4de944:	44 64       	R4 += 0x8;		/* (  8) */
8d4de946:	30 30       	R6 = R0;
8d4de948:	28 32       	P5 = R0;
8d4de94a:	39 30       	R7 = R1;
8d4de94c:	86 6f       	SP += -0x10;		/* (-16) */
8d4de94e:	0a 30       	R1 = R2;
8d4de950:	04 30       	R0 = R4;
8d4de952:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4de956:	10 1b 00 00 
8d4de95a:	04 30       	R0 = R4;
8d4de95c:	01 da 03 84 	R1=-2080152896;
8d4de960:	c0 62 00 00 
8d4de964:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4de968:	c0 27 00 00 
8d4de96c:	00 0c       	CC = R0 == 0x0;
8d4de96e:	07 10       	IF !CC JUMP 0x0x8d4de97c;
8d4de970:	00 60       	R0 = 0x0 (X);		/*		R0=0x100(256) */
8d4de972:	86 6c       	SP += 0x10;		/* ( 16) */
8d4de974:	a5 05       	(R7:4, P5:5) = [SP++];
8d4de976:	01 e8 00 00 	UNLINK;
8d4de97a:	10 00       	RTS;
8d4de97c:	04 30       	R0 = R4;
8d4de97e:	01 da 03 84 	R1=-2080152896;
8d4de982:	c0 62 00 00 
8d4de986:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de98a:	14 33 00 00 
8d4de98e:	00 de 05 8c 	CALL.A 0x8c051004;
8d4de992:	04 10 00 00 
8d4de996:	00 0c       	CC = R0 == 0x0;
8d4de998:	ec 1f       	IF CC JUMP 0x0x8d4de970 (BP);
8d4de99a:	57 30       	R2 = FP;
8d4de99c:	42 66       	R2 += -0x38;		/* (-56) */
8d4de99e:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP + 0x10] = R2 || NOP;
8d4de9a2:	3a b1 00 00 
8d4de9a6:	23 e1 2c 01 	R3 = 0x12c (X);		/*		R3=0x12c(300) */
8d4de9aa:	de 50       	R3 = R6 + R3;
8d4de9ac:	01 da 03 84 	R1=-2080152896;
8d4de9b0:	c0 62 00 00 
8d4de9b4:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [FP + 0x8] = R3 || NOP;
8d4de9b8:	bb b0 00 00 
8d4de9bc:	00 de 05 8c 	CALL.A 0x8c053314;
8d4de9c0:	14 33 00 00 
8d4de9c4:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4de9c8:	38 a1 00 00 
8d4de9cc:	00 de 05 8c 	CALL.A 0x8c051cca;
8d4de9d0:	ca 1c 00 00 
8d4de9d4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4de9d8:	b8 00 03 00 
8d4de9dc:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || R1 = [FP + 0x10];
8d4de9e0:	f3 b0 39 a1 
8d4de9e4:	b8 a0       	R0 = [FP + 0x8];
8d4de9e6:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4de9ea:	70 e9 00 00 
8d4de9ee:	f0 a3       	R0 = [SP + 0x3c];
8d4de9f0:	83 60       	R3 = 0x10 (X);		/*		R3=0x12c(300) */
8d4de9f2:	03 0a       	CC = R3 <= R0 (IU);
8d4de9f4:	6f 18       	IF CC JUMP 0x0x8d4dead2;
8d4de9f6:	5f 30       	R3 = FP;
8d4de9f8:	23 67       	R3 += -0x1c;		/* (-28) */
8d4de9fa:	fb b0       	[FP + 0xc] = R3;
8d4de9fc:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4dea00:	b5 e6 44 00 	B[SP + 0x44] = R5;
8d4dea04:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4dea08:	b8 00 02 00 
8d4dea0c:	79 60       	R1 = 0xf (X);		/*		R1=0xf0(240) */
8d4dea0e:	7b 60       	R3 = 0xf (X);		/*		R3=0x12c(300) */
8d4dea10:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R2 || R0 = [FP + 0xc];
8d4dea14:	f2 b0 f8 a0 
8d4dea18:	03 c8 00 18 	MNOP || [FP -0x4] = R1 || R1 = [FP + 0x8];
8d4dea1c:	f1 bb b9 a0 
8d4dea20:	f3 b3       	[SP + 0x3c] = R3;
8d4dea22:	b5 b3       	[SP + 0x38] = R5;
8d4dea24:	e5 bb       	[FP -0x8] = R5;
8d4dea26:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dea2a:	70 e9 00 00 
8d4dea2e:	03 c8 00 18 	MNOP || R0 = [FP + 0xc] || R1 = [FP + 0xc];
8d4dea32:	f8 a0 f9 a0 
8d4dea36:	20 67       	R0 += -0x1c;		/* (-28) */
8d4dea38:	ff e3 46 f1 	CALL 0x0x8d4dccc4;
8d4dea3c:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4dea40:	b8 00 03 00 
8d4dea44:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || R1 = [FP + 0x10];
8d4dea48:	f3 b0 39 a1 
8d4dea4c:	b8 a0       	R0 = [FP + 0x8];
8d4dea4e:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dea52:	70 e9 00 00 
8d4dea56:	f0 a3       	R0 = [SP + 0x3c];
8d4dea58:	83 60       	R3 = 0x10 (X);		/*		R3=0x12c(300) */
8d4dea5a:	03 0a       	CC = R3 <= R0 (IU);
8d4dea5c:	37 18       	IF CC JUMP 0x0x8d4deaca;
8d4dea5e:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || [SP + 0x38] = R5;
8d4dea62:	f0 b9 b5 b3 
8d4dea66:	81 60       	R1 = 0x10 (X);		/*		R1=0xf0(240) */
8d4dea68:	7a 60       	R2 = 0xf (X);		/*		R2=0x111(273) */
8d4dea6a:	01 0a       	CC = R1 <= R0 (IU);
8d4dea6c:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4dea70:	03 c8 00 18 	MNOP || [SP + 0x3c] = R2 || R0 = [FP -0x18];
8d4dea74:	f2 b3 a0 b9 
8d4dea78:	26 18       	IF CC JUMP 0x0x8d4deac4;
8d4dea7a:	79 60       	R1 = 0xf (X);		/*		R1=0xf0(240) */
8d4dea7c:	03 c8 00 18 	MNOP || [FP -0x8] = R5 || R0 = [FP + 0x8];
8d4dea80:	e5 bb b8 a0 
8d4dea84:	b5 e6 44 00 	B[SP + 0x44] = R5;
8d4dea88:	f1 bb       	[FP -0x4] = R1;
8d4dea8a:	06 e3 b9 1b 	CALL 0x0x8d5a21fc;
8d4dea8e:	0a 61       	R2 = 0x21 (X);		/*		R2=0x111(273) */
8d4dea90:	10 08       	CC = R0 == R2;
8d4dea92:	28 e6 4a 00 	[P5 + 0x128] = R0;
8d4dea96:	08 30       	R1 = R0;
8d4dea98:	00 60       	R0 = 0x0 (X);		/*		R0=0x100(256) */
8d4dea9a:	6c 1f       	IF CC JUMP 0x0x8d4de972 (BP);
8d4dea9c:	01 30       	R0 = R1;
8d4dea9e:	06 e3 9d 1b 	CALL 0x0x8d5a21d8;
8d4deaa2:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || B[P5] = R0 || NOP;
8d4deaa6:	28 9b 00 00 
8d4deaaa:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [P5 + 0x4] = R7 || NOP;
8d4deaae:	6f b0 00 00 
8d4deab2:	06 30       	R0 = R6;
8d4deab4:	ff e3 f8 f8 	CALL 0x0x8d4ddca4;
8d4deab8:	86 6c       	SP += 0x10;		/* ( 16) */
8d4deaba:	a5 05       	(R7:4, P5:5) = [SP++];
8d4deabc:	01 e8 00 00 	UNLINK;
8d4deac0:	10 00       	RTS;
8d4deac2:	00 00       	NOP;
8d4deac4:	ff e3 90 7c 	CALL 0x0x8d4ce3e4;
8d4deac8:	d9 2f       	JUMP.S 0x0x8d4dea7a;
8d4deaca:	b0 a2       	R0 = [SP + 0x28];
8d4deacc:	ff e3 8c 7c 	CALL 0x0x8d4ce3e4;
8d4dead0:	c7 2f       	JUMP.S 0x0x8d4dea5e;
8d4dead2:	b0 a2       	R0 = [SP + 0x28];
8d4dead4:	ff e3 88 7c 	CALL 0x0x8d4ce3e4;
8d4dead8:	8f 2f       	JUMP.S 0x0x8d4de9f6;
8d4deada:	00 00       	NOP;
8d4deadc:	00 e8 15 00 	LINK 0x54;		/* (84) */
8d4deae0:	60 05       	[--SP] = (R7:4);
8d4deae2:	38 30       	R7 = R0;
8d4deae4:	86 6f       	SP += -0x10;		/* (-16) */
8d4deae6:	47 64       	R7 += 0x8;		/* (  8) */
8d4deae8:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || [FP + 0x8] = R1 || NOP;
8d4deaec:	b9 b0 00 00 
8d4deaf0:	0f 30       	R1 = R7;
8d4deaf2:	02 30       	R0 = R2;
8d4deaf4:	22 30       	R4 = R2;
8d4deaf6:	00 de 03 8c 	CALL.A 0x8c03fb08;
8d4deafa:	08 fb 00 00 
8d4deafe:	00 0c       	CC = R0 == 0x0;
8d4deb00:	06 10       	IF !CC JUMP 0x0x8d4deb0c;
8d4deb02:	86 6c       	SP += 0x10;		/* ( 16) */
8d4deb04:	20 05       	(R7:4) = [SP++];
8d4deb06:	01 e8 00 00 	UNLINK;
8d4deb0a:	10 00       	RTS;
8d4deb0c:	78 60       	R0 = 0xf (X);		/*		R0=0x100(256) */
8d4deb0e:	4e 30       	R1 = SP;
8d4deb10:	03 61       	R3 = 0x20 (X);		/*		R3=0x12c(300) */
8d4deb12:	04 cc 36 4c 	R6 = R6 - R6 (NS) || [FP -0x4] = R0 || NOP;
8d4deb16:	f0 bb 00 00 
8d4deb1a:	7a 60       	R2 = 0xf (X);		/*		R2=0x111(273) */
8d4deb1c:	04 cc 0b 00 	R0 = R1 + R3 (NS) || [SP + 0x34] = R6 || NOP;
8d4deb20:	76 b3 00 00 
8d4deb24:	b6 e6 40 00 	B[SP + 0x40] = R6;
8d4deb28:	b6 e6 5c 00 	B[SP + 0x5c] = R6;
8d4deb2c:	b6 e6 24 00 	B[SP + 0x24] = R6;
8d4deb30:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [FP -0x24] = R6 || NOP;
8d4deb34:	76 bb 00 00 
8d4deb38:	e6 bb       	[FP -0x8] = R6;
8d4deb3a:	82 bb       	[FP -0x20] = R2;
8d4deb3c:	b2 b3       	[SP + 0x38] = R2;
8d4deb3e:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4deb42:	76 a3 00 00 
8d4deb46:	47 30       	R0 = FP;
8d4deb48:	20 67       	R0 += -0x1c;		/* (-28) */
8d4deb4a:	10 30       	R2 = R0;
8d4deb4c:	20 67       	R0 += -0x1c;		/* (-28) */
8d4deb4e:	08 30       	R1 = R0;
8d4deb50:	20 67       	R0 += -0x1c;		/* (-28) */
8d4deb52:	00 e3 87 27 	CALL 0x0x8d4e3a60;
8d4deb56:	b0 a3       	R0 = [SP + 0x38];
8d4deb58:	83 60       	R3 = 0x10 (X);		/*		R3=0x12c(300) */
8d4deb5a:	03 0a       	CC = R3 <= R0 (IU);
8d4deb5c:	63 18       	IF CC JUMP 0x0x8d4dec22;
8d4deb5e:	b6 e6 24 00 	B[SP + 0x24] = R6;
8d4deb62:	7a 60       	R2 = 0xf (X);		/*		R2=0x111(273) */
8d4deb64:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4deb68:	b8 00 03 00 
8d4deb6c:	4f 30       	R1 = FP;
8d4deb6e:	20 e1 64 01 	R0 = 0x164 (X);		/*		R0=0x164(356) */
8d4deb72:	04 cc 28 00 	R0 = R5 + R0 (NS) || [SP + 0x38] = R2 || NOP;
8d4deb76:	b2 b3 00 00 
8d4deb7a:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0x34] = R6 || NOP;
8d4deb7e:	76 b3 00 00 
8d4deb82:	f3 b0       	[SP + 0xc] = R3;
8d4deb84:	21 67       	R1 += -0x1c;		/* (-28) */
8d4deb86:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4deb8a:	70 e9 00 00 
8d4deb8e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4deb92:	b8 00 02 00 
8d4deb96:	4f 30       	R1 = FP;
8d4deb98:	23 e1 48 01 	R3 = 0x148 (X);		/*		R3=0x148(328) */
8d4deb9c:	04 cc 2b 00 	R0 = R5 + R3 (NS) || [SP + 0xc] = R2 || NOP;
8d4deba0:	f2 b0 00 00 
8d4deba4:	41 66       	R1 += -0x38;		/* (-56) */
8d4deba6:	02 60       	R2 = 0x0 (X);		/*		R2=0x111(273) */
8d4deba8:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4debac:	70 e9 00 00 
8d4debb0:	0c 30       	R1 = R4;
8d4debb2:	25 30       	R4 = R5;
8d4debb4:	a5 64       	R5 += 0x14;		/* ( 20) */
8d4debb6:	05 30       	R0 = R5;
8d4debb8:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4debbc:	76 a3 00 00 
8d4debc0:	82 ce 07 c4 	R2 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4debc4:	b9 a0 00 00 
8d4debc8:	04 30       	R0 = R4;
8d4debca:	ff e3 b9 fe 	CALL 0x0x8d4de93c;
8d4debce:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R1 = [FP -0x4] || R0 = [FP -0x18];
8d4debd2:	f1 b9 a0 b9 
8d4debd6:	82 60       	R2 = 0x10 (X);		/*		R2=0x111(273) */
8d4debd8:	0a 0a       	CC = R2 <= R1 (IU);
8d4debda:	21 18       	IF CC JUMP 0x0x8d4dec1c;
8d4debdc:	03 c8 00 18 	MNOP || R0 = [FP -0x20] || [FP -0x8] = R6;
8d4debe0:	80 b9 e6 bb 
8d4debe4:	82 60       	R2 = 0x10 (X);		/*		R2=0x111(273) */
8d4debe6:	79 60       	R1 = 0xf (X);		/*		R1=0xf0(240) */
8d4debe8:	02 0a       	CC = R2 <= R0 (IU);
8d4debea:	b6 e6 5c 00 	B[SP + 0x5c] = R6;
8d4debee:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP -0x4] = R1 || NOP;
8d4debf2:	f1 bb 00 00 
8d4debf6:	08 18       	IF CC JUMP 0x0x8d4dec06;
8d4debf8:	b6 e6 40 00 	B[SP + 0x40] = R6;
8d4debfc:	86 6c       	SP += 0x10;		/* ( 16) */
8d4debfe:	20 05       	(R7:4) = [SP++];
8d4dec00:	01 e8 00 00 	UNLINK;
8d4dec04:	10 00       	RTS;
8d4dec06:	30 b9       	R0 = [FP -0x34];
8d4dec08:	ff e3 ee 7b 	CALL 0x0x8d4ce3e4;
8d4dec0c:	b6 e6 40 00 	B[SP + 0x40] = R6;
8d4dec10:	86 6c       	SP += 0x10;		/* ( 16) */
8d4dec12:	07 30       	R0 = R7;
8d4dec14:	20 05       	(R7:4) = [SP++];
8d4dec16:	01 e8 00 00 	UNLINK;
8d4dec1a:	10 00       	RTS;
8d4dec1c:	ff e3 e4 7b 	CALL 0x0x8d4ce3e4;
8d4dec20:	de 2f       	JUMP.S 0x0x8d4debdc;
8d4dec22:	70 a2       	R0 = [SP + 0x24];
8d4dec24:	ff e3 e0 7b 	CALL 0x0x8d4ce3e4;
8d4dec28:	9b 2f       	JUMP.S 0x0x8d4deb5e;
8d4dec2a:	08 32       	P1 = R0;
8d4dec2c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dec30:	00 da 03 84 	R0=-2080152560;
8d4dec34:	10 64 00 00 
8d4dec38:	09 91       	R1 = [P1];
8d4dec3a:	41 4d       	R1 >>>= 0x8;
8d4dec3c:	82 c6 11 84 	R2 = R1 << 0x2;
8d4dec40:	4a 52       	R1 = R2 - R1;
8d4dec42:	b9 4d       	R1 >>>= 0x17;
8d4dec44:	01 0c       	CC = R1 == 0x0;
8d4dec46:	0e 18       	IF CC JUMP 0x0x8d4dec62;
8d4dec48:	09 0c       	CC = R1 == 0x1;
8d4dec4a:	0b 18       	IF CC JUMP 0x0x8d4dec60;
8d4dec4c:	01 e8 00 00 	UNLINK;
8d4dec50:	11 0c       	CC = R1 == 0x2;
8d4dec52:	80 64       	R0 += 0x10;		/* ( 16) */
8d4dec54:	01 da 03 84 	R1=-2080152560;
8d4dec58:	10 64 00 00 
8d4dec5c:	01 06       	IF !CC R0 = R1;
8d4dec5e:	10 00       	RTS;
8d4dec60:	40 64       	R0 += 0x8;		/* (  8) */
8d4dec62:	01 e8 00 00 	UNLINK;
8d4dec66:	10 00       	RTS;
8d4dec68:	00 00       	NOP;
8d4dec6a:	00 00       	NOP;
8d4dec6c:	00 e8 27 00 	LINK 0x9c;		/* (156) */
8d4dec70:	e3 05       	[--SP] = (R7:4, P5:3);
8d4dec72:	57 30       	R2 = FP;
8d4dec74:	86 6f       	SP += -0x10;		/* (-16) */
8d4dec76:	22 66       	R2 += -0x3c;		/* (-60) */
8d4dec78:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || [FP -0x70] = R2 || NOP;
8d4dec7c:	42 ba 00 00 
8d4dec80:	30 30       	R6 = R0;
8d4dec82:	01 60       	R1 = 0x0 (X);		/*		R1=0xf0(240) */
8d4dec84:	d4 61       	R4 = 0x3a (X);		/*		R4=0x0(  0) */
8d4dec86:	40 b8       	R0 = [FP -0x70];
8d4dec88:	00 de 05 8c 	CALL.A 0x8c053038;
8d4dec8c:	38 30 00 00 
8d4dec90:	07 30       	R0 = R7;
8d4dec92:	04 e3 4d 97 	CALL 0x0x8d571b2c;
8d4dec96:	a0 ba       	[FP -0x58] = R0;
8d4dec98:	ac b8       	P4 = [FP -0x58];
8d4dec9a:	29 e1 64 38 	P1 = 0x3864 (X);		/*		P1=0x3864(14436) */
8d4dec9e:	7a 43       	R2 = R7.B (Z);
8d4deca0:	d2 ba       	[FP -0x4c] = R2;
8d4deca2:	4c 5b       	P5 = P4 + P1;
8d4deca4:	6d 30       	R5 = P5;
8d4deca6:	28 90       	R0 = [P5++];
8d4deca8:	80 0c       	CC = R0 < 0x0;
8d4decaa:	03 14       	IF !CC JUMP 0x0x8d4decb0 (BP);
8d4decac:	00 e2 2e 0d 	JUMP.L 0x0x8d4e0708;
8d4decb0:	fc 67       	R4 += -0x1;		/* ( -1) */
8d4decb2:	04 0c       	CC = R4 == 0x0;
8d4decb4:	f9 17       	IF !CC JUMP 0x0x8d4deca6 (BP);
8d4decb6:	02 da 03 84 	R2=-2080152904;
8d4decba:	b8 62 00 00 
8d4decbe:	46 64       	R6 += 0x8;		/* (  8) */
8d4decc0:	42 64       	R2 += 0x8;		/* (  8) */
8d4decc2:	be b0       	[FP + 0x8] = R6;
8d4decc4:	72 ba       	[FP -0x64] = R2;
8d4decc6:	24 e1 84 01 	R4 = 0x184 (X);		/*		R4=0x184(388) */
8d4decca:	b8 a0       	R0 = [FP + 0x8];
8d4deccc:	71 b8       	R1 = [FP -0x64];
8d4decce:	00 de 05 8c 	CALL.A 0x8c053314;
8d4decd2:	14 33 00 00 
8d4decd6:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [P4 + 0x18] || NOP;
8d4decda:	a0 a1 00 00 
8d4decde:	06 e3 a1 1a 	CALL 0x0x8d5a2220;
8d4dece2:	56 30       	R2 = SP;
8d4dece4:	23 e1 80 00 	R3 = 0x80 (X);		/*		R3=0x80(128) */
8d4dece8:	9a 51       	R6 = R2 + R3;
8d4decea:	08 30       	R1 = R0;
8d4decec:	06 30       	R0 = R6;
8d4decee:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4decf2:	a8 19 00 00 
8d4decf6:	07 30       	R0 = R7;
8d4decf8:	0e 30       	R1 = R6;
8d4decfa:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4decfe:	10 1b 00 00 
8d4ded02:	06 30       	R0 = R6;
8d4ded04:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4ded08:	38 1a 00 00 
8d4ded0c:	02 da 03 84 	R2=-2080152904;
8d4ded10:	b8 62 00 00 
8d4ded14:	04 cc 14 02 	R1 = R2 + R4 (NS) || R0 = [FP + 0x8] || NOP;
8d4ded18:	b8 a0 00 00 
8d4ded1c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ded20:	14 33 00 00 
8d4ded24:	38 30       	R7 = R0;
8d4ded26:	06 30       	R0 = R6;
8d4ded28:	21 60       	R1 = 0x4 (X);		/*		R1=0xf0(240) */
8d4ded2a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4ded2e:	96 10 00 00 
8d4ded32:	07 30       	R0 = R7;
8d4ded34:	0e 30       	R1 = R6;
8d4ded36:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4ded3a:	10 1b 00 00 
8d4ded3e:	06 30       	R0 = R6;
8d4ded40:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4ded44:	38 1a 00 00 
8d4ded48:	04 da 03 84 	R4=-2080152904;
8d4ded4c:	b8 62 00 00 
8d4ded50:	22 e1 70 01 	R2 = 0x170 (X);		/*		R2=0x170(368) */
8d4ded54:	04 cc 22 02 	R1 = R4 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4ded58:	b8 a0 00 00 
8d4ded5c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ded60:	14 33 00 00 
8d4ded64:	23 e1 7c 01 	R3 = 0x17c (X);		/*		R3=0x17c(380) */
8d4ded68:	02 da 03 84 	R2=-2080152904;
8d4ded6c:	b8 62 00 00 
8d4ded70:	38 30       	R7 = R0;
8d4ded72:	5a 50       	R1 = R2 + R3;
8d4ded74:	06 30       	R0 = R6;
8d4ded76:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4ded7a:	a8 19 00 00 
8d4ded7e:	07 30       	R0 = R7;
8d4ded80:	0e 30       	R1 = R6;
8d4ded82:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4ded86:	10 1b 00 00 
8d4ded8a:	06 30       	R0 = R6;
8d4ded8c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4ded90:	38 1a 00 00 
8d4ded94:	04 cc 24 48 	R4 = R4 - R4 (NS) || R0 = [FP + 0x8] || NOP;
8d4ded98:	b8 a0 00 00 
8d4ded9c:	01 da 03 84 	R1=-2080152904;
8d4deda0:	b8 62 00 00 
8d4deda4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4deda8:	14 33 00 00 
8d4dedac:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x4c] || NOP;
8d4dedb0:	d0 b8 00 00 
8d4dedb4:	04 e3 9e 87 	CALL 0x0x8d56fcf0;
8d4dedb8:	08 30       	R1 = R0;
8d4dedba:	06 30       	R0 = R6;
8d4dedbc:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dedc0:	96 10 00 00 
8d4dedc4:	07 30       	R0 = R7;
8d4dedc6:	0e 30       	R1 = R6;
8d4dedc8:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dedcc:	10 1b 00 00 
8d4dedd0:	06 30       	R0 = R6;
8d4dedd2:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dedd6:	38 1a 00 00 
8d4dedda:	22 e1 48 01 	R2 = 0x148 (X);		/*		R2=0x148(328) */
8d4dedde:	03 da 03 84 	R3=-2080152904;
8d4dede2:	b8 62 00 00 
8d4dede6:	04 cc 1a 04 	R2 = R3 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4dedea:	b8 a0 00 00 
8d4dedee:	d2 ba       	[FP -0x4c] = R2;
8d4dedf0:	d1 b8       	R1 = [FP -0x4c];
8d4dedf2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dedf6:	14 33 00 00 
8d4dedfa:	38 30       	R7 = R0;
8d4dedfc:	06 30       	R0 = R6;
8d4dedfe:	39 60       	R1 = 0x7 (X);		/*		R1=0xf0(240) */
8d4dee00:	00 de 05 8c 	CALL.A 0x8c053038;
8d4dee04:	38 30 00 00 
8d4dee08:	07 30       	R0 = R7;
8d4dee0a:	0e 30       	R1 = R6;
8d4dee0c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dee10:	10 1b 00 00 
8d4dee14:	06 30       	R0 = R6;
8d4dee16:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dee1a:	38 1a 00 00 
8d4dee1e:	22 e1 8c 01 	R2 = 0x18c (X);		/*		R2=0x18c(396) */
8d4dee22:	03 da 03 84 	R3=-2080152904;
8d4dee26:	b8 62 00 00 
8d4dee2a:	93 50       	R2 = R3 + R2;
8d4dee2c:	82 ba       	[FP -0x60] = R2;
8d4dee2e:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dee32:	d1 b8 b8 a0 
8d4dee36:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dee3a:	14 33 00 00 
8d4dee3e:	81 b8       	R1 = [FP -0x60];
8d4dee40:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dee44:	14 33 00 00 
8d4dee48:	0c 30       	R1 = R4;
8d4dee4a:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4dee4e:	e4 30 00 00 
8d4dee52:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP + 0xc] = R0 || NOP;
8d4dee56:	f8 b0 00 00 
8d4dee5a:	7f 30       	R7 = FP;
8d4dee5c:	ff e3 95 f6 	CALL 0x0x8d4ddb86;
8d4dee60:	87 66       	R7 += -0x30;		/* (-48) */
8d4dee62:	08 30       	R1 = R0;
8d4dee64:	07 30       	R0 = R7;
8d4dee66:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dee6a:	96 10 00 00 
8d4dee6e:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4dee72:	f8 a0 00 00 
8d4dee76:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dee7a:	10 1b 00 00 
8d4dee7e:	07 30       	R0 = R7;
8d4dee80:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dee84:	38 1a 00 00 
8d4dee88:	0c 64       	R4 += 0x1;		/* (  1) */
8d4dee8a:	42 60       	R2 = 0x8 (X);		/*		R2=0x18c(396) */
8d4dee8c:	94 08       	CC = R4 < R2;
8d4dee8e:	25 64       	R5 += 0x4;		/* (  4) */
8d4dee90:	cf 1f       	IF CC JUMP 0x0x8d4dee2e (BP);
8d4dee92:	22 e1 34 02 	R2 = 0x234 (X);		/*		R2=0x234(564) */
8d4dee96:	07 da 03 84 	R7=-2080152904;
8d4dee9a:	b8 62 00 00 
8d4dee9e:	04 cc 3a 04 	R2 = R7 + R2 (NS) || R7 = [FP -0x58] || NOP;
8d4deea2:	a7 b8 00 00 
8d4deea6:	20 e1 24 02 	R0 = 0x224 (X);		/*		R0=0x224(548) */
8d4deeaa:	04 da 03 84 	R4=-2080152904;
8d4deeae:	b8 62 00 00 
8d4deeb2:	23 e1 84 38 	R3 = 0x3884 (X);		/*		R3=0x3884(14468) */
8d4deeb6:	04 cc 20 08 	R4 = R4 + R0 (NS) || [FP + 0xc] = R2 || NOP;
8d4deeba:	fa b0 00 00 
8d4deebe:	df 51       	R7 = R7 + R3;
8d4deec0:	20 e1 3c 02 	R0 = 0x23c (X);		/*		R0=0x23c(572) */
8d4deec4:	03 da 03 84 	R3=-2080152904;
8d4deec8:	b8 62 00 00 
8d4deecc:	03 50       	R0 = R3 + R0;
8d4deece:	21 e1 30 02 	R1 = 0x230 (X);		/*		R1=0x230(560) */
8d4deed2:	05 da 03 84 	R5=-2080152904;
8d4deed6:	b8 62 00 00 
8d4deeda:	04 cc 29 0a 	R5 = R5 + R1 (NS) || [FP -0x50] = R0 || NOP;
8d4deede:	c0 ba 00 00 
8d4deee2:	00 da 03 84 	R0=-2080152904;
8d4deee6:	b8 62 00 00 
8d4deeea:	21 e1 44 02 	R1 = 0x244 (X);		/*		R1=0x244(580) */
8d4deeee:	04 cc 01 02 	R1 = R0 + R1 (NS) || R0 = [FP + 0x8] || NOP;
8d4deef2:	b8 a0 00 00 
8d4deef6:	b1 ba       	[FP -0x54] = R1;
8d4deef8:	22 e1 4c 02 	R2 = 0x24c (X);		/*		R2=0x24c(588) */
8d4deefc:	01 da 03 84 	R1=-2080152904;
8d4def00:	b8 62 00 00 
8d4def04:	91 50       	R2 = R1 + R2;
8d4def06:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [FP -0x68] = R2 || NOP;
8d4def0a:	62 ba 00 00 
8d4def0e:	23 e1 54 02 	R3 = 0x254 (X);		/*		R3=0x254(596) */
8d4def12:	02 da 03 84 	R2=-2080152904;
8d4def16:	b8 62 00 00 
8d4def1a:	da 50       	R3 = R2 + R3;
8d4def1c:	93 ba       	[FP -0x5c] = R3;
8d4def1e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4def22:	14 33 00 00 
8d4def26:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x6c] = R0 || NOP;
8d4def2a:	50 ba 00 00 
8d4def2e:	39 60       	R1 = 0x7 (X);		/*		R1=0x244(580) */
8d4def30:	00 de 05 8c 	CALL.A 0x8c053038;
8d4def34:	38 30 00 00 
8d4def38:	0e 30       	R1 = R6;
8d4def3a:	50 b8       	R0 = [FP -0x6c];
8d4def3c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4def40:	10 1b 00 00 
8d4def44:	06 30       	R0 = R6;
8d4def46:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4def4a:	38 1a 00 00 
8d4def4e:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4def52:	b8 a0 00 00 
8d4def56:	00 de 05 8c 	CALL.A 0x8c053314;
8d4def5a:	14 33 00 00 
8d4def5e:	0d 30       	R1 = R5;
8d4def60:	00 de 05 8c 	CALL.A 0x8c053314;
8d4def64:	14 33 00 00 
8d4def68:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x6c] = R0 || NOP;
8d4def6c:	50 ba 00 00 
8d4def70:	39 60       	R1 = 0x7 (X);		/*		R1=0x244(580) */
8d4def72:	00 de 05 8c 	CALL.A 0x8c053038;
8d4def76:	38 30 00 00 
8d4def7a:	0e 30       	R1 = R6;
8d4def7c:	50 b8       	R0 = [FP -0x6c];
8d4def7e:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4def82:	10 1b 00 00 
8d4def86:	06 30       	R0 = R6;
8d4def88:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4def8c:	38 1a 00 00 
8d4def90:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4def94:	b8 a0 00 00 
8d4def98:	00 de 05 8c 	CALL.A 0x8c053314;
8d4def9c:	14 33 00 00 
8d4defa0:	0d 30       	R1 = R5;
8d4defa2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4defa6:	14 33 00 00 
8d4defaa:	f9 a0       	R1 = [FP + 0xc];
8d4defac:	00 de 05 8c 	CALL.A 0x8c053314;
8d4defb0:	14 33 00 00 
8d4defb4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP -0x6c] = R0 || NOP;
8d4defb8:	50 ba 00 00 
8d4defbc:	ff e3 e5 f5 	CALL 0x0x8d4ddb86;
8d4defc0:	08 30       	R1 = R0;
8d4defc2:	06 30       	R0 = R6;
8d4defc4:	00 de 05 8c 	CALL.A 0x8c051096;
8d4defc8:	96 10 00 00 
8d4defcc:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP -0x6c] || NOP;
8d4defd0:	50 b8 00 00 
8d4defd4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4defd8:	10 1b 00 00 
8d4defdc:	06 30       	R0 = R6;
8d4defde:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4defe2:	38 1a 00 00 
8d4defe6:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4defea:	b8 a0 00 00 
8d4defee:	00 de 05 8c 	CALL.A 0x8c053314;
8d4deff2:	14 33 00 00 
8d4deff6:	0d 30       	R1 = R5;
8d4deff8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4deffc:	14 33 00 00 
8d4df000:	c1 b8       	R1 = [FP -0x50];
8d4df002:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df006:	14 33 00 00 
8d4df00a:	22 e1 88 38 	R2 = 0x3888 (X);		/*		R2=0x3888(14472) */
8d4df00e:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP -0x6c] = R0;
8d4df012:	a3 b8 50 ba 
8d4df016:	13 50       	R0 = R3 + R2;
8d4df018:	ff e3 b7 f5 	CALL 0x0x8d4ddb86;
8d4df01c:	08 30       	R1 = R0;
8d4df01e:	06 30       	R0 = R6;
8d4df020:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df024:	96 10 00 00 
8d4df028:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP -0x6c] || NOP;
8d4df02c:	50 b8 00 00 
8d4df030:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df034:	10 1b 00 00 
8d4df038:	06 30       	R0 = R6;
8d4df03a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df03e:	38 1a 00 00 
8d4df042:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df046:	b8 a0 00 00 
8d4df04a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df04e:	14 33 00 00 
8d4df052:	0d 30       	R1 = R5;
8d4df054:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df058:	14 33 00 00 
8d4df05c:	b1 b8       	R1 = [FP -0x54];
8d4df05e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df062:	14 33 00 00 
8d4df066:	22 e1 8c 38 	R2 = 0x388c (X);		/*		R2=0x388c(14476) */
8d4df06a:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP -0x6c] = R0;
8d4df06e:	a3 b8 50 ba 
8d4df072:	13 50       	R0 = R3 + R2;
8d4df074:	ff e3 89 f5 	CALL 0x0x8d4ddb86;
8d4df078:	08 30       	R1 = R0;
8d4df07a:	06 30       	R0 = R6;
8d4df07c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df080:	96 10 00 00 
8d4df084:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP -0x6c] || NOP;
8d4df088:	50 b8 00 00 
8d4df08c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df090:	10 1b 00 00 
8d4df094:	06 30       	R0 = R6;
8d4df096:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df09a:	38 1a 00 00 
8d4df09e:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df0a2:	b8 a0 00 00 
8d4df0a6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df0aa:	14 33 00 00 
8d4df0ae:	0d 30       	R1 = R5;
8d4df0b0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df0b4:	14 33 00 00 
8d4df0b8:	61 b8       	R1 = [FP -0x68];
8d4df0ba:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df0be:	14 33 00 00 
8d4df0c2:	22 e1 90 38 	R2 = 0x3890 (X);		/*		R2=0x3890(14480) */
8d4df0c6:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df0ca:	a3 b8 00 00 
8d4df0ce:	13 50       	R0 = R3 + R2;
8d4df0d0:	ff e3 5b f5 	CALL 0x0x8d4ddb86;
8d4df0d4:	08 30       	R1 = R0;
8d4df0d6:	06 30       	R0 = R6;
8d4df0d8:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df0dc:	96 10 00 00 
8d4df0e0:	05 30       	R0 = R5;
8d4df0e2:	0e 30       	R1 = R6;
8d4df0e4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df0e8:	10 1b 00 00 
8d4df0ec:	06 30       	R0 = R6;
8d4df0ee:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df0f2:	38 1a 00 00 
8d4df0f6:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df0fa:	b8 a0 00 00 
8d4df0fe:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df102:	14 33 00 00 
8d4df106:	91 b8       	R1 = [FP -0x5c];
8d4df108:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df10c:	14 33 00 00 
8d4df110:	28 30       	R5 = R0;
8d4df112:	06 30       	R0 = R6;
8d4df114:	39 60       	R1 = 0x7 (X);		/*		R1=0x244(580) */
8d4df116:	00 de 05 8c 	CALL.A 0x8c053038;
8d4df11a:	38 30 00 00 
8d4df11e:	05 30       	R0 = R5;
8d4df120:	0e 30       	R1 = R6;
8d4df122:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df126:	10 1b 00 00 
8d4df12a:	06 30       	R0 = R6;
8d4df12c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df130:	38 1a 00 00 
8d4df134:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df138:	b8 a0 00 00 
8d4df13c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df140:	14 33 00 00 
8d4df144:	91 b8       	R1 = [FP -0x5c];
8d4df146:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df14a:	14 33 00 00 
8d4df14e:	f9 a0       	R1 = [FP + 0xc];
8d4df150:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df154:	14 33 00 00 
8d4df158:	22 e1 e4 38 	R2 = 0x38e4 (X);		/*		R2=0x38e4(14564) */
8d4df15c:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df160:	a3 b8 00 00 
8d4df164:	13 50       	R0 = R3 + R2;
8d4df166:	ff e3 10 f5 	CALL 0x0x8d4ddb86;
8d4df16a:	08 30       	R1 = R0;
8d4df16c:	06 30       	R0 = R6;
8d4df16e:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df172:	96 10 00 00 
8d4df176:	05 30       	R0 = R5;
8d4df178:	0e 30       	R1 = R6;
8d4df17a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df17e:	10 1b 00 00 
8d4df182:	06 30       	R0 = R6;
8d4df184:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df188:	38 1a 00 00 
8d4df18c:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df190:	b8 a0 00 00 
8d4df194:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df198:	14 33 00 00 
8d4df19c:	91 b8       	R1 = [FP -0x5c];
8d4df19e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df1a2:	14 33 00 00 
8d4df1a6:	c1 b8       	R1 = [FP -0x50];
8d4df1a8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df1ac:	14 33 00 00 
8d4df1b0:	22 e1 e8 38 	R2 = 0x38e8 (X);		/*		R2=0x38e8(14568) */
8d4df1b4:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df1b8:	a3 b8 00 00 
8d4df1bc:	13 50       	R0 = R3 + R2;
8d4df1be:	ff e3 e4 f4 	CALL 0x0x8d4ddb86;
8d4df1c2:	08 30       	R1 = R0;
8d4df1c4:	06 30       	R0 = R6;
8d4df1c6:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df1ca:	96 10 00 00 
8d4df1ce:	05 30       	R0 = R5;
8d4df1d0:	0e 30       	R1 = R6;
8d4df1d2:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df1d6:	10 1b 00 00 
8d4df1da:	06 30       	R0 = R6;
8d4df1dc:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df1e0:	38 1a 00 00 
8d4df1e4:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df1e8:	b8 a0 00 00 
8d4df1ec:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df1f0:	14 33 00 00 
8d4df1f4:	91 b8       	R1 = [FP -0x5c];
8d4df1f6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df1fa:	14 33 00 00 
8d4df1fe:	b1 b8       	R1 = [FP -0x54];
8d4df200:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df204:	14 33 00 00 
8d4df208:	22 e1 ec 38 	R2 = 0x38ec (X);		/*		R2=0x38ec(14572) */
8d4df20c:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df210:	a3 b8 00 00 
8d4df214:	13 50       	R0 = R3 + R2;
8d4df216:	ff e3 b8 f4 	CALL 0x0x8d4ddb86;
8d4df21a:	08 30       	R1 = R0;
8d4df21c:	06 30       	R0 = R6;
8d4df21e:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df222:	96 10 00 00 
8d4df226:	05 30       	R0 = R5;
8d4df228:	0e 30       	R1 = R6;
8d4df22a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df22e:	10 1b 00 00 
8d4df232:	06 30       	R0 = R6;
8d4df234:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df238:	38 1a 00 00 
8d4df23c:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || R4 = [FP -0x58];
8d4df240:	b8 a0 a4 b8 
8d4df244:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df248:	14 33 00 00 
8d4df24c:	91 b8       	R1 = [FP -0x5c];
8d4df24e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df252:	14 33 00 00 
8d4df256:	61 b8       	R1 = [FP -0x68];
8d4df258:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df25c:	14 33 00 00 
8d4df260:	22 e1 f0 38 	R2 = 0x38f0 (X);		/*		R2=0x38f0(14576) */
8d4df264:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df268:	a3 b8 00 00 
8d4df26c:	13 50       	R0 = R3 + R2;
8d4df26e:	ff e3 8c f4 	CALL 0x0x8d4ddb86;
8d4df272:	08 30       	R1 = R0;
8d4df274:	06 30       	R0 = R6;
8d4df276:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df27a:	96 10 00 00 
8d4df27e:	05 30       	R0 = R5;
8d4df280:	0e 30       	R1 = R6;
8d4df282:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df286:	10 1b 00 00 
8d4df28a:	06 30       	R0 = R6;
8d4df28c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df290:	38 1a 00 00 
8d4df294:	a0 a1       	R0 = [P4 + 0x18];
8d4df296:	e9 60       	R1 = 0x1d (X);		/*		R1=0x244(580) */
8d4df298:	08 08       	CC = R0 == R1;
8d4df29a:	03 1c       	IF CC JUMP 0x0x8d4df2a0 (BP);
8d4df29c:	00 e2 8a 09 	JUMP.L 0x0x8d4e05b0;
8d4df2a0:	20 e1 6c 02 	R0 = 0x26c (X);		/*		R0=0x26c(620) */
8d4df2a4:	02 da 03 84 	R2=-2080152904;
8d4df2a8:	b8 62 00 00 
8d4df2ac:	21 e1 70 02 	R1 = 0x270 (X);		/*		R1=0x270(624) */
8d4df2b0:	03 da 03 84 	R3=-2080152904;
8d4df2b4:	b8 62 00 00 
8d4df2b8:	02 50       	R0 = R2 + R0;
8d4df2ba:	04 cc 19 02 	R1 = R3 + R1 (NS) || [FP -0x5c] = R0 || NOP;
8d4df2be:	90 ba 00 00 
8d4df2c2:	f9 b0       	[FP + 0xc] = R1;
8d4df2c4:	05 60       	R5 = 0x0 (X);		/*		R5=0x0(  0) */
8d4df2c6:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df2ca:	d1 b8 b8 a0 
8d4df2ce:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df2d2:	14 33 00 00 
8d4df2d6:	91 b8       	R1 = [FP -0x5c];
8d4df2d8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df2dc:	14 33 00 00 
8d4df2e0:	0d 30       	R1 = R5;
8d4df2e2:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df2e6:	e4 30 00 00 
8d4df2ea:	f9 a0       	R1 = [FP + 0xc];
8d4df2ec:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df2f0:	14 33 00 00 
8d4df2f4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP -0x50] = R0 || NOP;
8d4df2f8:	c0 ba 00 00 
8d4df2fc:	67 30       	R4 = FP;
8d4df2fe:	ff e3 9a f4 	CALL 0x0x8d4ddc32;
8d4df302:	84 66       	R4 += -0x30;		/* (-48) */
8d4df304:	08 30       	R1 = R0;
8d4df306:	04 30       	R0 = R4;
8d4df308:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df30c:	96 10 00 00 
8d4df310:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x50] || NOP;
8d4df314:	c0 b8 00 00 
8d4df318:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df31c:	10 1b 00 00 
8d4df320:	04 30       	R0 = R4;
8d4df322:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df326:	38 1a 00 00 
8d4df32a:	0d 64       	R5 += 0x1;		/* (  1) */
8d4df32c:	22 60       	R2 = 0x4 (X);		/*		R2=0x38f0(14576) */
8d4df32e:	95 08       	CC = R5 < R2;
8d4df330:	27 64       	R7 += 0x4;		/* (  4) */
8d4df332:	ca 1f       	IF CC JUMP 0x0x8d4df2c6 (BP);
8d4df334:	20 e1 a4 38 	R0 = 0x38a4 (X);		/*		R0=0x38a4(14500) */
8d4df338:	a1 b8       	R1 = [FP -0x58];
8d4df33a:	01 50       	R0 = R1 + R0;
8d4df33c:	c0 ba       	[FP -0x50] = R0;
8d4df33e:	27 60       	R7 = 0x4 (X);		/*		R7=0x0(  0) */
8d4df340:	25 60       	R5 = 0x4 (X);		/*		R5=0x0(  0) */
8d4df342:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df346:	d1 b8 b8 a0 
8d4df34a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df34e:	14 33 00 00 
8d4df352:	91 b8       	R1 = [FP -0x5c];
8d4df354:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df358:	14 33 00 00 
8d4df35c:	0d 30       	R1 = R5;
8d4df35e:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df362:	e4 30 00 00 
8d4df366:	f9 a0       	R1 = [FP + 0xc];
8d4df368:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df36c:	14 33 00 00 
8d4df370:	03 c8 00 18 	MNOP || [FP -0x54] = R0 || R0 = [FP -0x50];
8d4df374:	b0 ba c0 b8 
8d4df378:	67 30       	R4 = FP;
8d4df37a:	ff e3 5c f4 	CALL 0x0x8d4ddc32;
8d4df37e:	84 66       	R4 += -0x30;		/* (-48) */
8d4df380:	08 30       	R1 = R0;
8d4df382:	04 30       	R0 = R4;
8d4df384:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df388:	96 10 00 00 
8d4df38c:	0d 64       	R5 += 0x1;		/* (  1) */
8d4df38e:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x54] || [FP -0x68] = R5;
8d4df392:	b0 b8 65 ba 
8d4df396:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df39a:	10 1b 00 00 
8d4df39e:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R5 = [FP -0x50] || NOP;
8d4df3a2:	c5 b8 00 00 
8d4df3a6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df3aa:	38 1a 00 00 
8d4df3ae:	ff 67       	R7 += -0x1;		/* ( -1) */
8d4df3b0:	25 64       	R5 += 0x4;		/* (  4) */
8d4df3b2:	07 0c       	CC = R7 == 0x0;
8d4df3b4:	03 c8 00 18 	MNOP || [FP -0x50] = R5 || R5 = [FP -0x68];
8d4df3b8:	c5 ba 65 b8 
8d4df3bc:	c3 17       	IF !CC JUMP 0x0x8d4df342 (BP);
8d4df3be:	20 e1 94 38 	R0 = 0x3894 (X);		/*		R0=0x3894(14484) */
8d4df3c2:	a1 b8       	R1 = [FP -0x58];
8d4df3c4:	c1 51       	R7 = R1 + R0;
8d4df3c6:	05 60       	R5 = 0x0 (X);		/*		R5=0x0(  0) */
8d4df3c8:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df3cc:	d1 b8 b8 a0 
8d4df3d0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df3d4:	14 33 00 00 
8d4df3d8:	91 b8       	R1 = [FP -0x5c];
8d4df3da:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df3de:	14 33 00 00 
8d4df3e2:	0d 30       	R1 = R5;
8d4df3e4:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df3e8:	e4 30 00 00 
8d4df3ec:	91 b8       	R1 = [FP -0x5c];
8d4df3ee:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df3f2:	14 33 00 00 
8d4df3f6:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP + 0xc] = R0 || NOP;
8d4df3fa:	f8 b0 00 00 
8d4df3fe:	67 30       	R4 = FP;
8d4df400:	ff e3 d8 f3 	CALL 0x0x8d4ddbb0;
8d4df404:	84 66       	R4 += -0x30;		/* (-48) */
8d4df406:	08 30       	R1 = R0;
8d4df408:	04 30       	R0 = R4;
8d4df40a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df40e:	96 10 00 00 
8d4df412:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4df416:	f8 a0 00 00 
8d4df41a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df41e:	10 1b 00 00 
8d4df422:	04 30       	R0 = R4;
8d4df424:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df428:	38 1a 00 00 
8d4df42c:	0d 64       	R5 += 0x1;		/* (  1) */
8d4df42e:	22 60       	R2 = 0x4 (X);		/*		R2=0x38f0(14576) */
8d4df430:	95 08       	CC = R5 < R2;
8d4df432:	27 64       	R7 += 0x4;		/* (  4) */
8d4df434:	ca 1f       	IF CC JUMP 0x0x8d4df3c8 (BP);
8d4df436:	20 e1 b4 38 	R0 = 0x38b4 (X);		/*		R0=0x38b4(14516) */
8d4df43a:	a1 b8       	R1 = [FP -0x58];
8d4df43c:	01 50       	R0 = R1 + R0;
8d4df43e:	f8 b0       	[FP + 0xc] = R0;
8d4df440:	27 60       	R7 = 0x4 (X);		/*		R7=0x0(  0) */
8d4df442:	25 60       	R5 = 0x4 (X);		/*		R5=0x0(  0) */
8d4df444:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df448:	d1 b8 b8 a0 
8d4df44c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df450:	14 33 00 00 
8d4df454:	91 b8       	R1 = [FP -0x5c];
8d4df456:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df45a:	14 33 00 00 
8d4df45e:	0d 30       	R1 = R5;
8d4df460:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df464:	e4 30 00 00 
8d4df468:	91 b8       	R1 = [FP -0x5c];
8d4df46a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df46e:	14 33 00 00 
8d4df472:	03 c8 00 18 	MNOP || [FP -0x54] = R0 || R0 = [FP + 0xc];
8d4df476:	b0 ba f8 a0 
8d4df47a:	67 30       	R4 = FP;
8d4df47c:	ff e3 9a f3 	CALL 0x0x8d4ddbb0;
8d4df480:	84 66       	R4 += -0x30;		/* (-48) */
8d4df482:	08 30       	R1 = R0;
8d4df484:	04 30       	R0 = R4;
8d4df486:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df48a:	96 10 00 00 
8d4df48e:	0d 64       	R5 += 0x1;		/* (  1) */
8d4df490:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x54] || [FP -0x50] = R5;
8d4df494:	b0 b8 c5 ba 
8d4df498:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df49c:	10 1b 00 00 
8d4df4a0:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R5 = [FP + 0xc] || NOP;
8d4df4a4:	fd a0 00 00 
8d4df4a8:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df4ac:	38 1a 00 00 
8d4df4b0:	ff 67       	R7 += -0x1;		/* ( -1) */
8d4df4b2:	25 64       	R5 += 0x4;		/* (  4) */
8d4df4b4:	07 0c       	CC = R7 == 0x0;
8d4df4b6:	03 c8 00 18 	MNOP || [FP + 0xc] = R5 || R5 = [FP -0x50];
8d4df4ba:	fd b0 c5 b8 
8d4df4be:	c3 17       	IF !CC JUMP 0x0x8d4df444 (BP);
8d4df4c0:	22 e1 5c 02 	R2 = 0x25c (X);		/*		R2=0x25c(604) */
8d4df4c4:	07 da 03 84 	R7=-2080152904;
8d4df4c8:	b8 62 00 00 
8d4df4cc:	04 cc 3a 04 	R2 = R7 + R2 (NS) || R7 = [FP -0x70] || NOP;
8d4df4d0:	47 b8 00 00 
8d4df4d4:	03 c8 00 18 	MNOP || [FP + 0xc] = R2 || R2 = [P4 + 0x28];
8d4df4d8:	fa b0 a2 a2 
8d4df4dc:	23 e1 60 02 	R3 = 0x260 (X);		/*		R3=0x260(608) */
8d4df4e0:	04 da 03 84 	R4=-2080152904;
8d4df4e4:	b8 62 00 00 
8d4df4e8:	01 da 03 84 	R1=-2080152904;
8d4df4ec:	b8 62 00 00 
8d4df4f0:	04 cc 23 06 	R3 = R4 + R3 (NS) || [SP + 0xc] = R7 || R4 = [FP -0x58];
8d4df4f4:	f7 b0 a4 b8 
8d4df4f8:	41 66       	R1 += -0x38;		/* (-56) */
8d4df4fa:	08 60       	R0 = 0x1 (X);		/*		R0=0x38b4(14516) */
8d4df4fc:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [FP -0x50] = R3 || NOP;
8d4df500:	c3 ba 00 00 
8d4df504:	ff e3 84 dc 	CALL 0x0x8d4dae0c;
8d4df508:	03 c8 00 18 	MNOP || R0 = [FP + 0x8] || R1 = [FP + 0xc];
8d4df50c:	b8 a0 f9 a0 
8d4df510:	25 e1 a4 38 	R5 = 0x38a4 (X);		/*		R5=0x38a4(14500) */
8d4df514:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df518:	14 33 00 00 
8d4df51c:	6c 51       	R5 = R4 + R5;
8d4df51e:	20 30       	R4 = R0;
8d4df520:	06 30       	R0 = R6;
8d4df522:	39 60       	R1 = 0x7 (X);		/*		R1=0x270(624) */
8d4df524:	00 de 05 8c 	CALL.A 0x8c053038;
8d4df528:	38 30 00 00 
8d4df52c:	04 30       	R0 = R4;
8d4df52e:	0e 30       	R1 = R6;
8d4df530:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df534:	10 1b 00 00 
8d4df538:	06 30       	R0 = R6;
8d4df53a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df53e:	38 1a 00 00 
8d4df542:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df546:	f9 a0 b8 a0 
8d4df54a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df54e:	14 33 00 00 
8d4df552:	71 b8       	R1 = [FP -0x64];
8d4df554:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df558:	14 33 00 00 
8d4df55c:	82 ce 00 c8 	R4 = ROT R0 BY 0x0 || R1 = [FP -0x64] || R0 = [FP -0x70];
8d4df560:	71 b8 40 b8 
8d4df564:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df568:	14 33 00 00 
8d4df56c:	08 30       	R1 = R0;
8d4df56e:	04 30       	R0 = R4;
8d4df570:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df574:	10 1b 00 00 
8d4df578:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df57c:	f9 a0 b8 a0 
8d4df580:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df584:	14 33 00 00 
8d4df588:	c1 b8       	R1 = [FP -0x50];
8d4df58a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df58e:	14 33 00 00 
8d4df592:	20 30       	R4 = R0;
8d4df594:	a1 e4 2c 00 	R1 = B[P4 + 0x2c] (Z);
8d4df598:	06 30       	R0 = R6;
8d4df59a:	00 de 05 8c 	CALL.A 0x8c051066;
8d4df59e:	66 10 00 00 
8d4df5a2:	04 30       	R0 = R4;
8d4df5a4:	0e 30       	R1 = R6;
8d4df5a6:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df5aa:	10 1b 00 00 
8d4df5ae:	06 30       	R0 = R6;
8d4df5b0:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df5b4:	38 1a 00 00 
8d4df5b8:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df5bc:	f9 a0 b8 a0 
8d4df5c0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df5c4:	14 33 00 00 
8d4df5c8:	81 b8       	R1 = [FP -0x60];
8d4df5ca:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df5ce:	14 33 00 00 
8d4df5d2:	0f 30       	R1 = R7;
8d4df5d4:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df5d8:	e4 30 00 00 
8d4df5dc:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP -0x54] = R0 || NOP;
8d4df5e0:	b0 ba 00 00 
8d4df5e4:	67 30       	R4 = FP;
8d4df5e6:	ff e3 d0 f2 	CALL 0x0x8d4ddb86;
8d4df5ea:	84 66       	R4 += -0x30;		/* (-48) */
8d4df5ec:	08 30       	R1 = R0;
8d4df5ee:	04 30       	R0 = R4;
8d4df5f0:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df5f4:	96 10 00 00 
8d4df5f8:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x54] || NOP;
8d4df5fc:	b0 b8 00 00 
8d4df600:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df604:	10 1b 00 00 
8d4df608:	04 30       	R0 = R4;
8d4df60a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df60e:	38 1a 00 00 
8d4df612:	0f 64       	R7 += 0x1;		/* (  1) */
8d4df614:	42 60       	R2 = 0x8 (X);		/*		R2=0x25c(604) */
8d4df616:	97 08       	CC = R7 < R2;
8d4df618:	25 64       	R5 += 0x4;		/* (  4) */
8d4df61a:	cf 1f       	IF CC JUMP 0x0x8d4df5b8 (BP);
8d4df61c:	23 e1 68 02 	R3 = 0x268 (X);		/*		R3=0x268(616) */
8d4df620:	04 da 03 84 	R4=-2080152904;
8d4df624:	b8 62 00 00 
8d4df628:	04 cc 23 06 	R3 = R4 + R3 (NS) || R4 = [FP -0x70] || R2 = [P4 + 0x20];
8d4df62c:	44 b8 22 a2 
8d4df630:	03 c8 00 18 	MNOP || [FP + 0xc] = R3 || R7 = [FP -0x58];
8d4df634:	fb b0 a7 b8 
8d4df638:	01 da 03 84 	R1=-2080152904;
8d4df63c:	b8 62 00 00 
8d4df640:	f4 b0       	[SP + 0xc] = R4;
8d4df642:	41 67       	R1 += -0x18;		/* (-24) */
8d4df644:	08 60       	R0 = 0x1 (X);		/*		R0=0x38b4(14516) */
8d4df646:	ff e3 e3 db 	CALL 0x0x8d4dae0c;
8d4df64a:	03 c8 00 18 	MNOP || R0 = [FP + 0x8] || R1 = [FP + 0xc];
8d4df64e:	b8 a0 f9 a0 
8d4df652:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df656:	14 33 00 00 
8d4df65a:	20 30       	R4 = R0;
8d4df65c:	06 30       	R0 = R6;
8d4df65e:	39 60       	R1 = 0x7 (X);		/*		R1=0x270(624) */
8d4df660:	00 de 05 8c 	CALL.A 0x8c053038;
8d4df664:	38 30 00 00 
8d4df668:	04 30       	R0 = R4;
8d4df66a:	0e 30       	R1 = R6;
8d4df66c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df670:	10 1b 00 00 
8d4df674:	06 30       	R0 = R6;
8d4df676:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df67a:	38 1a 00 00 
8d4df67e:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df682:	f9 a0 b8 a0 
8d4df686:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df68a:	14 33 00 00 
8d4df68e:	71 b8       	R1 = [FP -0x64];
8d4df690:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df694:	14 33 00 00 
8d4df698:	82 ce 00 c8 	R4 = ROT R0 BY 0x0 || R1 = [FP -0x64] || R0 = [FP -0x70];
8d4df69c:	71 b8 40 b8 
8d4df6a0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df6a4:	14 33 00 00 
8d4df6a8:	08 30       	R1 = R0;
8d4df6aa:	04 30       	R0 = R4;
8d4df6ac:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df6b0:	10 1b 00 00 
8d4df6b4:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df6b8:	f9 a0 b8 a0 
8d4df6bc:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df6c0:	14 33 00 00 
8d4df6c4:	c1 b8       	R1 = [FP -0x50];
8d4df6c6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df6ca:	14 33 00 00 
8d4df6ce:	20 30       	R4 = R0;
8d4df6d0:	a1 e4 24 00 	R1 = B[P4 + 0x24] (Z);
8d4df6d4:	06 30       	R0 = R6;
8d4df6d6:	00 de 05 8c 	CALL.A 0x8c051066;
8d4df6da:	66 10 00 00 
8d4df6de:	04 30       	R0 = R4;
8d4df6e0:	0e 30       	R1 = R6;
8d4df6e2:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df6e6:	10 1b 00 00 
8d4df6ea:	25 e1 c4 38 	R5 = 0x38c4 (X);		/*		R5=0x38c4(14532) */
8d4df6ee:	06 30       	R0 = R6;
8d4df6f0:	6f 51       	R5 = R7 + R5;
8d4df6f2:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df6f6:	38 1a 00 00 
8d4df6fa:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4df6fc:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df700:	f9 a0 b8 a0 
8d4df704:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df708:	14 33 00 00 
8d4df70c:	81 b8       	R1 = [FP -0x60];
8d4df70e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df712:	14 33 00 00 
8d4df716:	0f 30       	R1 = R7;
8d4df718:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df71c:	e4 30 00 00 
8d4df720:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP -0x64] = R0 || NOP;
8d4df724:	70 ba 00 00 
8d4df728:	67 30       	R4 = FP;
8d4df72a:	ff e3 2e f2 	CALL 0x0x8d4ddb86;
8d4df72e:	84 66       	R4 += -0x30;		/* (-48) */
8d4df730:	08 30       	R1 = R0;
8d4df732:	04 30       	R0 = R4;
8d4df734:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df738:	96 10 00 00 
8d4df73c:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x64] || NOP;
8d4df740:	70 b8 00 00 
8d4df744:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df748:	10 1b 00 00 
8d4df74c:	04 30       	R0 = R4;
8d4df74e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df752:	38 1a 00 00 
8d4df756:	0f 64       	R7 += 0x1;		/* (  1) */
8d4df758:	42 60       	R2 = 0x8 (X);		/*		R2=0x25c(604) */
8d4df75a:	97 08       	CC = R7 < R2;
8d4df75c:	25 64       	R5 += 0x4;		/* (  4) */
8d4df75e:	cf 1f       	IF CC JUMP 0x0x8d4df6fc (BP);
8d4df760:	07 da 03 84 	R7=-2080152904;
8d4df764:	b8 62 00 00 
8d4df768:	21 e1 e4 01 	R1 = 0x1e4 (X);		/*		R1=0x1e4(484) */
8d4df76c:	20 e1 d8 01 	R0 = 0x1d8 (X);		/*		R0=0x1d8(472) */
8d4df770:	04 da 03 84 	R4=-2080152904;
8d4df774:	b8 62 00 00 
8d4df778:	23 e1 f8 01 	R3 = 0x1f8 (X);		/*		R3=0x1f8(504) */
8d4df77c:	4f 50       	R1 = R7 + R1;
8d4df77e:	04 cc 20 08 	R4 = R4 + R0 (NS) || [FP + 0xc] = R1 || NOP;
8d4df782:	f9 b0 00 00 
8d4df786:	df 51       	R7 = R7 + R3;
8d4df788:	20 e1 00 02 	R0 = 0x200 (X);		/*		R0=0x200(512) */
8d4df78c:	03 da 03 84 	R3=-2080152904;
8d4df790:	b8 62 00 00 
8d4df794:	03 50       	R0 = R3 + R0;
8d4df796:	c0 ba       	[FP -0x50] = R0;
8d4df798:	00 da 03 84 	R0=-2080152904;
8d4df79c:	b8 62 00 00 
8d4df7a0:	21 e1 0c 02 	R1 = 0x20c (X);		/*		R1=0x20c(524) */
8d4df7a4:	48 50       	R1 = R0 + R1;
8d4df7a6:	22 e1 f0 01 	R2 = 0x1f0 (X);		/*		R2=0x1f0(496) */
8d4df7aa:	05 da 03 84 	R5=-2080152904;
8d4df7ae:	b8 62 00 00 
8d4df7b2:	04 cc 2a 0a 	R5 = R5 + R2 (NS) || [FP -0x54] = R1 || NOP;
8d4df7b6:	b1 ba 00 00 
8d4df7ba:	01 da 03 84 	R1=-2080152904;
8d4df7be:	b8 62 00 00 
8d4df7c2:	22 e1 18 02 	R2 = 0x218 (X);		/*		R2=0x218(536) */
8d4df7c6:	04 cc 0a 04 	R2 = R1 + R2 (NS) || R1 = [FP -0x4c] || NOP;
8d4df7ca:	d1 b8 00 00 
8d4df7ce:	23 e1 24 01 	R3 = 0x124 (X);		/*		R3=0x124(292) */
8d4df7d2:	04 cc 03 06 	R3 = R0 + R3 (NS) || [FP -0x68] = R2 || NOP;
8d4df7d6:	62 ba 00 00 
8d4df7da:	02 da 03 84 	R2=-2080152904;
8d4df7de:	b8 62 00 00 
8d4df7e2:	20 e1 78 00 	R0 = 0x78 (X);		/*		R0=0x78(120) */
8d4df7e6:	04 cc 10 04 	R2 = R2 + R0 (NS) || R0 = [FP + 0x8] || [FP -0x64] = R3;
8d4df7ea:	b8 a0 73 ba 
8d4df7ee:	82 ba       	[FP -0x60] = R2;
8d4df7f0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df7f4:	14 33 00 00 
8d4df7f8:	0c 30       	R1 = R4;
8d4df7fa:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df7fe:	14 33 00 00 
8d4df802:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x5c] = R0 || NOP;
8d4df806:	90 ba 00 00 
8d4df80a:	39 60       	R1 = 0x7 (X);		/*		R1=0x20c(524) */
8d4df80c:	00 de 05 8c 	CALL.A 0x8c053038;
8d4df810:	38 30 00 00 
8d4df814:	0e 30       	R1 = R6;
8d4df816:	90 b8       	R0 = [FP -0x5c];
8d4df818:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df81c:	10 1b 00 00 
8d4df820:	06 30       	R0 = R6;
8d4df822:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df826:	38 1a 00 00 
8d4df82a:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df82e:	d1 b8 b8 a0 
8d4df832:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df836:	14 33 00 00 
8d4df83a:	0c 30       	R1 = R4;
8d4df83c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df840:	14 33 00 00 
8d4df844:	f9 a0       	R1 = [FP + 0xc];
8d4df846:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df84a:	14 33 00 00 
8d4df84e:	0d 30       	R1 = R5;
8d4df850:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df854:	14 33 00 00 
8d4df858:	22 e1 0c 39 	R2 = 0x390c (X);		/*		R2=0x390c(14604) */
8d4df85c:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP -0x5c] = R0;
8d4df860:	a3 b8 90 ba 
8d4df864:	13 50       	R0 = R3 + R2;
8d4df866:	ff e3 90 f1 	CALL 0x0x8d4ddb86;
8d4df86a:	08 30       	R1 = R0;
8d4df86c:	06 30       	R0 = R6;
8d4df86e:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df872:	96 10 00 00 
8d4df876:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP -0x5c] || NOP;
8d4df87a:	90 b8 00 00 
8d4df87e:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df882:	10 1b 00 00 
8d4df886:	06 30       	R0 = R6;
8d4df888:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df88c:	38 1a 00 00 
8d4df890:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df894:	d1 b8 b8 a0 
8d4df898:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df89c:	14 33 00 00 
8d4df8a0:	0c 30       	R1 = R4;
8d4df8a2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df8a6:	14 33 00 00 
8d4df8aa:	f9 a0       	R1 = [FP + 0xc];
8d4df8ac:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df8b0:	14 33 00 00 
8d4df8b4:	0f 30       	R1 = R7;
8d4df8b6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df8ba:	14 33 00 00 
8d4df8be:	22 e1 10 39 	R2 = 0x3910 (X);		/*		R2=0x3910(14608) */
8d4df8c2:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4df8c6:	a3 b8 f8 b0 
8d4df8ca:	13 50       	R0 = R3 + R2;
8d4df8cc:	ff e3 5d f1 	CALL 0x0x8d4ddb86;
8d4df8d0:	08 30       	R1 = R0;
8d4df8d2:	06 30       	R0 = R6;
8d4df8d4:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df8d8:	96 10 00 00 
8d4df8dc:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4df8e0:	f8 a0 00 00 
8d4df8e4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df8e8:	10 1b 00 00 
8d4df8ec:	06 30       	R0 = R6;
8d4df8ee:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df8f2:	38 1a 00 00 
8d4df8f6:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df8fa:	d1 b8 b8 a0 
8d4df8fe:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df902:	14 33 00 00 
8d4df906:	0c 30       	R1 = R4;
8d4df908:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df90c:	14 33 00 00 
8d4df910:	c1 b8       	R1 = [FP -0x50];
8d4df912:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df916:	14 33 00 00 
8d4df91a:	0d 30       	R1 = R5;
8d4df91c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df920:	14 33 00 00 
8d4df924:	22 e1 14 39 	R2 = 0x3914 (X);		/*		R2=0x3914(14612) */
8d4df928:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4df92c:	a3 b8 f8 b0 
8d4df930:	13 50       	R0 = R3 + R2;
8d4df932:	ff e3 2a f1 	CALL 0x0x8d4ddb86;
8d4df936:	08 30       	R1 = R0;
8d4df938:	06 30       	R0 = R6;
8d4df93a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df93e:	96 10 00 00 
8d4df942:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4df946:	f8 a0 00 00 
8d4df94a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df94e:	10 1b 00 00 
8d4df952:	06 30       	R0 = R6;
8d4df954:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df958:	38 1a 00 00 
8d4df95c:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df960:	d1 b8 b8 a0 
8d4df964:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df968:	14 33 00 00 
8d4df96c:	0c 30       	R1 = R4;
8d4df96e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df972:	14 33 00 00 
8d4df976:	c1 b8       	R1 = [FP -0x50];
8d4df978:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df97c:	14 33 00 00 
8d4df980:	0f 30       	R1 = R7;
8d4df982:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df986:	14 33 00 00 
8d4df98a:	22 e1 18 39 	R2 = 0x3918 (X);		/*		R2=0x3918(14616) */
8d4df98e:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4df992:	a3 b8 f8 b0 
8d4df996:	13 50       	R0 = R3 + R2;
8d4df998:	ff e3 f7 f0 	CALL 0x0x8d4ddb86;
8d4df99c:	08 30       	R1 = R0;
8d4df99e:	06 30       	R0 = R6;
8d4df9a0:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df9a4:	96 10 00 00 
8d4df9a8:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4df9ac:	f8 a0 00 00 
8d4df9b0:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df9b4:	10 1b 00 00 
8d4df9b8:	06 30       	R0 = R6;
8d4df9ba:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df9be:	38 1a 00 00 
8d4df9c2:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df9c6:	d1 b8 b8 a0 
8d4df9ca:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df9ce:	14 33 00 00 
8d4df9d2:	0c 30       	R1 = R4;
8d4df9d4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df9d8:	14 33 00 00 
8d4df9dc:	b1 b8       	R1 = [FP -0x54];
8d4df9de:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df9e2:	14 33 00 00 
8d4df9e6:	0d 30       	R1 = R5;
8d4df9e8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df9ec:	14 33 00 00 
8d4df9f0:	22 e1 1c 39 	R2 = 0x391c (X);		/*		R2=0x391c(14620) */
8d4df9f4:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4df9f8:	a3 b8 f8 b0 
8d4df9fc:	13 50       	R0 = R3 + R2;
8d4df9fe:	ff e3 c4 f0 	CALL 0x0x8d4ddb86;
8d4dfa02:	08 30       	R1 = R0;
8d4dfa04:	06 30       	R0 = R6;
8d4dfa06:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfa0a:	96 10 00 00 
8d4dfa0e:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4dfa12:	f8 a0 00 00 
8d4dfa16:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfa1a:	10 1b 00 00 
8d4dfa1e:	06 30       	R0 = R6;
8d4dfa20:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfa24:	38 1a 00 00 
8d4dfa28:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfa2c:	d1 b8 b8 a0 
8d4dfa30:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa34:	14 33 00 00 
8d4dfa38:	0c 30       	R1 = R4;
8d4dfa3a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa3e:	14 33 00 00 
8d4dfa42:	b1 b8       	R1 = [FP -0x54];
8d4dfa44:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa48:	14 33 00 00 
8d4dfa4c:	0f 30       	R1 = R7;
8d4dfa4e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa52:	14 33 00 00 
8d4dfa56:	22 e1 20 39 	R2 = 0x3920 (X);		/*		R2=0x3920(14624) */
8d4dfa5a:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4dfa5e:	a3 b8 f8 b0 
8d4dfa62:	13 50       	R0 = R3 + R2;
8d4dfa64:	ff e3 91 f0 	CALL 0x0x8d4ddb86;
8d4dfa68:	08 30       	R1 = R0;
8d4dfa6a:	06 30       	R0 = R6;
8d4dfa6c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfa70:	96 10 00 00 
8d4dfa74:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4dfa78:	f8 a0 00 00 
8d4dfa7c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfa80:	10 1b 00 00 
8d4dfa84:	06 30       	R0 = R6;
8d4dfa86:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfa8a:	38 1a 00 00 
8d4dfa8e:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfa92:	d1 b8 b8 a0 
8d4dfa96:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa9a:	14 33 00 00 
8d4dfa9e:	0c 30       	R1 = R4;
8d4dfaa0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfaa4:	14 33 00 00 
8d4dfaa8:	61 b8       	R1 = [FP -0x68];
8d4dfaaa:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfaae:	14 33 00 00 
8d4dfab2:	0d 30       	R1 = R5;
8d4dfab4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfab8:	14 33 00 00 
8d4dfabc:	22 e1 40 39 	R2 = 0x3940 (X);		/*		R2=0x3940(14656) */
8d4dfac0:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfac4:	a3 b8 00 00 
8d4dfac8:	13 50       	R0 = R3 + R2;
8d4dfaca:	ff e3 5e f0 	CALL 0x0x8d4ddb86;
8d4dface:	08 30       	R1 = R0;
8d4dfad0:	06 30       	R0 = R6;
8d4dfad2:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfad6:	96 10 00 00 
8d4dfada:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || R5 = [FP -0x58] || NOP;
8d4dfade:	a5 b8 00 00 
8d4dfae2:	0e 30       	R1 = R6;
8d4dfae4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfae8:	10 1b 00 00 
8d4dfaec:	06 30       	R0 = R6;
8d4dfaee:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfaf2:	38 1a 00 00 
8d4dfaf6:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfafa:	d1 b8 b8 a0 
8d4dfafe:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb02:	14 33 00 00 
8d4dfb06:	0c 30       	R1 = R4;
8d4dfb08:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb0c:	14 33 00 00 
8d4dfb10:	61 b8       	R1 = [FP -0x68];
8d4dfb12:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb16:	14 33 00 00 
8d4dfb1a:	0f 30       	R1 = R7;
8d4dfb1c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb20:	14 33 00 00 
8d4dfb24:	22 e1 44 39 	R2 = 0x3944 (X);		/*		R2=0x3944(14660) */
8d4dfb28:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfb2c:	a3 b8 00 00 
8d4dfb30:	13 50       	R0 = R3 + R2;
8d4dfb32:	ff e3 2a f0 	CALL 0x0x8d4ddb86;
8d4dfb36:	08 30       	R1 = R0;
8d4dfb38:	06 30       	R0 = R6;
8d4dfb3a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfb3e:	96 10 00 00 
8d4dfb42:	07 30       	R0 = R7;
8d4dfb44:	0e 30       	R1 = R6;
8d4dfb46:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfb4a:	10 1b 00 00 
8d4dfb4e:	06 30       	R0 = R6;
8d4dfb50:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfb54:	38 1a 00 00 
8d4dfb58:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfb5c:	d1 b8 b8 a0 
8d4dfb60:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb64:	14 33 00 00 
8d4dfb68:	01 da 03 84 	R1=-2080151952;
8d4dfb6c:	70 66 00 00 
8d4dfb70:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb74:	14 33 00 00 
8d4dfb78:	22 e1 24 39 	R2 = 0x3924 (X);		/*		R2=0x3924(14628) */
8d4dfb7c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfb80:	a3 b8 00 00 
8d4dfb84:	13 50       	R0 = R3 + R2;
8d4dfb86:	ff e3 00 f0 	CALL 0x0x8d4ddb86;
8d4dfb8a:	08 30       	R1 = R0;
8d4dfb8c:	06 30       	R0 = R6;
8d4dfb8e:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfb92:	96 10 00 00 
8d4dfb96:	07 30       	R0 = R7;
8d4dfb98:	0e 30       	R1 = R6;
8d4dfb9a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfb9e:	10 1b 00 00 
8d4dfba2:	06 30       	R0 = R6;
8d4dfba4:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfba8:	38 1a 00 00 
8d4dfbac:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfbb0:	d1 b8 b8 a0 
8d4dfbb4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfbb8:	14 33 00 00 
8d4dfbbc:	01 da 03 84 	R1=-2080151928;
8d4dfbc0:	88 66 00 00 
8d4dfbc4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfbc8:	14 33 00 00 
8d4dfbcc:	22 e1 28 39 	R2 = 0x3928 (X);		/*		R2=0x3928(14632) */
8d4dfbd0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfbd4:	a3 b8 00 00 
8d4dfbd8:	13 50       	R0 = R3 + R2;
8d4dfbda:	ff e3 d6 ef 	CALL 0x0x8d4ddb86;
8d4dfbde:	08 30       	R1 = R0;
8d4dfbe0:	06 30       	R0 = R6;
8d4dfbe2:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfbe6:	96 10 00 00 
8d4dfbea:	07 30       	R0 = R7;
8d4dfbec:	0e 30       	R1 = R6;
8d4dfbee:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfbf2:	10 1b 00 00 
8d4dfbf6:	06 30       	R0 = R6;
8d4dfbf8:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfbfc:	38 1a 00 00 
8d4dfc00:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfc04:	d1 b8 b8 a0 
8d4dfc08:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfc0c:	14 33 00 00 
8d4dfc10:	07 da 03 84 	R7=-2080152904;
8d4dfc14:	b8 62 00 00 
8d4dfc18:	22 e1 b0 01 	R2 = 0x1b0 (X);		/*		R2=0x1b0(432) */
8d4dfc1c:	57 50       	R1 = R7 + R2;
8d4dfc1e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfc22:	14 33 00 00 
8d4dfc26:	23 e1 2c 39 	R3 = 0x392c (X);		/*		R3=0x392c(14636) */
8d4dfc2a:	38 30       	R7 = R0;
8d4dfc2c:	1d 50       	R0 = R5 + R3;
8d4dfc2e:	ff e3 ac ef 	CALL 0x0x8d4ddb86;
8d4dfc32:	08 30       	R1 = R0;
8d4dfc34:	06 30       	R0 = R6;
8d4dfc36:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfc3a:	96 10 00 00 
8d4dfc3e:	07 30       	R0 = R7;
8d4dfc40:	0e 30       	R1 = R6;
8d4dfc42:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfc46:	10 1b 00 00 
8d4dfc4a:	06 30       	R0 = R6;
8d4dfc4c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfc50:	38 1a 00 00 
8d4dfc54:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfc58:	d1 b8 b8 a0 
8d4dfc5c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfc60:	14 33 00 00 
8d4dfc64:	07 da 03 84 	R7=-2080152904;
8d4dfc68:	b8 62 00 00 
8d4dfc6c:	22 e1 a8 01 	R2 = 0x1a8 (X);		/*		R2=0x1a8(424) */
8d4dfc70:	57 50       	R1 = R7 + R2;
8d4dfc72:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfc76:	14 33 00 00 
8d4dfc7a:	23 e1 30 39 	R3 = 0x3930 (X);		/*		R3=0x3930(14640) */
8d4dfc7e:	38 30       	R7 = R0;
8d4dfc80:	1d 50       	R0 = R5 + R3;
8d4dfc82:	ff e3 82 ef 	CALL 0x0x8d4ddb86;
8d4dfc86:	08 30       	R1 = R0;
8d4dfc88:	06 30       	R0 = R6;
8d4dfc8a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfc8e:	96 10 00 00 
8d4dfc92:	07 30       	R0 = R7;
8d4dfc94:	0e 30       	R1 = R6;
8d4dfc96:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfc9a:	10 1b 00 00 
8d4dfc9e:	06 30       	R0 = R6;
8d4dfca0:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfca4:	38 1a 00 00 
8d4dfca8:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfcac:	d1 b8 b8 a0 
8d4dfcb0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfcb4:	14 33 00 00 
8d4dfcb8:	71 b8       	R1 = [FP -0x64];
8d4dfcba:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfcbe:	14 33 00 00 
8d4dfcc2:	22 e1 34 39 	R2 = 0x3934 (X);		/*		R2=0x3934(14644) */
8d4dfcc6:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfcca:	a3 b8 00 00 
8d4dfcce:	13 50       	R0 = R3 + R2;
8d4dfcd0:	ff e3 63 ef 	CALL 0x0x8d4ddb96;
8d4dfcd4:	08 30       	R1 = R0;
8d4dfcd6:	06 30       	R0 = R6;
8d4dfcd8:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfcdc:	96 10 00 00 
8d4dfce0:	07 30       	R0 = R7;
8d4dfce2:	0e 30       	R1 = R6;
8d4dfce4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfce8:	10 1b 00 00 
8d4dfcec:	06 30       	R0 = R6;
8d4dfcee:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfcf2:	38 1a 00 00 
8d4dfcf6:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfcfa:	d1 b8 b8 a0 
8d4dfcfe:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfd02:	14 33 00 00 
8d4dfd06:	07 da 03 84 	R7=-2080152904;
8d4dfd0a:	b8 62 00 00 
8d4dfd0e:	22 e1 c0 01 	R2 = 0x1c0 (X);		/*		R2=0x1c0(448) */
8d4dfd12:	57 50       	R1 = R7 + R2;
8d4dfd14:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfd18:	14 33 00 00 
8d4dfd1c:	23 e1 38 39 	R3 = 0x3938 (X);		/*		R3=0x3938(14648) */
8d4dfd20:	38 30       	R7 = R0;
8d4dfd22:	1d 50       	R0 = R5 + R3;
8d4dfd24:	ff e3 31 ef 	CALL 0x0x8d4ddb86;
8d4dfd28:	08 30       	R1 = R0;
8d4dfd2a:	06 30       	R0 = R6;
8d4dfd2c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfd30:	96 10 00 00 
8d4dfd34:	07 30       	R0 = R7;
8d4dfd36:	0e 30       	R1 = R6;
8d4dfd38:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfd3c:	10 1b 00 00 
8d4dfd40:	06 30       	R0 = R6;
8d4dfd42:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfd46:	38 1a 00 00 
8d4dfd4a:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfd4e:	d1 b8 b8 a0 
8d4dfd52:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfd56:	14 33 00 00 
8d4dfd5a:	07 da 03 84 	R7=-2080152904;
8d4dfd5e:	b8 62 00 00 
8d4dfd62:	22 e1 cc 01 	R2 = 0x1cc (X);		/*		R2=0x1cc(460) */
8d4dfd66:	57 50       	R1 = R7 + R2;
8d4dfd68:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfd6c:	14 33 00 00 
8d4dfd70:	23 e1 3c 39 	R3 = 0x393c (X);		/*		R3=0x393c(14652) */
8d4dfd74:	38 30       	R7 = R0;
8d4dfd76:	1d 50       	R0 = R5 + R3;
8d4dfd78:	ff e3 07 ef 	CALL 0x0x8d4ddb86;
8d4dfd7c:	08 30       	R1 = R0;
8d4dfd7e:	06 30       	R0 = R6;
8d4dfd80:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfd84:	96 10 00 00 
8d4dfd88:	07 30       	R0 = R7;
8d4dfd8a:	0e 30       	R1 = R6;
8d4dfd8c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfd90:	10 1b 00 00 
8d4dfd94:	06 30       	R0 = R6;
8d4dfd96:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfd9a:	38 1a 00 00 
8d4dfd9e:	03 c8 00 18 	MNOP || R0 = [FP + 0x8] || R1 = [FP -0x60];
8d4dfda2:	b8 a0 81 b8 
8d4dfda6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfdaa:	14 33 00 00 
8d4dfdae:	38 30       	R7 = R0;
8d4dfdb0:	06 30       	R0 = R6;
8d4dfdb2:	31 60       	R1 = 0x6 (X);		/*		R1=0x20c(524) */
8d4dfdb4:	00 de 05 8c 	CALL.A 0x8c053038;
8d4dfdb8:	38 30 00 00 
8d4dfdbc:	07 30       	R0 = R7;
8d4dfdbe:	0e 30       	R1 = R6;
8d4dfdc0:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfdc4:	10 1b 00 00 
8d4dfdc8:	06 30       	R0 = R6;
8d4dfdca:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfdce:	38 1a 00 00 
8d4dfdd2:	a0 a1       	R0 = [P4 + 0x18];
8d4dfdd4:	18 0c       	CC = R0 == 0x3;
8d4dfdd6:	03 1c       	IF CC JUMP 0x0x8d4dfddc (BP);
8d4dfdd8:	e2 23       	JUMP.S 0x0x8d4e059c;
8d4dfdda:	00 00       	NOP;
8d4dfddc:	20 e1 01 07 	R0 = 0x701 (X);		/*		R0=0x701(1793) */
8d4dfde0:	22 e1 10 01 	R2 = 0x110 (X);		/*		R2=0x110(272) */
8d4dfde4:	07 da 03 84 	R7=-2080152904;
8d4dfde8:	b8 62 00 00 
8d4dfdec:	97 50       	R2 = R7 + R2;
8d4dfdee:	70 e6 38 00 	W[SP + 0x70] = R0;
8d4dfdf2:	06 da 03 84 	R6=-2080152904;
8d4dfdf6:	b8 62 00 00 
8d4dfdfa:	23 e1 80 00 	R3 = 0x80 (X);		/*		R3=0x80(128) */
8d4dfdfe:	05 da 03 84 	R5=-2080152904;
8d4dfe02:	b8 62 00 00 
8d4dfe06:	20 e1 94 00 	R0 = 0x94 (X);		/*		R0=0x94(148) */
8d4dfe0a:	04 cc 33 06 	R3 = R6 + R3 (NS) || [FP + 0xc] = R2 || NOP;
8d4dfe0e:	fa b0 00 00 
8d4dfe12:	04 cc 28 00 	R0 = R5 + R0 (NS) || [FP -0x50] = R3 || NOP;
8d4dfe16:	c3 ba 00 00 
8d4dfe1a:	22 e1 30 01 	R2 = 0x130 (X);		/*		R2=0x130(304) */
8d4dfe1e:	21 e1 01 06 	R1 = 0x601 (X);		/*		R1=0x601(1537) */
8d4dfe22:	04 cc 32 04 	R2 = R6 + R2 (NS) || [FP -0x54] = R0 || NOP;
8d4dfe26:	b0 ba 00 00 
8d4dfe2a:	23 e1 34 01 	R3 = 0x134 (X);		/*		R3=0x134(308) */
8d4dfe2e:	00 da 03 84 	R0=-2080152904;
8d4dfe32:	b8 62 00 00 
8d4dfe36:	71 e6 39 00 	W[SP + 0x72] = R1;
8d4dfe3a:	04 da 03 84 	R4=-2080152904;
8d4dfe3e:	b8 62 00 00 
8d4dfe42:	21 e1 18 01 	R1 = 0x118 (X);		/*		R1=0x118(280) */
8d4dfe46:	04 cc 03 00 	R0 = R0 + R3 (NS) || [FP -0x5c] = R2 || NOP;
8d4dfe4a:	92 ba 00 00 
8d4dfe4e:	26 e1 f8 00 	R6 = 0xf8 (X);		/*		R6=0xf8(248) */
8d4dfe52:	02 da 03 84 	R2=-2080152904;
8d4dfe56:	b8 62 00 00 
8d4dfe5a:	04 cc 21 02 	R1 = R4 + R1 (NS) || [FP -0x6c] = R0 || NOP;
8d4dfe5e:	50 ba 00 00 
8d4dfe62:	04 cc 16 04 	R2 = R2 + R6 (NS) || [FP -0x68] = R1 || NOP;
8d4dfe66:	61 ba 00 00 
8d4dfe6a:	27 e1 3c 01 	R7 = 0x13c (X);		/*		R7=0x13c(316) */
8d4dfe6e:	25 e1 04 01 	R5 = 0x104 (X);		/*		R5=0x104(260) */
8d4dfe72:	00 da 03 84 	R0=-2080152904;
8d4dfe76:	b8 62 00 00 
8d4dfe7a:	7c 50       	R1 = R4 + R7;
8d4dfe7c:	32 e6 12 00 	[SP + 0x48] = R2;
8d4dfe80:	04 cc 05 00 	R0 = R0 + R5 (NS) || [SP + 0x3c] = R1 || NOP;
8d4dfe84:	f1 b3 00 00 
8d4dfe88:	23 e1 b8 00 	R3 = 0xb8 (X);		/*		R3=0xb8(184) */
8d4dfe8c:	27 e1 c8 00 	R7 = 0xc8 (X);		/*		R7=0xc8(200) */
8d4dfe90:	02 da 03 84 	R2=-2080152904;
8d4dfe94:	b8 62 00 00 
8d4dfe98:	5c 50       	R1 = R4 + R3;
8d4dfe9a:	04 cc 17 04 	R2 = R2 + R7 (NS) || [FP -0x7c] = R1 || NOP;
8d4dfe9e:	11 ba 00 00 
8d4dfea2:	30 e6 11 00 	[SP + 0x44] = R0;
8d4dfea6:	26 e1 d8 00 	R6 = 0xd8 (X);		/*		R6=0xd8(216) */
8d4dfeaa:	25 e1 8c 00 	R5 = 0x8c (X);		/*		R5=0x8c(140) */
8d4dfeae:	00 da 03 84 	R0=-2080152904;
8d4dfeb2:	b8 62 00 00 
8d4dfeb6:	32 e6 10 00 	[SP + 0x40] = R2;
8d4dfeba:	6c 50       	R1 = R4 + R5;
8d4dfebc:	04 cc 06 00 	R0 = R0 + R6 (NS) || [FP -0x78] = R1 || NOP;
8d4dfec0:	21 ba 00 00 
8d4dfec4:	23 e1 9c 00 	R3 = 0x9c (X);		/*		R3=0x9c(156) */
8d4dfec8:	02 da 03 84 	R2=-2080152904;
8d4dfecc:	b8 62 00 00 
8d4dfed0:	04 cc 13 04 	R2 = R2 + R3 (NS) || [SP + 0x2c] = R0 || NOP;
8d4dfed4:	f0 b2 00 00 
8d4dfed8:	27 e1 ac 00 	R7 = 0xac (X);		/*		R7=0xac(172) */
8d4dfedc:	24 e1 f0 00 	R4 = 0xf0 (X);		/*		R4=0xf0(240) */
8d4dfee0:	26 e1 e8 00 	R6 = 0xe8 (X);		/*		R6=0xe8(232) */
8d4dfee4:	01 da 03 84 	R1=-2080152904;
8d4dfee8:	b8 62 00 00 
8d4dfeec:	03 da 03 84 	R3=-2080152904;
8d4dfef0:	b8 62 00 00 
8d4dfef4:	00 da 03 84 	R0=-2080152904;
8d4dfef8:	b8 62 00 00 
8d4dfefc:	04 cc 0e 02 	R1 = R1 + R6 (NS) || [SP + 0x30] = R2 || NOP;
8d4dff00:	32 b3 00 00 
8d4dff04:	04 cc 07 00 	R0 = R0 + R7 (NS) || [SP + 0x34] = R1 || NOP;
8d4dff08:	71 b3 00 00 
8d4dff0c:	04 cc 1c 04 	R2 = R3 + R4 (NS) || [SP + 0x38] = R0 || NOP;
8d4dff10:	b0 b3 00 00 
8d4dff14:	29 e1 6c 39 	P1 = 0x396c (X);		/*		P1=0x396c(14700) */
8d4dff18:	32 ba       	[FP -0x74] = R2;
8d4dff1a:	cc 5a       	P3 = P4 + P1;
8d4dff1c:	2d e1 80 00 	P5 = 0x80 (X);		/*		P5=0x80(128) */
8d4dff20:	c5 60       	R5 = 0x18 (X);		/*		R5=0x8c(140) */
8d4dff22:	4b 32       	P1 = P3;
8d4dff24:	04 cc 09 42 	R1 = R1 - R1 (NS) || R0 = B[P1++] (Z) || NOP;
8d4dff28:	08 98 00 00 
8d4dff2c:	00 0c       	CC = R0 == 0x0;
8d4dff2e:	fb 17       	IF !CC JUMP 0x0x8d4dff24 (BP);
8d4dff30:	19 44       	P1 -= P3;
8d4dff32:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d4dff34:	41 0c       	CC = P1 == 0x0;
8d4dff36:	74 10       	IF !CC JUMP 0x0x8d4e001e;
8d4dff38:	fd 67       	R5 += -0x1;		/* ( -1) */
8d4dff3a:	05 0c       	CC = R5 == 0x0;
8d4dff3c:	eb 5a       	P3 = P3 + P5;
8d4dff3e:	f2 17       	IF !CC JUMP 0x0x8d4dff22 (BP);
8d4dff40:	29 e1 94 53 	P1 = 0x5394 (X);		/*		P1=0x5394(21396) */
8d4dff44:	4c 5b       	P5 = P4 + P1;
8d4dff46:	4d 32       	P1 = P5;
8d4dff48:	c0 e0 04 30 	LSETUP_IMM(bottom=0x8d4dff50) LC0 count_fields=0x0/0xc;
8d4dff4c:	08 90       	R0 = [P1++];
8d4dff4e:	00 0c       	CC = R0 == 0x0;
8d4dff50:	65 10       	IF !CC JUMP 0x0x8d4e001a;
8d4dff52:	00 60       	R0 = 0x0 (X);		/*		R0=0x94(148) */
8d4dff54:	00 0c       	CC = R0 == 0x0;
8d4dff56:	58 18       	IF CC JUMP 0x0x8d4e0006;
8d4dff58:	22 e1 50 01 	R2 = 0x150 (X);		/*		R2=0x150(336) */
8d4dff5c:	03 da 03 84 	R3=-2080152904;
8d4dff60:	b8 62 00 00 
8d4dff64:	04 cc 1a 0c 	R6 = R3 + R2 (NS) || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dff68:	d1 b8 b8 a0 
8d4dff6c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dff70:	14 33 00 00 
8d4dff74:	0e 30       	R1 = R6;
8d4dff76:	7f 30       	R7 = FP;
8d4dff78:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dff7c:	14 33 00 00 
8d4dff80:	87 66       	R7 += -0x30;		/* (-48) */
8d4dff82:	28 30       	R5 = R0;
8d4dff84:	07 30       	R0 = R7;
8d4dff86:	31 60       	R1 = 0x6 (X);		/*		R1=0x118(280) */
8d4dff88:	00 de 05 8c 	CALL.A 0x8c053038;
8d4dff8c:	38 30 00 00 
8d4dff90:	05 30       	R0 = R5;
8d4dff92:	0f 30       	R1 = R7;
8d4dff94:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dff98:	10 1b 00 00 
8d4dff9c:	07 30       	R0 = R7;
8d4dff9e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dffa2:	38 1a 00 00 
8d4dffa6:	04 60       	R4 = 0x0 (X);		/*		R4=0xf0(240) */
8d4dffa8:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dffac:	d1 b8 b8 a0 
8d4dffb0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dffb4:	14 33 00 00 
8d4dffb8:	0e 30       	R1 = R6;
8d4dffba:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dffbe:	14 33 00 00 
8d4dffc2:	0c 30       	R1 = R4;
8d4dffc4:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4dffc8:	e4 30 00 00 
8d4dffcc:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R0 = [P5++] || NOP;
8d4dffd0:	28 90 00 00 
8d4dffd4:	7f 30       	R7 = FP;
8d4dffd6:	06 e3 33 48 	CALL 0x0x8d5a903c;
8d4dffda:	e7 66       	R7 += -0x24;		/* (-36) */
8d4dffdc:	08 30       	R1 = R0;
8d4dffde:	07 30       	R0 = R7;
8d4dffe0:	00 de 05 8c 	CALL.A 0x8c0518f4;
8d4dffe4:	f4 18 00 00 
8d4dffe8:	05 30       	R0 = R5;
8d4dffea:	0f 30       	R1 = R7;
8d4dffec:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfff0:	10 1b 00 00 
8d4dfff4:	07 30       	R0 = R7;
8d4dfff6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfffa:	38 1a 00 00 
8d4dfffe:	0c 64       	R4 += 0x1;		/* (  1) */
8d4e0000:	60 60       	R0 = 0xc (X);		/*		R0=0x94(148) */
8d4e0002:	84 08       	CC = R4 < R0;
8d4e0004:	d2 1f       	IF CC JUMP 0x0x8d4dffa8 (BP);
8d4e0006:	40 b8       	R0 = [FP -0x70];
8d4e0008:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e000c:	38 1a 00 00 
8d4e0010:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e0012:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e0014:	01 e8 00 00 	UNLINK;
8d4e0018:	10 00       	RTS;
8d4e001a:	08 60       	R0 = 0x1 (X);		/*		R0=0x94(148) */
8d4e001c:	9c 2f       	JUMP.S 0x0x8d4dff54;
8d4e001e:	7f 30       	R7 = FP;
8d4e0020:	e7 66       	R7 += -0x24;		/* (-36) */
8d4e0022:	07 30       	R0 = R7;
8d4e0024:	00 de 05 8c 	CALL.A 0x8c053038;
8d4e0028:	38 30 00 00 
8d4e002c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0xc] || NOP;
8d4e0030:	f9 a0 00 00 
8d4e0034:	67 30       	R4 = FP;
8d4e0036:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e003a:	14 33 00 00 
8d4e003e:	84 66       	R4 += -0x30;		/* (-48) */
8d4e0040:	30 30       	R6 = R0;
8d4e0042:	4b 30       	R1 = P3;
8d4e0044:	04 30       	R0 = R4;
8d4e0046:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4e004a:	a8 19 00 00 
8d4e004e:	06 30       	R0 = R6;
8d4e0050:	0c 30       	R1 = R4;
8d4e0052:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0056:	10 1b 00 00 
8d4e005a:	04 30       	R0 = R4;
8d4e005c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0060:	38 1a 00 00 
8d4e0064:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x50] || NOP;
8d4e0068:	c1 b8 00 00 
8d4e006c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0070:	14 33 00 00 
8d4e0074:	30 30       	R6 = R0;
8d4e0076:	19 e4 f8 ff 	R1 = [P3 + -0x20];
8d4e007a:	04 30       	R0 = R4;
8d4e007c:	00 de 05 8c 	CALL.A 0x8c05107e;
8d4e0080:	7e 10 00 00 
8d4e0084:	06 30       	R0 = R6;
8d4e0086:	0c 30       	R1 = R4;
8d4e0088:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e008c:	10 1b 00 00 
8d4e0090:	04 30       	R0 = R4;
8d4e0092:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0096:	38 1a 00 00 
8d4e009a:	a0 a1       	R0 = [P4 + 0x18];
8d4e009c:	18 0c       	CC = R0 == 0x3;
8d4e009e:	9d 11       	IF !CC JUMP 0x0x8d4e03d8;
8d4e00a0:	07 30       	R0 = R7;
8d4e00a2:	01 da 03 84 	R1=-2080152104;
8d4e00a6:	d8 65 00 00 
8d4e00aa:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e00ae:	14 33 00 00 
8d4e00b2:	38 b1       	[FP + 0x10] = R0;
8d4e00b4:	77 30       	R6 = FP;
8d4e00b6:	46 67       	R6 += -0x18;		/* (-24) */
8d4e00b8:	06 30       	R0 = R6;
8d4e00ba:	e1 61       	R1 = 0x3c (X);		/*		R1=0x118(280) */
8d4e00bc:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e00c0:	96 10 00 00 
8d4e00c4:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e00c8:	38 a1 00 00 
8d4e00cc:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e00d0:	10 1b 00 00 
8d4e00d4:	06 30       	R0 = R6;
8d4e00d6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e00da:	38 1a 00 00 
8d4e00de:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x64] || NOP;
8d4e00e2:	71 b8 00 00 
8d4e00e6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e00ea:	14 33 00 00 
8d4e00ee:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e00f2:	38 b1 00 00 
8d4e00f6:	99 e4 f8 ff 	R1 = B[P3 + -0x8] (Z);
8d4e00fa:	21 66       	R1 += -0x3c;		/* (-60) */
8d4e00fc:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0100:	96 10 00 00 
8d4e0104:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0108:	38 a1 00 00 
8d4e010c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0110:	10 1b 00 00 
8d4e0114:	06 30       	R0 = R6;
8d4e0116:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e011a:	38 1a 00 00 
8d4e011e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x54] || NOP;
8d4e0122:	b1 b8 00 00 
8d4e0126:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e012a:	14 33 00 00 
8d4e012e:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e0132:	38 b1 00 00 
8d4e0136:	99 e5 fc ff 	R1 = B[P3 + -0x4] (X);
8d4e013a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e013e:	96 10 00 00 
8d4e0142:	0e 30       	R1 = R6;
8d4e0144:	38 a1       	R0 = [FP + 0x10];
8d4e0146:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e014a:	10 1b 00 00 
8d4e014e:	06 30       	R0 = R6;
8d4e0150:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0154:	38 1a 00 00 
8d4e0158:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x68] || NOP;
8d4e015c:	61 b8 00 00 
8d4e0160:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0164:	14 33 00 00 
8d4e0168:	99 e4 fb ff 	R1 = B[P3 + -0x5] (Z);
8d4e016c:	fa 61       	R2 = 0x3f (X);		/*		R2=0x150(336) */
8d4e016e:	38 b1       	[FP + 0x10] = R0;
8d4e0170:	11 54       	R0 = R1 & R2;
8d4e0172:	ff e3 f2 da 	CALL 0x0x8d4db756;
8d4e0176:	08 30       	R1 = R0;
8d4e0178:	06 30       	R0 = R6;
8d4e017a:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4e017e:	a8 19 00 00 
8d4e0182:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0186:	38 a1 00 00 
8d4e018a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e018e:	10 1b 00 00 
8d4e0192:	06 30       	R0 = R6;
8d4e0194:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0198:	38 1a 00 00 
8d4e019c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x5c] || NOP;
8d4e01a0:	91 b8 00 00 
8d4e01a4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e01a8:	14 33 00 00 
8d4e01ac:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e01b0:	38 b1 00 00 
8d4e01b4:	99 e5 fe ff 	R1 = B[P3 + -0x2] (X);
8d4e01b8:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e01bc:	96 10 00 00 
8d4e01c0:	0e 30       	R1 = R6;
8d4e01c2:	38 a1       	R0 = [FP + 0x10];
8d4e01c4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e01c8:	10 1b 00 00 
8d4e01cc:	06 30       	R0 = R6;
8d4e01ce:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e01d2:	38 1a 00 00 
8d4e01d6:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x6c] || NOP;
8d4e01da:	51 b8 00 00 
8d4e01de:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e01e2:	14 33 00 00 
8d4e01e6:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP + 0x10] = R0 || R0 = [FP -0x58];
8d4e01ea:	38 b1 a0 b8 
8d4e01ee:	9a e4 fb ff 	R2 = B[P3 + -0x5] (Z);
8d4e01f2:	0a c6 02 00 	R0 = EXTRACT (R2, R0.L) (Z);
8d4e01f6:	00 0c       	CC = R0 == 0x0;
8d4e01f8:	03 10       	IF !CC JUMP 0x0x8d4e01fe;
8d4e01fa:	19 e4 fd ff 	R1 = [P3 + -0xc];
8d4e01fe:	06 30       	R0 = R6;
8d4e0200:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0204:	96 10 00 00 
8d4e0208:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e020c:	38 a1 00 00 
8d4e0210:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0214:	10 1b 00 00 
8d4e0218:	06 30       	R0 = R6;
8d4e021a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e021e:	38 1a 00 00 
8d4e0222:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x3c] || NOP;
8d4e0226:	f1 a3 00 00 
8d4e022a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e022e:	14 33 00 00 
8d4e0232:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP + 0x10] = R0 || R0 = [FP -0x58];
8d4e0236:	38 b1 a0 b8 
8d4e023a:	9a e4 fb ff 	R2 = B[P3 + -0x5] (Z);
8d4e023e:	0a c6 02 00 	R0 = EXTRACT (R2, R0.L) (Z);
8d4e0242:	00 0c       	CC = R0 == 0x0;
8d4e0244:	03 18       	IF CC JUMP 0x0x8d4e024a;
8d4e0246:	19 e4 fd ff 	R1 = [P3 + -0xc];
8d4e024a:	06 30       	R0 = R6;
8d4e024c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0250:	96 10 00 00 
8d4e0254:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0258:	38 a1 00 00 
8d4e025c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0260:	10 1b 00 00 
8d4e0264:	06 30       	R0 = R6;
8d4e0266:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e026a:	38 1a 00 00 
8d4e026e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x78] || NOP;
8d4e0272:	21 b8 00 00 
8d4e0276:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e027a:	14 33 00 00 
8d4e027e:	30 30       	R6 = R0;
8d4e0280:	99 e4 fa ff 	R1 = B[P3 + -0x6] (Z);
8d4e0284:	04 30       	R0 = R4;
8d4e0286:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e028a:	96 10 00 00 
8d4e028e:	06 30       	R0 = R6;
8d4e0290:	0c 30       	R1 = R4;
8d4e0292:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0296:	10 1b 00 00 
8d4e029a:	04 30       	R0 = R4;
8d4e029c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e02a0:	38 1a 00 00 
8d4e02a4:	18 e4 f9 ff 	R0 = [P3 + -0x1c];
8d4e02a8:	00 0c       	CC = R0 == 0x0;
8d4e02aa:	77 10       	IF !CC JUMP 0x0x8d4e0398;
8d4e02ac:	18 e4 fa ff 	R0 = [P3 + -0x18];
8d4e02b0:	38 0c       	CC = R0 == -0x1;
8d4e02b2:	53 10       	IF !CC JUMP 0x0x8d4e0358;
8d4e02b4:	98 e5 fd ff 	R0 = B[P3 + -0x3] (X);
8d4e02b8:	00 0c       	CC = R0 == 0x0;
8d4e02ba:	2f 10       	IF !CC JUMP 0x0x8d4e0318;
8d4e02bc:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x74] || NOP;
8d4e02c0:	31 b8 00 00 
8d4e02c4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e02c8:	14 33 00 00 
8d4e02cc:	30 30       	R6 = R0;
8d4e02ce:	99 e4 ff ff 	R1 = B[P3 + -0x1] (Z);
8d4e02d2:	04 30       	R0 = R4;
8d4e02d4:	00 de 05 8c 	CALL.A 0x8c051066;
8d4e02d8:	66 10 00 00 
8d4e02dc:	06 30       	R0 = R6;
8d4e02de:	0c 30       	R1 = R4;
8d4e02e0:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e02e4:	10 1b 00 00 
8d4e02e8:	04 30       	R0 = R4;
8d4e02ea:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e02ee:	38 1a 00 00 
8d4e02f2:	03 c8 00 18 	MNOP || R1 = [FP -0x60] || R0 = [FP + 0x8];
8d4e02f6:	81 b8 b8 a0 
8d4e02fa:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e02fe:	14 33 00 00 
8d4e0302:	0f 30       	R1 = R7;
8d4e0304:	00 de 05 8c 	CALL.A 0x8c0531e4;
8d4e0308:	e4 31 00 00 
8d4e030c:	07 30       	R0 = R7;
8d4e030e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0312:	38 1a 00 00 
8d4e0316:	11 2e       	JUMP.S 0x0x8d4dff38;
8d4e0318:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x34] || NOP;
8d4e031c:	71 a3 00 00 
8d4e0320:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0324:	14 33 00 00 
8d4e0328:	38 b1       	[FP + 0x10] = R0;
8d4e032a:	77 30       	R6 = FP;
8d4e032c:	46 67       	R6 += -0x18;		/* (-24) */
8d4e032e:	99 e5 fd ff 	R1 = B[P3 + -0x3] (X);
8d4e0332:	06 30       	R0 = R6;
8d4e0334:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0338:	96 10 00 00 
8d4e033c:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0340:	38 a1 00 00 
8d4e0344:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0348:	10 1b 00 00 
8d4e034c:	06 30       	R0 = R6;
8d4e034e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0352:	38 1a 00 00 
8d4e0356:	b3 2f       	JUMP.S 0x0x8d4e02bc;
8d4e0358:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x38] || NOP;
8d4e035c:	b1 a3 00 00 
8d4e0360:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0364:	14 33 00 00 
8d4e0368:	38 b1       	[FP + 0x10] = R0;
8d4e036a:	77 30       	R6 = FP;
8d4e036c:	46 67       	R6 += -0x18;		/* (-24) */
8d4e036e:	19 e4 fa ff 	R1 = [P3 + -0x18];
8d4e0372:	06 30       	R0 = R6;
8d4e0374:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0378:	96 10 00 00 
8d4e037c:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0380:	38 a1 00 00 
8d4e0384:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0388:	10 1b 00 00 
8d4e038c:	06 30       	R0 = R6;
8d4e038e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0392:	38 1a 00 00 
8d4e0396:	8f 2f       	JUMP.S 0x0x8d4e02b4;
8d4e0398:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x30] || NOP;
8d4e039c:	31 a3 00 00 
8d4e03a0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e03a4:	14 33 00 00 
8d4e03a8:	38 b1       	[FP + 0x10] = R0;
8d4e03aa:	77 30       	R6 = FP;
8d4e03ac:	46 67       	R6 += -0x18;		/* (-24) */
8d4e03ae:	19 e4 f9 ff 	R1 = [P3 + -0x1c];
8d4e03b2:	06 30       	R0 = R6;
8d4e03b4:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e03b8:	96 10 00 00 
8d4e03bc:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e03c0:	38 a1 00 00 
8d4e03c4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e03c8:	10 1b 00 00 
8d4e03cc:	06 30       	R0 = R6;
8d4e03ce:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e03d2:	38 1a 00 00 
8d4e03d6:	6b 2f       	JUMP.S 0x0x8d4e02ac;
8d4e03d8:	07 30       	R0 = R7;
8d4e03da:	01 da 03 84 	R1=-2080152104;
8d4e03de:	d8 65 00 00 
8d4e03e2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e03e6:	14 33 00 00 
8d4e03ea:	38 b1       	[FP + 0x10] = R0;
8d4e03ec:	77 30       	R6 = FP;
8d4e03ee:	46 67       	R6 += -0x18;		/* (-24) */
8d4e03f0:	99 e4 f8 ff 	R1 = B[P3 + -0x8] (Z);
8d4e03f4:	06 30       	R0 = R6;
8d4e03f6:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e03fa:	96 10 00 00 
8d4e03fe:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0402:	38 a1 00 00 
8d4e0406:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e040a:	10 1b 00 00 
8d4e040e:	06 30       	R0 = R6;
8d4e0410:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0414:	38 1a 00 00 
8d4e0418:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x54] || NOP;
8d4e041c:	b1 b8 00 00 
8d4e0420:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0424:	14 33 00 00 
8d4e0428:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e042c:	38 b1 00 00 
8d4e0430:	99 e5 fc ff 	R1 = B[P3 + -0x4] (X);
8d4e0434:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0438:	96 10 00 00 
8d4e043c:	0e 30       	R1 = R6;
8d4e043e:	38 a1       	R0 = [FP + 0x10];
8d4e0440:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0444:	10 1b 00 00 
8d4e0448:	06 30       	R0 = R6;
8d4e044a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e044e:	38 1a 00 00 
8d4e0452:	07 30       	R0 = R7;
8d4e0454:	31 e4 12 00 	R1 = [SP + 0x48];
8d4e0458:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e045c:	14 33 00 00 
8d4e0460:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e0464:	38 b1 00 00 
8d4e0468:	19 e4 fb ff 	R1 = [P3 + -0x14];
8d4e046c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0470:	96 10 00 00 
8d4e0474:	0e 30       	R1 = R6;
8d4e0476:	38 a1       	R0 = [FP + 0x10];
8d4e0478:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e047c:	10 1b 00 00 
8d4e0480:	06 30       	R0 = R6;
8d4e0482:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0486:	38 1a 00 00 
8d4e048a:	07 30       	R0 = R7;
8d4e048c:	31 e4 11 00 	R1 = [SP + 0x44];
8d4e0490:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0494:	14 33 00 00 
8d4e0498:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e049c:	38 b1 00 00 
8d4e04a0:	19 e4 fc ff 	R1 = [P3 + -0x10];
8d4e04a4:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e04a8:	96 10 00 00 
8d4e04ac:	0e 30       	R1 = R6;
8d4e04ae:	38 a1       	R0 = [FP + 0x10];
8d4e04b0:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e04b4:	10 1b 00 00 
8d4e04b8:	06 30       	R0 = R6;
8d4e04ba:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e04be:	38 1a 00 00 
8d4e04c2:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x7c] || NOP;
8d4e04c6:	11 b8 00 00 
8d4e04ca:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e04ce:	14 33 00 00 
8d4e04d2:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e04d6:	38 b1 00 00 
8d4e04da:	1a e4 fd ff 	R2 = [P3 + -0xc];
8d4e04de:	1b e4 f8 ff 	R3 = [P3 + -0x20];
8d4e04e2:	31 c2 53 20 	R1 = R2 * R3 (T);
8d4e04e6:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e04ea:	96 10 00 00 
8d4e04ee:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e04f2:	38 a1 00 00 
8d4e04f6:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e04fa:	10 1b 00 00 
8d4e04fe:	06 30       	R0 = R6;
8d4e0500:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0504:	38 1a 00 00 
8d4e0508:	07 30       	R0 = R7;
8d4e050a:	31 e4 10 00 	R1 = [SP + 0x40];
8d4e050e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0512:	14 33 00 00 
8d4e0516:	99 e4 fb ff 	R1 = B[P3 + -0x5] (Z);
8d4e051a:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R2 = [FP -0x58] || [FP + 0x10] = R0;
8d4e051e:	a2 b8 38 b1 
8d4e0522:	0a c6 11 02 	R1 = EXTRACT (R1, R2.L) (Z);
8d4e0526:	01 0c       	CC = R1 == 0x0;
8d4e0528:	11 02       	ILLEGAL;
8d4e052a:	00 de 05 8c 	CALL.A 0x8c051066;
8d4e052e:	66 10 00 00 
8d4e0532:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0536:	38 a1 00 00 
8d4e053a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e053e:	10 1b 00 00 
8d4e0542:	06 30       	R0 = R6;
8d4e0544:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0548:	38 1a 00 00 
8d4e054c:	98 e4 fb ff 	R0 = B[P3 + -0x5] (Z);
8d4e0550:	72 e4 39 00 	R2 = W[SP + 0x72] (Z);
8d4e0554:	0a ce 10 00 	R0 = EXTRACT (R0, R2.L) (Z) || R1 = [SP + 0x2c] || NOP;
8d4e0558:	f1 a2 00 00 
8d4e055c:	00 0c       	CC = R0 == 0x0;
8d4e055e:	88 1e       	IF CC JUMP 0x0x8d4e026e (BP);
8d4e0560:	07 30       	R0 = R7;
8d4e0562:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0566:	14 33 00 00 
8d4e056a:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP + 0x10] = R0 || NOP;
8d4e056e:	38 b1 00 00 
8d4e0572:	77 30       	R6 = FP;
8d4e0574:	a6 67       	R6 += -0xc;		/* (-12) */
8d4e0576:	06 30       	R0 = R6;
8d4e0578:	00 de 05 8c 	CALL.A 0x8c051066;
8d4e057c:	66 10 00 00 
8d4e0580:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0584:	38 a1 00 00 
8d4e0588:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e058c:	10 1b 00 00 
8d4e0590:	06 30       	R0 = R6;
8d4e0592:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0596:	38 1a 00 00 
8d4e059a:	6a 2e       	JUMP.S 0x0x8d4e026e;
8d4e059c:	10 0c       	CC = R0 == 0x2;
8d4e059e:	02 10       	IF !CC JUMP 0x0x8d4e05a2;
8d4e05a0:	1e 2c       	JUMP.S 0x0x8d4dfddc;
8d4e05a2:	f1 60       	R1 = 0x1e (X);		/*		R1=0x118(280) */
8d4e05a4:	08 08       	CC = R0 == R1;
8d4e05a6:	02 10       	IF !CC JUMP 0x0x8d4e05aa;
8d4e05a8:	1a 2c       	JUMP.S 0x0x8d4dfddc;
8d4e05aa:	cb 2c       	JUMP.S 0x0x8d4dff40;
8d4e05ac:	00 00       	NOP;
8d4e05ae:	00 00       	NOP;
8d4e05b0:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4e05b4:	d1 b8 b8 a0 
8d4e05b8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e05bc:	14 33 00 00 
8d4e05c0:	05 da 03 84 	R5=-2080152904;
8d4e05c4:	b8 62 00 00 
8d4e05c8:	22 e1 18 01 	R2 = 0x118 (X);		/*		R2=0x118(280) */
8d4e05cc:	55 50       	R1 = R5 + R2;
8d4e05ce:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e05d2:	14 33 00 00 
8d4e05d6:	23 e1 94 38 	R3 = 0x3894 (X);		/*		R3=0x3894(14484) */
8d4e05da:	28 30       	R5 = R0;
8d4e05dc:	1c 50       	R0 = R4 + R3;
8d4e05de:	7f 30       	R7 = FP;
8d4e05e0:	ff e3 25 f3 	CALL 0x0x8d4dec2a;
8d4e05e4:	87 66       	R7 += -0x30;		/* (-48) */
8d4e05e6:	08 30       	R1 = R0;
8d4e05e8:	07 30       	R0 = R7;
8d4e05ea:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4e05ee:	a8 19 00 00 
8d4e05f2:	05 30       	R0 = R5;
8d4e05f4:	0f 30       	R1 = R7;
8d4e05f6:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e05fa:	10 1b 00 00 
8d4e05fe:	07 30       	R0 = R7;
8d4e0600:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0604:	38 1a 00 00 
8d4e0608:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4e060c:	d1 b8 b8 a0 
8d4e0610:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0614:	14 33 00 00 
8d4e0618:	01 da 03 84 	R1=-2080151972;
8d4e061c:	5c 66 00 00 
8d4e0620:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0624:	14 33 00 00 
8d4e0628:	22 e1 98 38 	R2 = 0x3898 (X);		/*		R2=0x3898(14488) */
8d4e062c:	28 30       	R5 = R0;
8d4e062e:	14 50       	R0 = R4 + R2;
8d4e0630:	ff e3 ab ea 	CALL 0x0x8d4ddb86;
8d4e0634:	08 30       	R1 = R0;
8d4e0636:	07 30       	R0 = R7;
8d4e0638:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e063c:	96 10 00 00 
8d4e0640:	05 30       	R0 = R5;
8d4e0642:	0f 30       	R1 = R7;
8d4e0644:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0648:	10 1b 00 00 
8d4e064c:	07 30       	R0 = R7;
8d4e064e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0652:	38 1a 00 00 
8d4e0656:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4e065a:	d1 b8 b8 a0 
8d4e065e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0662:	14 33 00 00 
8d4e0666:	05 da 03 84 	R5=-2080152904;
8d4e066a:	b8 62 00 00 
8d4e066e:	22 e1 94 01 	R2 = 0x194 (X);		/*		R2=0x194(404) */
8d4e0672:	55 50       	R1 = R5 + R2;
8d4e0674:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0678:	14 33 00 00 
8d4e067c:	23 e1 9c 38 	R3 = 0x389c (X);		/*		R3=0x389c(14492) */
8d4e0680:	28 30       	R5 = R0;
8d4e0682:	1c 50       	R0 = R4 + R3;
8d4e0684:	ff e3 81 ea 	CALL 0x0x8d4ddb86;
8d4e0688:	08 30       	R1 = R0;
8d4e068a:	07 30       	R0 = R7;
8d4e068c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0690:	96 10 00 00 
8d4e0694:	05 30       	R0 = R5;
8d4e0696:	0f 30       	R1 = R7;
8d4e0698:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e069c:	10 1b 00 00 
8d4e06a0:	07 30       	R0 = R7;
8d4e06a2:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e06a6:	38 1a 00 00 
8d4e06aa:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4e06ae:	d1 b8 b8 a0 
8d4e06b2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e06b6:	14 33 00 00 
8d4e06ba:	05 da 03 84 	R5=-2080152904;
8d4e06be:	b8 62 00 00 
8d4e06c2:	22 e1 a0 01 	R2 = 0x1a0 (X);		/*		R2=0x1a0(416) */
8d4e06c6:	55 50       	R1 = R5 + R2;
8d4e06c8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e06cc:	14 33 00 00 
8d4e06d0:	23 e1 a0 38 	R3 = 0x38a0 (X);		/*		R3=0x38a0(14496) */
8d4e06d4:	28 30       	R5 = R0;
8d4e06d6:	1c 50       	R0 = R4 + R3;
8d4e06d8:	ff e3 57 ea 	CALL 0x0x8d4ddb86;
8d4e06dc:	08 30       	R1 = R0;
8d4e06de:	07 30       	R0 = R7;
8d4e06e0:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e06e4:	96 10 00 00 
8d4e06e8:	05 30       	R0 = R5;
8d4e06ea:	0f 30       	R1 = R7;
8d4e06ec:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e06f0:	10 1b 00 00 
8d4e06f4:	07 30       	R0 = R7;
8d4e06f6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e06fa:	38 1a 00 00 
8d4e06fe:	ff e2 e1 f6 	JUMP.L 0x0x8d4df4c0;
8d4e0702:	00 00       	NOP;
8d4e0704:	00 00       	NOP;
8d4e0706:	00 00       	NOP;
8d4e0708:	00 da 03 84 	R0=-2080151768;
8d4e070c:	28 67 00 00 
8d4e0710:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d4e0714:	a4 05 00 00 
8d4e0718:	ff e2 cc f2 	JUMP.L 0x0x8d4decb0;
8d4e071c:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d4e0720:	68 05       	[--SP] = (R7:5);
8d4e0722:	38 30       	R7 = R0;
8d4e0724:	47 30       	R0 = FP;
8d4e0726:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e0728:	40 66       	R0 += -0x38;		/* (-56) */
8d4e072a:	77 30       	R6 = FP;
8d4e072c:	29 30       	R5 = R1;
8d4e072e:	06 e3 85 1f 	CALL 0x0x8d5a4638;
8d4e0732:	26 67       	R6 += -0x1c;		/* (-28) */
8d4e0734:	0d 30       	R1 = R5;
8d4e0736:	06 30       	R0 = R6;
8d4e0738:	06 e3 be 1f 	CALL 0x0x8d5a46b4;
8d4e073c:	0e 30       	R1 = R6;
8d4e073e:	07 30       	R0 = R7;
8d4e0740:	16 30       	R2 = R6;
8d4e0742:	21 67       	R1 += -0x1c;		/* (-28) */
8d4e0744:	06 e3 b1 20 	CALL 0x0x8d5a48a6;
8d4e0748:	87 60       	R7 = 0x10 (X);		/*		R7=0xac(172) */
8d4e074a:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R0 = [FP -0x4] || NOP;
8d4e074e:	f0 b9 00 00 
8d4e0752:	07 0a       	CC = R7 <= R0 (IU);
8d4e0754:	1a 18       	IF CC JUMP 0x0x8d4e0788;
8d4e0756:	78 60       	R0 = 0xf (X);		/*		R0=0x94(148) */
8d4e0758:	f0 bb       	[FP -0x4] = R0;
8d4e075a:	30 a3       	R0 = [SP + 0x30];
8d4e075c:	07 0a       	CC = R7 <= R0 (IU);
8d4e075e:	e6 bb       	[FP -0x8] = R6;
8d4e0760:	b6 e6 38 00 	B[SP + 0x38] = R6;
8d4e0764:	08 18       	IF CC JUMP 0x0x8d4e0774;
8d4e0766:	b6 e6 1c 00 	B[SP + 0x1c] = R6;
8d4e076a:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e076c:	28 05       	(R7:5) = [SP++];
8d4e076e:	01 e8 00 00 	UNLINK;
8d4e0772:	10 00       	RTS;
8d4e0774:	f0 a1       	R0 = [SP + 0x1c];
8d4e0776:	ff e3 37 6e 	CALL 0x0x8d4ce3e4;
8d4e077a:	b6 e6 1c 00 	B[SP + 0x1c] = R6;
8d4e077e:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e0780:	28 05       	(R7:5) = [SP++];
8d4e0782:	01 e8 00 00 	UNLINK;
8d4e0786:	10 00       	RTS;
8d4e0788:	b0 a3       	R0 = [SP + 0x38];
8d4e078a:	ff e3 2d 6e 	CALL 0x0x8d4ce3e4;
8d4e078e:	e4 2f       	JUMP.S 0x0x8d4e0756;
8d4e0790:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d4e0794:	68 05       	[--SP] = (R7:5);
8d4e0796:	6f 30       	R5 = FP;
8d4e0798:	25 67       	R5 += -0x1c;		/* (-28) */
8d4e079a:	30 30       	R6 = R0;
8d4e079c:	39 30       	R7 = R1;
8d4e079e:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e07a0:	05 30       	R0 = R5;
8d4e07a2:	0a 30       	R1 = R2;
8d4e07a4:	06 e3 88 1f 	CALL 0x0x8d5a46b4;
8d4e07a8:	15 30       	R2 = R5;
8d4e07aa:	0f 30       	R1 = R7;
8d4e07ac:	06 30       	R0 = R6;
8d4e07ae:	06 e3 7c 20 	CALL 0x0x8d5a48a6;
8d4e07b2:	80 60       	R0 = 0x10 (X);		/*		R0=0x94(148) */
8d4e07b4:	31 a3       	R1 = [SP + 0x30];
8d4e07b6:	08 0a       	CC = R0 <= R1 (IU);
8d4e07b8:	09 18       	IF CC JUMP 0x0x8d4e07ca;
8d4e07ba:	00 60       	R0 = 0x0 (X);		/*		R0=0x94(148) */
8d4e07bc:	b0 e6 1c 00 	B[SP + 0x1c] = R0;
8d4e07c0:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e07c2:	28 05       	(R7:5) = [SP++];
8d4e07c4:	01 e8 00 00 	UNLINK;
8d4e07c8:	10 00       	RTS;
8d4e07ca:	f0 a1       	R0 = [SP + 0x1c];
8d4e07cc:	ff e3 0c 6e 	CALL 0x0x8d4ce3e4;
8d4e07d0:	00 60       	R0 = 0x0 (X);		/*		R0=0x94(148) */
8d4e07d2:	b0 e6 1c 00 	B[SP + 0x1c] = R0;
8d4e07d6:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e07d8:	28 05       	(R7:5) = [SP++];
8d4e07da:	01 e8 00 00 	UNLINK;
8d4e07de:	10 00       	RTS;
8d4e07e0:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d4e07e4:	08 30       	R1 = R0;
8d4e07e6:	60 05       	[--SP] = (R7:4);
8d4e07e8:	47 30       	R0 = FP;
8d4e07ea:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e07ec:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e07ee:	06 e3 61 1d 	CALL 0x0x8d5a42b0;
8d4e07f2:	03 c8 00 18 	MNOP || R7 = [SP + 0x30] || R3 = [SP + 0x34];
8d4e07f6:	37 a3 73 a3 
8d4e07fa:	65 60       	R5 = 0xc (X);		/*		R5=0x8c(140) */
8d4e07fc:	af 09       	CC = R7 < R5 (IU);
8d4e07fe:	86 60       	R6 = 0x10 (X);		/*		R6=0xe8(232) */
8d4e0800:	47 30       	R0 = FP;
8d4e0802:	2f 07       	IF CC R5 = R7;
8d4e0804:	1e 0a       	CC = R6 <= R3 (IU);
8d4e0806:	40 67       	R0 += -0x18;		/* (-24) */
8d4e0808:	34 a2       	R4 = [SP + 0x20];
8d4e080a:	62 60       	R2 = 0xc (X);		/*		R2=0x1a0(416) */
8d4e080c:	04 07       	IF CC R0 = R4;
8d4e080e:	95 09       	CC = R5 < R2 (IU);
8d4e0810:	15 07       	IF CC R2 = R5;
8d4e0812:	01 da 03 84 	R1=-2080152276;
8d4e0816:	2c 65 00 00 
8d4e081a:	00 de 02 04 	CALL.A 0x04023068;
8d4e081e:	68 30 00 00 
8d4e0822:	38 30       	R7 = R0;
8d4e0824:	07 0c       	CC = R7 == 0x0;
8d4e0826:	07 10       	IF !CC JUMP 0x0x8d4e0834;
8d4e0828:	60 60       	R0 = 0xc (X);		/*		R0=0x94(148) */
8d4e082a:	85 09       	CC = R5 < R0 (IU);
8d4e082c:	ff 63       	R7 = -0x1 (X);		/*		R7=0xac(172) */
8d4e082e:	03 18       	IF CC JUMP 0x0x8d4e0834;
8d4e0830:	28 08       	CC = R0 == R5;
8d4e0832:	17 02       	ILLEGAL;
8d4e0834:	70 a3       	R0 = [SP + 0x34];
8d4e0836:	06 0a       	CC = R6 <= R0 (IU);
8d4e0838:	0b 18       	IF CC JUMP 0x0x8d4e084e;
8d4e083a:	00 60       	R0 = 0x0 (X);		/*		R0=0x94(148) */
8d4e083c:	b0 e6 20 00 	B[SP + 0x20] = R0;
8d4e0840:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e0842:	07 0c       	CC = R7 == 0x0;
8d4e0844:	20 05       	(R7:4) = [SP++];
8d4e0846:	01 e8 00 00 	UNLINK;
8d4e084a:	00 02       	R0 = CC;
8d4e084c:	10 00       	RTS;
8d4e084e:	30 a2       	R0 = [SP + 0x20];
8d4e0850:	ff e3 ca 6d 	CALL 0x0x8d4ce3e4;
8d4e0854:	00 60       	R0 = 0x0 (X);		/*		R0=0x94(148) */
8d4e0856:	b0 e6 20 00 	B[SP + 0x20] = R0;
8d4e085a:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e085c:	07 0c       	CC = R7 == 0x0;
8d4e085e:	20 05       	(R7:4) = [SP++];
8d4e0860:	01 e8 00 00 	UNLINK;
8d4e0864:	00 02       	R0 = CC;
8d4e0866:	10 00       	RTS;
8d4e0868:	00 e8 23 00 	LINK 0x8c;		/* (140) */
8d4e086c:	60 05       	[--SP] = (R7:4);
8d4e086e:	86 6f       	SP += -0x10;		/* (-16) */
8d4e0870:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0x20] = R1 || NOP;
8d4e0874:	31 b2 00 00 
8d4e0878:	47 30       	R0 = FP;
8d4e087a:	48 64       	R0 += 0x9;		/* (  9) */
8d4e087c:	0a 60       	R2 = 0x1 (X);		/*		R2=0x1a0(416) */
8d4e087e:	01 60       	R1 = 0x0 (X);		/*		R1=0x118(280) */
8d4e0880:	00 de 02 04 	CALL.A 0x04022ea8;
8d4e0884:	a8 2e 00 00 
8d4e0888:	24 e1 40 00 	R4 = 0x40 (X);		/*		R4=0x40( 64) */
8d4e088c:	5e 30       	R3 = SP;
8d4e088e:	e3 50       	R3 = R3 + R4;
8d4e0890:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [FP + 0x10] = R3 || NOP;
8d4e0894:	3b b1 00 00 
8d4e0898:	57 30       	R2 = FP;
8d4e089a:	42 64       	R2 += 0x8;		/* (  8) */
8d4e089c:	0a 30       	R1 = R2;
8d4e089e:	09 64       	R1 += 0x1;		/* (  1) */
8d4e08a0:	38 a1       	R0 = [FP + 0x10];
8d4e08a2:	ff e3 51 e0 	CALL 0x0x8d4dc944;
8d4e08a6:	76 30       	R6 = SP;
8d4e08a8:	22 61       	R2 = 0x24 (X);		/*		R2=0x1a0(416) */
8d4e08aa:	04 cc 32 0c 	R6 = R6 + R2 (NS) || [SP + 0x38] = R5 || NOP;
8d4e08ae:	b5 b3 00 00 
8d4e08b2:	04 da 03 84 	R4=-2080152784;
8d4e08b6:	30 63 00 00 
8d4e08ba:	23 e1 0c 02 	R3 = 0x20c (X);		/*		R3=0x20c(524) */
8d4e08be:	7a 60       	R2 = 0xf (X);		/*		R2=0x1a0(416) */
8d4e08c0:	04 cc 23 02 	R1 = R4 + R3 (NS) || [SP + 0x3c] = R2 || NOP;
8d4e08c4:	f2 b3 00 00 
8d4e08c8:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4e08cc:	06 30       	R0 = R6;
8d4e08ce:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e08d2:	76 a3 00 00 
8d4e08d6:	06 30       	R0 = R6;
8d4e08d8:	0e 30       	R1 = R6;
8d4e08da:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e08dc:	ff e3 a4 df 	CALL 0x0x8d4dc824;
8d4e08e0:	f0 a3       	R0 = [SP + 0x3c];
8d4e08e2:	82 60       	R2 = 0x10 (X);		/*		R2=0x1a0(416) */
8d4e08e4:	02 0a       	CC = R2 <= R0 (IU);
8d4e08e6:	a8 18       	IF CC JUMP 0x0x8d4e0a36;
8d4e08e8:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0x38] = R5 || NOP;
8d4e08ec:	b5 b3 00 00 
8d4e08f0:	7b 60       	R3 = 0xf (X);		/*		R3=0x20c(524) */
8d4e08f2:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4e08f6:	f3 b3       	[SP + 0x3c] = R3;
8d4e08f8:	40 64       	R0 += 0x8;		/* (  8) */
8d4e08fa:	01 da 03 84 	R1=-2080152784;
8d4e08fe:	30 63 00 00 
8d4e0902:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0906:	14 33 00 00 
8d4e090a:	56 30       	R2 = SP;
8d4e090c:	23 e1 4c 00 	R3 = 0x4c (X);		/*		R3=0x4c( 76) */
8d4e0910:	9a 51       	R6 = R2 + R3;
8d4e0912:	08 30       	R1 = R0;
8d4e0914:	06 30       	R0 = R6;
8d4e0916:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4e091a:	f0 2b 00 00 
8d4e091e:	06 30       	R0 = R6;
8d4e0920:	00 de 05 8c 	CALL.A 0x8c052382;
8d4e0924:	82 23 00 00 
8d4e0928:	00 0d       	CC = R0 <= 0x0;
8d4e092a:	31 18       	IF CC JUMP 0x0x8d4e098c;
8d4e092c:	20 e1 98 00 	R0 = 0x98 (X);		/*		R0=0x98(152) */
8d4e0930:	04 50       	R0 = R4 + R0;
8d4e0932:	f8 b0       	[FP + 0xc] = R0;
8d4e0934:	07 60       	R7 = 0x0 (X);		/*		R7=0xac(172) */
8d4e0936:	56 30       	R2 = SP;
8d4e0938:	23 e1 58 00 	R3 = 0x58 (X);		/*		R3=0x58( 88) */
8d4e093c:	0f 30       	R1 = R7;
8d4e093e:	06 30       	R0 = R6;
8d4e0940:	1a 51       	R4 = R2 + R3;
8d4e0942:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4e0946:	e4 30 00 00 
8d4e094a:	f9 a0       	R1 = [FP + 0xc];
8d4e094c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0950:	14 33 00 00 
8d4e0954:	08 30       	R1 = R0;
8d4e0956:	04 30       	R0 = R4;
8d4e0958:	00 de 05 8c 	CALL.A 0x8c051cca;
8d4e095c:	ca 1c 00 00 
8d4e0960:	00 b9       	R0 = [FP -0x40];
8d4e0962:	00 0c       	CC = R0 == 0x0;
8d4e0964:	33 10       	IF !CC JUMP 0x0x8d4e09ca;
8d4e0966:	10 b9       	R0 = [FP -0x3c];
8d4e0968:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e096a:	01 0a       	CC = R1 <= R0 (IU);
8d4e096c:	2b 18       	IF CC JUMP 0x0x8d4e09c2;
8d4e096e:	78 60       	R0 = 0xf (X);		/*		R0=0x98(152) */
8d4e0970:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x3c] = R0 || NOP;
8d4e0974:	10 bb 00 00 
8d4e0978:	05 bb       	[FP -0x40] = R5;
8d4e097a:	b5 e6 5c 00 	B[SP + 0x5c] = R5;
8d4e097e:	0f 64       	R7 += 0x1;		/* (  1) */
8d4e0980:	00 de 05 8c 	CALL.A 0x8c052382;
8d4e0984:	82 23 00 00 
8d4e0988:	87 08       	CC = R7 < R0;
8d4e098a:	d6 1f       	IF CC JUMP 0x0x8d4e0936 (BP);
8d4e098c:	09 68       	P1 = 0x1 (X);		/*		P1=0x5394(21396) */
8d4e098e:	03 c8 00 18 	MNOP || [SP + 0xc] = P1 || R0 = [FP + 0x10];
8d4e0992:	f1 bc 38 a1 
8d4e0996:	31 a2       	R1 = [SP + 0x20];
8d4e0998:	02 da 4d 8d 	R2=-1924281800;
8d4e099c:	38 ca 00 00 
8d4e09a0:	00 de 03 8c 	CALL.A 0x8c03ffac;
8d4e09a4:	ac ff 00 00 
8d4e09a8:	06 30       	R0 = R6;
8d4e09aa:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e09ae:	38 1a 00 00 
8d4e09b2:	38 a1       	R0 = [FP + 0x10];
8d4e09b4:	ff e3 24 e0 	CALL 0x0x8d4dc9fc;
8d4e09b8:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e09ba:	20 05       	(R7:4) = [SP++];
8d4e09bc:	01 e8 00 00 	UNLINK;
8d4e09c0:	10 00       	RTS;
8d4e09c2:	c0 b8       	R0 = [FP -0x50];
8d4e09c4:	ff e3 10 6d 	CALL 0x0x8d4ce3e4;
8d4e09c8:	d3 2f       	JUMP.S 0x0x8d4e096e;
8d4e09ca:	04 30       	R0 = R4;
8d4e09cc:	ff e3 0a ff 	CALL 0x0x8d4e07e0;
8d4e09d0:	00 0c       	CC = R0 == 0x0;
8d4e09d2:	ca 17       	IF !CC JUMP 0x0x8d4e0966 (BP);
8d4e09d4:	04 30       	R0 = R4;
8d4e09d6:	0c 30       	R1 = R4;
8d4e09d8:	c0 65       	R0 += 0x38;		/* ( 56) */
8d4e09da:	06 e3 6b 1c 	CALL 0x0x8d5a42b0;
8d4e09de:	47 30       	R0 = FP;
8d4e09e0:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e09e2:	08 30       	R1 = R0;
8d4e09e4:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e09e6:	06 e3 67 1e 	CALL 0x0x8d5a46b4;
8d4e09ea:	4f 30       	R1 = FP;
8d4e09ec:	41 66       	R1 += -0x38;		/* (-56) */
8d4e09ee:	01 30       	R0 = R1;
8d4e09f0:	60 66       	R0 += -0x34;		/* (-52) */
8d4e09f2:	ff e3 19 df 	CALL 0x0x8d4dc824;
8d4e09f6:	80 b9       	R0 = [FP -0x20];
8d4e09f8:	82 60       	R2 = 0x10 (X);		/*		R2=0x1a0(416) */
8d4e09fa:	02 0a       	CC = R2 <= R0 (IU);
8d4e09fc:	19 18       	IF CC JUMP 0x0x8d4e0a2e;
8d4e09fe:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || [FP -0x24] = R5;
8d4e0a02:	f0 b9 75 bb 
8d4e0a06:	82 60       	R2 = 0x10 (X);		/*		R2=0x1a0(416) */
8d4e0a08:	79 60       	R1 = 0xf (X);		/*		R1=0x118(280) */
8d4e0a0a:	02 0a       	CC = R2 <= R0 (IU);
8d4e0a0c:	b5 e6 78 00 	B[SP + 0x78] = R5;
8d4e0a10:	03 c8 00 18 	MNOP || [FP -0x20] = R1 || R0 = [FP -0x18];
8d4e0a14:	81 bb a0 b9 
8d4e0a18:	08 18       	IF CC JUMP 0x0x8d4e0a28;
8d4e0a1a:	78 60       	R0 = 0xf (X);		/*		R0=0x98(152) */
8d4e0a1c:	e5 bb       	[FP -0x8] = R5;
8d4e0a1e:	b5 e6 94 00 	B[SP + 0x94] = R5;
8d4e0a22:	f0 bb       	[FP -0x4] = R0;
8d4e0a24:	a1 2f       	JUMP.S 0x0x8d4e0966;
8d4e0a26:	00 00       	NOP;
8d4e0a28:	ff e3 de 6c 	CALL 0x0x8d4ce3e4;
8d4e0a2c:	f7 2f       	JUMP.S 0x0x8d4e0a1a;
8d4e0a2e:	30 b9       	R0 = [FP -0x34];
8d4e0a30:	ff e3 da 6c 	CALL 0x0x8d4ce3e4;
8d4e0a34:	e5 2f       	JUMP.S 0x0x8d4e09fe;
8d4e0a36:	b0 a2       	R0 = [SP + 0x28];
8d4e0a38:	ff e3 d6 6c 	CALL 0x0x8d4ce3e4;
8d4e0a3c:	56 2f       	JUMP.S 0x0x8d4e08e8;
8d4e0a3e:	00 00       	NOP;
8d4e0a40:	00 e8 59 00 	LINK 0x164;		/* (356) */
8d4e0a44:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e0a46:	86 6f       	SP += -0x10;		/* (-16) */
8d4e0a48:	40 64       	R0 += 0x8;		/* (  8) */
8d4e0a4a:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || [FP -0x10] = R1 || NOP;
8d4e0a4e:	c1 bb 00 00 
8d4e0a52:	01 da 03 84 	R1=-2080152784;
8d4e0a56:	30 63 00 00 
8d4e0a5a:	d0 bb       	[FP -0xc] = R0;
8d4e0a5c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0a60:	14 33 00 00 
8d4e0a64:	26 e1 5c 00 	R6 = 0x5c (X);		/*		R6=0x5c( 92) */
8d4e0a68:	56 30       	R2 = SP;
8d4e0a6a:	b2 50       	R2 = R2 + R6;
8d4e0a6c:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d4e0a70:	ba b0 00 00 
8d4e0a74:	25 e1 68 00 	R5 = 0x68 (X);		/*		R5=0x68(104) */
8d4e0a78:	24 e1 74 00 	R4 = 0x74 (X);		/*		R4=0x74(116) */
8d4e0a7c:	26 e1 78 00 	R6 = 0x78 (X);		/*		R6=0x78(120) */
8d4e0a80:	b8 a0       	R0 = [FP + 0x8];
8d4e0a82:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4e0a86:	f0 2b 00 00 
8d4e0a8a:	5e 30       	R3 = SP;
8d4e0a8c:	eb 50       	R3 = R3 + R5;
8d4e0a8e:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [FP -0x8] = R3 || NOP;
8d4e0a92:	e3 bb 00 00 
8d4e0a96:	31 60       	R1 = 0x6 (X);		/*		R1=0x118(280) */
8d4e0a98:	0d da 03 84 	P5=-2080151712;
8d4e0a9c:	60 67 00 00 
8d4e0aa0:	e0 b9       	R0 = [FP -0x8];
8d4e0aa2:	00 de 05 8c 	CALL.A 0x8c053038;
8d4e0aa6:	38 30 00 00 
8d4e0aaa:	56 30       	R2 = SP;
8d4e0aac:	22 50       	R0 = R2 + R4;
8d4e0aae:	0f 30       	R1 = R7;
8d4e0ab0:	ff e3 36 fe 	CALL 0x0x8d4e071c;
8d4e0ab4:	31 e4 23 00 	R1 = [SP + 0x8c];
8d4e0ab8:	87 60       	R7 = 0x10 (X);		/*		R7=0xac(172) */
8d4e0aba:	5e 30       	R3 = SP;
8d4e0abc:	0f 0a       	CC = R7 <= R1 (IU);
8d4e0abe:	33 50       	R0 = R3 + R6;
8d4e0ac0:	32 e4 1e 00 	R2 = [SP + 0x78];
8d4e0ac4:	02 07       	IF CC R0 = R2;
8d4e0ac6:	00 de 03 8c 	CALL.A 0x8c03e328;
8d4e0aca:	28 e3 00 00 
8d4e0ace:	00 0c       	CC = R0 == 0x0;
8d4e0ad0:	38 30       	R7 = R0;
8d4e0ad2:	03 14       	IF !CC JUMP 0x0x8d4e0ad8 (BP);
8d4e0ad4:	32 22       	JUMP.S 0x0x8d4e0f38;
8d4e0ad6:	00 00       	NOP;
8d4e0ad8:	20 e1 98 00 	R0 = 0x98 (X);		/*		R0=0x98(152) */
8d4e0adc:	01 da 03 84 	R1=-2080152784;
8d4e0ae0:	30 63 00 00 
8d4e0ae4:	01 50       	R0 = R1 + R0;
8d4e0ae6:	38 b1       	[FP + 0x10] = R0;
8d4e0ae8:	06 60       	R6 = 0x0 (X);		/*		R6=0x78(120) */
8d4e0aea:	06 30       	R0 = R6;
8d4e0aec:	c1 60       	R1 = 0x18 (X);		/*		R1=0x118(280) */
8d4e0aee:	08 64       	R0 += 0x1;		/* (  1) */
8d4e0af0:	8e 08       	CC = R6 < R1;
8d4e0af2:	03 c8 00 18 	MNOP || [FP + 0xc] = R0 || R0 = [FP + 0x8];
8d4e0af6:	f8 b0 b8 a0 
8d4e0afa:	92 11       	IF !CC JUMP 0x0x8d4e0e1e;
8d4e0afc:	00 de 05 8c 	CALL.A 0x8c052382;
8d4e0b00:	82 23 00 00 
8d4e0b04:	30 0a       	CC = R0 <= R6 (IU);
8d4e0b06:	8c 19       	IF CC JUMP 0x0x8d4e0e1e;
8d4e0b08:	56 30       	R2 = SP;
8d4e0b0a:	27 e1 c4 00 	R7 = 0xc4 (X);		/*		R7=0xc4(196) */
8d4e0b0e:	5e 30       	R3 = SP;
8d4e0b10:	24 e1 d0 00 	R4 = 0xd0 (X);		/*		R4=0xd0(208) */
8d4e0b14:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4e0b18:	b8 a0 00 00 
8d4e0b1c:	fa 51       	R7 = R2 + R7;
8d4e0b1e:	a3 51       	R6 = R3 + R4;
8d4e0b20:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4e0b24:	e4 30 00 00 
8d4e0b28:	08 30       	R1 = R0;
8d4e0b2a:	07 30       	R0 = R7;
8d4e0b2c:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4e0b30:	f0 2b 00 00 
8d4e0b34:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d4e0b38:	39 a1 00 00 
8d4e0b3c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0b40:	14 33 00 00 
8d4e0b44:	08 30       	R1 = R0;
8d4e0b46:	06 30       	R0 = R6;
8d4e0b48:	00 de 05 8c 	CALL.A 0x8c051cca;
8d4e0b4c:	ca 1c 00 00 
8d4e0b50:	06 30       	R0 = R6;
8d4e0b52:	ff e3 47 fe 	CALL 0x0x8d4e07e0;
8d4e0b56:	00 0c       	CC = R0 == 0x0;
8d4e0b58:	79 18       	IF CC JUMP 0x0x8d4e0c4a;
8d4e0b5a:	56 30       	R2 = SP;
8d4e0b5c:	24 e1 24 01 	R4 = 0x124 (X);		/*		R4=0x124(292) */
8d4e0b60:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d4e0b64:	39 a1 00 00 
8d4e0b68:	22 51       	R4 = R2 + R4;
8d4e0b6a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0b6e:	14 33 00 00 
8d4e0b72:	23 e1 7c 00 	R3 = 0x7c (X);		/*		R3=0x7c(124) */
8d4e0b76:	04 cc 33 00 	R0 = R6 + R3 (NS) || [FP -0x4] = R0 || NOP;
8d4e0b7a:	f0 bb 00 00 
8d4e0b7e:	0e 30       	R1 = R6;
8d4e0b80:	06 e3 98 1b 	CALL 0x0x8d5a42b0;
8d4e0b84:	4f 30       	R1 = FP;
8d4e0b86:	21 66       	R1 += -0x3c;		/* (-60) */
8d4e0b88:	01 30       	R0 = R1;
8d4e0b8a:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e0b8c:	06 e3 a2 1a 	CALL 0x0x8d5a40d0;
8d4e0b90:	56 30       	R2 = SP;
8d4e0b92:	23 e1 30 01 	R3 = 0x130 (X);		/*		R3=0x130(304) */
8d4e0b96:	5a 50       	R1 = R2 + R3;
8d4e0b98:	01 30       	R0 = R1;
8d4e0b9a:	a0 67       	R0 += -0xc;		/* (-12) */
8d4e0b9c:	00 de 05 8c 	CALL.A 0x8c0519e4;
8d4e0ba0:	e4 19 00 00 
8d4e0ba4:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x4] || NOP;
8d4e0ba8:	f0 b9 00 00 
8d4e0bac:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0bb0:	10 1b 00 00 
8d4e0bb4:	04 30       	R0 = R4;
8d4e0bb6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0bba:	38 1a 00 00 
8d4e0bbe:	00 b9       	R0 = [FP -0x40];
8d4e0bc0:	82 60       	R2 = 0x10 (X);		/*		R2=0x1a0(416) */
8d4e0bc2:	02 0a       	CC = R2 <= R0 (IU);
8d4e0bc4:	3f 18       	IF CC JUMP 0x0x8d4e0c42;
8d4e0bc6:	03 c8 00 18 	MNOP || R0 = [FP -0x24] || [FP -0x44] = R5;
8d4e0bca:	70 b9 f5 ba 
8d4e0bce:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0bd0:	7a 60       	R2 = 0xf (X);		/*		R2=0x1a0(416) */
8d4e0bd2:	01 0a       	CC = R1 <= R0 (IU);
8d4e0bd4:	b5 e6 34 01 	B[SP + 0x134] = R5;
8d4e0bd8:	03 c8 00 18 	MNOP || [FP -0x40] = R2 || R0 = [FP -0x38];
8d4e0bdc:	02 bb 20 b9 
8d4e0be0:	2e 18       	IF CC JUMP 0x0x8d4e0c3c;
8d4e0be2:	7a 60       	R2 = 0xf (X);		/*		R2=0x1a0(416) */
8d4e0be4:	20 e1 a4 ff 	R0 = -0x5c (X);		/*		R0=0xffffffa4(-92) */
8d4e0be8:	b5 e6 50 01 	B[SP + 0x150] = R5;
8d4e0bec:	04 cc 38 00 	R0 = R7 + R0 (NS) || [FP -0x28] = R5 || NOP;
8d4e0bf0:	65 bb 00 00 
8d4e0bf4:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [FP -0x24] = R2 || NOP;
8d4e0bf8:	72 bb 00 00 
8d4e0bfc:	00 de 05 8c 	CALL.A 0x8c0531e4;
8d4e0c00:	e4 31 00 00 
8d4e0c04:	30 e4 3a 00 	R0 = [SP + 0xe8];
8d4e0c08:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0c0a:	01 0a       	CC = R1 <= R0 (IU);
8d4e0c0c:	12 18       	IF CC JUMP 0x0x8d4e0c30;
8d4e0c0e:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0c10:	30 e6 3a 00 	[SP + 0xe8] = R0;
8d4e0c14:	35 e6 39 00 	[SP + 0xe4] = R5;
8d4e0c18:	b5 e6 d4 00 	B[SP + 0xd4] = R5;
8d4e0c1c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R6 = [FP + 0xc] || NOP;
8d4e0c20:	fe a0 00 00 
8d4e0c24:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0c28:	38 1a 00 00 
8d4e0c2c:	5f 2f       	JUMP.S 0x0x8d4e0aea;
8d4e0c2e:	00 00       	NOP;
8d4e0c30:	30 e4 35 00 	R0 = [SP + 0xd4];
8d4e0c34:	ff e3 d8 6b 	CALL 0x0x8d4ce3e4;
8d4e0c38:	eb 2f       	JUMP.S 0x0x8d4e0c0e;
8d4e0c3a:	00 00       	NOP;
8d4e0c3c:	ff e3 d4 6b 	CALL 0x0x8d4ce3e4;
8d4e0c40:	d1 2f       	JUMP.S 0x0x8d4e0be2;
8d4e0c42:	b0 b8       	R0 = [FP -0x54];
8d4e0c44:	ff e3 d0 6b 	CALL 0x0x8d4ce3e4;
8d4e0c48:	bf 2f       	JUMP.S 0x0x8d4e0bc6;
8d4e0c4a:	06 30       	R0 = R6;
8d4e0c4c:	0e 30       	R1 = R6;
8d4e0c4e:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e0c50:	06 e3 30 1b 	CALL 0x0x8d5a42b0;
8d4e0c54:	4e 30       	R1 = SP;
8d4e0c56:	22 e1 ec 00 	R2 = 0xec (X);		/*		R2=0xec(236) */
8d4e0c5a:	91 50       	R2 = R1 + R2;
8d4e0c5c:	24 e1 88 ff 	R4 = -0x78 (X);		/*		R4=0xffffff88(-120) */
8d4e0c60:	62 50       	R1 = R2 + R4;
8d4e0c62:	23 e1 94 00 	R3 = 0x94 (X);		/*		R3=0x94(148) */
8d4e0c66:	19 50       	R0 = R1 + R3;
8d4e0c68:	ff e3 94 fd 	CALL 0x0x8d4e0790;
8d4e0c6c:	03 c8 00 18 	MNOP || R2 = [FP -0x68] || R1 = [FP -0x7c];
8d4e0c70:	62 b8 11 b8 
8d4e0c74:	84 60       	R4 = 0x10 (X);		/*		R4=0xffffff88(-120) */
8d4e0c76:	5e 30       	R3 = SP;
8d4e0c78:	20 e1 0c 01 	R0 = 0x10c (X);		/*		R0=0x10c(268) */
8d4e0c7c:	14 0a       	CC = R4 <= R2 (IU);
8d4e0c7e:	03 50       	R0 = R3 + R0;
8d4e0c80:	01 07       	IF CC R0 = R1;
8d4e0c82:	00 de 03 8c 	CALL.A 0x8c03e29c;
8d4e0c86:	9c e2 00 00 
8d4e0c8a:	00 0c       	CC = R0 == 0x0;
8d4e0c8c:	5c 10       	IF !CC JUMP 0x0x8d4e0d44;
8d4e0c8e:	32 e4 41 00 	R2 = [SP + 0x104];
8d4e0c92:	83 60       	R3 = 0x10 (X);		/*		R3=0x94(148) */
8d4e0c94:	13 0a       	CC = R3 <= R2 (IU);
8d4e0c96:	4e 30       	R1 = SP;
8d4e0c98:	24 e1 0c 01 	R4 = 0x10c (X);		/*		R4=0x10c(268) */
8d4e0c9c:	46 30       	R0 = SP;
8d4e0c9e:	22 e1 f0 00 	R2 = 0xf0 (X);		/*		R2=0xf0(240) */
8d4e0ca2:	04 cc 0c 02 	R1 = R1 + R4 (NS) || R3 = [FP -0x68] || NOP;
8d4e0ca6:	63 b8 00 00 
8d4e0caa:	04 cc 02 00 	R0 = R0 + R2 (NS) || R2 = [FP -0x7c] || NOP;
8d4e0cae:	12 b8 00 00 
8d4e0cb2:	34 e4 3c 00 	R4 = [SP + 0xf0];
8d4e0cb6:	04 07       	IF CC R0 = R4;
8d4e0cb8:	84 60       	R4 = 0x10 (X);		/*		R4=0x10c(268) */
8d4e0cba:	1c 0a       	CC = R4 <= R3 (IU);
8d4e0cbc:	0a 07       	IF CC R1 = R2;
8d4e0cbe:	02 60       	R2 = 0x0 (X);		/*		R2=0xf0(240) */
8d4e0cc0:	00 de 03 8c 	CALL.A 0x8c03e0e4;
8d4e0cc4:	e4 e0 00 00 
8d4e0cc8:	00 0c       	CC = R0 == 0x0;
8d4e0cca:	3d 10       	IF !CC JUMP 0x0x8d4e0d44;
8d4e0ccc:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e0cd0:	fc 1e 00 00 
8d4e0cd4:	98 0c       	CC = R0 < 0x3;
8d4e0cd6:	2a 10       	IF !CC JUMP 0x0x8d4e0d2a;
8d4e0cd8:	60 b8       	R0 = [FP -0x68];
8d4e0cda:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0cdc:	01 0a       	CC = R1 <= R0 (IU);
8d4e0cde:	22 18       	IF CC JUMP 0x0x8d4e0d22;
8d4e0ce0:	78 60       	R0 = 0xf (X);		/*		R0=0x10c(268) */
8d4e0ce2:	60 ba       	[FP -0x68] = R0;
8d4e0ce4:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0ce6:	30 e4 41 00 	R0 = [SP + 0x104];
8d4e0cea:	01 0a       	CC = R1 <= R0 (IU);
8d4e0cec:	55 ba       	[FP -0x6c] = R5;
8d4e0cee:	b5 e6 0c 01 	B[SP + 0x10c] = R5;
8d4e0cf2:	13 18       	IF CC JUMP 0x0x8d4e0d18;
8d4e0cf4:	78 60       	R0 = 0xf (X);		/*		R0=0x10c(268) */
8d4e0cf6:	30 e6 41 00 	[SP + 0x104] = R0;
8d4e0cfa:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0cfc:	30 e4 3a 00 	R0 = [SP + 0xe8];
8d4e0d00:	01 0a       	CC = R1 <= R0 (IU);
8d4e0d02:	35 e6 40 00 	[SP + 0x100] = R5;
8d4e0d06:	b5 e6 f0 00 	B[SP + 0xf0] = R5;
8d4e0d0a:	82 17       	IF !CC JUMP 0x0x8d4e0c0e (BP);
8d4e0d0c:	30 e4 35 00 	R0 = [SP + 0xd4];
8d4e0d10:	ff e3 6a 6b 	CALL 0x0x8d4ce3e4;
8d4e0d14:	7d 2f       	JUMP.S 0x0x8d4e0c0e;
8d4e0d16:	00 00       	NOP;
8d4e0d18:	30 e4 3c 00 	R0 = [SP + 0xf0];
8d4e0d1c:	ff e3 64 6b 	CALL 0x0x8d4ce3e4;
8d4e0d20:	ea 2f       	JUMP.S 0x0x8d4e0cf4;
8d4e0d22:	10 b8       	R0 = [FP -0x7c];
8d4e0d24:	ff e3 60 6b 	CALL 0x0x8d4ce3e4;
8d4e0d28:	dc 2f       	JUMP.S 0x0x8d4e0ce0;
8d4e0d2a:	f5 bc       	[SP + 0xc] = P5;
8d4e0d2c:	22 e1 79 02 	R2 = 0x279 (X);		/*		R2=0x279(633) */
8d4e0d30:	01 da 03 84 	R1=-2080152232;
8d4e0d34:	58 65 00 00 
8d4e0d38:	18 60       	R0 = 0x3 (X);		/*		R0=0x10c(268) */
8d4e0d3a:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e0d3e:	74 05 00 00 
8d4e0d42:	cb 2f       	JUMP.S 0x0x8d4e0cd8;
8d4e0d44:	46 30       	R0 = SP;
8d4e0d46:	22 e1 9c 00 	R2 = 0x9c (X);		/*		R2=0x9c(156) */
8d4e0d4a:	04 cc 02 08 	R4 = R0 + R2 (NS) || R1 = [FP + 0x10] || NOP;
8d4e0d4e:	39 a1 00 00 
8d4e0d52:	07 30       	R0 = R7;
8d4e0d54:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0d58:	14 33 00 00 
8d4e0d5c:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [FP -0x4] = R0 || NOP;
8d4e0d60:	f0 bb 00 00 
8d4e0d64:	c6 66       	R6 += -0x28;		/* (-40) */
8d4e0d66:	06 30       	R0 = R6;
8d4e0d68:	06 e3 a6 1c 	CALL 0x0x8d5a46b4;
8d4e0d6c:	56 30       	R2 = SP;
8d4e0d6e:	23 e1 a8 00 	R3 = 0xa8 (X);		/*		R3=0xa8(168) */
8d4e0d72:	5a 50       	R1 = R2 + R3;
8d4e0d74:	01 30       	R0 = R1;
8d4e0d76:	a0 67       	R0 += -0xc;		/* (-12) */
8d4e0d78:	00 de 05 8c 	CALL.A 0x8c0519e4;
8d4e0d7c:	e4 19 00 00 
8d4e0d80:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x4] || NOP;
8d4e0d84:	f0 b9 00 00 
8d4e0d88:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0d8c:	10 1b 00 00 
8d4e0d90:	04 30       	R0 = R4;
8d4e0d92:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0d96:	38 1a 00 00 
8d4e0d9a:	30 e4 30 00 	R0 = [SP + 0xc0];
8d4e0d9e:	82 60       	R2 = 0x10 (X);		/*		R2=0x9c(156) */
8d4e0da0:	02 0a       	CC = R2 <= R0 (IU);
8d4e0da2:	39 18       	IF CC JUMP 0x0x8d4e0e14;
8d4e0da4:	7a 60       	R2 = 0xf (X);		/*		R2=0x9c(156) */
8d4e0da6:	20 e1 a4 ff 	R0 = -0x5c (X);		/*		R0=0xffffffa4(-92) */
8d4e0daa:	35 e6 2f 00 	[SP + 0xbc] = R5;
8d4e0dae:	b5 e6 ac 00 	B[SP + 0xac] = R5;
8d4e0db2:	32 e6 30 00 	[SP + 0xc0] = R2;
8d4e0db6:	07 50       	R0 = R7 + R0;
8d4e0db8:	0f 30       	R1 = R7;
8d4e0dba:	00 de 05 8c 	CALL.A 0x8c0531e4;
8d4e0dbe:	e4 31 00 00 
8d4e0dc2:	60 b8       	R0 = [FP -0x68];
8d4e0dc4:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0dc6:	01 0a       	CC = R1 <= R0 (IU);
8d4e0dc8:	21 18       	IF CC JUMP 0x0x8d4e0e0a;
8d4e0dca:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0dcc:	60 ba       	[FP -0x68] = R0;
8d4e0dce:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0dd0:	30 e4 41 00 	R0 = [SP + 0x104];
8d4e0dd4:	01 0a       	CC = R1 <= R0 (IU);
8d4e0dd6:	55 ba       	[FP -0x6c] = R5;
8d4e0dd8:	b5 e6 0c 01 	B[SP + 0x10c] = R5;
8d4e0ddc:	12 18       	IF CC JUMP 0x0x8d4e0e00;
8d4e0dde:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0de0:	30 e6 41 00 	[SP + 0x104] = R0;
8d4e0de4:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0de6:	30 e4 3a 00 	R0 = [SP + 0xe8];
8d4e0dea:	01 0a       	CC = R1 <= R0 (IU);
8d4e0dec:	35 e6 40 00 	[SP + 0x100] = R5;
8d4e0df0:	b5 e6 f0 00 	B[SP + 0xf0] = R5;
8d4e0df4:	0d 17       	IF !CC JUMP 0x0x8d4e0c0e (BP);
8d4e0df6:	30 e4 35 00 	R0 = [SP + 0xd4];
8d4e0dfa:	ff e3 f5 6a 	CALL 0x0x8d4ce3e4;
8d4e0dfe:	08 2f       	JUMP.S 0x0x8d4e0c0e;
8d4e0e00:	30 e4 3c 00 	R0 = [SP + 0xf0];
8d4e0e04:	ff e3 f0 6a 	CALL 0x0x8d4ce3e4;
8d4e0e08:	eb 2f       	JUMP.S 0x0x8d4e0dde;
8d4e0e0a:	10 b8       	R0 = [FP -0x7c];
8d4e0e0c:	ff e3 ec 6a 	CALL 0x0x8d4ce3e4;
8d4e0e10:	dd 2f       	JUMP.S 0x0x8d4e0dca;
8d4e0e12:	00 00       	NOP;
8d4e0e14:	30 e4 2b 00 	R0 = [SP + 0xac];
8d4e0e18:	ff e3 e6 6a 	CALL 0x0x8d4ce3e4;
8d4e0e1c:	c4 2f       	JUMP.S 0x0x8d4e0da4;
8d4e0e1e:	46 30       	R0 = SP;
8d4e0e20:	22 e1 90 00 	R2 = 0x90 (X);		/*		R2=0x90(144) */
8d4e0e24:	04 cc 02 0c 	R6 = R0 + R2 (NS) || R1 = [FP -0xc] || NOP;
8d4e0e28:	d1 b9 00 00 
8d4e0e2c:	06 30       	R0 = R6;
8d4e0e2e:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4e0e32:	f0 2b 00 00 
8d4e0e36:	06 30       	R0 = R6;
8d4e0e38:	01 da 03 84 	R1=-2080152784;
8d4e0e3c:	30 63 00 00 
8d4e0e40:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0e44:	14 33 00 00 
8d4e0e48:	e1 b9       	R1 = [FP -0x8];
8d4e0e4a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0e4e:	10 1b 00 00 
8d4e0e52:	7c 60       	R4 = 0xf (X);		/*		R4=0x10c(268) */
8d4e0e54:	56 30       	R2 = SP;
8d4e0e56:	23 e1 40 00 	R3 = 0x40 (X);		/*		R3=0x40( 64) */
8d4e0e5a:	34 e6 16 00 	[SP + 0x58] = R4;
8d4e0e5e:	da 51       	R7 = R2 + R3;
8d4e0e60:	01 da 03 84 	R1=-2080152784;
8d4e0e64:	30 63 00 00 
8d4e0e68:	24 e1 0c 02 	R4 = 0x20c (X);		/*		R4=0x20c(524) */
8d4e0e6c:	35 e6 15 00 	[SP + 0x54] = R5;
8d4e0e70:	b5 e6 44 00 	B[SP + 0x44] = R5;
8d4e0e74:	61 50       	R1 = R1 + R4;
8d4e0e76:	07 30       	R0 = R7;
8d4e0e78:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e0e7c:	76 a3 00 00 
8d4e0e80:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x10] || NOP;
8d4e0e84:	c1 b9 00 00 
8d4e0e88:	17 30       	R2 = R7;
8d4e0e8a:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e0e8c:	ff e3 82 fc 	CALL 0x0x8d4e0790;
8d4e0e90:	23 e1 94 ff 	R3 = -0x6c (X);		/*		R3=0xffffff94(-108) */
8d4e0e94:	1e 50       	R0 = R6 + R3;
8d4e0e96:	0e 30       	R1 = R6;
8d4e0e98:	00 de 03 8c 	CALL.A 0x8c03f624;
8d4e0e9c:	24 f6 00 00 
8d4e0ea0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [SP + 0x3c] || NOP;
8d4e0ea4:	f0 a3 00 00 
8d4e0ea8:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0eaa:	01 0a       	CC = R1 <= R0 (IU);
8d4e0eac:	41 18       	IF CC JUMP 0x0x8d4e0f2e;
8d4e0eae:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0eb0:	f0 b3       	[SP + 0x3c] = R0;
8d4e0eb2:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0eb4:	30 e4 16 00 	R0 = [SP + 0x58];
8d4e0eb8:	01 0a       	CC = R1 <= R0 (IU);
8d4e0eba:	b5 b3       	[SP + 0x38] = R5;
8d4e0ebc:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4e0ec0:	32 18       	IF CC JUMP 0x0x8d4e0f24;
8d4e0ec2:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0ec4:	30 e6 16 00 	[SP + 0x58] = R0;
8d4e0ec8:	35 e6 15 00 	[SP + 0x54] = R5;
8d4e0ecc:	b5 e6 44 00 	B[SP + 0x44] = R5;
8d4e0ed0:	06 30       	R0 = R6;
8d4e0ed2:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0ed6:	38 1a 00 00 
8d4e0eda:	30 e4 23 00 	R0 = [SP + 0x8c];
8d4e0ede:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0ee0:	01 0a       	CC = R1 <= R0 (IU);
8d4e0ee2:	1b 18       	IF CC JUMP 0x0x8d4e0f18;
8d4e0ee4:	04 cc 09 42 	R1 = R1 - R1 (NS) || R0 = [FP -0x8] || NOP;
8d4e0ee8:	e0 b9 00 00 
8d4e0eec:	7a 60       	R2 = 0xf (X);		/*		R2=0x90(144) */
8d4e0eee:	31 e6 22 00 	[SP + 0x88] = R1;
8d4e0ef2:	b1 e6 78 00 	B[SP + 0x78] = R1;
8d4e0ef6:	32 e6 23 00 	[SP + 0x8c] = R2;
8d4e0efa:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0efe:	38 1a 00 00 
8d4e0f02:	b8 a0       	R0 = [FP + 0x8];
8d4e0f04:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0f08:	38 1a 00 00 
8d4e0f0c:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e0f0e:	07 30       	R0 = R7;
8d4e0f10:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e0f12:	01 e8 00 00 	UNLINK;
8d4e0f16:	10 00       	RTS;
8d4e0f18:	30 e4 1e 00 	R0 = [SP + 0x78];
8d4e0f1c:	ff e3 64 6a 	CALL 0x0x8d4ce3e4;
8d4e0f20:	e2 2f       	JUMP.S 0x0x8d4e0ee4;
8d4e0f22:	00 00       	NOP;
8d4e0f24:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e0f28:	ff e3 5e 6a 	CALL 0x0x8d4ce3e4;
8d4e0f2c:	cb 2f       	JUMP.S 0x0x8d4e0ec2;
8d4e0f2e:	b0 a2       	R0 = [SP + 0x28];
8d4e0f30:	ff e3 5a 6a 	CALL 0x0x8d4ce3e4;
8d4e0f34:	bd 2f       	JUMP.S 0x0x8d4e0eae;
8d4e0f36:	00 00       	NOP;
8d4e0f38:	31 e4 23 00 	R1 = [SP + 0x8c];
8d4e0f3c:	83 60       	R3 = 0x10 (X);		/*		R3=0xffffff94(-108) */
8d4e0f3e:	46 30       	R0 = SP;
8d4e0f40:	0b 0a       	CC = R3 <= R1 (IU);
8d4e0f42:	30 50       	R0 = R0 + R6;
8d4e0f44:	32 e4 1e 00 	R2 = [SP + 0x78];
8d4e0f48:	02 07       	IF CC R0 = R2;
8d4e0f4a:	00 de 03 8c 	CALL.A 0x8c03e06c;
8d4e0f4e:	6c e0 00 00 
8d4e0f52:	00 0c       	CC = R0 == 0x0;
8d4e0f54:	02 18       	IF CC JUMP 0x0x8d4e0f58;
8d4e0f56:	c1 2d       	JUMP.S 0x0x8d4e0ad8;
8d4e0f58:	30 e4 23 00 	R0 = [SP + 0x8c];
8d4e0f5c:	81 60       	R1 = 0x10 (X);		/*		R1=0x118(280) */
8d4e0f5e:	01 0a       	CC = R1 <= R0 (IU);
8d4e0f60:	c2 17       	IF !CC JUMP 0x0x8d4e0ee4 (BP);
8d4e0f62:	30 e4 1e 00 	R0 = [SP + 0x78];
8d4e0f66:	ff e3 3f 6a 	CALL 0x0x8d4ce3e4;
8d4e0f6a:	bd 2f       	JUMP.S 0x0x8d4e0ee4;
8d4e0f6c:	00 00       	NOP;
8d4e0f6e:	00 00       	NOP;
