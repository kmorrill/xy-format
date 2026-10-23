
os.ldr@0x8c03ffac:     file format binary


Disassembly of section .data:

8c03ffac <.data>:
8c03ffac:	09 32       	P1 = R1;
8c03ffae:	00 e8 10 00 	LINK 0x40;		/* (64) */
8c03ffb2:	60 05       	[--SP] = (R7:4);
8c03ffb4:	86 6f       	SP += -0x10;		/* (-16) */
8c03ffb6:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8c03ffb8:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || R3 = [P1 + 0x18] || [FP + 0x10] = R1;
8c03ffbc:	8b a1 39 b1 
8c03ffc0:	1f 0a       	CC = R7 <= R3 (IU);
8c03ffc2:	fa b0       	[FP + 0xc] = R2;
8c03ffc4:	b8 b0       	[FP + 0x8] = R0;
8c03ffc6:	b5 b2       	[SP + 0x28] = R5;
8c03ffc8:	f5 b2       	[SP + 0x2c] = R5;
8c03ffca:	35 b3       	[SP + 0x30] = R5;
8c03ffcc:	f5 b3       	[SP + 0x3c] = R5;
8c03ffce:	85 bb       	[FP -0x20] = R5;
8c03ffd0:	b5 b3       	[SP + 0x38] = R5;
8c03ffd2:	21 64       	R1 += 0x4;		/* (  4) */
8c03ffd4:	03 10       	IF !CC JUMP 0x0x8c03ffda;
8c03ffd6:	09 32       	P1 = R1;
8c03ffd8:	09 91       	R1 = [P1];
8c03ffda:	01 30       	R0 = R1;
8c03ffdc:	03 e3 7f d3 	CALL 0x0x8c0ba6da;
8c03ffe0:	00 0c       	CC = R0 == 0x0;
8c03ffe2:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R1 = [SP + 0x38] || R2 = [SP + 0x3c];
8c03ffe6:	b1 a3 f2 a3 
8c03ffea:	e4 18       	IF CC JUMP 0x0x8c0401b2;
8c03ffec:	00 da 90 11 	R0=294680304;
8c03fff0:	f0 76 00 00 
8c03fff4:	20 64       	R0 += 0x4;		/* (  4) */
8c03fff6:	30 b2       	[SP + 0x20] = R0;
8c03fff8:	06 30       	R0 = R6;
8c03fffa:	03 e3 1d d4 	CALL 0x0x8c0ba834;
8c03fffe:	00 0c       	CC = R0 == 0x0;
8c040000:	08 32       	P1 = R0;
8c040002:	57 18       	IF CC JUMP 0x0x8c0400b0;
8c040004:	22 60       	R2 = 0x4 (X);		/*		R2=0x0(  0) */
8c040006:	89 e4 0a 00 	R1 = B[P1 + 0xa] (Z);
8c04000a:	11 08       	CC = R1 == R2;
8c04000c:	20 18       	IF CC JUMP 0x0x8c04004c;
8c04000e:	42 60       	R2 = 0x8 (X);		/*		R2=0x0(  0) */
8c040010:	11 08       	CC = R1 == R2;
8c040012:	f3 17       	IF !CC JUMP 0x0x8c03fff8 (BP);
8c040014:	7f 30       	R7 = FP;
8c040016:	27 67       	R7 += -0x1c;		/* (-28) */
8c040018:	08 30       	R1 = R0;
8c04001a:	07 30       	R0 = R7;
8c04001c:	59 64       	R1 += 0xb;		/* ( 11) */
8c04001e:	ff e3 f1 f6 	CALL 0x0x8c03ee00;
8c040022:	07 30       	R0 = R7;
8c040024:	0f 30       	R1 = R7;
8c040026:	80 67       	R0 += -0x10;		/* (-16) */
8c040028:	ff e3 b6 fe 	CALL 0x0x8c03fd94;
8c04002c:	f0 b9       	R0 = [FP -0x4];
8c04002e:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8c040030:	02 0a       	CC = R2 <= R0 (IU);
8c040032:	07 18       	IF CC JUMP 0x0x8c040040;
8c040034:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8c040036:	e5 bb       	[FP -0x8] = R5;
8c040038:	b5 e6 48 00 	B[SP + 0x48] = R5;
8c04003c:	f0 bb       	[FP -0x4] = R0;
8c04003e:	dd 2f       	JUMP.S 0x0x8c03fff8;
8c040040:	a0 b9       	R0 = [FP -0x18];
8c040042:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c040046:	e4 e3 00 00 
8c04004a:	f5 2f       	JUMP.S 0x0x8c040034;
8c04004c:	38 30       	R7 = R0;
8c04004e:	5f 64       	R7 += 0xb;		/* ( 11) */
8c040050:	07 30       	R0 = R7;
8c040052:	01 da 90 11 	R1=294680304;
8c040056:	f0 76 00 00 
8c04005a:	00 de 02 04 	CALL.A 0x040231b4;
8c04005e:	b4 31 00 00 
8c040062:	00 0c       	CC = R0 == 0x0;
8c040064:	ca 1f       	IF CC JUMP 0x0x8c03fff8 (BP);
8c040066:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x20] || NOP;
8c04006a:	31 a2 00 00 
8c04006e:	00 de 02 04 	CALL.A 0x040231b4;
8c040072:	b4 31 00 00 
8c040076:	00 0c       	CC = R0 == 0x0;
8c040078:	c0 1f       	IF CC JUMP 0x0x8c03fff8 (BP);
8c04007a:	0f 30       	R1 = R7;
8c04007c:	7f 30       	R7 = FP;
8c04007e:	27 67       	R7 += -0x1c;		/* (-28) */
8c040080:	07 30       	R0 = R7;
8c040082:	ff e3 bf f6 	CALL 0x0x8c03ee00;
8c040086:	07 30       	R0 = R7;
8c040088:	0f 30       	R1 = R7;
8c04008a:	00 67       	R0 += -0x20;		/* (-32) */
8c04008c:	ff e3 84 fe 	CALL 0x0x8c03fd94;
8c040090:	f0 b9       	R0 = [FP -0x4];
8c040092:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8c040094:	02 0a       	CC = R2 <= R0 (IU);
8c040096:	07 18       	IF CC JUMP 0x0x8c0400a4;
8c040098:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8c04009a:	e5 bb       	[FP -0x8] = R5;
8c04009c:	b5 e6 48 00 	B[SP + 0x48] = R5;
8c0400a0:	f0 bb       	[FP -0x4] = R0;
8c0400a2:	ab 2f       	JUMP.S 0x0x8c03fff8;
8c0400a4:	a0 b9       	R0 = [FP -0x18];
8c0400a6:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0400aa:	e4 e3 00 00 
8c0400ae:	f5 2f       	JUMP.S 0x0x8c040098;
8c0400b0:	06 30       	R0 = R6;
8c0400b2:	03 e3 48 d4 	CALL 0x0x8c0ba942;
8c0400b6:	03 c8 00 18 	MNOP || P1 = [FP + 0xc] || R0 = [FP + 0x14];
8c0400ba:	f9 ac 78 a1 
8c0400be:	00 0c       	CC = R0 == 0x0;
8c0400c0:	63 10       	IF !CC JUMP 0x0x8c040186;
8c0400c2:	03 c8 00 18 	MNOP || R7 = [SP + 0x28] || R6 = [SP + 0x2c];
8c0400c6:	b7 a2 f6 a2 
8c0400ca:	37 08       	CC = R7 == R6;
8c0400cc:	23 18       	IF CC JUMP 0x0x8c040112;
8c0400ce:	17 30       	R2 = R7;
8c0400d0:	67 30       	R4 = FP;
8c0400d2:	24 67       	R4 += -0x1c;		/* (-28) */
8c0400d4:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R1 = [FP + 0x10] || NOP;
8c0400d8:	39 a1 00 00 
8c0400dc:	ff e3 cb fb 	CALL 0x0x8c03f872;
8c0400e0:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R3 = [FP + 0x14] || R2 = [FP + 0xc];
8c0400e4:	7b a1 fa a0 
8c0400e8:	03 c8 00 18 	MNOP || [SP + 0xc] = R3 || R0 = [FP + 0x8];
8c0400ec:	f3 b0 b8 a0 
8c0400f0:	ff e3 5e ff 	CALL 0x0x8c03ffac;
8c0400f4:	f0 b9       	R0 = [FP -0x4];
8c0400f6:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8c0400f8:	01 0a       	CC = R1 <= R0 (IU);
8c0400fa:	40 18       	IF CC JUMP 0x0x8c04017a;
8c0400fc:	e7 64       	R7 += 0x1c;		/* ( 28) */
8c0400fe:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8c040100:	3e 08       	CC = R6 == R7;
8c040102:	82 ce 07 c4 	R2 = ROT R7 BY 0x0 || [FP -0x8] = R5 || NOP;
8c040106:	e5 bb 00 00 
8c04010a:	b5 e6 48 00 	B[SP + 0x48] = R5;
8c04010e:	f0 bb       	[FP -0x4] = R0;
8c040110:	e0 17       	IF !CC JUMP 0x0x8c0400d0 (BP);
8c040112:	03 c8 00 18 	MNOP || P1 = [FP + 0xc] || R0 = [FP + 0x14];
8c040116:	f9 ac 78 a1 
8c04011a:	00 0c       	CC = R0 == 0x0;
8c04011c:	25 18       	IF CC JUMP 0x0x8c040166;
8c04011e:	b1 a3       	R1 = [SP + 0x38];
8c040120:	01 0c       	CC = R1 == 0x0;
8c040122:	0b 18       	IF CC JUMP 0x0x8c040138;
8c040124:	47 30       	R0 = FP;
8c040126:	a0 66       	R0 += -0x2c;		/* (-44) */
8c040128:	f2 a3       	R2 = [SP + 0x3c];
8c04012a:	ff e3 3d fc 	CALL 0x0x8c03f9a4;
8c04012e:	b0 a3       	R0 = [SP + 0x38];
8c040130:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c040134:	e4 e3 00 00 
8c040138:	f5 b3       	[SP + 0x3c] = R5;
8c04013a:	85 bb       	[FP -0x20] = R5;
8c04013c:	03 c8 00 18 	MNOP || R1 = [SP + 0x28] || [SP + 0x38] = R5;
8c040140:	b1 a2 b5 b3 
8c040144:	01 0c       	CC = R1 == 0x0;
8c040146:	0b 18       	IF CC JUMP 0x0x8c04015c;
8c040148:	47 30       	R0 = FP;
8c04014a:	20 66       	R0 += -0x3c;		/* (-60) */
8c04014c:	f2 a2       	R2 = [SP + 0x2c];
8c04014e:	ff e3 2b fc 	CALL 0x0x8c03f9a4;
8c040152:	b0 a2       	R0 = [SP + 0x28];
8c040154:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c040158:	e4 e3 00 00 
8c04015c:	86 6c       	SP += 0x10;		/* ( 16) */
8c04015e:	20 05       	(R7:4) = [SP++];
8c040160:	01 e8 00 00 	UNLINK;
8c040164:	10 00       	RTS;
8c040166:	39 a1       	R1 = [FP + 0x10];
8c040168:	57 30       	R2 = FP;
8c04016a:	a2 66       	R2 += -0x2c;		/* (-44) */
8c04016c:	03 c8 00 18 	MNOP || [SP + 0xc] = R2 || R0 = [FP + 0x8];
8c040170:	f2 b0 b8 a0 
8c040174:	82 67       	R2 += -0x10;		/* (-16) */
8c040176:	61 00       	CALL (P1);
8c040178:	d3 2f       	JUMP.S 0x0x8c04011e;
8c04017a:	a0 b9       	R0 = [FP -0x18];
8c04017c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c040180:	e4 e3 00 00 
8c040184:	bc 2f       	JUMP.S 0x0x8c0400fc;
8c040186:	39 a1       	R1 = [FP + 0x10];
8c040188:	57 30       	R2 = FP;
8c04018a:	a2 66       	R2 += -0x2c;		/* (-44) */
8c04018c:	03 c8 00 18 	MNOP || [SP + 0xc] = R2 || R0 = [FP + 0x8];
8c040190:	f2 b0 b8 a0 
8c040194:	82 67       	R2 += -0x10;		/* (-16) */
8c040196:	61 00       	CALL (P1);
8c040198:	03 c8 00 18 	MNOP || R7 = [SP + 0x38] || R2 = [SP + 0x3c];
8c04019c:	b7 a3 f2 a3 
8c0401a0:	17 08       	CC = R7 == R2;
8c0401a2:	90 1b       	IF CC JUMP 0x0x8c0400c2;
8c0401a4:	47 30       	R0 = FP;
8c0401a6:	a0 66       	R0 += -0x2c;		/* (-44) */
8c0401a8:	0f 30       	R1 = R7;
8c0401aa:	ff e3 fd fb 	CALL 0x0x8c03f9a4;
8c0401ae:	f7 b3       	[SP + 0x3c] = R7;
8c0401b0:	89 2f       	JUMP.S 0x0x8c0400c2;
8c0401b2:	01 0c       	CC = R1 == 0x0;
8c0401b4:	0a 18       	IF CC JUMP 0x0x8c0401c8;
8c0401b6:	47 30       	R0 = FP;
8c0401b8:	a0 66       	R0 += -0x2c;		/* (-44) */
8c0401ba:	ff e3 f5 fb 	CALL 0x0x8c03f9a4;
8c0401be:	b0 a3       	R0 = [SP + 0x38];
8c0401c0:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0401c4:	e4 e3 00 00 
8c0401c8:	f5 b3       	[SP + 0x3c] = R5;
8c0401ca:	85 bb       	[FP -0x20] = R5;
8c0401cc:	03 c8 00 18 	MNOP || R1 = [SP + 0x28] || [SP + 0x38] = R5;
8c0401d0:	b1 a2 b5 b3 
8c0401d4:	01 0c       	CC = R1 == 0x0;
8c0401d6:	c3 1b       	IF CC JUMP 0x0x8c04015c;
8c0401d8:	47 30       	R0 = FP;
8c0401da:	20 66       	R0 += -0x3c;		/* (-60) */
8c0401dc:	f2 a2       	R2 = [SP + 0x2c];
8c0401de:	ff e3 e3 fb 	CALL 0x0x8c03f9a4;
8c0401e2:	b0 a2       	R0 = [SP + 0x28];
8c0401e4:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0401e8:	e4 e3 00 00 
8c0401ec:	86 6c       	SP += 0x10;		/* ( 16) */
8c0401ee:	20 05       	(R7:4) = [SP++];
8c0401f0:	01 e8 00 00 	UNLINK;
