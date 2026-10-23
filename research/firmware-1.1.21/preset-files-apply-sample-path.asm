
os.ldr@0x8d4dd3d0:     file format binary


Disassembly of section .data:

8d4dd3d0 <.data>:
8d4dd3d0:	10 00       	RTS;
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
8d4dd42a:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
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
8d4dd45c:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8d4dd45e:	30 e4 3b 00 	R0 = [SP + 0xec];
8d4dd462:	02 0a       	CC = R2 <= R0 (IU);
8d4dd464:	ee 18       	IF CC JUMP 0x0x8d4dd640;
8d4dd466:	b9 a0       	R1 = [FP + 0x8];
8d4dd468:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
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
8d4dd4c8:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
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
8d4dd500:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
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
8d4dd548:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
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
8d4dd66e:	Address 0x8d4dd670 is out of bounds.

