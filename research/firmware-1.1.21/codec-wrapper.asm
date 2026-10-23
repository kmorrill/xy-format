
os.ldr@0x8d585220:     file format binary


Disassembly of section .data:

8d585220 <.data>:
8d585220:	00 e8 08 00 	LINK 0x20;		/* (32) */
8d585224:	e3 05       	[--SP] = (R7:4, P5:3);
8d585226:	57 30       	R2 = FP;
8d585228:	26 6f       	SP += -0x1c;		/* (-28) */
8d58522a:	22 67       	R2 += -0x1c;		/* (-28) */
8d58522c:	82 ce 00 c8 	R4 = ROT R0 BY 0x0 || [SP + 0x38] = R2 || NOP;
8d585230:	b2 b3 00 00 
8d585234:	31 30       	R6 = R1;
8d585236:	29 30       	R5 = R1;
8d585238:	07 da 0a 84 	R7=-2079711276;
8d58523c:	d4 1f 00 00 
8d585240:	b0 a3       	R0 = [SP + 0x38];
8d585242:	ff e3 5d b9 	CALL 0x0x8d57c4fc;
8d585246:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [SP + 0x38] || NOP;
8d58524a:	b0 a3 00 00 
8d58524e:	ff e3 71 b9 	CALL 0x0x8d57c530;
8d585252:	00 0c       	CC = R0 == 0x0;
8d585254:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R0 = [SP + 0x38] || NOP;
8d585258:	b0 a3 00 00 
8d58525c:	16 19       	IF CC JUMP 0x0x8d585488;
8d58525e:	4f 30       	R1 = FP;
8d585260:	41 64       	R1 += 0x8;		/* (  8) */
8d585262:	42 60       	R2 = 0x8 (X);		/*		R2=0x0(  0) */
8d585264:	ff e3 d4 b9 	CALL 0x0x8d57c60c;
8d585268:	03 c8 00 18 	MNOP || R6 = [FP -0x4] || R1 = [FP + 0x8];
8d58526c:	f6 b9 b9 a0 
8d585270:	06 0c       	CC = R6 == 0x0;
8d585272:	43 60       	R3 = 0x8 (X);		/*		R3=0x0(  0) */
8d585274:	ee 10       	IF !CC JUMP 0x0x8d585450;
8d585276:	00 da bb aa 	R0=-1430532899;
8d58527a:	dd cc 00 00 
8d58527e:	01 08       	CC = R1 == R0;
8d585280:	cc 10       	IF !CC JUMP 0x0x8d585418;
8d585282:	b1 e4 64 00 	R1 = B[SP + 0x64] (Z);
8d585286:	99 08       	CC = R1 < R3;
8d585288:	ac 18       	IF CC JUMP 0x0x8d5853e0;
8d58528a:	48 60       	R0 = 0x9 (X);		/*		R0=0x0(  0) */
8d58528c:	88 08       	CC = R0 < R1;
8d58528e:	a9 18       	IF CC JUMP 0x0x8d5853e0;
8d585290:	03 c8 00 18 	MNOP || [SP + 0xc] = R4 || R0 = [SP + 0x38];
8d585294:	f4 b0 b0 a3 
8d585298:	b2 e4 65 00 	R2 = B[SP + 0x65] (Z);
8d58529c:	ff e3 d2 fb 	CALL 0x0x8d584a40;
8d5852a0:	0c 32       	P1 = R4;
8d5852a2:	00 0c       	CC = R0 == 0x0;
8d5852a4:	7e 18       	IF CC JUMP 0x0x8d5853a0;
8d5852a6:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP -0x4] || NOP;
8d5852aa:	f0 b9 00 00 
8d5852ae:	00 0c       	CC = R0 == 0x0;
8d5852b0:	5c 10       	IF !CC JUMP 0x0x8d585368;
8d5852b2:	28 e1 94 0d 	P0 = 0xd94 (X);		/*		P0=0xd94(3476) */
8d5852b6:	0a da 05 00 	P2=343848;
8d5852ba:	28 3f 00 00 
8d5852be:	41 5a       	P1 = P1 + P0;
8d5852c0:	51 5b       	P5 = P1 + P2;
8d5852c2:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d5852c4:	3d bd       	[FP + 0x10] = P5;
8d5852c6:	39 ad       	P1 = [FP + 0x10];
8d5852c8:	08 da 05 00 	P0=343876;
8d5852cc:	44 3f 00 00 
8d5852d0:	05 60       	R5 = 0x0 (X);		/*		R5=0x0(  0) */
8d5852d2:	01 80       	R0 = [P1 ++ P0];
8d5852d4:	00 0c       	CC = R0 == 0x0;
8d5852d6:	39 bd       	[FP + 0x10] = P1;
8d5852d8:	1f 18       	IF CC JUMP 0x0x8d585316;
8d5852da:	38 ad       	P0 = [FP + 0x10];
8d5852dc:	09 da f5 ff 	P1=-694804;
8d5852e0:	ec 65 00 00 
8d5852e4:	08 5b       	P4 = P0 + P1;
8d5852e6:	85 09       	CC = R5 < R0 (IU);
8d5852e8:	34 10       	IF !CC JUMP 0x0x8d585350;
8d5852ea:	20 e4 ea 06 	R0 = [P4 + 0x1ba8];
8d5852ee:	00 e3 75 e7 	CALL 0x0x8d5a21d8;
8d5852f2:	29 e1 f4 53 	P1 = 0x53f4 (X);		/*		P1=0x53f4(21492) */
8d5852f6:	00 0c       	CC = R0 == 0x0;
8d5852f8:	0c 5b       	P4 = P4 + P1;
8d5852fa:	0a 18       	IF CC JUMP 0x0x8d58530e;
8d5852fc:	5c 32       	P3 = P4;
8d5852fe:	44 60       	R4 = 0x8 (X);		/*		R4=0x0(  0) */
8d585300:	28 91       	R0 = [P5];
8d585302:	85 09       	CC = R5 < R0 (IU);
8d585304:	1a 10       	IF !CC JUMP 0x0x8d585338;
8d585306:	fc 67       	R4 += -0x1;		/* ( -1) */
8d585308:	04 0c       	CC = R4 == 0x0;
8d58530a:	1e 92       	[P3++] = R6;
8d58530c:	fa 17       	IF !CC JUMP 0x0x8d585300 (BP);
8d58530e:	0d 64       	R5 += 0x1;		/* (  1) */
8d585310:	28 91       	R0 = [P5];
8d585312:	85 09       	CC = R5 < R0 (IU);
8d585314:	e9 1f       	IF CC JUMP 0x0x8d5852e6 (BP);
8d585316:	ff 67       	R7 += -0x1;		/* ( -1) */
8d585318:	07 0c       	CC = R7 == 0x0;
8d58531a:	3d ad       	P5 = [FP + 0x10];
8d58531c:	d4 17       	IF !CC JUMP 0x0x8d5852c4 (BP);
8d58531e:	f0 b9       	R0 = [FP -0x4];
8d585320:	00 0c       	CC = R0 == 0x0;
8d585322:	06 02       	R6 = CC;
8d585324:	b0 a3       	R0 = [SP + 0x38];
8d585326:	ff e3 35 b9 	CALL 0x0x8d57c590;
8d58532a:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d58532c:	06 30       	R0 = R6;
8d58532e:	a3 05       	(R7:4, P5:3) = [SP++];
8d585330:	01 e8 00 00 	UNLINK;
8d585334:	10 00       	RTS;
8d585336:	00 00       	NOP;
8d585338:	00 da 09 84 	R0=-2079740064;
8d58533c:	60 af 00 00 
8d585340:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d585344:	a4 05 00 00 
8d585348:	df 2f       	JUMP.S 0x0x8d585306;
8d58534a:	00 00       	NOP;
8d58534c:	00 00       	NOP;
8d58534e:	00 00       	NOP;
8d585350:	00 da 09 84 	R0=-2079740064;
8d585354:	60 af 00 00 
8d585358:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d58535c:	a4 05 00 00 
8d585360:	c5 2f       	JUMP.S 0x0x8d5852ea;
8d585362:	00 00       	NOP;
8d585364:	00 00       	NOP;
8d585366:	00 00       	NOP;
8d585368:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d58536c:	fc 1e 00 00 
8d585370:	88 0c       	CC = R0 < 0x1;
8d585372:	d9 1f       	IF CC JUMP 0x0x8d585324 (BP);
8d585374:	35 b1       	[SP + 0x10] = R5;
8d585376:	b0 e4 64 00 	R0 = B[SP + 0x64] (Z);
8d58537a:	70 b1       	[SP + 0x14] = R0;
8d58537c:	b0 e4 65 00 	R0 = B[SP + 0x65] (Z);
8d585380:	b0 b1       	[SP + 0x18] = R0;
8d585382:	09 da 0a 84 	P1=-2079710340;
8d585386:	7c 23 00 00 
8d58538a:	f1 bc       	[SP + 0xc] = P1;
8d58538c:	22 e1 bb 01 	R2 = 0x1bb (X);		/*		R2=0x1bb(443) */
8d585390:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d585392:	00 de 04 8c 	CALL.A 0x8c040574;
8d585396:	74 05 00 00 
8d58539a:	c5 2f       	JUMP.S 0x0x8d585324;
8d58539c:	00 00       	NOP;
8d58539e:	00 00       	NOP;
8d5853a0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5853a4:	fc 1e 00 00 
8d5853a8:	88 0c       	CC = R0 < 0x1;
8d5853aa:	bd 1f       	IF CC JUMP 0x0x8d585324 (BP);
8d5853ac:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0x10] = R5 || NOP;
8d5853b0:	35 b1 00 00 
8d5853b4:	b0 e4 64 00 	R0 = B[SP + 0x64] (Z);
8d5853b8:	70 b1       	[SP + 0x14] = R0;
8d5853ba:	b0 e4 65 00 	R0 = B[SP + 0x65] (Z);
8d5853be:	b0 b1       	[SP + 0x18] = R0;
8d5853c0:	09 da 0a 84 	P1=-2079710388;
8d5853c4:	4c 23 00 00 
8d5853c8:	f1 bc       	[SP + 0xc] = P1;
8d5853ca:	22 e1 b6 01 	R2 = 0x1b6 (X);		/*		R2=0x1b6(438) */
8d5853ce:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d5853d0:	00 de 04 8c 	CALL.A 0x8c040574;
8d5853d4:	74 05 00 00 
8d5853d8:	a6 2f       	JUMP.S 0x0x8d585324;
8d5853da:	00 00       	NOP;
8d5853dc:	00 00       	NOP;
8d5853de:	00 00       	NOP;
8d5853e0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5853e4:	fc 1e 00 00 
8d5853e8:	88 0c       	CC = R0 < 0x1;
8d5853ea:	9d 1f       	IF CC JUMP 0x0x8d585324 (BP);
8d5853ec:	71 b1       	[SP + 0x14] = R1;
8d5853ee:	35 b1       	[SP + 0x10] = R5;
8d5853f0:	b0 e4 65 00 	R0 = B[SP + 0x65] (Z);
8d5853f4:	b0 b1       	[SP + 0x18] = R0;
8d5853f6:	09 da 0a 84 	P1=-2079710432;
8d5853fa:	20 23 00 00 
8d5853fe:	f1 bc       	[SP + 0xc] = P1;
8d585400:	22 e1 b1 01 	R2 = 0x1b1 (X);		/*		R2=0x1b1(433) */
8d585404:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d585406:	01 da 0a 84 	R1=-2079711276;
8d58540a:	d4 1f 00 00 
8d58540e:	00 de 04 8c 	CALL.A 0x8c040574;
8d585412:	74 05 00 00 
8d585416:	87 2f       	JUMP.S 0x0x8d585324;
8d585418:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d58541c:	fc 1e 00 00 
8d585420:	88 0c       	CC = R0 < 0x1;
8d585422:	81 1f       	IF CC JUMP 0x0x8d585324 (BP);
8d585424:	71 b1       	[SP + 0x14] = R1;
8d585426:	35 b1       	[SP + 0x10] = R5;
8d585428:	09 da 0a 84 	P1=-2079710472;
8d58542c:	f8 22 00 00 
8d585430:	f1 bc       	[SP + 0xc] = P1;
8d585432:	22 e1 ac 01 	R2 = 0x1ac (X);		/*		R2=0x1ac(428) */
8d585436:	01 da 0a 84 	R1=-2079711276;
8d58543a:	d4 1f 00 00 
8d58543e:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d585440:	00 de 04 8c 	CALL.A 0x8c040574;
8d585444:	74 05 00 00 
8d585448:	6e 2f       	JUMP.S 0x0x8d585324;
8d58544a:	00 00       	NOP;
8d58544c:	00 00       	NOP;
8d58544e:	00 00       	NOP;
8d585450:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d585454:	fc 1e 00 00 
8d585458:	88 0c       	CC = R0 < 0x1;
8d58545a:	03 10       	IF !CC JUMP 0x0x8d585460;
8d58545c:	06 60       	R6 = 0x0 (X);		/*		R6=0x0(  0) */
8d58545e:	63 2f       	JUMP.S 0x0x8d585324;
8d585460:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0x10] = R5 || NOP;
8d585464:	35 b1 00 00 
8d585468:	09 da 0a 84 	P1=-2079710508;
8d58546c:	d4 22 00 00 
8d585470:	f1 bc       	[SP + 0xc] = P1;
8d585472:	22 e1 a7 01 	R2 = 0x1a7 (X);		/*		R2=0x1a7(423) */
8d585476:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d585478:	00 de 04 8c 	CALL.A 0x8c040574;
8d58547c:	74 05 00 00 
8d585480:	ee 2f       	JUMP.S 0x0x8d58545c;
8d585482:	00 00       	NOP;
8d585484:	00 00       	NOP;
8d585486:	00 00       	NOP;
8d585488:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d58548c:	fc 1e 00 00 
8d585490:	88 0c       	CC = R0 < 0x1;
8d585492:	49 1f       	IF CC JUMP 0x0x8d585324 (BP);
8d585494:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0x10] = R5 || NOP;
8d585498:	35 b1 00 00 
8d58549c:	09 da 0a 84 	P1=-2079711196;
8d5854a0:	24 20 00 00 
8d5854a4:	f1 bc       	[SP + 0xc] = P1;
8d5854a6:	22 e1 a0 01 	R2 = 0x1a0 (X);		/*		R2=0x1a0(416) */
8d5854aa:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d5854ac:	00 de 04 8c 	CALL.A 0x8c040574;
8d5854b0:	74 05 00 00 
8d5854b4:	38 2f       	JUMP.S 0x0x8d585324;
8d5854b6:	00 00       	NOP;
