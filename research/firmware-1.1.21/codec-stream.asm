
os.ldr@0x8d57c4fc:     file format binary


Disassembly of section .data:

8d57c4fc <.data>:
8d57c4fc:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d57c500:	04 cc 09 42 	R1 = R1 - R1 (NS) || [SP + 0xc] = P5 || NOP;
8d57c504:	f5 bc 00 00 
8d57c508:	28 32       	P5 = R0;
8d57c50a:	fa 63       	R2 = -0x1 (X);		/*		R2=0x0(  0) */
8d57c50c:	20 e1 00 01 	R0 = 0x100 (X);		/*		R0=0x100(256) */
8d57c510:	6a b0       	[P5 + 0x4] = R2;
8d57c512:	aa b0       	[P5 + 0x8] = R2;
8d57c514:	29 93       	[P5] = R1;
8d57c516:	e9 b0       	[P5 + 0xc] = R1;
8d57c518:	29 b1       	[P5 + 0x10] = R1;
8d57c51a:	69 b1       	[P5 + 0x14] = R1;
8d57c51c:	a9 b1       	[P5 + 0x18] = R1;
8d57c51e:	00 de ed 8f 	CALL.A 0x8fed5158;
8d57c522:	58 51 00 00 
8d57c526:	e8 b0       	[P5 + 0xc] = R0;
8d57c528:	f5 ac       	P5 = [SP + 0xc];
8d57c52a:	01 e8 00 00 	UNLINK;
8d57c52e:	10 00       	RTS;
8d57c530:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d57c534:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = P5 || NOP;
8d57c538:	f5 bc 00 00 
8d57c53c:	28 32       	P5 = R0;
8d57c53e:	fb 63       	R3 = -0x1 (X);		/*		R3=0x0(  0) */
8d57c540:	01 30       	R0 = R1;
8d57c542:	01 da 09 84 	R1=-2079727428;
8d57c546:	bc e0 00 00 
8d57c54a:	6b b0       	[P5 + 0x4] = R3;
8d57c54c:	ab b0       	[P5 + 0x8] = R3;
8d57c54e:	2a b1       	[P5 + 0x10] = R2;
8d57c550:	6a b1       	[P5 + 0x14] = R2;
8d57c552:	aa b1       	[P5 + 0x18] = R2;
8d57c554:	00 de ed 8f 	CALL.A 0x8fed0348;
8d57c558:	48 03 00 00 
8d57c55c:	28 93       	[P5] = R0;
8d57c55e:	f5 ac       	P5 = [SP + 0xc];
8d57c560:	01 e8 00 00 	UNLINK;
8d57c564:	00 0c       	CC = R0 == 0x0;
8d57c566:	10 02       	ILLEGAL;
8d57c568:	10 00       	RTS;
8d57c56a:	00 00       	NOP;
8d57c56c:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d57c570:	f5 bc       	[SP + 0xc] = P5;
8d57c572:	28 32       	P5 = R0;
8d57c574:	28 91       	R0 = [P5];
8d57c576:	00 0c       	CC = R0 == 0x0;
8d57c578:	07 18       	IF CC JUMP 0x0x8d57c586;
8d57c57a:	00 de ed 8f 	CALL.A 0x8fed00ae;
8d57c57e:	ae 00 00 00 
8d57c582:	00 60       	R0 = 0x0 (X);		/*		R0=0x100(256) */
8d57c584:	28 93       	[P5] = R0;
8d57c586:	f5 ac       	P5 = [SP + 0xc];
8d57c588:	01 e8 00 00 	UNLINK;
8d57c58c:	10 00       	RTS;
8d57c58e:	00 00       	NOP;
8d57c590:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d57c594:	f5 bc       	[SP + 0xc] = P5;
8d57c596:	28 32       	P5 = R0;
8d57c598:	ff e3 ea ff 	CALL 0x0x8d57c56c;
8d57c59c:	e8 a0       	R0 = [P5 + 0xc];
8d57c59e:	00 de ed 8f 	CALL.A 0x8fed4aa4;
8d57c5a2:	a4 4a 00 00 
8d57c5a6:	f5 ac       	P5 = [SP + 0xc];
8d57c5a8:	01 e8 00 00 	UNLINK;
8d57c5ac:	10 00       	RTS;
8d57c5ae:	00 00       	NOP;
8d57c5b0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d57c5b4:	fd 05       	[--SP] = (R7:7, P5:5);
8d57c5b6:	28 32       	P5 = R0;
8d57c5b8:	86 6f       	SP += -0x10;		/* (-16) */
8d57c5ba:	22 e1 00 01 	R2 = 0x100 (X);		/*		R2=0x100(256) */
8d57c5be:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d57c5c0:	03 c8 00 18 	MNOP || R1 = [P5 + 0x10] || R0 = [P5 + 0x14];
8d57c5c4:	29 a1 68 a1 
8d57c5c8:	08 0a       	CC = R0 <= R1 (IU);
8d57c5ca:	14 18       	IF CC JUMP 0x0x8d57c5f2;
8d57c5cc:	00 0c       	CC = R0 == 0x0;
8d57c5ce:	0c 18       	IF CC JUMP 0x0x8d57c5e6;
8d57c5d0:	29 ad       	P1 = [P5 + 0x10];
8d57c5d2:	e8 ac       	P0 = [P5 + 0xc];
8d57c5d4:	08 5a       	P0 = P0 + P1;
8d57c5d6:	00 99       	R0 = B[P0] (Z);
8d57c5d8:	09 6c       	P1 += 0x1;		/* (  1) */
8d57c5da:	29 bd       	[P5 + 0x10] = P1;
8d57c5dc:	86 6c       	SP += 0x10;		/* ( 16) */
8d57c5de:	bd 05       	(R7:7, P5:5) = [SP++];
8d57c5e0:	01 e8 00 00 	UNLINK;
8d57c5e4:	10 00       	RTS;
8d57c5e6:	86 6c       	SP += 0x10;		/* ( 16) */
8d57c5e8:	bd 05       	(R7:7, P5:5) = [SP++];
8d57c5ea:	01 e8 00 00 	UNLINK;
8d57c5ee:	f8 63       	R0 = -0x1 (X);		/*		R0=0x100(256) */
8d57c5f0:	10 00       	RTS;
8d57c5f2:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d57c5f4:	03 c8 00 18 	MNOP || R3 = [P5] || R0 = [P5 + 0xc];
8d57c5f8:	2b 91 e8 a0 
8d57c5fc:	2f b1       	[P5 + 0x10] = R7;
8d57c5fe:	f3 b0       	[SP + 0xc] = R3;
8d57c600:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d57c604:	bc 05 00 00 
8d57c608:	68 b1       	[P5 + 0x14] = R0;
8d57c60a:	e1 2f       	JUMP.S 0x0x8d57c5cc;
8d57c60c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d57c610:	e5 05       	[--SP] = (R7:4, P5:5);
8d57c612:	a6 6f       	SP += -0xc;		/* (-12) */
8d57c614:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || [SP + 0x30] = R2 || NOP;
8d57c618:	32 b3 00 00 
8d57c61c:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || [SP + 0x28] = R7 || NOP;
8d57c620:	b7 b2 00 00 
8d57c624:	28 32       	P5 = R0;
8d57c626:	fc 63       	R4 = -0x1 (X);		/*		R4=0x0(  0) */
8d57c628:	02 0c       	CC = R2 == 0x0;
8d57c62a:	37 18       	IF CC JUMP 0x0x8d57c698;
8d57c62c:	03 c8 00 18 	MNOP || P1 = [SP + 0x28] || R0 = [P5 + 0x8];
8d57c630:	b1 ae a8 a0 
8d57c634:	00 0d       	CC = R0 <= 0x0;
8d57c636:	13 18       	IF CC JUMP 0x0x8d57c65c;
8d57c638:	69 a0       	R1 = [P5 + 0x4];
8d57c63a:	39 0c       	CC = R1 == -0x1;
8d57c63c:	0b 18       	IF CC JUMP 0x0x8d57c652;
8d57c63e:	09 9b       	B[P1] = R1;
8d57c640:	03 c8 00 18 	MNOP || R1 = [SP + 0x28] || R0 = [SP + 0x30];
8d57c644:	b1 a2 30 a3 
8d57c648:	f8 67       	R0 += -0x1;		/* ( -1) */
8d57c64a:	30 b3       	[SP + 0x30] = R0;
8d57c64c:	09 64       	R1 += 0x1;		/* (  1) */
8d57c64e:	b1 b2       	[SP + 0x28] = R1;
8d57c650:	a8 a0       	R0 = [P5 + 0x8];
8d57c652:	f8 67       	R0 += -0x1;		/* ( -1) */
8d57c654:	00 0d       	CC = R0 <= 0x0;
8d57c656:	a8 b0       	[P5 + 0x8] = R0;
8d57c658:	1d 10       	IF !CC JUMP 0x0x8d57c692;
8d57c65a:	6c b0       	[P5 + 0x4] = R4;
8d57c65c:	06 30       	R0 = R6;
8d57c65e:	ff e3 a9 ff 	CALL 0x0x8d57c5b0;
8d57c662:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R0 = [P5 + 0x4] || NOP;
8d57c666:	68 a0 00 00 
8d57c66a:	05 08       	CC = R5 == R0;
8d57c66c:	41 18       	IF CC JUMP 0x0x8d57c6ee;
8d57c66e:	03 c8 00 18 	MNOP || P1 = [SP + 0x28] || R0 = [P5 + 0x4];
8d57c672:	b1 ae 68 a0 
8d57c676:	38 0c       	CC = R0 == -0x1;
8d57c678:	0a 18       	IF CC JUMP 0x0x8d57c68c;
8d57c67a:	08 9b       	B[P1] = R0;
8d57c67c:	03 c8 00 18 	MNOP || R0 = [SP + 0x28] || R1 = [SP + 0x30];
8d57c680:	b0 a2 31 a3 
8d57c684:	08 64       	R0 += 0x1;		/* (  1) */
8d57c686:	b0 b2       	[SP + 0x28] = R0;
8d57c688:	f9 67       	R1 += -0x1;		/* ( -1) */
8d57c68a:	31 b3       	[SP + 0x30] = R1;
8d57c68c:	6d b0       	[P5 + 0x4] = R5;
8d57c68e:	3d 0c       	CC = R5 == -0x1;
8d57c690:	04 18       	IF CC JUMP 0x0x8d57c698;
8d57c692:	32 a3       	R2 = [SP + 0x30];
8d57c694:	ca 2f       	JUMP.S 0x0x8d57c628;
8d57c696:	00 00       	NOP;
8d57c698:	04 cc 12 44 	R2 = R2 - R2 (NS) || R1 = [SP + 0x30] || NOP;
8d57c69c:	31 a3 00 00 
8d57c6a0:	01 0c       	CC = R1 == 0x0;
8d57c6a2:	09 32       	P1 = R1;
8d57c6a4:	1e 18       	IF CC JUMP 0x0x8d57c6e0;
8d57c6a6:	09 0c       	CC = R1 == 0x1;
8d57c6a8:	08 60       	R0 = 0x1 (X);		/*		R0=0x100(256) */
8d57c6aa:	03 c8 00 18 	MNOP || P0 = [SP + 0x28] || [P5 + 0x18] = R0;
8d57c6ae:	b0 ae a8 b1 
8d57c6b2:	0e 18       	IF CC JUMP 0x0x8d57c6ce;
8d57c6b4:	09 45       	P1 = P1 >> 0x1;
8d57c6b6:	49 0c       	CC = P1 == 0x1;
8d57c6b8:	08 18       	IF CC JUMP 0x0x8d57c6c8;
8d57c6ba:	0a 45       	P2 = P1 >> 0x1;
8d57c6bc:	a2 e0 02 20 	LSETUP(0x8d57c6c0, 0x8d57c6c0) LC0 = P2;
8d57c6c0:	02 92       	[P0++] = R2;
8d57c6c2:	41 30       	R0 = P1;
8d57c6c4:	00 49       	CC = BITTST (R0, 0x0);		/* bit  0 */
8d57c6c6:	02 10       	IF !CC JUMP 0x0x8d57c6ca;
8d57c6c8:	02 96       	W[P0++] = R2;
8d57c6ca:	01 49       	CC = BITTST (R1, 0x0);		/* bit  0 */
8d57c6cc:	02 10       	IF !CC JUMP 0x0x8d57c6d0;
8d57c6ce:	02 9a       	B[P0++] = R2;
8d57c6d0:	b0 be       	[SP + 0x28] = P0;
8d57c6d2:	b0 a2       	R0 = [SP + 0x28];
8d57c6d4:	66 6c       	SP += 0xc;		/* ( 12) */
8d57c6d6:	38 52       	R0 = R0 - R7;
8d57c6d8:	a5 05       	(R7:4, P5:5) = [SP++];
8d57c6da:	01 e8 00 00 	UNLINK;
8d57c6de:	10 00       	RTS;
8d57c6e0:	b0 a2       	R0 = [SP + 0x28];
8d57c6e2:	66 6c       	SP += 0xc;		/* ( 12) */
8d57c6e4:	38 52       	R0 = R0 - R7;
8d57c6e6:	a5 05       	(R7:4, P5:5) = [SP++];
8d57c6e8:	01 e8 00 00 	UNLINK;
8d57c6ec:	10 00       	RTS;
8d57c6ee:	06 30       	R0 = R6;
8d57c6f0:	ff e3 60 ff 	CALL 0x0x8d57c5b0;
8d57c6f4:	10 64       	R0 += 0x2;		/* (  2) */
8d57c6f6:	a8 b0       	[P5 + 0x8] = R0;
8d57c6f8:	cb 2f       	JUMP.S 0x0x8d57c68e;
8d57c6fa:	00 00       	NOP;
8d57c6fc:	00 00       	NOP;
8d57c6fe:	00 00       	NOP;
8d57c700:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d57c704:	e3 05       	[--SP] = (R7:4, P5:3);
8d57c706:	86 6f       	SP += -0x10;		/* (-16) */
8d57c708:	04 60       	R4 = 0x0 (X);		/*		R4=0x0(  0) */
8d57c70a:	b4 e6 30 00 	B[SP + 0x30] = R4;
8d57c70e:	7f 30       	R7 = FP;
8d57c710:	27 67       	R7 += -0x1c;		/* (-28) */
8d57c712:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d57c716:	b8 00 03 00 
8d57c71a:	7e 60       	R6 = 0xf (X);		/*		R6=0x0(  0) */
8d57c71c:	18 32       	P3 = R0;
8d57c71e:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || [FP -0x8] = R4 || NOP;
8d57c722:	e4 bb 00 00 
8d57c726:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d57c72a:	f3 b0 00 00 
8d57c72e:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x4] = R6 || NOP;
8d57c732:	f6 bb 00 00 
8d57c736:	21 64       	R1 += 0x4;		/* (  4) */
8d57c738:	00 de 03 8c 	CALL.A 0x8c03e970;
8d57c73c:	70 e9 00 00 
8d57c740:	0d da 09 84 	P5=-2079727424;
8d57c744:	c0 e0 00 00 
8d57c748:	0c da 09 84 	P4=-2079727424;
8d57c74c:	c0 e0 00 00 
8d57c750:	03 c8 00 18 	MNOP || P1 = [SP + 0x30] || R0 = B[P5++] (Z);
8d57c754:	31 af 28 98 
8d57c758:	00 0c       	CC = R0 == 0x0;
8d57c75a:	fb 17       	IF !CC JUMP 0x0x8d57c750 (BP);
8d57c75c:	04 cc 00 40 	R0 = R0 - R0 (NS) || R1 = [FP -0x4] || NOP;
8d57c760:	f1 b9 00 00 
8d57c764:	47 32       	P0 = FP;
8d57c766:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d57c768:	0e 0a       	CC = R6 <= R1 (IU);
8d57c76a:	40 6f       	P0 += -0x18;		/* (-24) */
8d57c76c:	c1 07       	IF CC P0 = P1;
8d57c76e:	25 44       	P5 -= P4;
8d57c770:	fd 6f       	P5 += -0x1;		/* ( -1) */
8d57c772:	e9 b9       	P1 = [FP -0x8];
8d57c774:	c4 09       	CC = P4 < P0 (IU);
8d57c776:	04 18       	IF CC JUMP 0x0x8d57c77e;
8d57c778:	48 5a       	P1 = P0 + P1;
8d57c77a:	61 0a       	CC = P1 <= P4 (IU);
8d57c77c:	10 02       	ILLEGAL;
8d57c77e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0041;
8d57c782:	b8 00 41 00 
8d57c786:	00 0c       	CC = R0 == 0x0;
8d57c788:	7c 18       	IF CC JUMP 0x0x8d57c880;
8d57c78a:	e0 b9       	R0 = [FP -0x8];
8d57c78c:	08 32       	P1 = R0;
8d57c78e:	04 44       	P4 -= P0;
8d57c790:	4c 30       	R1 = P4;
8d57c792:	88 09       	CC = R0 < R1 (IU);
8d57c794:	6d 18       	IF CC JUMP 0x0x8d57c86e;
8d57c796:	41 32       	P0 = P1;
8d57c798:	20 44       	P0 -= P4;
8d57c79a:	e8 09       	CC = P0 < P5 (IU);
8d57c79c:	e8 07       	IF CC P5 = P0;
8d57c79e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0040;
8d57c7a2:	b8 00 40 00 
8d57c7a6:	07 30       	R0 = R7;
8d57c7a8:	08 44       	P0 -= P1;
8d57c7aa:	68 0a       	CC = P0 <= P5 (IU);
8d57c7ac:	5c 18       	IF CC JUMP 0x0x8d57c864;
8d57c7ae:	45 0c       	CC = P5 == 0x0;
8d57c7b0:	2c 10       	IF !CC JUMP 0x0x8d57c808;
8d57c7b2:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d57c7b4:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [P3 + 0x14] = R4 || NOP;
8d57c7b8:	5c b1 00 00 
8d57c7bc:	9c e6 04 00 	B[P3 + 0x4] = R4;
8d57c7c0:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [P3 + 0x18] = R3 || NOP;
8d57c7c4:	9b b1 00 00 
8d57c7c8:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d57c7cc:	b8 00 03 00 
8d57c7d0:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d57c7d4:	f3 b0 00 00 
8d57c7d8:	00 de 03 8c 	CALL.A 0x8c03e970;
8d57c7dc:	70 e9 00 00 
8d57c7e0:	f0 b9       	R0 = [FP -0x4];
8d57c7e2:	06 0a       	CC = R6 <= R0 (IU);
8d57c7e4:	08 18       	IF CC JUMP 0x0x8d57c7f4;
8d57c7e6:	b4 e6 30 00 	B[SP + 0x30] = R4;
8d57c7ea:	86 6c       	SP += 0x10;		/* ( 16) */
8d57c7ec:	a3 05       	(R7:4, P5:3) = [SP++];
8d57c7ee:	01 e8 00 00 	UNLINK;
8d57c7f2:	10 00       	RTS;
8d57c7f4:	30 a3       	R0 = [SP + 0x30];
8d57c7f6:	fa e3 f7 8d 	CALL 0x0x8d4ce3e4;
8d57c7fa:	b4 e6 30 00 	B[SP + 0x30] = R4;
8d57c7fe:	86 6c       	SP += 0x10;		/* ( 16) */
8d57c800:	a3 05       	(R7:4, P5:3) = [SP++];
8d57c802:	01 e8 00 00 	UNLINK;
8d57c806:	10 00       	RTS;
8d57c808:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || P0 = [FP -0x8] || NOP;
8d57c80c:	e8 b9 00 00 
8d57c810:	02 60       	R2 = 0x0 (X);		/*		R2=0x100(256) */
8d57c812:	05 5a       	P0 = P5 + P0;
8d57c814:	b8 bc       	[FP + 0x8] = P0;
8d57c816:	b9 ac       	P1 = [FP + 0x8];
8d57c818:	49 30       	R1 = P1;
8d57c81a:	00 de 03 8c 	CALL.A 0x8c03e740;
8d57c81e:	40 e7 00 00 
8d57c822:	00 0c       	CC = R0 == 0x0;
8d57c824:	c7 1b       	IF CC JUMP 0x0x8d57c7b2;
8d57c826:	03 c8 00 18 	MNOP || P0 = [SP + 0x30] || R0 = [FP -0x4];
8d57c82a:	30 af f0 b9 
8d57c82e:	4f 32       	P1 = FP;
8d57c830:	06 0a       	CC = R6 <= R0 (IU);
8d57c832:	41 6f       	P1 += -0x18;		/* (-24) */
8d57c834:	c8 07       	IF CC P1 = P0;
8d57c836:	e8 b9       	P0 = [FP -0x8];
8d57c838:	55 30       	R2 = P5;
8d57c83a:	6f 32       	P5 = FP;
8d57c83c:	45 6f       	P5 += -0x18;		/* (-24) */
8d57c83e:	a1 5a       	P2 = P1 + P4;
8d57c840:	01 5a       	P0 = P1 + P0;
8d57c842:	4a 30       	R1 = P2;
8d57c844:	40 30       	R0 = P0;
8d57c846:	00 de 02 04 	CALL.A 0x040201c4;
8d57c84a:	c4 01 00 00 
8d57c84e:	03 c8 00 18 	MNOP || P1 = [SP + 0x30] || R0 = [FP -0x4];
8d57c852:	31 af f0 b9 
8d57c856:	06 0a       	CC = R6 <= R0 (IU);
8d57c858:	bc ac       	P4 = [FP + 0x8];
8d57c85a:	ec bb       	[FP -0x8] = P4;
8d57c85c:	e9 07       	IF CC P5 = P1;
8d57c85e:	65 5a       	P1 = P5 + P4;
8d57c860:	0c 9b       	B[P1] = R4;
8d57c862:	a8 2f       	JUMP.S 0x0x8d57c7b2;
8d57c864:	00 de ed 8f 	CALL.A 0x8fed519c;
8d57c868:	9c 51 00 00 
8d57c86c:	a1 2f       	JUMP.S 0x0x8d57c7ae;
8d57c86e:	07 30       	R0 = R7;
8d57c870:	00 de ed 8f 	CALL.A 0x8fed51a2;
8d57c874:	a2 51 00 00 
8d57c878:	e9 b9       	P1 = [FP -0x8];
8d57c87a:	8e 2f       	JUMP.S 0x0x8d57c796;
8d57c87c:	00 00       	NOP;
8d57c87e:	00 00       	NOP;
8d57c880:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || P0 = [FP -0x8] || NOP;
8d57c884:	e8 b9 00 00 
8d57c888:	01 44       	P1 -= P0;
8d57c88a:	69 0a       	CC = P1 <= P5 (IU);
8d57c88c:	30 18       	IF CC JUMP 0x0x8d57c8ec;
8d57c88e:	45 0c       	CC = P5 == 0x0;
8d57c890:	91 1f       	IF CC JUMP 0x0x8d57c7b2 (BP);
8d57c892:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || P1 = [FP -0x8] || NOP;
8d57c896:	e9 b9 00 00 
8d57c89a:	02 60       	R2 = 0x0 (X);		/*		R2=0x100(256) */
8d57c89c:	0d 5b       	P4 = P5 + P1;
8d57c89e:	4c 30       	R1 = P4;
8d57c8a0:	00 de 03 8c 	CALL.A 0x8c03e740;
8d57c8a4:	40 e7 00 00 
8d57c8a8:	00 0c       	CC = R0 == 0x0;
8d57c8aa:	84 1b       	IF CC JUMP 0x0x8d57c7b2;
8d57c8ac:	03 c8 00 18 	MNOP || P0 = [SP + 0x30] || R0 = [FP -0x4];
8d57c8b0:	30 af f0 b9 
8d57c8b4:	4f 32       	P1 = FP;
8d57c8b6:	06 0a       	CC = R6 <= R0 (IU);
8d57c8b8:	41 6f       	P1 += -0x18;		/* (-24) */
8d57c8ba:	c8 07       	IF CC P1 = P0;
8d57c8bc:	e8 b9       	P0 = [FP -0x8];
8d57c8be:	55 30       	R2 = P5;
8d57c8c0:	01 da 09 84 	R1=-2079727424;
8d57c8c4:	c0 e0 00 00 
8d57c8c8:	6f 32       	P5 = FP;
8d57c8ca:	41 5a       	P1 = P1 + P0;
8d57c8cc:	41 30       	R0 = P1;
8d57c8ce:	00 de 02 04 	CALL.A 0x040201c4;
8d57c8d2:	c4 01 00 00 
8d57c8d6:	03 c8 00 18 	MNOP || P1 = [SP + 0x30] || R0 = [FP -0x4];
8d57c8da:	31 af f0 b9 
8d57c8de:	06 0a       	CC = R6 <= R0 (IU);
8d57c8e0:	45 6f       	P5 += -0x18;		/* (-24) */
8d57c8e2:	ec bb       	[FP -0x8] = P4;
8d57c8e4:	e9 07       	IF CC P5 = P1;
8d57c8e6:	65 5a       	P1 = P5 + P4;
8d57c8e8:	0c 9b       	B[P1] = R4;
8d57c8ea:	64 2f       	JUMP.S 0x0x8d57c7b2;
8d57c8ec:	00 de ed 8f 	CALL.A 0x8fed519c;
8d57c8f0:	9c 51 00 00 
8d57c8f4:	cd 2f       	JUMP.S 0x0x8d57c88e;
8d57c8f6:	00 00       	NOP;
8d57c8f8:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d57c8fc:	e3 05       	[--SP] = (R7:4, P5:3);
8d57c8fe:	28 30       	R5 = R0;
8d57c900:	1d 32       	P3 = R5;
8d57c902:	01 32       	P0 = R1;
8d57c904:	86 6f       	SP += -0x10;		/* (-16) */
8d57c906:	fa 63       	R2 = -0x1 (X);		/*		R2=0x100(256) */
8d57c908:	21 30       	R4 = R1;
8d57c90a:	1a b2       	[P3 + 0x20] = R2;
8d57c90c:	5a b2       	[P3 + 0x24] = R2;
8d57c90e:	20 64       	R0 += 0x4;		/* (  4) */
8d57c910:	60 32       	P4 = P0;
8d57c912:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R2 = B[P4++] (Z) || NOP;
8d57c916:	22 98 00 00 
8d57c91a:	02 0c       	CC = R2 == 0x0;
8d57c91c:	fb 17       	IF !CC JUMP 0x0x8d57c912 (BP);
8d57c91e:	04 44       	P4 -= P0;
8d57c920:	40 0c       	CC = P0 == 0x0;
8d57c922:	fc 6f       	P4 += -0x1;		/* ( -1) */
8d57c924:	02 60       	R2 = 0x0 (X);		/*		R2=0x100(256) */
8d57c926:	12 18       	IF CC JUMP 0x0x8d57c94a;
8d57c928:	4b 32       	P1 = P3;
8d57c92a:	41 6c       	P1 += 0x8;		/* (  8) */
8d57c92c:	4b a1       	R3 = [P1 + 0x14];
8d57c92e:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d57c930:	1f 0a       	CC = R7 <= R3 (IU);
8d57c932:	51 32       	P2 = P1;
8d57c934:	02 10       	IF !CC JUMP 0x0x8d57c938;
8d57c936:	4a 91       	P2 = [P1];
8d57c938:	d0 09       	CC = P0 < P2 (IU);
8d57c93a:	9a ad       	P2 = [P3 + 0x18];
8d57c93c:	07 18       	IF CC JUMP 0x0x8d57c94a;
8d57c93e:	1f 0a       	CC = R7 <= R3 (IU);
8d57c940:	02 10       	IF !CC JUMP 0x0x8d57c944;
8d57c942:	49 91       	P1 = [P1];
8d57c944:	51 5a       	P1 = P1 + P2;
8d57c946:	41 0a       	CC = P1 <= P0 (IU);
8d57c948:	12 02       	ILLEGAL;
8d57c94a:	02 0c       	CC = R2 == 0x0;
8d57c94c:	47 18       	IF CC JUMP 0x0x8d57c9da;
8d57c94e:	82 ce 05 c4 	R2 = ROT R5 BY 0x0 || R3 = [P3 + 0x1c] || NOP;
8d57c952:	db a1 00 00 
8d57c956:	42 64       	R2 += 0x8;		/* (  8) */
8d57c958:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d57c95a:	0a 32       	P1 = R2;
8d57c95c:	1f 0a       	CC = R7 <= R3 (IU);
8d57c95e:	02 10       	IF !CC JUMP 0x0x8d57c962;
8d57c960:	0a 91       	R2 = [P1];
8d57c962:	04 cc 0a 44 	R2 = R1 - R2 (NS) || [SP + 0xc] = P4 || NOP;
8d57c966:	f4 bc 00 00 
8d57c96a:	08 30       	R1 = R0;
8d57c96c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d57c970:	70 e9 00 00 
8d57c974:	0d 30       	R1 = R5;
8d57c976:	47 30       	R0 = FP;
8d57c978:	20 67       	R0 += -0x1c;		/* (-28) */
8d57c97a:	ff e3 c3 fe 	CALL 0x0x8d57c700;
8d57c97e:	47 30       	R0 = FP;
8d57c980:	40 67       	R0 += -0x18;		/* (-24) */
8d57c982:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d57c984:	01 da 09 84 	R1=-2079727416;
8d57c988:	c8 e0 00 00 
8d57c98c:	03 c8 00 18 	MNOP || R2 = [FP -0x4] || R3 = [SP + 0x30];
8d57c990:	f2 b9 33 a3 
8d57c994:	17 0a       	CC = R7 <= R2 (IU);
8d57c996:	03 07       	IF CC R0 = R3;
8d57c998:	00 de ed 8f 	CALL.A 0x8fed0348;
8d57c99c:	48 03 00 00 
8d57c9a0:	03 c8 00 18 	MNOP || [P3] = R0 || R0 = [FP -0x4];
8d57c9a4:	18 93 f0 b9 
8d57c9a8:	07 0a       	CC = R7 <= R0 (IU);
8d57c9aa:	0b 18       	IF CC JUMP 0x0x8d57c9c0;
8d57c9ac:	b6 e6 30 00 	B[SP + 0x30] = R6;
8d57c9b0:	18 91       	R0 = [P3];
8d57c9b2:	86 6c       	SP += 0x10;		/* ( 16) */
8d57c9b4:	a3 05       	(R7:4, P5:3) = [SP++];
8d57c9b6:	01 e8 00 00 	UNLINK;
8d57c9ba:	00 0c       	CC = R0 == 0x0;
8d57c9bc:	10 02       	ILLEGAL;
8d57c9be:	10 00       	RTS;
8d57c9c0:	30 a3       	R0 = [SP + 0x30];
8d57c9c2:	fa e3 11 8d 	CALL 0x0x8d4ce3e4;
8d57c9c6:	b6 e6 30 00 	B[SP + 0x30] = R6;
8d57c9ca:	18 91       	R0 = [P3];
8d57c9cc:	86 6c       	SP += 0x10;		/* ( 16) */
8d57c9ce:	a3 05       	(R7:4, P5:3) = [SP++];
8d57c9d0:	01 e8 00 00 	UNLINK;
8d57c9d4:	00 0c       	CC = R0 == 0x0;
8d57c9d6:	10 02       	ILLEGAL;
8d57c9d8:	10 00       	RTS;
8d57c9da:	7c 30       	R7 = P4;
8d57c9dc:	0f 30       	R1 = R7;
8d57c9de:	00 de 03 8c 	CALL.A 0x8c03e740;
8d57c9e2:	40 e7 00 00 
8d57c9e6:	00 0c       	CC = R0 == 0x0;
8d57c9e8:	c6 1b       	IF CC JUMP 0x0x8d57c974;
8d57c9ea:	6b 32       	P5 = P3;
8d57c9ec:	82 ce 07 c4 	R2 = ROT R7 BY 0x0 || R0 = [P3 + 0x1c] || NOP;
8d57c9f0:	d8 a1 00 00 
8d57c9f4:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d57c9f6:	45 6c       	P5 += 0x8;		/* (  8) */
8d57c9f8:	01 0a       	CC = R1 <= R0 (IU);
8d57c9fa:	4d 32       	P1 = P5;
8d57c9fc:	02 10       	IF !CC JUMP 0x0x8d57ca00;
8d57c9fe:	69 91       	P1 = [P5];
8d57ca00:	41 30       	R0 = P1;
8d57ca02:	0c 30       	R1 = R4;
8d57ca04:	00 de 02 04 	CALL.A 0x040201c4;
8d57ca08:	c4 01 00 00 
8d57ca0c:	d8 a1       	R0 = [P3 + 0x1c];
8d57ca0e:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d57ca10:	01 0a       	CC = R1 <= R0 (IU);
8d57ca12:	02 10       	IF !CC JUMP 0x0x8d57ca16;
8d57ca14:	6d 91       	P5 = [P5];
8d57ca16:	9c bd       	[P3 + 0x18] = P4;
8d57ca18:	65 5a       	P1 = P5 + P4;
8d57ca1a:	0e 9b       	B[P1] = R6;
8d57ca1c:	ac 2f       	JUMP.S 0x0x8d57c974;
8d57ca1e:	00 00       	NOP;
8d57ca20:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d57ca24:	ec 05       	[--SP] = (R7:5, P5:4);
8d57ca26:	28 32       	P5 = R0;
8d57ca28:	a6 6f       	SP += -0xc;		/* (-12) */
8d57ca2a:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d57ca2c:	fa 63       	R2 = -0x1 (X);		/*		R2=0x100(256) */
8d57ca2e:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d57ca30:	eb b1       	[P5 + 0x1c] = R3;
8d57ca32:	2a b2       	[P5 + 0x20] = R2;
8d57ca34:	6a b2       	[P5 + 0x24] = R2;
8d57ca36:	29 93       	[P5] = R1;
8d57ca38:	a9 b1       	[P5 + 0x18] = R1;
8d57ca3a:	a9 e6 08 00 	B[P5 + 0x8] = R1;
8d57ca3e:	e9 b2       	[P5 + 0x2c] = R1;
8d57ca40:	29 b3       	[P5 + 0x30] = R1;
8d57ca42:	69 b3       	[P5 + 0x34] = R1;
8d57ca44:	20 e1 00 10 	R0 = 0x1000 (X);		/*		R0=0x1000(4096) */
8d57ca48:	fa e3 c6 8c 	CALL 0x0x8d4ce3d4;
8d57ca4c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P2 = [P5 + 0x30] || R0 = [P5 + 0x2c];
8d57ca50:	2a af e8 a2 
8d57ca54:	00 32       	P0 = R0;
8d57ca56:	27 32       	P4 = R7;
8d57ca58:	26 e1 00 10 	R6 = 0x1000 (X);		/*		R6=0x1000(4096) */
8d57ca5c:	4a 30       	R1 = P2;
8d57ca5e:	08 08       	CC = R0 == R1;
8d57ca60:	16 18       	IF CC JUMP 0x0x8d57ca8c;
8d57ca62:	48 32       	P1 = P0;
8d57ca64:	08 6c       	P0 += 0x1;		/* (  1) */
8d57ca66:	42 08       	CC = P2 == P0;
8d57ca68:	02 44       	P2 -= P0;
8d57ca6a:	09 18       	IF CC JUMP 0x0x8d57ca7c;
8d57ca6c:	a2 e0 07 20 	LSETUP(0x8d57ca70, 0x8d57ca7a) LC0 = P2;
8d57ca70:	44 0c       	CC = P4 == 0x0;
8d57ca72:	03 18       	IF CC JUMP 0x0x8d57ca78;
8d57ca74:	08 99       	R0 = B[P1] (Z);
8d57ca76:	20 9b       	B[P4] = R0;
8d57ca78:	09 6c       	P1 += 0x1;		/* (  1) */
8d57ca7a:	0c 6c       	P4 += 0x1;		/* (  1) */
8d57ca7c:	44 0c       	CC = P4 == 0x0;
8d57ca7e:	03 18       	IF CC JUMP 0x0x8d57ca84;
8d57ca80:	08 99       	R0 = B[P1] (Z);
8d57ca82:	20 9b       	B[P4] = R0;
8d57ca84:	03 c8 00 18 	MNOP || R1 = [P5 + 0x30] || R0 = [P5 + 0x2c];
8d57ca88:	29 a3 e8 a2 
8d57ca8c:	00 0c       	CC = R0 == 0x0;
8d57ca8e:	41 53       	R5 = R1 - R0;
8d57ca90:	03 18       	IF CC JUMP 0x0x8d57ca96;
8d57ca92:	fa e3 a9 8c 	CALL 0x0x8d4ce3e4;
8d57ca96:	04 cc 3e 00 	R0 = R7 + R6 (NS) || [P5 + 0x2c] = R7 || NOP;
8d57ca9a:	ef b2 00 00 
8d57ca9e:	04 cc 3d 00 	R0 = R7 + R5 (NS) || [P5 + 0x34] = R0 || NOP;
8d57caa2:	68 b3 00 00 
8d57caa6:	28 b3       	[P5 + 0x30] = R0;
8d57caa8:	66 6c       	SP += 0xc;		/* ( 12) */
8d57caaa:	ac 05       	(R7:5, P5:4) = [SP++];
8d57caac:	01 e8 00 00 	UNLINK;
8d57cab0:	10 00       	RTS;
8d57cab2:	00 00       	NOP;
8d57cab4:	00 00       	NOP;
8d57cab6:	00 00       	NOP;
8d57cab8:	00 e8 06 00 	LINK 0x18;		/* (24) */
8d57cabc:	75 bd       	[SP + 0x14] = P5;
8d57cabe:	28 32       	P5 = R0;
8d57cac0:	03 c8 00 18 	MNOP || R1 = [P5 + 0x30] || R0 = [P5 + 0x2c];
8d57cac4:	29 a3 e8 a2 
8d57cac8:	41 52       	R1 = R1 - R0;
8d57caca:	01 0c       	CC = R1 == 0x0;
8d57cacc:	05 10       	IF !CC JUMP 0x0x8d57cad6;
8d57cace:	75 ad       	P5 = [SP + 0x14];
8d57cad0:	01 e8 00 00 	UNLINK;
8d57cad4:	10 00       	RTS;
8d57cad6:	2a 91       	R2 = [P5];
8d57cad8:	f2 b0       	[SP + 0xc] = R2;
8d57cada:	0a 60       	R2 = 0x1 (X);		/*		R2=0x100(256) */
8d57cadc:	00 de ed 8f 	CALL.A 0x8fed0780;
8d57cae0:	80 07 00 00 
8d57cae4:	08 0c       	CC = R0 == 0x1;
8d57cae6:	0d 10       	IF !CC JUMP 0x0x8d57cb00;
8d57cae8:	03 c8 00 18 	MNOP || R0 = [P5 + 0x2c] || R1 = [P5 + 0x30];
8d57caec:	e8 a2 29 a3 
8d57caf0:	08 08       	CC = R0 == R1;
8d57caf2:	ee 1b       	IF CC JUMP 0x0x8d57cace;
8d57caf4:	28 b3       	[P5 + 0x30] = R0;
8d57caf6:	75 ad       	P5 = [SP + 0x14];
8d57caf8:	01 e8 00 00 	UNLINK;
8d57cafc:	10 00       	RTS;
8d57cafe:	00 00       	NOP;
8d57cb00:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d57cb04:	fc 1e 00 00 
8d57cb08:	80 0c       	CC = R0 < 0x0;
8d57cb0a:	07 10       	IF !CC JUMP 0x0x8d57cb18;
8d57cb0c:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d57cb10:	24 2b 00 00 
8d57cb14:	00 00       	NOP;
8d57cb16:	00 00       	NOP;
8d57cb18:	00 de 0c 8c 	CALL.A 0x8c0c0f68;
8d57cb1c:	68 0f 00 00 
8d57cb20:	08 32       	P1 = R0;
8d57cb22:	08 da 09 84 	P0=-2079727372;
8d57cb26:	f4 e0 00 00 
8d57cb2a:	04 cc 00 40 	R0 = R0 - R0 (NS) || [SP + 0xc] = P0 || NOP;
8d57cb2e:	f0 bc 00 00 
8d57cb32:	22 e1 4b 00 	R2 = 0x4b (X);		/*		R2=0x4b( 75) */
8d57cb36:	01 da 09 84 	R1=-2079727412;
8d57cb3a:	cc e0 00 00 
8d57cb3e:	0b 91       	R3 = [P1];
8d57cb40:	33 b1       	[SP + 0x10] = R3;
8d57cb42:	00 de 04 8c 	CALL.A 0x8c040574;
8d57cb46:	74 05 00 00 
8d57cb4a:	e1 2f       	JUMP.S 0x0x8d57cb0c;
8d57cb4c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d57cb50:	e4 05       	[--SP] = (R7:4, P5:4);
8d57cb52:	28 32       	P5 = R0;
8d57cb54:	a6 6f       	SP += -0xc;		/* (-12) */
8d57cb56:	b1 e6 35 00 	B[SP + 0x35] = R1;
8d57cb5a:	20 30       	R4 = R0;
8d57cb5c:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d57cb5e:	65 32       	P4 = P5;
8d57cb60:	44 6d       	P4 += 0x28;		/* ( 40) */
8d57cb62:	04 cc 00 40 	R0 = R0 - R0 (NS) || R2 = [P4 + 0x4] || R5 = [P4 + 0x8];
8d57cb66:	62 a0 a5 a0 
8d57cb6a:	02 0c       	CC = R2 == 0x0;
8d57cb6c:	04 cc 2a 42 	R1 = R5 - R2 (NS) || P0 = [P4 + 0x8] || NOP;
8d57cb70:	a0 ac 00 00 
8d57cb74:	03 18       	IF CC JUMP 0x0x8d57cb7a;
8d57cb76:	e0 a0       	R0 = [P4 + 0xc];
8d57cb78:	10 52       	R0 = R0 - R2;
8d57cb7a:	81 09       	CC = R1 < R0 (IU);
8d57cb7c:	84 18       	IF CC JUMP 0x0x8d57cc84;
8d57cb7e:	02 0c       	CC = R2 == 0x0;
8d57cb80:	00 60       	R0 = 0x0 (X);		/*		R0=0x1000(4096) */
8d57cb82:	03 18       	IF CC JUMP 0x0x8d57cb88;
8d57cb84:	e0 a0       	R0 = [P4 + 0xc];
8d57cb86:	10 52       	R0 = R0 - R2;
8d57cb88:	fb 63       	R3 = -0x1 (X);		/*		R3=0x0(  0) */
8d57cb8a:	8b 52       	R2 = R3 - R1;
8d57cb8c:	02 0c       	CC = R2 == 0x0;
8d57cb8e:	77 18       	IF CC JUMP 0x0x8d57cc7c;
8d57cb90:	09 64       	R1 += 0x1;		/* (  1) */
8d57cb92:	88 09       	CC = R0 < R1 (IU);
8d57cb94:	3a 18       	IF CC JUMP 0x0x8d57cc08;
8d57cb96:	b3 e4 35 00 	R3 = B[SP + 0x35] (Z);
8d57cb9a:	03 9b       	B[P0] = R3;
8d57cb9c:	a1 a0       	R1 = [P4 + 0x8];
8d57cb9e:	0d 08       	CC = R5 == R1;
8d57cba0:	01 30       	R0 = R1;
8d57cba2:	08 64       	R0 += 0x1;		/* (  1) */
8d57cba4:	a0 b0       	[P4 + 0x8] = R0;
8d57cba6:	1d 18       	IF CC JUMP 0x0x8d57cbe0;
8d57cba8:	0d 64       	R5 += 0x1;		/* (  1) */
8d57cbaa:	29 08       	CC = R1 == R5;
8d57cbac:	a9 52       	R2 = R1 - R5;
8d57cbae:	17 18       	IF CC JUMP 0x0x8d57cbdc;
8d57cbb0:	0a 32       	P1 = R2;
8d57cbb2:	0a 0c       	CC = R2 == 0x1;
8d57cbb4:	13 18       	IF CC JUMP 0x0x8d57cbda;
8d57cbb6:	09 45       	P1 = P1 >> 0x1;
8d57cbb8:	82 c6 43 80 	R0 = R3 << 0x8;
8d57cbbc:	03 56       	R0 = R3 | R0;
8d57cbbe:	49 0c       	CC = P1 == 0x1;
8d57cbc0:	0a 18       	IF CC JUMP 0x0x8d57cbd4;
8d57cbc2:	04 c6 00 00 	R0 = PACK (R0.L, R0.L);
8d57cbc6:	0a 45       	P2 = P1 >> 0x1;
8d57cbc8:	a2 e0 02 20 	LSETUP(0x8d57cbcc, 0x8d57cbcc) LC0 = P2;
8d57cbcc:	00 92       	[P0++] = R0;
8d57cbce:	49 30       	R1 = P1;
8d57cbd0:	01 49       	CC = BITTST (R1, 0x0);		/* bit  0 */
8d57cbd2:	02 10       	IF !CC JUMP 0x0x8d57cbd6;
8d57cbd4:	00 96       	W[P0++] = R0;
8d57cbd6:	02 49       	CC = BITTST (R2, 0x0);		/* bit  0 */
8d57cbd8:	02 10       	IF !CC JUMP 0x0x8d57cbdc;
8d57cbda:	03 9a       	B[P0++] = R3;
8d57cbdc:	03 9b       	B[P0] = R3;
8d57cbde:	28 a3       	R0 = [P5 + 0x30];
8d57cbe0:	e9 a2       	R1 = [P5 + 0x2c];
8d57cbe2:	08 52       	R0 = R0 - R1;
8d57cbe4:	21 e1 00 10 	R1 = 0x1000 (X);		/*		R1=0x1000(4096) */
8d57cbe8:	01 0a       	CC = R1 <= R0 (IU);
8d57cbea:	06 18       	IF CC JUMP 0x0x8d57cbf6;
8d57cbec:	66 6c       	SP += 0xc;		/* ( 12) */
8d57cbee:	a4 05       	(R7:4, P5:4) = [SP++];
8d57cbf0:	01 e8 00 00 	UNLINK;
8d57cbf4:	10 00       	RTS;
8d57cbf6:	04 30       	R0 = R4;
8d57cbf8:	ff e3 60 ff 	CALL 0x0x8d57cab8;
8d57cbfc:	66 6c       	SP += 0xc;		/* ( 12) */
8d57cbfe:	a4 05       	(R7:4, P5:4) = [SP++];
8d57cc00:	01 e8 00 00 	UNLINK;
8d57cc04:	10 00       	RTS;
8d57cc06:	00 00       	NOP;
8d57cc08:	82 c6 f8 85 	R2 = R0 >> 0x1;
8d57cc0c:	d3 52       	R3 = R3 - R2;
8d57cc0e:	83 09       	CC = R3 < R0 (IU);
8d57cc10:	90 51       	R6 = R0 + R2;
8d57cc12:	3e 06       	IF !CC R7 = R6;
8d57cc14:	8f 09       	CC = R7 < R1 (IU);
8d57cc16:	39 07       	IF CC R7 = R1;
8d57cc18:	07 30       	R0 = R7;
8d57cc1a:	fa e3 dd 8b 	CALL 0x0x8d4ce3d4;
8d57cc1e:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R1 = [P4 + 0x4] || NOP;
8d57cc22:	61 a0 00 00 
8d57cc26:	cd 52       	R3 = R5 - R1;
8d57cc28:	f3 b2       	[SP + 0x2c] = R3;
8d57cc2a:	f2 a2       	R2 = [SP + 0x2c];
8d57cc2c:	00 de 02 04 	CALL.A 0x04020218;
8d57cc30:	18 02 00 00 
8d57cc34:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || R3 = [SP + 0x2c] || NOP;
8d57cc38:	f3 a2 00 00 
8d57cc3c:	1e 50       	R0 = R6 + R3;
8d57cc3e:	08 32       	P1 = R0;
8d57cc40:	b2 e4 35 00 	R2 = B[SP + 0x35] (Z);
8d57cc44:	08 64       	R0 += 0x1;		/* (  1) */
8d57cc46:	0a 9b       	B[P1] = R2;
8d57cc48:	a2 a0       	R2 = [P4 + 0x8];
8d57cc4a:	aa 52       	R2 = R2 - R5;
8d57cc4c:	00 de 02 04 	CALL.A 0x04020218;
8d57cc50:	18 02 00 00 
8d57cc54:	03 c8 00 18 	MNOP || R0 = [P4 + 0x4] || R1 = [P4 + 0x8];
8d57cc58:	60 a0 a1 a0 
8d57cc5c:	41 53       	R5 = R1 - R0;
8d57cc5e:	00 0c       	CC = R0 == 0x0;
8d57cc60:	0d 64       	R5 += 0x1;		/* (  1) */
8d57cc62:	03 18       	IF CC JUMP 0x0x8d57cc68;
8d57cc64:	fa e3 c0 8b 	CALL 0x0x8d4ce3e4;
8d57cc68:	04 cc 37 00 	R0 = R6 + R7 (NS) || [P5 + 0x2c] = R6 || NOP;
8d57cc6c:	ee b2 00 00 
8d57cc70:	04 cc 35 00 	R0 = R6 + R5 (NS) || [P5 + 0x34] = R0 || NOP;
8d57cc74:	68 b3 00 00 
8d57cc78:	28 b3       	[P5 + 0x30] = R0;
8d57cc7a:	b3 2f       	JUMP.S 0x0x8d57cbe0;
8d57cc7c:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d57cc80:	24 2b 00 00 
8d57cc84:	05 30       	R0 = R5;
8d57cc86:	08 64       	R0 += 0x1;		/* (  1) */
8d57cc88:	b1 e4 35 00 	R1 = B[SP + 0x35] (Z);
8d57cc8c:	01 9b       	B[P0] = R1;
8d57cc8e:	a0 b0       	[P4 + 0x8] = R0;
8d57cc90:	a8 2f       	JUMP.S 0x0x8d57cbe0;
8d57cc92:	00 00       	NOP;
8d57cc94:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d57cc98:	e4 05       	[--SP] = (R7:4, P5:4);
8d57cc9a:	02 0c       	CC = R2 == 0x0;
8d57cc9c:	20 32       	P4 = R0;
8d57cc9e:	38 30       	R7 = R0;
8d57cca0:	29 32       	P5 = R1;
8d57cca2:	a6 6f       	SP += -0xc;		/* (-12) */
8d57cca4:	12 18       	IF CC JUMP 0x0x8d57ccc8;
8d57cca6:	32 30       	R6 = R2;
8d57cca8:	25 e1 01 01 	R5 = 0x101 (X);		/*		R5=0x101(257) */
8d57ccac:	03 c8 00 18 	MNOP || R1 = [P4 + 0x20] || R4 = B[P5++] (X);
8d57ccb0:	21 a2 6c 98 
8d57ccb4:	0c 08       	CC = R4 == R1;
8d57ccb6:	0e 10       	IF !CC JUMP 0x0x8d57ccd2;
8d57ccb8:	60 a2       	R0 = [P4 + 0x24];
8d57ccba:	a8 08       	CC = R0 < R5;
8d57ccbc:	0b 10       	IF !CC JUMP 0x0x8d57ccd2;
8d57ccbe:	08 64       	R0 += 0x1;		/* (  1) */
8d57ccc0:	60 b2       	[P4 + 0x24] = R0;
8d57ccc2:	fe 67       	R6 += -0x1;		/* ( -1) */
8d57ccc4:	06 0c       	CC = R6 == 0x0;
8d57ccc6:	f3 17       	IF !CC JUMP 0x0x8d57ccac (BP);
8d57ccc8:	66 6c       	SP += 0xc;		/* ( 12) */
8d57ccca:	a4 05       	(R7:4, P5:4) = [SP++];
8d57cccc:	01 e8 00 00 	UNLINK;
8d57ccd0:	10 00       	RTS;
8d57ccd2:	60 a2       	R0 = [P4 + 0x24];
8d57ccd4:	00 0d       	CC = R0 <= 0x0;
8d57ccd6:	04 10       	IF !CC JUMP 0x0x8d57ccde;
8d57ccd8:	24 b2       	[P4 + 0x20] = R4;
8d57ccda:	08 60       	R0 = 0x1 (X);		/*		R0=0x1000(4096) */
8d57ccdc:	f2 2f       	JUMP.S 0x0x8d57ccc0;
8d57ccde:	09 43       	R1 = R1.B (X);
8d57cce0:	07 30       	R0 = R7;
8d57cce2:	ff e3 35 ff 	CALL 0x0x8d57cb4c;
8d57cce6:	60 a2       	R0 = [P4 + 0x24];
8d57cce8:	08 0d       	CC = R0 <= 0x1;
8d57ccea:	f7 1f       	IF CC JUMP 0x0x8d57ccd8 (BP);
8d57ccec:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [P4 + 0x20] || NOP;
8d57ccf0:	21 a2 00 00 
8d57ccf4:	09 43       	R1 = R1.B (X);
8d57ccf6:	ff e3 2b ff 	CALL 0x0x8d57cb4c;
8d57ccfa:	a0 e4 24 00 	R0 = B[P4 + 0x24] (Z);
8d57ccfe:	f0 67       	R0 += -0x2;		/* ( -2) */
8d57cd00:	01 43       	R1 = R0.B (X);
8d57cd02:	07 30       	R0 = R7;
8d57cd04:	ff e3 24 ff 	CALL 0x0x8d57cb4c;
8d57cd08:	e8 2f       	JUMP.S 0x0x8d57ccd8;
8d57cd0a:	00 00       	NOP;
8d57cd0c:	00 00       	NOP;
8d57cd0e:	00 00       	NOP;
8d57cd10:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d57cd14:	e5 05       	[--SP] = (R7:4, P5:5);
8d57cd16:	30 30       	R6 = R0;
8d57cd18:	2e 32       	P5 = R6;
8d57cd1a:	66 6f       	SP += -0x14;		/* (-20) */
8d57cd1c:	38 30       	R7 = R0;
8d57cd1e:	29 91       	R1 = [P5];
8d57cd20:	01 0c       	CC = R1 == 0x0;
8d57cd22:	3b 18       	IF CC JUMP 0x0x8d57cd98;
8d57cd24:	69 a2       	R1 = [P5 + 0x24];
8d57cd26:	01 0d       	CC = R1 <= 0x0;
8d57cd28:	8d 10       	IF !CC JUMP 0x0x8d57ce42;
8d57cd2a:	07 30       	R0 = R7;
8d57cd2c:	ff e3 c6 fe 	CALL 0x0x8d57cab8;
8d57cd30:	28 91       	R0 = [P5];
8d57cd32:	00 de ed 8f 	CALL.A 0x8fed00ae;
8d57cd36:	ae 00 00 00 
8d57cd3a:	20 30       	R4 = R0;
8d57cd3c:	04 0c       	CC = R4 == 0x0;
8d57cd3e:	07 da 09 84 	R7=-2079727412;
8d57cd42:	cc e0 00 00 
8d57cd46:	59 10       	IF !CC JUMP 0x0x8d57cdf8;
8d57cd48:	47 30       	R0 = FP;
8d57cd4a:	20 67       	R0 += -0x1c;		/* (-28) */
8d57cd4c:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [P5] = R4 || NOP;
8d57cd50:	2c 93 00 00 
8d57cd54:	ff e3 d6 fc 	CALL 0x0x8d57c700;
8d57cd58:	ea a1       	R2 = [P5 + 0x1c];
8d57cd5a:	47 30       	R0 = FP;
8d57cd5c:	40 67       	R0 += -0x18;		/* (-24) */
8d57cd5e:	85 60       	R5 = 0x10 (X);		/*		R5=0x101(257) */
8d57cd60:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R6 = [FP -0x4] || R3 = [SP + 0x2c];
8d57cd64:	f6 b9 f3 a2 
8d57cd68:	35 0a       	CC = R5 <= R6 (IU);
8d57cd6a:	03 07       	IF CC R0 = R3;
8d57cd6c:	15 0a       	CC = R5 <= R2 (IU);
8d57cd6e:	41 64       	R1 += 0x8;		/* (  8) */
8d57cd70:	03 10       	IF !CC JUMP 0x0x8d57cd76;
8d57cd72:	09 32       	P1 = R1;
8d57cd74:	09 91       	R1 = [P1];
8d57cd76:	00 de ed 8f 	CALL.A 0x8fed0908;
8d57cd7a:	08 09 00 00 
8d57cd7e:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R0 = [FP -0x4] || NOP;
8d57cd82:	f0 b9 00 00 
8d57cd86:	05 0a       	CC = R5 <= R0 (IU);
8d57cd88:	32 18       	IF CC JUMP 0x0x8d57cdec;
8d57cd8a:	06 0c       	CC = R6 == 0x0;
8d57cd8c:	f4 b3       	[SP + 0x3c] = R4;
8d57cd8e:	b4 e6 2c 00 	B[SP + 0x2c] = R4;
8d57cd92:	78 60       	R0 = 0xf (X);		/*		R0=0x1000(4096) */
8d57cd94:	f0 bb       	[FP -0x4] = R0;
8d57cd96:	09 10       	IF !CC JUMP 0x0x8d57cda8;
8d57cd98:	a6 6c       	SP += 0x14;		/* ( 20) */
8d57cd9a:	a5 05       	(R7:4, P5:5) = [SP++];
8d57cd9c:	01 e8 00 00 	UNLINK;
8d57cda0:	10 00       	RTS;
8d57cda2:	00 00       	NOP;
8d57cda4:	00 00       	NOP;
8d57cda6:	00 00       	NOP;
8d57cda8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d57cdac:	fc 1e 00 00 
8d57cdb0:	80 0c       	CC = R0 < 0x0;
8d57cdb2:	07 10       	IF !CC JUMP 0x0x8d57cdc0;
8d57cdb4:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d57cdb8:	24 2b 00 00 
8d57cdbc:	00 00       	NOP;
8d57cdbe:	00 00       	NOP;
8d57cdc0:	00 de 0c 8c 	CALL.A 0x8c0c0f68;
8d57cdc4:	68 0f 00 00 
8d57cdc8:	08 32       	P1 = R0;
8d57cdca:	08 da 09 84 	P0=-2079727332;
8d57cdce:	1c e1 00 00 
8d57cdd2:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = P0 || NOP;
8d57cdd6:	f0 bc 00 00 
8d57cdda:	12 61       	R2 = 0x22 (X);		/*		R2=0x4b( 75) */
8d57cddc:	00 60       	R0 = 0x0 (X);		/*		R0=0x1000(4096) */
8d57cdde:	0b 91       	R3 = [P1];
8d57cde0:	33 b1       	[SP + 0x10] = R3;
8d57cde2:	00 de 04 8c 	CALL.A 0x8c040574;
8d57cde6:	74 05 00 00 
8d57cdea:	e5 2f       	JUMP.S 0x0x8d57cdb4;
8d57cdec:	f0 a2       	R0 = [SP + 0x2c];
8d57cdee:	fa e3 fb 8a 	CALL 0x0x8d4ce3e4;
8d57cdf2:	cc 2f       	JUMP.S 0x0x8d57cd8a;
8d57cdf4:	00 00       	NOP;
8d57cdf6:	00 00       	NOP;
8d57cdf8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d57cdfc:	fc 1e 00 00 
8d57ce00:	80 0c       	CC = R0 < 0x0;
8d57ce02:	07 10       	IF !CC JUMP 0x0x8d57ce10;
8d57ce04:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d57ce08:	24 2b 00 00 
8d57ce0c:	00 00       	NOP;
8d57ce0e:	00 00       	NOP;
8d57ce10:	00 de 0c 8c 	CALL.A 0x8c0c0f68;
8d57ce14:	68 0f 00 00 
8d57ce18:	08 32       	P1 = R0;
8d57ce1a:	08 da 09 84 	P0=-2079727352;
8d57ce1e:	08 e1 00 00 
8d57ce22:	04 cc 00 40 	R0 = R0 - R0 (NS) || [SP + 0xc] = P0 || NOP;
8d57ce26:	f0 bc 00 00 
8d57ce2a:	fa 60       	R2 = 0x1f (X);		/*		R2=0x4b( 75) */
8d57ce2c:	01 da 09 84 	R1=-2079727412;
8d57ce30:	cc e0 00 00 
8d57ce34:	0b 91       	R3 = [P1];
8d57ce36:	33 b1       	[SP + 0x10] = R3;
8d57ce38:	00 de 04 8c 	CALL.A 0x8c040574;
8d57ce3c:	74 05 00 00 
8d57ce40:	e2 2f       	JUMP.S 0x0x8d57ce04;
8d57ce42:	29 a2       	R1 = [P5 + 0x20];
8d57ce44:	09 43       	R1 = R1.B (X);
8d57ce46:	ff e3 83 fe 	CALL 0x0x8d57cb4c;
8d57ce4a:	68 a2       	R0 = [P5 + 0x24];
8d57ce4c:	08 0d       	CC = R0 <= 0x1;
8d57ce4e:	6e 1f       	IF CC JUMP 0x0x8d57cd2a (BP);
8d57ce50:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [P5 + 0x20] || NOP;
8d57ce54:	29 a2 00 00 
8d57ce58:	09 43       	R1 = R1.B (X);
8d57ce5a:	ff e3 79 fe 	CALL 0x0x8d57cb4c;
8d57ce5e:	a8 e4 24 00 	R0 = B[P5 + 0x24] (Z);
8d57ce62:	f0 67       	R0 += -0x2;		/* ( -2) */
8d57ce64:	01 43       	R1 = R0.B (X);
8d57ce66:	07 30       	R0 = R7;
8d57ce68:	ff e3 72 fe 	CALL 0x0x8d57cb4c;
8d57ce6c:	5f 2f       	JUMP.S 0x0x8d57cd2a;
8d57ce6e:	00 00       	NOP;
8d57ce70:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d57ce74:	fd 05       	[--SP] = (R7:7, P5:5);
8d57ce76:	28 32       	P5 = R0;
8d57ce78:	a6 6f       	SP += -0xc;		/* (-12) */
8d57ce7a:	ff e3 4b ff 	CALL 0x0x8d57cd10;
8d57ce7e:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d57ce80:	e8 a2       	R0 = [P5 + 0x2c];
8d57ce82:	00 0c       	CC = R0 == 0x0;
8d57ce84:	03 18       	IF CC JUMP 0x0x8d57ce8a;
8d57ce86:	fa e3 af 8a 	CALL 0x0x8d4ce3e4;
8d57ce8a:	80 60       	R0 = 0x10 (X);		/*		R0=0x1000(4096) */
8d57ce8c:	e9 a1       	R1 = [P5 + 0x1c];
8d57ce8e:	08 0a       	CC = R0 <= R1 (IU);
8d57ce90:	ef b2       	[P5 + 0x2c] = R7;
8d57ce92:	2f b3       	[P5 + 0x30] = R7;
8d57ce94:	6f b3       	[P5 + 0x34] = R7;
8d57ce96:	0b 18       	IF CC JUMP 0x0x8d57ceac;
8d57ce98:	78 60       	R0 = 0xf (X);		/*		R0=0x1000(4096) */
8d57ce9a:	af b1       	[P5 + 0x18] = R7;
8d57ce9c:	af e6 08 00 	B[P5 + 0x8] = R7;
8d57cea0:	e8 b1       	[P5 + 0x1c] = R0;
8d57cea2:	66 6c       	SP += 0xc;		/* ( 12) */
8d57cea4:	bd 05       	(R7:7, P5:5) = [SP++];
8d57cea6:	01 e8 00 00 	UNLINK;
8d57ceaa:	10 00       	RTS;
8d57ceac:	a8 a0       	R0 = [P5 + 0x8];
8d57ceae:	fa e3 9b 8a 	CALL 0x0x8d4ce3e4;
8d57ceb2:	78 60       	R0 = 0xf (X);		/*		R0=0x1000(4096) */
8d57ceb4:	af b1       	[P5 + 0x18] = R7;
8d57ceb6:	af e6 08 00 	B[P5 + 0x8] = R7;
8d57ceba:	e8 b1       	[P5 + 0x1c] = R0;
8d57cebc:	66 6c       	SP += 0xc;		/* ( 12) */
8d57cebe:	bd 05       	(R7:7, P5:5) = [SP++];
8d57cec0:	01 e8 00 00 	UNLINK;
8d57cec4:	10 00       	RTS;
8d57cec6:	00 00       	NOP;
