
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d591de0.bin:     file format binary


Disassembly of section .data:

8d5a40d0 <.data+0x122f0>:
8d5a40d0:	00 e8 0a 00 	LINK 0x28;		/* (40) */
8d5a40d4:	e3 05       	[--SP] = (R7:4, P5:3);
8d5a40d6:	29 32       	P5 = R1;
8d5a40d8:	86 6f       	SP += -0x10;		/* (-16) */
8d5a40da:	65 60       	R5 = 0xc (X);		/*		R5=0x0(  0) */
8d5a40dc:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d5a40e0:	38 b1 00 00 
8d5a40e4:	30 b3       	[SP + 0x30] = R0;
8d5a40e6:	6a a1       	R2 = [P5 + 0x14];
8d5a40e8:	aa 09       	CC = R2 < R5 (IU);
8d5a40ea:	66 60       	R6 = 0xc (X);		/*		R6=0x0(  0) */
8d5a40ec:	02 10       	IF !CC JUMP 0x0x8d5a40f0;
8d5a40ee:	32 30       	R6 = R2;
8d5a40f0:	03 c8 00 18 	MNOP || [SP + 0x2c] = R1 || R2 = [P5 + 0x18];
8d5a40f4:	f1 b2 aa a1 
8d5a40f8:	21 64       	R1 += 0x4;		/* (  4) */
8d5a40fa:	b9 b0       	[FP + 0x8] = R1;
8d5a40fc:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d5a40fe:	13 0a       	CC = R3 <= R2 (IU);
8d5a4100:	62 60       	R2 = 0xc (X);		/*		R2=0x0(  0) */
8d5a4102:	03 c8 00 18 	MNOP || P1 = [FP + 0x8] || R0 = [FP + 0x8];
8d5a4106:	b9 ac b8 a0 
8d5a410a:	02 10       	IF !CC JUMP 0x0x8d5a410e;
8d5a410c:	08 91       	R0 = [P1];
8d5a410e:	ae 09       	CC = R6 < R5 (IU);
8d5a4110:	16 07       	IF CC R2 = R6;
8d5a4112:	01 da 0a 84 	R1=-2079689576;
8d5a4116:	98 74 00 00 
8d5a411a:	00 de 02 04 	CALL.A 0x04023068;
8d5a411e:	68 30 00 00 
8d5a4122:	00 0c       	CC = R0 == 0x0;
8d5a4124:	f8 b0       	[FP + 0xc] = R0;
8d5a4126:	07 10       	IF !CC JUMP 0x0x8d5a4134;
8d5a4128:	ae 09       	CC = R6 < R5 (IU);
8d5a412a:	f8 63       	R0 = -0x1 (X);		/*		R0=0x0(  0) */
8d5a412c:	03 18       	IF CC JUMP 0x0x8d5a4132;
8d5a412e:	35 08       	CC = R5 == R6;
8d5a4130:	10 02       	ILLEGAL;
8d5a4132:	f8 b0       	[FP + 0xc] = R0;
8d5a4134:	04 cc 12 44 	R2 = R2 - R2 (NS) || P0 = [FP + 0x10] || R0 = [FP + 0xc];
8d5a4138:	38 ad f8 a0 
8d5a413c:	00 0c       	CC = R0 == 0x0;
8d5a413e:	a4 10       	IF !CC JUMP 0x0x8d5a4286;
8d5a4140:	08 da bd 86 	P0=-2034409228;
8d5a4144:	f4 60 00 00 
8d5a4148:	03 c8 00 18 	MNOP || P4 = [P0 + 0x4] || R0 = [P0 + 0x4];
8d5a414c:	44 ac 40 a0 
8d5a4150:	4d 32       	P1 = P5;
8d5a4152:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R4 = [P0 + 0x8] || NOP;
8d5a4156:	84 a0 00 00 
8d5a415a:	21 6c       	P1 += 0x4;		/* (  4) */
8d5a415c:	00 65       	R0 += 0x20;		/* ( 32) */
8d5a415e:	71 bf       	[SP + 0x34] = P1;
8d5a4160:	84 6d       	P4 += 0x30;		/* ( 48) */
8d5a4162:	18 32       	P3 = R0;
8d5a4164:	3c 08       	CC = R4 == R7;
8d5a4166:	75 18       	IF CC JUMP 0x0x8d5a4250;
8d5a4168:	03 c8 00 18 	MNOP || R5 = [P4] || R0 = [P5 + 0x14];
8d5a416c:	25 91 68 a1 
8d5a4170:	85 09       	CC = R5 < R0 (IU);
8d5a4172:	c4 6d       	P4 += 0x38;		/* ( 56) */
8d5a4174:	06 18       	IF CC JUMP 0x0x8d5a4180;
8d5a4176:	c7 65       	R7 += 0x38;		/* ( 56) */
8d5a4178:	c3 6d       	P3 += 0x38;		/* ( 56) */
8d5a417a:	f5 2f       	JUMP.S 0x0x8d5a4164;
8d5a417c:	00 00       	NOP;
8d5a417e:	00 00       	NOP;
8d5a4180:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0006;
8d5a4184:	b8 00 06 00 
8d5a4188:	b5 09       	CC = R5 < R6 (IU);
8d5a418a:	02 10       	IF !CC JUMP 0x0x8d5a418e;
8d5a418c:	35 30       	R6 = R5;
8d5a418e:	5a a1       	R2 = [P3 + 0x14];
8d5a4190:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d5a4192:	13 0a       	CC = R3 <= R2 (IU);
8d5a4194:	4b 30       	R1 = P3;
8d5a4196:	02 10       	IF !CC JUMP 0x0x8d5a419a;
8d5a4198:	19 91       	R1 = [P3];
8d5a419a:	a8 09       	CC = R0 < R5 (IU);
8d5a419c:	02 10       	IF !CC JUMP 0x0x8d5a41a0;
8d5a419e:	28 30       	R5 = R0;
8d5a41a0:	03 c8 00 18 	MNOP || R2 = [P5 + 0x18] || R0 = [FP + 0x8];
8d5a41a4:	aa a1 b8 a0 
8d5a41a8:	13 0a       	CC = R3 <= R2 (IU);
8d5a41aa:	02 10       	IF !CC JUMP 0x0x8d5a41ae;
8d5a41ac:	68 a0       	R0 = [P5 + 0x4];
8d5a41ae:	b5 09       	CC = R5 < R6 (IU);
8d5a41b0:	16 30       	R2 = R6;
8d5a41b2:	15 07       	IF CC R2 = R5;
8d5a41b4:	00 de 02 04 	CALL.A 0x04023068;
8d5a41b8:	68 30 00 00 
8d5a41bc:	00 0c       	CC = R0 == 0x0;
8d5a41be:	06 10       	IF !CC JUMP 0x0x8d5a41ca;
8d5a41c0:	b5 09       	CC = R5 < R6 (IU);
8d5a41c2:	f8 63       	R0 = -0x1 (X);		/*		R0=0x0(  0) */
8d5a41c4:	03 18       	IF CC JUMP 0x0x8d5a41ca;
8d5a41c6:	2e 08       	CC = R6 == R5;
8d5a41c8:	10 02       	ILLEGAL;
8d5a41ca:	00 0c       	CC = R0 == 0x0;
8d5a41cc:	d5 13       	IF !CC JUMP 0x0x8d5a4176;
8d5a41ce:	03 c8 00 18 	MNOP || P1 = [SP + 0x34] || R0 = [P5 + 0x18];
8d5a41d2:	71 af a8 a1 
8d5a41d6:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d5a41d8:	01 0a       	CC = R1 <= R0 (IU);
8d5a41da:	20 e5 f2 ff 	P0 = [P4 + -0x38];
8d5a41de:	02 10       	IF !CC JUMP 0x0x8d5a41e2;
8d5a41e0:	69 ac       	P1 = [P5 + 0x4];
8d5a41e2:	41 5a       	P1 = P1 + P0;
8d5a41e4:	48 99       	R0 = B[P1] (X);
8d5a41e6:	79 61       	R1 = 0x2f (X);		/*		R1=0x0(  0) */
8d5a41e8:	08 08       	CC = R0 == R1;
8d5a41ea:	c6 17       	IF !CC JUMP 0x0x8d5a4176 (BP);
8d5a41ec:	77 30       	R6 = FP;
8d5a41ee:	26 67       	R6 += -0x1c;		/* (-28) */
8d5a41f0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a41f4:	b8 00 03 00 
8d5a41f8:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R3 || R1 = [SP + 0x2c];
8d5a41fc:	f3 b0 f1 a2 
8d5a4200:	22 e4 f2 ff 	R2 = [P4 + -0x38];
8d5a4204:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d5a4208:	a6 ec 00 00 
8d5a420c:	82 ce 06 c4 	R2 = ROT R6 BY 0x0 || R0 = [SP + 0x30] || NOP;
8d5a4210:	30 a3 00 00 
8d5a4214:	0f 30       	R1 = R7;
8d5a4216:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d5a421a:	e4 f0 00 00 
8d5a421e:	f0 b9       	R0 = [FP -0x4];
8d5a4220:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d5a4222:	03 0a       	CC = R3 <= R0 (IU);
8d5a4224:	09 18       	IF CC JUMP 0x0x8d5a4236;
8d5a4226:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a4228:	b0 e6 3c 00 	B[SP + 0x3c] = R0;
8d5a422c:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a422e:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a4230:	01 e8 00 00 	UNLINK;
8d5a4234:	10 00       	RTS;
8d5a4236:	f0 a3       	R0 = [SP + 0x3c];
8d5a4238:	f9 e3 d6 50 	CALL 0x0x8d4ce3e4;
8d5a423c:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a423e:	b0 e6 3c 00 	B[SP + 0x3c] = R0;
8d5a4242:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a4244:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a4246:	01 e8 00 00 	UNLINK;
8d5a424a:	10 00       	RTS;
8d5a424c:	00 00       	NOP;
8d5a424e:	00 00       	NOP;
8d5a4250:	03 c8 00 18 	MNOP || P0 = [FP + 0x10] || R2 = [FP + 0xc];
8d5a4254:	38 ad fa a0 
8d5a4258:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d5a425a:	03 c8 00 18 	MNOP || R1 = [SP + 0x2c] || R0 = [SP + 0x30];
8d5a425e:	f1 a2 30 a3 
8d5a4262:	42 b1       	[P0 + 0x14] = R2;
8d5a4264:	82 e6 04 00 	B[P0 + 0x4] = R2;
8d5a4268:	83 b1       	[P0 + 0x18] = R3;
8d5a426a:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a426e:	b8 00 03 00 
8d5a4272:	f3 b0       	[SP + 0xc] = R3;
8d5a4274:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a4278:	70 e9 00 00 
8d5a427c:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a427e:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a4280:	01 e8 00 00 	UNLINK;
8d5a4284:	10 00       	RTS;
8d5a4286:	f1 a2       	R1 = [SP + 0x2c];
8d5a4288:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d5a428a:	07 30       	R0 = R7;
8d5a428c:	42 b1       	[P0 + 0x14] = R2;
8d5a428e:	82 e6 04 00 	B[P0 + 0x4] = R2;
8d5a4292:	83 b1       	[P0 + 0x18] = R3;
8d5a4294:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a4298:	b8 00 03 00 
8d5a429c:	f3 b0       	[SP + 0xc] = R3;
8d5a429e:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a42a2:	70 e9 00 00 
8d5a42a6:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a42a8:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a42aa:	01 e8 00 00 	UNLINK;
8d5a42ae:	10 00       	RTS;
