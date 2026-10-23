
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d55cf54 <.data+0x90f34>:
8d55cf54:	07 30       	R0 = R7;
8d55cf56:	00 de 0b 8c 	CALL.A 0x8c0ba834;
8d55cf5a:	34 a8 00 00 
8d55cf5e:	00 0c       	CC = R0 == 0x0;
8d55cf60:	02 14       	IF !CC JUMP 0x0x8d55cf64 (BP);
8d55cf62:	f6 21       	JUMP.S 0x0x8d55d34e;
8d55cf64:	58 64       	R0 += 0xb;		/* ( 11) */
8d55cf66:	08 32       	P1 = R0;
8d55cf68:	72 61       	R2 = 0x2e (X);		/*		R2=0x0(  0) */
8d55cf6a:	26 e1 88 00 	R6 = 0x88 (X);		/*		R6=0x88(136) */
8d55cf6e:	49 99       	R1 = B[P1] (X);
8d55cf70:	11 08       	CC = R1 == R2;
8d55cf72:	f1 1f       	IF CC JUMP 0x0x8d55cf54 (BP);
8d55cf74:	56 30       	R2 = SP;
8d55cf76:	b2 51       	R6 = R2 + R6;
8d55cf78:	08 30       	R1 = R0;
8d55cf7a:	34 e6 28 00 	[SP + 0xa0] = R4;
8d55cf7e:	35 e6 27 00 	[SP + 0x9c] = R5;
8d55cf82:	b5 e6 8c 00 	B[SP + 0x8c] = R5;
8d55cf86:	06 30       	R0 = R6;
8d55cf88:	00 de 09 8c 	CALL.A 0x8c09a376;
8d55cf8c:	76 a3 00 00 
8d55cf90:	06 30       	R0 = R6;
8d55cf92:	0e 30       	R1 = R6;
8d55cf94:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d55cf96:	02 e3 55 3c 	CALL 0x0x8d5a4840;
8d55cf9a:	5e 30       	R3 = SP;
8d55cf9c:	22 e1 a4 00 	R2 = 0xa4 (X);		/*		R2=0xa4(164) */
8d55cfa0:	13 50       	R0 = R3 + R2;
8d55cfa2:	01 da 06 84 	R1=-2079942004;
8d55cfa6:	8c 9a 00 00 
8d55cfaa:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d55cfae:	88 bf 00 00 
8d55cfb2:	00 0c       	CC = R0 == 0x0;
8d55cfb4:	24 10       	IF !CC JUMP 0x0x8d55cffc;
8d55cfb6:	30 e4 2f 00 	R0 = [SP + 0xbc];
8d55cfba:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d55cfbc:	01 0a       	CC = R1 <= R0 (IU);
8d55cfbe:	19 18       	IF CC JUMP 0x0x8d55cff0;
8d55cfc0:	30 e4 28 00 	R0 = [SP + 0xa0];
8d55cfc4:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d55cfc6:	01 0a       	CC = R1 <= R0 (IU);
8d55cfc8:	34 e6 2f 00 	[SP + 0xbc] = R4;
8d55cfcc:	35 e6 2e 00 	[SP + 0xb8] = R5;
8d55cfd0:	b5 e6 a8 00 	B[SP + 0xa8] = R5;
8d55cfd4:	08 18       	IF CC JUMP 0x0x8d55cfe4;
8d55cfd6:	34 e6 28 00 	[SP + 0xa0] = R4;
8d55cfda:	35 e6 27 00 	[SP + 0x9c] = R5;
8d55cfde:	b5 e6 8c 00 	B[SP + 0x8c] = R5;
8d55cfe2:	b9 2f       	JUMP.S 0x0x8d55cf54;
8d55cfe4:	30 e4 23 00 	R0 = [SP + 0x8c];
8d55cfe8:	fb e3 fe 89 	CALL 0x0x8d4ce3e4;
8d55cfec:	f5 2f       	JUMP.S 0x0x8d55cfd6;
8d55cfee:	00 00       	NOP;
8d55cff0:	30 e4 2a 00 	R0 = [SP + 0xa8];
8d55cff4:	fb e3 f8 89 	CALL 0x0x8d4ce3e4;
8d55cff8:	e4 2f       	JUMP.S 0x0x8d55cfc0;
8d55cffa:	00 00       	NOP;
8d55cffc:	33 e4 27 00 	R3 = [SP + 0x9c];
8d55d000:	31 e4 2e 00 	R1 = [SP + 0xb8];
8d55d004:	cb 52       	R3 = R3 - R1;
8d55d006:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d55d00a:	f3 b0 00 00 
8d55d00e:	0e 30       	R1 = R6;
8d55d010:	c0 65       	R0 += 0x38;		/* ( 56) */
8d55d012:	02 60       	R2 = 0x0 (X);		/*		R2=0xa4(164) */
8d55d014:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d55d018:	a6 ec 00 00 
8d55d01c:	03 c8 00 18 	MNOP || R0 = [P3 + 0x18] || R1 = [FP -0x4];
8d55d020:	98 a1 f1 b9 
8d55d024:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d55d026:	03 0a       	CC = R3 <= R0 (IU);
8d55d028:	21 64       	R1 += 0x4;		/* (  4) */
8d55d02a:	03 10       	IF !CC JUMP 0x0x8d55d030;
8d55d02c:	09 32       	P1 = R1;
8d55d02e:	09 91       	R1 = [P1];
8d55d030:	46 30       	R0 = SP;
8d55d032:	a3 61       	R3 = 0x34 (X);		/*		R3=0x0(  0) */
8d55d034:	34 e6 13 00 	[SP + 0x4c] = R4;
8d55d038:	35 e6 12 00 	[SP + 0x48] = R5;
8d55d03c:	b5 e6 38 00 	B[SP + 0x38] = R5;
8d55d040:	18 50       	R0 = R0 + R3;
8d55d042:	00 de 09 8c 	CALL.A 0x8c09a376;
8d55d046:	76 a3 00 00 
8d55d04a:	30 e4 36 00 	R0 = [SP + 0xd8];
8d55d04e:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d55d050:	01 0a       	CC = R1 <= R0 (IU);
8d55d052:	56 30       	R2 = SP;
8d55d054:	20 e1 50 00 	R0 = 0x50 (X);		/*		R0=0x50( 80) */
8d55d058:	82 50       	R2 = R2 + R0;
8d55d05a:	fa b0       	[FP + 0xc] = R2;
8d55d05c:	5e 30       	R3 = SP;
8d55d05e:	21 e1 c4 00 	R1 = 0xc4 (X);		/*		R1=0xc4(196) */
8d55d062:	4b 50       	R1 = R3 + R1;
8d55d064:	33 e4 31 00 	R3 = [SP + 0xc4];
8d55d068:	0b 07       	IF CC R1 = R3;
8d55d06a:	34 e6 1a 00 	[SP + 0x68] = R4;
8d55d06e:	35 e6 19 00 	[SP + 0x64] = R5;
8d55d072:	b5 e6 54 00 	B[SP + 0x54] = R5;
8d55d076:	f8 a0       	R0 = [FP + 0xc];
8d55d078:	00 de 09 8c 	CALL.A 0x8c09a376;
8d55d07c:	76 a3 00 00 
8d55d080:	03 c8 00 18 	MNOP || R0 = [P5 + 0x8] || R2 = [P5 + 0x4];
8d55d084:	a8 a0 6a a0 
8d55d088:	04 cc 02 40 	R0 = R0 - R2 (NS) || R1 = [FP + 0xc] || [SP + 0x14] = P4;
8d55d08c:	f9 a0 74 bd 
8d55d090:	03 da 49 92 	R3=-1840700269;
8d55d094:	93 24 00 00 
8d55d098:	31 cb c3 20 	R3 = R0 * R3 (M,T) || [SP + 0x10] = P4 || NOP;
8d55d09c:	34 bd 00 00 
8d55d0a0:	82 c6 08 05 	R2 = R0 >>> 0x1f;
8d55d0a4:	23 4d       	R3 >>>= 0x4;
8d55d0a6:	04 cc 1a 46 	R3 = R3 - R2 (NS) || R2 = [FP + 0xc] || NOP;
8d55d0aa:	fa a0 00 00 
8d55d0ae:	f3 b0       	[SP + 0xc] = R3;
8d55d0b0:	21 67       	R1 += -0x1c;		/* (-28) */
8d55d0b2:	00 da eb 84 	R0=-2064952556;
8d55d0b6:	14 53 00 00 
8d55d0ba:	02 e3 4b 57 	CALL 0x0x8d5a7f50;
8d55d0be:	30 e4 1a 00 	R0 = [SP + 0x68];
8d55d0c2:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d55d0c4:	03 0a       	CC = R3 <= R0 (IU);
8d55d0c6:	3f 19       	IF CC JUMP 0x0x8d55d344;
8d55d0c8:	30 e4 13 00 	R0 = [SP + 0x4c];
8d55d0cc:	81 60       	R1 = 0x10 (X);		/*		R1=0xc4(196) */
8d55d0ce:	01 0a       	CC = R1 <= R0 (IU);
8d55d0d0:	34 e6 1a 00 	[SP + 0x68] = R4;
8d55d0d4:	35 e6 19 00 	[SP + 0x64] = R5;
8d55d0d8:	b5 e6 54 00 	B[SP + 0x54] = R5;
8d55d0dc:	2f 19       	IF CC JUMP 0x0x8d55d33a;
8d55d0de:	46 30       	R0 = SP;
8d55d0e0:	23 e1 6c 00 	R3 = 0x6c (X);		/*		R3=0x6c(108) */
8d55d0e4:	04 cc 03 00 	R0 = R0 + R3 (NS) || R1 = [FP -0x8] || NOP;
8d55d0e8:	e1 b9 00 00 
8d55d0ec:	34 e6 13 00 	[SP + 0x4c] = R4;
8d55d0f0:	35 e6 12 00 	[SP + 0x48] = R5;
8d55d0f4:	b5 e6 38 00 	B[SP + 0x38] = R5;
8d55d0f8:	7a 61       	R2 = 0x2f (X);		/*		R2=0xa4(164) */
8d55d0fa:	fc e3 59 27 	CALL 0x0x8d4e1fac;
8d55d0fe:	0e 30       	R1 = R6;
8d55d100:	21 67       	R1 += -0x1c;		/* (-28) */
8d55d102:	20 e1 70 00 	R0 = 0x70 (X);		/*		R0=0x70(112) */
8d55d106:	01 50       	R0 = R1 + R0;
8d55d108:	16 30       	R2 = R6;
8d55d10a:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d55d10e:	e4 f0 00 00 
8d55d112:	30 e4 21 00 	R0 = [SP + 0x84];
8d55d116:	83 60       	R3 = 0x10 (X);		/*		R3=0x6c(108) */
8d55d118:	03 0a       	CC = R3 <= R0 (IU);
8d55d11a:	0b 19       	IF CC JUMP 0x0x8d55d330;
8d55d11c:	4e 30       	R1 = SP;
8d55d11e:	23 e1 dc 00 	R3 = 0xdc (X);		/*		R3=0xdc(220) */
8d55d122:	99 51       	R6 = R1 + R3;
8d55d124:	34 e6 21 00 	[SP + 0x84] = R4;
8d55d128:	35 e6 20 00 	[SP + 0x80] = R5;
8d55d12c:	b5 e6 70 00 	B[SP + 0x70] = R5;
8d55d130:	0e 30       	R1 = R6;
8d55d132:	00 da eb 84 	R0=-2064952592;
8d55d136:	f0 52 00 00 
8d55d13a:	00 de 03 8c 	CALL.A 0x8c03fd94;
8d55d13e:	94 fd 00 00 
8d55d142:	04 cc 12 44 	R2 = R2 - R2 (NS) || R3 = [FP -0xc] || NOP;
8d55d146:	d3 b9 00 00 
8d55d14a:	03 0c       	CC = R3 == 0x0;
8d55d14c:	d6 10       	IF !CC JUMP 0x0x8d55d2f8;
8d55d14e:	fa b0       	[FP + 0xc] = R2;
8d55d150:	01 60       	R1 = 0x0 (X);		/*		R1=0xc4(196) */
8d55d152:	00 da eb 84 	R0=-2064952576;
8d55d156:	00 53 00 00 
8d55d15a:	ff e3 25 fd 	CALL 0x0x8d55cba4;
8d55d15e:	fa a0       	R2 = [FP + 0xc];
8d55d160:	02 0c       	CC = R2 == 0x0;
8d55d162:	0c 18       	IF CC JUMP 0x0x8d55d17a;
8d55d164:	30 e4 21 00 	R0 = [SP + 0x84];
8d55d168:	81 60       	R1 = 0x10 (X);		/*		R1=0xc4(196) */
8d55d16a:	01 0a       	CC = R1 <= R0 (IU);
8d55d16c:	c0 18       	IF CC JUMP 0x0x8d55d2ec;
8d55d16e:	34 e6 21 00 	[SP + 0x84] = R4;
8d55d172:	35 e6 20 00 	[SP + 0x80] = R5;
8d55d176:	b5 e6 70 00 	B[SP + 0x70] = R5;
8d55d17a:	46 30       	R0 = SP;
8d55d17c:	21 e1 c0 00 	R1 = 0xc0 (X);		/*		R1=0xc0(192) */
8d55d180:	08 50       	R0 = R0 + R1;
8d55d182:	ff e3 d6 f0 	CALL 0x0x8d55b32e;
8d55d186:	38 0c       	CC = R0 == -0x1;
8d55d188:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP + 0xc] = R0 || NOP;
8d55d18c:	f8 b0 00 00 
8d55d190:	46 10       	IF !CC JUMP 0x0x8d55d21c;
8d55d192:	30 e4 3d 00 	R0 = [SP + 0xf4];
8d55d196:	81 60       	R1 = 0x10 (X);		/*		R1=0xc0(192) */
8d55d198:	01 0a       	CC = R1 <= R0 (IU);
8d55d19a:	3b 18       	IF CC JUMP 0x0x8d55d210;
8d55d19c:	30 e4 36 00 	R0 = [SP + 0xd8];
8d55d1a0:	81 60       	R1 = 0x10 (X);		/*		R1=0xc0(192) */
8d55d1a2:	01 0a       	CC = R1 <= R0 (IU);
8d55d1a4:	34 e6 3d 00 	[SP + 0xf4] = R4;
8d55d1a8:	35 e6 3c 00 	[SP + 0xf0] = R5;
8d55d1ac:	b5 e6 e0 00 	B[SP + 0xe0] = R5;
8d55d1b0:	2a 18       	IF CC JUMP 0x0x8d55d204;
8d55d1b2:	30 e4 2f 00 	R0 = [SP + 0xbc];
8d55d1b6:	81 60       	R1 = 0x10 (X);		/*		R1=0xc0(192) */
8d55d1b8:	01 0a       	CC = R1 <= R0 (IU);
8d55d1ba:	34 e6 36 00 	[SP + 0xd8] = R4;
8d55d1be:	35 e6 35 00 	[SP + 0xd4] = R5;
8d55d1c2:	b5 e6 c4 00 	B[SP + 0xc4] = R5;
8d55d1c6:	19 18       	IF CC JUMP 0x0x8d55d1f8;
8d55d1c8:	30 e4 28 00 	R0 = [SP + 0xa0];
8d55d1cc:	81 60       	R1 = 0x10 (X);		/*		R1=0xc0(192) */
8d55d1ce:	01 0a       	CC = R1 <= R0 (IU);
8d55d1d0:	34 e6 2f 00 	[SP + 0xbc] = R4;
8d55d1d4:	35 e6 2e 00 	[SP + 0xb8] = R5;
8d55d1d8:	b5 e6 a8 00 	B[SP + 0xa8] = R5;
8d55d1dc:	08 18       	IF CC JUMP 0x0x8d55d1ec;
8d55d1de:	34 e6 28 00 	[SP + 0xa0] = R4;
8d55d1e2:	35 e6 27 00 	[SP + 0x9c] = R5;
8d55d1e6:	b5 e6 8c 00 	B[SP + 0x8c] = R5;
8d55d1ea:	b5 2e       	JUMP.S 0x0x8d55cf54;
8d55d1ec:	30 e4 23 00 	R0 = [SP + 0x8c];
8d55d1f0:	fb e3 fa 88 	CALL 0x0x8d4ce3e4;
8d55d1f4:	f5 2f       	JUMP.S 0x0x8d55d1de;
8d55d1f6:	00 00       	NOP;
8d55d1f8:	30 e4 2a 00 	R0 = [SP + 0xa8];
8d55d1fc:	fb e3 f4 88 	CALL 0x0x8d4ce3e4;
8d55d200:	e4 2f       	JUMP.S 0x0x8d55d1c8;
8d55d202:	00 00       	NOP;
8d55d204:	30 e4 31 00 	R0 = [SP + 0xc4];
8d55d208:	fb e3 ee 88 	CALL 0x0x8d4ce3e4;
8d55d20c:	d3 2f       	JUMP.S 0x0x8d55d1b2;
8d55d20e:	00 00       	NOP;
8d55d210:	30 e4 38 00 	R0 = [SP + 0xe0];
8d55d214:	fb e3 e8 88 	CALL 0x0x8d4ce3e4;
8d55d218:	c2 2f       	JUMP.S 0x0x8d55d19c;
8d55d21a:	00 00       	NOP;
8d55d21c:	b5 e6 3c 01 	B[SP + 0x13c] = R5;
8d55d220:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d55d224:	b8 00 03 00 
8d55d228:	f3 b0       	[SP + 0xc] = R3;
8d55d22a:	4e 30       	R1 = SP;
8d55d22c:	23 e1 18 01 	R3 = 0x118 (X);		/*		R3=0x118(280) */
8d55d230:	04 cc 0b 02 	R1 = R1 + R3 (NS) || [FP -0x24] = R4 || NOP;
8d55d234:	74 bb 00 00 
8d55d238:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [FP -0x10] = R1 || NOP;
8d55d23c:	c1 bb 00 00 
8d55d240:	20 e1 5c 00 	R0 = 0x5c (X);		/*		R0=0x5c( 92) */
8d55d244:	04 cc 30 00 	R0 = R6 + R0 (NS) || [FP -0x28] = R5 || NOP;
8d55d248:	65 bb 00 00 
8d55d24c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d55d250:	70 e9 00 00 
8d55d254:	03 c8 00 18 	MNOP || R3 = [FP + 0xc] || R0 = [FP -0x10];
8d55d258:	fb a0 c0 b9 
8d55d25c:	57 30       	R2 = FP;
8d55d25e:	4f 30       	R1 = FP;
8d55d260:	bb b0       	[FP + 0x8] = R3;
8d55d262:	22 66       	R2 += -0x3c;		/* (-60) */
8d55d264:	41 64       	R1 += 0x8;		/* (  8) */
8d55d266:	ff e3 90 f3 	CALL 0x0x8d55b986;
8d55d26a:	03 c8 00 18 	MNOP || R0 = [FP -0x10] || R1 = [FP -0x10];
8d55d26e:	c0 b9 c1 b9 
8d55d272:	00 67       	R0 += -0x20;		/* (-32) */
8d55d274:	ff e3 78 f2 	CALL 0x0x8d55b764;
8d55d278:	26 e1 f8 00 	R6 = 0xf8 (X);		/*		R6=0xf8(248) */
8d55d27c:	5e 30       	R3 = SP;
8d55d27e:	73 50       	R1 = R3 + R6;
8d55d280:	00 da eb 84 	R0=-2064952644;
8d55d284:	bc 52 00 00 
8d55d288:	ff e3 84 fb 	CALL 0x0x8d55c990;
8d55d28c:	80 b8       	R0 = [FP -0x60];
8d55d28e:	82 60       	R2 = 0x10 (X);		/*		R2=0xa4(164) */
8d55d290:	02 0a       	CC = R2 <= R0 (IU);
8d55d292:	28 18       	IF CC JUMP 0x0x8d55d2e2;
8d55d294:	03 c8 00 18 	MNOP || R0 = [FP -0x40] || [FP -0x64] = R5;
8d55d298:	00 b9 75 ba 
8d55d29c:	81 60       	R1 = 0x10 (X);		/*		R1=0xc0(192) */
8d55d29e:	01 0a       	CC = R1 <= R0 (IU);
8d55d2a0:	b5 e6 00 01 	B[SP + 0x100] = R5;
8d55d2a4:	03 c8 00 18 	MNOP || [FP -0x60] = R4 || R0 = [FP -0x54];
8d55d2a8:	84 ba b0 b8 
8d55d2ac:	18 18       	IF CC JUMP 0x0x8d55d2dc;
8d55d2ae:	03 c8 00 18 	MNOP || R0 = [FP -0x24] || [FP -0x44] = R5;
8d55d2b2:	70 b9 f5 ba 
8d55d2b6:	81 60       	R1 = 0x10 (X);		/*		R1=0xc0(192) */
8d55d2b8:	01 0a       	CC = R1 <= R0 (IU);
8d55d2ba:	b5 e6 20 01 	B[SP + 0x120] = R5;
8d55d2be:	03 c8 00 18 	MNOP || [FP -0x40] = R4 || R0 = [FP -0x38];
8d55d2c2:	04 bb 20 b9 
8d55d2c6:	07 18       	IF CC JUMP 0x0x8d55d2d4;
8d55d2c8:	74 bb       	[FP -0x24] = R4;
8d55d2ca:	65 bb       	[FP -0x28] = R5;
8d55d2cc:	b5 e6 3c 01 	B[SP + 0x13c] = R5;
8d55d2d0:	61 2f       	JUMP.S 0x0x8d55d192;
8d55d2d2:	00 00       	NOP;
8d55d2d4:	fb e3 88 88 	CALL 0x0x8d4ce3e4;
8d55d2d8:	f8 2f       	JUMP.S 0x0x8d55d2c8;
8d55d2da:	00 00       	NOP;
8d55d2dc:	fb e3 84 88 	CALL 0x0x8d4ce3e4;
8d55d2e0:	e7 2f       	JUMP.S 0x0x8d55d2ae;
8d55d2e2:	30 b8       	R0 = [FP -0x74];
8d55d2e4:	fb e3 80 88 	CALL 0x0x8d4ce3e4;
8d55d2e8:	d6 2f       	JUMP.S 0x0x8d55d294;
8d55d2ea:	00 00       	NOP;
8d55d2ec:	30 e4 1c 00 	R0 = [SP + 0x70];
8d55d2f0:	fb e3 7a 88 	CALL 0x0x8d4ce3e4;
8d55d2f4:	3d 2f       	JUMP.S 0x0x8d55d16e;
8d55d2f6:	00 00       	NOP;
8d55d2f8:	23 e1 90 ff 	R3 = -0x70 (X);		/*		R3=0xffffff90(-112) */
8d55d2fc:	1e 50       	R0 = R6 + R3;
8d55d2fe:	0e 30       	R1 = R6;
8d55d300:	00 e3 40 19 	CALL 0x0x8d560580;
8d55d304:	33 e4 21 00 	R3 = [SP + 0x84];
8d55d308:	82 60       	R2 = 0x10 (X);		/*		R2=0xa4(164) */
8d55d30a:	4e 30       	R1 = SP;
8d55d30c:	20 e1 70 00 	R0 = 0x70 (X);		/*		R0=0x70(112) */
8d55d310:	1a 0a       	CC = R2 <= R3 (IU);
8d55d312:	01 50       	R0 = R1 + R0;
8d55d314:	33 e4 1c 00 	R3 = [SP + 0x70];
8d55d318:	03 07       	IF CC R0 = R3;
8d55d31a:	00 de 03 8c 	CALL.A 0x8c03e328;
8d55d31e:	28 e3 00 00 
8d55d322:	00 0c       	CC = R0 == 0x0;
8d55d324:	0a 60       	R2 = 0x1 (X);		/*		R2=0xa4(164) */
8d55d326:	14 1b       	IF CC JUMP 0x0x8d55d14e;
8d55d328:	fa b0       	[FP + 0xc] = R2;
8d55d32a:	09 60       	R1 = 0x1 (X);		/*		R1=0xc0(192) */
8d55d32c:	13 2f       	JUMP.S 0x0x8d55d152;
8d55d32e:	00 00       	NOP;
8d55d330:	30 e4 1c 00 	R0 = [SP + 0x70];
8d55d334:	fb e3 58 88 	CALL 0x0x8d4ce3e4;
8d55d338:	f2 2e       	JUMP.S 0x0x8d55d11c;
8d55d33a:	b0 a3       	R0 = [SP + 0x38];
8d55d33c:	fb e3 54 88 	CALL 0x0x8d4ce3e4;
8d55d340:	cf 2e       	JUMP.S 0x0x8d55d0de;
8d55d342:	00 00       	NOP;
8d55d344:	30 e4 15 00 	R0 = [SP + 0x54];
8d55d348:	fb e3 4e 88 	CALL 0x0x8d4ce3e4;
8d55d34c:	be 2e       	JUMP.S 0x0x8d55d0c8;
8d55d34e:	07 30       	R0 = R7;
8d55d350:	00 de 0b 8c 	CALL.A 0x8c0ba942;
8d55d354:	    
