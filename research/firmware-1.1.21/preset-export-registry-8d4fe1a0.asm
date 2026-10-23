
os.ldr@0x8d4fe1a0:     file format binary


Disassembly of section .data:

8d4fe1a0 <.data>:
8d4fe1a0:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d4fe1a4:	ff e3 e0 ff 	CALL 0x0x8d4fe164;
8d4fe1a8:	01 e8 00 00 	UNLINK;
8d4fe1ac:	10 00       	RTS;
8d4fe1ae:	00 00       	NOP;
8d4fe1b0:	00 00       	NOP;
8d4fe1b2:	00 00       	NOP;
8d4fe1b4:	00 e8 08 00 	LINK 0x20;		/* (32) */
8d4fe1b8:	e3 05       	[--SP] = (R7:4, P5:3);
8d4fe1ba:	86 61       	R6 = 0x30 (X);		/*		R6=0x0(  0) */
8d4fe1bc:	38 30       	R7 = R0;
8d4fe1be:	f0 40       	R0 *= R6;
8d4fe1c0:	08 32       	P1 = R0;
8d4fe1c2:	08 da 6d 84 	P0=-2073168304;
8d4fe1c6:	50 f6 00 00 
8d4fe1ca:	86 6f       	SP += -0x10;		/* (-16) */
8d4fe1cc:	82 ce 01 cc 	R6 = ROT R1 BY 0x0 || R4 = [FP + 0x14] || [SP + 0xc] = R1;
8d4fe1d0:	7c a1 f1 b0 
8d4fe1d4:	03 c8 00 18 	MNOP || R1 = [FP + 0x18] || R3 = [FP + 0x1c];
8d4fe1d8:	b9 a1 fb a1 
8d4fe1dc:	48 5a       	P1 = P0 + P1;
8d4fe1de:	41 30       	R0 = P1;
8d4fe1e0:	0a 92       	[P1++] = R2;
8d4fe1e2:	0c 92       	[P1++] = R4;
8d4fe1e4:	09 9b       	B[P1] = R1;
8d4fe1e6:	4b b0       	[P1 + 0x4] = R3;
8d4fe1e8:	80 64       	R0 += 0x10;		/* ( 16) */
8d4fe1ea:	6f 30       	R5 = FP;
8d4fe1ec:	02 da 04 84 	R2=-2080097444;
8d4fe1f0:	5c 3b 00 00 
8d4fe1f4:	01 61       	R1 = 0x20 (X);		/*		R1=0x0(  0) */
8d4fe1f6:	00 de 04 8c 	CALL.A 0x8c0499a8;
8d4fe1fa:	a8 99 00 00 
8d4fe1fe:	05 67       	R5 += -0x20;		/* (-32) */
8d4fe200:	0e 30       	R1 = R6;
8d4fe202:	05 30       	R0 = R5;
8d4fe204:	00 de 03 8c 	CALL.A 0x8c03ee00;
8d4fe208:	00 ee 00 00 
8d4fe20c:	0c da 6d 84 	P4=-2073169180;
8d4fe210:	e4 f2 00 00 
8d4fe214:	03 c8 00 18 	MNOP || P5 = [P4 + 0x4] || [FP -0x4] = R7;
8d4fe218:	65 ac f7 bb 
8d4fe21c:	06 da 6d 84 	R6=-2073169180;
8d4fe220:	e4 f2 00 00 
8d4fe224:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4fe226:	6b ac       	P3 = [P5 + 0x4];
8d4fe228:	99 e5 2d 00 	R1 = B[P3 + 0x2d] (X);
8d4fe22c:	01 0c       	CC = R1 == 0x0;
8d4fe22e:	14 10       	IF !CC JUMP 0x0x8d4fe256;
8d4fe230:	53 30       	R2 = P3;
8d4fe232:	0d 30       	R1 = R5;
8d4fe234:	62 64       	R2 += 0xc;		/* ( 12) */
8d4fe236:	00 da 6d 84 	R0=-2073169180;
8d4fe23a:	e4 f2 00 00 
8d4fe23e:	fe e3 cd ed 	CALL 0x0x8d4dbdd8;
8d4fe242:	4b 32       	P1 = P3;
8d4fe244:	00 0c       	CC = R0 == 0x0;
8d4fe246:	43 6c       	P3 += 0x8;		/* (  8) */
8d4fe248:	69 32       	P5 = P1;
8d4fe24a:	cb 07       	IF CC P1 = P3;
8d4fe24c:	4b 91       	P3 = [P1];
8d4fe24e:	99 e5 2d 00 	R1 = B[P3 + 0x2d] (X);
8d4fe252:	01 0c       	CC = R1 == 0x0;
8d4fe254:	ee 1f       	IF CC JUMP 0x0x8d4fe230 (BP);
8d4fe256:	47 43       	R7 = R0.B (Z);
8d4fe258:	07 0c       	CC = R7 == 0x0;
8d4fe25a:	bd bc       	[FP + 0x8] = P5;
8d4fe25c:	20 18       	IF CC JUMP 0x0x8d4fe29c;
8d4fe25e:	61 ac       	P1 = [P4 + 0x4];
8d4fe260:	55 30       	R2 = P5;
8d4fe262:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d4fe264:	08 91       	R0 = [P1];
8d4fe266:	10 08       	CC = R0 == R2;
8d4fe268:	62 18       	IF CC JUMP 0x0x8d4fe32c;
8d4fe26a:	a8 e5 2d 00 	R0 = B[P5 + 0x2d] (X);
8d4fe26e:	00 0c       	CC = R0 == 0x0;
8d4fe270:	5b 10       	IF !CC JUMP 0x0x8d4fe326;
8d4fe272:	68 91       	P0 = [P5];
8d4fe274:	80 e5 2d 00 	R0 = B[P0 + 0x2d] (X);
8d4fe278:	00 0c       	CC = R0 == 0x0;
8d4fe27a:	40 10       	IF !CC JUMP 0x0x8d4fe2fa;
8d4fe27c:	81 ac       	P1 = [P0 + 0x8];
8d4fe27e:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4fe282:	00 0c       	CC = R0 == 0x0;
8d4fe284:	0b 10       	IF !CC JUMP 0x0x8d4fe29a;
8d4fe286:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4fe294) LC0 count_fields=0x0/0x0;
8d4fe28a:	41 32       	P0 = P1;
8d4fe28c:	81 ac       	P1 = [P0 + 0x8];
8d4fe28e:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4fe292:	00 0c       	CC = R0 == 0x0;
8d4fe294:	03 10       	IF !CC JUMP 0x0x8d4fe29a;
8d4fe296:	81 ac       	P1 = [P0 + 0x8];
8d4fe298:	f7 2f       	JUMP.S 0x0x8d4fe286;
8d4fe29a:	b8 bc       	[FP + 0x8] = P0;
8d4fe29c:	00 da 6d 84 	R0=-2073169180;
8d4fe2a0:	e4 f2 00 00 
8d4fe2a4:	82 ce 05 c4 	R2 = ROT R5 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4fe2a8:	b9 a0 00 00 
8d4fe2ac:	61 64       	R1 += 0xc;		/* ( 12) */
8d4fe2ae:	fe e3 95 ed 	CALL 0x0x8d4dbdd8;
8d4fe2b2:	00 0c       	CC = R0 == 0x0;
8d4fe2b4:	1a 10       	IF !CC JUMP 0x0x8d4fe2e8;
8d4fe2b6:	e0 b9       	R0 = [FP -0x8];
8d4fe2b8:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4fe2ba:	01 0a       	CC = R1 <= R0 (IU);
8d4fe2bc:	09 18       	IF CC JUMP 0x0x8d4fe2ce;
8d4fe2be:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4fe2c0:	b0 e6 30 00 	B[SP + 0x30] = R0;
8d4fe2c4:	86 6c       	SP += 0x10;		/* ( 16) */
8d4fe2c6:	a3 05       	(R7:4, P5:3) = [SP++];
8d4fe2c8:	01 e8 00 00 	UNLINK;
8d4fe2cc:	10 00       	RTS;
8d4fe2ce:	30 a3       	R0 = [SP + 0x30];
8d4fe2d0:	fe e3 8a 80 	CALL 0x0x8d4ce3e4;
8d4fe2d4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4fe2d6:	b0 e6 30 00 	B[SP + 0x30] = R0;
8d4fe2da:	86 6c       	SP += 0x10;		/* ( 16) */
8d4fe2dc:	a3 05       	(R7:4, P5:3) = [SP++];
8d4fe2de:	01 e8 00 00 	UNLINK;
8d4fe2e2:	10 00       	RTS;
8d4fe2e4:	00 00       	NOP;
8d4fe2e6:	00 00       	NOP;
8d4fe2e8:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = R5 || NOP;
8d4fe2ec:	f5 b0 00 00 
8d4fe2f0:	06 30       	R0 = R6;
8d4fe2f2:	55 30       	R2 = P5;
8d4fe2f4:	ff e3 c8 fd 	CALL 0x0x8d4fde84;
8d4fe2f8:	df 2f       	JUMP.S 0x0x8d4fe2b6;
8d4fe2fa:	4d 32       	P1 = P5;
8d4fe2fc:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d4fe312) LC0 count_fields=0x0/0x0;
8d4fe300:	48 ac       	P0 = [P1 + 0x4];
8d4fe302:	80 e5 2d 00 	R0 = B[P0 + 0x2d] (X);
8d4fe306:	00 0c       	CC = R0 == 0x0;
8d4fe308:	07 10       	IF !CC JUMP 0x0x8d4fe316;
8d4fe30a:	41 30       	R0 = P1;
8d4fe30c:	01 91       	R1 = [P0];
8d4fe30e:	01 08       	CC = R1 == R0;
8d4fe310:	03 10       	IF !CC JUMP 0x0x8d4fe316;
8d4fe312:	48 32       	P1 = P0;
8d4fe314:	f4 2f       	JUMP.S 0x0x8d4fe2fc;
8d4fe316:	b9 bc       	[FP + 0x8] = P1;
8d4fe318:	ba ac       	P2 = [FP + 0x8];
8d4fe31a:	90 e5 2d 00 	R0 = B[P2 + 0x2d] (X);
8d4fe31e:	00 0c       	CC = R0 == 0x0;
