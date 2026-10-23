
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d591de0.bin:     file format binary


Disassembly of section .data:

8d5a42b0 <.data+0x124d0>:
8d5a42b0:	00 e8 10 00 	LINK 0x40;		/* (64) */
8d5a42b4:	e3 05       	[--SP] = (R7:4, P5:3);
8d5a42b6:	29 32       	P5 = R1;
8d5a42b8:	86 6f       	SP += -0x10;		/* (-16) */
8d5a42ba:	f8 b0       	[FP + 0xc] = R0;
8d5a42bc:	30 b3       	[SP + 0x30] = R0;
8d5a42be:	20 32       	P4 = R0;
8d5a42c0:	6d a1       	R5 = [P5 + 0x14];
8d5a42c2:	05 0c       	CC = R5 == 0x0;
8d5a42c4:	27 19       	IF CC JUMP 0x0x8d5a4512;
8d5a42c6:	aa a1       	R2 = [P5 + 0x18];
8d5a42c8:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d5a42ca:	17 0a       	CC = R7 <= R2 (IU);
8d5a42cc:	5d 32       	P3 = P5;
8d5a42ce:	25 6c       	P5 += 0x4;		/* (  4) */
8d5a42d0:	4d 32       	P1 = P5;
8d5a42d2:	02 10       	IF !CC JUMP 0x0x8d5a42d6;
8d5a42d4:	69 91       	P1 = [P5];
8d5a42d6:	4b 99       	R3 = B[P1] (X);
8d5a42d8:	e6 61       	R6 = 0x3c (X);		/*		R6=0x0(  0) */
8d5a42da:	33 08       	CC = R3 == R6;
8d5a42dc:	1b 11       	IF !CC JUMP 0x0x8d5a4512;
8d5a42de:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || [SP + 0x2c] = R1 || NOP;
8d5a42e2:	f1 b2 00 00 
8d5a42e6:	20 64       	R0 += 0x4;		/* (  4) */
8d5a42e8:	38 b1       	[FP + 0x10] = R0;
8d5a42ea:	f3 61       	R3 = 0x3e (X);		/*		R3=0x0(  0) */
8d5a42ec:	17 0a       	CC = R7 <= R2 (IU);
8d5a42ee:	b3 e6 74 00 	B[SP + 0x74] = R3;
8d5a42f2:	3c a1       	R4 = [FP + 0x10];
8d5a42f4:	02 10       	IF !CC JUMP 0x0x8d5a42f8;
8d5a42f6:	2c 91       	R4 = [P5];
8d5a42f8:	f1 61       	R1 = 0x3e (X);		/*		R1=0x0(  0) */
8d5a42fa:	15 30       	R2 = R5;
8d5a42fc:	04 30       	R0 = R4;
8d5a42fe:	00 de 02 04 	CALL.A 0x04023048;
8d5a4302:	48 30 00 00 
8d5a4306:	30 30       	R6 = R0;
8d5a4308:	06 0c       	CC = R6 == 0x0;
8d5a430a:	fb 18       	IF CC JUMP 0x0x8d5a4500;
8d5a430c:	4f 30       	R1 = FP;
8d5a430e:	41 64       	R1 += 0x8;		/* (  8) */
8d5a4310:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d5a4312:	00 de 02 04 	CALL.A 0x04023068;
8d5a4316:	68 30 00 00 
8d5a431a:	00 0c       	CC = R0 == 0x0;
8d5a431c:	0a 18       	IF CC JUMP 0x0x8d5a4330;
8d5a431e:	26 52       	R0 = R6 - R4;
8d5a4320:	08 64       	R0 += 0x1;		/* (  1) */
8d5a4322:	45 53       	R5 = R5 - R0;
8d5a4324:	0e 64       	R6 += 0x1;		/* (  1) */
8d5a4326:	26 30       	R4 = R6;
8d5a4328:	b1 e5 74 00 	R1 = B[SP + 0x74] (X);
8d5a432c:	e7 2f       	JUMP.S 0x0x8d5a42fa;
8d5a432e:	00 00       	NOP;
8d5a4330:	03 c8 00 18 	MNOP || R1 = [P3 + 0x18] || R0 = [FP + 0x10];
8d5a4334:	99 a1 38 a1 
8d5a4338:	0f 0a       	CC = R7 <= R1 (IU);
8d5a433a:	02 10       	IF !CC JUMP 0x0x8d5a433e;
8d5a433c:	28 91       	R0 = [P5];
8d5a433e:	86 53       	R6 = R6 - R0;
8d5a4340:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d5a4344:	b8 00 00 00 
8d5a4348:	06 08       	CC = R6 == R0;
8d5a434a:	c3 18       	IF CC JUMP 0x0x8d5a44d0;
8d5a434c:	5f 30       	R3 = FP;
8d5a434e:	23 67       	R3 += -0x1c;		/* (-28) */
8d5a4350:	0e 64       	R6 += 0x1;		/* (  1) */
8d5a4352:	47 30       	R0 = FP;
8d5a4354:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP + 0x10] = R3 || R1 = [SP + 0x2c];
8d5a4358:	3b b1 f1 a2 
8d5a435c:	f6 b0       	[SP + 0xc] = R6;
8d5a435e:	40 66       	R0 += -0x38;		/* (-56) */
8d5a4360:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d5a4364:	a6 ec 00 00 
8d5a4368:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d5a436c:	b8 00 02 00 
8d5a4370:	82 ce 06 c4 	R2 = ROT R6 BY 0x0 || [SP + 0xc] = R2 || R1 = [SP + 0x2c];
8d5a4374:	f2 b0 f1 a2 
8d5a4378:	38 a1       	R0 = [FP + 0x10];
8d5a437a:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d5a437e:	a6 ec 00 00 
8d5a4382:	09 da bd 86 	P1=-2034409228;
8d5a4386:	f4 60 00 00 
8d5a438a:	03 c8 00 18 	MNOP || P5 = [P1 + 0x4] || R0 = [P1 + 0x8];
8d5a438e:	4d ac 88 a0 
8d5a4392:	03 c8 00 18 	MNOP || [FP + 0xc] = R0 || R6 = [P1 + 0x4];
8d5a4396:	f8 b0 4e a0 
8d5a439a:	25 6c       	P5 += 0x4;		/* (  4) */
8d5a439c:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || R0 = [FP + 0xc] || R1 = [SP + 0x2c];
8d5a43a0:	f8 a0 f1 a2 
8d5a43a4:	30 08       	CC = R0 == R6;
8d5a43a6:	57 18       	IF CC JUMP 0x0x8d5a4454;
8d5a43a8:	4f 30       	R1 = FP;
8d5a43aa:	61 66       	R1 += -0x34;		/* (-52) */
8d5a43ac:	45 30       	R0 = P5;
8d5a43ae:	72 b9       	R2 = [FP -0x24];
8d5a43b0:	82 ce 02 c8 	R4 = ROT R2 BY 0x0 || R3 = [FP -0x20] || R5 = [SP + 0x38];
8d5a43b4:	83 b9 b5 a3 
8d5a43b8:	1f 0a       	CC = R7 <= R3 (IU);
8d5a43ba:	0d 07       	IF CC R1 = R5;
8d5a43bc:	03 c8 00 18 	MNOP || R3 = [P5 + 0x14] || R5 = [P5 + 0x10];
8d5a43c0:	6b a1 2d a1 
8d5a43c4:	1f 0a       	CC = R7 <= R3 (IU);
8d5a43c6:	02 10       	IF !CC JUMP 0x0x8d5a43ca;
8d5a43c8:	28 91       	R0 = [P5];
8d5a43ca:	95 09       	CC = R5 < R2 (IU);
8d5a43cc:	15 07       	IF CC R2 = R5;
8d5a43ce:	00 de 02 04 	CALL.A 0x04023068;
8d5a43d2:	68 30 00 00 
8d5a43d6:	00 0c       	CC = R0 == 0x0;
8d5a43d8:	06 10       	IF !CC JUMP 0x0x8d5a43e4;
8d5a43da:	a5 09       	CC = R5 < R4 (IU);
8d5a43dc:	f8 63       	R0 = -0x1 (X);		/*		R0=0x0(  0) */
8d5a43de:	03 18       	IF CC JUMP 0x0x8d5a43e4;
8d5a43e0:	2c 08       	CC = R4 == R5;
8d5a43e2:	10 02       	ILLEGAL;
8d5a43e4:	00 0c       	CC = R0 == 0x0;
8d5a43e6:	04 18       	IF CC JUMP 0x0x8d5a43ee;
8d5a43e8:	c6 65       	R6 += 0x38;		/* ( 56) */
8d5a43ea:	c5 6d       	P5 += 0x38;		/* ( 56) */
8d5a43ec:	d8 2f       	JUMP.S 0x0x8d5a439c;
8d5a43ee:	e5 6f       	P5 += -0x4;		/* ( -4) */
8d5a43f0:	4d 30       	R1 = P5;
8d5a43f2:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d5a43f4:	03 c8 00 18 	MNOP || R2 = [FP + 0x10] || R0 = [SP + 0x30];
8d5a43f8:	3a a1 30 a3 
8d5a43fc:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d5a4400:	e4 f0 00 00 
8d5a4404:	f0 b9       	R0 = [FP -0x4];
8d5a4406:	07 0a       	CC = R7 <= R0 (IU);
8d5a4408:	22 18       	IF CC JUMP 0x0x8d5a444c;
8d5a440a:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a440c:	b0 e6 54 00 	B[SP + 0x54] = R0;
8d5a4410:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP -0x20] || NOP;
8d5a4414:	80 b9 00 00 
8d5a4418:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8d5a441a:	07 0a       	CC = R7 <= R0 (IU);
8d5a441c:	04 cc 00 40 	R0 = R0 - R0 (NS) || [FP -0x8] = R2 || NOP;
8d5a4420:	e2 bb 00 00 
8d5a4424:	f1 bb       	[FP -0x4] = R1;
8d5a4426:	08 18       	IF CC JUMP 0x0x8d5a4436;
8d5a4428:	b0 e6 38 00 	B[SP + 0x38] = R0;
8d5a442c:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a442e:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a4430:	01 e8 00 00 	UNLINK;
8d5a4434:	10 00       	RTS;
8d5a4436:	b0 a3       	R0 = [SP + 0x38];
8d5a4438:	f9 e3 d6 4f 	CALL 0x0x8d4ce3e4;
8d5a443c:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a443e:	b0 e6 38 00 	B[SP + 0x38] = R0;
8d5a4442:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a4444:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a4446:	01 e8 00 00 	UNLINK;
8d5a444a:	10 00       	RTS;
8d5a444c:	a0 b9       	R0 = [FP -0x18];
8d5a444e:	f9 e3 cb 4f 	CALL 0x0x8d4ce3e4;
8d5a4452:	dc 2f       	JUMP.S 0x0x8d5a440a;
8d5a4454:	30 a3       	R0 = [SP + 0x30];
8d5a4456:	04 cc 1b 46 	R3 = R3 - R3 (NS) || [P4 + 0x14] = R5 || NOP;
8d5a445a:	65 b1 00 00 
8d5a445e:	7e 60       	R6 = 0xf (X);		/*		R6=0x0(  0) */
8d5a4460:	a3 e6 04 00 	B[P4 + 0x4] = R3;
8d5a4464:	04 cc 12 44 	R2 = R2 - R2 (NS) || [P4 + 0x18] = R6 || NOP;
8d5a4468:	a6 b1 00 00 
8d5a446c:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a4470:	b8 00 03 00 
8d5a4474:	f3 b0       	[SP + 0xc] = R3;
8d5a4476:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a447a:	70 e9 00 00 
8d5a447e:	f0 b9       	R0 = [FP -0x4];
8d5a4480:	07 0a       	CC = R7 <= R0 (IU);
8d5a4482:	20 18       	IF CC JUMP 0x0x8d5a44c2;
8d5a4484:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP -0x20] || [FP -0x4] = R6;
8d5a4488:	80 b9 f6 bb 
8d5a448c:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP -0x8] = R2 || NOP;
8d5a4490:	e2 bb 00 00 
8d5a4494:	07 0a       	CC = R7 <= R0 (IU);
8d5a4496:	b1 e6 54 00 	B[SP + 0x54] = R1;
8d5a449a:	09 18       	IF CC JUMP 0x0x8d5a44ac;
8d5a449c:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a449e:	b0 e6 38 00 	B[SP + 0x38] = R0;
8d5a44a2:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a44a4:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a44a6:	01 e8 00 00 	UNLINK;
8d5a44aa:	10 00       	RTS;
8d5a44ac:	b0 a3       	R0 = [SP + 0x38];
8d5a44ae:	f9 e3 9b 4f 	CALL 0x0x8d4ce3e4;
8d5a44b2:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a44b4:	b0 e6 38 00 	B[SP + 0x38] = R0;
8d5a44b8:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a44ba:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a44bc:	01 e8 00 00 	UNLINK;
8d5a44c0:	10 00       	RTS;
8d5a44c2:	a0 b9       	R0 = [FP -0x18];
8d5a44c4:	f9 e3 90 4f 	CALL 0x0x8d4ce3e4;
8d5a44c8:	de 2f       	JUMP.S 0x0x8d5a4484;
8d5a44ca:	00 00       	NOP;
8d5a44cc:	00 00       	NOP;
8d5a44ce:	00 00       	NOP;
8d5a44d0:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP + 0xc] || R1 = [SP + 0x2c];
8d5a44d4:	f8 a0 f1 a2 
8d5a44d8:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d5a44da:	62 b1       	[P4 + 0x14] = R2;
8d5a44dc:	a2 e6 04 00 	B[P4 + 0x4] = R2;
8d5a44e0:	a3 b1       	[P4 + 0x18] = R3;
8d5a44e2:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a44e6:	b8 00 03 00 
8d5a44ea:	f3 b0       	[SP + 0xc] = R3;
8d5a44ec:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a44f0:	70 e9 00 00 
8d5a44f4:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a44f6:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a44f8:	01 e8 00 00 	UNLINK;
8d5a44fc:	10 00       	RTS;
8d5a44fe:	00 00       	NOP;
8d5a4500:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d5a4504:	b8 00 00 00 
8d5a4508:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0006;
8d5a450c:	b8 00 06 00 
8d5a4510:	1c 2f       	JUMP.S 0x0x8d5a4348;
8d5a4512:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a4514:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d5a4516:	62 b1       	[P4 + 0x14] = R2;
8d5a4518:	a2 e6 04 00 	B[P4 + 0x4] = R2;
8d5a451c:	a3 b1       	[P4 + 0x18] = R3;
8d5a451e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a4522:	b8 00 03 00 
8d5a4526:	f3 b0       	[SP + 0xc] = R3;
8d5a4528:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a452c:	70 e9 00 00 
8d5a4530:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a4532:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a4534:	01 e8 00 00 	UNLINK;
8d5a4538:	10 00       	RTS;
	...
