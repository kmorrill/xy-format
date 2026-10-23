
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d4fff44 <.data+0x33f24>:
8d4fff44:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d4fff48:	e5 05       	[--SP] = (R7:4, P5:5);
8d4fff4a:	28 32       	P5 = R0;
8d4fff4c:	6f 30       	R5 = FP;
8d4fff4e:	26 6f       	SP += -0x1c;		/* (-28) */
8d4fff50:	25 67       	R5 += -0x1c;		/* (-28) */
8d4fff52:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [FP + 0xc] = R0 || NOP;
8d4fff56:	f8 b0 00 00 
8d4fff5a:	af e6 2c 00 	B[P5 + 0x2c] = R7;
8d4fff5e:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP + 0x8] = R7 || NOP;
8d4fff62:	bf b0 00 00 
8d4fff66:	77 30       	R6 = FP;
8d4fff68:	21 30       	R4 = R1;
8d4fff6a:	00 de 03 8c 	CALL.A 0x8c03ee00;
8d4fff6e:	00 ee 00 00 
8d4fff72:	46 64       	R6 += 0x8;		/* (  8) */
8d4fff74:	0d 30       	R1 = R5;
8d4fff76:	06 30       	R0 = R6;
8d4fff78:	ff e3 9e b3 	CALL 0x0x8d4f66b4;
8d4fff7c:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R1 = [FP -0x4] || R0 = [SP + 0x34];
8d4fff80:	f1 b9 70 a3 
8d4fff84:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8d4fff86:	0a 0a       	CC = R2 <= R1 (IU);
8d4fff88:	d6 18       	IF CC JUMP 0x0x8d500134;
8d4fff8a:	05 0c       	CC = R5 == 0x0;
8d4fff8c:	e7 bb       	[FP -0x8] = R7;
8d4fff8e:	b7 e6 34 00 	B[SP + 0x34] = R7;
8d4fff92:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d4fff94:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x4] = R0 || NOP;
8d4fff98:	f0 bb 00 00 
8d4fff9c:	22 10       	IF !CC JUMP 0x0x8d4fffe0;
8d4fff9e:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4fffa2:	fc 1e 00 00 
8d4fffa6:	88 0c       	CC = R0 < 0x1;
8d4fffa8:	0a 10       	IF !CC JUMP 0x0x8d4fffbc;
8d4fffaa:	06 30       	R0 = R6;
8d4fffac:	ff e3 37 af 	CALL 0x0x8d4f5e1a;
8d4fffb0:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4fffb2:	07 30       	R0 = R7;
8d4fffb4:	a5 05       	(R7:4, P5:5) = [SP++];
8d4fffb6:	01 e8 00 00 	UNLINK;
8d4fffba:	10 00       	RTS;
8d4fffbc:	34 b1       	[SP + 0x10] = R4;
8d4fffbe:	09 da 04 84 	P1=-2080095464;
8d4fffc2:	18 43 00 00 
8d4fffc6:	f1 bc       	[SP + 0xc] = P1;
8d4fffc8:	22 e1 a3 00 	R2 = 0xa3 (X);		/*		R2=0xa3(163) */
8d4fffcc:	01 da 04 84 	R1=-2080095432;
8d4fffd0:	38 43 00 00 
8d4fffd4:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4fffd6:	00 de 04 8c 	CALL.A 0x8c040574;
8d4fffda:	74 05 00 00 
8d4fffde:	e6 2f       	JUMP.S 0x0x8d4fffaa;
8d4fffe0:	ff e3 e0 ae 	CALL 0x0x8d4f5da0;
8d4fffe4:	88 0c       	CC = R0 < 0x1;
8d4fffe6:	03 18       	IF CC JUMP 0x0x8d4fffec;
8d4fffe8:	10 0d       	CC = R0 <= 0x2;
8d4fffea:	1a 18       	IF CC JUMP 0x0x8d50001e;
8d4fffec:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0001;
8d4ffff0:	fc 1e 01 00 
8d4ffff4:	89 0c       	CC = R1 < 0x1;
8d4ffff6:	da 1f       	IF CC JUMP 0x0x8d4fffaa (BP);
8d4ffff8:	70 b1       	[SP + 0x14] = R0;
8d4ffffa:	34 b1       	[SP + 0x10] = R4;
8d4ffffc:	09 da 04 84 	P1=-2080095400;
8d500000:	58 43 00 00 
8d500004:	f1 bc       	[SP + 0xc] = P1;
8d500006:	22 e1 a9 00 	R2 = 0xa9 (X);		/*		R2=0xa9(169) */
8d50000a:	01 da 04 84 	R1=-2080095432;
8d50000e:	38 43 00 00 
8d500012:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d500014:	00 de 04 8c 	CALL.A 0x8c040574;
8d500018:	74 05 00 00 
8d50001c:	c7 2f       	JUMP.S 0x0x8d4fffaa;
8d50001e:	10 0c       	CC = R0 == 0x2;
8d500020:	00 02       	R0 = CC;
8d500022:	a8 e6 3c 00 	B[P5 + 0x3c] = R0;
8d500026:	06 30       	R0 = R6;
8d500028:	ff e3 af ae 	CALL 0x0x8d4f5d86;
8d50002c:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [P5 + 0x30] = R0 || NOP;
8d500030:	28 b3 00 00 
8d500034:	ff e3 9c ae 	CALL 0x0x8d4f5d6c;
8d500038:	03 c8 00 18 	MNOP || [P5 + 0x38] = R0 || R0 = [P5 + 0x30];
8d50003c:	a8 b3 28 a3 
8d500040:	05 da 0d 00 	R5=882000;
8d500044:	50 75 00 00 
8d500048:	85 09       	CC = R5 < R0 (IU);
8d50004a:	0a 10       	IF !CC JUMP 0x0x8d50005e;
8d50004c:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0001;
8d500050:	fc 1e 01 00 
8d500054:	89 0c       	CC = R1 < 0x1;
8d500056:	55 10       	IF !CC JUMP 0x0x8d500100;
8d500058:	07 c4 05 40 	R0 = MIN (R0, R5);
8d50005c:	28 b3       	[P5 + 0x30] = R0;
8d50005e:	06 30       	R0 = R6;
8d500060:	ff e3 79 ae 	CALL 0x0x8d4f5d52;
8d500064:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d500068:	f8 a0 00 00 
8d50006c:	ff e3 14 ff 	CALL 0x0x8d4ffe94;
8d500070:	00 0c       	CC = R0 == 0x0;
8d500072:	19 10       	IF !CC JUMP 0x0x8d5000a4;
8d500074:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d500078:	fc 1e 00 00 
8d50007c:	88 0c       	CC = R0 < 0x1;
8d50007e:	96 1f       	IF CC JUMP 0x0x8d4fffaa (BP);
8d500080:	34 b1       	[SP + 0x10] = R4;
8d500082:	09 da 04 84 	P1=-2080095336;
8d500086:	98 43 00 00 
8d50008a:	f1 bc       	[SP + 0xc] = P1;
8d50008c:	22 e1 b8 00 	R2 = 0xb8 (X);		/*		R2=0xb8(184) */
8d500090:	01 da 04 84 	R1=-2080095432;
8d500094:	38 43 00 00 
8d500098:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d50009a:	00 de 04 8c 	CALL.A 0x8c040574;
8d50009e:	74 05 00 00 
8d5000a2:	84 2f       	JUMP.S 0x0x8d4fffaa;
8d5000a4:	a8 e4 3c 00 	R0 = B[P5 + 0x3c] (Z);
8d5000a8:	00 0c       	CC = R0 == 0x0;
8d5000aa:	10 60       	R0 = 0x2 (X);		/*		R0=0x0(  0) */
8d5000ac:	0a 60       	R2 = 0x1 (X);		/*		R2=0xb8(184) */
8d5000ae:	10 06       	IF !CC R2 = R0;
8d5000b0:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R3 = [P5 + 0x30] || R1 = [P5 + 0x4];
8d5000b4:	2b a3 69 a0 
8d5000b8:	71 c2 53 21 	R5 = R2 * R3 (IS,NS);
8d5000bc:	15 30       	R2 = R5;
8d5000be:	ff e3 3d ae 	CALL 0x0x8d4f5d38;
8d5000c2:	05 08       	CC = R5 == R0;
8d5000c4:	1b 18       	IF CC JUMP 0x0x8d5000fa;
8d5000c6:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5000ca:	fc 1e 00 00 
8d5000ce:	88 0c       	CC = R0 < 0x1;
8d5000d0:	03 10       	IF !CC JUMP 0x0x8d5000d6;
8d5000d2:	6f b3       	[P5 + 0x34] = R7;
8d5000d4:	6b 2f       	JUMP.S 0x0x8d4fffaa;
8d5000d6:	34 b1       	[SP + 0x10] = R4;
8d5000d8:	09 da 04 84 	P1=-2080095296;
8d5000dc:	c0 43 00 00 
8d5000e0:	f1 bc       	[SP + 0xc] = P1;
8d5000e2:	22 e1 c0 00 	R2 = 0xc0 (X);		/*		R2=0xc0(192) */
8d5000e6:	01 da 04 84 	R1=-2080095432;
8d5000ea:	38 43 00 00 
8d5000ee:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d5000f0:	00 de 04 8c 	CALL.A 0x8c040574;
8d5000f4:	74 05 00 00 
8d5000f8:	ed 2f       	JUMP.S 0x0x8d5000d2;
8d5000fa:	68 b3       	[P5 + 0x34] = R0;
8d5000fc:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8d5000fe:	56 2f       	JUMP.S 0x0x8d4fffaa;
8d500100:	70 b1       	[SP + 0x14] = R0;
8d500102:	34 b1       	[SP + 0x10] = R4;
8d500104:	09 da 0d 00 	P1=882000;
8d500108:	50 75 00 00 
8d50010c:	b1 bd       	[SP + 0x18] = P1;
8d50010e:	09 da 04 84 	P1=-2080095368;
8d500112:	78 43 00 00 
8d500116:	f1 bc       	[SP + 0xc] = P1;
8d500118:	22 e1 b2 00 	R2 = 0xb2 (X);		/*		R2=0xb2(178) */
8d50011c:	01 da 04 84 	R1=-2080095432;
8d500120:	38 43 00 00 
8d500124:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d500126:	00 de 04 8c 	CALL.A 0x8c040574;
8d50012a:	74 05 00 00 
8d50012e:	28 a3       	R0 = [P5 + 0x30];
8d500130:	94 2f       	JUMP.S 0x0x8d500058;
8d500132:	00 00       	NOP;
8d500134:	fe e3 58 71 	CALL 0x0x8d4ce3e4;
8d500138:	29 2f       	JUMP.S 0x0x8d4fff8a;
8d50013a:	09 32       	P1 = R1;
8d50013c:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d500140:	82 60       	R2 = 0x10 (X);		/*		R2=0xb2(178) */
8d500142:	21 64       	R1 += 0x4;		/* (  4) */
8d500144:	8b a1       	R3 = [P1 + 0x18];
8d500146:	09 32       	P1 = R1;
8d500148:	1a 0a       	CC = R2 <= R3 (IU);
8d50014a:	02 10       	IF !CC JUMP 0x0x8d50014e;
8d50014c:	09 91       	R1 = [P1];
8d50014e:	ff e3 fb fe 	CALL 0x0x8d4fff44;
8d500152:	01 e8 00 00 	UNLINK;
8d500156:	10 00       	RTS;
