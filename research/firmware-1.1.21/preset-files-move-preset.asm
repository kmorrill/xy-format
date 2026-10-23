
os.ldr@0x8d4e841c:     file format binary


Disassembly of section .data:

8d4e841c <.data>:
8d4e841c:	00 e8 5c 00 	LINK 0x170;		/* (368) */
8d4e8420:	e3 05       	[--SP] = (R7:4, P5:3);
8d4e8422:	26 6f       	SP += -0x1c;		/* (-28) */
8d4e8424:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [FP + 0xc] = R1 || NOP;
8d4e8428:	f9 b0 00 00 
8d4e842c:	24 e1 70 00 	R4 = 0x70 (X);		/*		R4=0x70(112) */
8d4e8430:	5e 30       	R3 = SP;
8d4e8432:	04 cc 1c 02 	R1 = R3 + R4 (NS) || [FP -0xc] = R2 || NOP;
8d4e8436:	d2 bb 00 00 
8d4e843a:	7e 60       	R6 = 0xf (X);		/*		R6=0x0(  0) */
8d4e843c:	82 ce 01 c4 	R2 = ROT R1 BY 0x0 || [FP -0x8] = R0 || NOP;
8d4e8440:	e0 bb 00 00 
8d4e8444:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [FP -0x10] = R0 || NOP;
8d4e8448:	c0 bb 00 00 
8d4e844c:	18 32       	P3 = R0;
8d4e844e:	35 e6 1a 00 	[SP + 0x68] = R5;
8d4e8452:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e8456:	35 e6 21 00 	[SP + 0x84] = R5;
8d4e845a:	b5 e6 74 00 	B[SP + 0x74] = R5;
8d4e845e:	36 e6 1b 00 	[SP + 0x6c] = R6;
8d4e8462:	36 e6 22 00 	[SP + 0x88] = R6;
8d4e8466:	21 67       	R1 += -0x1c;		/* (-28) */
8d4e8468:	f8 a0       	R0 = [FP + 0xc];
8d4e846a:	ff e3 35 ed 	CALL 0x0x8d4e5ed4;
8d4e846e:	03 c8 00 18 	MNOP || P1 = [FP + 0x14] || R1 = [FP -0xc];
8d4e8472:	79 ad d1 b9 
8d4e8476:	00 0c       	CC = R0 == 0x0;
8d4e8478:	03 14       	IF !CC JUMP 0x0x8d4e847e (BP);
8d4e847a:	00 e2 9b 07 	JUMP.L 0x0x8d4e93b0;
8d4e847e:	56 30       	R2 = SP;
8d4e8480:	23 e1 54 00 	R3 = 0x54 (X);		/*		R3=0x54( 84) */
8d4e8484:	9a 50       	R2 = R2 + R3;
8d4e8486:	f2 bb       	[FP -0x4] = R2;
8d4e8488:	4c a1       	R4 = [P1 + 0x14];
8d4e848a:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || [FP + 0x8] = R4;
8d4e848e:	f0 b9 bc b0 
8d4e8492:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e8496:	32 41 00 00 
8d4e849a:	04 56       	R0 = R4 | R0;
8d4e849c:	00 0c       	CC = R0 == 0x0;
8d4e849e:	03 14       	IF !CC JUMP 0x0x8d4e84a4 (BP);
8d4e84a0:	34 27       	JUMP.S 0x0x8d4e9308;
8d4e84a2:	00 00       	NOP;
8d4e84a4:	b5 e6 90 00 	B[SP + 0x90] = R5;
8d4e84a8:	00 d8 29 84 	LdStAbs addr=0x8429daf4 control=0x0044;
8d4e84ac:	f4 da 44 00 
8d4e84b0:	36 e6 29 00 	[SP + 0xa4] = R6;
8d4e84b4:	35 e6 28 00 	[SP + 0xa0] = R5;
8d4e84b8:	24 e1 18 01 	R4 = 0x118 (X);		/*		R4=0x118(280) */
8d4e84bc:	65 91       	P5 = [P4];
8d4e84be:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e84c0:	6c 08       	CC = P4 == P5;
8d4e84c2:	9b 18       	IF CC JUMP 0x0x8d4e85f8;
8d4e84c4:	b5 e6 1c 01 	B[SP + 0x11c] = R5;
8d4e84c8:	96 ba       	[FP -0x5c] = R6;
8d4e84ca:	85 ba       	[FP -0x60] = R5;
8d4e84cc:	b5 e6 38 01 	B[SP + 0x138] = R5;
8d4e84d0:	46 30       	R0 = SP;
8d4e84d2:	04 cc 04 02 	R1 = R0 + R4 (NS) || [FP -0x78] = R6 || NOP;
8d4e84d6:	26 ba 00 00 
8d4e84da:	45 30       	R0 = P5;
8d4e84dc:	80 64       	R0 += 0x10;		/* ( 16) */
8d4e84de:	82 ce 01 c4 	R2 = ROT R1 BY 0x0 || [FP -0x7c] = R5 || NOP;
8d4e84e2:	15 ba 00 00 
8d4e84e6:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4e84e8:	ff e3 bc da 	CALL 0x0x8d4e3a60;
8d4e84ec:	00 0c       	CC = R0 == 0x0;
8d4e84ee:	47 10       	IF !CC JUMP 0x0x8d4e857c;
8d4e84f0:	90 b8       	R0 = [FP -0x5c];
8d4e84f2:	07 0a       	CC = R7 <= R0 (IU);
8d4e84f4:	3f 18       	IF CC JUMP 0x0x8d4e8572;
8d4e84f6:	85 ba       	[FP -0x60] = R5;
8d4e84f8:	b5 e6 38 01 	B[SP + 0x138] = R5;
8d4e84fc:	03 c8 00 18 	MNOP || R0 = [FP -0x78] || [FP -0x5c] = R6;
8d4e8500:	20 b8 96 ba 
8d4e8504:	07 0a       	CC = R7 <= R0 (IU);
8d4e8506:	31 18       	IF CC JUMP 0x0x8d4e8568;
8d4e8508:	26 ba       	[FP -0x78] = R6;
8d4e850a:	15 ba       	[FP -0x7c] = R5;
8d4e850c:	b5 e6 1c 01 	B[SP + 0x11c] = R5;
8d4e8510:	a8 e5 2d 00 	R0 = B[P5 + 0x2d] (X);
8d4e8514:	00 0c       	CC = R0 == 0x0;
8d4e8516:	d5 13       	IF !CC JUMP 0x0x8d4e84c0;
8d4e8518:	a8 ac       	P0 = [P5 + 0x8];
8d4e851a:	80 e5 2d 00 	R0 = B[P0 + 0x2d] (X);
8d4e851e:	00 0c       	CC = R0 == 0x0;
8d4e8520:	12 10       	IF !CC JUMP 0x0x8d4e8544;
8d4e8522:	41 91       	P1 = [P0];
8d4e8524:	68 32       	P5 = P0;
8d4e8526:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e852a:	00 0c       	CC = R0 == 0x0;
8d4e852c:	ca 13       	IF !CC JUMP 0x0x8d4e84c0;
8d4e852e:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4e853c) LC0 count_fields=0x0/0x0;
8d4e8532:	69 32       	P5 = P1;
8d4e8534:	69 91       	P1 = [P5];
8d4e8536:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e853a:	00 0c       	CC = R0 == 0x0;
8d4e853c:	c2 13       	IF !CC JUMP 0x0x8d4e84c0;
8d4e853e:	69 91       	P1 = [P5];
8d4e8540:	f7 2f       	JUMP.S 0x0x8d4e852e;
8d4e8542:	00 00       	NOP;
8d4e8544:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d4e855a) LC0 count_fields=0x0/0x0;
8d4e8548:	69 ac       	P1 = [P5 + 0x4];
8d4e854a:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e854e:	00 0c       	CC = R0 == 0x0;
8d4e8550:	09 10       	IF !CC JUMP 0x0x8d4e8562;
8d4e8552:	45 30       	R0 = P5;
8d4e8554:	89 a0       	R1 = [P1 + 0x8];
8d4e8556:	01 08       	CC = R1 == R0;
8d4e8558:	03 10       	IF !CC JUMP 0x0x8d4e855e;
8d4e855a:	69 32       	P5 = P1;
8d4e855c:	f4 2f       	JUMP.S 0x0x8d4e8544;
8d4e855e:	69 32       	P5 = P1;
8d4e8560:	b0 2f       	JUMP.S 0x0x8d4e84c0;
8d4e8562:	69 32       	P5 = P1;
8d4e8564:	ae 2f       	JUMP.S 0x0x8d4e84c0;
8d4e8566:	00 00       	NOP;
8d4e8568:	30 e4 47 00 	R0 = [SP + 0x11c];
8d4e856c:	ff e3 3c 2f 	CALL 0x0x8d4ce3e4;
8d4e8570:	cc 2f       	JUMP.S 0x0x8d4e8508;
8d4e8572:	40 b8       	R0 = [FP -0x70];
8d4e8574:	ff e3 38 2f 	CALL 0x0x8d4ce3e4;
8d4e8578:	bf 2f       	JUMP.S 0x0x8d4e84f6;
8d4e857a:	00 00       	NOP;
8d4e857c:	20 e1 c4 00 	R0 = 0xc4 (X);		/*		R0=0xc4(196) */
8d4e8580:	03 c8 00 18 	MNOP || R2 = [FP -0x4] || R1 = [FP -0x4];
8d4e8584:	f2 b9 f1 b9 
8d4e8588:	02 50       	R0 = R2 + R0;
8d4e858a:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e858e:	32 41 00 00 
8d4e8592:	00 0c       	CC = R0 == 0x0;
8d4e8594:	ae 17       	IF !CC JUMP 0x0x8d4e84f0 (BP);
8d4e8596:	46 30       	R0 = SP;
8d4e8598:	21 e1 70 00 	R1 = 0x70 (X);		/*		R1=0x70(112) */
8d4e859c:	48 50       	R1 = R0 + R1;
8d4e859e:	22 e1 c4 00 	R2 = 0xc4 (X);		/*		R2=0xc4(196) */
8d4e85a2:	11 50       	R0 = R1 + R2;
8d4e85a4:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e85a8:	32 41 00 00 
8d4e85ac:	00 0c       	CC = R0 == 0x0;
8d4e85ae:	a1 17       	IF !CC JUMP 0x0x8d4e84f0 (BP);
8d4e85b0:	4d 30       	R1 = P5;
8d4e85b2:	81 64       	R1 += 0x10;		/* ( 16) */
8d4e85b4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4e85b8:	b8 00 02 00 
8d4e85bc:	46 30       	R0 = SP;
8d4e85be:	23 e1 8c 00 	R3 = 0x8c (X);		/*		R3=0x8c(140) */
8d4e85c2:	04 cc 03 00 	R0 = R0 + R3 (NS) || [SP + 0xc] = R2 || NOP;
8d4e85c6:	f2 b0 00 00 
8d4e85ca:	02 60       	R2 = 0x0 (X);		/*		R2=0xc4(196) */
8d4e85cc:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e85d0:	70 e9 00 00 
8d4e85d4:	90 b8       	R0 = [FP -0x5c];
8d4e85d6:	07 0a       	CC = R7 <= R0 (IU);
8d4e85d8:	02 14       	IF !CC JUMP 0x0x8d4e85dc (BP);
8d4e85da:	90 26       	JUMP.S 0x0x8d4e92fa;
8d4e85dc:	85 ba       	[FP -0x60] = R5;
8d4e85de:	b5 e6 38 01 	B[SP + 0x138] = R5;
8d4e85e2:	03 c8 00 18 	MNOP || R0 = [FP -0x78] || [FP -0x5c] = R6;
8d4e85e6:	20 b8 96 ba 
8d4e85ea:	07 0a       	CC = R7 <= R0 (IU);
8d4e85ec:	02 14       	IF !CC JUMP 0x0x8d4e85f0 (BP);
8d4e85ee:	81 26       	JUMP.S 0x0x8d4e92f0;
8d4e85f0:	26 ba       	[FP -0x78] = R6;
8d4e85f2:	15 ba       	[FP -0x7c] = R5;
8d4e85f4:	b5 e6 1c 01 	B[SP + 0x11c] = R5;
8d4e85f8:	30 e4 28 00 	R0 = [SP + 0xa0];
8d4e85fc:	00 0c       	CC = R0 == 0x0;
8d4e85fe:	02 14       	IF !CC JUMP 0x0x8d4e8602 (BP);
8d4e8600:	10 26       	JUMP.S 0x0x8d4e9220;
8d4e8602:	4e 30       	R1 = SP;
8d4e8604:	22 e1 8c 00 	R2 = 0x8c (X);		/*		R2=0x8c(140) */
8d4e8608:	51 50       	R1 = R1 + R2;
8d4e860a:	b1 bb       	[FP -0x14] = R1;
8d4e860c:	66 30       	R4 = SP;
8d4e860e:	0d da 03 84 	P5=-2080148376;
8d4e8612:	68 74 00 00 
8d4e8616:	b0 b9       	R0 = [FP -0x14];
8d4e8618:	ff e3 fe c5 	CALL 0x0x8d4e1214;
8d4e861c:	00 0c       	CC = R0 == 0x0;
8d4e861e:	03 1c       	IF CC JUMP 0x0x8d4e8624 (BP);
8d4e8620:	98 25       	JUMP.S 0x0x8d4e9150;
8d4e8622:	00 00       	NOP;
8d4e8624:	23 e1 a8 00 	R3 = 0xa8 (X);		/*		R3=0xa8(168) */
8d4e8628:	04 cc 23 08 	R4 = R4 + R3 (NS) || P1 = [FP + 0x14] || R2 = [FP + 0x8];
8d4e862c:	79 ad ba a0 
8d4e8630:	a4 bb       	[FP -0x18] = R4;
8d4e8632:	00 da 03 84 	R0=-2080149172;
8d4e8636:	4c 71 00 00 
8d4e863a:	a0 66       	R0 += -0x2c;		/* (-44) */
8d4e863c:	b5 e6 ac 00 	B[SP + 0xac] = R5;
8d4e8640:	02 0c       	CC = R2 == 0x0;
8d4e8642:	4e 30       	R1 = SP;
8d4e8644:	22 e1 70 00 	R2 = 0x70 (X);		/*		R2=0x70(112) */
8d4e8648:	04 cc 0a 02 	R1 = R1 + R2 (NS) || [FP + 0x10] = R0 || NOP;
8d4e864c:	38 b1 00 00 
8d4e8650:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d4e8654:	b8 00 00 00 
8d4e8658:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R0 || R0 = [FP -0x18];
8d4e865c:	f0 b0 a0 b9 
8d4e8660:	49 06       	IF !CC R1 = P1;
8d4e8662:	36 e6 30 00 	[SP + 0xc0] = R6;
8d4e8666:	35 e6 2f 00 	[SP + 0xbc] = R5;
8d4e866a:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e866e:	70 e9 00 00 
8d4e8672:	24 e1 c4 00 	R4 = 0xc4 (X);		/*		R4=0xc4(196) */
8d4e8676:	5e 30       	R3 = SP;
8d4e8678:	04 cc 1c 06 	R3 = R3 + R4 (NS) || R2 = [FP -0xc] || NOP;
8d4e867c:	d2 b9 00 00 
8d4e8680:	93 bb       	[FP -0x1c] = R3;
8d4e8682:	01 da 03 84 	R1=-2080148688;
8d4e8686:	30 73 00 00 
8d4e868a:	66 30       	R4 = SP;
8d4e868c:	90 b9       	R0 = [FP -0x1c];
8d4e868e:	00 de 04 8c 	CALL.A 0x8c04ee6c;
8d4e8692:	6c ee 00 00 
8d4e8696:	31 e4 37 00 	R1 = [SP + 0xdc];
8d4e869a:	23 e1 c8 00 	R3 = 0xc8 (X);		/*		R3=0xc8(200) */
8d4e869e:	0f 0a       	CC = R7 <= R1 (IU);
8d4e86a0:	1c 50       	R0 = R4 + R3;
8d4e86a2:	32 e4 32 00 	R2 = [SP + 0xc8];
8d4e86a6:	02 07       	IF CC R0 = R2;
8d4e86a8:	00 de 03 8c 	CALL.A 0x8c03e328;
8d4e86ac:	28 e3 00 00 
8d4e86b0:	00 0c       	CC = R0 == 0x0;
8d4e86b2:	8e 10       	IF !CC JUMP 0x0x8d4e87ce;
8d4e86b4:	56 30       	R2 = SP;
8d4e86b6:	23 e1 18 01 	R3 = 0x118 (X);		/*		R3=0x118(280) */
8d4e86ba:	04 cc 13 06 	R3 = R2 + R3 (NS) || R0 = [FP -0xc] || NOP;
8d4e86be:	d0 b9 00 00 
8d4e86c2:	c3 bb       	[FP -0x10] = R3;
8d4e86c4:	35 e6 47 00 	[SP + 0x11c] = R5;
8d4e86c8:	35 e6 48 00 	[SP + 0x120] = R5;
8d4e86cc:	35 e6 49 00 	[SP + 0x124] = R5;
8d4e86d0:	c1 b9       	R1 = [FP -0x10];
8d4e86d2:	ff e3 29 d9 	CALL 0x0x8d4e3924;
8d4e86d6:	01 da 03 84 	R1=-2080149172;
8d4e86da:	4c 71 00 00 
8d4e86de:	56 30       	R2 = SP;
8d4e86e0:	23 e1 28 01 	R3 = 0x128 (X);		/*		R3=0x128(296) */
8d4e86e4:	04 cc 13 00 	R0 = R2 + R3 (NS) || [FP -0x6c] = R5 || NOP;
8d4e86e8:	55 ba 00 00 
8d4e86ec:	b5 e6 2c 01 	B[SP + 0x12c] = R5;
8d4e86f0:	66 ba       	[FP -0x68] = R6;
8d4e86f2:	81 67       	R1 += -0x10;		/* (-16) */
8d4e86f4:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e86f8:	76 a3 00 00 
8d4e86fc:	30 e4 48 00 	R0 = [SP + 0x120];
8d4e8700:	32 e4 47 00 	R2 = [SP + 0x11c];
8d4e8704:	02 08       	CC = R2 == R0;
8d4e8706:	f8 b0       	[FP + 0xc] = R0;
8d4e8708:	44 18       	IF CC JUMP 0x0x8d4e8790;
8d4e870a:	ba b0       	[FP + 0x8] = R2;
8d4e870c:	46 30       	R0 = SP;
8d4e870e:	23 e1 44 01 	R3 = 0x144 (X);		/*		R3=0x144(324) */
8d4e8712:	04 cc 03 08 	R4 = R0 + R3 (NS) || R1 = [FP + 0x10] || NOP;
8d4e8716:	39 a1 00 00 
8d4e871a:	04 30       	R0 = R4;
8d4e871c:	00 de 04 8c 	CALL.A 0x8c04ee6c;
8d4e8720:	6c ee 00 00 
8d4e8724:	0c 30       	R1 = R4;
8d4e8726:	24 67       	R4 += -0x1c;		/* (-28) */
8d4e8728:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e872c:	b8 00 03 00 
8d4e8730:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4e8734:	f3 b0 00 00 
8d4e8738:	02 60       	R2 = 0x0 (X);		/*		R2=0x70(112) */
8d4e873a:	00 de 03 8c 	CALL.A 0x8c03e898;
8d4e873e:	98 e8 00 00 
8d4e8742:	d0 b8       	R0 = [FP -0x4c];
8d4e8744:	07 0a       	CC = R7 <= R0 (IU);
8d4e8746:	05 14       	IF !CC JUMP 0x0x8d4e8750 (BP);
8d4e8748:	ff 24       	JUMP.S 0x0x8d4e9146;
8d4e874a:	00 00       	NOP;
8d4e874c:	00 00       	NOP;
8d4e874e:	00 00       	NOP;
8d4e8750:	03 c8 00 18 	MNOP || R1 = [FP -0x68] || R2 = [FP -0x7c];
8d4e8754:	61 b8 12 b8 
8d4e8758:	46 30       	R0 = SP;
8d4e875a:	23 e1 2c 01 	R3 = 0x12c (X);		/*		R3=0x12c(300) */
8d4e875e:	0f 0a       	CC = R7 <= R1 (IU);
8d4e8760:	04 cc 03 00 	R0 = R0 + R3 (NS) || [FP -0x50] = R5 || NOP;
8d4e8764:	c5 ba 00 00 
8d4e8768:	b5 e6 48 01 	B[SP + 0x148] = R5;
8d4e876c:	d6 ba       	[FP -0x4c] = R6;
8d4e876e:	02 07       	IF CC R0 = R2;
8d4e8770:	00 de 03 8c 	CALL.A 0x8c03e328;
8d4e8774:	28 e3 00 00 
8d4e8778:	00 0c       	CC = R0 == 0x0;
8d4e877a:	03 14       	IF !CC JUMP 0x0x8d4e8780 (BP);
8d4e877c:	d6 24       	JUMP.S 0x0x8d4e9128;
8d4e877e:	00 00       	NOP;
8d4e8780:	03 c8 00 18 	MNOP || R2 = [FP + 0x8] || R0 = [FP + 0xc];
8d4e8784:	ba a0 f8 a0 
8d4e8788:	e2 64       	R2 += 0x1c;		/* ( 28) */
8d4e878a:	10 08       	CC = R0 == R2;
8d4e878c:	ba b0       	[FP + 0x8] = R2;
8d4e878e:	bf 17       	IF !CC JUMP 0x0x8d4e870c (BP);
8d4e8790:	60 b8       	R0 = [FP -0x68];
8d4e8792:	07 0a       	CC = R7 <= R0 (IU);
8d4e8794:	02 14       	IF !CC JUMP 0x0x8d4e8798 (BP);
8d4e8796:	c2 24       	JUMP.S 0x0x8d4e911a;
8d4e8798:	03 c8 00 18 	MNOP || [FP -0x68] = R6 || R0 = [FP -0x10];
8d4e879c:	66 ba c0 b9 
8d4e87a0:	55 ba       	[FP -0x6c] = R5;
8d4e87a2:	b5 e6 2c 01 	B[SP + 0x12c] = R5;
8d4e87a6:	31 e4 47 00 	R1 = [SP + 0x11c];
8d4e87aa:	01 0c       	CC = R1 == 0x0;
8d4e87ac:	0b 18       	IF CC JUMP 0x0x8d4e87c2;
8d4e87ae:	32 e4 48 00 	R2 = [SP + 0x120];
8d4e87b2:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e87b6:	a4 f9 00 00 
8d4e87ba:	30 e4 47 00 	R0 = [SP + 0x11c];
8d4e87be:	ff e3 13 2e 	CALL 0x0x8d4ce3e4;
8d4e87c2:	35 e6 47 00 	[SP + 0x11c] = R5;
8d4e87c6:	35 e6 48 00 	[SP + 0x120] = R5;
8d4e87ca:	35 e6 49 00 	[SP + 0x124] = R5;
8d4e87ce:	36 e6 3e 00 	[SP + 0xf8] = R6;
8d4e87d2:	35 e6 3d 00 	[SP + 0xf4] = R5;
8d4e87d6:	b5 e6 e4 00 	B[SP + 0xe4] = R5;
8d4e87da:	03 c8 00 18 	MNOP || R0 = [FP -0x14] || R4 = [FP -0x1c];
8d4e87de:	b0 b9 94 b9 
8d4e87e2:	ff e3 f1 ea 	CALL 0x0x8d4e5dc4;
8d4e87e6:	00 0c       	CC = R0 == 0x0;
8d4e87e8:	02 14       	IF !CC JUMP 0x0x8d4e87ec (BP);
8d4e87ea:	11 23       	JUMP.S 0x0x8d4e8e0c;
8d4e87ec:	24 e1 c4 00 	R4 = 0xc4 (X);		/*		R4=0xc4(196) */
8d4e87f0:	03 c8 00 18 	MNOP || R0 = [FP -0x14] || R1 = [FP -0x14];
8d4e87f4:	b0 b9 b1 b9 
8d4e87f8:	04 cc 04 00 	R0 = R0 + R4 (NS) || R4 = [FP -0x1c] || NOP;
8d4e87fc:	94 b9 00 00 
8d4e8800:	05 e3 1c df 	CALL 0x0x8d5a4638;
8d4e8804:	23 e1 70 00 	R3 = 0x70 (X);		/*		R3=0x70(112) */
8d4e8808:	04 cc 23 00 	R0 = R4 + R3 (NS) || R2 = [FP + 0x10] || R1 = [FP -0x1c];
8d4e880c:	3a a1 91 b9 
8d4e8810:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e8814:	94 f1 00 00 
8d4e8818:	24 e1 8c 00 	R4 = 0x8c (X);		/*		R4=0x8c(140) */
8d4e881c:	03 c8 00 18 	MNOP || R3 = [FP -0x18] || R2 = [FP -0x18];
8d4e8820:	a3 b9 a2 b9 
8d4e8824:	63 50       	R1 = R3 + R4;
8d4e8826:	01 30       	R0 = R1;
8d4e8828:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e882a:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d4e882e:	e4 f0 00 00 
8d4e8832:	24 e1 18 01 	R4 = 0x118 (X);		/*		R4=0x118(280) */
8d4e8836:	5e 30       	R3 = SP;
8d4e8838:	63 50       	R1 = R3 + R4;
8d4e883a:	02 da 03 84 	R2=-2080149172;
8d4e883e:	4c 71 00 00 
8d4e8842:	20 e1 54 00 	R0 = 0x54 (X);		/*		R0=0x54( 84) */
8d4e8846:	01 50       	R0 = R1 + R0;
8d4e8848:	02 66       	R2 += -0x40;		/* (-64) */
8d4e884a:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e884e:	94 f1 00 00 
8d4e8852:	20 b8       	R0 = [FP -0x78];
8d4e8854:	07 0a       	CC = R7 <= R0 (IU);
8d4e8856:	02 14       	IF !CC JUMP 0x0x8d4e885a (BP);
8d4e8858:	d4 22       	JUMP.S 0x0x8d4e8e00;
8d4e885a:	15 ba       	[FP -0x7c] = R5;
8d4e885c:	b5 e6 1c 01 	B[SP + 0x11c] = R5;
8d4e8860:	03 c8 00 18 	MNOP || R0 = [FP -0x5c] || [FP -0x78] = R6;
8d4e8864:	90 b8 26 ba 
8d4e8868:	07 0a       	CC = R7 <= R0 (IU);
8d4e886a:	02 14       	IF !CC JUMP 0x0x8d4e886e (BP);
8d4e886c:	c6 22       	JUMP.S 0x0x8d4e8df8;
8d4e886e:	96 ba       	[FP -0x5c] = R6;
8d4e8870:	85 ba       	[FP -0x60] = R5;
8d4e8872:	b5 e6 38 01 	B[SP + 0x138] = R5;
8d4e8876:	47 30       	R0 = FP;
8d4e8878:	40 66       	R0 += -0x38;		/* (-56) */
8d4e887a:	03 c8 00 18 	MNOP || R1 = [FP -0x24] || R2 = [FP -0x38];
8d4e887e:	71 b9 22 b9 
8d4e8882:	0f 0a       	CC = R7 <= R1 (IU);
8d4e8884:	02 07       	IF CC R0 = R2;
8d4e8886:	00 de 03 8c 	CALL.A 0x8c03e328;
8d4e888a:	28 e3 00 00 
8d4e888e:	00 0c       	CC = R0 == 0x0;
8d4e8890:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e8894:	fc 1e 00 00 
8d4e8898:	aa 18       	IF CC JUMP 0x0x8d4e89ec;
8d4e889a:	98 0c       	CC = R0 < 0x3;
8d4e889c:	92 10       	IF !CC JUMP 0x0x8d4e89c0;
8d4e889e:	03 c8 00 18 	MNOP || [P3 + 0x18] = R6 || R0 = [FP -0x8];
8d4e88a2:	9e b1 e0 b9 
8d4e88a6:	5d b1       	[P3 + 0x14] = R5;
8d4e88a8:	9d e6 04 00 	B[P3 + 0x4] = R5;
8d4e88ac:	01 da 03 84 	R1=-2080149172;
8d4e88b0:	4c 71 00 00 
8d4e88b4:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e88b8:	76 a3 00 00 
8d4e88bc:	70 b9       	R0 = [FP -0x24];
8d4e88be:	07 0a       	CC = R7 <= R0 (IU);
8d4e88c0:	79 18       	IF CC JUMP 0x0x8d4e89b2;
8d4e88c2:	65 bb       	[FP -0x28] = R5;
8d4e88c4:	b5 e6 70 01 	B[SP + 0x170] = R5;
8d4e88c8:	03 c8 00 18 	MNOP || R0 = [FP -0x40] || [FP -0x24] = R6;
8d4e88cc:	00 b9 76 bb 
8d4e88d0:	07 0a       	CC = R7 <= R0 (IU);
8d4e88d2:	6c 18       	IF CC JUMP 0x0x8d4e89aa;
8d4e88d4:	06 bb       	[FP -0x40] = R6;
8d4e88d6:	f5 ba       	[FP -0x44] = R5;
8d4e88d8:	b5 e6 54 01 	B[SP + 0x154] = R5;
8d4e88dc:	30 e4 3e 00 	R0 = [SP + 0xf8];
8d4e88e0:	07 0a       	CC = R7 <= R0 (IU);
8d4e88e2:	5f 18       	IF CC JUMP 0x0x8d4e89a0;
8d4e88e4:	36 e6 3e 00 	[SP + 0xf8] = R6;
8d4e88e8:	35 e6 3d 00 	[SP + 0xf4] = R5;
8d4e88ec:	b5 e6 e4 00 	B[SP + 0xe4] = R5;
8d4e88f0:	30 e4 37 00 	R0 = [SP + 0xdc];
8d4e88f4:	07 0a       	CC = R7 <= R0 (IU);
8d4e88f6:	4f 18       	IF CC JUMP 0x0x8d4e8994;
8d4e88f8:	36 e6 37 00 	[SP + 0xdc] = R6;
8d4e88fc:	35 e6 36 00 	[SP + 0xd8] = R5;
8d4e8900:	b5 e6 c8 00 	B[SP + 0xc8] = R5;
8d4e8904:	30 e4 30 00 	R0 = [SP + 0xc0];
8d4e8908:	07 0a       	CC = R7 <= R0 (IU);
8d4e890a:	3f 18       	IF CC JUMP 0x0x8d4e8988;
8d4e890c:	36 e6 30 00 	[SP + 0xc0] = R6;
8d4e8910:	35 e6 2f 00 	[SP + 0xbc] = R5;
8d4e8914:	b5 e6 ac 00 	B[SP + 0xac] = R5;
8d4e8918:	30 e4 29 00 	R0 = [SP + 0xa4];
8d4e891c:	07 0a       	CC = R7 <= R0 (IU);
8d4e891e:	2f 18       	IF CC JUMP 0x0x8d4e897c;
8d4e8920:	36 e6 29 00 	[SP + 0xa4] = R6;
8d4e8924:	35 e6 28 00 	[SP + 0xa0] = R5;
8d4e8928:	b5 e6 90 00 	B[SP + 0x90] = R5;
8d4e892c:	30 e4 22 00 	R0 = [SP + 0x88];
8d4e8930:	07 0a       	CC = R7 <= R0 (IU);
8d4e8932:	1f 18       	IF CC JUMP 0x0x8d4e8970;
8d4e8934:	36 e6 22 00 	[SP + 0x88] = R6;
8d4e8938:	35 e6 21 00 	[SP + 0x84] = R5;
8d4e893c:	b5 e6 74 00 	B[SP + 0x74] = R5;
8d4e8940:	30 e4 1b 00 	R0 = [SP + 0x6c];
8d4e8944:	07 0a       	CC = R7 <= R0 (IU);
8d4e8946:	09 18       	IF CC JUMP 0x0x8d4e8958;
8d4e8948:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e894c:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e894e:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e8950:	01 e8 00 00 	UNLINK;
8d4e8954:	10 00       	RTS;
8d4e8956:	00 00       	NOP;
8d4e8958:	30 e4 16 00 	R0 = [SP + 0x58];
8d4e895c:	ff e3 44 2d 	CALL 0x0x8d4ce3e4;
8d4e8960:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e8964:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e8966:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e8968:	01 e8 00 00 	UNLINK;
8d4e896c:	10 00       	RTS;
8d4e896e:	00 00       	NOP;
8d4e8970:	30 e4 1d 00 	R0 = [SP + 0x74];
8d4e8974:	ff e3 38 2d 	CALL 0x0x8d4ce3e4;
8d4e8978:	de 2f       	JUMP.S 0x0x8d4e8934;
8d4e897a:	00 00       	NOP;
8d4e897c:	30 e4 24 00 	R0 = [SP + 0x90];
8d4e8980:	ff e3 32 2d 	CALL 0x0x8d4ce3e4;
8d4e8984:	ce 2f       	JUMP.S 0x0x8d4e8920;
8d4e8986:	00 00       	NOP;
8d4e8988:	30 e4 2b 00 	R0 = [SP + 0xac];
8d4e898c:	ff e3 2c 2d 	CALL 0x0x8d4ce3e4;
8d4e8990:	be 2f       	JUMP.S 0x0x8d4e890c;
8d4e8992:	00 00       	NOP;
8d4e8994:	30 e4 32 00 	R0 = [SP + 0xc8];
8d4e8998:	ff e3 26 2d 	CALL 0x0x8d4ce3e4;
8d4e899c:	ae 2f       	JUMP.S 0x0x8d4e88f8;
8d4e899e:	00 00       	NOP;
8d4e89a0:	30 e4 39 00 	R0 = [SP + 0xe4];
8d4e89a4:	ff e3 20 2d 	CALL 0x0x8d4ce3e4;
8d4e89a8:	9e 2f       	JUMP.S 0x0x8d4e88e4;
8d4e89aa:	b0 b8       	R0 = [FP -0x54];
8d4e89ac:	ff e3 1c 2d 	CALL 0x0x8d4ce3e4;
8d4e89b0:	92 2f       	JUMP.S 0x0x8d4e88d4;
8d4e89b2:	20 b9       	R0 = [FP -0x38];
8d4e89b4:	ff e3 18 2d 	CALL 0x0x8d4ce3e4;
8d4e89b8:	85 2f       	JUMP.S 0x0x8d4e88c2;
8d4e89ba:	00 00       	NOP;
8d4e89bc:	00 00       	NOP;
8d4e89be:	00 00       	NOP;
8d4e89c0:	03 c8 00 18 	MNOP || P0 = [FP -0x38] || R3 = [FP -0x24];
8d4e89c4:	28 b9 73 b9 
8d4e89c8:	4f 32       	P1 = FP;
8d4e89ca:	1f 0a       	CC = R7 <= R3 (IU);
8d4e89cc:	41 6e       	P1 += -0x38;		/* (-56) */
8d4e89ce:	c8 07       	IF CC P1 = P0;
8d4e89d0:	f5 bc       	[SP + 0xc] = P5;
8d4e89d2:	31 bd       	[SP + 0x10] = P1;
8d4e89d4:	01 da 03 84 	R1=-2080148832;
8d4e89d8:	a0 72 00 00 
8d4e89dc:	22 e1 1d 03 	R2 = 0x31d (X);		/*		R2=0x31d(797) */
8d4e89e0:	18 60       	R0 = 0x3 (X);		/*		R0=0x54( 84) */
8d4e89e2:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e89e6:	74 05 00 00 
8d4e89ea:	5a 2f       	JUMP.S 0x0x8d4e889e;
8d4e89ec:	98 0c       	CC = R0 < 0x3;
8d4e89ee:	02 1c       	IF CC JUMP 0x0x8d4e89f2 (BP);
8d4e89f0:	e0 21       	JUMP.S 0x0x8d4e8db0;
8d4e89f2:	46 30       	R0 = SP;
8d4e89f4:	22 e1 54 01 	R2 = 0x154 (X);		/*		R2=0x154(340) */
8d4e89f8:	04 cc 02 00 	R0 = R0 + R2 (NS) || R2 = [FP -0x40] || R3 = [FP -0x54];
8d4e89fc:	02 b9 b3 b8 
8d4e8a00:	17 0a       	CC = R7 <= R2 (IU);
8d4e8a02:	74 b9       	R4 = [FP -0x24];
8d4e8a04:	4f 30       	R1 = FP;
8d4e8a06:	03 07       	IF CC R0 = R3;
8d4e8a08:	27 0a       	CC = R7 <= R4 (IU);
8d4e8a0a:	41 66       	R1 += -0x38;		/* (-56) */
8d4e8a0c:	24 b9       	R4 = [FP -0x38];
8d4e8a0e:	0c 07       	IF CC R1 = R4;
8d4e8a10:	00 de 03 8c 	CALL.A 0x8c03e250;
8d4e8a14:	50 e2 00 00 
8d4e8a18:	00 0c       	CC = R0 == 0x0;
8d4e8a1a:	bb 10       	IF !CC JUMP 0x0x8d4e8b90;
8d4e8a1c:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e8a20:	fc 1e 00 00 
8d4e8a24:	98 0c       	CC = R0 < 0x3;
8d4e8a26:	91 10       	IF !CC JUMP 0x0x8d4e8b48;
8d4e8a28:	03 c8 00 18 	MNOP || [P3 + 0x18] = R6 || R0 = [FP -0x8];
8d4e8a2c:	9e b1 e0 b9 
8d4e8a30:	5d b1       	[P3 + 0x14] = R5;
8d4e8a32:	9d e6 04 00 	B[P3 + 0x4] = R5;
8d4e8a36:	01 da 03 84 	R1=-2080149172;
8d4e8a3a:	4c 71 00 00 
8d4e8a3e:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e8a42:	76 a3 00 00 
8d4e8a46:	70 b9       	R0 = [FP -0x24];
8d4e8a48:	07 0a       	CC = R7 <= R0 (IU);
8d4e8a4a:	78 18       	IF CC JUMP 0x0x8d4e8b3a;
8d4e8a4c:	65 bb       	[FP -0x28] = R5;
8d4e8a4e:	b5 e6 70 01 	B[SP + 0x170] = R5;
8d4e8a52:	03 c8 00 18 	MNOP || R0 = [FP -0x40] || [FP -0x24] = R6;
8d4e8a56:	00 b9 76 bb 
8d4e8a5a:	07 0a       	CC = R7 <= R0 (IU);
8d4e8a5c:	6b 18       	IF CC JUMP 0x0x8d4e8b32;
8d4e8a5e:	06 bb       	[FP -0x40] = R6;
8d4e8a60:	f5 ba       	[FP -0x44] = R5;
8d4e8a62:	b5 e6 54 01 	B[SP + 0x154] = R5;
8d4e8a66:	30 e4 3e 00 	R0 = [SP + 0xf8];
8d4e8a6a:	07 0a       	CC = R7 <= R0 (IU);
8d4e8a6c:	5e 18       	IF CC JUMP 0x0x8d4e8b28;
8d4e8a6e:	36 e6 3e 00 	[SP + 0xf8] = R6;
8d4e8a72:	35 e6 3d 00 	[SP + 0xf4] = R5;
8d4e8a76:	b5 e6 e4 00 	B[SP + 0xe4] = R5;
8d4e8a7a:	30 e4 37 00 	R0 = [SP + 0xdc];
8d4e8a7e:	07 0a       	CC = R7 <= R0 (IU);
8d4e8a80:	4e 18       	IF CC JUMP 0x0x8d4e8b1c;
8d4e8a82:	36 e6 37 00 	[SP + 0xdc] = R6;
8d4e8a86:	35 e6 36 00 	[SP + 0xd8] = R5;
8d4e8a8a:	b5 e6 c8 00 	B[SP + 0xc8] = R5;
8d4e8a8e:	30 e4 30 00 	R0 = [SP + 0xc0];
8d4e8a92:	07 0a       	CC = R7 <= R0 (IU);
8d4e8a94:	3e 18       	IF CC JUMP 0x0x8d4e8b10;
8d4e8a96:	36 e6 30 00 	[SP + 0xc0] = R6;
8d4e8a9a:	35 e6 2f 00 	[SP + 0xbc] = R5;
8d4e8a9e:	b5 e6 ac 00 	B[SP + 0xac] = R5;
8d4e8aa2:	30 e4 29 00 	R0 = [SP + 0xa4];
8d4e8aa6:	07 0a       	CC = R7 <= R0 (IU);
8d4e8aa8:	2e 18       	IF CC JUMP 0x0x8d4e8b04;
8d4e8aaa:	36 e6 29 00 	[SP + 0xa4] = R6;
8d4e8aae:	35 e6 28 00 	[SP + 0xa0] = R5;
8d4e8ab2:	b5 e6 90 00 	B[SP + 0x90] = R5;
8d4e8ab6:	30 e4 22 00 	R0 = [SP + 0x88];
8d4e8aba:	07 0a       	CC = R7 <= R0 (IU);
8d4e8abc:	1e 18       	IF CC JUMP 0x0x8d4e8af8;
8d4e8abe:	36 e6 22 00 	[SP + 0x88] = R6;
8d4e8ac2:	35 e6 21 00 	[SP + 0x84] = R5;
8d4e8ac6:	b5 e6 74 00 	B[SP + 0x74] = R5;
8d4e8aca:	30 e4 1b 00 	R0 = [SP + 0x6c];
8d4e8ace:	07 0a       	CC = R7 <= R0 (IU);
8d4e8ad0:	08 18       	IF CC JUMP 0x0x8d4e8ae0;
8d4e8ad2:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e8ad6:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e8ad8:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e8ada:	01 e8 00 00 	UNLINK;
8d4e8ade:	10 00       	RTS;
8d4e8ae0:	30 e4 16 00 	R0 = [SP + 0x58];
8d4e8ae4:	ff e3 80 2c 	CALL 0x0x8d4ce3e4;
8d4e8ae8:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e8aec:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e8aee:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e8af0:	01 e8 00 00 	UNLINK;
8d4e8af4:	10 00       	RTS;
8d4e8af6:	00 00       	NOP;
8d4e8af8:	30 e4 1d 00 	R0 = [SP + 0x74];
8d4e8afc:	ff e3 74 2c 	CALL 0x0x8d4ce3e4;
8d4e8b00:	df 2f       	JUMP.S 0x0x8d4e8abe;
8d4e8b02:	00 00       	NOP;
8d4e8b04:	30 e4 24 00 	R0 = [SP + 0x90];
8d4e8b08:	ff e3 6e 2c 	CALL 0x0x8d4ce3e4;
8d4e8b0c:	cf 2f       	JUMP.S 0x0x8d4e8aaa;
8d4e8b0e:	00 00       	NOP;
8d4e8b10:	30 e4 2b 00 	R0 = [SP + 0xac];
8d4e8b14:	ff e3 68 2c 	CALL 0x0x8d4ce3e4;
8d4e8b18:	bf 2f       	JUMP.S 0x0x8d4e8a96;
8d4e8b1a:	00 00       	NOP;
8d4e8b1c:	30 e4 32 00 	R0 = [SP + 0xc8];
8d4e8b20:	ff e3 62 2c 	CALL 0x0x8d4ce3e4;
8d4e8b24:	af 2f       	JUMP.S 0x0x8d4e8a82;
8d4e8b26:	00 00       	NOP;
8d4e8b28:	30 e4 39 00 	R0 = [SP + 0xe4];
8d4e8b2c:	ff e3 5c 2c 	CALL 0x0x8d4ce3e4;
8d4e8b30:	9f 2f       	JUMP.S 0x0x8d4e8a6e;
8d4e8b32:	b0 b8       	R0 = [FP -0x54];
8d4e8b34:	ff e3 58 2c 	CALL 0x0x8d4ce3e4;
8d4e8b38:	93 2f       	JUMP.S 0x0x8d4e8a5e;
8d4e8b3a:	20 b9       	R0 = [FP -0x38];
8d4e8b3c:	ff e3 54 2c 	CALL 0x0x8d4ce3e4;
8d4e8b40:	86 2f       	JUMP.S 0x0x8d4e8a4c;
8d4e8b42:	00 00       	NOP;
8d4e8b44:	00 00       	NOP;
8d4e8b46:	00 00       	NOP;
8d4e8b48:	03 c8 00 18 	MNOP || P5 = [FP -0x54] || R3 = [FP -0x40];
8d4e8b4c:	bd b8 03 b9 
8d4e8b50:	03 c8 00 18 	MNOP || P2 = [FP -0x38] || R4 = [FP -0x24];
8d4e8b54:	2a b9 74 b9 
8d4e8b58:	08 da 03 84 	P0=-2080148324;
8d4e8b5c:	9c 74 00 00 
8d4e8b60:	2c e1 54 01 	P4 = 0x154 (X);		/*		P4=0x154(340) */
8d4e8b64:	f0 bc       	[SP + 0xc] = P0;
8d4e8b66:	1f 0a       	CC = R7 <= R3 (IU);
8d4e8b68:	26 5a       	P0 = SP + P4;
8d4e8b6a:	4f 32       	P1 = FP;
8d4e8b6c:	c5 07       	IF CC P0 = P5;
8d4e8b6e:	27 0a       	CC = R7 <= R4 (IU);
8d4e8b70:	41 6e       	P1 += -0x38;		/* (-56) */
8d4e8b72:	ca 07       	IF CC P1 = P2;
8d4e8b74:	30 bd       	[SP + 0x10] = P0;
8d4e8b76:	71 bd       	[SP + 0x14] = P1;
8d4e8b78:	22 e1 22 03 	R2 = 0x322 (X);		/*		R2=0x322(802) */
8d4e8b7c:	18 60       	R0 = 0x3 (X);		/*		R0=0x54( 84) */
8d4e8b7e:	01 da 03 84 	R1=-2080148832;
8d4e8b82:	a0 72 00 00 
8d4e8b86:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e8b8a:	74 05 00 00 
8d4e8b8e:	4d 2f       	JUMP.S 0x0x8d4e8a28;
8d4e8b90:	4f 30       	R1 = FP;
8d4e8b92:	21 66       	R1 += -0x3c;		/* (-60) */
8d4e8b94:	01 30       	R0 = R1;
8d4e8b96:	02 da 03 84 	R2=-2080149172;
8d4e8b9a:	4c 71 00 00 
8d4e8b9e:	40 66       	R0 += -0x38;		/* (-56) */
8d4e8ba0:	22 67       	R2 += -0x1c;		/* (-28) */
8d4e8ba2:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e8ba6:	94 f1 00 00 
8d4e8baa:	24 e1 34 01 	R4 = 0x134 (X);		/*		R4=0x134(308) */
8d4e8bae:	5e 30       	R3 = SP;
8d4e8bb0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4e8bb4:	b8 00 02 00 
8d4e8bb8:	04 cc 1c 02 	R1 = R3 + R4 (NS) || [SP + 0xc] = R2 || NOP;
8d4e8bbc:	f2 b0 00 00 
8d4e8bc0:	20 e1 ac ff 	R0 = -0x54 (X);		/*		R0=0xffffffac(-84) */
8d4e8bc4:	01 50       	R0 = R1 + R0;
8d4e8bc6:	02 60       	R2 = 0x0 (X);		/*		R2=0x322(802) */
8d4e8bc8:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e8bcc:	70 e9 00 00 
8d4e8bd0:	90 b8       	R0 = [FP -0x5c];
8d4e8bd2:	07 0a       	CC = R7 <= R0 (IU);
8d4e8bd4:	e9 18       	IF CC JUMP 0x0x8d4e8da6;
8d4e8bd6:	85 ba       	[FP -0x60] = R5;
8d4e8bd8:	b5 e6 38 01 	B[SP + 0x138] = R5;
8d4e8bdc:	03 c8 00 18 	MNOP || R0 = [FP -0x24] || [FP -0x5c] = R6;
8d4e8be0:	70 b9 96 ba 
8d4e8be4:	07 0a       	CC = R7 <= R0 (IU);
8d4e8be6:	dc 18       	IF CC JUMP 0x0x8d4e8d9e;
8d4e8be8:	65 bb       	[FP -0x28] = R5;
8d4e8bea:	b5 e6 70 01 	B[SP + 0x170] = R5;
8d4e8bee:	03 c8 00 18 	MNOP || R0 = [FP -0x40] || [FP -0x24] = R6;
8d4e8bf2:	00 b9 76 bb 
8d4e8bf6:	07 0a       	CC = R7 <= R0 (IU);
8d4e8bf8:	cf 18       	IF CC JUMP 0x0x8d4e8d96;
8d4e8bfa:	06 bb       	[FP -0x40] = R6;
8d4e8bfc:	f5 ba       	[FP -0x44] = R5;
8d4e8bfe:	b5 e6 54 01 	B[SP + 0x154] = R5;
8d4e8c02:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || R1 = [FP -0x4];
8d4e8c06:	f0 b9 f1 b9 
8d4e8c0a:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e8c0c:	7a 61       	R2 = 0x2f (X);		/*		R2=0x322(802) */
8d4e8c0e:	ff e3 cf c9 	CALL 0x0x8d4e1fac;
8d4e8c12:	26 e1 70 00 	R6 = 0x70 (X);		/*		R6=0x70(112) */
8d4e8c16:	5e 30       	R3 = SP;
8d4e8c18:	04 cc 1e 02 	R1 = R3 + R6 (NS) || R4 = [FP -0x4] || NOP;
8d4e8c1c:	f4 b9 00 00 
8d4e8c20:	11 30       	R2 = R1;
8d4e8c22:	41 66       	R1 += -0x38;		/* (-56) */
8d4e8c24:	25 e1 c4 00 	R5 = 0xc4 (X);		/*		R5=0xc4(196) */
8d4e8c28:	29 50       	R0 = R1 + R5;
8d4e8c2a:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d4e8c2e:	e4 f0 00 00 
8d4e8c32:	7e 30       	R7 = SP;
8d4e8c34:	c6 61       	R6 = 0x38 (X);		/*		R6=0x70(112) */
8d4e8c36:	04 cc 3e 00 	R0 = R7 + R6 (NS) || R6 = [FP -0x18] || NOP;
8d4e8c3a:	a6 b9 00 00 
8d4e8c3e:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8c42:	34 a3 00 00 
8d4e8c46:	25 e1 fc 00 	R5 = 0xfc (X);		/*		R5=0xfc(252) */
8d4e8c4a:	5e 30       	R3 = SP;
8d4e8c4c:	6b 51       	R5 = R3 + R5;
8d4e8c4e:	05 30       	R0 = R5;
8d4e8c50:	00 de 0b 8c 	CALL.A 0x8c0bab56;
8d4e8c54:	56 ab 00 00 
8d4e8c58:	ff e3 69 c2 	CALL 0x0x8d4e112a;
8d4e8c5c:	ff e3 1c e9 	CALL 0x0x8d4e5e94;
8d4e8c60:	03 c8 00 18 	MNOP || R0 = [FP -0x18] || R2 = [FP -0x18];
8d4e8c64:	a0 b9 a2 b9 
8d4e8c68:	03 c8 00 18 	MNOP || R3 = [FP -0xc] || [SP + 0x10] = R0;
8d4e8c6c:	d3 b9 30 b1 
8d4e8c70:	09 68       	P1 = 0x1 (X);		/*		P1=0x0(  0) */
8d4e8c72:	00 68       	P0 = 0x0 (X);		/*		P0=0x0(  0) */
8d4e8c74:	f3 b0       	[SP + 0xc] = R3;
8d4e8c76:	b1 bd       	[SP + 0x18] = P1;
8d4e8c78:	70 bd       	[SP + 0x14] = P0;
8d4e8c7a:	c2 65       	R2 += 0x38;		/* ( 56) */
8d4e8c7c:	01 da 29 84 	R1=-2077631728;
8d4e8c80:	10 db 00 00 
8d4e8c84:	00 da 29 84 	R0=-2077631748;
8d4e8c88:	fc da 00 00 
8d4e8c8c:	ff e3 2c f5 	CALL 0x0x8d4e76e4;
8d4e8c90:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || R1 = [FP -0xc];
8d4e8c94:	f0 b9 d1 b9 
8d4e8c98:	00 e3 6c 06 	CALL 0x0x8d4e9970;
8d4e8c9c:	00 0c       	CC = R0 == 0x0;
8d4e8c9e:	49 10       	IF !CC JUMP 0x0x8d4e8d30;
8d4e8ca0:	03 c8 00 18 	MNOP || R1 = [FP -0xc] || R0 = [FP -0x4];
8d4e8ca4:	d1 b9 f0 b9 
8d4e8ca8:	00 e3 64 06 	CALL 0x0x8d4e9970;
8d4e8cac:	00 0c       	CC = R0 == 0x0;
8d4e8cae:	39 10       	IF !CC JUMP 0x0x8d4e8d20;
8d4e8cb0:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP -0x8] || NOP;
8d4e8cb4:	e0 b9 00 00 
8d4e8cb8:	00 de 0b 8c 	CALL.A 0x8c0bab8e;
8d4e8cbc:	8e ab 00 00 
8d4e8cc0:	05 30       	R0 = R5;
8d4e8cc2:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8cc6:	34 a3 00 00 
8d4e8cca:	4e 30       	R1 = SP;
8d4e8ccc:	22 e1 e0 00 	R2 = 0xe0 (X);		/*		R2=0xe0(224) */
8d4e8cd0:	11 50       	R0 = R1 + R2;
8d4e8cd2:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8cd6:	34 a3 00 00 
8d4e8cda:	90 b9       	R0 = [FP -0x1c];
8d4e8cdc:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8ce0:	34 a3 00 00 
8d4e8ce4:	06 30       	R0 = R6;
8d4e8ce6:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8cea:	34 a3 00 00 
8d4e8cee:	b0 b9       	R0 = [FP -0x14];
8d4e8cf0:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8cf4:	34 a3 00 00 
8d4e8cf8:	4e 30       	R1 = SP;
8d4e8cfa:	22 e1 70 00 	R2 = 0x70 (X);		/*		R2=0x70(112) */
8d4e8cfe:	11 50       	R0 = R1 + R2;
8d4e8d00:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8d04:	34 a3 00 00 
8d4e8d08:	f0 b9       	R0 = [FP -0x4];
8d4e8d0a:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8d0e:	34 a3 00 00 
8d4e8d12:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e8d14:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e8d16:	01 e8 00 00 	UNLINK;
8d4e8d1a:	10 00       	RTS;
8d4e8d1c:	00 00       	NOP;
8d4e8d1e:	00 00       	NOP;
8d4e8d20:	00 da 29 84 	R0=-2077631748;
8d4e8d24:	fc da 00 00 
8d4e8d28:	05 e3 7a e1 	CALL 0x0x8d5a501c;
8d4e8d2c:	c2 2f       	JUMP.S 0x0x8d4e8cb0;
8d4e8d2e:	00 00       	NOP;
8d4e8d30:	03 c8 00 18 	MNOP || R1 = [FP + 0x10] || R0 = [FP -0x4];
8d4e8d34:	39 a1 f0 b9 
8d4e8d38:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4e8d3c:	88 bf 00 00 
8d4e8d40:	00 0c       	CC = R0 == 0x0;
8d4e8d42:	af 17       	IF !CC JUMP 0x0x8d4e8ca0 (BP);
8d4e8d44:	20 e1 c4 00 	R0 = 0xc4 (X);		/*		R0=0xc4(196) */
8d4e8d48:	f2 b9       	R2 = [FP -0x4];
8d4e8d4a:	04 50       	R0 = R4 + R0;
8d4e8d4c:	01 da 03 84 	R1=-2080148688;
8d4e8d50:	30 73 00 00 
8d4e8d54:	00 de 04 8c 	CALL.A 0x8c04ee6c;
8d4e8d58:	6c ee 00 00 
8d4e8d5c:	27 e1 18 01 	R7 = 0x118 (X);		/*		R7=0x118(280) */
8d4e8d60:	5e 30       	R3 = SP;
8d4e8d62:	fb 51       	R7 = R3 + R7;
8d4e8d64:	07 30       	R0 = R7;
8d4e8d66:	00 de 0b 8c 	CALL.A 0x8c0bab56;
8d4e8d6a:	56 ab 00 00 
8d4e8d6e:	00 de 03 8c 	CALL.A 0x8c03e328;
8d4e8d72:	28 e3 00 00 
8d4e8d76:	00 0c       	CC = R0 == 0x0;
8d4e8d78:	07 10       	IF !CC JUMP 0x0x8d4e8d86;
8d4e8d7a:	07 30       	R0 = R7;
8d4e8d7c:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8d80:	34 a3 00 00 
8d4e8d84:	8e 2f       	JUMP.S 0x0x8d4e8ca0;
8d4e8d86:	f1 b9       	R1 = [FP -0x4];
8d4e8d88:	00 da 29 84 	R0=-2077631748;
8d4e8d8c:	fc da 00 00 
8d4e8d90:	05 e3 d8 f8 	CALL 0x0x8d5a7f40;
8d4e8d94:	f3 2f       	JUMP.S 0x0x8d4e8d7a;
8d4e8d96:	b0 b8       	R0 = [FP -0x54];
8d4e8d98:	ff e3 26 2b 	CALL 0x0x8d4ce3e4;
8d4e8d9c:	2f 2f       	JUMP.S 0x0x8d4e8bfa;
8d4e8d9e:	20 b9       	R0 = [FP -0x38];
8d4e8da0:	ff e3 22 2b 	CALL 0x0x8d4ce3e4;
8d4e8da4:	22 2f       	JUMP.S 0x0x8d4e8be8;
8d4e8da6:	40 b8       	R0 = [FP -0x70];
8d4e8da8:	ff e3 1e 2b 	CALL 0x0x8d4ce3e4;
8d4e8dac:	15 2f       	JUMP.S 0x0x8d4e8bd6;
8d4e8dae:	00 00       	NOP;
8d4e8db0:	03 c8 00 18 	MNOP || P5 = [FP -0x54] || R3 = [FP -0x40];
8d4e8db4:	bd b8 03 b9 
8d4e8db8:	03 c8 00 18 	MNOP || P2 = [FP -0x38] || R4 = [FP -0x24];
8d4e8dbc:	2a b9 74 b9 
8d4e8dc0:	08 da 03 84 	P0=-2080148348;
8d4e8dc4:	84 74 00 00 
8d4e8dc8:	2c e1 54 01 	P4 = 0x154 (X);		/*		P4=0x154(340) */
8d4e8dcc:	f0 bc       	[SP + 0xc] = P0;
8d4e8dce:	1f 0a       	CC = R7 <= R3 (IU);
8d4e8dd0:	26 5a       	P0 = SP + P4;
8d4e8dd2:	4f 32       	P1 = FP;
8d4e8dd4:	c5 07       	IF CC P0 = P5;
8d4e8dd6:	27 0a       	CC = R7 <= R4 (IU);
8d4e8dd8:	41 6e       	P1 += -0x38;		/* (-56) */
8d4e8dda:	ca 07       	IF CC P1 = P2;
8d4e8ddc:	30 bd       	[SP + 0x10] = P0;
8d4e8dde:	71 bd       	[SP + 0x14] = P1;
8d4e8de0:	22 e1 20 03 	R2 = 0x320 (X);		/*		R2=0x320(800) */
8d4e8de4:	18 60       	R0 = 0x3 (X);		/*		R0=0xc4(196) */
8d4e8de6:	01 da 03 84 	R1=-2080148832;
8d4e8dea:	a0 72 00 00 
8d4e8dee:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e8df2:	74 05 00 00 
8d4e8df6:	fe 2d       	JUMP.S 0x0x8d4e89f2;
8d4e8df8:	40 b8       	R0 = [FP -0x70];
8d4e8dfa:	ff e3 f5 2a 	CALL 0x0x8d4ce3e4;
8d4e8dfe:	38 2d       	JUMP.S 0x0x8d4e886e;
8d4e8e00:	30 e4 47 00 	R0 = [SP + 0x11c];
8d4e8e04:	ff e3 f0 2a 	CALL 0x0x8d4ce3e4;
8d4e8e08:	29 2d       	JUMP.S 0x0x8d4e885a;
8d4e8e0a:	00 00       	NOP;
8d4e8e0c:	23 e1 70 00 	R3 = 0x70 (X);		/*		R3=0x70(112) */
8d4e8e10:	3a a1       	R2 = [FP + 0x10];
8d4e8e12:	04 cc 23 00 	R0 = R4 + R3 (NS) || R1 = [FP -0x1c] || NOP;
8d4e8e16:	91 b9 00 00 
8d4e8e1a:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e8e1e:	94 f1 00 00 
8d4e8e22:	24 e1 8c 00 	R4 = 0x8c (X);		/*		R4=0x8c(140) */
8d4e8e26:	03 c8 00 18 	MNOP || R3 = [FP -0x18] || R2 = [FP -0x18];
8d4e8e2a:	a3 b9 a2 b9 
8d4e8e2e:	23 50       	R0 = R3 + R4;
8d4e8e30:	08 30       	R1 = R0;
8d4e8e32:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e8e34:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d4e8e38:	e4 f0 00 00 
8d4e8e3c:	24 e1 18 01 	R4 = 0x118 (X);		/*		R4=0x118(280) */
8d4e8e40:	5e 30       	R3 = SP;
8d4e8e42:	63 50       	R1 = R3 + R4;
8d4e8e44:	01 30       	R0 = R1;
8d4e8e46:	22 e1 a0 ff 	R2 = -0x60 (X);		/*		R2=0xffffffa0(-96) */
8d4e8e4a:	03 da 03 84 	R3=-2080149172;
8d4e8e4e:	4c 71 00 00 
8d4e8e52:	93 50       	R2 = R3 + R2;
8d4e8e54:	c0 65       	R0 += 0x38;		/* ( 56) */
8d4e8e56:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e8e5a:	94 f1 00 00 
8d4e8e5e:	20 b8       	R0 = [FP -0x78];
8d4e8e60:	07 0a       	CC = R7 <= R0 (IU);
8d4e8e62:	57 19       	IF CC JUMP 0x0x8d4e9110;
8d4e8e64:	15 ba       	[FP -0x7c] = R5;
8d4e8e66:	b5 e6 1c 01 	B[SP + 0x11c] = R5;
8d4e8e6a:	03 c8 00 18 	MNOP || R0 = [FP -0x5c] || [FP -0x78] = R6;
8d4e8e6e:	90 b8 26 ba 
8d4e8e72:	07 0a       	CC = R7 <= R0 (IU);
8d4e8e74:	49 19       	IF CC JUMP 0x0x8d4e9106;
8d4e8e76:	85 ba       	[FP -0x60] = R5;
8d4e8e78:	b5 e6 38 01 	B[SP + 0x138] = R5;
8d4e8e7c:	46 30       	R0 = SP;
8d4e8e7e:	21 e1 54 01 	R1 = 0x154 (X);		/*		R1=0x154(340) */
8d4e8e82:	04 cc 01 00 	R0 = R0 + R1 (NS) || [FP -0x5c] = R6 || NOP;
8d4e8e86:	96 ba 00 00 
8d4e8e8a:	03 c8 00 18 	MNOP || R1 = [FP -0x40] || R2 = [FP -0x54];
8d4e8e8e:	01 b9 b2 b8 
8d4e8e92:	0f 0a       	CC = R7 <= R1 (IU);
8d4e8e94:	02 07       	IF CC R0 = R2;
8d4e8e96:	00 de 03 8c 	CALL.A 0x8c03e29c;
8d4e8e9a:	9c e2 00 00 
8d4e8e9e:	00 0c       	CC = R0 == 0x0;
8d4e8ea0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e8ea4:	fc 1e 00 00 
8d4e8ea8:	87 18       	IF CC JUMP 0x0x8d4e8fb6;
8d4e8eaa:	98 0c       	CC = R0 < 0x3;
8d4e8eac:	6e 10       	IF !CC JUMP 0x0x8d4e8f88;
8d4e8eae:	03 c8 00 18 	MNOP || [P3 + 0x18] = R6 || R0 = [FP -0x8];
8d4e8eb2:	9e b1 e0 b9 
8d4e8eb6:	5d b1       	[P3 + 0x14] = R5;
8d4e8eb8:	9d e6 04 00 	B[P3 + 0x4] = R5;
8d4e8ebc:	01 da 03 84 	R1=-2080149172;
8d4e8ec0:	4c 71 00 00 
8d4e8ec4:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e8ec8:	76 a3 00 00 
8d4e8ecc:	00 b9       	R0 = [FP -0x40];
8d4e8ece:	07 0a       	CC = R7 <= R0 (IU);
8d4e8ed0:	57 18       	IF CC JUMP 0x0x8d4e8f7e;
8d4e8ed2:	06 bb       	[FP -0x40] = R6;
8d4e8ed4:	f5 ba       	[FP -0x44] = R5;
8d4e8ed6:	b5 e6 54 01 	B[SP + 0x154] = R5;
8d4e8eda:	30 e4 3e 00 	R0 = [SP + 0xf8];
8d4e8ede:	07 0a       	CC = R7 <= R0 (IU);
8d4e8ee0:	4a 18       	IF CC JUMP 0x0x8d4e8f74;
8d4e8ee2:	36 e6 3e 00 	[SP + 0xf8] = R6;
8d4e8ee6:	35 e6 3d 00 	[SP + 0xf4] = R5;
8d4e8eea:	b5 e6 e4 00 	B[SP + 0xe4] = R5;
8d4e8eee:	30 e4 37 00 	R0 = [SP + 0xdc];
8d4e8ef2:	07 0a       	CC = R7 <= R0 (IU);
8d4e8ef4:	3a 18       	IF CC JUMP 0x0x8d4e8f68;
8d4e8ef6:	36 e6 37 00 	[SP + 0xdc] = R6;
8d4e8efa:	35 e6 36 00 	[SP + 0xd8] = R5;
8d4e8efe:	b5 e6 c8 00 	B[SP + 0xc8] = R5;
8d4e8f02:	30 e4 30 00 	R0 = [SP + 0xc0];
8d4e8f06:	07 0a       	CC = R7 <= R0 (IU);
8d4e8f08:	2a 18       	IF CC JUMP 0x0x8d4e8f5c;
8d4e8f0a:	36 e6 30 00 	[SP + 0xc0] = R6;
8d4e8f0e:	35 e6 2f 00 	[SP + 0xbc] = R5;
8d4e8f12:	b5 e6 ac 00 	B[SP + 0xac] = R5;
8d4e8f16:	30 e4 29 00 	R0 = [SP + 0xa4];
8d4e8f1a:	07 0a       	CC = R7 <= R0 (IU);
8d4e8f1c:	1a 18       	IF CC JUMP 0x0x8d4e8f50;
8d4e8f1e:	4e 30       	R1 = SP;
8d4e8f20:	22 e1 70 00 	R2 = 0x70 (X);		/*		R2=0x70(112) */
8d4e8f24:	36 e6 29 00 	[SP + 0xa4] = R6;
8d4e8f28:	35 e6 28 00 	[SP + 0xa0] = R5;
8d4e8f2c:	b5 e6 90 00 	B[SP + 0x90] = R5;
8d4e8f30:	11 50       	R0 = R1 + R2;
8d4e8f32:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8f36:	34 a3 00 00 
8d4e8f3a:	f0 b9       	R0 = [FP -0x4];
8d4e8f3c:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e8f40:	34 a3 00 00 
8d4e8f44:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e8f46:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e8f48:	01 e8 00 00 	UNLINK;
8d4e8f4c:	10 00       	RTS;
8d4e8f4e:	00 00       	NOP;
8d4e8f50:	30 e4 24 00 	R0 = [SP + 0x90];
8d4e8f54:	ff e3 48 2a 	CALL 0x0x8d4ce3e4;
8d4e8f58:	e3 2f       	JUMP.S 0x0x8d4e8f1e;
8d4e8f5a:	00 00       	NOP;
8d4e8f5c:	30 e4 2b 00 	R0 = [SP + 0xac];
8d4e8f60:	ff e3 42 2a 	CALL 0x0x8d4ce3e4;
8d4e8f64:	d3 2f       	JUMP.S 0x0x8d4e8f0a;
8d4e8f66:	00 00       	NOP;
8d4e8f68:	30 e4 32 00 	R0 = [SP + 0xc8];
8d4e8f6c:	ff e3 3c 2a 	CALL 0x0x8d4ce3e4;
8d4e8f70:	c3 2f       	JUMP.S 0x0x8d4e8ef6;
8d4e8f72:	00 00       	NOP;
8d4e8f74:	30 e4 39 00 	R0 = [SP + 0xe4];
8d4e8f78:	ff e3 36 2a 	CALL 0x0x8d4ce3e4;
8d4e8f7c:	b3 2f       	JUMP.S 0x0x8d4e8ee2;
8d4e8f7e:	b0 b8       	R0 = [FP -0x54];
8d4e8f80:	ff e3 32 2a 	CALL 0x0x8d4ce3e4;
8d4e8f84:	a7 2f       	JUMP.S 0x0x8d4e8ed2;
8d4e8f86:	00 00       	NOP;
8d4e8f88:	03 c8 00 18 	MNOP || P0 = [FP -0x54] || R3 = [FP -0x40];
8d4e8f8c:	b8 b8 03 b9 
8d4e8f90:	29 e1 54 01 	P1 = 0x154 (X);		/*		P1=0x154(340) */
8d4e8f94:	1f 0a       	CC = R7 <= R3 (IU);
8d4e8f96:	4e 5a       	P1 = SP + P1;
8d4e8f98:	c8 07       	IF CC P1 = P0;
8d4e8f9a:	f5 bc       	[SP + 0xc] = P5;
8d4e8f9c:	31 bd       	[SP + 0x10] = P1;
8d4e8f9e:	01 da 03 84 	R1=-2080148832;
8d4e8fa2:	a0 72 00 00 
8d4e8fa6:	22 e1 2a 03 	R2 = 0x32a (X);		/*		R2=0x32a(810) */
8d4e8faa:	18 60       	R0 = 0x3 (X);		/*		R0=0xc4(196) */
8d4e8fac:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e8fb0:	74 05 00 00 
8d4e8fb4:	7d 2f       	JUMP.S 0x0x8d4e8eae;
8d4e8fb6:	98 0c       	CC = R0 < 0x3;
8d4e8fb8:	82 10       	IF !CC JUMP 0x0x8d4e90bc;
8d4e8fba:	b0 b9       	R0 = [FP -0x14];
8d4e8fbc:	00 de 0b 8c 	CALL.A 0x8c0bab56;
8d4e8fc0:	56 ab 00 00 
8d4e8fc4:	4e 30       	R1 = SP;
8d4e8fc6:	22 e1 50 01 	R2 = 0x150 (X);		/*		R2=0x150(336) */
8d4e8fca:	91 51       	R6 = R1 + R2;
8d4e8fcc:	38 30       	R7 = R0;
8d4e8fce:	06 30       	R0 = R6;
8d4e8fd0:	00 de 0b 8c 	CALL.A 0x8c0bab56;
8d4e8fd4:	56 ab 00 00 
8d4e8fd8:	08 30       	R1 = R0;
8d4e8fda:	07 30       	R0 = R7;
8d4e8fdc:	00 de 03 8c 	CALL.A 0x8c03e2f0;
8d4e8fe0:	f0 e2 00 00 
8d4e8fe4:	00 0c       	CC = R0 == 0x0;
8d4e8fe6:	5d 10       	IF !CC JUMP 0x0x8d4e90a0;
8d4e8fe8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e8fec:	fc 1e 00 00 
8d4e8ff0:	98 0c       	CC = R0 < 0x3;
8d4e8ff2:	38 10       	IF !CC JUMP 0x0x8d4e9062;
8d4e8ff4:	e0 b9       	R0 = [FP -0x8];
8d4e8ff6:	01 da 03 84 	R1=-2080149172;
8d4e8ffa:	4c 71 00 00 
8d4e8ffe:	00 de 03 8c 	CALL.A 0x8c03ee00;
8d4e9002:	00 ee 00 00 
8d4e9006:	06 30       	R0 = R6;
8d4e9008:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e900c:	34 a3 00 00 
8d4e9010:	56 30       	R2 = SP;
8d4e9012:	23 e1 e0 00 	R3 = 0xe0 (X);		/*		R3=0xe0(224) */
8d4e9016:	1a 50       	R0 = R2 + R3;
8d4e9018:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e901c:	34 a3 00 00 
8d4e9020:	90 b9       	R0 = [FP -0x1c];
8d4e9022:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e9026:	34 a3 00 00 
8d4e902a:	a0 b9       	R0 = [FP -0x18];
8d4e902c:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e9030:	34 a3 00 00 
8d4e9034:	b0 b9       	R0 = [FP -0x14];
8d4e9036:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e903a:	34 a3 00 00 
8d4e903e:	4e 30       	R1 = SP;
8d4e9040:	22 e1 70 00 	R2 = 0x70 (X);		/*		R2=0x70(112) */
8d4e9044:	11 50       	R0 = R1 + R2;
8d4e9046:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e904a:	34 a3 00 00 
8d4e904e:	f0 b9       	R0 = [FP -0x4];
8d4e9050:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e9054:	34 a3 00 00 
8d4e9058:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e905a:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e905c:	01 e8 00 00 	UNLINK;
8d4e9060:	10 00       	RTS;
8d4e9062:	b0 b9       	R0 = [FP -0x14];
8d4e9064:	00 de 0b 8c 	CALL.A 0x8c0bab56;
8d4e9068:	56 ab 00 00 
8d4e906c:	38 30       	R7 = R0;
8d4e906e:	06 30       	R0 = R6;
8d4e9070:	00 de 0b 8c 	CALL.A 0x8c0bab56;
8d4e9074:	56 ab 00 00 
8d4e9078:	09 da 03 84 	P1=-2080148272;
8d4e907c:	d0 74 00 00 
8d4e9080:	70 b1       	[SP + 0x14] = R0;
8d4e9082:	37 b1       	[SP + 0x10] = R7;
8d4e9084:	f1 bc       	[SP + 0xc] = P1;
8d4e9086:	01 da 03 84 	R1=-2080148832;
8d4e908a:	a0 72 00 00 
8d4e908e:	22 e1 2f 03 	R2 = 0x32f (X);		/*		R2=0x32f(815) */
8d4e9092:	18 60       	R0 = 0x3 (X);		/*		R0=0xc4(196) */
8d4e9094:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e9098:	74 05 00 00 
8d4e909c:	ac 2f       	JUMP.S 0x0x8d4e8ff4;
8d4e909e:	00 00       	NOP;
8d4e90a0:	20 e1 90 ff 	R0 = -0x70 (X);		/*		R0=0xffffff90(-112) */
8d4e90a4:	06 50       	R0 = R6 + R0;
8d4e90a6:	0e 30       	R1 = R6;
8d4e90a8:	00 de 0b 8c 	CALL.A 0x8c0bab70;
8d4e90ac:	70 ab 00 00 
8d4e90b0:	06 30       	R0 = R6;
8d4e90b2:	00 de 09 8c 	CALL.A 0x8c09a334;
8d4e90b6:	34 a3 00 00 
8d4e90ba:	a4 2d       	JUMP.S 0x0x8d4e8c02;
8d4e90bc:	35 e5 24 00 	P5 = [SP + 0x90];
8d4e90c0:	29 e1 54 01 	P1 = 0x154 (X);		/*		P1=0x154(340) */
8d4e90c4:	03 c8 00 18 	MNOP || P4 = [FP -0x54] || R3 = [FP -0x40];
8d4e90c8:	bc b8 03 b9 
8d4e90cc:	0e 5a       	P0 = SP + P1;
8d4e90ce:	36 e4 29 00 	R6 = [SP + 0xa4];
8d4e90d2:	29 e1 90 00 	P1 = 0x90 (X);		/*		P1=0x90(144) */
8d4e90d6:	37 0a       	CC = R7 <= R6 (IU);
8d4e90d8:	4e 5a       	P1 = SP + P1;
8d4e90da:	cd 07       	IF CC P1 = P5;
8d4e90dc:	1f 0a       	CC = R7 <= R3 (IU);
8d4e90de:	c4 07       	IF CC P0 = P4;
8d4e90e0:	0a da 03 84 	P2=-2080148292;
8d4e90e4:	bc 74 00 00 
8d4e90e8:	31 bd       	[SP + 0x10] = P1;
8d4e90ea:	70 bd       	[SP + 0x14] = P0;
8d4e90ec:	f2 bc       	[SP + 0xc] = P2;
8d4e90ee:	22 e1 2d 03 	R2 = 0x32d (X);		/*		R2=0x32d(813) */
8d4e90f2:	18 60       	R0 = 0x3 (X);		/*		R0=0xffffff90(-112) */
8d4e90f4:	01 da 03 84 	R1=-2080148832;
8d4e90f8:	a0 72 00 00 
8d4e90fc:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e9100:	74 05 00 00 
8d4e9104:	5b 2f       	JUMP.S 0x0x8d4e8fba;
8d4e9106:	40 b8       	R0 = [FP -0x70];
8d4e9108:	ff e3 6e 29 	CALL 0x0x8d4ce3e4;
8d4e910c:	b5 2e       	JUMP.S 0x0x8d4e8e76;
8d4e910e:	00 00       	NOP;
8d4e9110:	30 e4 47 00 	R0 = [SP + 0x11c];
8d4e9114:	ff e3 68 29 	CALL 0x0x8d4ce3e4;
8d4e9118:	a6 2e       	JUMP.S 0x0x8d4e8e64;
8d4e911a:	10 b8       	R0 = [FP -0x7c];
8d4e911c:	ff e3 64 29 	CALL 0x0x8d4ce3e4;
8d4e9120:	3c 2b       	JUMP.S 0x0x8d4e8798;
8d4e9122:	00 00       	NOP;
8d4e9124:	00 00       	NOP;
8d4e9126:	00 00       	NOP;
8d4e9128:	03 c8 00 18 	MNOP || R1 = [FP -0x68] || R2 = [FP -0x7c];
8d4e912c:	61 b8 12 b8 
8d4e9130:	46 30       	R0 = SP;
8d4e9132:	23 e1 2c 01 	R3 = 0x12c (X);		/*		R3=0x12c(300) */
8d4e9136:	0f 0a       	CC = R7 <= R1 (IU);
8d4e9138:	18 50       	R0 = R0 + R3;
8d4e913a:	02 07       	IF CC R0 = R2;
8d4e913c:	00 de 03 8c 	CALL.A 0x8c03e06c;
8d4e9140:	6c e0 00 00 
8d4e9144:	1e 2b       	JUMP.S 0x0x8d4e8780;
8d4e9146:	80 b8       	R0 = [FP -0x60];
8d4e9148:	ff e3 4e 29 	CALL 0x0x8d4ce3e4;
8d4e914c:	02 2b       	JUMP.S 0x0x8d4e8750;
8d4e914e:	00 00       	NOP;
8d4e9150:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e9154:	fc 1e 00 00 
8d4e9158:	98 0c       	CC = R0 < 0x3;
8d4e915a:	47 10       	IF !CC JUMP 0x0x8d4e91e8;
8d4e915c:	03 c8 00 18 	MNOP || [P3 + 0x18] = R6 || R0 = [FP -0x10];
8d4e9160:	9e b1 c0 b9 
8d4e9164:	5d b1       	[P3 + 0x14] = R5;
8d4e9166:	9d e6 04 00 	B[P3 + 0x4] = R5;
8d4e916a:	01 da 03 84 	R1=-2080149172;
8d4e916e:	4c 71 00 00 
8d4e9172:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e9176:	76 a3 00 00 
8d4e917a:	30 e4 29 00 	R0 = [SP + 0xa4];
8d4e917e:	07 0a       	CC = R7 <= R0 (IU);
8d4e9180:	2e 18       	IF CC JUMP 0x0x8d4e91dc;
8d4e9182:	36 e6 29 00 	[SP + 0xa4] = R6;
8d4e9186:	35 e6 28 00 	[SP + 0xa0] = R5;
8d4e918a:	b5 e6 90 00 	B[SP + 0x90] = R5;
8d4e918e:	30 e4 22 00 	R0 = [SP + 0x88];
8d4e9192:	07 0a       	CC = R7 <= R0 (IU);
8d4e9194:	1e 18       	IF CC JUMP 0x0x8d4e91d0;
8d4e9196:	36 e6 22 00 	[SP + 0x88] = R6;
8d4e919a:	35 e6 21 00 	[SP + 0x84] = R5;
8d4e919e:	b5 e6 74 00 	B[SP + 0x74] = R5;
8d4e91a2:	30 e4 1b 00 	R0 = [SP + 0x6c];
8d4e91a6:	07 0a       	CC = R7 <= R0 (IU);
8d4e91a8:	08 18       	IF CC JUMP 0x0x8d4e91b8;
8d4e91aa:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e91ae:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e91b0:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e91b2:	01 e8 00 00 	UNLINK;
8d4e91b6:	10 00       	RTS;
8d4e91b8:	30 e4 16 00 	R0 = [SP + 0x58];
8d4e91bc:	ff e3 14 29 	CALL 0x0x8d4ce3e4;
8d4e91c0:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e91c4:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e91c6:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e91c8:	01 e8 00 00 	UNLINK;
8d4e91cc:	10 00       	RTS;
8d4e91ce:	00 00       	NOP;
8d4e91d0:	30 e4 1d 00 	R0 = [SP + 0x74];
8d4e91d4:	ff e3 08 29 	CALL 0x0x8d4ce3e4;
8d4e91d8:	df 2f       	JUMP.S 0x0x8d4e9196;
8d4e91da:	00 00       	NOP;
8d4e91dc:	30 e4 24 00 	R0 = [SP + 0x90];
8d4e91e0:	ff e3 02 29 	CALL 0x0x8d4ce3e4;
8d4e91e4:	cf 2f       	JUMP.S 0x0x8d4e9182;
8d4e91e6:	00 00       	NOP;
8d4e91e8:	30 e5 24 00 	P0 = [SP + 0x90];
8d4e91ec:	30 e4 29 00 	R0 = [SP + 0xa4];
8d4e91f0:	29 e1 90 00 	P1 = 0x90 (X);		/*		P1=0x90(144) */
8d4e91f4:	07 0a       	CC = R7 <= R0 (IU);
8d4e91f6:	4e 5a       	P1 = SP + P1;
8d4e91f8:	c8 07       	IF CC P1 = P0;
8d4e91fa:	31 bd       	[SP + 0x10] = P1;
8d4e91fc:	09 da 03 84 	P1=-2080148412;
8d4e9200:	44 74 00 00 
8d4e9204:	f1 bc       	[SP + 0xc] = P1;
8d4e9206:	22 e1 03 03 	R2 = 0x303 (X);		/*		R2=0x303(771) */
8d4e920a:	01 da 03 84 	R1=-2080148832;
8d4e920e:	a0 72 00 00 
8d4e9212:	18 60       	R0 = 0x3 (X);		/*		R0=0xffffff90(-112) */
8d4e9214:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e9218:	74 05 00 00 
8d4e921c:	a0 2f       	JUMP.S 0x0x8d4e915c;
8d4e921e:	00 00       	NOP;
8d4e9220:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e9224:	fc 1e 00 00 
8d4e9228:	98 0c       	CC = R0 < 0x3;
8d4e922a:	47 10       	IF !CC JUMP 0x0x8d4e92b8;
8d4e922c:	03 c8 00 18 	MNOP || [P3 + 0x18] = R6 || R0 = [FP -0x10];
8d4e9230:	9e b1 c0 b9 
8d4e9234:	5d b1       	[P3 + 0x14] = R5;
8d4e9236:	9d e6 04 00 	B[P3 + 0x4] = R5;
8d4e923a:	01 da 03 84 	R1=-2080149172;
8d4e923e:	4c 71 00 00 
8d4e9242:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e9246:	76 a3 00 00 
8d4e924a:	30 e4 29 00 	R0 = [SP + 0xa4];
8d4e924e:	07 0a       	CC = R7 <= R0 (IU);
8d4e9250:	2e 18       	IF CC JUMP 0x0x8d4e92ac;
8d4e9252:	36 e6 29 00 	[SP + 0xa4] = R6;
8d4e9256:	35 e6 28 00 	[SP + 0xa0] = R5;
8d4e925a:	b5 e6 90 00 	B[SP + 0x90] = R5;
8d4e925e:	30 e4 22 00 	R0 = [SP + 0x88];
8d4e9262:	07 0a       	CC = R7 <= R0 (IU);
8d4e9264:	1e 18       	IF CC JUMP 0x0x8d4e92a0;
8d4e9266:	36 e6 22 00 	[SP + 0x88] = R6;
8d4e926a:	35 e6 21 00 	[SP + 0x84] = R5;
8d4e926e:	b5 e6 74 00 	B[SP + 0x74] = R5;
8d4e9272:	30 e4 1b 00 	R0 = [SP + 0x6c];
8d4e9276:	07 0a       	CC = R7 <= R0 (IU);
8d4e9278:	08 18       	IF CC JUMP 0x0x8d4e9288;
8d4e927a:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e927e:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e9280:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e9282:	01 e8 00 00 	UNLINK;
8d4e9286:	10 00       	RTS;
8d4e9288:	30 e4 16 00 	R0 = [SP + 0x58];
8d4e928c:	ff e3 ac 28 	CALL 0x0x8d4ce3e4;
8d4e9290:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e9294:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e9296:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e9298:	01 e8 00 00 	UNLINK;
8d4e929c:	10 00       	RTS;
8d4e929e:	00 00       	NOP;
8d4e92a0:	30 e4 1d 00 	R0 = [SP + 0x74];
8d4e92a4:	ff e3 a0 28 	CALL 0x0x8d4ce3e4;
8d4e92a8:	df 2f       	JUMP.S 0x0x8d4e9266;
8d4e92aa:	00 00       	NOP;
8d4e92ac:	30 e4 24 00 	R0 = [SP + 0x90];
8d4e92b0:	ff e3 9a 28 	CALL 0x0x8d4ce3e4;
8d4e92b4:	cf 2f       	JUMP.S 0x0x8d4e9252;
8d4e92b6:	00 00       	NOP;
8d4e92b8:	03 c8 00 18 	MNOP || P1 = [FP + 0xc] || R0 = [FP + 0xc];
8d4e92bc:	f9 ac f8 a0 
8d4e92c0:	20 64       	R0 += 0x4;		/* (  4) */
8d4e92c2:	22 e1 ff 02 	R2 = 0x2ff (X);		/*		R2=0x2ff(767) */
8d4e92c6:	89 a1       	R1 = [P1 + 0x18];
8d4e92c8:	08 32       	P1 = R0;
8d4e92ca:	0f 0a       	CC = R7 <= R1 (IU);
8d4e92cc:	02 10       	IF !CC JUMP 0x0x8d4e92d0;
8d4e92ce:	08 91       	R0 = [P1];
8d4e92d0:	30 b1       	[SP + 0x10] = R0;
8d4e92d2:	09 da 03 84 	P1=-2080148448;
8d4e92d6:	20 74 00 00 
8d4e92da:	f1 bc       	[SP + 0xc] = P1;
8d4e92dc:	01 da 03 84 	R1=-2080148832;
8d4e92e0:	a0 72 00 00 
8d4e92e4:	18 60       	R0 = 0x3 (X);		/*		R0=0xffffff90(-112) */
8d4e92e6:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e92ea:	74 05 00 00 
8d4e92ee:	9f 2f       	JUMP.S 0x0x8d4e922c;
8d4e92f0:	30 e4 47 00 	R0 = [SP + 0x11c];
8d4e92f4:	ff e3 78 28 	CALL 0x0x8d4ce3e4;
8d4e92f8:	7c 29       	JUMP.S 0x0x8d4e85f0;
8d4e92fa:	40 b8       	R0 = [FP -0x70];
8d4e92fc:	ff e3 74 28 	CALL 0x0x8d4ce3e4;
8d4e9300:	6e 29       	JUMP.S 0x0x8d4e85dc;
8d4e9302:	00 00       	NOP;
8d4e9304:	00 00       	NOP;
8d4e9306:	00 00       	NOP;
8d4e9308:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e930c:	fc 1e 00 00 
8d4e9310:	98 0c       	CC = R0 < 0x3;
8d4e9312:	3b 10       	IF !CC JUMP 0x0x8d4e9388;
8d4e9314:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P3 + 0x18] = R6 || NOP;
8d4e9318:	9e b1 00 00 
8d4e931c:	5d b1       	[P3 + 0x14] = R5;
8d4e931e:	9d e6 04 00 	B[P3 + 0x4] = R5;
8d4e9322:	01 da 03 84 	R1=-2080149172;
8d4e9326:	4c 71 00 00 
8d4e932a:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e932e:	76 a3 00 00 
8d4e9332:	87 60       	R7 = 0x10 (X);		/*		R7=0x118(280) */
8d4e9334:	30 e4 22 00 	R0 = [SP + 0x88];
8d4e9338:	07 0a       	CC = R7 <= R0 (IU);
8d4e933a:	1f 18       	IF CC JUMP 0x0x8d4e9378;
8d4e933c:	36 e6 22 00 	[SP + 0x88] = R6;
8d4e9340:	35 e6 21 00 	[SP + 0x84] = R5;
8d4e9344:	b5 e6 74 00 	B[SP + 0x74] = R5;
8d4e9348:	30 e4 1b 00 	R0 = [SP + 0x6c];
8d4e934c:	07 0a       	CC = R7 <= R0 (IU);
8d4e934e:	09 18       	IF CC JUMP 0x0x8d4e9360;
8d4e9350:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e9354:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e9356:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e9358:	01 e8 00 00 	UNLINK;
8d4e935c:	10 00       	RTS;
8d4e935e:	00 00       	NOP;
8d4e9360:	30 e4 16 00 	R0 = [SP + 0x58];
8d4e9364:	ff e3 40 28 	CALL 0x0x8d4ce3e4;
8d4e9368:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e936c:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e936e:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e9370:	01 e8 00 00 	UNLINK;
8d4e9374:	10 00       	RTS;
8d4e9376:	00 00       	NOP;
8d4e9378:	30 e4 1d 00 	R0 = [SP + 0x74];
8d4e937c:	ff e3 34 28 	CALL 0x0x8d4ce3e4;
8d4e9380:	de 2f       	JUMP.S 0x0x8d4e933c;
8d4e9382:	00 00       	NOP;
8d4e9384:	00 00       	NOP;
8d4e9386:	00 00       	NOP;
8d4e9388:	09 da 03 84 	P1=-2080148476;
8d4e938c:	04 74 00 00 
8d4e9390:	f1 bc       	[SP + 0xc] = P1;
8d4e9392:	01 da 03 84 	R1=-2080148832;
8d4e9396:	a0 72 00 00 
8d4e939a:	22 e1 f0 02 	R2 = 0x2f0 (X);		/*		R2=0x2f0(752) */
8d4e939e:	18 60       	R0 = 0x3 (X);		/*		R0=0xffffff90(-112) */
8d4e93a0:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e93a4:	74 05 00 00 
8d4e93a8:	b6 2f       	JUMP.S 0x0x8d4e9314;
8d4e93aa:	00 00       	NOP;
8d4e93ac:	00 00       	NOP;
8d4e93ae:	00 00       	NOP;
8d4e93b0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e93b4:	fc 1e 00 00 
8d4e93b8:	98 0c       	CC = R0 < 0x3;
8d4e93ba:	3b 10       	IF !CC JUMP 0x0x8d4e9430;
8d4e93bc:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P3 + 0x18] = R6 || NOP;
8d4e93c0:	9e b1 00 00 
8d4e93c4:	5d b1       	[P3 + 0x14] = R5;
8d4e93c6:	9d e6 04 00 	B[P3 + 0x4] = R5;
8d4e93ca:	01 da 03 84 	R1=-2080149172;
8d4e93ce:	4c 71 00 00 
8d4e93d2:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e93d6:	76 a3 00 00 
8d4e93da:	87 60       	R7 = 0x10 (X);		/*		R7=0x118(280) */
8d4e93dc:	30 e4 22 00 	R0 = [SP + 0x88];
8d4e93e0:	07 0a       	CC = R7 <= R0 (IU);
8d4e93e2:	1f 18       	IF CC JUMP 0x0x8d4e9420;
8d4e93e4:	36 e6 22 00 	[SP + 0x88] = R6;
8d4e93e8:	35 e6 21 00 	[SP + 0x84] = R5;
8d4e93ec:	b5 e6 74 00 	B[SP + 0x74] = R5;
8d4e93f0:	30 e4 1b 00 	R0 = [SP + 0x6c];
8d4e93f4:	07 0a       	CC = R7 <= R0 (IU);
8d4e93f6:	09 18       	IF CC JUMP 0x0x8d4e9408;
8d4e93f8:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e93fc:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e93fe:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e9400:	01 e8 00 00 	UNLINK;
8d4e9404:	10 00       	RTS;
8d4e9406:	00 00       	NOP;
8d4e9408:	30 e4 16 00 	R0 = [SP + 0x58];
8d4e940c:	ff e3 ec 27 	CALL 0x0x8d4ce3e4;
8d4e9410:	b5 e6 58 00 	B[SP + 0x58] = R5;
8d4e9414:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d4e9416:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e9418:	01 e8 00 00 	UNLINK;
8d4e941c:	10 00       	RTS;
8d4e941e:	00 00       	NOP;
8d4e9420:	30 e4 1d 00 	R0 = [SP + 0x74];
8d4e9424:	ff e3 e0 27 	CALL 0x0x8d4ce3e4;
8d4e9428:	de 2f       	JUMP.S 0x0x8d4e93e4;
8d4e942a:	00 00       	NOP;
8d4e942c:	00 00       	NOP;
8d4e942e:	00 00       	NOP;
8d4e9430:	03 c8 00 18 	MNOP || P1 = [FP + 0xc] || R3 = [FP + 0xc];
8d4e9434:	f9 ac fb a0 
8d4e9438:	80 60       	R0 = 0x10 (X);		/*		R0=0xffffff90(-112) */
8d4e943a:	23 64       	R3 += 0x4;		/* (  4) */
8d4e943c:	22 e1 ea 02 	R2 = 0x2ea (X);		/*		R2=0x2ea(746) */
8d4e9440:	89 a1       	R1 = [P1 + 0x18];
8d4e9442:	0b 32       	P1 = R3;
8d4e9444:	08 0a       	CC = R0 <= R1 (IU);
8d4e9446:	02 10       	IF !CC JUMP 0x0x8d4e944a;
8d4e9448:	0b 91       	R3 = [P1];
8d4e944a:	Address 0x8d4e944c is out of bounds.

