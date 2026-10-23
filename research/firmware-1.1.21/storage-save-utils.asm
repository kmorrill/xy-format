
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d5612d0 <.data+0x952b0>:
8d5612d0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5612d4:	e5 05       	[--SP] = (R7:4, P5:5);
8d5612d6:	20 30       	R4 = R0;
8d5612d8:	47 30       	R0 = FP;
8d5612da:	31 30       	R6 = R1;
8d5612dc:	86 6f       	SP += -0x10;		/* (-16) */
8d5612de:	68 64       	R0 += 0xd;		/* ( 13) */
8d5612e0:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d5612e2:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d5612e4:	00 de 02 04 	CALL.A 0x04022ea8;
8d5612e8:	a8 2e 00 00 
8d5612ec:	2e 32       	P5 = R6;
8d5612ee:	57 30       	R2 = FP;
8d5612f0:	62 64       	R2 += 0xc;		/* ( 12) */
8d5612f2:	0a 30       	R1 = R2;
8d5612f4:	04 30       	R0 = R4;
8d5612f6:	09 64       	R1 += 0x1;		/* (  1) */
8d5612f8:	ff e3 be ff 	CALL 0x0x8d561274;
8d5612fc:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R1 = [P5 + 0x18] || NOP;
8d561300:	a9 a1 00 00 
8d561304:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d561306:	0f 0a       	CC = R7 <= R1 (IU);
8d561308:	20 64       	R0 += 0x4;		/* (  4) */
8d56130a:	0d 60       	R5 = 0x1 (X);		/*		R5=0x0(  0) */
8d56130c:	08 32       	P1 = R0;
8d56130e:	02 10       	IF !CC JUMP 0x0x8d561312;
8d561310:	08 91       	R0 = [P1];
8d561312:	00 de 0b 8c 	CALL.A 0x8c0ba6da;
8d561316:	da a6 00 00 
8d56131a:	00 0c       	CC = R0 == 0x0;
8d56131c:	30 30       	R6 = R0;
8d56131e:	81 18       	IF CC JUMP 0x0x8d561420;
8d561320:	77 61       	R7 = 0x2e (X);		/*		R7=0x0(  0) */
8d561322:	06 30       	R0 = R6;
8d561324:	00 de 0b 8c 	CALL.A 0x8c0ba834;
8d561328:	34 a8 00 00 
8d56132c:	00 0c       	CC = R0 == 0x0;
8d56132e:	74 18       	IF CC JUMP 0x0x8d561416;
8d561330:	58 64       	R0 += 0xb;		/* ( 11) */
8d561332:	08 32       	P1 = R0;
8d561334:	2c 32       	P5 = R4;
8d561336:	52 60       	R2 = 0xa (X);		/*		R2=0x0(  0) */
8d561338:	49 99       	R1 = B[P1] (X);
8d56133a:	39 08       	CC = R1 == R7;
8d56133c:	f3 1b       	IF CC JUMP 0x0x8d561322;
8d56133e:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d561340:	00 de ed 8f 	CALL.A 0x8fed45ac;
8d561344:	ac 45 00 00 
8d561348:	04 ce 2a 84 	R2 = PACK (R2.H, R5.L) || [SP + 0x2c] = R0 || NOP;
8d56134c:	f0 b2 00 00 
8d561350:	6d ac       	P5 = [P5 + 0x4];
8d561352:	69 ac       	P1 = [P5 + 0x4];
8d561354:	55 32       	P2 = P5;
8d561356:	89 e5 11 00 	R1 = B[P1 + 0x11] (X);
8d56135a:	01 0c       	CC = R1 == 0x0;
8d56135c:	11 10       	IF !CC JUMP 0x0x8d56137e;
8d56135e:	c0 e0 0c 00 	LSETUP_IMM(bottom=0x8d561376) LC0 count_fields=0x0/0x0;
8d561362:	c9 a0       	R1 = [P1 + 0xc];
8d561364:	51 32       	P2 = P1;
8d561366:	88 08       	CC = R0 < R1;
8d561368:	41 6c       	P1 += 0x8;		/* (  8) */
8d56136a:	42 32       	P0 = P2;
8d56136c:	c1 06       	IF !CC P0 = P1;
8d56136e:	41 91       	P1 = [P0];
8d561370:	8a e5 11 00 	R2 = B[P1 + 0x11] (X);
8d561374:	02 0c       	CC = R2 == 0x0;
8d561376:	02 10       	IF !CC JUMP 0x0x8d56137a;
8d561378:	f3 2f       	JUMP.S 0x0x8d56135e;
8d56137a:	88 08       	CC = R0 < R1;
8d56137c:	02 02       	R2 = CC;
8d56137e:	51 43       	R1 = R2.B (Z);
8d561380:	01 0c       	CC = R1 == 0x0;
8d561382:	42 32       	P0 = P2;
8d561384:	1d 18       	IF CC JUMP 0x0x8d5613be;
8d561386:	2b 91       	R3 = [P5];
8d561388:	52 30       	R2 = P2;
8d56138a:	13 08       	CC = R3 == R2;
8d56138c:	3b 18       	IF CC JUMP 0x0x8d561402;
8d56138e:	92 e5 11 00 	R2 = B[P2 + 0x11] (X);
8d561392:	02 0c       	CC = R2 == 0x0;
8d561394:	35 10       	IF !CC JUMP 0x0x8d5613fe;
8d561396:	50 91       	P0 = [P2];
8d561398:	82 e5 11 00 	R2 = B[P0 + 0x11] (X);
8d56139c:	02 0c       	CC = R2 == 0x0;
8d56139e:	1d 10       	IF !CC JUMP 0x0x8d5613d8;
8d5613a0:	81 ac       	P1 = [P0 + 0x8];
8d5613a2:	8a e5 11 00 	R2 = B[P1 + 0x11] (X);
8d5613a6:	02 0c       	CC = R2 == 0x0;
8d5613a8:	0b 10       	IF !CC JUMP 0x0x8d5613be;
8d5613aa:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d5613b8) LC0 count_fields=0x0/0x0;
8d5613ae:	41 32       	P0 = P1;
8d5613b0:	81 ac       	P1 = [P0 + 0x8];
8d5613b2:	8a e5 11 00 	R2 = B[P1 + 0x11] (X);
8d5613b6:	02 0c       	CC = R2 == 0x0;
8d5613b8:	03 10       	IF !CC JUMP 0x0x8d5613be;
8d5613ba:	81 ac       	P1 = [P0 + 0x8];
8d5613bc:	f7 2f       	JUMP.S 0x0x8d5613aa;
8d5613be:	c2 a0       	R2 = [P0 + 0xc];
8d5613c0:	82 08       	CC = R2 < R0;
8d5613c2:	b0 17       	IF !CC JUMP 0x0x8d561322 (BP);
8d5613c4:	52 30       	R2 = P2;
8d5613c6:	47 30       	R0 = FP;
8d5613c8:	40 64       	R0 += 0x8;		/* (  8) */
8d5613ca:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d5613ce:	f0 b0 00 00 
8d5613d2:	ff e3 33 fe 	CALL 0x0x8d561038;
8d5613d6:	a6 2f       	JUMP.S 0x0x8d561322;
8d5613d8:	42 32       	P0 = P2;
8d5613da:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d5613f0) LC0 count_fields=0x0/0x0;
8d5613de:	41 ac       	P1 = [P0 + 0x4];
8d5613e0:	8a e5 11 00 	R2 = B[P1 + 0x11] (X);
8d5613e4:	02 0c       	CC = R2 == 0x0;
8d5613e6:	07 10       	IF !CC JUMP 0x0x8d5613f4;
8d5613e8:	50 30       	R2 = P0;
8d5613ea:	0b 91       	R3 = [P1];
8d5613ec:	13 08       	CC = R3 == R2;
8d5613ee:	03 10       	IF !CC JUMP 0x0x8d5613f4;
8d5613f0:	41 32       	P0 = P1;
8d5613f2:	f4 2f       	JUMP.S 0x0x8d5613da;
8d5613f4:	82 e5 11 00 	R2 = B[P0 + 0x11] (X);
8d5613f8:	02 0c       	CC = R2 == 0x0;
8d5613fa:	c1 07       	IF CC P0 = P1;
8d5613fc:	e1 2f       	JUMP.S 0x0x8d5613be;
8d5613fe:	90 ac       	P0 = [P2 + 0x8];
8d561400:	df 2f       	JUMP.S 0x0x8d5613be;
8d561402:	47 30       	R0 = FP;
8d561404:	40 64       	R0 += 0x8;		/* (  8) */
8d561406:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d56140a:	f0 b0 00 00 
8d56140e:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d561410:	ff e3 14 fe 	CALL 0x0x8d561038;
8d561414:	87 2f       	JUMP.S 0x0x8d561322;
8d561416:	06 30       	R0 = R6;
8d561418:	00 de 0b 8c 	CALL.A 0x8c0ba942;
8d56141c:	42 a9 00 00 
8d561420:	86 6c       	SP += 0x10;		/* ( 16) */
8d561422:	a5 05       	(R7:4, P5:5) = [SP++];
8d561424:	01 e8 00 00 	UNLINK;
8d561428:	10 00       	RTS;
8d56142a:	00 00       	NOP;
8d56142c:	00 e8 3c 00 	LINK 0xf0;		/* (240) */
8d561430:	60 05       	[--SP] = (R7:4);
8d561432:	66 6f       	SP += -0x14;		/* (-20) */
8d561434:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [FP + 0x10] = R0 || NOP;
8d561438:	38 b1 00 00 
8d56143c:	21 61       	R1 = 0x24 (X);		/*		R1=0x0(  0) */
8d56143e:	46 30       	R0 = SP;
8d561440:	c8 51       	R7 = R0 + R1;
8d561442:	07 30       	R0 = R7;
8d561444:	fb e3 f8 cf 	CALL 0x0x8d4db434;
8d561448:	84 60       	R4 = 0x10 (X);		/*		R4=0x0(  0) */
8d56144a:	03 c8 00 18 	MNOP || R0 = [SP + 0x3c] || R6 = [SP + 0x38];
8d56144e:	f0 a3 b6 a3 
8d561452:	04 0a       	CC = R4 <= R0 (IU);
8d561454:	02 14       	IF !CC JUMP 0x0x8d561458 (BP);
8d561456:	6c 22       	JUMP.S 0x0x8d56192e;
8d561458:	06 0c       	CC = R6 == 0x0;
8d56145a:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0x38] = R5 || NOP;
8d56145e:	b5 b3 00 00 
8d561462:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d561466:	7e 60       	R6 = 0xf (X);		/*		R6=0x0(  0) */
8d561468:	f6 b3       	[SP + 0x3c] = R6;
8d56146a:	03 14       	IF !CC JUMP 0x0x8d561470 (BP);
8d56146c:	46 22       	JUMP.S 0x0x8d5618f8;
8d56146e:	00 00       	NOP;
8d561470:	fb e3 b6 cf 	CALL 0x0x8d4db3dc;
8d561474:	07 30       	R0 = R7;
8d561476:	ff e3 37 fc 	CALL 0x0x8d560ce4;
8d56147a:	00 0c       	CC = R0 == 0x0;
8d56147c:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d56147e:	02 14       	IF !CC JUMP 0x0x8d561482 (BP);
8d561480:	29 22       	JUMP.S 0x0x8d5618d2;
8d561482:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d561484:	f8 b0       	[FP + 0xc] = R0;
8d561486:	01 0c       	CC = R1 == 0x0;
8d561488:	0c 18       	IF CC JUMP 0x0x8d5614a0;
8d56148a:	30 e4 16 00 	R0 = [SP + 0x58];
8d56148e:	04 0a       	CC = R4 <= R0 (IU);
8d561490:	02 14       	IF !CC JUMP 0x0x8d561494 (BP);
8d561492:	1b 22       	JUMP.S 0x0x8d5618c8;
8d561494:	36 e6 16 00 	[SP + 0x58] = R6;
8d561498:	35 e6 15 00 	[SP + 0x54] = R5;
8d56149c:	b5 e6 44 00 	B[SP + 0x44] = R5;
8d5614a0:	f0 a3       	R0 = [SP + 0x3c];
8d5614a2:	04 0a       	CC = R4 <= R0 (IU);
8d5614a4:	02 14       	IF !CC JUMP 0x0x8d5614a8 (BP);
8d5614a6:	0c 22       	JUMP.S 0x0x8d5618be;
8d5614a8:	03 c8 00 18 	MNOP || R0 = [FP + 0xc] || [SP + 0x3c] = R6;
8d5614ac:	f8 a0 f6 b3 
8d5614b0:	00 0c       	CC = R0 == 0x0;
8d5614b2:	b5 b3       	[SP + 0x38] = R5;
8d5614b4:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d5614b8:	02 1c       	IF CC JUMP 0x0x8d5614bc (BP);
8d5614ba:	d6 21       	JUMP.S 0x0x8d561866;
8d5614bc:	56 30       	R2 = SP;
8d5614be:	23 e1 40 00 	R3 = 0x40 (X);		/*		R3=0x40( 64) */
8d5614c2:	9a 50       	R2 = R2 + R3;
8d5614c4:	fa b0       	[FP + 0xc] = R2;
8d5614c6:	f8 a0       	R0 = [FP + 0xc];
8d5614c8:	fb e3 8a cf 	CALL 0x0x8d4db3dc;
8d5614cc:	03 c8 00 18 	MNOP || R0 = [FP + 0xc] || R1 = [FP + 0xc];
8d5614d0:	f8 a0 f9 a0 
8d5614d4:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d5614d6:	ff e3 55 f8 	CALL 0x0x8d560580;
8d5614da:	30 e4 16 00 	R0 = [SP + 0x58];
8d5614de:	04 0a       	CC = R4 <= R0 (IU);
8d5614e0:	be 19       	IF CC JUMP 0x0x8d56185c;
8d5614e2:	46 30       	R0 = SP;
8d5614e4:	21 e1 5c 00 	R1 = 0x5c (X);		/*		R1=0x5c( 92) */
8d5614e8:	48 50       	R1 = R0 + R1;
8d5614ea:	01 30       	R0 = R1;
8d5614ec:	36 e6 16 00 	[SP + 0x58] = R6;
8d5614f0:	35 e6 15 00 	[SP + 0x54] = R5;
8d5614f4:	b5 e6 44 00 	B[SP + 0x44] = R5;
8d5614f8:	40 66       	R0 += -0x38;		/* (-56) */
8d5614fa:	02 da 06 84 	R2=-2079940752;
8d5614fe:	70 9f 00 00 
8d561502:	00 de 03 8c 	CALL.A 0x8c03f194;
8d561506:	94 f1 00 00 
8d56150a:	f1 a3       	R1 = [SP + 0x3c];
8d56150c:	5e 30       	R3 = SP;
8d56150e:	42 61       	R2 = 0x28 (X);		/*		R2=0x0(  0) */
8d561510:	0c 0a       	CC = R4 <= R1 (IU);
8d561512:	04 cc 1a 00 	R0 = R3 + R2 (NS) || R1 = [SP + 0x28] || NOP;
8d561516:	b1 a2 00 00 
8d56151a:	01 07       	IF CC R0 = R1;
8d56151c:	00 de 03 8c 	CALL.A 0x8c03e080;
8d561520:	80 e0 00 00 
8d561524:	f0 a3       	R0 = [SP + 0x3c];
8d561526:	04 0a       	CC = R4 <= R0 (IU);
8d561528:	96 19       	IF CC JUMP 0x0x8d561854;
8d56152a:	46 30       	R0 = SP;
8d56152c:	21 e1 5c 00 	R1 = 0x5c (X);		/*		R1=0x5c( 92) */
8d561530:	04 cc 01 02 	R1 = R0 + R1 (NS) || [SP + 0x3c] = R6 || NOP;
8d561534:	f6 b3 00 00 
8d561538:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || [SP + 0x38] = R5 || NOP;
8d56153c:	b5 b3 00 00 
8d561540:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d561544:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d561546:	ff e3 c5 fe 	CALL 0x0x8d5612d0;
8d56154a:	30 e4 20 00 	R0 = [SP + 0x80];
8d56154e:	31 e5 1f 00 	P1 = [SP + 0x7c];
8d561552:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d561554:	00 0c       	CC = R0 == 0x0;
8d561556:	fa b0       	[FP + 0xc] = R2;
8d561558:	1c 18       	IF CC JUMP 0x0x8d561590;
8d56155a:	88 e5 11 00 	R0 = B[P1 + 0x11] (X);
8d56155e:	00 0c       	CC = R0 == 0x0;
8d561560:	77 11       	IF !CC JUMP 0x0x8d56184e;
8d561562:	48 91       	P0 = [P1];
8d561564:	80 e5 11 00 	R0 = B[P0 + 0x11] (X);
8d561568:	00 0c       	CC = R0 == 0x0;
8d56156a:	5d 11       	IF !CC JUMP 0x0x8d561824;
8d56156c:	81 ac       	P1 = [P0 + 0x8];
8d56156e:	88 e5 11 00 	R0 = B[P1 + 0x11] (X);
8d561572:	00 0c       	CC = R0 == 0x0;
8d561574:	0b 10       	IF !CC JUMP 0x0x8d56158a;
8d561576:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d561584) LC0 count_fields=0x0/0x0;
8d56157a:	41 32       	P0 = P1;
8d56157c:	81 ac       	P1 = [P0 + 0x8];
8d56157e:	88 e5 11 00 	R0 = B[P1 + 0x11] (X);
8d561582:	00 0c       	CC = R0 == 0x0;
8d561584:	03 10       	IF !CC JUMP 0x0x8d56158a;
8d561586:	81 ac       	P1 = [P0 + 0x8];
8d561588:	f7 2f       	JUMP.S 0x0x8d561576;
8d56158a:	c0 a0       	R0 = [P0 + 0xc];
8d56158c:	08 64       	R0 += 0x1;		/* (  1) */
8d56158e:	f8 b0       	[FP + 0xc] = R0;
8d561590:	20 e1 0f 27 	R0 = 0x270f (X);		/*		R0=0x270f(9999) */
8d561594:	fa a0       	R2 = [FP + 0xc];
8d561596:	90 08       	CC = R0 < R2;
8d561598:	4f 30       	R1 = FP;
8d56159a:	33 10       	IF !CC JUMP 0x0x8d561600;
8d56159c:	32 e4 1d 00 	R2 = [SP + 0x74];
8d5615a0:	23 e1 4c ff 	R3 = -0xb4 (X);		/*		R3=0xffffff4c(-180) */
8d5615a4:	14 0a       	CC = R4 <= R2 (IU);
8d5615a6:	19 50       	R0 = R1 + R3;
8d5615a8:	37 e4 18 00 	R7 = [SP + 0x60];
8d5615ac:	07 07       	IF CC R0 = R7;
8d5615ae:	00 de 03 8c 	CALL.A 0x8c03e268;
8d5615b2:	68 e2 00 00 
8d5615b6:	38 a1       	R0 = [FP + 0x10];
8d5615b8:	ff e3 3a ff 	CALL 0x0x8d56142c;
8d5615bc:	4e 30       	R1 = SP;
8d5615be:	22 e1 78 00 	R2 = 0x78 (X);		/*		R2=0x78(120) */
8d5615c2:	11 50       	R0 = R1 + R2;
8d5615c4:	ff e3 26 f6 	CALL 0x0x8d560210;
8d5615c8:	30 e4 1d 00 	R0 = [SP + 0x74];
8d5615cc:	04 0a       	CC = R4 <= R0 (IU);
8d5615ce:	0d 18       	IF CC JUMP 0x0x8d5615e8;
8d5615d0:	b5 e6 60 00 	B[SP + 0x60] = R5;
8d5615d4:	a6 6c       	SP += 0x14;		/* ( 20) */
8d5615d6:	20 05       	(R7:4) = [SP++];
8d5615d8:	01 e8 00 00 	UNLINK;
8d5615dc:	10 00       	RTS;
8d5615de:	a6 6c       	SP += 0x14;		/* ( 20) */
8d5615e0:	20 05       	(R7:4) = [SP++];
8d5615e2:	01 e8 00 00 	UNLINK;
8d5615e6:	10 00       	RTS;
8d5615e8:	30 e4 18 00 	R0 = [SP + 0x60];
8d5615ec:	fb e3 fc 66 	CALL 0x0x8d4ce3e4;
8d5615f0:	b5 e6 60 00 	B[SP + 0x60] = R5;
8d5615f4:	a6 6c       	SP += 0x14;		/* ( 20) */
8d5615f6:	20 05       	(R7:4) = [SP++];
8d5615f8:	01 e8 00 00 	UNLINK;
8d5615fc:	10 00       	RTS;
8d5615fe:	00 00       	NOP;
8d561600:	20 e1 64 ff 	R0 = -0x9c (X);		/*		R0=0xffffff64(-156) */
8d561604:	01 50       	R0 = R1 + R0;
8d561606:	08 30       	R1 = R0;
8d561608:	20 67       	R0 += -0x1c;		/* (-28) */
8d56160a:	9a 60       	R2 = 0x13 (X);		/*		R2=0x78(120) */
8d56160c:	ff e3 d8 fa 	CALL 0x0x8d560bbc;
8d561610:	5e 30       	R3 = SP;
8d561612:	22 e1 84 00 	R2 = 0x84 (X);		/*		R2=0x84(132) */
8d561616:	13 50       	R0 = R3 + R2;
8d561618:	fb e3 e2 ce 	CALL 0x0x8d4db3dc;
8d56161c:	4e 30       	R1 = SP;
8d56161e:	23 e1 5c 00 	R3 = 0x5c (X);		/*		R3=0x5c( 92) */
8d561622:	59 50       	R1 = R1 + R3;
8d561624:	01 30       	R0 = R1;
8d561626:	20 67       	R0 += -0x1c;		/* (-28) */
8d561628:	7a 61       	R2 = 0x2f (X);		/*		R2=0x84(132) */
8d56162a:	fc e3 c1 04 	CALL 0x0x8d4e1fac;
8d56162e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0xc] || NOP;
8d561632:	f9 a0 00 00 
8d561636:	ff e3 bf f3 	CALL 0x0x8d55fdb4;
8d56163a:	0f 30       	R1 = R7;
8d56163c:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d56163e:	20 e1 60 00 	R0 = 0x60 (X);		/*		R0=0x60( 96) */
8d561642:	01 50       	R0 = R1 + R0;
8d561644:	17 30       	R2 = R7;
8d561646:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d56164a:	e4 f0 00 00 
8d56164e:	f0 a3       	R0 = [SP + 0x3c];
8d561650:	04 0a       	CC = R4 <= R0 (IU);
8d561652:	e4 18       	IF CC JUMP 0x0x8d56181a;
8d561654:	f6 b3       	[SP + 0x3c] = R6;
8d561656:	b5 b3       	[SP + 0x38] = R5;
8d561658:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d56165c:	30 e4 16 00 	R0 = [SP + 0x58];
8d561660:	04 0a       	CC = R4 <= R0 (IU);
8d561662:	d7 18       	IF CC JUMP 0x0x8d561810;
8d561664:	21 b8       	R1 = [FP -0x78];
8d561666:	46 30       	R0 = SP;
8d561668:	23 e1 88 00 	R3 = 0x88 (X);		/*		R3=0x88(136) */
8d56166c:	0c 0a       	CC = R4 <= R1 (IU);
8d56166e:	18 50       	R0 = R0 + R3;
8d561670:	32 e4 22 00 	R2 = [SP + 0x88];
8d561674:	36 e6 16 00 	[SP + 0x58] = R6;
8d561678:	35 e6 15 00 	[SP + 0x54] = R5;
8d56167c:	b5 e6 44 00 	B[SP + 0x44] = R5;
8d561680:	02 07       	IF CC R0 = R2;
8d561682:	00 de 03 8c 	CALL.A 0x8c03e29c;
8d561686:	9c e2 00 00 
8d56168a:	00 0c       	CC = R0 == 0x0;
8d56168c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P0 = [FP -0x70] || R3 = [FP -0x5c];
8d561690:	48 b8 93 b8 
8d561694:	6e 10       	IF !CC JUMP 0x0x8d561770;
8d561696:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d56169a:	fc 1e 00 00 
8d56169e:	98 0c       	CC = R0 < 0x3;
8d5616a0:	4c 10       	IF !CC JUMP 0x0x8d561738;
8d5616a2:	21 b8       	R1 = [FP -0x78];
8d5616a4:	46 30       	R0 = SP;
8d5616a6:	23 e1 88 00 	R3 = 0x88 (X);		/*		R3=0x88(136) */
8d5616aa:	0c 0a       	CC = R4 <= R1 (IU);
8d5616ac:	18 50       	R0 = R0 + R3;
8d5616ae:	32 e4 22 00 	R2 = [SP + 0x88];
8d5616b2:	02 07       	IF CC R0 = R2;
8d5616b4:	00 e3 80 81 	CALL 0x0x8d5719b4;
8d5616b8:	07 0c       	CC = R7 == 0x0;
8d5616ba:	3b 18       	IF CC JUMP 0x0x8d561730;
8d5616bc:	90 b8       	R0 = [FP -0x5c];
8d5616be:	04 0a       	CC = R4 <= R0 (IU);
8d5616c0:	33 18       	IF CC JUMP 0x0x8d561726;
8d5616c2:	85 ba       	[FP -0x60] = R5;
8d5616c4:	b5 e6 a4 00 	B[SP + 0xa4] = R5;
8d5616c8:	03 c8 00 18 	MNOP || R0 = [FP -0x78] || [FP -0x5c] = R6;
8d5616cc:	20 b8 96 ba 
8d5616d0:	04 0a       	CC = R4 <= R0 (IU);
8d5616d2:	25 18       	IF CC JUMP 0x0x8d56171c;
8d5616d4:	46 30       	R0 = SP;
8d5616d6:	21 e1 78 00 	R1 = 0x78 (X);		/*		R1=0x78(120) */
8d5616da:	04 cc 01 00 	R0 = R0 + R1 (NS) || [FP -0x7c] = R5 || NOP;
8d5616de:	15 ba 00 00 
8d5616e2:	b5 e6 88 00 	B[SP + 0x88] = R5;
8d5616e6:	26 ba       	[FP -0x78] = R6;
8d5616e8:	ff e3 94 f5 	CALL 0x0x8d560210;
8d5616ec:	30 e4 1d 00 	R0 = [SP + 0x74];
8d5616f0:	04 0a       	CC = R4 <= R0 (IU);
8d5616f2:	09 18       	IF CC JUMP 0x0x8d561704;
8d5616f4:	b5 e6 60 00 	B[SP + 0x60] = R5;
8d5616f8:	a6 6c       	SP += 0x14;		/* ( 20) */
8d5616fa:	20 05       	(R7:4) = [SP++];
8d5616fc:	01 e8 00 00 	UNLINK;
8d561700:	10 00       	RTS;
8d561702:	00 00       	NOP;
8d561704:	30 e4 18 00 	R0 = [SP + 0x60];
8d561708:	fb e3 6e 66 	CALL 0x0x8d4ce3e4;
8d56170c:	b5 e6 60 00 	B[SP + 0x60] = R5;
8d561710:	a6 6c       	SP += 0x14;		/* ( 20) */
8d561712:	20 05       	(R7:4) = [SP++];
8d561714:	01 e8 00 00 	UNLINK;
8d561718:	10 00       	RTS;
8d56171a:	00 00       	NOP;
8d56171c:	30 e4 22 00 	R0 = [SP + 0x88];
8d561720:	fb e3 62 66 	CALL 0x0x8d4ce3e4;
8d561724:	d8 2f       	JUMP.S 0x0x8d5616d4;
8d561726:	40 b8       	R0 = [FP -0x70];
8d561728:	fb e3 5e 66 	CALL 0x0x8d4ce3e4;
8d56172c:	cb 2f       	JUMP.S 0x0x8d5616c2;
8d56172e:	00 00       	NOP;
8d561730:	ff e3 04 cc 	CALL 0x0x8d55af38;
8d561734:	c4 2f       	JUMP.S 0x0x8d5616bc;
8d561736:	00 00       	NOP;
8d561738:	30 e5 22 00 	P0 = [SP + 0x88];
8d56173c:	20 b8       	R0 = [FP -0x78];
8d56173e:	29 e1 88 00 	P1 = 0x88 (X);		/*		P1=0x88(136) */
8d561742:	04 0a       	CC = R4 <= R0 (IU);
8d561744:	4e 5a       	P1 = SP + P1;
8d561746:	c8 07       	IF CC P1 = P0;
8d561748:	31 bd       	[SP + 0x10] = P1;
8d56174a:	09 da 06 84 	P1=-2079940428;
8d56174e:	b4 a0 00 00 
8d561752:	f1 bc       	[SP + 0xc] = P1;
8d561754:	22 e1 f4 00 	R2 = 0xf4 (X);		/*		R2=0xf4(244) */
8d561758:	01 da 06 84 	R1=-2079940696;
8d56175c:	a8 9f 00 00 
8d561760:	18 60       	R0 = 0x3 (X);		/*		R0=0x60( 96) */
8d561762:	00 de 04 8c 	CALL.A 0x8c040574;
8d561766:	74 05 00 00 
8d56176a:	9c 2f       	JUMP.S 0x0x8d5616a2;
8d56176c:	00 00       	NOP;
8d56176e:	00 00       	NOP;
8d561770:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d561774:	fc 1e 00 00 
8d561778:	98 0c       	CC = R0 < 0x3;
8d56177a:	33 10       	IF !CC JUMP 0x0x8d5617e0;
8d56177c:	4e 30       	R1 = SP;
8d56177e:	22 e1 a4 00 	R2 = 0xa4 (X);		/*		R2=0xa4(164) */
8d561782:	04 cc 0a 02 	R1 = R1 + R2 (NS) || R2 = [FP -0x78] || NOP;
8d561786:	22 b8 00 00 
8d56178a:	46 30       	R0 = SP;
8d56178c:	23 e1 88 00 	R3 = 0x88 (X);		/*		R3=0x88(136) */
8d561790:	14 0a       	CC = R4 <= R2 (IU);
8d561792:	04 cc 03 00 	R0 = R0 + R3 (NS) || R3 = [FP -0x5c] || NOP;
8d561796:	93 b8 00 00 
8d56179a:	32 e4 22 00 	R2 = [SP + 0x88];
8d56179e:	02 07       	IF CC R0 = R2;
8d5617a0:	1c 0a       	CC = R4 <= R3 (IU);
8d5617a2:	42 b8       	R2 = [FP -0x70];
8d5617a4:	0a 07       	IF CC R1 = R2;
8d5617a6:	00 de 03 8c 	CALL.A 0x8c03e2f0;
8d5617aa:	f0 e2 00 00 
8d5617ae:	00 0c       	CC = R0 == 0x0;
8d5617b0:	73 13       	IF !CC JUMP 0x0x8d561696;
8d5617b2:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5617b6:	fc 1e 00 00 
8d5617ba:	98 0c       	CC = R0 < 0x3;
8d5617bc:	6d 1f       	IF CC JUMP 0x0x8d561696 (BP);
8d5617be:	09 da 06 84 	P1=-2079940448;
8d5617c2:	a0 a0 00 00 
8d5617c6:	f1 bc       	[SP + 0xc] = P1;
8d5617c8:	22 e1 f0 00 	R2 = 0xf0 (X);		/*		R2=0xf0(240) */
8d5617cc:	01 da 06 84 	R1=-2079940696;
8d5617d0:	a8 9f 00 00 
8d5617d4:	18 60       	R0 = 0x3 (X);		/*		R0=0x60( 96) */
8d5617d6:	00 de 04 8c 	CALL.A 0x8c040574;
8d5617da:	74 05 00 00 
8d5617de:	5c 2f       	JUMP.S 0x0x8d561696;
8d5617e0:	29 e1 a4 00 	P1 = 0xa4 (X);		/*		P1=0xa4(164) */
8d5617e4:	1c 0a       	CC = R4 <= R3 (IU);
8d5617e6:	4e 5a       	P1 = SP + P1;
8d5617e8:	c8 07       	IF CC P1 = P0;
8d5617ea:	0a da 06 84 	P2=-2079940468;
8d5617ee:	8c a0 00 00 
8d5617f2:	31 bd       	[SP + 0x10] = P1;
8d5617f4:	f2 bc       	[SP + 0xc] = P2;
8d5617f6:	01 da 06 84 	R1=-2079940696;
8d5617fa:	a8 9f 00 00 
8d5617fe:	22 e1 ed 00 	R2 = 0xed (X);		/*		R2=0xed(237) */
8d561802:	18 60       	R0 = 0x3 (X);		/*		R0=0x60( 96) */
8d561804:	00 de 04 8c 	CALL.A 0x8c040574;
8d561808:	74 05 00 00 
8d56180c:	b8 2f       	JUMP.S 0x0x8d56177c;
8d56180e:	00 00       	NOP;
8d561810:	30 e4 11 00 	R0 = [SP + 0x44];
8d561814:	fb e3 e8 65 	CALL 0x0x8d4ce3e4;
8d561818:	26 2f       	JUMP.S 0x0x8d561664;
8d56181a:	b0 a2       	R0 = [SP + 0x28];
8d56181c:	fb e3 e4 65 	CALL 0x0x8d4ce3e4;
8d561820:	1a 2f       	JUMP.S 0x0x8d561654;
8d561822:	00 00       	NOP;
8d561824:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d56183a) LC0 count_fields=0x0/0x0;
8d561828:	48 ac       	P0 = [P1 + 0x4];
8d56182a:	80 e5 11 00 	R0 = B[P0 + 0x11] (X);
8d56182e:	00 0c       	CC = R0 == 0x0;
8d561830:	07 10       	IF !CC JUMP 0x0x8d56183e;
8d561832:	41 30       	R0 = P1;
8d561834:	01 91       	R1 = [P0];
8d561836:	01 08       	CC = R1 == R0;
8d561838:	03 10       	IF !CC JUMP 0x0x8d56183e;
8d56183a:	48 32       	P1 = P0;
8d56183c:	f4 2f       	JUMP.S 0x0x8d561824;
8d56183e:	b9 bc       	[FP + 0x8] = P1;
8d561840:	ba ac       	P2 = [FP + 0x8];
8d561842:	90 e5 11 00 	R0 = B[P2 + 0x11] (X);
8d561846:	00 0c       	CC = R0 == 0x0;
8d561848:	c8 07       	IF CC P1 = P0;
8d56184a:	41 32       	P0 = P1;
8d56184c:	9f 2e       	JUMP.S 0x0x8d56158a;
8d56184e:	88 a0       	R0 = [P1 + 0x8];
8d561850:	00 32       	P0 = R0;
8d561852:	9c 2e       	JUMP.S 0x0x8d56158a;
8d561854:	b0 a2       	R0 = [SP + 0x28];
8d561856:	fb e3 c7 65 	CALL 0x0x8d4ce3e4;
8d56185a:	68 2e       	JUMP.S 0x0x8d56152a;
8d56185c:	30 e4 11 00 	R0 = [SP + 0x44];
8d561860:	fb e3 c2 65 	CALL 0x0x8d4ce3e4;
8d561864:	3f 2e       	JUMP.S 0x0x8d5614e2;
8d561866:	57 30       	R2 = FP;
8d561868:	22 66       	R2 += -0x3c;		/* (-60) */
8d56186a:	fa b0       	[FP + 0xc] = R2;
8d56186c:	f8 a0       	R0 = [FP + 0xc];
8d56186e:	fb e3 b7 cd 	CALL 0x0x8d4db3dc;
8d561872:	03 c8 00 18 	MNOP || R0 = [FP + 0xc] || R1 = [FP + 0xc];
8d561876:	f8 a0 f9 a0 
8d56187a:	20 67       	R0 += -0x1c;		/* (-28) */
8d56187c:	ff e3 a4 fa 	CALL 0x0x8d560dc4;
8d561880:	56 30       	R2 = SP;
8d561882:	23 e1 bc 00 	R3 = 0xbc (X);		/*		R3=0xbc(188) */
8d561886:	1a 50       	R0 = R2 + R3;
8d561888:	fb e3 fc cd 	CALL 0x0x8d4db480;
8d56188c:	00 b9       	R0 = [FP -0x40];
8d56188e:	04 0a       	CC = R4 <= R0 (IU);
8d561890:	13 18       	IF CC JUMP 0x0x8d5618b6;
8d561892:	f5 ba       	[FP -0x44] = R5;
8d561894:	b5 e6 c0 00 	B[SP + 0xc0] = R5;
8d561898:	03 c8 00 18 	MNOP || R0 = [FP -0x24] || [FP -0x40] = R6;
8d56189c:	70 b9 06 bb 
8d5618a0:	04 0a       	CC = R4 <= R0 (IU);
8d5618a2:	06 18       	IF CC JUMP 0x0x8d5618ae;
8d5618a4:	76 bb       	[FP -0x24] = R6;
8d5618a6:	65 bb       	[FP -0x28] = R5;
8d5618a8:	b5 e6 dc 00 	B[SP + 0xdc] = R5;
8d5618ac:	08 2e       	JUMP.S 0x0x8d5614bc;
8d5618ae:	20 b9       	R0 = [FP -0x38];
8d5618b0:	fb e3 9a 65 	CALL 0x0x8d4ce3e4;
8d5618b4:	f8 2f       	JUMP.S 0x0x8d5618a4;
8d5618b6:	b0 b8       	R0 = [FP -0x54];
8d5618b8:	fb e3 96 65 	CALL 0x0x8d4ce3e4;
8d5618bc:	eb 2f       	JUMP.S 0x0x8d561892;
8d5618be:	b0 a2       	R0 = [SP + 0x28];
8d5618c0:	fb e3 92 65 	CALL 0x0x8d4ce3e4;
8d5618c4:	f2 2d       	JUMP.S 0x0x8d5614a8;
8d5618c6:	00 00       	NOP;
8d5618c8:	30 e4 11 00 	R0 = [SP + 0x44];
8d5618cc:	fb e3 8c 65 	CALL 0x0x8d4ce3e4;
8d5618d0:	e2 2d       	JUMP.S 0x0x8d561494;
8d5618d2:	56 30       	R2 = SP;
8d5618d4:	23 e1 40 00 	R3 = 0x40 (X);		/*		R3=0x40( 64) */
8d5618d8:	9a 50       	R2 = R2 + R3;
8d5618da:	fa b0       	[FP + 0xc] = R2;
8d5618dc:	f8 a0       	R0 = [FP + 0xc];
8d5618de:	fb e3 7f cd 	CALL 0x0x8d4db3dc;
8d5618e2:	f8 a0       	R0 = [FP + 0xc];
8d5618e4:	ff e3 38 fa 	CALL 0x0x8d560d54;
8d5618e8:	00 0c       	CC = R0 == 0x0;
8d5618ea:	09 60       	R1 = 0x1 (X);		/*		R1=0x78(120) */
8d5618ec:	02 1c       	IF CC JUMP 0x0x8d5618f0 (BP);
8d5618ee:	ca 2d       	JUMP.S 0x0x8d561482;
8d5618f0:	00 60       	R0 = 0x0 (X);		/*		R0=0x60( 96) */
8d5618f2:	f8 b0       	[FP + 0xc] = R0;
8d5618f4:	c9 2d       	JUMP.S 0x0x8d561486;
8d5618f6:	00 00       	NOP;
8d5618f8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5618fc:	fc 1e 00 00 
8d561900:	88 0c       	CC = R0 < 0x1;
8d561902:	6e 1e       	IF CC JUMP 0x0x8d5615de (BP);
8d561904:	09 da 06 84 	P1=-2079940496;
8d561908:	70 a0 00 00 
8d56190c:	f1 bc       	[SP + 0xc] = P1;
8d56190e:	01 da 06 84 	R1=-2079940696;
8d561912:	a8 9f 00 00 
8d561916:	22 e1 d1 00 	R2 = 0xd1 (X);		/*		R2=0xd1(209) */
8d56191a:	08 60       	R0 = 0x1 (X);		/*		R0=0x60( 96) */
8d56191c:	00 de 04 8c 	CALL.A 0x8c040574;
8d561920:	74 05 00 00 
8d561924:	a6 6c       	SP += 0x14;		/* ( 20) */
8d561926:	20 05       	(R7:4) = [SP++];
8d561928:	01 e8 00 00 	UNLINK;
8d56192c:	10 00       	RTS;
8d56192e:	b0 a2       	R0 = [SP + 0x28];
8d561930:	fb e3 5a 65 	CALL 0x0x8d4ce3e4;
8d561934:	92 2d       	JUMP.S 0x0x8d561458;
	...
