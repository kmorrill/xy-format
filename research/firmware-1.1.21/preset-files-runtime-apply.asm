
os.ldr@0x8d4dced8:     file format binary


Disassembly of section .data:

8d4dced8 <.data>:
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
8d4dd856:	Address 0x8d4dd858 is out of bounds.

