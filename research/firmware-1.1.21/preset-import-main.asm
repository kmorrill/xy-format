
os.ldr@0x8d4dce40:     file format binary


Disassembly of section .data:

8d4dce40 <.data>:
8d4dce40:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4dce44:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d4dce48:	f7 b0 00 00 
8d4dce4c:	00 de 05 8c 	CALL.A 0x8c05101a;
8d4dce50:	1a 10 00 00 
8d4dce54:	00 0c       	CC = R0 == 0x0;
8d4dce56:	0d 10       	IF !CC JUMP 0x0x8d4dce70;
8d4dce58:	07 30       	R0 = R7;
8d4dce5a:	00 de 05 8c 	CALL.A 0x8c051042;
8d4dce5e:	42 10 00 00 
8d4dce62:	00 0c       	CC = R0 == 0x0;
8d4dce64:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4dce66:	05 10       	IF !CC JUMP 0x0x8d4dce70;
8d4dce68:	f7 a0       	R7 = [SP + 0xc];
8d4dce6a:	01 e8 00 00 	UNLINK;
8d4dce6e:	10 00       	RTS;
8d4dce70:	07 30       	R0 = R7;
8d4dce72:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4dce76:	88 1d 00 00 
8d4dce7a:	82 ce 80 80 	R0 = R0 << 0x10 || R7 = [SP + 0xc] || NOP;
8d4dce7e:	f7 a0 00 00 
8d4dce82:	01 e8 00 00 	UNLINK;
8d4dce86:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4dce88:	07 c4 01 00 	R0 = MAX (R0, R1);
8d4dce8c:	10 00       	RTS;
8d4dce8e:	00 00       	NOP;
8d4dce90:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4dce94:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d4dce98:	f7 b0 00 00 
8d4dce9c:	00 de 05 8c 	CALL.A 0x8c05101a;
8d4dcea0:	1a 10 00 00 
8d4dcea4:	00 0c       	CC = R0 == 0x0;
8d4dcea6:	0d 10       	IF !CC JUMP 0x0x8d4dcec0;
8d4dcea8:	07 30       	R0 = R7;
8d4dceaa:	00 de 05 8c 	CALL.A 0x8c051042;
8d4dceae:	42 10 00 00 
8d4dceb2:	00 0c       	CC = R0 == 0x0;
8d4dceb4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4dceb6:	05 10       	IF !CC JUMP 0x0x8d4dcec0;
8d4dceb8:	f7 a0       	R7 = [SP + 0xc];
8d4dceba:	01 e8 00 00 	UNLINK;
8d4dcebe:	10 00       	RTS;
8d4dcec0:	07 30       	R0 = R7;
8d4dcec2:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4dcec6:	88 1d 00 00 
8d4dceca:	f7 a0       	R7 = [SP + 0xc];
8d4dcecc:	01 e8 00 00 	UNLINK;
8d4dced0:	10 00       	RTS;
8d4dced2:	00 00       	NOP;
8d4dced4:	00 00       	NOP;
8d4dced6:	00 00       	NOP;
8d4dced8:	00 e8 54 00 	LINK 0x150;		/* (336) */
8d4dcedc:	e3 05       	[--SP] = (R7:4, P5:3);
8d4dcede:	66 6f       	SP += -0x14;		/* (-20) */
8d4dcee0:	30 e6 15 00 	[SP + 0x54] = R0;
8d4dcee4:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [FP -0x4] = R1 || NOP;
8d4dcee8:	f1 bb 00 00 
8d4dceec:	ff e3 04 f7 	CALL 0x0x8d4dbcf4;
8d4dcef0:	04 e3 98 b1 	CALL 0x0x8d573220;
8d4dcef4:	08 32       	P1 = R0;
8d4dcef6:	34 e5 15 00 	P4 = [SP + 0x54];
8d4dcefa:	30 e6 13 00 	[SP + 0x4c] = R0;
8d4dcefe:	30 e6 14 00 	[SP + 0x50] = R0;
8d4dcf02:	76 30       	R6 = SP;
8d4dcf04:	20 e1 84 00 	R0 = 0x84 (X);		/*		R0=0x84(132) */
8d4dcf08:	21 e4 4a 00 	R1 = [P4 + 0x128];
8d4dcf0c:	04 cc 30 0c 	R6 = R6 + R0 (NS) || [P1 + 0x18] = R1 || NOP;
8d4dcf10:	89 b1 00 00 
8d4dcf14:	24 e1 64 01 	R4 = 0x164 (X);		/*		R4=0x164(356) */
8d4dcf18:	33 e4 15 00 	R3 = [SP + 0x54];
8d4dcf1c:	63 50       	R1 = R3 + R4;
8d4dcf1e:	06 30       	R0 = R6;
8d4dcf20:	02 da 03 84 	R2=-2080152856;
8d4dcf24:	e8 62 00 00 
8d4dcf28:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4dcf2c:	94 f1 00 00 
8d4dcf30:	06 30       	R0 = R6;
8d4dcf32:	25 e1 48 01 	R5 = 0x148 (X);		/*		R5=0x148(328) */
8d4dcf36:	33 e4 15 00 	R3 = [SP + 0x54];
8d4dcf3a:	ab 50       	R2 = R3 + R5;
8d4dcf3c:	0e 30       	R1 = R6;
8d4dcf3e:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4dcf40:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d4dcf44:	e4 f0 00 00 
8d4dcf48:	30 e4 27 00 	R0 = [SP + 0x9c];
8d4dcf4c:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d4dcf4e:	03 0a       	CC = R3 <= R0 (IU);
8d4dcf50:	02 14       	IF !CC JUMP 0x0x8d4dcf54 (BP);
8d4dcf52:	0f 25       	JUMP.S 0x0x8d4dd970;
8d4dcf54:	06 60       	R6 = 0x0 (X);		/*		R6=0x0(  0) */
8d4dcf56:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8d4dcf58:	36 e6 26 00 	[SP + 0x98] = R6;
8d4dcf5c:	b6 e6 88 00 	B[SP + 0x88] = R6;
8d4dcf60:	31 e6 27 00 	[SP + 0x9c] = R1;
8d4dcf64:	07 30       	R0 = R7;
8d4dcf66:	ff e3 c7 f6 	CALL 0x0x8d4dbcf4;
8d4dcf6a:	33 e4 2e 00 	R3 = [SP + 0xb8];
8d4dcf6e:	84 60       	R4 = 0x10 (X);		/*		R4=0x164(356) */
8d4dcf70:	1c 0a       	CC = R4 <= R3 (IU);
8d4dcf72:	25 e1 a4 00 	R5 = 0xa4 (X);		/*		R5=0xa4(164) */
8d4dcf76:	4e 30       	R1 = SP;
8d4dcf78:	27 e1 48 00 	R7 = 0x48 (X);		/*		R7=0x48( 72) */
8d4dcf7c:	32 e4 15 00 	R2 = [SP + 0x54];
8d4dcf80:	04 da 03 84 	R4=-2080152856;
8d4dcf84:	e8 62 00 00 
8d4dcf88:	69 50       	R1 = R1 + R5;
8d4dcf8a:	33 e4 29 00 	R3 = [SP + 0xa4];
8d4dcf8e:	fc 51       	R7 = R4 + R7;
8d4dcf90:	42 64       	R2 += 0x8;		/* (  8) */
8d4dcf92:	0b 07       	IF CC R1 = R3;
8d4dcf94:	37 e6 1f 00 	[SP + 0x7c] = R7;
8d4dcf98:	c2 bb       	[FP -0x10] = R2;
8d4dcf9a:	04 e3 e3 b1 	CALL 0x0x8d573360;
8d4dcf9e:	24 e1 4c 39 	R4 = 0x394c (X);		/*		R4=0x394c(14668) */
8d4dcfa2:	37 e4 13 00 	R7 = [SP + 0x4c];
8d4dcfa6:	27 50       	R0 = R7 + R4;
8d4dcfa8:	22 e1 00 0c 	R2 = 0xc00 (X);		/*		R2=0xc00(3072) */
8d4dcfac:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4dcfae:	28 32       	P5 = R0;
8d4dcfb0:	00 de 02 04 	CALL.A 0x04022ea8;
8d4dcfb4:	a8 2e 00 00 
8d4dcfb8:	31 e4 1f 00 	R1 = [SP + 0x7c];
8d4dcfbc:	c0 b9       	R0 = [FP -0x10];
8d4dcfbe:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4dcfc2:	c0 27 00 00 
8d4dcfc6:	00 0c       	CC = R0 == 0x0;
8d4dcfc8:	02 14       	IF !CC JUMP 0x0x8d4dcfcc (BP);
8d4dcfca:	a5 23       	JUMP.S 0x0x8d4dd714;
8d4dcfcc:	31 e4 1f 00 	R1 = [SP + 0x7c];
8d4dcfd0:	c0 b9       	R0 = [FP -0x10];
8d4dcfd2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dcfd6:	14 33 00 00 
8d4dcfda:	56 30       	R2 = SP;
8d4dcfdc:	23 e1 bc 00 	R3 = 0xbc (X);		/*		R3=0xbc(188) */
8d4dcfe0:	9a 50       	R2 = R2 + R3;
8d4dcfe2:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [FP -0x18] = R2 || NOP;
8d4dcfe6:	a2 bb 00 00 
8d4dcfea:	05 da 03 84 	R5=-2080152856;
8d4dcfee:	e8 62 00 00 
8d4dcff2:	04 da 03 84 	R4=-2080152856;
8d4dcff6:	e8 62 00 00 
8d4dcffa:	27 e1 01 07 	R7 = 0x701 (X);		/*		R7=0x701(1793) */
8d4dcffe:	a0 b9       	R0 = [FP -0x18];
8d4dd000:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4dd004:	f0 2b 00 00 
8d4dd008:	a0 b9       	R0 = [FP -0x18];
8d4dd00a:	00 de 05 8c 	CALL.A 0x8c050fe0;
8d4dd00e:	e0 0f 00 00 
8d4dd012:	00 0c       	CC = R0 == 0x0;
8d4dd014:	02 14       	IF !CC JUMP 0x0x8d4dd018 (BP);
8d4dd016:	7a 23       	JUMP.S 0x0x8d4dd70a;
8d4dd018:	20 e1 01 06 	R0 = 0x601 (X);		/*		R0=0x601(1537) */
8d4dd01c:	70 e6 34 00 	W[SP + 0x68] = R0;
8d4dd020:	22 e1 50 00 	R2 = 0x50 (X);		/*		R2=0x50( 80) */
8d4dd024:	23 e1 5c 00 	R3 = 0x5c (X);		/*		R3=0x5c( 92) */
8d4dd028:	20 e1 64 00 	R0 = 0x64 (X);		/*		R0=0x64(100) */
8d4dd02c:	95 50       	R2 = R5 + R2;
8d4dd02e:	dc 50       	R3 = R4 + R3;
8d4dd030:	05 50       	R0 = R5 + R0;
8d4dd032:	31 60       	R1 = 0x6 (X);		/*		R1=0x0(  0) */
8d4dd034:	32 e6 16 00 	[SP + 0x58] = R2;
8d4dd038:	33 e6 17 00 	[SP + 0x5c] = R3;
8d4dd03c:	30 e6 19 00 	[SP + 0x64] = R0;
8d4dd040:	71 e6 1e 00 	W[SP + 0x3c] = R1;
8d4dd044:	22 e1 7c 00 	R2 = 0x7c (X);		/*		R2=0x7c(124) */
8d4dd048:	23 e1 88 00 	R3 = 0x88 (X);		/*		R3=0x88(136) */
8d4dd04c:	00 da 03 84 	R0=-2080152856;
8d4dd050:	e8 62 00 00 
8d4dd054:	21 e1 6c 00 	R1 = 0x6c (X);		/*		R1=0x6c(108) */
8d4dd058:	95 50       	R2 = R5 + R2;
8d4dd05a:	04 cc 03 00 	R0 = R0 + R3 (NS) || [FP -0x1c] = R2 || NOP;
8d4dd05e:	92 bb 00 00 
8d4dd062:	04 cc 21 02 	R1 = R4 + R1 (NS) || [SP + 0x38] = R0 || NOP;
8d4dd066:	b0 b3 00 00 
8d4dd06a:	31 e6 18 00 	[SP + 0x60] = R1;
8d4dd06e:	25 e1 98 00 	R5 = 0x98 (X);		/*		R5=0x98(152) */
8d4dd072:	23 e1 b8 00 	R3 = 0xb8 (X);		/*		R3=0xb8(184) */
8d4dd076:	02 da 03 84 	R2=-2080152856;
8d4dd07a:	e8 62 00 00 
8d4dd07e:	24 e1 a8 00 	R4 = 0xa8 (X);		/*		R4=0xa8(168) */
8d4dd082:	00 da 03 84 	R0=-2080152856;
8d4dd086:	e8 62 00 00 
8d4dd08a:	01 da 03 84 	R1=-2080152856;
8d4dd08e:	e8 62 00 00 
8d4dd092:	a2 50       	R2 = R2 + R4;
8d4dd094:	18 50       	R0 = R0 + R3;
8d4dd096:	69 50       	R1 = R1 + R5;
8d4dd098:	32 e6 20 00 	[SP + 0x80] = R2;
8d4dd09c:	30 e6 1d 00 	[SP + 0x74] = R0;
8d4dd0a0:	31 e6 1b 00 	[SP + 0x6c] = R1;
8d4dd0a4:	24 e1 c8 00 	R4 = 0xc8 (X);		/*		R4=0xc8(200) */
8d4dd0a8:	23 e1 d4 00 	R3 = 0xd4 (X);		/*		R3=0xd4(212) */
8d4dd0ac:	25 e1 c0 00 	R5 = 0xc0 (X);		/*		R5=0xc0(192) */
8d4dd0b0:	02 da 03 84 	R2=-2080152856;
8d4dd0b4:	e8 62 00 00 
8d4dd0b8:	00 da 03 84 	R0=-2080152856;
8d4dd0bc:	e8 62 00 00 
8d4dd0c0:	01 da 03 84 	R1=-2080152856;
8d4dd0c4:	e8 62 00 00 
8d4dd0c8:	a2 50       	R2 = R2 + R4;
8d4dd0ca:	18 50       	R0 = R0 + R3;
8d4dd0cc:	04 cc 0d 02 	R1 = R1 + R5 (NS) || [FP -0x20] = R0 || NOP;
8d4dd0d0:	80 bb 00 00 
8d4dd0d4:	32 e6 1e 00 	[SP + 0x78] = R2;
8d4dd0d8:	31 e6 1c 00 	[SP + 0x70] = R1;
8d4dd0dc:	24 e1 e8 00 	R4 = 0xe8 (X);		/*		R4=0xe8(232) */
8d4dd0e0:	23 e1 f4 00 	R3 = 0xf4 (X);		/*		R3=0xf4(244) */
8d4dd0e4:	25 e1 e0 00 	R5 = 0xe0 (X);		/*		R5=0xe0(224) */
8d4dd0e8:	00 da 03 84 	R0=-2080152856;
8d4dd0ec:	e8 62 00 00 
8d4dd0f0:	02 da 03 84 	R2=-2080152856;
8d4dd0f4:	e8 62 00 00 
8d4dd0f8:	01 da 03 84 	R1=-2080152856;
8d4dd0fc:	e8 62 00 00 
8d4dd100:	18 50       	R0 = R0 + R3;
8d4dd102:	04 cc 14 04 	R2 = R2 + R4 (NS) || [SP + 0x34] = R0 || NOP;
8d4dd106:	70 b3 00 00 
8d4dd10a:	69 50       	R1 = R1 + R5;
8d4dd10c:	32 e6 12 00 	[SP + 0x48] = R2;
8d4dd110:	b1 bb       	[FP -0x14] = R1;
8d4dd112:	29 e1 9b ff 	P1 = -0x65 (X);		/*		P1=0xffffff9b(-101) */
8d4dd116:	23 e1 0c 01 	R3 = 0x10c (X);		/*		R3=0x10c(268) */
8d4dd11a:	24 e1 04 01 	R4 = 0x104 (X);		/*		R4=0x104(260) */
8d4dd11e:	00 da 03 84 	R0=-2080152856;
8d4dd122:	e8 62 00 00 
8d4dd126:	25 e1 00 01 	R5 = 0x100 (X);		/*		R5=0x100(256) */
8d4dd12a:	02 da 03 84 	R2=-2080152856;
8d4dd12e:	e8 62 00 00 
8d4dd132:	01 da 03 84 	R1=-2080152856;
8d4dd136:	e8 62 00 00 
8d4dd13a:	69 50       	R1 = R1 + R5;
8d4dd13c:	4d 5a       	P1 = P5 + P1;
8d4dd13e:	04 cc 03 00 	R0 = R0 + R3 (NS) || [FP + 0x10] = P1 || NOP;
8d4dd142:	39 bd 00 00 
8d4dd146:	04 cc 14 04 	R2 = R2 + R4 (NS) || [SP + 0x30] = R0 || NOP;
8d4dd14a:	30 b3 00 00 
8d4dd14e:	31 e6 11 00 	[SP + 0x44] = R1;
8d4dd152:	32 e6 10 00 	[SP + 0x40] = R2;
8d4dd156:	05 60       	R5 = 0x0 (X);		/*		R5=0x100(256) */
8d4dd158:	05 30       	R0 = R5;
8d4dd15a:	c1 60       	R1 = 0x18 (X);		/*		R1=0x6c(108) */
8d4dd15c:	08 64       	R0 += 0x1;		/* (  1) */
8d4dd15e:	8d 08       	CC = R5 < R1;
8d4dd160:	03 c8 00 18 	MNOP || [FP -0x8] = R0 || R0 = [FP -0x18];
8d4dd164:	e0 bb a0 b9 
8d4dd168:	02 1c       	IF CC JUMP 0x0x8d4dd16c (BP);
8d4dd16a:	d0 22       	JUMP.S 0x0x8d4dd70a;
8d4dd16c:	00 de 05 8c 	CALL.A 0x8c052382;
8d4dd170:	82 23 00 00 
8d4dd174:	28 0a       	CC = R0 <= R5 (IU);
8d4dd176:	02 14       	IF !CC JUMP 0x0x8d4dd17a (BP);
8d4dd178:	c9 22       	JUMP.S 0x0x8d4dd70a;
8d4dd17a:	56 30       	R2 = SP;
8d4dd17c:	23 e1 c8 00 	R3 = 0xc8 (X);		/*		R3=0xc8(200) */
8d4dd180:	31 e4 1f 00 	R1 = [SP + 0x7c];
8d4dd184:	04 cc 13 08 	R4 = R2 + R3 (NS) || R0 = [FP -0x10] || [FP + 0x8] = P5;
8d4dd188:	c0 b9 bd bc 
8d4dd18c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd190:	14 33 00 00 
8d4dd194:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || P3 = [FP + 0x10] || NOP;
8d4dd198:	3b ad 00 00 
8d4dd19c:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4dd1a0:	e4 30 00 00 
8d4dd1a4:	08 30       	R1 = R0;
8d4dd1a6:	04 30       	R0 = R4;
8d4dd1a8:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4dd1ac:	f0 2b 00 00 
8d4dd1b0:	04 30       	R0 = R4;
8d4dd1b2:	31 e4 16 00 	R1 = [SP + 0x58];
8d4dd1b6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd1ba:	14 33 00 00 
8d4dd1be:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd1c2:	ff e3 67 fe 	CALL 0x0x8d4dce90;
8d4dd1c6:	b9 ac       	P1 = [FP + 0x8];
8d4dd1c8:	28 e1 80 00 	P0 = 0x80 (X);		/*		P0=0x80(128) */
8d4dd1cc:	2a e1 7f 00 	P2 = 0x7f (X);		/*		P2=0x7f(127) */
8d4dd1d0:	31 e4 17 00 	R1 = [SP + 0x5c];
8d4dd1d4:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [P1 ++ P0] = R0 || NOP;
8d4dd1d8:	01 88 00 00 
8d4dd1dc:	d3 5a       	P3 = P3 + P2;
8d4dd1de:	d9 bb       	[FP -0xc] = P1;
8d4dd1e0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd1e4:	14 33 00 00 
8d4dd1e8:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd1ec:	ff e3 52 fe 	CALL 0x0x8d4dce90;
8d4dd1f0:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || B[P3++] = R0 || NOP;
8d4dd1f4:	18 9a 00 00 
8d4dd1f8:	01 da 03 84 	R1=-2080152104;
8d4dd1fc:	d8 65 00 00 
8d4dd200:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd204:	14 33 00 00 
8d4dd208:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd20c:	ff e3 42 fe 	CALL 0x0x8d4dce90;
8d4dd210:	98 e6 fd ff 	B[P3 + -0x3] = R0;
8d4dd214:	04 30       	R0 = R4;
8d4dd216:	31 e4 19 00 	R1 = [SP + 0x64];
8d4dd21a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd21e:	14 33 00 00 
8d4dd222:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd226:	ff e3 35 fe 	CALL 0x0x8d4dce90;
8d4dd22a:	98 e6 01 00 	B[P3 + 0x1] = R0;
8d4dd22e:	04 30       	R0 = R4;
8d4dd230:	31 e4 18 00 	R1 = [SP + 0x60];
8d4dd234:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd238:	14 33 00 00 
8d4dd23c:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd240:	ff e3 28 fe 	CALL 0x0x8d4dce90;
8d4dd244:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [P5 + 0x4] = R0 || R1 = [FP -0x1c];
8d4dd248:	68 b0 91 b9 
8d4dd24c:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4dd250:	c0 27 00 00 
8d4dd254:	00 0c       	CC = R0 == 0x0;
8d4dd256:	f8 63       	R0 = -0x1 (X);		/*		R0=0x64(100) */
8d4dd258:	04 1c       	IF CC JUMP 0x0x8d4dd260 (BP);
8d4dd25a:	4b 22       	JUMP.S 0x0x8d4dd6f0;
8d4dd25c:	00 00       	NOP;
8d4dd25e:	00 00       	NOP;
8d4dd260:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0x8] = R0 || R1 = [P5];
8d4dd264:	a8 b0 29 91 
8d4dd268:	01 0c       	CC = R1 == 0x0;
8d4dd26a:	03 1c       	IF CC JUMP 0x0x8d4dd270 (BP);
8d4dd26c:	12 22       	JUMP.S 0x0x8d4dd690;
8d4dd26e:	00 00       	NOP;
8d4dd270:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [P5 + 0x14] = R0 || NOP;
8d4dd274:	68 b1 00 00 
8d4dd278:	31 e4 1b 00 	R1 = [SP + 0x6c];
8d4dd27c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd280:	14 33 00 00 
8d4dd284:	00 de 05 8c 	CALL.A 0x8c0520dc;
8d4dd288:	dc 20 00 00 
8d4dd28c:	04 ce 38 0e 	R7 = PACK (R0.L, R7.L) || R3 = B[P3] (Z) || NOP;
8d4dd290:	1b 99 00 00 
8d4dd294:	0a c6 3b 80 	R0 = DEPOSIT (R3, R7);
8d4dd298:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || B[P3] = R0 || NOP;
8d4dd29c:	18 9b 00 00 
8d4dd2a0:	31 e4 20 00 	R1 = [SP + 0x80];
8d4dd2a4:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4dd2a8:	c0 27 00 00 
8d4dd2ac:	00 0c       	CC = R0 == 0x0;
8d4dd2ae:	02 60       	R2 = 0x0 (X);		/*		R2=0x7c(124) */
8d4dd2b0:	02 1c       	IF CC JUMP 0x0x8d4dd2b4 (BP);
8d4dd2b2:	dd 21       	JUMP.S 0x0x8d4dd66c;
8d4dd2b4:	33 e4 1a 00 	R3 = [SP + 0x68];
8d4dd2b8:	80 ce 02 a0 	R0.H = R2.L << 0x0 || R5 = B[P3] (Z) || NOP;
8d4dd2bc:	1d 99 00 00 
8d4dd2c0:	80 c6 03 80 	R0.L = R3.L << 0x0;
8d4dd2c4:	0a c6 05 80 	R0 = DEPOSIT (R5, R0);
8d4dd2c8:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || B[P3] = R0 || NOP;
8d4dd2cc:	18 9b 00 00 
8d4dd2d0:	31 e4 1d 00 	R1 = [SP + 0x74];
8d4dd2d4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd2d8:	14 33 00 00 
8d4dd2dc:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd2e0:	ff e3 d8 fd 	CALL 0x0x8d4dce90;
8d4dd2e4:	38 ad       	P0 = [FP + 0x10];
8d4dd2e6:	31 e4 1c 00 	R1 = [SP + 0x70];
8d4dd2ea:	80 e6 82 00 	B[P0 + 0x82] = R0;
8d4dd2ee:	04 30       	R0 = R4;
8d4dd2f0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd2f4:	14 33 00 00 
8d4dd2f8:	00 de 05 8c 	CALL.A 0x8c0520dc;
8d4dd2fc:	dc 20 00 00 
8d4dd300:	39 ad       	P1 = [FP + 0x10];
8d4dd302:	31 e4 1e 00 	R1 = [SP + 0x78];
8d4dd306:	88 e6 84 00 	B[P1 + 0x84] = R0;
8d4dd30a:	04 30       	R0 = R4;
8d4dd30c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd310:	14 33 00 00 
8d4dd314:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4dd318:	88 1d 00 00 
8d4dd31c:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [P5 + 0xc] = R0 || R1 = [FP -0x20];
8d4dd320:	e8 b0 81 b9 
8d4dd324:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4dd328:	c0 27 00 00 
8d4dd32c:	00 0c       	CC = R0 == 0x0;
8d4dd32e:	fa 63       	R2 = -0x1 (X);		/*		R2=0x7c(124) */
8d4dd330:	90 11       	IF !CC JUMP 0x0x8d4dd650;
8d4dd332:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [P5 + 0x10] = R2 || R1 = [FP -0x14];
8d4dd336:	2a b1 b1 b9 
8d4dd33a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd33e:	14 33 00 00 
8d4dd342:	00 de 05 8c 	CALL.A 0x8c051004;
8d4dd346:	04 10 00 00 
8d4dd34a:	00 0c       	CC = R0 == 0x0;
8d4dd34c:	6c 10       	IF !CC JUMP 0x0x8d4dd424;
8d4dd34e:	9e e6 05 00 	B[P3 + 0x5] = R6;
8d4dd352:	20 99       	R0 = B[P4] (Z);
8d4dd354:	00 0c       	CC = R0 == 0x0;
8d4dd356:	0b 10       	IF !CC JUMP 0x0x8d4dd36c;
8d4dd358:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP + 0x10] = P3 || R5 = [FP -0x8];
8d4dd35c:	3b bd e5 b9 
8d4dd360:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dd364:	38 1a 00 00 
8d4dd368:	dd b9       	P5 = [FP -0xc];
8d4dd36a:	f7 2e       	JUMP.S 0x0x8d4dd158;
8d4dd36c:	04 30       	R0 = R4;
8d4dd36e:	31 e4 12 00 	R1 = [SP + 0x48];
8d4dd372:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd376:	14 33 00 00 
8d4dd37a:	ff e3 39 fc 	CALL 0x0x8d4dcbec;
8d4dd37e:	80 ce 00 a4 	R2.H = R0.L << 0x0 || R3 = [SP + 0x3c] || R5 = B[P3] (Z);
8d4dd382:	f3 a3 1d 99 
8d4dd386:	80 ce 03 84 	R2.L = R3.L << 0x0 || R1 = [SP + 0x34] || NOP;
8d4dd38a:	71 a3 00 00 
8d4dd38e:	0a c6 15 80 	R0 = DEPOSIT (R5, R2);
8d4dd392:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || B[P3] = R0 || NOP;
8d4dd396:	18 9b 00 00 
8d4dd39a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd39e:	14 33 00 00 
8d4dd3a2:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd3a6:	ff e3 75 fd 	CALL 0x0x8d4dce90;
8d4dd3aa:	38 ad       	P0 = [FP + 0x10];
8d4dd3ac:	31 e4 11 00 	R1 = [SP + 0x44];
8d4dd3b0:	82 e4 7d 00 	R2 = B[P0 + 0x7d] (Z);
8d4dd3b4:	10 50       	R0 = R0 + R2;
8d4dd3b6:	80 e6 7d 00 	B[P0 + 0x7d] = R0;
8d4dd3ba:	04 30       	R0 = R4;
8d4dd3bc:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd3c0:	14 33 00 00 
8d4dd3c4:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd3c8:	ff e3 64 fd 	CALL 0x0x8d4dce90;
8d4dd3cc:	39 ad       	P1 = [FP + 0x10];
8d4dd3ce:	31 e4 10 00 	R1 = [SP + 0x40];
8d4dd3d2:	88 e6 83 00 	B[P1 + 0x83] = R0;
8d4dd3d6:	04 30       	R0 = R4;
8d4dd3d8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd3dc:	14 33 00 00 
8d4dd3e0:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd3e4:	ff e3 56 fd 	CALL 0x0x8d4dce90;
8d4dd3e8:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R1 = [SP + 0x30] || NOP;
8d4dd3ec:	31 a3 00 00 
8d4dd3f0:	04 30       	R0 = R4;
8d4dd3f2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd3f6:	14 33 00 00 
8d4dd3fa:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd3fe:	ff e3 49 fd 	CALL 0x0x8d4dce90;
8d4dd402:	07 cc 28 04 	R2 = MAX (R5, R0) || P1 = [FP + 0x10] || R3 = B[P3] (Z);
8d4dd406:	39 ad 1b 99 
8d4dd40a:	85 08       	CC = R5 < R0;
8d4dd40c:	01 02       	R1 = CC;
8d4dd40e:	07 c4 16 04 	R2 = MAX (R2, R6);
8d4dd412:	04 ce 39 0e 	R7 = PACK (R1.L, R7.L) || [P5 + 0x14] = R2 || NOP;
8d4dd416:	6a b1 00 00 
8d4dd41a:	0a c6 3b 80 	R0 = DEPOSIT (R3, R7);
8d4dd41e:	88 e6 80 00 	B[P1 + 0x80] = R0;
8d4dd422:	9b 2f       	JUMP.S 0x0x8d4dd358;
8d4dd424:	46 30       	R0 = SP;
8d4dd426:	23 e1 d4 00 	R3 = 0xd4 (X);		/*		R3=0xd4(212) */
8d4dd42a:	7a 60       	R2 = 0xf (X);		/*		R2=0x7c(124) */
8d4dd42c:	04 cc 03 0a 	R5 = R0 + R3 (NS) || [FP -0x78] = R2 || R1 = [FP -0x14];
8d4dd430:	22 ba b1 b9 
8d4dd434:	b6 e6 f4 00 	B[SP + 0xf4] = R6;
8d4dd438:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP -0x7c] = R6 || NOP;
8d4dd43c:	16 ba 00 00 
8d4dd440:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd444:	14 33 00 00 
8d4dd448:	08 30       	R1 = R0;
8d4dd44a:	05 30       	R0 = R5;
8d4dd44c:	00 de 05 8c 	CALL.A 0x8c051cca;
8d4dd450:	ca 1c 00 00 
8d4dd454:	05 30       	R0 = R5;
8d4dd456:	ff e3 25 fc 	CALL 0x0x8d4dcca0;
8d4dd45a:	b8 b0       	[FP + 0x8] = R0;
8d4dd45c:	82 60       	R2 = 0x10 (X);		/*		R2=0x7c(124) */
8d4dd45e:	30 e4 3b 00 	R0 = [SP + 0xec];
8d4dd462:	02 0a       	CC = R2 <= R0 (IU);
8d4dd464:	ee 18       	IF CC JUMP 0x0x8d4dd640;
8d4dd466:	b9 a0       	R1 = [FP + 0x8];
8d4dd468:	78 60       	R0 = 0xf (X);		/*		R0=0x64(100) */
8d4dd46a:	01 0c       	CC = R1 == 0x0;
8d4dd46c:	36 e6 3a 00 	[SP + 0xe8] = R6;
8d4dd470:	b6 e6 d8 00 	B[SP + 0xd8] = R6;
8d4dd474:	30 e6 3b 00 	[SP + 0xec] = R0;
8d4dd478:	57 30       	R2 = FP;
8d4dd47a:	7d 10       	IF !CC JUMP 0x0x8d4dd574;
8d4dd47c:	23 e1 8c ff 	R3 = -0x74 (X);		/*		R3=0xffffff8c(-116) */
8d4dd480:	04 cc 13 04 	R2 = R2 + R3 (NS) || R1 = [FP -0x14] || NOP;
8d4dd484:	b1 b9 00 00 
8d4dd488:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d4dd48c:	ba b0 00 00 
8d4dd490:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd494:	14 33 00 00 
8d4dd498:	08 30       	R1 = R0;
8d4dd49a:	b8 a0       	R0 = [FP + 0x8];
8d4dd49c:	00 de 05 8c 	CALL.A 0x8c051cca;
8d4dd4a0:	ca 1c 00 00 
8d4dd4a4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4dd4a8:	b8 00 03 00 
8d4dd4ac:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP + 0x8] || [SP + 0xc] = R3;
8d4dd4b0:	b8 a0 f3 b0 
8d4dd4b4:	20 67       	R0 += -0x1c;		/* (-28) */
8d4dd4b6:	b9 a0       	R1 = [FP + 0x8];
8d4dd4b8:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dd4bc:	70 e9 00 00 
8d4dd4c0:	90 b8       	R0 = [FP -0x5c];
8d4dd4c2:	83 60       	R3 = 0x10 (X);		/*		R3=0xffffff8c(-116) */
8d4dd4c4:	03 0a       	CC = R3 <= R0 (IU);
8d4dd4c6:	52 18       	IF CC JUMP 0x0x8d4dd56a;
8d4dd4c8:	78 60       	R0 = 0xf (X);		/*		R0=0x64(100) */
8d4dd4ca:	86 ba       	[FP -0x60] = R6;
8d4dd4cc:	b6 e6 10 01 	B[SP + 0x110] = R6;
8d4dd4d0:	90 ba       	[FP -0x5c] = R0;
8d4dd4d2:	4e 30       	R1 = SP;
8d4dd4d4:	22 e1 f0 00 	R2 = 0xf0 (X);		/*		R2=0xf0(240) */
8d4dd4d8:	11 50       	R0 = R1 + R2;
8d4dd4da:	08 30       	R1 = R0;
8d4dd4dc:	20 67       	R0 += -0x1c;		/* (-28) */
8d4dd4de:	06 e3 f9 35 	CALL 0x0x8d5a40d0;
8d4dd4e2:	05 30       	R0 = R5;
8d4dd4e4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4dd4e8:	b8 00 03 00 
8d4dd4ec:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4dd4f0:	f3 b0 00 00 
8d4dd4f4:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4dd4f6:	02 60       	R2 = 0x0 (X);		/*		R2=0xf0(240) */
8d4dd4f8:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dd4fc:	70 e9 00 00 
8d4dd500:	85 60       	R5 = 0x10 (X);		/*		R5=0x100(256) */
8d4dd502:	30 e4 3b 00 	R0 = [SP + 0xec];
8d4dd506:	05 0a       	CC = R5 <= R0 (IU);
8d4dd508:	2c 18       	IF CC JUMP 0x0x8d4dd560;
8d4dd50a:	7b 60       	R3 = 0xf (X);		/*		R3=0xffffff8c(-116) */
8d4dd50c:	33 e6 3b 00 	[SP + 0xec] = R3;
8d4dd510:	23 b8       	R3 = [FP -0x78];
8d4dd512:	82 60       	R2 = 0x10 (X);		/*		R2=0xf0(240) */
8d4dd514:	1a 0a       	CC = R2 <= R3 (IU);
8d4dd516:	4e 30       	R1 = SP;
8d4dd518:	23 e1 f4 00 	R3 = 0xf4 (X);		/*		R3=0xf4(244) */
8d4dd51c:	59 50       	R1 = R1 + R3;
8d4dd51e:	45 30       	R0 = P5;
8d4dd520:	35 e4 3d 00 	R5 = [SP + 0xf4];
8d4dd524:	36 e6 3a 00 	[SP + 0xe8] = R6;
8d4dd528:	b6 e6 d8 00 	B[SP + 0xd8] = R6;
8d4dd52c:	0d 07       	IF CC R1 = R5;
8d4dd52e:	00 65       	R0 += 0x20;		/* ( 32) */
8d4dd530:	22 e1 60 00 	R2 = 0x60 (X);		/*		R2=0x60( 96) */
8d4dd534:	00 de 02 04 	CALL.A 0x040232e4;
8d4dd538:	e4 32 00 00 
8d4dd53c:	9e e6 64 00 	B[P3 + 0x64] = R6;
8d4dd540:	83 60       	R3 = 0x10 (X);		/*		R3=0xf4(244) */
8d4dd542:	20 b8       	R0 = [FP -0x78];
8d4dd544:	03 0a       	CC = R3 <= R0 (IU);
8d4dd546:	07 18       	IF CC JUMP 0x0x8d4dd554;
8d4dd548:	78 60       	R0 = 0xf (X);		/*		R0=0x64(100) */
8d4dd54a:	16 ba       	[FP -0x7c] = R6;
8d4dd54c:	b6 e6 f4 00 	B[SP + 0xf4] = R6;
8d4dd550:	20 ba       	[FP -0x78] = R0;
8d4dd552:	00 2f       	JUMP.S 0x0x8d4dd352;
8d4dd554:	30 e4 3d 00 	R0 = [SP + 0xf4];
8d4dd558:	ff e3 46 87 	CALL 0x0x8d4ce3e4;
8d4dd55c:	f6 2f       	JUMP.S 0x0x8d4dd548;
8d4dd55e:	00 00       	NOP;
8d4dd560:	30 e4 36 00 	R0 = [SP + 0xd8];
8d4dd564:	ff e3 40 87 	CALL 0x0x8d4ce3e4;
8d4dd568:	d1 2f       	JUMP.S 0x0x8d4dd50a;
8d4dd56a:	40 b8       	R0 = [FP -0x70];
8d4dd56c:	ff e3 3c 87 	CALL 0x0x8d4ce3e4;
8d4dd570:	ac 2f       	JUMP.S 0x0x8d4dd4c8;
8d4dd572:	00 00       	NOP;
8d4dd574:	20 e1 a8 ff 	R0 = -0x58 (X);		/*		R0=0xffffffa8(-88) */
8d4dd578:	31 e4 15 00 	R1 = [SP + 0x54];
8d4dd57c:	02 50       	R0 = R2 + R0;
8d4dd57e:	a1 64       	R1 += 0x14;		/* ( 20) */
8d4dd580:	06 e3 5c 38 	CALL 0x0x8d5a4638;
8d4dd584:	5f 30       	R3 = FP;
8d4dd586:	23 66       	R3 += -0x3c;		/* (-60) */
8d4dd588:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP + 0x8] = R3 || R1 = [FP -0x14];
8d4dd58c:	bb b0 b1 b9 
8d4dd590:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd594:	14 33 00 00 
8d4dd598:	08 30       	R1 = R0;
8d4dd59a:	b8 a0       	R0 = [FP + 0x8];
8d4dd59c:	00 de 05 8c 	CALL.A 0x8c051cca;
8d4dd5a0:	ca 1c 00 00 
8d4dd5a4:	03 c8 00 18 	MNOP || R0 = [FP + 0x8] || R2 = [FP + 0x8];
8d4dd5a8:	b8 a0 ba a0 
8d4dd5ac:	20 67       	R0 += -0x1c;		/* (-28) */
8d4dd5ae:	08 30       	R1 = R0;
8d4dd5b0:	20 67       	R0 += -0x1c;		/* (-28) */
8d4dd5b2:	06 e3 7a 39 	CALL 0x0x8d5a48a6;
8d4dd5b6:	5e 30       	R3 = SP;
8d4dd5b8:	21 e1 0c 01 	R1 = 0x10c (X);		/*		R1=0x10c(268) */
8d4dd5bc:	4b 50       	R1 = R3 + R1;
8d4dd5be:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4dd5c2:	b8 00 02 00 
8d4dd5c6:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || [SP + 0xc] = R2 || NOP;
8d4dd5ca:	f2 b0 00 00 
8d4dd5ce:	20 67       	R0 += -0x1c;		/* (-28) */
8d4dd5d0:	02 60       	R2 = 0x0 (X);		/*		R2=0x60( 96) */
8d4dd5d2:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4dd5d6:	70 e9 00 00 
8d4dd5da:	90 b8       	R0 = [FP -0x5c];
8d4dd5dc:	83 60       	R3 = 0x10 (X);		/*		R3=0xf4(244) */
8d4dd5de:	03 0a       	CC = R3 <= R0 (IU);
8d4dd5e0:	2b 18       	IF CC JUMP 0x0x8d4dd636;
8d4dd5e2:	03 c8 00 18 	MNOP || R0 = [FP -0x24] || [FP -0x60] = R6;
8d4dd5e6:	70 b9 86 ba 
8d4dd5ea:	81 60       	R1 = 0x10 (X);		/*		R1=0x10c(268) */
8d4dd5ec:	7a 60       	R2 = 0xf (X);		/*		R2=0x60( 96) */
8d4dd5ee:	01 0a       	CC = R1 <= R0 (IU);
8d4dd5f0:	b6 e6 10 01 	B[SP + 0x110] = R6;
8d4dd5f4:	03 c8 00 18 	MNOP || [FP -0x5c] = R2 || R0 = [FP -0x38];
8d4dd5f8:	92 ba 20 b9 
8d4dd5fc:	1a 18       	IF CC JUMP 0x0x8d4dd630;
8d4dd5fe:	03 c8 00 18 	MNOP || R0 = [FP -0x40] || [FP -0x28] = R6;
8d4dd602:	00 b9 66 bb 
8d4dd606:	81 60       	R1 = 0x10 (X);		/*		R1=0x10c(268) */
8d4dd608:	7a 60       	R2 = 0xf (X);		/*		R2=0x60( 96) */
8d4dd60a:	01 0a       	CC = R1 <= R0 (IU);
8d4dd60c:	b6 e6 48 01 	B[SP + 0x148] = R6;
8d4dd610:	03 c8 00 18 	MNOP || [FP -0x24] = R2 || R0 = [FP -0x54];
8d4dd614:	72 bb b0 b8 
8d4dd618:	08 18       	IF CC JUMP 0x0x8d4dd628;
8d4dd61a:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa8(-88) */
8d4dd61c:	f6 ba       	[FP -0x44] = R6;
8d4dd61e:	b6 e6 2c 01 	B[SP + 0x12c] = R6;
8d4dd622:	00 bb       	[FP -0x40] = R0;
8d4dd624:	57 2f       	JUMP.S 0x0x8d4dd4d2;
8d4dd626:	00 00       	NOP;
8d4dd628:	ff e3 de 86 	CALL 0x0x8d4ce3e4;
8d4dd62c:	f7 2f       	JUMP.S 0x0x8d4dd61a;
8d4dd62e:	00 00       	NOP;
8d4dd630:	ff e3 da 86 	CALL 0x0x8d4ce3e4;
8d4dd634:	e5 2f       	JUMP.S 0x0x8d4dd5fe;
8d4dd636:	40 b8       	R0 = [FP -0x70];
8d4dd638:	ff e3 d6 86 	CALL 0x0x8d4ce3e4;
8d4dd63c:	d3 2f       	JUMP.S 0x0x8d4dd5e2;
8d4dd63e:	00 00       	NOP;
8d4dd640:	30 e4 36 00 	R0 = [SP + 0xd8];
8d4dd644:	ff e3 d0 86 	CALL 0x0x8d4ce3e4;
8d4dd648:	0f 2f       	JUMP.S 0x0x8d4dd466;
8d4dd64a:	00 00       	NOP;
8d4dd64c:	00 00       	NOP;
8d4dd64e:	00 00       	NOP;
8d4dd650:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R1 = [FP -0x20] || NOP;
8d4dd654:	81 b9 00 00 
8d4dd658:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd65c:	14 33 00 00 
8d4dd660:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4dd664:	88 1d 00 00 
8d4dd668:	10 30       	R2 = R0;
8d4dd66a:	64 2e       	JUMP.S 0x0x8d4dd332;
8d4dd66c:	04 30       	R0 = R4;
8d4dd66e:	31 e4 20 00 	R1 = [SP + 0x80];
8d4dd672:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd676:	14 33 00 00 
8d4dd67a:	00 de 05 8c 	CALL.A 0x8c0520dc;
8d4dd67e:	dc 20 00 00 
8d4dd682:	00 0c       	CC = R0 == 0x0;
8d4dd684:	0a 60       	R2 = 0x1 (X);		/*		R2=0x60( 96) */
8d4dd686:	02 14       	IF !CC JUMP 0x0x8d4dd68a (BP);
8d4dd688:	16 2e       	JUMP.S 0x0x8d4dd2b4;
8d4dd68a:	02 60       	R2 = 0x0 (X);		/*		R2=0x60( 96) */
8d4dd68c:	14 2e       	JUMP.S 0x0x8d4dd2b4;
8d4dd68e:	00 00       	NOP;
8d4dd690:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R1 = [SP + 0x38] || NOP;
8d4dd694:	b1 a3 00 00 
8d4dd698:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd69c:	14 33 00 00 
8d4dd6a0:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd6a4:	ff e3 f6 fb 	CALL 0x0x8d4dce90;
8d4dd6a8:	00 de 02 04 	CALL.A 0x04021854;
8d4dd6ac:	54 18 00 00 
8d4dd6b0:	01 da 00 4f 	R1=1325400064;
8d4dd6b4:	00 00 00 00 
8d4dd6b8:	00 de 02 04 	CALL.A 0x04021ac0;
8d4dd6bc:	c0 1a 00 00 
8d4dd6c0:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R0 = [P5] || NOP;
8d4dd6c4:	28 91 00 00 
8d4dd6c8:	00 de 02 04 	CALL.A 0x040218a0;
8d4dd6cc:	a0 18 00 00 
8d4dd6d0:	08 30       	R1 = R0;
8d4dd6d2:	05 30       	R0 = R5;
8d4dd6d4:	00 de 02 04 	CALL.A 0x040219e4;
8d4dd6d8:	e4 19 00 00 
8d4dd6dc:	00 de 02 04 	CALL.A 0x04020fd8;
8d4dd6e0:	d8 0f 00 00 
8d4dd6e4:	07 c4 06 00 	R0 = MAX (R0, R6);
8d4dd6e8:	c4 2d       	JUMP.S 0x0x8d4dd270;
8d4dd6ea:	00 00       	NOP;
8d4dd6ec:	00 00       	NOP;
8d4dd6ee:	00 00       	NOP;
8d4dd6f0:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R1 = [FP -0x1c] || NOP;
8d4dd6f4:	91 b9 00 00 
8d4dd6f8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd6fc:	14 33 00 00 
8d4dd700:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd704:	ff e3 c6 fb 	CALL 0x0x8d4dce90;
8d4dd708:	ac 2d       	JUMP.S 0x0x8d4dd260;
8d4dd70a:	a0 b9       	R0 = [FP -0x18];
8d4dd70c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dd710:	38 1a 00 00 
8d4dd714:	30 e4 15 00 	R0 = [SP + 0x54];
8d4dd718:	ff e3 14 f3 	CALL 0x0x8d4dbd40;
8d4dd71c:	32 e5 14 00 	P2 = [SP + 0x50];
8d4dd720:	28 e1 64 38 	P0 = 0x3864 (X);		/*		P0=0x3864(14436) */
8d4dd724:	30 e4 15 00 	R0 = [SP + 0x54];
8d4dd728:	ad 60       	R5 = 0x15 (X);		/*		R5=0x100(256) */
8d4dd72a:	42 5b       	P5 = P2 + P0;
8d4dd72c:	ff e3 30 f3 	CALL 0x0x8d4dbd8c;
8d4dd730:	4c 32       	P1 = P4;
8d4dd732:	81 6d       	P1 += 0x30;		/* ( 48) */
8d4dd734:	ef 60       	R7 = 0x1d (X);		/*		R7=0x701(1793) */
8d4dd736:	43 61       	R3 = 0x28 (X);		/*		R3=0xf4(244) */
8d4dd738:	4a 61       	R2 = 0x29 (X);		/*		R2=0x60( 96) */
8d4dd73a:	01 60       	R1 = 0x0 (X);		/*		R1=0x10c(268) */
8d4dd73c:	c0 e0 0d e8 	LSETUP_IMM(bottom=0x8d4dd756) LC0 count_fields=0x0/0x3a;
8d4dd740:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || R4 = [FP -0x4] || NOP;
8d4dd744:	f4 b9 00 00 
8d4dd748:	04 0c       	CC = R4 == 0x0;
8d4dd74a:	08 64       	R0 += 0x1;		/* (  1) */
8d4dd74c:	e1 10       	IF !CC JUMP 0x0x8d4dd90e;
8d4dd74e:	11 08       	CC = R1 == R2;
8d4dd750:	df 10       	IF !CC JUMP 0x0x8d4dd90e;
8d4dd752:	21 6c       	P1 += 0x4;		/* (  4) */
8d4dd754:	25 6c       	P5 += 0x4;		/* (  4) */
8d4dd756:	08 30       	R1 = R0;
8d4dd758:	30 e4 15 00 	R0 = [SP + 0x54];
8d4dd75c:	ff e3 38 f2 	CALL 0x0x8d4dbbcc;
8d4dd760:	31 e5 14 00 	P1 = [SP + 0x50];
8d4dd764:	00 0c       	CC = R0 == 0x0;
8d4dd766:	17 18       	IF CC JUMP 0x0x8d4dd794;
8d4dd768:	30 e5 14 00 	P0 = [SP + 0x50];
8d4dd76c:	00 da 00 40 	R0=1073741824;
8d4dd770:	00 00 00 00 
8d4dd774:	08 e6 19 0e 	[P1 + 0x3864] = R0;
8d4dd778:	08 e6 1a 0e 	[P1 + 0x3868] = R0;
8d4dd77c:	08 e6 1b 0e 	[P1 + 0x386c] = R0;
8d4dd780:	08 e6 1c 0e 	[P1 + 0x3870] = R0;
8d4dd784:	08 e6 1d 0e 	[P1 + 0x3874] = R0;
8d4dd788:	08 e6 1e 0e 	[P1 + 0x3878] = R0;
8d4dd78c:	00 e6 1f 0e 	[P0 + 0x387c] = R0;
8d4dd790:	00 e6 20 0e 	[P0 + 0x3880] = R0;
8d4dd794:	31 e5 14 00 	P1 = [SP + 0x50];
8d4dd798:	01 da 00 40 	R1=1073741824;
8d4dd79c:	00 00 00 00 
8d4dd7a0:	22 e1 18 01 	R2 = 0x118 (X);		/*		R2=0x118(280) */
8d4dd7a4:	03 da 03 84 	R3=-2080152856;
8d4dd7a8:	e8 62 00 00 
8d4dd7ac:	09 e6 40 0e 	[P1 + 0x3900] = R1;
8d4dd7b0:	09 e6 3f 0e 	[P1 + 0x38fc] = R1;
8d4dd7b4:	30 e4 15 00 	R0 = [SP + 0x54];
8d4dd7b8:	d3 51       	R7 = R3 + R2;
8d4dd7ba:	ff e3 9d f2 	CALL 0x0x8d4dbcf4;
8d4dd7be:	08 30       	R1 = R0;
8d4dd7c0:	00 da bc 86 	R0=-2034451996;
8d4dd7c4:	e4 b9 00 00 
8d4dd7c8:	05 e3 98 d0 	CALL 0x0x8d5978f8;
8d4dd7cc:	30 e4 15 00 	R0 = [SP + 0x54];
8d4dd7d0:	ff e3 92 f2 	CALL 0x0x8d4dbcf4;
8d4dd7d4:	08 30       	R1 = R0;
8d4dd7d6:	00 da bc 86 	R0=-2034451996;
8d4dd7da:	e4 b9 00 00 
8d4dd7de:	05 e3 db cf 	CALL 0x0x8d597794;
8d4dd7e2:	30 e4 15 00 	R0 = [SP + 0x54];
8d4dd7e6:	ff e3 87 f2 	CALL 0x0x8d4dbcf4;
8d4dd7ea:	01 da 03 84 	R1=-2080152856;
8d4dd7ee:	e8 62 00 00 
8d4dd7f2:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R0 = [FP -0x10] || NOP;
8d4dd7f6:	c0 b9 00 00 
8d4dd7fa:	81 66       	R1 += -0x30;		/* (-48) */
8d4dd7fc:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd800:	14 33 00 00 
8d4dd804:	21 e4 60 00 	R1 = [P4 + 0x180];
8d4dd808:	ff e3 44 fb 	CALL 0x0x8d4dce90;
8d4dd80c:	08 30       	R1 = R0;
8d4dd80e:	05 30       	R0 = R5;
8d4dd810:	04 e3 c0 ea 	CALL 0x0x8d57ad90;
8d4dd814:	34 e4 13 00 	R4 = [SP + 0x4c];
8d4dd818:	23 e1 94 53 	R3 = 0x5394 (X);		/*		R3=0x5394(21396) */
8d4dd81c:	1c 50       	R0 = R4 + R3;
8d4dd81e:	82 61       	R2 = 0x30 (X);		/*		R2=0x118(280) */
8d4dd820:	01 60       	R1 = 0x0 (X);		/*		R1=0x10c(268) */
8d4dd822:	28 32       	P5 = R0;
8d4dd824:	00 de 02 04 	CALL.A 0x04022ea8;
8d4dd828:	a8 2e 00 00 
8d4dd82c:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP -0x10] || NOP;
8d4dd830:	c0 b9 00 00 
8d4dd834:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4dd838:	c0 27 00 00 
8d4dd83c:	00 0c       	CC = R0 == 0x0;
8d4dd83e:	4c 18       	IF CC JUMP 0x0x8d4dd8d6;
8d4dd840:	21 e1 20 01 	R1 = 0x120 (X);		/*		R1=0x120(288) */
8d4dd844:	02 da 03 84 	R2=-2080152856;
8d4dd848:	e8 62 00 00 
8d4dd84c:	04 cc 11 0a 	R5 = R2 + R1 (NS) || R0 = [FP -0x10] || NOP;
8d4dd850:	c0 b9 00 00 
8d4dd854:	0f 30       	R1 = R7;
8d4dd856:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd85a:	14 33 00 00 
8d4dd85e:	0d 30       	R1 = R5;
8d4dd860:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4dd864:	c0 27 00 00 
8d4dd868:	00 0c       	CC = R0 == 0x0;
8d4dd86a:	36 18       	IF CC JUMP 0x0x8d4dd8d6;
8d4dd86c:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP -0x10] || NOP;
8d4dd870:	c0 b9 00 00 
8d4dd874:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd878:	14 33 00 00 
8d4dd87c:	0d 30       	R1 = R5;
8d4dd87e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd882:	14 33 00 00 
8d4dd886:	00 de 05 8c 	CALL.A 0x8c052382;
8d4dd88a:	82 23 00 00 
8d4dd88e:	61 60       	R1 = 0xc (X);		/*		R1=0x120(288) */
8d4dd890:	08 08       	CC = R0 == R1;
8d4dd892:	f0 bb       	[FP -0x4] = R0;
8d4dd894:	21 10       	IF !CC JUMP 0x0x8d4dd8d6;
8d4dd896:	04 60       	R4 = 0x0 (X);		/*		R4=0x104(260) */
8d4dd898:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP -0x10] || NOP;
8d4dd89c:	c0 b9 00 00 
8d4dd8a0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd8a4:	14 33 00 00 
8d4dd8a8:	0d 30       	R1 = R5;
8d4dd8aa:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dd8ae:	14 33 00 00 
8d4dd8b2:	0c 30       	R1 = R4;
8d4dd8b4:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4dd8b8:	e4 30 00 00 
8d4dd8bc:	00 de 05 8c 	CALL.A 0x8c052038;
8d4dd8c0:	38 20 00 00 
8d4dd8c4:	06 e3 2a 63 	CALL 0x0x8d5a9f18;
8d4dd8c8:	0c 64       	R4 += 0x1;		/* (  1) */
8d4dd8ca:	03 c8 00 18 	MNOP || R1 = [FP -0x4] || [P5++] = R0;
8d4dd8ce:	f1 b9 28 92 
8d4dd8d2:	8c 08       	CC = R4 < R1;
8d4dd8d4:	e2 1f       	IF CC JUMP 0x0x8d4dd898 (BP);
8d4dd8d6:	30 e4 2e 00 	R0 = [SP + 0xb8];
8d4dd8da:	82 60       	R2 = 0x10 (X);		/*		R2=0x118(280) */
8d4dd8dc:	09 60       	R1 = 0x1 (X);		/*		R1=0x120(288) */
8d4dd8de:	02 0a       	CC = R2 <= R0 (IU);
8d4dd8e0:	00 d8 09 84 	LdStAbs addr=0x8409adf5 control=0x0a01;
8d4dd8e4:	f5 ad 01 0a 
8d4dd8e8:	08 18       	IF CC JUMP 0x0x8d4dd8f8;
8d4dd8ea:	b6 e6 a4 00 	B[SP + 0xa4] = R6;
8d4dd8ee:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4dd8f0:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dd8f2:	01 e8 00 00 	UNLINK;
8d4dd8f6:	10 00       	RTS;
8d4dd8f8:	30 e4 29 00 	R0 = [SP + 0xa4];
8d4dd8fc:	ff e3 74 85 	CALL 0x0x8d4ce3e4;
8d4dd900:	b6 e6 a4 00 	B[SP + 0xa4] = R6;
8d4dd904:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4dd906:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dd908:	01 e8 00 00 	UNLINK;
8d4dd90c:	10 00       	RTS;
8d4dd90e:	04 0c       	CC = R4 == 0x0;
8d4dd910:	03 10       	IF !CC JUMP 0x0x8d4dd916;
8d4dd912:	19 08       	CC = R1 == R3;
8d4dd914:	1f 1b       	IF CC JUMP 0x0x8d4dd752;
8d4dd916:	29 08       	CC = R1 == R5;
8d4dd918:	05 10       	IF !CC JUMP 0x0x8d4dd922;
8d4dd91a:	24 e4 4a 00 	R4 = [P4 + 0x128];
8d4dd91e:	3c 08       	CC = R4 == R7;
8d4dd920:	03 10       	IF !CC JUMP 0x0x8d4dd926;
8d4dd922:	0c 91       	R4 = [P1];
8d4dd924:	2c 93       	[P5] = R4;
8d4dd926:	0c 91       	R4 = [P1];
8d4dd928:	84 0c       	CC = R4 < 0x0;
8d4dd92a:	14 17       	IF !CC JUMP 0x0x8d4dd752 (BP);
8d4dd92c:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4dd930:	fc 1e 00 00 
8d4dd934:	80 0c       	CC = R0 < 0x0;
8d4dd936:	09 10       	IF !CC JUMP 0x0x8d4dd948;
8d4dd938:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4dd93c:	24 2b 00 00 
8d4dd940:	00 00       	NOP;
8d4dd942:	00 00       	NOP;
8d4dd944:	00 00       	NOP;
8d4dd946:	00 00       	NOP;
8d4dd948:	04 cc 00 40 	R0 = R0 - R0 (NS) || [SP + 0x10] = R1 || NOP;
8d4dd94c:	31 b1 00 00 
8d4dd950:	09 da 03 84 	P1=-2080152088;
8d4dd954:	e8 65 00 00 
8d4dd958:	f1 bc       	[SP + 0xc] = P1;
8d4dd95a:	22 e1 e6 02 	R2 = 0x2e6 (X);		/*		R2=0x2e6(742) */
8d4dd95e:	01 da 03 84 	R1=-2080152232;
8d4dd962:	58 65 00 00 
8d4dd966:	00 de 04 8c 	CALL.A 0x8c040574;
8d4dd96a:	74 05 00 00 
8d4dd96e:	e5 2f       	JUMP.S 0x0x8d4dd938;
8d4dd970:	30 e4 22 00 	R0 = [SP + 0x88];
8d4dd974:	ff e3 38 85 	CALL 0x0x8d4ce3e4;
8d4dd978:	ee 2a       	JUMP.S 0x0x8d4dcf54;
8d4dd97a:	00 00       	NOP;
8d4dd97c:	00 e8 15 00 	LINK 0x54;		/* (84) */
8d4dd980:	60 05       	[--SP] = (R7:4);
8d4dd982:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dd984:	38 30       	R7 = R0;
8d4dd986:	00 de 05 8c 	CALL.A 0x8c051004;
8d4dd98a:	04 10 00 00 
8d4dd98e:	00 0c       	CC = R0 == 0x0;
8d4dd990:	07 10       	IF !CC JUMP 0x0x8d4dd99e;
8d4dd992:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dd994:	20 05       	(R7:4) = [SP++];
8d4dd996:	01 e8 00 00 	UNLINK;
8d4dd99a:	90 60       	R0 = 0x12 (X);		/*		R0=0xffffffa8(-88) */
8d4dd99c:	10 00       	RTS;
8d4dd99e:	07 30       	R0 = R7;
8d4dd9a0:	00 de 05 8c 	CALL.A 0x8c051c90;
8d4dd9a4:	90 1c 00 00 
8d4dd9a8:	4e 30       	R1 = SP;
8d4dd9aa:	e2 60       	R2 = 0x1c (X);		/*		R2=0x2e6(742) */
8d4dd9ac:	d1 51       	R7 = R1 + R2;
8d4dd9ae:	05 60       	R5 = 0x0 (X);		/*		R5=0x100(256) */
8d4dd9b0:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [SP + 0x30] = R5 || NOP;
8d4dd9b4:	35 b3 00 00 
8d4dd9b8:	b5 e6 20 00 	B[SP + 0x20] = R5;
8d4dd9bc:	7c 60       	R4 = 0xf (X);		/*		R4=0x104(260) */
8d4dd9be:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0x34] = R4 || NOP;
8d4dd9c2:	74 b3 00 00 
8d4dd9c6:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4dd9ca:	76 a3 00 00 
8d4dd9ce:	0f 30       	R1 = R7;
8d4dd9d0:	c7 65       	R7 += 0x38;		/* ( 56) */
8d4dd9d2:	07 30       	R0 = R7;
8d4dd9d4:	ff e3 b4 f9 	CALL 0x0x8d4dcd3c;
8d4dd9d8:	87 60       	R7 = 0x10 (X);		/*		R7=0x701(1793) */
8d4dd9da:	70 a3       	R0 = [SP + 0x34];
8d4dd9dc:	07 0a       	CC = R7 <= R0 (IU);
8d4dd9de:	45 18       	IF CC JUMP 0x0x8d4dda68;
8d4dd9e0:	35 b3       	[SP + 0x30] = R5;
8d4dd9e2:	b5 e6 20 00 	B[SP + 0x20] = R5;
8d4dd9e6:	84 bb       	[FP -0x20] = R4;
8d4dd9e8:	75 bb       	[FP -0x24] = R5;
8d4dd9ea:	b5 e6 3c 00 	B[SP + 0x3c] = R5;
8d4dd9ee:	4f 30       	R1 = FP;
8d4dd9f0:	41 67       	R1 += -0x18;		/* (-24) */
8d4dd9f2:	77 30       	R6 = FP;
8d4dd9f4:	46 66       	R6 += -0x38;		/* (-56) */
8d4dd9f6:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0x34] = R4 || NOP;
8d4dd9fa:	74 b3 00 00 
8d4dd9fe:	03 c8 00 18 	MNOP || R3 = [FP -0x4] || R2 = [FP -0x18];
8d4dda02:	f3 b9 a2 b9 
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
8d4dda84:	21 60       	R1 = 0x4 (X);		/*		R1=0x120(288) */
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
8d4ddb52:	21 61       	R1 = 0x24 (X);		/*		R1=0x120(288) */
8d4ddb54:	07 cc 01 40 	R0 = MIN (R0, R1) || R7 = [SP + 0xc] || NOP;
8d4ddb58:	f7 a0 00 00 
8d4ddb5c:	e1 62       	R1 = -0x24 (X);		/*		R1=0x120(288) */
8d4ddb5e:	07 c4 01 00 	R0 = MAX (R0, R1);
8d4ddb62:	01 e8 00 00 	UNLINK;
8d4ddb66:	20 65       	R0 += 0x24;		/* ( 36) */
8d4ddb68:	01 60       	R1 = 0x0 (X);		/*		R1=0x120(288) */
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
8d4ddcaa:	45 60       	R5 = 0x8 (X);		/*		R5=0x100(256) */
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
8d4ddcd2:	e7 61       	R7 = 0x3c (X);		/*		R7=0x701(1793) */
8d4ddcd4:	38 a1       	R0 = [FP + 0x10];
8d4ddcd6:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4ddcda:	c0 27 00 00 
8d4ddcde:	00 0c       	CC = R0 == 0x0;
8d4ddce0:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP + 0x10] || NOP;
8d4ddce4:	38 a1 00 00 
8d4ddce8:	02 1c       	IF CC JUMP 0x0x8d4ddcec (BP);
8d4ddcea:	eb 25       	JUMP.S 0x0x8d4de8c0;
8d4ddcec:	0f 60       	R7 = 0x1 (X);		/*		R7=0x701(1793) */
8d4ddcee:	02 0c       	CC = R2 == 0x0;
8d4ddcf0:	0f 18       	IF CC JUMP 0x0x8d4ddd0e;
8d4ddcf2:	50 b9       	R0 = [FP -0x2c];
8d4ddcf4:	81 60       	R1 = 0x10 (X);		/*		R1=0x120(288) */
8d4ddcf6:	01 0a       	CC = R1 <= R0 (IU);
8d4ddcf8:	02 14       	IF !CC JUMP 0x0x8d4ddcfc (BP);
8d4ddcfa:	dc 25       	JUMP.S 0x0x8d4de8b2;
8d4ddcfc:	02 60       	R2 = 0x0 (X);		/*		R2=0x2e6(742) */
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
8d4ddf92:	d7 61       	R7 = 0x3a (X);		/*		R7=0x701(1793) */
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
8d4de064:	07 60       	R7 = 0x0 (X);		/*		R7=0x701(1793) */
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
8d4de146:	7f 60       	R7 = 0xf (X);		/*		R7=0x701(1793) */
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
8d4de188:	07 60       	R7 = 0x0 (X);		/*		R7=0x701(1793) */
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
8d4de234:	25 60       	R5 = 0x4 (X);		/*		R5=0x100(256) */
8d4de236:	04 60       	R4 = 0x0 (X);		/*		R4=0x104(260) */
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
8d4de27c:	24 60       	R4 = 0x4 (X);		/*		R4=0x104(260) */
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
8d4de2c8:	04 60       	R4 = 0x0 (X);		/*		R4=0x104(260) */
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
8d4de30a:	24 60       	R4 = 0x4 (X);		/*		R4=0x104(260) */
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
8d4de924:	07 60       	R7 = 0x0 (X);		/*		R7=0x701(1793) */
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
