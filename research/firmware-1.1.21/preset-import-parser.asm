
os.ldr@0x8c04e500:     file format binary


Disassembly of section .data:

8c04e500 <.data>:
8c04e500:	02 91       	R2 = [P0];
8c04e502:	0a 64       	R2 += 0x1;		/* (  1) */
8c04e504:	55 99       	R5 = B[P2] (X);
8c04e506:	1d 08       	CC = R5 == R3;
8c04e508:	30 07       	IF CC R6 = R0;
8c04e50a:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [P0] = R2 || NOP;
8c04e50e:	02 93 00 00 
8c04e512:	10 30       	R2 = R0;
8c04e514:	f2 2f       	JUMP.S 0x0x8c04e4f8;
8c04e516:	11 52       	R0 = R1 - R2;
8c04e518:	08 64       	R0 += 0x1;		/* (  1) */
8c04e51a:	28 93       	[P5] = R0;
8c04e51c:	00 91       	R0 = [P0];
8c04e51e:	08 64       	R0 += 0x1;		/* (  1) */
8c04e520:	00 93       	[P0] = R0;
8c04e522:	ad 05       	(R7:5, P5:5) = [SP++];
8c04e524:	01 e8 00 00 	UNLINK;
8c04e528:	10 00       	RTS;
8c04e52a:	11 52       	R0 = R1 - R2;
8c04e52c:	08 64       	R0 += 0x1;		/* (  1) */
8c04e52e:	28 93       	[P5] = R0;
8c04e530:	00 91       	R0 = [P0];
8c04e532:	08 64       	R0 += 0x1;		/* (  1) */
8c04e534:	00 93       	[P0] = R0;
8c04e536:	ad 05       	(R7:5, P5:5) = [SP++];
8c04e538:	01 e8 00 00 	UNLINK;
8c04e53c:	10 00       	RTS;
8c04e53e:	08 32       	P1 = R0;
8c04e540:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04e544:	08 e4 13 00 	R0 = [P1 + 0x4c];
8c04e548:	00 32       	P0 = R0;
8c04e54a:	09 e4 12 00 	R1 = [P1 + 0x48];
8c04e54e:	08 08       	CC = R0 == R1;
8c04e550:	08 18       	IF CC JUMP 0x0x8c04e560;
8c04e552:	40 98       	R0 = B[P0++] (X);
8c04e554:	08 e7 13 00 	[P1 + 0x4c] = P0;
8c04e558:	01 e8 00 00 	UNLINK;
8c04e55c:	10 00       	RTS;
8c04e55e:	00 00       	NOP;
8c04e560:	01 e8 00 00 	UNLINK;
8c04e564:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c04e566:	10 00       	RTS;
8c04e568:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04e56c:	4d 01       	[--SP] = P5;
8c04e56e:	28 32       	P5 = R0;
8c04e570:	0a 32       	P1 = R2;
8c04e572:	28 e4 12 00 	R0 = [P5 + 0x48];
8c04e576:	2b e4 13 00 	R3 = [P5 + 0x4c];
8c04e57a:	18 52       	R0 = R0 - R3;
8c04e57c:	90 08       	CC = R0 < R2;
8c04e57e:	21 18       	IF CC JUMP 0x0x8c04e5c0;
8c04e580:	02 30       	R0 = R2;
8c04e582:	f8 67       	R0 += -0x1;		/* ( -1) */
8c04e584:	41 50       	R1 = R1 + R0;
8c04e586:	03 50       	R0 = R3 + R0;
8c04e588:	11 32       	P2 = R1;
8c04e58a:	00 32       	P0 = R0;
8c04e58c:	a2 e0 07 14 	LSETUPZ(0x8c04e590, 0x8c04e59a) LC0 = P1;
8c04e590:	03 c8 00 18 	MNOP || R0 = B[P0--] (X) || R1 = B[P2--] (X);
8c04e594:	c0 98 d1 98 
8c04e598:	08 08       	CC = R0 == R1;
8c04e59a:	0b 10       	IF !CC JUMP 0x0x8c04e5b0;
8c04e59c:	13 50       	R0 = R3 + R2;
8c04e59e:	28 e6 13 00 	[P5 + 0x4c] = R0;
8c04e5a2:	75 90       	P5 = [SP++];
8c04e5a4:	01 e8 00 00 	UNLINK;
8c04e5a8:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c04e5aa:	10 00       	RTS;
8c04e5ac:	00 00       	NOP;
8c04e5ae:	00 00       	NOP;
8c04e5b0:	04 cc 00 40 	R0 = R0 - R0 (NS) || P5 = [SP++] || NOP;
8c04e5b4:	75 90 00 00 
8c04e5b8:	01 e8 00 00 	UNLINK;
8c04e5bc:	10 00       	RTS;
8c04e5be:	00 00       	NOP;
8c04e5c0:	04 cc 00 40 	R0 = R0 - R0 (NS) || P5 = [SP++] || NOP;
8c04e5c4:	75 90 00 00 
8c04e5c8:	01 e8 00 00 	UNLINK;
8c04e5cc:	10 00       	RTS;
8c04e5ce:	08 32       	P1 = R0;
8c04e5d0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04e5d4:	70 05       	[--SP] = (R7:6);
8c04e5d6:	49 60       	R1 = 0x9 (X);		/*		R1=0x0(  0) */
8c04e5d8:	6a 60       	R2 = 0xd (X);		/*		R2=0x0(  0) */
8c04e5da:	41 32       	P0 = P1;
8c04e5dc:	0f e4 12 00 	R7 = [P1 + 0x48];
8c04e5e0:	0a e5 13 00 	P2 = [P1 + 0x4c];
8c04e5e4:	80 6c       	P0 += 0x10;		/* ( 16) */
8c04e5e6:	53 60       	R3 = 0xa (X);		/*		R3=0x0(  0) */
8c04e5e8:	00 61       	R0 = 0x20 (X);		/*		R0=0x0(  0) */
8c04e5ea:	c0 e0 08 00 	LSETUP_IMM(bottom=0x8c04e5fa) LC0 count_fields=0x0/0x0;
8c04e5ee:	c6 a3       	R6 = [P0 + 0x3c];
8c04e5f0:	3e 08       	CC = R6 == R7;
8c04e5f2:	12 18       	IF CC JUMP 0x0x8c04e616;
8c04e5f4:	56 98       	R6 = B[P2++] (X);
8c04e5f6:	06 08       	CC = R6 == R0;
8c04e5f8:	05 10       	IF !CC JUMP 0x0x8c04e602;
8c04e5fa:	c2 bf       	[P0 + 0x3c] = P2;
8c04e5fc:	0a e5 13 00 	P2 = [P1 + 0x4c];
8c04e600:	f5 2f       	JUMP.S 0x0x8c04e5ea;
8c04e602:	0e 08       	CC = R6 == R1;
8c04e604:	fb 1b       	IF CC JUMP 0x0x8c04e5fa;
8c04e606:	16 08       	CC = R6 == R2;
8c04e608:	f9 1b       	IF CC JUMP 0x0x8c04e5fa;
8c04e60a:	1e 08       	CC = R6 == R3;
8c04e60c:	f7 1f       	IF CC JUMP 0x0x8c04e5fa (BP);
8c04e60e:	30 05       	(R7:6) = [SP++];
8c04e610:	01 e8 00 00 	UNLINK;
8c04e614:	10 00       	RTS;
8c04e616:	30 05       	(R7:6) = [SP++];
8c04e618:	01 e8 00 00 	UNLINK;
8c04e61c:	10 00       	RTS;
8c04e61e:	08 32       	P1 = R0;
8c04e620:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04e624:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c04e626:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8c04e628:	08 9a       	B[P1++] = R0;
8c04e62a:	09 9b       	B[P1] = R1;
8c04e62c:	01 e8 00 00 	UNLINK;
8c04e630:	10 00       	RTS;
8c04e632:	00 00       	NOP;
8c04e634:	00 00       	NOP;
8c04e636:	01 32       	P0 = R1;
8c04e638:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04e63c:	e3 05       	[--SP] = (R7:4, P5:3);
8c04e63e:	18 32       	P3 = R0;
8c04e640:	39 30       	R7 = R1;
8c04e642:	30 30       	R6 = R0;
8c04e644:	86 6f       	SP += -0x10;		/* (-16) */
8c04e646:	60 32       	P4 = P0;
8c04e648:	04 cc 24 48 	R4 = R4 - R4 (NS) || R1 = B[P4++] (Z) || NOP;
8c04e64c:	21 98 00 00 
8c04e650:	01 0c       	CC = R1 == 0x0;
8c04e652:	fb 17       	IF !CC JUMP 0x0x8c04e648 (BP);
8c04e654:	04 44       	P4 -= P0;
8c04e656:	40 0c       	CC = P0 == 0x0;
8c04e658:	fc 6f       	P4 += -0x1;		/* ( -1) */
8c04e65a:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8c04e65c:	12 18       	IF CC JUMP 0x0x8c04e680;
8c04e65e:	4b 32       	P1 = P3;
8c04e660:	21 6c       	P1 += 0x4;		/* (  4) */
8c04e662:	4a a1       	R2 = [P1 + 0x14];
8c04e664:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8c04e666:	13 0a       	CC = R3 <= R2 (IU);
8c04e668:	51 32       	P2 = P1;
8c04e66a:	02 10       	IF !CC JUMP 0x0x8c04e66e;
8c04e66c:	4a 91       	P2 = [P1];
8c04e66e:	d0 09       	CC = P0 < P2 (IU);
8c04e670:	08 18       	IF CC JUMP 0x0x8c04e680;
8c04e672:	13 0a       	CC = R3 <= R2 (IU);
8c04e674:	5a ad       	P2 = [P3 + 0x14];
8c04e676:	02 10       	IF !CC JUMP 0x0x8c04e67a;
8c04e678:	49 91       	P1 = [P1];
8c04e67a:	51 5a       	P1 = P1 + P2;
8c04e67c:	41 0a       	CC = P1 <= P0 (IU);
8c04e67e:	11 02       	ILLEGAL;
8c04e680:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0041;
8c04e684:	b8 00 41 00 
8c04e688:	01 0c       	CC = R1 == 0x0;
8c04e68a:	44 10       	IF !CC JUMP 0x0x8c04e712;
8c04e68c:	58 ad       	P0 = [P3 + 0x14];
8c04e68e:	01 44       	P1 -= P0;
8c04e690:	61 0a       	CC = P1 <= P4 (IU);
8c04e692:	3b 18       	IF CC JUMP 0x0x8c04e708;
8c04e694:	44 0c       	CC = P4 == 0x0;
8c04e696:	06 30       	R0 = R6;
8c04e698:	08 10       	IF !CC JUMP 0x0x8c04e6a8;
8c04e69a:	86 6c       	SP += 0x10;		/* ( 16) */
8c04e69c:	a3 05       	(R7:4, P5:3) = [SP++];
8c04e69e:	01 e8 00 00 	UNLINK;
8c04e6a2:	10 00       	RTS;
8c04e6a4:	00 00       	NOP;
8c04e6a6:	00 00       	NOP;
8c04e6a8:	04 cc 12 44 	R2 = R2 - R2 (NS) || P0 = [P3 + 0x14] || NOP;
8c04e6ac:	58 ad 00 00 
8c04e6b0:	6b 32       	P5 = P3;
8c04e6b2:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
8c04e6b4:	04 5a       	P0 = P4 + P0;
8c04e6b6:	70 bf       	[SP + 0x34] = P0;
8c04e6b8:	71 af       	P1 = [SP + 0x34];
8c04e6ba:	25 6c       	P5 += 0x4;		/* (  4) */
8c04e6bc:	49 30       	R1 = P1;
8c04e6be:	ff e3 41 80 	CALL 0x0x8c03e740;
8c04e6c2:	00 0c       	CC = R0 == 0x0;
8c04e6c4:	06 30       	R0 = R6;
8c04e6c6:	ea 1b       	IF CC JUMP 0x0x8c04e69a;
8c04e6c8:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || P0 = [P3 + 0x14] || R0 = [P3 + 0x18];
8c04e6cc:	58 ad 98 a1 
8c04e6d0:	05 0a       	CC = R5 <= R0 (IU);
8c04e6d2:	4d 32       	P1 = P5;
8c04e6d4:	02 10       	IF !CC JUMP 0x0x8c04e6d8;
8c04e6d6:	69 91       	P1 = [P5];
8c04e6d8:	54 30       	R2 = P4;
8c04e6da:	41 5a       	P1 = P1 + P0;
8c04e6dc:	41 30       	R0 = P1;
8c04e6de:	00 de 02 04 	CALL.A 0x040201c4;
8c04e6e2:	c4 01 00 00 
8c04e6e6:	03 c8 00 18 	MNOP || P0 = [SP + 0x34] || R0 = [P3 + 0x18];
8c04e6ea:	70 af 98 a1 
8c04e6ee:	05 0a       	CC = R5 <= R0 (IU);
8c04e6f0:	02 10       	IF !CC JUMP 0x0x8c04e6f4;
8c04e6f2:	6d 91       	P5 = [P5];
8c04e6f4:	06 30       	R0 = R6;
8c04e6f6:	58 bd       	[P3 + 0x14] = P0;
8c04e6f8:	45 5a       	P1 = P5 + P0;
8c04e6fa:	0c 9b       	B[P1] = R4;
8c04e6fc:	86 6c       	SP += 0x10;		/* ( 16) */
8c04e6fe:	a3 05       	(R7:4, P5:3) = [SP++];
8c04e700:	01 e8 00 00 	UNLINK;
8c04e704:	10 00       	RTS;
8c04e706:	00 00       	NOP;
8c04e708:	00 de ed 8f 	CALL.A 0x8fed519c;
8c04e70c:	9c 51 00 00 
8c04e710:	c2 2f       	JUMP.S 0x0x8c04e694;
8c04e712:	99 a1       	R1 = [P3 + 0x18];
8c04e714:	26 64       	R6 += 0x4;		/* (  4) */
8c04e716:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8c04e718:	0e 32       	P1 = R6;
8c04e71a:	0a 0a       	CC = R2 <= R1 (IU);
8c04e71c:	02 10       	IF !CC JUMP 0x0x8c04e720;
8c04e71e:	0e 91       	R6 = [P1];
8c04e720:	04 cc 3e 44 	R2 = R7 - R6 (NS) || [SP + 0xc] = P4 || NOP;
8c04e724:	f4 bc 00 00 
8c04e728:	08 30       	R1 = R0;
8c04e72a:	ff e3 b7 80 	CALL 0x0x8c03e898;
8c04e72e:	86 6c       	SP += 0x10;		/* ( 16) */
8c04e730:	a3 05       	(R7:4, P5:3) = [SP++];
8c04e732:	01 e8 00 00 	UNLINK;
8c04e736:	10 00       	RTS;
8c04e738:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04e73c:	e5 05       	[--SP] = (R7:4, P5:5);
8c04e73e:	28 32       	P5 = R0;
8c04e740:	01 0c       	CC = R1 == 0x0;
8c04e742:	28 30       	R5 = R0;
8c04e744:	31 30       	R6 = R1;
8c04e746:	3a 30       	R7 = R2;
8c04e748:	86 6f       	SP += -0x10;		/* (-16) */
8c04e74a:	04 60       	R4 = 0x0 (X);		/*		R4=0x0(  0) */
8c04e74c:	17 18       	IF CC JUMP 0x0x8c04e77a;
8c04e74e:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || R3 = [P5 + 0x18] || NOP;
8c04e752:	ab a1 00 00 
8c04e756:	21 64       	R1 += 0x4;		/* (  4) */
8c04e758:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8c04e75a:	09 32       	P1 = R1;
8c04e75c:	1a 0a       	CC = R2 <= R3 (IU);
8c04e75e:	21 30       	R4 = R1;
8c04e760:	02 10       	IF !CC JUMP 0x0x8c04e764;
8c04e762:	0c 91       	R4 = [P1];
8c04e764:	09 32       	P1 = R1;
8c04e766:	a6 09       	CC = R6 < R4 (IU);
8c04e768:	04 60       	R4 = 0x0 (X);		/*		R4=0x0(  0) */
8c04e76a:	08 18       	IF CC JUMP 0x0x8c04e77a;
8c04e76c:	1a 0a       	CC = R2 <= R3 (IU);
8c04e76e:	02 10       	IF !CC JUMP 0x0x8c04e772;
8c04e770:	09 91       	R1 = [P1];
8c04e772:	6a a1       	R2 = [P5 + 0x14];
8c04e774:	51 50       	R1 = R1 + R2;
8c04e776:	31 0a       	CC = R1 <= R6 (IU);
8c04e778:	14 02       	ILLEGAL;
8c04e77a:	04 0c       	CC = R4 == 0x0;
8c04e77c:	1a 18       	IF CC JUMP 0x0x8c04e7b0;
8c04e77e:	a9 a1       	R1 = [P5 + 0x18];
8c04e780:	20 64       	R0 += 0x4;		/* (  4) */
8c04e782:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8c04e784:	08 32       	P1 = R0;
8c04e786:	0a 0a       	CC = R2 <= R1 (IU);
8c04e788:	02 10       	IF !CC JUMP 0x0x8c04e78c;
8c04e78a:	08 91       	R0 = [P1];
8c04e78c:	04 cc 30 44 	R2 = R6 - R0 (NS) || [SP + 0xc] = R7 || NOP;
8c04e790:	f7 b0 00 00 
8c04e794:	0d 30       	R1 = R5;
8c04e796:	05 30       	R0 = R5;
8c04e798:	ff e3 ec 80 	CALL 0x0x8c03e970;
8c04e79c:	86 6c       	SP += 0x10;		/* ( 16) */
8c04e79e:	a5 05       	(R7:4, P5:5) = [SP++];
8c04e7a0:	01 e8 00 00 	UNLINK;
8c04e7a4:	10 00       	RTS;
8c04e7a6:	86 6c       	SP += 0x10;		/* ( 16) */
8c04e7a8:	a5 05       	(R7:4, P5:5) = [SP++];
8c04e7aa:	01 e8 00 00 	UNLINK;
8c04e7ae:	10 00       	RTS;
8c04e7b0:	0f 30       	R1 = R7;
8c04e7b2:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8c04e7b4:	ff e3 c6 7f 	CALL 0x0x8c03e740;
8c04e7b8:	00 0c       	CC = R0 == 0x0;
8c04e7ba:	05 30       	R0 = R5;
8c04e7bc:	f5 1b       	IF CC JUMP 0x0x8c04e7a6;
8c04e7be:	82 ce 05 c8 	R4 = ROT R5 BY 0x0 || R1 = [P5 + 0x18] || NOP;
8c04e7c2:	a9 a1 00 00 
8c04e7c6:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8c04e7c8:	24 64       	R4 += 0x4;		/* (  4) */
8c04e7ca:	0a 0a       	CC = R2 <= R1 (IU);
8c04e7cc:	0c 32       	P1 = R4;
8c04e7ce:	04 30       	R0 = R4;
8c04e7d0:	02 10       	IF !CC JUMP 0x0x8c04e7d4;
8c04e7d2:	08 91       	R0 = [P1];
8c04e7d4:	17 30       	R2 = R7;
8c04e7d6:	0e 30       	R1 = R6;
8c04e7d8:	00 de 02 04 	CALL.A 0x040201c4;
8c04e7dc:	c4 01 00 00 
8c04e7e0:	0c 32       	P1 = R4;
8c04e7e2:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [P5 + 0x18] || NOP;
8c04e7e6:	a8 a1 00 00 
8c04e7ea:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8c04e7ec:	01 0a       	CC = R1 <= R0 (IU);
8c04e7ee:	02 10       	IF !CC JUMP 0x0x8c04e7f2;
8c04e7f0:	0c 91       	R4 = [P1];
8c04e7f2:	04 cc 27 02 	R1 = R4 + R7 (NS) || [P5 + 0x14] = R7 || NOP;
8c04e7f6:	6f b1 00 00 
8c04e7fa:	09 32       	P1 = R1;
8c04e7fc:	05 30       	R0 = R5;
8c04e7fe:	0a 9b       	B[P1] = R2;
8c04e800:	86 6c       	SP += 0x10;		/* ( 16) */
8c04e802:	a5 05       	(R7:4, P5:5) = [SP++];
8c04e804:	01 e8 00 00 	UNLINK;
8c04e808:	10 00       	RTS;
8c04e80a:	08 32       	P1 = R0;
8c04e80c:	00 e8 04 00 	LINK 0x10;		/* (16) */
8c04e810:	04 cc 1b 46 	R3 = R3 - R3 (NS) || [SP + 0xc] = R7 || NOP;
8c04e814:	f7 b0 00 00 
8c04e818:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8c04e81a:	11 08       	CC = R1 == R2;
8c04e81c:	04 cc 11 44 	R2 = R2 - R1 (NS) || [P1 + 0x18] = R7 || NOP;
8c04e820:	8f b1 00 00 
8c04e824:	4b b1       	[P1 + 0x14] = R3;
8c04e826:	8b e6 04 00 	B[P1 + 0x4] = R3;
8c04e82a:	03 18       	IF CC JUMP 0x0x8c04e830;
8c04e82c:	ff e3 86 ff 	CALL 0x0x8c04e738;
8c04e830:	f7 a0       	R7 = [SP + 0xc];
8c04e832:	01 e8 00 00 	UNLINK;
8c04e836:	10 00       	RTS;
8c04e838:	00 e8 04 00 	LINK 0x10;		/* (16) */
8c04e83c:	47 30       	R0 = FP;
8c04e83e:	e0 67       	R0 += -0x4;		/* ( -4) */
8c04e840:	ff e3 ef fe 	CALL 0x0x8c04e61e;
8c04e844:	f0 a0       	R0 = [SP + 0xc];
8c04e846:	f0 b5       	W[SP + 0xe] = R0;
8c04e848:	b0 e4 0e 00 	R0 = B[SP + 0xe] (Z);
8c04e84c:	b1 e4 0f 00 	R1 = B[SP + 0xf] (Z);
8c04e850:	b0 e6 18 00 	B[SP + 0x18] = R0;
8c04e854:	b1 e6 19 00 	B[SP + 0x19] = R1;
8c04e858:	30 ab       	R0 = W[SP + 0x18] (X);
8c04e85a:	01 e8 00 00 	UNLINK;
8c04e85e:	10 00       	RTS;
8c04e860:	00 32       	P0 = R0;
8c04e862:	00 e8 03 00 	LINK 0xc;		/* (12) */
8c04e866:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c04e868:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8c04e86a:	57 32       	P2 = FP;
8c04e86c:	01 e6 10 00 	[P0 + 0x40] = R1;
8c04e870:	01 e6 1c 00 	[P0 + 0x70] = R1;
8c04e874:	40 b0       	[P0 + 0x4] = R0;
8c04e876:	80 b0       	[P0 + 0x8] = R0;
8c04e878:	c0 b0       	[P0 + 0xc] = R0;
8c04e87a:	00 b1       	[P0 + 0x10] = R0;
8c04e87c:	80 b1       	[P0 + 0x18] = R0;
8c04e87e:	c0 b1       	[P0 + 0x1c] = R0;
8c04e880:	00 b2       	[P0 + 0x20] = R0;
8c04e882:	40 b2       	[P0 + 0x24] = R0;
8c04e884:	c0 b3       	[P0 + 0x3c] = R0;
8c04e886:	80 e6 2c 00 	B[P0 + 0x2c] = R0;
8c04e88a:	00 e6 1b 00 	[P0 + 0x6c] = R0;
8c04e88e:	80 e6 5c 00 	B[P0 + 0x5c] = R0;
8c04e892:	ff e3 d3 ff 	CALL 0x0x8c04e838;
8c04e896:	70 b1       	[SP + 0x14] = R0;
8c04e898:	42 6c       	P2 += 0x8;		/* (  8) */
8c04e89a:	90 e4 01 00 	R0 = B[P2 + 0x1] (Z);
8c04e89e:	80 e6 75 00 	B[P0 + 0x75] = R0;
8c04e8a2:	b0 e4 14 00 	R0 = B[SP + 0x14] (Z);
8c04e8a6:	80 e6 74 00 	B[P0 + 0x74] = R0;
8c04e8aa:	01 e8 00 00 	UNLINK;
8c04e8ae:	10 00       	RTS;
8c04e8b0:	10 32       	P2 = R0;
8c04e8b2:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04e8b6:	fd 05       	[--SP] = (R7:7, P5:5);
8c04e8b8:	10 30       	R2 = R0;
8c04e8ba:	a6 6f       	SP += -0xc;		/* (-12) */
8c04e8bc:	7b 61       	R3 = 0x2f (X);		/*		R3=0x0(  0) */
8c04e8be:	57 61       	R7 = 0x2a (X);		/*		R7=0x0(  0) */
8c04e8c0:	6a 32       	P5 = P2;
8c04e8c2:	85 6c       	P5 += 0x10;		/* ( 16) */
8c04e8c4:	c0 e0 0d 00 	LSETUP_IMM(bottom=0x8c04e8de) LC0 count_fields=0x0/0x0;
8c04e8c8:	03 c8 00 18 	MNOP || R0 = [P5 + 0x3c] || R1 = [P5 + 0x38];
8c04e8cc:	e8 a3 a9 a3 
8c04e8d0:	08 08       	CC = R0 == R1;
8c04e8d2:	0c 18       	IF CC JUMP 0x0x8c04e8ea;
8c04e8d4:	02 30       	R0 = R2;
8c04e8d6:	ff e3 34 fe 	CALL 0x0x8c04e53e;
8c04e8da:	38 08       	CC = R0 == R7;
8c04e8dc:	03 18       	IF CC JUMP 0x0x8c04e8e2;
8c04e8de:	00 00       	NOP;
8c04e8e0:	f0 2f       	JUMP.S 0x0x8c04e8c0;
8c04e8e2:	e9 af       	P1 = [P5 + 0x3c];
8c04e8e4:	48 99       	R0 = B[P1] (X);
8c04e8e6:	18 08       	CC = R0 == R3;
8c04e8e8:	fb 17       	IF !CC JUMP 0x0x8c04e8de (BP);
8c04e8ea:	02 30       	R0 = R2;
8c04e8ec:	ff e3 29 fe 	CALL 0x0x8c04e53e;
8c04e8f0:	66 6c       	SP += 0xc;		/* ( 12) */
8c04e8f2:	bd 05       	(R7:7, P5:5) = [SP++];
8c04e8f4:	01 e8 00 00 	UNLINK;
8c04e8f8:	18 08       	CC = R0 == R3;
8c04e8fa:	00 02       	R0 = CC;
8c04e8fc:	10 00       	RTS;
8c04e8fe:	10 32       	P2 = R0;
8c04e900:	00 e8 04 00 	LINK 0x10;		/* (16) */
8c04e904:	82 ce 00 c4 	R2 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8c04e908:	f7 b0 00 00 
8c04e90c:	34 e1 4c 00 	M0 = 0x4c (X);		/*		M0=0x4c( 76) */
8c04e910:	6b 60       	R3 = 0xd (X);		/*		R3=0x0(  0) */
8c04e912:	57 60       	R7 = 0xa (X);		/*		R7=0x0(  0) */
8c04e914:	42 34       	I0 = P2;
8c04e916:	60 9e       	I0 += M0;
8c04e918:	c0 e0 0d 00 	LSETUP_IMM(bottom=0x8c04e932) LC0 count_fields=0x0/0x0;
8c04e91c:	88 32       	P1 = I0;
8c04e91e:	88 90       	R0 = [P1--];
8c04e920:	09 91       	R1 = [P1];
8c04e922:	08 08       	CC = R0 == R1;
8c04e924:	13 18       	IF CC JUMP 0x0x8c04e94a;
8c04e926:	02 30       	R0 = R2;
8c04e928:	ff e3 0b fe 	CALL 0x0x8c04e53e;
8c04e92c:	18 08       	CC = R0 == R3;
8c04e92e:	09 18       	IF CC JUMP 0x0x8c04e940;
8c04e930:	38 08       	CC = R0 == R7;
8c04e932:	02 18       	IF CC JUMP 0x0x8c04e936;
8c04e934:	f0 2f       	JUMP.S 0x0x8c04e914;
8c04e936:	f7 a0       	R7 = [SP + 0xc];
8c04e938:	01 e8 00 00 	UNLINK;
8c04e93c:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c04e93e:	10 00       	RTS;
8c04e940:	f7 a0       	R7 = [SP + 0xc];
8c04e942:	01 e8 00 00 	UNLINK;
8c04e946:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c04e948:	10 00       	RTS;
8c04e94a:	f7 a0       	R7 = [SP + 0xc];
8c04e94c:	01 e8 00 00 	UNLINK;
8c04e950:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c04e952:	10 00       	RTS;
8c04e954:	10 32       	P2 = R0;
8c04e956:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04e95a:	70 05       	[--SP] = (R7:6);
8c04e95c:	18 30       	R3 = R0;
8c04e95e:	a6 6f       	SP += -0xc;		/* (-12) */
8c04e960:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8c04e962:	34 e1 4c 00 	M0 = 0x4c (X);		/*		M0=0x4c( 76) */
8c04e966:	17 61       	R7 = 0x22 (X);		/*		R7=0x0(  0) */
8c04e968:	26 e1 5c 00 	R6 = 0x5c (X);		/*		R6=0x5c( 92) */
8c04e96c:	42 34       	I0 = P2;
8c04e96e:	60 9e       	I0 += M0;
8c04e970:	c0 e0 0f 00 	LSETUP_IMM(bottom=0x8c04e98e) LC0 count_fields=0x0/0x0;
8c04e974:	88 32       	P1 = I0;
8c04e976:	88 90       	R0 = [P1--];
8c04e978:	09 91       	R1 = [P1];
8c04e97a:	08 08       	CC = R0 == R1;
8c04e97c:	15 18       	IF CC JUMP 0x0x8c04e9a6;
8c04e97e:	03 30       	R0 = R3;
8c04e980:	ff e3 df fd 	CALL 0x0x8c04e53e;
8c04e984:	10 30       	R2 = R0;
8c04e986:	32 08       	CC = R2 == R6;
8c04e988:	0b 18       	IF CC JUMP 0x0x8c04e99e;
8c04e98a:	3a 08       	CC = R2 == R7;
8c04e98c:	03 18       	IF CC JUMP 0x0x8c04e992;
8c04e98e:	00 00       	NOP;
8c04e990:	ee 2f       	JUMP.S 0x0x8c04e96c;
8c04e992:	66 6c       	SP += 0xc;		/* ( 12) */
8c04e994:	30 05       	(R7:6) = [SP++];
8c04e996:	01 e8 00 00 	UNLINK;
8c04e99a:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c04e99c:	10 00       	RTS;
8c04e99e:	03 30       	R0 = R3;
8c04e9a0:	ff e3 cf fd 	CALL 0x0x8c04e53e;
8c04e9a4:	f5 2f       	JUMP.S 0x0x8c04e98e;
8c04e9a6:	10 43       	R0 = R2.B (X);
8c04e9a8:	66 6c       	SP += 0xc;		/* ( 12) */
8c04e9aa:	38 08       	CC = R0 == R7;
8c04e9ac:	30 05       	(R7:6) = [SP++];
8c04e9ae:	01 e8 00 00 	UNLINK;
8c04e9b2:	00 02       	R0 = CC;
8c04e9b4:	10 00       	RTS;
8c04e9b6:	08 32       	P1 = R0;
8c04e9b8:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04e9bc:	e5 05       	[--SP] = (R7:4, P5:5);
8c04e9be:	73 61       	R3 = 0x2e (X);		/*		R3=0x0(  0) */
8c04e9c0:	22 e1 65 00 	R2 = 0x65 (X);		/*		R2=0x65(101) */
8c04e9c4:	09 e4 12 00 	R1 = [P1 + 0x48];
8c04e9c8:	41 32       	P0 = P1;
8c04e9ca:	81 6c       	P1 += 0x10;		/* ( 16) */
8c04e9cc:	cf 61       	R7 = 0x39 (X);		/*		R7=0x0(  0) */
8c04e9ce:	86 61       	R6 = 0x30 (X);		/*		R6=0x5c( 92) */
8c04e9d0:	02 e5 13 00 	P2 = [P0 + 0x4c];
8c04e9d4:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8c04e9ea) LC0 count_fields=0x0/0x0;
8c04e9d8:	c8 a3       	R0 = [P1 + 0x3c];
8c04e9da:	08 08       	CC = R0 == R1;
8c04e9dc:	28 32       	P5 = R0;
8c04e9de:	1e 18       	IF CC JUMP 0x0x8c04ea1a;
8c04e9e0:	55 98       	R5 = B[P2++] (X);
8c04e9e2:	2e 09       	CC = R6 <= R5;
8c04e9e4:	05 10       	IF !CC JUMP 0x0x8c04e9ee;
8c04e9e6:	3d 09       	CC = R5 <= R7;
8c04e9e8:	03 10       	IF !CC JUMP 0x0x8c04e9ee;
8c04e9ea:	ca bf       	[P1 + 0x3c] = P2;
8c04e9ec:	f2 2f       	JUMP.S 0x0x8c04e9d0;
8c04e9ee:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c04e9f0:	6c 99       	R4 = B[P5] (X);
8c04e9f2:	1c 08       	CC = R4 == R3;
8c04e9f4:	0d 18       	IF CC JUMP 0x0x8c04ea0e;
8c04e9f6:	14 08       	CC = R4 == R2;
8c04e9f8:	0b 18       	IF CC JUMP 0x0x8c04ea0e;
8c04e9fa:	25 e1 45 00 	R5 = 0x45 (X);		/*		R5=0x45( 69) */
8c04e9fe:	2c 08       	CC = R4 == R5;
8c04ea00:	07 18       	IF CC JUMP 0x0x8c04ea0e;
8c04ea02:	5d 61       	R5 = 0x2b (X);		/*		R5=0x45( 69) */
8c04ea04:	2c 08       	CC = R4 == R5;
8c04ea06:	04 18       	IF CC JUMP 0x0x8c04ea0e;
8c04ea08:	68 61       	R0 = 0x2d (X);		/*		R0=0x0(  0) */
8c04ea0a:	04 08       	CC = R4 == R0;
8c04ea0c:	00 02       	R0 = CC;
8c04ea0e:	00 0c       	CC = R0 == 0x0;
8c04ea10:	ed 17       	IF !CC JUMP 0x0x8c04e9ea (BP);
8c04ea12:	a5 05       	(R7:4, P5:5) = [SP++];
8c04ea14:	01 e8 00 00 	UNLINK;
8c04ea18:	10 00       	RTS;
8c04ea1a:	a5 05       	(R7:4, P5:5) = [SP++];
8c04ea1c:	01 e8 00 00 	UNLINK;
8c04ea20:	10 00       	RTS;
8c04ea22:	08 32       	P1 = R0;
8c04ea24:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04ea28:	1b 60       	R3 = 0x3 (X);		/*		R3=0x0(  0) */
8c04ea2a:	03 c8 00 18 	MNOP || R0 = [P1 + 0xc] || R1 = [P1 + 0x10];
8c04ea2e:	c8 a0 09 a1 
8c04ea32:	04 cc 01 02 	R1 = R0 + R1 (NS) || P2 = [P1 + 0x4] || R2 = [P1 + 0x8];
8c04ea36:	4a ac 8a a0 
8c04ea3a:	f9 67       	R1 += -0x1;		/* ( -1) */
8c04ea3c:	82 c6 f1 81 	R0 = R1 >> 0x2;
8c04ea40:	02 0a       	CC = R2 <= R0 (IU);
8c04ea42:	90 52       	R2 = R0 - R2;
8c04ea44:	02 07       	IF CC R0 = R2;
8c04ea46:	08 32       	P1 = R0;
8c04ea48:	19 54       	R0 = R1 & R3;
8c04ea4a:	00 32       	P0 = R0;
8c04ea4c:	4a 5e       	P1 = P2 + (P1 << 0x2);
8c04ea4e:	49 91       	P1 = [P1];
8c04ea50:	41 5e       	P1 = P1 + (P0 << 0x2);
8c04ea52:	08 91       	R0 = [P1];
8c04ea54:	01 e8 00 00 	UNLINK;
8c04ea58:	10 00       	RTS;
8c04ea5a:	00 00       	NOP;
8c04ea5c:	00 e8 0d 00 	LINK 0x34;		/* (52) */
8c04ea60:	70 05       	[--SP] = (R7:6);
8c04ea62:	5f 30       	R3 = FP;
8c04ea64:	38 30       	R7 = R0;
8c04ea66:	01 30       	R0 = R1;
8c04ea68:	0a 30       	R1 = R2;
8c04ea6a:	66 6f       	SP += -0x14;		/* (-20) */
8c04ea6c:	43 64       	R3 += 0x8;		/* (  8) */
8c04ea6e:	22 60       	R2 = 0x4 (X);		/*		R2=0x65(101) */
8c04ea70:	04 cc 1a 04 	R2 = R3 + R2 (NS) || [SP + 0xc] = R3 || NOP;
8c04ea74:	f3 b0 00 00 
8c04ea78:	ff e3 18 fd 	CALL 0x0x8c04e4a8;
8c04ea7c:	46 30       	R0 = SP;
8c04ea7e:	e1 60       	R1 = 0x1c (X);		/*		R1=0x0(  0) */
8c04ea80:	04 cc 01 0c 	R6 = R0 + R1 (NS) || R1 = [FP + 0x8] || R0 = [FP + 0xc];
8c04ea84:	b9 a0 f8 a0 
8c04ea88:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R0 || NOP;
8c04ea8c:	f0 b0 00 00 
8c04ea90:	31 b1       	[SP + 0x10] = R1;
8c04ea92:	02 da 80 11 	R2=293608780;
8c04ea96:	4c 1d 00 00 
8c04ea9a:	99 61       	R1 = 0x33 (X);		/*		R1=0x0(  0) */
8c04ea9c:	ff e3 86 d7 	CALL 0x0x8c0499a8;
8c04eaa0:	0e 30       	R1 = R6;
8c04eaa2:	07 30       	R0 = R7;
8c04eaa4:	ff e3 ae 81 	CALL 0x0x8c03ee00;
8c04eaa8:	a6 6c       	SP += 0x14;		/* ( 20) */
8c04eaaa:	30 05       	(R7:6) = [SP++];
8c04eaac:	01 e8 00 00 	UNLINK;
8c04eab0:	10 00       	RTS;
8c04eab2:	00 00       	NOP;
8c04eab4:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8c04eab8:	e5 05       	[--SP] = (R7:4, P5:5);
8c04eaba:	28 30       	R5 = R0;
8c04eabc:	2d 32       	P5 = R5;
8c04eabe:	86 6f       	SP += -0x10;		/* (-16) */
8c04eac0:	82 ce 01 cc 	R6 = ROT R1 BY 0x0 || R4 = [FP + 0x14] || NOP;
8c04eac4:	7c a1 00 00 
8c04eac8:	3a 30       	R7 = R2;
8c04eaca:	a8 e4 76 00 	R0 = B[P5 + 0x76] (Z);
8c04eace:	00 0c       	CC = R0 == 0x0;
8c04ead0:	78 18       	IF CC JUMP 0x0x8c04ebc0;
8c04ead2:	0c 0c       	CC = R4 == 0x1;
8c04ead4:	36 10       	IF !CC JUMP 0x0x8c04eb40;
8c04ead6:	28 e4 15 00 	R0 = [P5 + 0x54];
8c04eada:	00 0c       	CC = R0 == 0x0;
8c04eadc:	2a 18       	IF CC JUMP 0x0x8c04eb30;
8c04eade:	17 30       	R2 = R7;
8c04eae0:	0e 30       	R1 = R6;
8c04eae2:	7f 30       	R7 = FP;
8c04eae4:	27 67       	R7 += -0x1c;		/* (-28) */
8c04eae6:	07 30       	R0 = R7;
8c04eae8:	ff e3 91 fe 	CALL 0x0x8c04e80a;
8c04eaec:	28 e4 15 00 	R0 = [P5 + 0x54];
8c04eaf0:	0f 30       	R1 = R7;
8c04eaf2:	0a 60       	R2 = 0x1 (X);		/*		R2=0x65(101) */
8c04eaf4:	00 e3 11 21 	CALL 0x0x8c052d16;
8c04eaf8:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8c04eafa:	f1 a3       	R1 = [SP + 0x3c];
8c04eafc:	08 0a       	CC = R0 <= R1 (IU);
8c04eafe:	09 18       	IF CC JUMP 0x0x8c04eb10;
8c04eb00:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c04eb02:	b0 e6 28 00 	B[SP + 0x28] = R0;
8c04eb06:	86 6c       	SP += 0x10;		/* ( 16) */
8c04eb08:	a5 05       	(R7:4, P5:5) = [SP++];
8c04eb0a:	01 e8 00 00 	UNLINK;
8c04eb0e:	10 00       	RTS;
8c04eb10:	b0 a2       	R0 = [SP + 0x28];
8c04eb12:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04eb16:	e4 e3 00 00 
8c04eb1a:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c04eb1c:	b0 e6 28 00 	B[SP + 0x28] = R0;
8c04eb20:	86 6c       	SP += 0x10;		/* ( 16) */
8c04eb22:	a5 05       	(R7:4, P5:5) = [SP++];
8c04eb24:	01 e8 00 00 	UNLINK;
8c04eb28:	10 00       	RTS;
8c04eb2a:	00 00       	NOP;
8c04eb2c:	00 00       	NOP;
8c04eb2e:	00 00       	NOP;
8c04eb30:	00 da 80 11 	R0=293608876;
8c04eb34:	ac 1d 00 00 
8c04eb38:	ff e3 36 8d 	CALL 0x0x8c0405a4;
8c04eb3c:	d1 2f       	JUMP.S 0x0x8c04eade;
8c04eb3e:	00 00       	NOP;
8c04eb40:	28 e4 1b 00 	R0 = [P5 + 0x6c];
8c04eb44:	00 0c       	CC = R0 == 0x0;
8c04eb46:	31 10       	IF !CC JUMP 0x0x8c04eba8;
8c04eb48:	17 30       	R2 = R7;
8c04eb4a:	0e 30       	R1 = R6;
8c04eb4c:	7f 30       	R7 = FP;
8c04eb4e:	27 67       	R7 += -0x1c;		/* (-28) */
8c04eb50:	07 30       	R0 = R7;
8c04eb52:	ff e3 5c fe 	CALL 0x0x8c04e80a;
8c04eb56:	0f 30       	R1 = R7;
8c04eb58:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8c04eb5c:	b8 00 00 00 
8c04eb60:	22 e1 58 00 	R2 = 0x58 (X);		/*		R2=0x58( 88) */
8c04eb64:	04 cc 2a 00 	R0 = R5 + R2 (NS) || [SP + 0xc] = R0 || NOP;
8c04eb68:	f0 b0 00 00 
8c04eb6c:	02 60       	R2 = 0x0 (X);		/*		R2=0x58( 88) */
8c04eb6e:	ff e3 95 7e 	CALL 0x0x8c03e898;
8c04eb72:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8c04eb74:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R1 = [SP + 0x3c] || NOP;
8c04eb78:	f1 a3 00 00 
8c04eb7c:	08 0a       	CC = R0 <= R1 (IU);
8c04eb7e:	08 18       	IF CC JUMP 0x0x8c04eb8e;
8c04eb80:	b7 e6 28 00 	B[SP + 0x28] = R7;
8c04eb84:	86 6c       	SP += 0x10;		/* ( 16) */
8c04eb86:	a5 05       	(R7:4, P5:5) = [SP++];
8c04eb88:	01 e8 00 00 	UNLINK;
8c04eb8c:	10 00       	RTS;
8c04eb8e:	b0 a2       	R0 = [SP + 0x28];
8c04eb90:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04eb94:	e4 e3 00 00 
8c04eb98:	b7 e6 28 00 	B[SP + 0x28] = R7;
8c04eb9c:	86 6c       	SP += 0x10;		/* ( 16) */
8c04eb9e:	a5 05       	(R7:4, P5:5) = [SP++];
8c04eba0:	01 e8 00 00 	UNLINK;
8c04eba4:	10 00       	RTS;
8c04eba6:	00 00       	NOP;
8c04eba8:	20 e1 58 00 	R0 = 0x58 (X);		/*		R0=0x58( 88) */
8c04ebac:	05 50       	R0 = R5 + R0;
8c04ebae:	01 da 80 11 	R1=293608716;
8c04ebb2:	0c 1d 00 00 
8c04ebb6:	ff e3 40 fd 	CALL 0x0x8c04e636;
8c04ebba:	c7 2f       	JUMP.S 0x0x8c04eb48;
8c04ebbc:	00 00       	NOP;
8c04ebbe:	00 00       	NOP;
8c04ebc0:	00 da 80 11 	R0=293608800;
8c04ebc4:	60 1d 00 00 
8c04ebc8:	ff e3 ee 8c 	CALL 0x0x8c0405a4;
8c04ebcc:	83 2f       	JUMP.S 0x0x8c04ead2;
8c04ebce:	00 00       	NOP;
8c04ebd0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04ebd4:	e5 05       	[--SP] = (R7:4, P5:5);
8c04ebd6:	28 32       	P5 = R0;
8c04ebd8:	86 6f       	SP += -0x10;		/* (-16) */
8c04ebda:	10 30       	R2 = R0;
8c04ebdc:	30 30       	R6 = R0;
8c04ebde:	54 61       	R4 = 0x2a (X);		/*		R4=0x0(  0) */
8c04ebe0:	2f e4 13 00 	R7 = [P5 + 0x4c];
8c04ebe4:	ff e3 ad fc 	CALL 0x0x8c04e53e;
8c04ebe8:	28 30       	R5 = R0;
8c04ebea:	25 08       	CC = R5 == R4;
8c04ebec:	ff 67       	R7 += -0x1;		/* ( -1) */
8c04ebee:	41 18       	IF CC JUMP 0x0x8c04ec70;
8c04ebf0:	78 61       	R0 = 0x2f (X);		/*		R0=0x58( 88) */
8c04ebf2:	05 08       	CC = R5 == R0;
8c04ebf4:	00 60       	R0 = 0x0 (X);		/*		R0=0x58( 88) */
8c04ebf6:	39 18       	IF CC JUMP 0x0x8c04ec68;
8c04ebf8:	40 43       	R0 = R0.B (Z);
8c04ebfa:	00 0c       	CC = R0 == 0x0;
8c04ebfc:	08 10       	IF !CC JUMP 0x0x8c04ec0c;
8c04ebfe:	86 6c       	SP += 0x10;		/* ( 16) */
8c04ec00:	a5 05       	(R7:4, P5:5) = [SP++];
8c04ec02:	01 e8 00 00 	UNLINK;
8c04ec06:	00 60       	R0 = 0x0 (X);		/*		R0=0x58( 88) */
8c04ec08:	10 00       	RTS;
8c04ec0a:	00 00       	NOP;
8c04ec0c:	a8 e4 76 00 	R0 = B[P5 + 0x76] (Z);
8c04ec10:	00 0c       	CC = R0 == 0x0;
8c04ec12:	07 10       	IF !CC JUMP 0x0x8c04ec20;
8c04ec14:	86 6c       	SP += 0x10;		/* ( 16) */
8c04ec16:	a5 05       	(R7:4, P5:5) = [SP++];
8c04ec18:	01 e8 00 00 	UNLINK;
8c04ec1c:	08 60       	R0 = 0x1 (X);		/*		R0=0x58( 88) */
8c04ec1e:	10 00       	RTS;
8c04ec20:	28 e4 14 00 	R0 = [P5 + 0x50];
8c04ec24:	00 0c       	CC = R0 == 0x0;
8c04ec26:	03 60       	R3 = 0x0 (X);		/*		R3=0x0(  0) */
8c04ec28:	09 18       	IF CC JUMP 0x0x8c04ec3a;
8c04ec2a:	0f 30       	R1 = R7;
8c04ec2c:	ff e3 22 fc 	CALL 0x0x8c04e470;
8c04ec30:	00 0c       	CC = R0 == 0x0;
8c04ec32:	04 10       	IF !CC JUMP 0x0x8c04ec3a;
8c04ec34:	25 08       	CC = R5 == R4;
8c04ec36:	0b 60       	R3 = 0x1 (X);		/*		R3=0x0(  0) */
8c04ec38:	10 18       	IF CC JUMP 0x0x8c04ec58;
8c04ec3a:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = R3 || NOP;
8c04ec3e:	f3 b0 00 00 
8c04ec42:	06 30       	R0 = R6;
8c04ec44:	2a e4 13 00 	R2 = [P5 + 0x4c];
8c04ec48:	ff e3 36 ff 	CALL 0x0x8c04eab4;
8c04ec4c:	86 6c       	SP += 0x10;		/* ( 16) */
8c04ec4e:	a5 05       	(R7:4, P5:5) = [SP++];
8c04ec50:	01 e8 00 00 	UNLINK;
8c04ec54:	08 60       	R0 = 0x1 (X);		/*		R0=0x58( 88) */
8c04ec56:	10 00       	RTS;
8c04ec58:	29 e4 13 00 	R1 = [P5 + 0x4c];
8c04ec5c:	07 30       	R0 = R7;
8c04ec5e:	ff e3 09 fc 	CALL 0x0x8c04e470;
8c04ec62:	00 0c       	CC = R0 == 0x0;
8c04ec64:	03 02       	R3 = CC;
8c04ec66:	ea 2f       	JUMP.S 0x0x8c04ec3a;
8c04ec68:	02 30       	R0 = R2;
8c04ec6a:	ff e3 4a fe 	CALL 0x0x8c04e8fe;
8c04ec6e:	c5 2f       	JUMP.S 0x0x8c04ebf8;
8c04ec70:	02 30       	R0 = R2;
8c04ec72:	ff e3 1f fe 	CALL 0x0x8c04e8b0;
8c04ec76:	c1 2f       	JUMP.S 0x0x8c04ebf8;
8c04ec78:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04ec7c:	f4 05       	[--SP] = (R7:6, P5:4);
8c04ec7e:	28 32       	P5 = R0;
8c04ec80:	21 32       	P4 = R1;
8c04ec82:	a6 6f       	SP += -0xc;		/* (-12) */
8c04ec84:	38 30       	R7 = R0;
8c04ec86:	ff e3 a4 fc 	CALL 0x0x8c04e5ce;
8c04ec8a:	28 e4 13 00 	R0 = [P5 + 0x4c];
8c04ec8e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P4 + 0x4] = R0 || NOP;
8c04ec92:	60 b0 00 00 
8c04ec96:	ff e3 54 fc 	CALL 0x0x8c04e53e;
8c04ec9a:	26 e1 66 00 	R6 = 0x66 (X);		/*		R6=0x66(102) */
8c04ec9e:	b0 09       	CC = R0 < R6 (IU);
8c04eca0:	52 18       	IF CC JUMP 0x0x8c04ed44;
8c04eca2:	30 08       	CC = R0 == R6;
8c04eca4:	01 da 80 11 	R1=293608724;
8c04eca8:	14 1d 00 00 
8c04ecac:	42 18       	IF CC JUMP 0x0x8c04ed30;
8c04ecae:	22 e1 74 00 	R2 = 0x74 (X);		/*		R2=0x74(116) */
8c04ecb2:	90 09       	CC = R0 < R2 (IU);
8c04ecb4:	2e 18       	IF CC JUMP 0x0x8c04ed10;
8c04ecb6:	10 08       	CC = R0 == R2;
8c04ecb8:	20 18       	IF CC JUMP 0x0x8c04ecf8;
8c04ecba:	21 e1 7b 00 	R1 = 0x7b (X);		/*		R1=0x7b(123) */
8c04ecbe:	88 09       	CC = R0 < R1 (IU);
8c04ecc0:	02 60       	R2 = 0x0 (X);		/*		R2=0x74(116) */
8c04ecc2:	0a 18       	IF CC JUMP 0x0x8c04ecd6;
8c04ecc4:	08 08       	CC = R0 == R1;
8c04ecc6:	16 18       	IF CC JUMP 0x0x8c04ecf2;
8c04ecc8:	21 e1 7d 00 	R1 = 0x7d (X);		/*		R1=0x7d(125) */
8c04eccc:	08 08       	CC = R0 == R1;
8c04ecce:	04 10       	IF !CC JUMP 0x0x8c04ecd6;
8c04ecd0:	10 60       	R0 = 0x2 (X);		/*		R0=0x58( 88) */
8c04ecd2:	20 93       	[P4] = R0;
8c04ecd4:	0a 60       	R2 = 0x1 (X);		/*		R2=0x74(116) */
8c04ecd6:	50 43       	R0 = R2.B (Z);
8c04ecd8:	00 0c       	CC = R0 == 0x0;
8c04ecda:	03 10       	IF !CC JUMP 0x0x8c04ece0;
8c04ecdc:	68 60       	R0 = 0xd (X);		/*		R0=0x58( 88) */
8c04ecde:	20 93       	[P4] = R0;
8c04ece0:	28 e4 13 00 	R0 = [P5 + 0x4c];
8c04ece4:	a0 b0       	[P4 + 0x8] = R0;
8c04ece6:	66 6c       	SP += 0xc;		/* ( 12) */
8c04ece8:	b4 05       	(R7:6, P5:4) = [SP++];
8c04ecea:	01 e8 00 00 	UNLINK;
8c04ecee:	08 60       	R0 = 0x1 (X);		/*		R0=0x58( 88) */
8c04ecf0:	10 00       	RTS;
8c04ecf2:	0a 60       	R2 = 0x1 (X);		/*		R2=0x74(116) */
8c04ecf4:	22 93       	[P4] = R2;
8c04ecf6:	f0 2f       	JUMP.S 0x0x8c04ecd6;
8c04ecf8:	e1 67       	R1 += -0x4;		/* ( -4) */
8c04ecfa:	38 60       	R0 = 0x7 (X);		/*		R0=0x58( 88) */
8c04ecfc:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P4] = R0 || NOP;
8c04ed00:	20 93 00 00 
8c04ed04:	1a 60       	R2 = 0x3 (X);		/*		R2=0x74(116) */
8c04ed06:	ff e3 31 fc 	CALL 0x0x8c04e568;
8c04ed0a:	10 30       	R2 = R0;
8c04ed0c:	e5 2f       	JUMP.S 0x0x8c04ecd6;
8c04ed0e:	00 00       	NOP;
8c04ed10:	22 e1 6e 00 	R2 = 0x6e (X);		/*		R2=0x6e(110) */
8c04ed14:	10 08       	CC = R0 == R2;
8c04ed16:	02 60       	R2 = 0x0 (X);		/*		R2=0x6e(110) */
8c04ed18:	df 17       	IF !CC JUMP 0x0x8c04ecd6 (BP);
8c04ed1a:	41 64       	R1 += 0x8;		/* (  8) */
8c04ed1c:	48 60       	R0 = 0x9 (X);		/*		R0=0x58( 88) */
8c04ed1e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P4] = R0 || NOP;
8c04ed22:	20 93 00 00 
8c04ed26:	1a 60       	R2 = 0x3 (X);		/*		R2=0x6e(110) */
8c04ed28:	ff e3 20 fc 	CALL 0x0x8c04e568;
8c04ed2c:	10 30       	R2 = R0;
8c04ed2e:	d4 2f       	JUMP.S 0x0x8c04ecd6;
8c04ed30:	40 60       	R0 = 0x8 (X);		/*		R0=0x58( 88) */
8c04ed32:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P4] = R0 || NOP;
8c04ed36:	20 93 00 00 
8c04ed3a:	22 60       	R2 = 0x4 (X);		/*		R2=0x6e(110) */
8c04ed3c:	ff e3 16 fc 	CALL 0x0x8c04e568;
8c04ed40:	10 30       	R2 = R0;
8c04ed42:	ca 2f       	JUMP.S 0x0x8c04ecd6;
8c04ed44:	11 61       	R1 = 0x22 (X);		/*		R1=0x7d(125) */
8c04ed46:	88 09       	CC = R0 < R1 (IU);
8c04ed48:	23 18       	IF CC JUMP 0x0x8c04ed8e;
8c04ed4a:	08 30       	R1 = R0;
8c04ed4c:	f0 66       	R0 += -0x22;		/* (-34) */
8c04ed4e:	ca 60       	R2 = 0x19 (X);		/*		R2=0x6e(110) */
8c04ed50:	08 32       	P1 = R0;
8c04ed52:	90 09       	CC = R0 < R2 (IU);
8c04ed54:	0a 10       	IF !CC JUMP 0x0x8c04ed68;
8c04ed56:	08 da 80 11 	P0=293608952;
8c04ed5a:	f8 1d 00 00 
8c04ed5e:	48 5e       	P1 = P0 + (P1 << 0x2);
8c04ed60:	49 91       	P1 = [P1];
8c04ed62:	0a 60       	R2 = 0x1 (X);		/*		R2=0x6e(110) */
8c04ed64:	51 00       	JUMP (P1);
8c04ed66:	00 00       	NOP;
8c04ed68:	20 e1 5b 00 	R0 = 0x5b (X);		/*		R0=0x5b( 91) */
8c04ed6c:	81 09       	CC = R1 < R0 (IU);
8c04ed6e:	02 60       	R2 = 0x0 (X);		/*		R2=0x6e(110) */
8c04ed70:	b3 1b       	IF CC JUMP 0x0x8c04ecd6;
8c04ed72:	01 08       	CC = R1 == R0;
8c04ed74:	09 18       	IF CC JUMP 0x0x8c04ed86;
8c04ed76:	20 e1 5d 00 	R0 = 0x5d (X);		/*		R0=0x5d( 93) */
8c04ed7a:	01 08       	CC = R1 == R0;
8c04ed7c:	ad 13       	IF !CC JUMP 0x0x8c04ecd6;
8c04ed7e:	20 60       	R0 = 0x4 (X);		/*		R0=0x5d( 93) */
8c04ed80:	20 93       	[P4] = R0;
8c04ed82:	0a 60       	R2 = 0x1 (X);		/*		R2=0x6e(110) */
8c04ed84:	a9 2f       	JUMP.S 0x0x8c04ecd6;
8c04ed86:	18 60       	R0 = 0x3 (X);		/*		R0=0x5d( 93) */
8c04ed88:	20 93       	[P4] = R0;
8c04ed8a:	0a 60       	R2 = 0x1 (X);		/*		R2=0x6e(110) */
8c04ed8c:	a5 2f       	JUMP.S 0x0x8c04ecd6;
8c04ed8e:	00 0c       	CC = R0 == 0x0;
8c04ed90:	02 60       	R2 = 0x0 (X);		/*		R2=0x6e(110) */
8c04ed92:	a2 13       	IF !CC JUMP 0x0x8c04ecd6;
8c04ed94:	22 93       	[P4] = R2;
8c04ed96:	0a 60       	R2 = 0x1 (X);		/*		R2=0x6e(110) */
8c04ed98:	9f 2f       	JUMP.S 0x0x8c04ecd6;
8c04ed9a:	28 60       	R0 = 0x5 (X);		/*		R0=0x5d( 93) */
8c04ed9c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P4] = R0 || NOP;
8c04eda0:	20 93 00 00 
8c04eda4:	ff e3 d8 fd 	CALL 0x0x8c04e954;
8c04eda8:	10 30       	R2 = R0;
8c04edaa:	96 2f       	JUMP.S 0x0x8c04ecd6;
8c04edac:	20 93       	[P4] = R0;
8c04edae:	0a 60       	R2 = 0x1 (X);		/*		R2=0x6e(110) */
8c04edb0:	93 2f       	JUMP.S 0x0x8c04ecd6;
8c04edb2:	30 60       	R0 = 0x6 (X);		/*		R0=0x5d( 93) */
8c04edb4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P4] = R0 || NOP;
8c04edb8:	20 93 00 00 
8c04edbc:	ff e3 fd fd 	CALL 0x0x8c04e9b6;
8c04edc0:	0a 60       	R2 = 0x1 (X);		/*		R2=0x6e(110) */
8c04edc2:	8a 2f       	JUMP.S 0x0x8c04ecd6;
8c04edc4:	60 60       	R0 = 0xc (X);		/*		R0=0x5d( 93) */
8c04edc6:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P4] = R0 || NOP;
8c04edca:	20 93 00 00 
8c04edce:	ff e3 01 ff 	CALL 0x0x8c04ebd0;
8c04edd2:	10 30       	R2 = R0;
8c04edd4:	81 2f       	JUMP.S 0x0x8c04ecd6;
8c04edd6:	58 60       	R0 = 0xb (X);		/*		R0=0x5d( 93) */
8c04edd8:	20 93       	[P4] = R0;
8c04edda:	7e 2f       	JUMP.S 0x0x8c04ecd6;
8c04eddc:	08 32       	P1 = R0;
8c04edde:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04ede2:	ed 05       	[--SP] = (R7:5, P5:5);
8c04ede4:	a6 6f       	SP += -0xc;		/* (-12) */
8c04ede6:	30 30       	R6 = R0;
8c04ede8:	8a e4 74 00 	R2 = B[P1 + 0x74] (Z);
8c04edec:	02 0c       	CC = R2 == 0x0;
8c04edee:	29 32       	P5 = R1;
8c04edf0:	39 30       	R7 = R1;
8c04edf2:	0f 18       	IF CC JUMP 0x0x8c04ee10;
8c04edf4:	65 60       	R5 = 0xc (X);		/*		R5=0x45( 69) */
8c04edf6:	0f 30       	R1 = R7;
8c04edf8:	06 30       	R0 = R6;
8c04edfa:	ff e3 3f ff 	CALL 0x0x8c04ec78;
8c04edfe:	28 91       	R0 = [P5];
8c04ee00:	28 08       	CC = R0 == R5;
8c04ee02:	fa 1f       	IF CC JUMP 0x0x8c04edf6 (BP);
8c04ee04:	66 6c       	SP += 0xc;		/* ( 12) */
8c04ee06:	ad 05       	(R7:5, P5:5) = [SP++];
8c04ee08:	01 e8 00 00 	UNLINK;
8c04ee0c:	10 00       	RTS;
8c04ee0e:	00 00       	NOP;
8c04ee10:	ff e3 34 ff 	CALL 0x0x8c04ec78;
8c04ee14:	66 6c       	SP += 0xc;		/* ( 12) */
8c04ee16:	ad 05       	(R7:5, P5:5) = [SP++];
8c04ee18:	01 e8 00 00 	UNLINK;
8c04ee1c:	10 00       	RTS;
8c04ee1e:	00 00       	NOP;
8c04ee20:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04ee24:	ec 05       	[--SP] = (R7:5, P5:4);
8c04ee26:	29 32       	P5 = R1;
8c04ee28:	20 32       	P4 = R0;
8c04ee2a:	63 60       	R3 = 0xc (X);		/*		R3=0x0(  0) */
8c04ee2c:	86 6f       	SP += -0x10;		/* (-16) */
8c04ee2e:	18 50       	R0 = R0 + R3;
8c04ee30:	04 cc 0b 02 	R1 = R1 + R3 (NS) || R7 = [P5] || R5 = [P5 + 0x4];
8c04ee34:	2f 91 6d a0 
8c04ee38:	04 cc 12 44 	R2 = R2 - R2 (NS) || R3 = [P5 + 0x8] || [P4] = R7;
8c04ee3c:	ab a0 27 93 
8c04ee40:	7e 60       	R6 = 0xf (X);		/*		R6=0x66(102) */
8c04ee42:	65 b0       	[P4 + 0x4] = R5;
8c04ee44:	22 b2       	[P4 + 0x20] = R2;
8c04ee46:	a2 e6 10 00 	B[P4 + 0x10] = R2;
8c04ee4a:	a3 b0       	[P4 + 0x8] = R3;
8c04ee4c:	66 b2       	[P4 + 0x24] = R6;
8c04ee4e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c04ee52:	b8 00 03 00 
8c04ee56:	f3 b0       	[SP + 0xc] = R3;
8c04ee58:	ff e3 8c 7d 	CALL 0x0x8c03e970;
8c04ee5c:	a8 a2       	R0 = [P5 + 0x28];
8c04ee5e:	a0 b2       	[P4 + 0x28] = R0;
8c04ee60:	86 6c       	SP += 0x10;		/* ( 16) */
8c04ee62:	ac 05       	(R7:5, P5:4) = [SP++];
8c04ee64:	01 e8 00 00 	UNLINK;
8c04ee68:	10 00       	RTS;
8c04ee6a:	00 00       	NOP;
8c04ee6c:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8c04ee70:	ed 05       	[--SP] = (R7:5, P5:5);
8c04ee72:	7f 30       	R7 = FP;
8c04ee74:	27 67       	R7 += -0x1c;		/* (-28) */
8c04ee76:	28 32       	P5 = R0;
8c04ee78:	30 30       	R6 = R0;
8c04ee7a:	86 6f       	SP += -0x10;		/* (-16) */
8c04ee7c:	07 30       	R0 = R7;
8c04ee7e:	2a 30       	R5 = R2;
8c04ee80:	ff e3 c0 7f 	CALL 0x0x8c03ee00;
8c04ee84:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8c04ee88:	b8 00 01 00 
8c04ee8c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R1 || NOP;
8c04ee90:	f1 b0 00 00 
8c04ee94:	0d 30       	R1 = R5;
8c04ee96:	02 60       	R2 = 0x0 (X);		/*		R2=0x6e(110) */
8c04ee98:	ff e3 00 7d 	CALL 0x0x8c03e898;
8c04ee9c:	08 30       	R1 = R0;
8c04ee9e:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8c04eea0:	78 60       	R0 = 0xf (X);		/*		R0=0x5d( 93) */
8c04eea2:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [P5 + 0x18] = R0 || NOP;
8c04eea6:	a8 b1 00 00 
8c04eeaa:	6f b1       	[P5 + 0x14] = R7;
8c04eeac:	af e6 04 00 	B[P5 + 0x4] = R7;
8c04eeb0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8c04eeb4:	b8 00 02 00 
8c04eeb8:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R2 || NOP;
8c04eebc:	f2 b0 00 00 
8c04eec0:	ff e3 58 7d 	CALL 0x0x8c03e970;
8c04eec4:	80 60       	R0 = 0x10 (X);		/*		R0=0x5d( 93) */
8c04eec6:	b1 a3       	R1 = [SP + 0x38];
8c04eec8:	08 0a       	CC = R0 <= R1 (IU);
8c04eeca:	08 18       	IF CC JUMP 0x0x8c04eeda;
8c04eecc:	b7 e6 24 00 	B[SP + 0x24] = R7;
8c04eed0:	86 6c       	SP += 0x10;		/* ( 16) */
8c04eed2:	ad 05       	(R7:5, P5:5) = [SP++];
8c04eed4:	01 e8 00 00 	UNLINK;
8c04eed8:	10 00       	RTS;
8c04eeda:	70 a2       	R0 = [SP + 0x24];
8c04eedc:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04eee0:	e4 e3 00 00 
8c04eee4:	b7 e6 24 00 	B[SP + 0x24] = R7;
8c04eee8:	86 6c       	SP += 0x10;		/* ( 16) */
8c04eeea:	ad 05       	(R7:5, P5:5) = [SP++];
8c04eeec:	01 e8 00 00 	UNLINK;
8c04eef0:	10 00       	RTS;
8c04eef2:	00 00       	NOP;
8c04eef4:	00 e8 39 00 	LINK 0xe4;		/* (228) */
8c04eef8:	08 32       	P1 = R0;
8c04eefa:	e3 05       	[--SP] = (R7:4, P5:3);
8c04eefc:	29 32       	P5 = R1;
8c04eefe:	86 6f       	SP += -0x10;		/* (-16) */
8c04ef00:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [FP + 0x10] = R1 || NOP;
8c04ef04:	39 b1 00 00 
8c04ef08:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8c04ef0a:	8d e6 04 00 	B[P1 + 0x4] = R5;
8c04ef0e:	4d b1       	[P1 + 0x14] = R5;
8c04ef10:	8f b1       	[P1 + 0x18] = R7;
8c04ef12:	02 da 80 11 	R2=293608716;
8c04ef16:	0c 1d 00 00 
8c04ef1a:	03 c8 00 18 	MNOP || P1 = [P5 + 0x20] || [FP + 0xc] = R0;
8c04ef1e:	29 ae f8 b0 
8c04ef22:	22 65       	R2 += 0x24;		/* ( 36) */
8c04ef24:	c2 bb       	[FP -0x10] = R2;
8c04ef26:	03 da 80 11 	R3=293608716;
8c04ef2a:	0c 1d 00 00 
8c04ef2e:	01 da 80 11 	R1=293608716;
8c04ef32:	0c 1d 00 00 
8c04ef36:	02 da 80 11 	R2=293608716;
8c04ef3a:	0c 1d 00 00 
8c04ef3e:	a3 64       	R3 += 0x14;		/* ( 20) */
8c04ef40:	c1 64       	R1 += 0x18;		/* ( 24) */
8c04ef42:	e2 64       	R2 += 0x1c;		/* ( 28) */
8c04ef44:	e3 bb       	[FP -0x8] = R3;
8c04ef46:	f1 bb       	[FP -0x4] = R1;
8c04ef48:	d2 bb       	[FP -0xc] = R2;
8c04ef4a:	61 32       	P4 = P1;
8c04ef4c:	86 60       	R6 = 0x10 (X);		/*		R6=0x66(102) */
8c04ef4e:	03 c8 00 18 	MNOP || P2 = [P5 + 0x24] || R1 = [FP + 0x10];
8c04ef52:	6a ae 39 a1 
8c04ef56:	44 32       	P0 = P4;
8c04ef58:	0c 6c       	P4 += 0x1;		/* (  1) */
8c04ef5a:	50 30       	R2 = P0;
8c04ef5c:	51 5a       	P1 = P1 + P2;
8c04ef5e:	48 08       	CC = P0 == P1;
8c04ef60:	0b 19       	IF CC JUMP 0x0x8c04f176;
8c04ef62:	03 c8 00 18 	MNOP || P3 = [P5 + 0x18] || R3 = [P5 + 0x1c];
8c04ef66:	ab ad eb a1 
8c04ef6a:	13 32       	P2 = R3;
8c04ef6c:	48 32       	P1 = P0;
8c04ef6e:	13 0a       	CC = R3 <= R2 (IU);
8c04ef70:	46 30       	R0 = SP;
8c04ef72:	11 44       	P1 -= P2;
8c04ef74:	c1 07       	IF CC P0 = P1;
8c04ef76:	24 e1 80 00 	R4 = 0x80 (X);		/*		R4=0x80(128) */
8c04ef7a:	04 cc 04 08 	R4 = R0 + R4 (NS) || [FP + 0x8] = FP || NOP;
8c04ef7e:	bf bc 00 00 
8c04ef82:	04 30       	R0 = R4;
8c04ef84:	43 5e       	P1 = P3 + (P0 << 0x2);
8c04ef86:	4b 91       	P3 = [P1];
8c04ef88:	5a a0       	R2 = [P3 + 0x4];
8c04ef8a:	ff e3 69 fd 	CALL 0x0x8c04ea5c;
8c04ef8e:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R1 = [FP -0x8] || NOP;
8c04ef92:	e1 b9 00 00 
8c04ef96:	14 30       	R2 = R4;
8c04ef98:	20 67       	R0 += -0x1c;		/* (-28) */
8c04ef9a:	ff e3 69 ff 	CALL 0x0x8c04ee6c;
8c04ef9e:	ba a0       	R2 = [FP + 0x8];
8c04efa0:	23 e1 54 ff 	R3 = -0xac (X);		/*		R3=0xffffff54(-172) */
8c04efa4:	5a 50       	R1 = R2 + R3;
8c04efa6:	01 30       	R0 = R1;
8c04efa8:	20 67       	R0 += -0x1c;		/* (-28) */
8c04efaa:	02 da 80 11 	R2=293608716;
8c04efae:	0c 1d 00 00 
8c04efb2:	ff e3 f1 80 	CALL 0x0x8c03f194;
8c04efb6:	04 cc 12 44 	R2 = R2 - R2 (NS) || R3 = [FP + 0x8] || R0 = [FP + 0xc];
8c04efba:	bb a0 f8 a0 
8c04efbe:	21 e1 38 ff 	R1 = -0xc8 (X);		/*		R1=0xffffff38(-200) */
8c04efc2:	04 cc 19 02 	R1 = R3 + R1 (NS) || [FP + 0x8] = P3 || NOP;
8c04efc6:	bb bc 00 00 
8c04efca:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c04efce:	b8 00 03 00 
8c04efd2:	f3 b0       	[SP + 0xc] = R3;
8c04efd4:	ff e3 62 7c 	CALL 0x0x8c03e898;
8c04efd8:	30 e4 18 00 	R0 = [SP + 0x60];
8c04efdc:	06 0a       	CC = R6 <= R0 (IU);
8c04efde:	c5 18       	IF CC JUMP 0x0x8c04f168;
8c04efe0:	37 e6 18 00 	[SP + 0x60] = R7;
8c04efe4:	35 e6 17 00 	[SP + 0x5c] = R5;
8c04efe8:	b5 e6 4c 00 	B[SP + 0x4c] = R5;
8c04efec:	30 e4 1f 00 	R0 = [SP + 0x7c];
8c04eff0:	06 0a       	CC = R6 <= R0 (IU);
8c04eff2:	b3 18       	IF CC JUMP 0x0x8c04f158;
8c04eff4:	37 e6 1f 00 	[SP + 0x7c] = R7;
8c04eff8:	35 e6 1e 00 	[SP + 0x78] = R5;
8c04effc:	b5 e6 68 00 	B[SP + 0x68] = R5;
8c04f000:	20 b8       	R0 = [FP -0x78];
8c04f002:	06 0a       	CC = R6 <= R0 (IU);
8c04f004:	a2 18       	IF CC JUMP 0x0x8c04f148;
8c04f006:	03 c8 00 18 	MNOP || R2 = [FP + 0x8] || [FP -0x78] = R7;
8c04f00a:	ba a0 27 ba 
8c04f00e:	5e 30       	R3 = SP;
8c04f010:	20 e1 64 00 	R0 = 0x64 (X);		/*		R0=0x64(100) */
8c04f014:	b5 e6 84 00 	B[SP + 0x84] = R5;
8c04f018:	04 cc 18 00 	R0 = R3 + R0 (NS) || [FP -0x7c] = R5 || R1 = [FP -0x4];
8c04f01c:	15 ba f1 b9 
8c04f020:	62 64       	R2 += 0xc;		/* ( 12) */
8c04f022:	ff e3 25 ff 	CALL 0x0x8c04ee6c;
8c04f026:	5e 30       	R3 = SP;
8c04f028:	20 e1 64 00 	R0 = 0x64 (X);		/*		R0=0x64(100) */
8c04f02c:	43 50       	R1 = R3 + R0;
8c04f02e:	01 30       	R0 = R1;
8c04f030:	e0 64       	R0 += 0x1c;		/* ( 28) */
8c04f032:	02 da 80 11 	R2=293608716;
8c04f036:	0c 1d 00 00 
8c04f03a:	ff e3 ad 80 	CALL 0x0x8c03f194;
8c04f03e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c04f042:	b8 00 03 00 
8c04f046:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0xc] = R3 || R0 = [FP + 0xc];
8c04f04a:	f3 b0 f8 a0 
8c04f04e:	02 60       	R2 = 0x0 (X);		/*		R2=0x6e(110) */
8c04f050:	ff e3 24 7c 	CALL 0x0x8c03e898;
8c04f054:	20 b8       	R0 = [FP -0x78];
8c04f056:	06 0a       	CC = R6 <= R0 (IU);
8c04f058:	70 18       	IF CC JUMP 0x0x8c04f138;
8c04f05a:	27 ba       	[FP -0x78] = R7;
8c04f05c:	15 ba       	[FP -0x7c] = R5;
8c04f05e:	b5 e6 84 00 	B[SP + 0x84] = R5;
8c04f062:	30 e4 1f 00 	R0 = [SP + 0x7c];
8c04f066:	06 0a       	CC = R6 <= R0 (IU);
8c04f068:	60 18       	IF CC JUMP 0x0x8c04f128;
8c04f06a:	37 e6 1f 00 	[SP + 0x7c] = R7;
8c04f06e:	35 e6 1e 00 	[SP + 0x78] = R5;
8c04f072:	b5 e6 68 00 	B[SP + 0x68] = R5;
8c04f076:	03 c8 00 18 	MNOP || R2 = [P3 + 0x28] || R1 = [FP + 0x10];
8c04f07a:	9a a2 39 a1 
8c04f07e:	02 0c       	CC = R2 == 0x0;
8c04f080:	40 18       	IF CC JUMP 0x0x8c04f100;
8c04f082:	67 30       	R4 = FP;
8c04f084:	24 66       	R4 += -0x3c;		/* (-60) */
8c04f086:	04 30       	R0 = R4;
8c04f088:	ff e3 ea fc 	CALL 0x0x8c04ea5c;
8c04f08c:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || R1 = [FP -0xc] || NOP;
8c04f090:	d1 b9 00 00 
8c04f094:	24 67       	R4 += -0x1c;		/* (-28) */
8c04f096:	04 30       	R0 = R4;
8c04f098:	ff e3 ea fe 	CALL 0x0x8c04ee6c;
8c04f09c:	46 30       	R0 = SP;
8c04f09e:	23 e1 b8 00 	R3 = 0xb8 (X);		/*		R3=0xb8(184) */
8c04f0a2:	04 cc 03 02 	R1 = R0 + R3 (NS) || R2 = [FP -0x10] || NOP;
8c04f0a6:	c2 b9 00 00 
8c04f0aa:	01 30       	R0 = R1;
8c04f0ac:	20 67       	R0 += -0x1c;		/* (-28) */
8c04f0ae:	ff e3 73 80 	CALL 0x0x8c03f194;
8c04f0b2:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0004;
8c04f0b6:	b8 00 04 00 
8c04f0ba:	5e 30       	R3 = SP;
8c04f0bc:	21 e1 9c 00 	R1 = 0x9c (X);		/*		R1=0x9c(156) */
8c04f0c0:	04 cc 19 02 	R1 = R3 + R1 (NS) || [SP + 0xc] = R4 || R0 = [FP + 0xc];
8c04f0c4:	f4 b0 f8 a0 
8c04f0c8:	02 60       	R2 = 0x0 (X);		/*		R2=0x6e(110) */
8c04f0ca:	ff e3 e7 7b 	CALL 0x0x8c03e898;
8c04f0ce:	90 b8       	R0 = [FP -0x5c];
8c04f0d0:	06 0a       	CC = R6 <= R0 (IU);
8c04f0d2:	25 18       	IF CC JUMP 0x0x8c04f11c;
8c04f0d4:	85 ba       	[FP -0x60] = R5;
8c04f0d6:	b5 e6 a0 00 	B[SP + 0xa0] = R5;
8c04f0da:	03 c8 00 18 	MNOP || R0 = [FP -0x40] || [FP -0x5c] = R7;
8c04f0de:	00 b9 97 ba 
8c04f0e2:	06 0a       	CC = R6 <= R0 (IU);
8c04f0e4:	16 18       	IF CC JUMP 0x0x8c04f110;
8c04f0e6:	f5 ba       	[FP -0x44] = R5;
8c04f0e8:	b5 e6 bc 00 	B[SP + 0xbc] = R5;
8c04f0ec:	03 c8 00 18 	MNOP || R0 = [FP -0x24] || [FP -0x40] = R7;
8c04f0f0:	70 b9 07 bb 
8c04f0f4:	06 0a       	CC = R6 <= R0 (IU);
8c04f0f6:	07 18       	IF CC JUMP 0x0x8c04f104;
8c04f0f8:	77 bb       	[FP -0x24] = R7;
8c04f0fa:	65 bb       	[FP -0x28] = R5;
8c04f0fc:	b5 e6 d8 00 	B[SP + 0xd8] = R5;
8c04f100:	29 ae       	P1 = [P5 + 0x20];
8c04f102:	26 2f       	JUMP.S 0x0x8c04ef4e;
8c04f104:	20 b9       	R0 = [FP -0x38];
8c04f106:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f10a:	e4 e3 00 00 
8c04f10e:	f5 2f       	JUMP.S 0x0x8c04f0f8;
8c04f110:	b0 b8       	R0 = [FP -0x54];
8c04f112:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f116:	e4 e3 00 00 
8c04f11a:	e6 2f       	JUMP.S 0x0x8c04f0e6;
8c04f11c:	40 b8       	R0 = [FP -0x70];
8c04f11e:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f122:	e4 e3 00 00 
8c04f126:	d7 2f       	JUMP.S 0x0x8c04f0d4;
8c04f128:	30 e4 1a 00 	R0 = [SP + 0x68];
8c04f12c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f130:	e4 e3 00 00 
8c04f134:	9b 2f       	JUMP.S 0x0x8c04f06a;
8c04f136:	00 00       	NOP;
8c04f138:	30 e4 21 00 	R0 = [SP + 0x84];
8c04f13c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f140:	e4 e3 00 00 
8c04f144:	8b 2f       	JUMP.S 0x0x8c04f05a;
8c04f146:	00 00       	NOP;
8c04f148:	30 e4 21 00 	R0 = [SP + 0x84];
8c04f14c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f150:	e4 e3 00 00 
8c04f154:	59 2f       	JUMP.S 0x0x8c04f006;
8c04f156:	00 00       	NOP;
8c04f158:	30 e4 1a 00 	R0 = [SP + 0x68];
8c04f15c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f160:	e4 e3 00 00 
8c04f164:	48 2f       	JUMP.S 0x0x8c04eff4;
8c04f166:	00 00       	NOP;
8c04f168:	30 e4 13 00 	R0 = [SP + 0x4c];
8c04f16c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f170:	e4 e3 00 00 
8c04f174:	36 2f       	JUMP.S 0x0x8c04efe0;
8c04f176:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f178:	a3 05       	(R7:4, P5:3) = [SP++];
8c04f17a:	01 e8 00 00 	UNLINK;
8c04f17e:	10 00       	RTS;
8c04f180:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04f184:	c4 04       	[--SP] = (P5:4);
8c04f186:	28 32       	P5 = R0;
8c04f188:	a6 6f       	SP += -0xc;		/* (-12) */
8c04f18a:	28 a1       	R0 = [P5 + 0x10];
8c04f18c:	00 0c       	CC = R0 == 0x0;
8c04f18e:	08 32       	P1 = R0;
8c04f190:	1f 18       	IF CC JUMP 0x0x8c04f1ce;
8c04f192:	03 c8 00 18 	MNOP || P0 = [P5 + 0xc] || R0 = [P5 + 0x8];
8c04f196:	e8 ac a8 a0 
8c04f19a:	01 5a       	P0 = P1 + P0;
8c04f19c:	08 32       	P1 = R0;
8c04f19e:	f8 6f       	P0 += -0x1;		/* ( -1) */
8c04f1a0:	48 30       	R1 = P0;
8c04f1a2:	08 0a       	CC = R0 <= R1 (IU);
8c04f1a4:	02 10       	IF !CC JUMP 0x0x8c04f1a8;
8c04f1a6:	08 44       	P0 -= P1;
8c04f1a8:	69 ac       	P1 = [P5 + 0x4];
8c04f1aa:	80 60       	R0 = 0x10 (X);		/*		R0=0x64(100) */
8c04f1ac:	41 5e       	P1 = P1 + (P0 << 0x2);
8c04f1ae:	4c 91       	P4 = [P1];
8c04f1b0:	61 a2       	R1 = [P4 + 0x24];
8c04f1b2:	08 0a       	CC = R0 <= R1 (IU);
8c04f1b4:	12 18       	IF CC JUMP 0x0x8c04f1d8;
8c04f1b6:	01 60       	R1 = 0x0 (X);		/*		R1=0x9c(156) */
8c04f1b8:	21 b2       	[P4 + 0x20] = R1;
8c04f1ba:	a1 e6 10 00 	B[P4 + 0x10] = R1;
8c04f1be:	78 60       	R0 = 0xf (X);		/*		R0=0x64(100) */
8c04f1c0:	60 b2       	[P4 + 0x24] = R0;
8c04f1c2:	28 a1       	R0 = [P5 + 0x10];
8c04f1c4:	f8 67       	R0 += -0x1;		/* ( -1) */
8c04f1c6:	00 0c       	CC = R0 == 0x0;
8c04f1c8:	28 b1       	[P5 + 0x10] = R0;
8c04f1ca:	02 10       	IF !CC JUMP 0x0x8c04f1ce;
8c04f1cc:	e9 b0       	[P5 + 0xc] = R1;
8c04f1ce:	66 6c       	SP += 0xc;		/* ( 12) */
8c04f1d0:	84 04       	(P5:4) = [SP++];
8c04f1d2:	01 e8 00 00 	UNLINK;
8c04f1d6:	10 00       	RTS;
8c04f1d8:	20 a1       	R0 = [P4 + 0x10];
8c04f1da:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f1de:	e4 e3 00 00 
8c04f1e2:	ea 2f       	JUMP.S 0x0x8c04f1b6;
8c04f1e4:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04f1e8:	e3 05       	[--SP] = (R7:4, P5:3);
8c04f1ea:	28 32       	P5 = R0;
8c04f1ec:	a6 6f       	SP += -0xc;		/* (-12) */
8c04f1ee:	21 30       	R4 = R1;
8c04f1f0:	03 da ff 0f 	R3=268435455;
8c04f1f4:	ff ff 00 00 
8c04f1f8:	46 60       	R6 = 0x8 (X);		/*		R6=0x66(102) */
8c04f1fa:	03 c8 00 18 	MNOP || R1 = [P5 + 0xc] || R0 = [P5 + 0x10];
8c04f1fe:	e9 a0 28 a1 
8c04f202:	81 50       	R2 = R1 + R0;
8c04f204:	f2 4f       	R2 <<= 0x1e;
8c04f206:	00 03       	CC = AZ;
8c04f208:	08 32       	P1 = R0;
8c04f20a:	01 32       	P0 = R1;
8c04f20c:	65 10       	IF !CC JUMP 0x0x8c04f2d6;
8c04f20e:	20 64       	R0 += 0x4;		/* (  4) */
8c04f210:	82 ce f0 85 	R2 = R0 >> 0x2 || R0 = [P5 + 0x8] || NOP;
8c04f214:	a8 a0 00 00 
8c04f218:	10 0a       	CC = R0 <= R2 (IU);
8c04f21a:	5e 10       	IF !CC JUMP 0x0x8c04f2d6;
8c04f21c:	83 52       	R2 = R3 - R0;
8c04f21e:	02 0c       	CC = R2 == 0x0;
8c04f220:	a6 18       	IF CC JUMP 0x0x8c04f36c;
8c04f222:	82 c6 f8 85 	R2 = R0 >> 0x1;
8c04f226:	b2 09       	CC = R2 < R6 (IU);
8c04f228:	16 07       	IF CC R2 = R6;
8c04f22a:	d3 52       	R3 = R3 - R2;
8c04f22c:	18 0a       	CC = R0 <= R3 (IU);
8c04f22e:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8c04f230:	3a 07       	IF CC R7 = R2;
8c04f232:	82 c6 f1 8b 	R5 = R1 >> 0x2;
8c04f236:	78 41       	R0 = (R0 + R7) << 0x2;
8c04f238:	25 32       	P4 = R5;
8c04f23a:	00 de 4c 8d 	CALL.A 0x8d4ce3d4;
8c04f23e:	d4 e3 00 00 
8c04f242:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || P3 = [P5 + 0x4] || NOP;
8c04f246:	6b ac 00 00 
8c04f24a:	a8 ac       	P0 = [P5 + 0x8];
8c04f24c:	08 32       	P1 = R0;
8c04f24e:	e2 63       	R2 = -0x4 (X);		/*		R2=0x6e(110) */
8c04f250:	a3 5e       	P2 = P3 + (P4 << 0x2);
8c04f252:	03 5e       	P0 = P3 + (P0 << 0x2);
8c04f254:	10 44       	P0 -= P2;
8c04f256:	48 30       	R1 = P0;
8c04f258:	e1 5e       	P3 = P1 + (P4 << 0x2);
8c04f25a:	91 54       	R2 = R1 & R2;
8c04f25c:	32 b3       	[SP + 0x30] = R2;
8c04f25e:	43 30       	R0 = P3;
8c04f260:	4a 30       	R1 = P2;
8c04f262:	00 de 02 04 	CALL.A 0x04020218;
8c04f266:	18 02 00 00 
8c04f26a:	82 ce 17 86 	R3 = R7 << 0x2 || P0 = [SP + 0x30] || R1 = [P5 + 0x4];
8c04f26e:	30 af 69 a0 
8c04f272:	3d 0a       	CC = R5 <= R7 (IU);
8c04f274:	06 34       	I0 = R6;
8c04f276:	e2 63       	R2 = -0x4 (X);		/*		R2=0x6e(110) */
8c04f278:	c3 5a       	P3 = P3 + P0;
8c04f27a:	43 30       	R0 = P3;
8c04f27c:	58 10       	IF !CC JUMP 0x0x8c04f32c;
8c04f27e:	f2 60       	R2 = 0x1e (X);		/*		R2=0x6e(110) */
8c04f280:	0a c6 15 44 	R2 = EXTRACT (R5, R2.L) (X);
8c04f284:	12 4f       	R2 <<= 0x2;
8c04f286:	32 b3       	[SP + 0x30] = R2;
8c04f288:	00 de 02 04 	CALL.A 0x04020218;
8c04f28c:	18 02 00 00 
8c04f290:	04 cc 3d 46 	R3 = R7 - R5 (NS) || P1 = [SP + 0x30] || NOP;
8c04f294:	31 af 00 00 
8c04f298:	03 0c       	CC = R3 == 0x0;
8c04f29a:	07 30       	R0 = R7;
8c04f29c:	0b 5a       	P0 = P3 + P1;
8c04f29e:	0a 18       	IF CC JUMP 0x0x8c04f2b2;
8c04f2a0:	f8 67       	R0 += -0x1;		/* ( -1) */
8c04f2a2:	28 52       	R0 = R0 - R5;
8c04f2a4:	08 32       	P1 = R0;
8c04f2a6:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8c04f2a8:	a2 e0 02 14 	LSETUPZ(0x8c04f2ac, 0x8c04f2ac) LC0 = P1;
8c04f2ac:	00 92       	[P0++] = R0;
8c04f2ae:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8c04f2b0:	00 93       	[P0] = R0;
8c04f2b2:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8c04f2b4:	a2 e0 02 44 	LSETUPZ(0x8c04f2b8, 0x8c04f2b8) LC0 = P4;
8c04f2b8:	00 9e       	[I0++] = R0;
8c04f2ba:	68 a0       	R0 = [P5 + 0x4];
8c04f2bc:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f2c0:	e4 e3 00 00 
8c04f2c4:	03 c8 00 18 	MNOP || P0 = [P5 + 0xc] || R0 = [P5 + 0x8];
8c04f2c8:	e8 ac a8 a0 
8c04f2cc:	04 cc 38 00 	R0 = R7 + R0 (NS) || P1 = [P5 + 0x10] || [P5 + 0x4] = R6;
8c04f2d0:	29 ad 6e b0 
8c04f2d4:	a8 b0       	[P5 + 0x8] = R0;
8c04f2d6:	48 5a       	P1 = P0 + P1;
8c04f2d8:	cc 44       	P4 = P1 >> 0x2;
8c04f2da:	79 30       	R7 = P1;
8c04f2dc:	a8 a0       	R0 = [P5 + 0x8];
8c04f2de:	4c 30       	R1 = P4;
8c04f2e0:	08 32       	P1 = R0;
8c04f2e2:	08 0a       	CC = R0 <= R1 (IU);
8c04f2e4:	02 10       	IF !CC JUMP 0x0x8c04f2e8;
8c04f2e6:	0c 44       	P4 -= P1;
8c04f2e8:	69 ac       	P1 = [P5 + 0x4];
8c04f2ea:	21 5e       	P0 = P1 + (P4 << 0x2);
8c04f2ec:	00 91       	R0 = [P0];
8c04f2ee:	00 0c       	CC = R0 == 0x0;
8c04f2f0:	14 18       	IF CC JUMP 0x0x8c04f318;
8c04f2f2:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8c04f2f4:	07 54       	R0 = R7 & R0;
8c04f2f6:	00 32       	P0 = R0;
8c04f2f8:	61 5e       	P1 = P1 + (P4 << 0x2);
8c04f2fa:	49 91       	P1 = [P1];
8c04f2fc:	01 5e       	P0 = P1 + (P0 << 0x2);
8c04f2fe:	0c 32       	P1 = R4;
8c04f300:	40 0c       	CC = P0 == 0x0;
8c04f302:	03 18       	IF CC JUMP 0x0x8c04f308;
8c04f304:	08 91       	R0 = [P1];
8c04f306:	00 93       	[P0] = R0;
8c04f308:	28 a1       	R0 = [P5 + 0x10];
8c04f30a:	08 64       	R0 += 0x1;		/* (  1) */
8c04f30c:	28 b1       	[P5 + 0x10] = R0;
8c04f30e:	66 6c       	SP += 0xc;		/* ( 12) */
8c04f310:	a3 05       	(R7:4, P5:3) = [SP++];
8c04f312:	01 e8 00 00 	UNLINK;
8c04f316:	10 00       	RTS;
8c04f318:	80 60       	R0 = 0x10 (X);		/*		R0=0x64(100) */
8c04f31a:	00 de 4c 8d 	CALL.A 0x8d4ce3d4;
8c04f31e:	d4 e3 00 00 
8c04f322:	69 ac       	P1 = [P5 + 0x4];
8c04f324:	61 5e       	P1 = P1 + (P4 << 0x2);
8c04f326:	08 93       	[P1] = R0;
8c04f328:	69 ac       	P1 = [P5 + 0x4];
8c04f32a:	e4 2f       	JUMP.S 0x0x8c04f2f2;
8c04f32c:	93 54       	R2 = R3 & R2;
8c04f32e:	00 de 02 04 	CALL.A 0x04020218;
8c04f332:	18 02 00 00 
8c04f336:	82 ce 15 8a 	R5 = R5 << 0x2 || R2 = [P5 + 0x4] || NOP;
8c04f33a:	6a a0 00 00 
8c04f33e:	82 c6 17 82 	R1 = R7 << 0x2;
8c04f342:	2a 50       	R0 = R2 + R5;
8c04f344:	4a 50       	R1 = R2 + R1;
8c04f346:	08 52       	R0 = R0 - R1;
8c04f348:	e3 63       	R3 = -0x4 (X);		/*		R3=0xb8(184) */
8c04f34a:	98 54       	R2 = R0 & R3;
8c04f34c:	06 30       	R0 = R6;
8c04f34e:	56 51       	R5 = R6 + R2;
8c04f350:	00 de 02 04 	CALL.A 0x04020218;
8c04f354:	18 02 00 00 
8c04f358:	0f 32       	P1 = R7;
8c04f35a:	07 0c       	CC = R7 == 0x0;
8c04f35c:	05 32       	P0 = R5;
8c04f35e:	ae 1b       	IF CC JUMP 0x0x8c04f2ba;
8c04f360:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8c04f362:	a2 e0 02 10 	LSETUP(0x8c04f366, 0x8c04f366) LC0 = P1;
8c04f366:	00 92       	[P0++] = R0;
8c04f368:	a9 2f       	JUMP.S 0x0x8c04f2ba;
8c04f36a:	00 00       	NOP;
8c04f36c:	00 de ed 8f 	CALL.A 0x8fed2b24;
8c04f370:	24 2b 00 00 
8c04f374:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04f378:	e3 05       	[--SP] = (R7:4, P5:3);
8c04f37a:	28 32       	P5 = R0;
8c04f37c:	a6 6f       	SP += -0xc;		/* (-12) */
8c04f37e:	03 da d1 05 	R3=97612893;
8c04f382:	5d 74 00 00 
8c04f386:	47 60       	R7 = 0x8 (X);		/*		R7=0x0(  0) */
8c04f388:	e4 63       	R4 = -0x4 (X);		/*		R4=0x80(128) */
8c04f38a:	aa a0       	R2 = [P5 + 0x8];
8c04f38c:	04 cc 1a 40 	R0 = R3 - R2 (NS) || P4 = [P5 + 0xc] || R5 = [P5 + 0xc];
8c04f390:	ec ac ed a0 
8c04f394:	88 09       	CC = R0 < R1 (IU);
8c04f396:	73 18       	IF CC JUMP 0x0x8c04f47c;
8c04f398:	82 c6 fa 81 	R0 = R2 >> 0x1;
8c04f39c:	b8 09       	CC = R0 < R7 (IU);
8c04f39e:	07 07       	IF CC R0 = R7;
8c04f3a0:	81 09       	CC = R1 < R0 (IU);
8c04f3a2:	04 10       	IF !CC JUMP 0x0x8c04f3aa;
8c04f3a4:	c3 52       	R3 = R3 - R0;
8c04f3a6:	1a 0a       	CC = R2 <= R3 (IU);
8c04f3a8:	08 07       	IF CC R1 = R0;
8c04f3aa:	01 30       	R0 = R1;
8c04f3ac:	50 41       	R0 = (R0 + R2) << 0x2;
8c04f3ae:	39 30       	R7 = R1;
8c04f3b0:	00 de 4c 8d 	CALL.A 0x8d4ce3d4;
8c04f3b4:	d4 e3 00 00 
8c04f3b8:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || P3 = [P5 + 0x4] || NOP;
8c04f3bc:	6b ac 00 00 
8c04f3c0:	a8 ac       	P0 = [P5 + 0x8];
8c04f3c2:	08 32       	P1 = R0;
8c04f3c4:	a3 5e       	P2 = P3 + (P4 << 0x2);
8c04f3c6:	03 5e       	P0 = P3 + (P0 << 0x2);
8c04f3c8:	10 44       	P0 -= P2;
8c04f3ca:	48 30       	R1 = P0;
8c04f3cc:	e1 5e       	P3 = P1 + (P4 << 0x2);
8c04f3ce:	a1 54       	R2 = R1 & R4;
8c04f3d0:	32 b3       	[SP + 0x30] = R2;
8c04f3d2:	43 30       	R0 = P3;
8c04f3d4:	4a 30       	R1 = P2;
8c04f3d6:	00 de 02 04 	CALL.A 0x04020218;
8c04f3da:	18 02 00 00 
8c04f3de:	82 ce 17 84 	R2 = R7 << 0x2 || P1 = [SP + 0x30] || R1 = [P5 + 0x4];
8c04f3e2:	31 af 69 a0 
8c04f3e6:	3d 0a       	CC = R5 <= R7 (IU);
8c04f3e8:	06 34       	I0 = R6;
8c04f3ea:	a2 54       	R2 = R2 & R4;
8c04f3ec:	cb 5a       	P3 = P3 + P1;
8c04f3ee:	43 30       	R0 = P3;
8c04f3f0:	28 10       	IF !CC JUMP 0x0x8c04f440;
8c04f3f2:	f2 60       	R2 = 0x1e (X);		/*		R2=0x6e(110) */
8c04f3f4:	0a c6 15 44 	R2 = EXTRACT (R5, R2.L) (X);
8c04f3f8:	12 4f       	R2 <<= 0x2;
8c04f3fa:	32 b3       	[SP + 0x30] = R2;
8c04f3fc:	00 de 02 04 	CALL.A 0x04020218;
8c04f400:	18 02 00 00 
8c04f404:	04 cc 3d 46 	R3 = R7 - R5 (NS) || P1 = [SP + 0x30] || NOP;
8c04f408:	31 af 00 00 
8c04f40c:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8c04f40e:	0b 5a       	P0 = P3 + P1;
8c04f410:	0b 32       	P1 = R3;
8c04f412:	a2 e0 02 14 	LSETUPZ(0x8c04f416, 0x8c04f416) LC0 = P1;
8c04f416:	00 92       	[P0++] = R0;
8c04f418:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8c04f41a:	a2 e0 02 44 	LSETUPZ(0x8c04f41e, 0x8c04f41e) LC0 = P4;
8c04f41e:	00 9e       	[I0++] = R0;
8c04f420:	68 a0       	R0 = [P5 + 0x4];
8c04f422:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f426:	e4 e3 00 00 
8c04f42a:	03 c8 00 18 	MNOP || R0 = [P5 + 0x8] || [P5 + 0x4] = R6;
8c04f42e:	a8 a0 6e b0 
8c04f432:	07 50       	R0 = R7 + R0;
8c04f434:	a8 b0       	[P5 + 0x8] = R0;
8c04f436:	66 6c       	SP += 0xc;		/* ( 12) */
8c04f438:	a3 05       	(R7:4, P5:3) = [SP++];
8c04f43a:	01 e8 00 00 	UNLINK;
8c04f43e:	10 00       	RTS;
8c04f440:	00 de 02 04 	CALL.A 0x04020218;
8c04f444:	18 02 00 00 
8c04f448:	82 ce 15 86 	R3 = R5 << 0x2 || R2 = [P5 + 0x4] || NOP;
8c04f44c:	6a a0 00 00 
8c04f450:	82 c6 17 82 	R1 = R7 << 0x2;
8c04f454:	1a 50       	R0 = R2 + R3;
8c04f456:	4a 50       	R1 = R2 + R1;
8c04f458:	08 52       	R0 = R0 - R1;
8c04f45a:	a0 54       	R2 = R0 & R4;
8c04f45c:	06 30       	R0 = R6;
8c04f45e:	56 51       	R5 = R6 + R2;
8c04f460:	00 de 02 04 	CALL.A 0x04020218;
8c04f464:	18 02 00 00 
8c04f468:	0f 32       	P1 = R7;
8c04f46a:	07 0c       	CC = R7 == 0x0;
8c04f46c:	05 32       	P0 = R5;
8c04f46e:	d9 1b       	IF CC JUMP 0x0x8c04f420;
8c04f470:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8c04f472:	a2 e0 02 10 	LSETUP(0x8c04f476, 0x8c04f476) LC0 = P1;
8c04f476:	00 92       	[P0++] = R0;
8c04f478:	d4 2f       	JUMP.S 0x0x8c04f420;
8c04f47a:	00 00       	NOP;
8c04f47c:	00 de ed 8f 	CALL.A 0x8fed2b24;
8c04f480:	24 2b 00 00 
8c04f484:	0a 32       	P1 = R2;
8c04f486:	00 e8 0b 00 	LINK 0x2c;		/* (44) */
8c04f48a:	ec 05       	[--SP] = (R7:5, P5:4);
8c04f48c:	86 6f       	SP += -0x10;		/* (-16) */
8c04f48e:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R5 = [FP + 0x14] || NOP;
8c04f492:	7d a1 00 00 
8c04f496:	7b 60       	R3 = 0xf (X);		/*		R3=0xb8(184) */
8c04f498:	b6 e6 34 00 	B[SP + 0x34] = R6;
8c04f49c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [FP -0x8] = R3 || R2 = [P1++];
8c04f4a0:	e3 bb 0a 90 
8c04f4a4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c04f4a8:	b8 00 03 00 
8c04f4ac:	27 32       	P4 = R7;
8c04f4ae:	03 c8 00 18 	MNOP || [SP + 0xc] = R3 || R3 = [P1++];
8c04f4b2:	f3 b0 0b 90 
8c04f4b6:	03 c8 00 18 	MNOP || [SP + 0x24] = R2 || R2 = [P1];
8c04f4ba:	72 b2 0a 91 
8c04f4be:	47 30       	R0 = FP;
8c04f4c0:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0x2c] = R2 || NOP;
8c04f4c4:	f2 b2 00 00 
8c04f4c8:	d6 bb       	[FP -0xc] = R6;
8c04f4ca:	b3 b2       	[SP + 0x28] = R3;
8c04f4cc:	00 67       	R0 += -0x20;		/* (-32) */
8c04f4ce:	ff e3 51 7a 	CALL 0x0x8c03e970;
8c04f4d2:	03 c8 00 18 	MNOP || R1 = [P4 + 0x24] || R0 = [P4 + 0x1c];
8c04f4d6:	61 a2 e0 a1 
8c04f4da:	09 64       	R1 += 0x1;		/* (  1) */
8c04f4dc:	08 0a       	CC = R0 <= R1 (IU);
8c04f4de:	f5 bb       	[FP -0x4] = R5;
8c04f4e0:	40 18       	IF CC JUMP 0x0x8c04f560;
8c04f4e2:	21 ae       	P1 = [P4 + 0x20];
8c04f4e4:	60 ae       	P0 = [P4 + 0x24];
8c04f4e6:	41 5b       	P5 = P1 + P0;
8c04f4e8:	4d 30       	R1 = P5;
8c04f4ea:	08 0a       	CC = R0 <= R1 (IU);
8c04f4ec:	03 10       	IF !CC JUMP 0x0x8c04f4f2;
8c04f4ee:	e1 ad       	P1 = [P4 + 0x1c];
8c04f4f0:	0d 44       	P5 -= P1;
8c04f4f2:	a1 ad       	P1 = [P4 + 0x18];
8c04f4f4:	29 5e       	P0 = P1 + (P5 << 0x2);
8c04f4f6:	00 91       	R0 = [P0];
8c04f4f8:	00 0c       	CC = R0 == 0x0;
8c04f4fa:	29 18       	IF CC JUMP 0x0x8c04f54c;
8c04f4fc:	69 5e       	P1 = P1 + (P5 << 0x2);
8c04f4fe:	08 91       	R0 = [P1];
8c04f500:	00 0c       	CC = R0 == 0x0;
8c04f502:	05 18       	IF CC JUMP 0x0x8c04f50c;
8c04f504:	4f 30       	R1 = FP;
8c04f506:	a1 66       	R1 += -0x2c;		/* (-44) */
8c04f508:	ff e3 8c fc 	CALL 0x0x8c04ee20;
8c04f50c:	81 60       	R1 = 0x10 (X);		/*		R1=0x9c(156) */
8c04f50e:	03 c8 00 18 	MNOP || R0 = [P4 + 0x24] || R2 = [FP -0x8];
8c04f512:	60 a2 e2 b9 
8c04f516:	11 0a       	CC = R1 <= R2 (IU);
8c04f518:	08 64       	R0 += 0x1;		/* (  1) */
8c04f51a:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P4 + 0x24] = R0 || NOP;
8c04f51e:	60 b2 00 00 
8c04f522:	08 18       	IF CC JUMP 0x0x8c04f532;
8c04f524:	b6 e6 34 00 	B[SP + 0x34] = R6;
8c04f528:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f52a:	ac 05       	(R7:5, P5:4) = [SP++];
8c04f52c:	01 e8 00 00 	UNLINK;
8c04f530:	10 00       	RTS;
8c04f532:	70 a3       	R0 = [SP + 0x34];
8c04f534:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f538:	e4 e3 00 00 
8c04f53c:	b6 e6 34 00 	B[SP + 0x34] = R6;
8c04f540:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f542:	ac 05       	(R7:5, P5:4) = [SP++];
8c04f544:	01 e8 00 00 	UNLINK;
8c04f548:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8c04f54a:	10 00       	RTS;
8c04f54c:	60 61       	R0 = 0x2c (X);		/*		R0=0x64(100) */
8c04f54e:	00 de 4c 8d 	CALL.A 0x8d4ce3d4;
8c04f552:	d4 e3 00 00 
8c04f556:	a1 ad       	P1 = [P4 + 0x18];
8c04f558:	69 5e       	P1 = P1 + (P5 << 0x2);
8c04f55a:	08 93       	[P1] = R0;
8c04f55c:	a1 ad       	P1 = [P4 + 0x18];
8c04f55e:	cf 2f       	JUMP.S 0x0x8c04f4fc;
8c04f560:	a7 64       	R7 += 0x14;		/* ( 20) */
8c04f562:	07 30       	R0 = R7;
8c04f564:	09 60       	R1 = 0x1 (X);		/*		R1=0x9c(156) */
8c04f566:	ff e3 07 ff 	CALL 0x0x8c04f374;
8c04f56a:	e0 a1       	R0 = [P4 + 0x1c];
8c04f56c:	bb 2f       	JUMP.S 0x0x8c04f4e2;
8c04f56e:	00 00       	NOP;
8c04f570:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8c04f574:	e5 05       	[--SP] = (R7:4, P5:5);
8c04f576:	2a 32       	P5 = R2;
8c04f578:	86 6f       	SP += -0x10;		/* (-16) */
8c04f57a:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || P1 = [FP + 0x18] || R2 = [FP + 0x14];
8c04f57e:	b9 ad 7a a1 
8c04f582:	23 60       	R3 = 0x4 (X);		/*		R3=0xb8(184) */
8c04f584:	b9 b0       	[FP + 0x8] = R1;
8c04f586:	04 cc 00 40 	R0 = R0 - R0 (NS) || R7 = [P5] || [FP + 0xc] = R0;
8c04f58a:	2f 91 f8 b0 
8c04f58e:	ba 52       	R2 = R2 - R7;
8c04f590:	9a 08       	CC = R2 < R3;
8c04f592:	62 18       	IF CC JUMP 0x0x8c04f656;
8c04f594:	08 93       	[P1] = R0;
8c04f596:	86 61       	R6 = 0x30 (X);		/*		R6=0x66(102) */
8c04f598:	cf 61       	R7 = 0x39 (X);		/*		R7=0x0(  0) */
8c04f59a:	23 e1 61 00 	R3 = 0x61 (X);		/*		R3=0x61( 97) */
8c04f59e:	22 e1 41 00 	R2 = 0x41 (X);		/*		R2=0x41( 65) */
8c04f5a2:	21 e1 46 00 	R1 = 0x46 (X);		/*		R1=0x46( 70) */
8c04f5a6:	c0 e0 0e 10 	LSETUP_IMM(bottom=0x8c04f5c2) LC0 count_fields=0x0/0x4;
8c04f5aa:	68 91       	P0 = [P5];
8c04f5ac:	40 98       	R0 = B[P0++] (X);
8c04f5ae:	68 93       	[P5] = P0;
8c04f5b0:	06 09       	CC = R6 <= R0;
8c04f5b2:	0d 91       	R5 = [P1];
8c04f5b4:	25 4f       	R5 <<= 0x4;
8c04f5b6:	0d 93       	[P1] = R5;
8c04f5b8:	0c 10       	IF !CC JUMP 0x0x8c04f5d0;
8c04f5ba:	38 09       	CC = R0 <= R7;
8c04f5bc:	0a 10       	IF !CC JUMP 0x0x8c04f5d0;
8c04f5be:	80 66       	R0 += -0x30;		/* (-48) */
8c04f5c0:	28 50       	R0 = R0 + R5;
8c04f5c2:	08 93       	[P1] = R0;
8c04f5c4:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f5c6:	a5 05       	(R7:4, P5:5) = [SP++];
8c04f5c8:	01 e8 00 00 	UNLINK;
8c04f5cc:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
8c04f5ce:	10 00       	RTS;
8c04f5d0:	03 09       	CC = R3 <= R0;
8c04f5d2:	0a 10       	IF !CC JUMP 0x0x8c04f5e6;
8c04f5d4:	24 e1 66 00 	R4 = 0x66 (X);		/*		R4=0x66(102) */
8c04f5d8:	20 09       	CC = R0 <= R4;
8c04f5da:	06 10       	IF !CC JUMP 0x0x8c04f5e6;
8c04f5dc:	24 e1 a9 ff 	R4 = -0x57 (X);		/*		R4=0xffffffa9(-87) */
8c04f5e0:	20 50       	R0 = R0 + R4;
8c04f5e2:	28 50       	R0 = R0 + R5;
8c04f5e4:	ef 2f       	JUMP.S 0x0x8c04f5c2;
8c04f5e6:	02 09       	CC = R2 <= R0;
8c04f5e8:	06 10       	IF !CC JUMP 0x0x8c04f5f4;
8c04f5ea:	08 09       	CC = R0 <= R1;
8c04f5ec:	04 10       	IF !CC JUMP 0x0x8c04f5f4;
8c04f5ee:	48 66       	R0 += -0x37;		/* (-55) */
8c04f5f0:	28 50       	R0 = R0 + R5;
8c04f5f2:	e8 2f       	JUMP.S 0x0x8c04f5c2;
8c04f5f4:	7f 30       	R7 = FP;
8c04f5f6:	27 67       	R7 += -0x1c;		/* (-28) */
8c04f5f8:	07 30       	R0 = R7;
8c04f5fa:	01 da 80 11 	R1=293609116;
8c04f5fe:	9c 1e 00 00 
8c04f602:	ff e3 ff 7b 	CALL 0x0x8c03ee00;
8c04f606:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R3 = [P5] || R0 = [FP + 0xc];
8c04f60a:	2b 91 f8 a0 
8c04f60e:	03 c8 00 18 	MNOP || [SP + 0xc] = R3 || R2 = [FP + 0x8];
8c04f612:	f3 b0 ba a0 
8c04f616:	ff e3 37 ff 	CALL 0x0x8c04f484;
8c04f61a:	86 60       	R6 = 0x10 (X);		/*		R6=0x66(102) */
8c04f61c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R1 = [SP + 0x3c] || R0 = [SP + 0x28];
8c04f620:	f1 a3 b0 a2 
8c04f624:	0e 0a       	CC = R6 <= R1 (IU);
8c04f626:	0b 18       	IF CC JUMP 0x0x8c04f63c;
8c04f628:	01 60       	R1 = 0x0 (X);		/*		R1=0x46( 70) */
8c04f62a:	b1 e6 28 00 	B[SP + 0x28] = R1;
8c04f62e:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f630:	07 30       	R0 = R7;
8c04f632:	a5 05       	(R7:4, P5:5) = [SP++];
8c04f634:	01 e8 00 00 	UNLINK;
8c04f638:	10 00       	RTS;
8c04f63a:	00 00       	NOP;
8c04f63c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f640:	e4 e3 00 00 
8c04f644:	01 60       	R1 = 0x0 (X);		/*		R1=0x46( 70) */
8c04f646:	b1 e6 28 00 	B[SP + 0x28] = R1;
8c04f64a:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f64c:	07 30       	R0 = R7;
8c04f64e:	a5 05       	(R7:4, P5:5) = [SP++];
8c04f650:	01 e8 00 00 	UNLINK;
8c04f654:	10 00       	RTS;
8c04f656:	7f 30       	R7 = FP;
8c04f658:	27 67       	R7 += -0x1c;		/* (-28) */
8c04f65a:	07 30       	R0 = R7;
8c04f65c:	01 da 80 11 	R1=293609052;
8c04f660:	5c 1e 00 00 
8c04f664:	ff e3 ce 7b 	CALL 0x0x8c03ee00;
8c04f668:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [P5] || R2 = [FP + 0x8];
8c04f66c:	28 91 ba a0 
8c04f670:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R0 || NOP;
8c04f674:	f0 b0 00 00 
8c04f678:	ff e3 06 ff 	CALL 0x0x8c04f484;
8c04f67c:	83 60       	R3 = 0x10 (X);		/*		R3=0x61( 97) */
8c04f67e:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R1 = [SP + 0x3c] || R0 = [SP + 0x28];
8c04f682:	f1 a3 b0 a2 
8c04f686:	0b 0a       	CC = R3 <= R1 (IU);
8c04f688:	0a 18       	IF CC JUMP 0x0x8c04f69c;
8c04f68a:	01 60       	R1 = 0x0 (X);		/*		R1=0x46( 70) */
8c04f68c:	b1 e6 28 00 	B[SP + 0x28] = R1;
8c04f690:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f692:	07 30       	R0 = R7;
8c04f694:	a5 05       	(R7:4, P5:5) = [SP++];
8c04f696:	01 e8 00 00 	UNLINK;
8c04f69a:	10 00       	RTS;
8c04f69c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f6a0:	e4 e3 00 00 
8c04f6a4:	01 60       	R1 = 0x0 (X);		/*		R1=0x46( 70) */
8c04f6a6:	b1 e6 28 00 	B[SP + 0x28] = R1;
8c04f6aa:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f6ac:	07 30       	R0 = R7;
8c04f6ae:	a5 05       	(R7:4, P5:5) = [SP++];
8c04f6b0:	01 e8 00 00 	UNLINK;
8c04f6b4:	10 00       	RTS;
8c04f6b6:	00 00       	NOP;
8c04f6b8:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8c04f6bc:	e4 05       	[--SP] = (R7:4, P5:4);
8c04f6be:	66 6f       	SP += -0x14;		/* (-20) */
8c04f6c0:	82 ce 01 cc 	R6 = ROT R1 BY 0x0 || P4 = [FP + 0x18] || R5 = [FP + 0x14];
8c04f6c4:	bc ad 7d a1 
8c04f6c8:	82 ce 02 c8 	R4 = ROT R2 BY 0x0 || [SP + 0x10] = P4 || NOP;
8c04f6cc:	34 bd 00 00 
8c04f6d0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R5 || NOP;
8c04f6d4:	f5 b0 00 00 
8c04f6d8:	2a 32       	P5 = R2;
8c04f6da:	ff e3 4b ff 	CALL 0x0x8c04f570;
8c04f6de:	00 0c       	CC = R0 == 0x0;
8c04f6e0:	49 18       	IF CC JUMP 0x0x8c04f772;
8c04f6e2:	20 91       	R0 = [P4];
8c04f6e4:	81 e1 00 d8 	R1 = 0xd800 (Z);		/*		R1=0xd800(55296) */
8c04f6e8:	01 0a       	CC = R1 <= R0 (IU);
8c04f6ea:	3e 10       	IF !CC JUMP 0x0x8c04f766;
8c04f6ec:	81 e1 ff db 	R1 = 0xdbff (Z);		/*		R1=0xdbff(56319) */
8c04f6f0:	08 0a       	CC = R0 <= R1 (IU);
8c04f6f2:	3a 10       	IF !CC JUMP 0x0x8c04f766;
8c04f6f4:	03 c8 00 18 	MNOP || P1 = [P5] || R0 = [P5];
8c04f6f8:	69 91 28 91 
8c04f6fc:	45 52       	R1 = R5 - R0;
8c04f6fe:	32 60       	R2 = 0x6 (X);		/*		R2=0x41( 65) */
8c04f700:	91 08       	CC = R1 < R2;
8c04f702:	6f 18       	IF CC JUMP 0x0x8c04f7e0;
8c04f704:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || R2 = B[P1] (X) || NOP;
8c04f708:	4a 99 00 00 
8c04f70c:	08 64       	R0 += 0x1;		/* (  1) */
8c04f70e:	28 93       	[P5] = R0;
8c04f710:	08 32       	P1 = R0;
8c04f712:	23 e1 5c 00 	R3 = 0x5c (X);		/*		R3=0x5c( 92) */
8c04f716:	1a 08       	CC = R2 == R3;
8c04f718:	32 10       	IF !CC JUMP 0x0x8c04f77c;
8c04f71a:	22 e1 75 00 	R2 = 0x75 (X);		/*		R2=0x75(117) */
8c04f71e:	11 64       	R1 += 0x2;		/* (  2) */
8c04f720:	48 99       	R0 = B[P1] (X);
8c04f722:	10 08       	CC = R0 == R2;
8c04f724:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || [P5] = R1 || NOP;
8c04f728:	29 93 00 00 
8c04f72c:	28 10       	IF !CC JUMP 0x0x8c04f77c;
8c04f72e:	f5 b0       	[SP + 0xc] = R5;
8c04f730:	07 30       	R0 = R7;
8c04f732:	4f 30       	R1 = FP;
8c04f734:	41 64       	R1 += 0x8;		/* (  8) */
8c04f736:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [SP + 0x10] = R1 || NOP;
8c04f73a:	31 b1 00 00 
8c04f73e:	ff e3 19 ff 	CALL 0x0x8c04f570;
8c04f742:	00 0c       	CC = R0 == 0x0;
8c04f744:	17 18       	IF CC JUMP 0x0x8c04f772;
8c04f746:	20 e1 ff 03 	R0 = 0x3ff (X);		/*		R0=0x3ff(1023) */
8c04f74a:	01 da 01 00 	R1=65536;
8c04f74e:	00 00 00 00 
8c04f752:	03 c8 00 18 	MNOP || R2 = [P4] || R3 = [FP + 0x8];
8c04f756:	22 91 bb a0 
8c04f75a:	82 54       	R2 = R2 & R0;
8c04f75c:	03 54       	R0 = R3 & R0;
8c04f75e:	52 4f       	R2 <<= 0xa;
8c04f760:	4a 50       	R1 = R2 + R1;
8c04f762:	01 50       	R0 = R1 + R0;
8c04f764:	20 93       	[P4] = R0;
8c04f766:	a6 6c       	SP += 0x14;		/* ( 20) */
8c04f768:	a4 05       	(R7:4, P5:4) = [SP++];
8c04f76a:	01 e8 00 00 	UNLINK;
8c04f76e:	08 60       	R0 = 0x1 (X);		/*		R0=0x3ff(1023) */
8c04f770:	10 00       	RTS;
8c04f772:	a6 6c       	SP += 0x14;		/* ( 20) */
8c04f774:	a4 05       	(R7:4, P5:4) = [SP++];
8c04f776:	01 e8 00 00 	UNLINK;
8c04f77a:	10 00       	RTS;
8c04f77c:	6f 30       	R5 = FP;
8c04f77e:	25 67       	R5 += -0x1c;		/* (-28) */
8c04f780:	05 30       	R0 = R5;
8c04f782:	01 da 80 11 	R1=293609252;
8c04f786:	24 1f 00 00 
8c04f78a:	ff e3 3b 7b 	CALL 0x0x8c03ee00;
8c04f78e:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || R0 = [P5] || NOP;
8c04f792:	28 91 00 00 
8c04f796:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R0 || NOP;
8c04f79a:	f0 b0 00 00 
8c04f79e:	16 30       	R2 = R6;
8c04f7a0:	ff e3 72 fe 	CALL 0x0x8c04f484;
8c04f7a4:	81 60       	R1 = 0x10 (X);		/*		R1=0xdbff(56319) */
8c04f7a6:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x4] || NOP;
8c04f7aa:	f0 b9 00 00 
8c04f7ae:	01 0a       	CC = R1 <= R0 (IU);
8c04f7b0:	0a 18       	IF CC JUMP 0x0x8c04f7c4;
8c04f7b2:	01 60       	R1 = 0x0 (X);		/*		R1=0xdbff(56319) */
8c04f7b4:	b1 e6 30 00 	B[SP + 0x30] = R1;
8c04f7b8:	a6 6c       	SP += 0x14;		/* ( 20) */
8c04f7ba:	07 30       	R0 = R7;
8c04f7bc:	a4 05       	(R7:4, P5:4) = [SP++];
8c04f7be:	01 e8 00 00 	UNLINK;
8c04f7c2:	10 00       	RTS;
8c04f7c4:	30 a3       	R0 = [SP + 0x30];
8c04f7c6:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f7ca:	e4 e3 00 00 
8c04f7ce:	01 60       	R1 = 0x0 (X);		/*		R1=0xdbff(56319) */
8c04f7d0:	b1 e6 30 00 	B[SP + 0x30] = R1;
8c04f7d4:	a6 6c       	SP += 0x14;		/* ( 20) */
8c04f7d6:	07 30       	R0 = R7;
8c04f7d8:	a4 05       	(R7:4, P5:4) = [SP++];
8c04f7da:	01 e8 00 00 	UNLINK;
8c04f7de:	10 00       	RTS;
8c04f7e0:	6f 30       	R5 = FP;
8c04f7e2:	25 67       	R5 += -0x1c;		/* (-28) */
8c04f7e4:	05 30       	R0 = R5;
8c04f7e6:	01 da 80 11 	R1=293609184;
8c04f7ea:	e0 1e 00 00 
8c04f7ee:	ff e3 09 7b 	CALL 0x0x8c03ee00;
8c04f7f2:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || R0 = [P5] || NOP;
8c04f7f6:	28 91 00 00 
8c04f7fa:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R0 || NOP;
8c04f7fe:	f0 b0 00 00 
8c04f802:	16 30       	R2 = R6;
8c04f804:	ff e3 40 fe 	CALL 0x0x8c04f484;
8c04f808:	81 60       	R1 = 0x10 (X);		/*		R1=0xdbff(56319) */
8c04f80a:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x4] || NOP;
8c04f80e:	f0 b9 00 00 
8c04f812:	01 0a       	CC = R1 <= R0 (IU);
8c04f814:	0a 18       	IF CC JUMP 0x0x8c04f828;
8c04f816:	01 60       	R1 = 0x0 (X);		/*		R1=0xdbff(56319) */
8c04f818:	b1 e6 30 00 	B[SP + 0x30] = R1;
8c04f81c:	a6 6c       	SP += 0x14;		/* ( 20) */
8c04f81e:	07 30       	R0 = R7;
8c04f820:	a4 05       	(R7:4, P5:4) = [SP++];
8c04f822:	01 e8 00 00 	UNLINK;
8c04f826:	10 00       	RTS;
8c04f828:	30 a3       	R0 = [SP + 0x30];
8c04f82a:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f82e:	e4 e3 00 00 
8c04f832:	01 60       	R1 = 0x0 (X);		/*		R1=0xdbff(56319) */
8c04f834:	b1 e6 30 00 	B[SP + 0x30] = R1;
8c04f838:	a6 6c       	SP += 0x14;		/* ( 20) */
8c04f83a:	07 30       	R0 = R7;
8c04f83c:	a4 05       	(R7:4, P5:4) = [SP++];
8c04f83e:	01 e8 00 00 	UNLINK;
8c04f842:	10 00       	RTS;
8c04f844:	00 e8 18 00 	LINK 0x60;		/* (96) */
8c04f848:	e4 05       	[--SP] = (R7:4, P5:4);
8c04f84a:	21 32       	P4 = R1;
8c04f84c:	86 6f       	SP += -0x10;		/* (-16) */
8c04f84e:	82 ce 01 cc 	R6 = ROT R1 BY 0x0 || [FP + 0xc] = R0 || NOP;
8c04f852:	f8 b0 00 00 
8c04f856:	38 30       	R7 = R0;
8c04f858:	00 61       	R0 = 0x20 (X);		/*		R0=0x3ff(1023) */
8c04f85a:	03 c8 00 18 	MNOP || R2 = [P4 + 0x8] || R1 = [P4 + 0x4];
8c04f85e:	a2 a0 61 a0 
8c04f862:	ca 52       	R3 = R2 - R1;
8c04f864:	05 60       	R5 = 0x0 (X);		/*		R5=0x45( 69) */
8c04f866:	03 09       	CC = R3 <= R0;
8c04f868:	bd b0       	[FP + 0x8] = R5;
8c04f86a:	66 30       	R4 = SP;
8c04f86c:	9c 10       	IF !CC JUMP 0x0x8c04f9a4;
8c04f86e:	a0 61       	R0 = 0x34 (X);		/*		R0=0x3ff(1023) */
8c04f870:	2b 32       	P5 = R3;
8c04f872:	04 51       	R4 = R4 + R0;
8c04f874:	13 30       	R2 = R3;
8c04f876:	04 30       	R0 = R4;
8c04f878:	00 de 02 04 	CALL.A 0x040201c4;
8c04f87c:	c4 01 00 00 
8c04f880:	a1 69       	P1 = 0x34 (X);		/*		P1=0x0(  0) */
8c04f882:	4e 5a       	P1 = SP + P1;
8c04f884:	69 5a       	P1 = P1 + P5;
8c04f886:	57 30       	R2 = FP;
8c04f888:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || B[P1] = R5 || NOP;
8c04f88c:	0d 9b 00 00 
8c04f890:	42 64       	R2 += 0x8;		/* (  8) */
8c04f892:	01 da 80 11 	R1=293608768;
8c04f896:	40 1d 00 00 
8c04f89a:	00 de ed 8f 	CALL.A 0x8fed0ad8;
8c04f89e:	d8 0a 00 00 
8c04f8a2:	08 0c       	CC = R0 == 0x1;
8c04f8a4:	1b 10       	IF !CC JUMP 0x0x8c04f8da;
8c04f8a6:	07 30       	R0 = R7;
8c04f8a8:	ff e3 bd f8 	CALL 0x0x8c04ea22;
8c04f8ac:	38 30       	R7 = R0;
8c04f8ae:	46 30       	R0 = SP;
8c04f8b0:	41 61       	R1 = 0x28 (X);		/*		R1=0xdbff(56319) */
8c04f8b2:	04 cc 01 0c 	R6 = R0 + R1 (NS) || R1 = [FP + 0x8] || NOP;
8c04f8b6:	b9 a0 00 00 
8c04f8ba:	06 30       	R0 = R6;
8c04f8bc:	00 e3 1c 10 	CALL 0x0x8c0518f4;
8c04f8c0:	07 30       	R0 = R7;
8c04f8c2:	0e 30       	R1 = R6;
8c04f8c4:	00 e3 26 11 	CALL 0x0x8c051b10;
8c04f8c8:	06 30       	R0 = R6;
8c04f8ca:	00 e3 b7 10 	CALL 0x0x8c051a38;
8c04f8ce:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f8d0:	a4 05       	(R7:4, P5:4) = [SP++];
8c04f8d2:	01 e8 00 00 	UNLINK;
8c04f8d6:	08 60       	R0 = 0x1 (X);		/*		R0=0x3ff(1023) */
8c04f8d8:	10 00       	RTS;
8c04f8da:	7f 30       	R7 = FP;
8c04f8dc:	27 67       	R7 += -0x1c;		/* (-28) */
8c04f8de:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [P4 + 0x4] || R2 = [P4 + 0x8];
8c04f8e2:	61 a0 a2 a0 
8c04f8e6:	ff e3 92 f7 	CALL 0x0x8c04e80a;
8c04f8ea:	04 da 80 11 	R4=293608768;
8c04f8ee:	40 1d 00 00 
8c04f8f2:	07 30       	R0 = R7;
8c04f8f4:	24 64       	R4 += 0x4;		/* (  4) */
8c04f8f6:	17 30       	R2 = R7;
8c04f8f8:	0c 30       	R1 = R4;
8c04f8fa:	20 67       	R0 += -0x1c;		/* (-28) */
8c04f8fc:	ff e3 b8 fa 	CALL 0x0x8c04ee6c;
8c04f900:	47 30       	R0 = FP;
8c04f902:	40 66       	R0 += -0x38;		/* (-56) */
8c04f904:	08 30       	R1 = R0;
8c04f906:	20 67       	R0 += -0x1c;		/* (-28) */
8c04f908:	02 da 80 11 	R2=293609332;
8c04f90c:	74 1f 00 00 
8c04f910:	ff e3 42 7c 	CALL 0x0x8c03f194;
8c04f914:	a7 61       	R7 = 0x34 (X);		/*		R7=0x0(  0) */
8c04f916:	5e 30       	R3 = SP;
8c04f918:	01 68       	P1 = 0x0 (X);		/*		P1=0x0(  0) */
8c04f91a:	04 cc 1f 02 	R1 = R3 + R7 (NS) || [SP + 0xc] = P1 || R0 = [FP + 0xc];
8c04f91e:	f1 bc f8 a0 
8c04f922:	16 30       	R2 = R6;
8c04f924:	ff e3 b0 fd 	CALL 0x0x8c04f484;
8c04f928:	84 60       	R4 = 0x10 (X);		/*		R4=0xffffffa9(-87) */
8c04f92a:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R1 = [FP -0x3c] || R0 = [SP + 0x38];
8c04f92e:	11 b9 b0 a3 
8c04f932:	0c 0a       	CC = R4 <= R1 (IU);
8c04f934:	32 18       	IF CC JUMP 0x0x8c04f998;
8c04f936:	b5 e6 38 00 	B[SP + 0x38] = R5;
8c04f93a:	03 c8 00 18 	MNOP || R0 = [FP -0x20] || [FP -0x40] = R5;
8c04f93e:	80 b9 05 bb 
8c04f942:	04 0a       	CC = R4 <= R0 (IU);
8c04f944:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8c04f946:	17 bb       	[FP -0x3c] = R7;
8c04f948:	21 18       	IF CC JUMP 0x0x8c04f98a;
8c04f94a:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || [FP -0x20] = R7;
8c04f94e:	f0 b9 87 bb 
8c04f952:	04 0a       	CC = R4 <= R0 (IU);
8c04f954:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x24] = R5 || NOP;
8c04f958:	75 bb 00 00 
8c04f95c:	b5 e6 54 00 	B[SP + 0x54] = R5;
8c04f960:	08 18       	IF CC JUMP 0x0x8c04f970;
8c04f962:	b5 e6 70 00 	B[SP + 0x70] = R5;
8c04f966:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f968:	a4 05       	(R7:4, P5:4) = [SP++];
8c04f96a:	01 e8 00 00 	UNLINK;
8c04f96e:	10 00       	RTS;
8c04f970:	a0 b9       	R0 = [FP -0x18];
8c04f972:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f976:	e4 e3 00 00 
8c04f97a:	b5 e6 70 00 	B[SP + 0x70] = R5;
8c04f97e:	86 6c       	SP += 0x10;		/* ( 16) */
8c04f980:	06 30       	R0 = R6;
8c04f982:	a4 05       	(R7:4, P5:4) = [SP++];
8c04f984:	01 e8 00 00 	UNLINK;
8c04f988:	10 00       	RTS;
8c04f98a:	30 b9       	R0 = [FP -0x34];
8c04f98c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f990:	e4 e3 00 00 
8c04f994:	db 2f       	JUMP.S 0x0x8c04f94a;
8c04f996:	00 00       	NOP;
8c04f998:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f99c:	e4 e3 00 00 
8c04f9a0:	cb 2f       	JUMP.S 0x0x8c04f936;
8c04f9a2:	00 00       	NOP;
8c04f9a4:	a0 61       	R0 = 0x34 (X);		/*		R0=0x3ff(1023) */
8c04f9a6:	04 50       	R0 = R4 + R0;
8c04f9a8:	ff e3 31 f7 	CALL 0x0x8c04e80a;
8c04f9ac:	5e 30       	R3 = SP;
8c04f9ae:	c0 61       	R0 = 0x38 (X);		/*		R0=0x3ff(1023) */
8c04f9b0:	84 60       	R4 = 0x10 (X);		/*		R4=0xffffffa9(-87) */
8c04f9b2:	04 cc 18 00 	R0 = R3 + R0 (NS) || R1 = [FP -0x3c] || R3 = [SP + 0x38];
8c04f9b6:	11 b9 b3 a3 
8c04f9ba:	0c 0a       	CC = R4 <= R1 (IU);
8c04f9bc:	57 30       	R2 = FP;
8c04f9be:	03 07       	IF CC R0 = R3;
8c04f9c0:	42 64       	R2 += 0x8;		/* (  8) */
8c04f9c2:	01 da 80 11 	R1=293608768;
8c04f9c6:	40 1d 00 00 
8c04f9ca:	00 de ed 8f 	CALL.A 0x8fed0ad8;
8c04f9ce:	d8 0a 00 00 
8c04f9d2:	03 c8 00 18 	MNOP || [FP + 0x10] = R0 || R0 = [FP -0x3c];
8c04f9d6:	38 b1 10 b9 
8c04f9da:	04 0a       	CC = R4 <= R0 (IU);
8c04f9dc:	0a 18       	IF CC JUMP 0x0x8c04f9f0;
8c04f9de:	79 60       	R1 = 0xf (X);		/*		R1=0xdbff(56319) */
8c04f9e0:	03 c8 00 18 	MNOP || [FP -0x40] = R5 || R0 = [FP + 0x10];
8c04f9e4:	05 bb 38 a1 
8c04f9e8:	b5 e6 38 00 	B[SP + 0x38] = R5;
8c04f9ec:	11 bb       	[FP -0x3c] = R1;
8c04f9ee:	5a 2f       	JUMP.S 0x0x8c04f8a2;
8c04f9f0:	b0 a3       	R0 = [SP + 0x38];
8c04f9f2:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04f9f6:	e4 e3 00 00 
8c04f9fa:	f2 2f       	JUMP.S 0x0x8c04f9de;
8c04f9fc:	00 00       	NOP;
8c04f9fe:	00 00       	NOP;
8c04fa00:	00 e8 16 00 	LINK 0x58;		/* (88) */
8c04fa04:	e4 05       	[--SP] = (R7:4, P5:4);
8c04fa06:	86 6f       	SP += -0x10;		/* (-16) */
8c04fa08:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP + 0xc] = R1 || NOP;
8c04fa0c:	f9 b0 00 00 
8c04fa10:	04 cc 36 4c 	R6 = R6 - R6 (NS) || P1 = [FP + 0xc] || [FP + 0x10] = R1;
8c04fa14:	f9 ac 39 b1 
8c04fa18:	04 cc 00 40 	R0 = R0 - R0 (NS) || [FP + 0x8] = R0 || NOP;
8c04fa1c:	b8 b0 00 00 
8c04fa20:	75 61       	R5 = 0x2e (X);		/*		R5=0x45( 69) */
8c04fa22:	6f 61       	R7 = 0x2d (X);		/*		R7=0x0(  0) */
8c04fa24:	03 c8 00 18 	MNOP || P5 = [P1 + 0x8] || R1 = [P1 + 0x4];
8c04fa28:	8d ac 49 a0 
8c04fa2c:	b5 be       	[SP + 0x28] = P5;
8c04fa2e:	01 32       	P0 = R1;
8c04fa30:	b3 a2       	R3 = [SP + 0x28];
8c04fa32:	19 08       	CC = R1 == R3;
8c04fa34:	2c 18       	IF CC JUMP 0x0x8c04fa8c;
8c04fa36:	48 32       	P1 = P0;
8c04fa38:	09 6c       	P1 += 0x1;		/* (  1) */
8c04fa3a:	4d 08       	CC = P5 == P1;
8c04fa3c:	55 32       	P2 = P5;
8c04fa3e:	0a 44       	P2 -= P1;
8c04fa40:	60 32       	P4 = P0;
8c04fa42:	21 18       	IF CC JUMP 0x0x8c04fa84;
8c04fa44:	02 5b       	P4 = P2 + P0;
8c04fa46:	48 32       	P1 = P0;
8c04fa48:	23 e1 65 00 	R3 = 0x65 (X);		/*		R3=0x65(101) */
8c04fa4c:	a2 e0 1b 20 	LSETUP(0x8c04fa50, 0x8c04fa82) LC0 = P2;
8c04fa50:	40 43       	R0 = R0.B (Z);
8c04fa52:	00 0c       	CC = R0 == 0x0;
8c04fa54:	08 60       	R0 = 0x1 (X);		/*		R0=0x3ff(1023) */
8c04fa56:	16 10       	IF !CC JUMP 0x0x8c04fa82;
8c04fa58:	4a 99       	R2 = B[P1] (X);
8c04fa5a:	2a 08       	CC = R2 == R5;
8c04fa5c:	0c 60       	R4 = 0x1 (X);		/*		R4=0xffffffa9(-87) */
8c04fa5e:	0b 18       	IF CC JUMP 0x0x8c04fa74;
8c04fa60:	1a 08       	CC = R2 == R3;
8c04fa62:	09 18       	IF CC JUMP 0x0x8c04fa74;
8c04fa64:	24 e1 45 00 	R4 = 0x45 (X);		/*		R4=0x45( 69) */
8c04fa68:	22 08       	CC = R2 == R4;
8c04fa6a:	0c 60       	R4 = 0x1 (X);		/*		R4=0x45( 69) */
8c04fa6c:	04 18       	IF CC JUMP 0x0x8c04fa74;
8c04fa6e:	5c 61       	R4 = 0x2b (X);		/*		R4=0x45( 69) */
8c04fa70:	22 08       	CC = R2 == R4;
8c04fa72:	04 02       	R4 = CC;
8c04fa74:	04 0c       	CC = R4 == 0x0;
8c04fa76:	06 10       	IF !CC JUMP 0x0x8c04fa82;
8c04fa78:	3a 08       	CC = R2 == R7;
8c04fa7a:	00 60       	R0 = 0x0 (X);		/*		R0=0x3ff(1023) */
8c04fa7c:	03 10       	IF !CC JUMP 0x0x8c04fa82;
8c04fa7e:	48 08       	CC = P0 == P1;
8c04fa80:	10 02       	ILLEGAL;
8c04fa82:	09 6c       	P1 += 0x1;		/* (  1) */
8c04fa84:	40 43       	R0 = R0.B (Z);
8c04fa86:	00 0c       	CC = R0 == 0x0;
8c04fa88:	0a 60       	R2 = 0x1 (X);		/*		R2=0x75(117) */
8c04fa8a:	f2 18       	IF CC JUMP 0x0x8c04fc6e;
8c04fa8c:	50 43       	R0 = R2.B (Z);
8c04fa8e:	00 0c       	CC = R0 == 0x0;
8c04fa90:	e4 10       	IF !CC JUMP 0x0x8c04fc58;
8c04fa92:	42 99       	R2 = B[P0] (X);
8c04fa94:	48 32       	P1 = P0;
8c04fa96:	6f 61       	R7 = 0x2d (X);		/*		R7=0x0(  0) */
8c04fa98:	3a 08       	CC = R2 == R7;
8c04fa9a:	09 6c       	P1 += 0x1;		/* (  1) */
8c04fa9c:	c1 07       	IF CC P0 = P1;
8c04fa9e:	00 d8 80 11 	LdStAbs addr=0x11802160 control=0x0000;
8c04faa2:	60 21 00 00 
8c04faa6:	07 cc 00 c0 	R0 = -R0 (NS) || [FP + 0x10] = R2 || NOP;
8c04faaa:	3a b1 00 00 
8c04faae:	00 d8 80 11 	LdStAbs addr=0x11802168 control=0x0003;
8c04fab2:	68 21 03 00 
8c04fab6:	03 06       	IF !CC R0 = R3;
8c04fab8:	02 da cc cc 	R2=-858993459;
8c04fabc:	cd cc 00 00 
8c04fac0:	b1 c2 02 20 	R0 = R0 * R2 (TFU);
8c04fac4:	45 0a       	CC = P5 <= P0 (IU);
8c04fac6:	05 44       	P5 -= P0;
8c04fac8:	82 c6 e8 8f 	R7 = R0 >> 0x3;
8c04facc:	12 18       	IF CC JUMP 0x0x8c04faf0;
8c04face:	00 60       	R0 = 0x0 (X);		/*		R0=0x3ff(1023) */
8c04fad0:	84 61       	R4 = 0x30 (X);		/*		R4=0x45( 69) */
8c04fad2:	cd 61       	R5 = 0x39 (X);		/*		R5=0x45( 69) */
8c04fad4:	53 60       	R3 = 0xa (X);		/*		R3=0x65(101) */
8c04fad6:	a2 e0 0b 50 	LSETUP(0x8c04fada, 0x8c04faec) LC0 = P5;
8c04fada:	42 98       	R2 = B[P0++] (X);
8c04fadc:	a2 08       	CC = R2 < R4;
8c04fade:	58 18       	IF CC JUMP 0x0x8c04fb8e;
8c04fae0:	95 08       	CC = R5 < R2;
8c04fae2:	56 18       	IF CC JUMP 0x0x8c04fb8e;
8c04fae4:	07 0a       	CC = R7 <= R0 (IU);
8c04fae6:	49 18       	IF CC JUMP 0x0x8c04fb78;
8c04fae8:	d8 40       	R0 *= R3;
8c04faea:	82 66       	R2 += -0x30;		/* (-48) */
8c04faec:	10 50       	R0 = R0 + R2;
8c04faee:	30 30       	R6 = R0;
8c04faf0:	68 61       	R0 = 0x2d (X);		/*		R0=0x3ff(1023) */
8c04faf2:	39 a1       	R1 = [FP + 0x10];
8c04faf4:	01 08       	CC = R1 == R0;
8c04faf6:	30 18       	IF CC JUMP 0x0x8c04fb56;
8c04faf8:	00 d8 80 11 	LdStAbs addr=0x11802164 control=0x0000;
8c04fafc:	64 21 00 00 
8c04fb00:	06 0a       	CC = R6 <= R0 (IU);
8c04fb02:	12 10       	IF !CC JUMP 0x0x8c04fb26;
8c04fb04:	b8 a0       	R0 = [FP + 0x8];
8c04fb06:	ff e3 8e f7 	CALL 0x0x8c04ea22;
8c04fb0a:	56 30       	R2 = SP;
8c04fb0c:	63 61       	R3 = 0x2c (X);		/*		R3=0x65(101) */
8c04fb0e:	0e 30       	R1 = R6;
8c04fb10:	9a 51       	R6 = R2 + R3;
8c04fb12:	38 30       	R7 = R0;
8c04fb14:	06 30       	R0 = R6;
8c04fb16:	00 e3 c0 0a 	CALL 0x0x8c051096;
8c04fb1a:	07 30       	R0 = R7;
8c04fb1c:	0e 30       	R1 = R6;
8c04fb1e:	00 e3 f9 0f 	CALL 0x0x8c051b10;
8c04fb22:	06 30       	R0 = R6;
8c04fb24:	11 20       	JUMP.S 0x0x8c04fb46;
8c04fb26:	b8 a0       	R0 = [FP + 0x8];
8c04fb28:	ff e3 7d f7 	CALL 0x0x8c04ea22;
8c04fb2c:	56 30       	R2 = SP;
8c04fb2e:	63 61       	R3 = 0x2c (X);		/*		R3=0x65(101) */
8c04fb30:	0e 30       	R1 = R6;
8c04fb32:	9a 51       	R6 = R2 + R3;
8c04fb34:	38 30       	R7 = R0;
8c04fb36:	06 30       	R0 = R6;
8c04fb38:	00 e3 a3 0a 	CALL 0x0x8c05107e;
8c04fb3c:	07 30       	R0 = R7;
8c04fb3e:	0e 30       	R1 = R6;
8c04fb40:	00 e3 e8 0f 	CALL 0x0x8c051b10;
8c04fb44:	06 30       	R0 = R6;
8c04fb46:	00 e3 79 0f 	CALL 0x0x8c051a38;
8c04fb4a:	86 6c       	SP += 0x10;		/* ( 16) */
8c04fb4c:	a4 05       	(R7:4, P5:4) = [SP++];
8c04fb4e:	01 e8 00 00 	UNLINK;
8c04fb52:	08 60       	R0 = 0x1 (X);		/*		R0=0x3ff(1023) */
8c04fb54:	10 00       	RTS;
8c04fb56:	b8 a0       	R0 = [FP + 0x8];
8c04fb58:	ff e3 65 f7 	CALL 0x0x8c04ea22;
8c04fb5c:	56 30       	R2 = SP;
8c04fb5e:	63 61       	R3 = 0x2c (X);		/*		R3=0x65(101) */
8c04fb60:	b1 43       	R1 = -R6;
8c04fb62:	9a 51       	R6 = R2 + R3;
8c04fb64:	38 30       	R7 = R0;
8c04fb66:	06 30       	R0 = R6;
8c04fb68:	00 e3 97 0a 	CALL 0x0x8c051096;
8c04fb6c:	07 30       	R0 = R7;
8c04fb6e:	0e 30       	R1 = R6;
8c04fb70:	00 e3 d0 0f 	CALL 0x0x8c051b10;
8c04fb74:	06 30       	R0 = R6;
8c04fb76:	e8 2f       	JUMP.S 0x0x8c04fb46;
8c04fb78:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8c04fb7c:	f9 a0 b8 a0 
8c04fb80:	ff e3 62 fe 	CALL 0x0x8c04f844;
8c04fb84:	86 6c       	SP += 0x10;		/* ( 16) */
8c04fb86:	a4 05       	(R7:4, P5:4) = [SP++];
8c04fb88:	01 e8 00 00 	UNLINK;
8c04fb8c:	10 00       	RTS;
8c04fb8e:	7f 30       	R7 = FP;
8c04fb90:	27 67       	R7 += -0x1c;		/* (-28) */
8c04fb92:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R2 = [SP + 0x28] || NOP;
8c04fb96:	b2 a2 00 00 
8c04fb9a:	ff e3 38 f6 	CALL 0x0x8c04e80a;
8c04fb9e:	07 30       	R0 = R7;
8c04fba0:	17 30       	R2 = R7;
8c04fba2:	20 67       	R0 += -0x1c;		/* (-28) */
8c04fba4:	01 da 80 11 	R1=293608772;
8c04fba8:	44 1d 00 00 
8c04fbac:	ff e3 60 f9 	CALL 0x0x8c04ee6c;
8c04fbb0:	4f 30       	R1 = FP;
8c04fbb2:	41 66       	R1 += -0x38;		/* (-56) */
8c04fbb4:	01 30       	R0 = R1;
8c04fbb6:	20 67       	R0 += -0x1c;		/* (-28) */
8c04fbb8:	02 da 80 11 	R2=293609332;
8c04fbbc:	74 1f 00 00 
8c04fbc0:	ff e3 ea 7a 	CALL 0x0x8c03f194;
8c04fbc4:	67 61       	R7 = 0x2c (X);		/*		R7=0x0(  0) */
8c04fbc6:	01 68       	P1 = 0x0 (X);		/*		P1=0x0(  0) */
8c04fbc8:	5e 30       	R3 = SP;
8c04fbca:	04 cc 1f 02 	R1 = R3 + R7 (NS) || [SP + 0xc] = P1 || R2 = [FP + 0xc];
8c04fbce:	f1 bc fa a0 
8c04fbd2:	b8 a0       	R0 = [FP + 0x8];
8c04fbd4:	ff e3 58 fc 	CALL 0x0x8c04f484;
8c04fbd8:	84 60       	R4 = 0x10 (X);		/*		R4=0x45( 69) */
8c04fbda:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R1 = [FP -0x3c] || R0 = [SP + 0x30];
8c04fbde:	11 b9 30 a3 
8c04fbe2:	0c 0a       	CC = R4 <= R1 (IU);
8c04fbe4:	34 18       	IF CC JUMP 0x0x8c04fc4c;
8c04fbe6:	b6 e6 30 00 	B[SP + 0x30] = R6;
8c04fbea:	03 c8 00 18 	MNOP || R0 = [FP -0x20] || [FP -0x40] = R6;
8c04fbee:	80 b9 06 bb 
8c04fbf2:	04 0a       	CC = R4 <= R0 (IU);
8c04fbf4:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8c04fbf6:	03 c8 00 18 	MNOP || [FP -0x3c] = R7 || R0 = [FP -0x34];
8c04fbfa:	17 bb 30 b9 
8c04fbfe:	21 18       	IF CC JUMP 0x0x8c04fc40;
8c04fc00:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || [FP -0x20] = R7;
8c04fc04:	f0 b9 87 bb 
8c04fc08:	04 0a       	CC = R4 <= R0 (IU);
8c04fc0a:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP -0x24] = R6 || NOP;
8c04fc0e:	76 bb 00 00 
8c04fc12:	b6 e6 4c 00 	B[SP + 0x4c] = R6;
8c04fc16:	08 18       	IF CC JUMP 0x0x8c04fc26;
8c04fc18:	b6 e6 68 00 	B[SP + 0x68] = R6;
8c04fc1c:	86 6c       	SP += 0x10;		/* ( 16) */
8c04fc1e:	a4 05       	(R7:4, P5:4) = [SP++];
8c04fc20:	01 e8 00 00 	UNLINK;
8c04fc24:	10 00       	RTS;
8c04fc26:	a0 b9       	R0 = [FP -0x18];
8c04fc28:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04fc2c:	e4 e3 00 00 
8c04fc30:	b6 e6 68 00 	B[SP + 0x68] = R6;
8c04fc34:	86 6c       	SP += 0x10;		/* ( 16) */
8c04fc36:	05 30       	R0 = R5;
8c04fc38:	a4 05       	(R7:4, P5:4) = [SP++];
8c04fc3a:	01 e8 00 00 	UNLINK;
8c04fc3e:	10 00       	RTS;
8c04fc40:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04fc44:	e4 e3 00 00 
8c04fc48:	dc 2f       	JUMP.S 0x0x8c04fc00;
8c04fc4a:	00 00       	NOP;
8c04fc4c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04fc50:	e4 e3 00 00 
8c04fc54:	c9 2f       	JUMP.S 0x0x8c04fbe6;
8c04fc56:	00 00       	NOP;
8c04fc58:	03 c8 00 18 	MNOP || R1 = [FP + 0x10] || R0 = [FP + 0x8];
8c04fc5c:	39 a1 b8 a0 
8c04fc60:	ff e3 f2 fd 	CALL 0x0x8c04f844;
8c04fc64:	86 6c       	SP += 0x10;		/* ( 16) */
8c04fc66:	a4 05       	(R7:4, P5:4) = [SP++];
8c04fc68:	01 e8 00 00 	UNLINK;
8c04fc6c:	10 00       	RTS;
8c04fc6e:	63 99       	R3 = B[P4] (X);
8c04fc70:	70 61       	R0 = 0x2e (X);		/*		R0=0x3ff(1023) */
8c04fc72:	03 08       	CC = R3 == R0;
8c04fc74:	08 60       	R0 = 0x1 (X);		/*		R0=0x3ff(1023) */
8c04fc76:	0b 10       	IF !CC JUMP 0x0x8c04fc8c;
8c04fc78:	00 0c       	CC = R0 == 0x0;
8c04fc7a:	09 13       	IF !CC JUMP 0x0x8c04fa8c;
8c04fc7c:	68 61       	R0 = 0x2d (X);		/*		R0=0x3ff(1023) */
8c04fc7e:	03 08       	CC = R3 == R0;
8c04fc80:	02 60       	R2 = 0x0 (X);		/*		R2=0x75(117) */
8c04fc82:	05 13       	IF !CC JUMP 0x0x8c04fa8c;
8c04fc84:	60 08       	CC = P0 == P4;
8c04fc86:	12 02       	ILLEGAL;
8c04fc88:	02 2f       	JUMP.S 0x0x8c04fa8c;
8c04fc8a:	00 00       	NOP;
8c04fc8c:	20 e1 65 00 	R0 = 0x65 (X);		/*		R0=0x65(101) */
8c04fc90:	03 08       	CC = R3 == R0;
8c04fc92:	08 60       	R0 = 0x1 (X);		/*		R0=0x65(101) */
8c04fc94:	f2 1b       	IF CC JUMP 0x0x8c04fc78;
8c04fc96:	20 e1 45 00 	R0 = 0x45 (X);		/*		R0=0x45( 69) */
8c04fc9a:	03 08       	CC = R3 == R0;
8c04fc9c:	08 60       	R0 = 0x1 (X);		/*		R0=0x45( 69) */
8c04fc9e:	ed 1b       	IF CC JUMP 0x0x8c04fc78;
8c04fca0:	58 61       	R0 = 0x2b (X);		/*		R0=0x45( 69) */
8c04fca2:	03 08       	CC = R3 == R0;
8c04fca4:	00 02       	R0 = CC;
8c04fca6:	e9 2f       	JUMP.S 0x0x8c04fc78;
8c04fca8:	00 e8 0b 00 	LINK 0x2c;		/* (44) */
8c04fcac:	e3 05       	[--SP] = (R7:4, P5:3);
8c04fcae:	28 32       	P5 = R0;
8c04fcb0:	86 6f       	SP += -0x10;		/* (-16) */
8c04fcb2:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R3 = [FP + 0x18] || [SP + 0x2c] = R2;
8c04fcb6:	bb a1 f2 b2 
8c04fcba:	20 30       	R4 = R0;
8c04fcbc:	20 e1 58 00 	R0 = 0x58 (X);		/*		R0=0x58( 88) */
8c04fcc0:	ae e4 74 00 	R6 = B[P5 + 0x74] (Z);
8c04fcc4:	06 0c       	CC = R6 == 0x0;
8c04fcc6:	1f 07       	IF CC R3 = R7;
8c04fcc8:	29 30       	R5 = R1;
8c04fcca:	2a e6 12 00 	[P5 + 0x48] = R2;
8c04fcce:	04 50       	R0 = R4 + R0;
8c04fcd0:	2f e6 14 00 	[P5 + 0x50] = R7;
8c04fcd4:	2f e6 15 00 	[P5 + 0x54] = R7;
8c04fcd8:	ab e6 76 00 	B[P5 + 0x76] = R3;
8c04fcdc:	2d e6 11 00 	[P5 + 0x44] = R5;
8c04fce0:	2d e6 13 00 	[P5 + 0x4c] = R5;
8c04fce4:	01 da 80 11 	R1=293608776;
8c04fce8:	48 1d 00 00 
8c04fcec:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP + 0x10] = R0 || NOP;
8c04fcf0:	38 b1 00 00 
8c04fcf4:	ff e3 22 f5 	CALL 0x0x8c04e738;
8c04fcf8:	65 32       	P4 = P5;
8c04fcfa:	68 a2       	R0 = [P5 + 0x24];
8c04fcfc:	a4 6c       	P4 += 0x14;		/* ( 20) */
8c04fcfe:	00 0c       	CC = R0 == 0x0;
8c04fd00:	74 30       	R6 = P4;
8c04fd02:	07 18       	IF CC JUMP 0x0x8c04fd10;
8c04fd04:	06 30       	R0 = R6;
8c04fd06:	ff e3 3d fa 	CALL 0x0x8c04f180;
8c04fd0a:	20 a1       	R0 = [P4 + 0x10];
8c04fd0c:	00 0c       	CC = R0 == 0x0;
8c04fd0e:	fb 17       	IF !CC JUMP 0x0x8c04fd04 (BP);
8c04fd10:	e8 a1       	R0 = [P5 + 0x1c];
8c04fd12:	20 32       	P4 = R0;
8c04fd14:	00 0c       	CC = R0 == 0x0;
8c04fd16:	10 18       	IF CC JUMP 0x0x8c04fd36;
8c04fd18:	e1 6b       	P1 = -0x4 (X);		/*		P1=0x0(  0) */
8c04fd1a:	e1 5e       	P3 = P1 + (P4 << 0x2);
8c04fd1c:	a9 ad       	P1 = [P5 + 0x18];
8c04fd1e:	59 5a       	P1 = P1 + P3;
8c04fd20:	08 91       	R0 = [P1];
8c04fd22:	00 0c       	CC = R0 == 0x0;
8c04fd24:	05 18       	IF CC JUMP 0x0x8c04fd2e;
8c04fd26:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04fd2a:	e4 e3 00 00 
8c04fd2e:	fc 6f       	P4 += -0x1;		/* ( -1) */
8c04fd30:	44 0c       	CC = P4 == 0x0;
8c04fd32:	e3 6f       	P3 += -0x4;		/* ( -4) */
8c04fd34:	f4 17       	IF !CC JUMP 0x0x8c04fd1c (BP);
8c04fd36:	a8 a1       	R0 = [P5 + 0x18];
8c04fd38:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04fd3c:	e4 e3 00 00 
8c04fd40:	03 c8 00 18 	MNOP || [P5 + 0x18] = R7 || R2 = [FP + 0x14];
8c04fd44:	af b1 7a a1 
8c04fd48:	03 c8 00 18 	MNOP || R0 = [P5 + 0x10] || [P5 + 0x1c] = R7;
8c04fd4c:	28 a1 ef b1 
8c04fd50:	00 0c       	CC = R0 == 0x0;
8c04fd52:	08 32       	P1 = R0;
8c04fd54:	09 18       	IF CC JUMP 0x0x8c04fd66;
8c04fd56:	a2 e0 06 10 	LSETUP(0x8c04fd5a, 0x8c04fd62) LC0 = P1;
8c04fd5a:	f9 6f       	P1 += -0x1;		/* ( -1) */
8c04fd5c:	41 0c       	CC = P1 == 0x0;
8c04fd5e:	02 10       	IF !CC JUMP 0x0x8c04fd62;
8c04fd60:	ef b0       	[P5 + 0xc] = R7;
8c04fd62:	00 00       	NOP;
8c04fd64:	2f b1       	[P5 + 0x10] = R7;
8c04fd66:	04 30       	R0 = R4;
8c04fd68:	4f 30       	R1 = FP;
8c04fd6a:	ba b0       	[FP + 0x8] = R2;
8c04fd6c:	41 64       	R1 += 0x8;		/* (  8) */
8c04fd6e:	ff e3 3b fa 	CALL 0x0x8c04f1e4;
8c04fd72:	04 30       	R0 = R4;
8c04fd74:	77 30       	R6 = FP;
8c04fd76:	00 e3 23 06 	CALL 0x0x8c0509bc;
8c04fd7a:	c6 66       	R6 += -0x28;		/* (-40) */
8c04fd7c:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [FP + 0xc] = R0 || NOP;
8c04fd80:	f8 b0 00 00 
8c04fd84:	04 30       	R0 = R4;
8c04fd86:	ff e3 2b f8 	CALL 0x0x8c04eddc;
8c04fd8a:	a8 e4 76 00 	R0 = B[P5 + 0x76] (Z);
8c04fd8e:	00 0c       	CC = R0 == 0x0;
8c04fd90:	05 18       	IF CC JUMP 0x0x8c04fd9a;
8c04fd92:	28 e4 1b 00 	R0 = [P5 + 0x6c];
8c04fd96:	00 0c       	CC = R0 == 0x0;
8c04fd98:	4c 10       	IF !CC JUMP 0x0x8c04fe30;
8c04fd9a:	a9 e4 75 00 	R1 = B[P5 + 0x75] (Z);
8c04fd9e:	01 0c       	CC = R1 == 0x0;
8c04fda0:	f8 a0       	R0 = [FP + 0xc];
8c04fda2:	06 10       	IF !CC JUMP 0x0x8c04fdae;
8c04fda4:	86 6c       	SP += 0x10;		/* ( 16) */
8c04fda6:	a3 05       	(R7:4, P5:3) = [SP++];
8c04fda8:	01 e8 00 00 	UNLINK;
8c04fdac:	10 00       	RTS;
8c04fdae:	78 a1       	R0 = [FP + 0x14];
8c04fdb0:	00 e3 18 09 	CALL 0x0x8c050fe0;
8c04fdb4:	00 0c       	CC = R0 == 0x0;
8c04fdb6:	f8 a0       	R0 = [FP + 0xc];
8c04fdb8:	f6 17       	IF !CC JUMP 0x0x8c04fda4 (BP);
8c04fdba:	78 a1       	R0 = [FP + 0x14];
8c04fdbc:	00 e3 00 09 	CALL 0x0x8c050fbc;
8c04fdc0:	00 0c       	CC = R0 == 0x0;
8c04fdc2:	03 c8 00 18 	MNOP || R0 = [FP + 0xc] || R3 = [SP + 0x2c];
8c04fdc6:	f8 a0 f3 a2 
8c04fdca:	ed 17       	IF !CC JUMP 0x0x8c04fda4 (BP);
8c04fdcc:	75 b3       	[SP + 0x34] = R5;
8c04fdce:	6a 60       	R2 = 0xd (X);		/*		R2=0x75(117) */
8c04fdd0:	47 30       	R0 = FP;
8c04fdd2:	b3 b3       	[SP + 0x38] = R3;
8c04fdd4:	32 b3       	[SP + 0x30] = R2;
8c04fdd6:	20 67       	R0 += -0x1c;		/* (-28) */
8c04fdd8:	01 da 80 11 	R1=293609352;
8c04fddc:	88 1f 00 00 
8c04fde0:	ff e3 10 78 	CALL 0x0x8c03ee00;
8c04fde4:	0e 30       	R1 = R6;
8c04fde6:	01 68       	P1 = 0x0 (X);		/*		P1=0x0(  0) */
8c04fde8:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0xc] = P1 || NOP;
8c04fdec:	f1 bc 00 00 
8c04fdf0:	16 30       	R2 = R6;
8c04fdf2:	61 64       	R1 += 0xc;		/* ( 12) */
8c04fdf4:	ff e3 48 fb 	CALL 0x0x8c04f484;
8c04fdf8:	82 60       	R2 = 0x10 (X);		/*		R2=0x75(117) */
8c04fdfa:	f0 b9       	R0 = [FP -0x4];
8c04fdfc:	02 0a       	CC = R2 <= R0 (IU);
8c04fdfe:	09 18       	IF CC JUMP 0x0x8c04fe10;
8c04fe00:	b7 e6 40 00 	B[SP + 0x40] = R7;
8c04fe04:	86 6c       	SP += 0x10;		/* ( 16) */
8c04fe06:	a3 05       	(R7:4, P5:3) = [SP++];
8c04fe08:	01 e8 00 00 	UNLINK;
8c04fe0c:	00 60       	R0 = 0x0 (X);		/*		R0=0x58( 88) */
8c04fe0e:	10 00       	RTS;
8c04fe10:	a0 b9       	R0 = [FP -0x18];
8c04fe12:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c04fe16:	e4 e3 00 00 
8c04fe1a:	b7 e6 40 00 	B[SP + 0x40] = R7;
8c04fe1e:	86 6c       	SP += 0x10;		/* ( 16) */
8c04fe20:	a3 05       	(R7:4, P5:3) = [SP++];
8c04fe22:	01 e8 00 00 	UNLINK;
8c04fe26:	00 60       	R0 = 0x0 (X);		/*		R0=0x58( 88) */
8c04fe28:	10 00       	RTS;
8c04fe2a:	00 00       	NOP;
8c04fe2c:	00 00       	NOP;
8c04fe2e:	00 00       	NOP;
8c04fe30:	03 c8 00 18 	MNOP || R1 = [FP + 0x10] || R0 = [FP + 0x14];
8c04fe34:	39 a1 78 a1 
8c04fe38:	12 60       	R2 = 0x2 (X);		/*		R2=0x75(117) */
8c04fe3a:	00 e3 6e 17 	CALL 0x0x8c052d16;
8c04fe3e:	ae 2f       	JUMP.S 0x0x8c04fd9a;
8c04fe40:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04fe44:	ed 05       	[--SP] = (R7:5, P5:5);
8c04fe46:	28 32       	P5 = R0;
8c04fe48:	66 6f       	SP += -0x14;		/* (-20) */
8c04fe4a:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c04fe4e:	b8 00 03 00 
8c04fe52:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R3 || R5 = [SP + 0x38];
8c04fe56:	f3 b0 b5 a3 
8c04fe5a:	32 30       	R6 = R2;
8c04fe5c:	40 65       	R0 += 0x28;		/* ( 40) */
8c04fe5e:	02 60       	R2 = 0x0 (X);		/*		R2=0x75(117) */
8c04fe60:	ff e3 88 75 	CALL 0x0x8c03e970;
8c04fe64:	2a e4 10 00 	R2 = [P5 + 0x40];
8c04fe68:	83 60       	R3 = 0x10 (X);		/*		R3=0x65(101) */
8c04fe6a:	0f 30       	R1 = R7;
8c04fe6c:	13 0a       	CC = R3 <= R2 (IU);
8c04fe6e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R2 = [P5 + 0x3c] || NOP;
8c04fe72:	ea a3 00 00 
8c04fe76:	61 65       	R1 += 0x2c;		/* ( 44) */
8c04fe78:	03 10       	IF !CC JUMP 0x0x8c04fe7e;
8c04fe7a:	09 32       	P1 = R1;
8c04fe7c:	09 91       	R1 = [P1];
8c04fe7e:	35 b1       	[SP + 0x10] = R5;
8c04fe80:	04 cc 0a 04 	R2 = R1 + R2 (NS) || [SP + 0xc] = R6 || NOP;
8c04fe84:	f6 b0 00 00 
8c04fe88:	ff e3 10 ff 	CALL 0x0x8c04fca8;
8c04fe8c:	a6 6c       	SP += 0x14;		/* ( 20) */
8c04fe8e:	ad 05       	(R7:5, P5:5) = [SP++];
8c04fe90:	01 e8 00 00 	UNLINK;
8c04fe94:	10 00       	RTS;
8c04fe96:	00 00       	NOP;
8c04fe98:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c04fe9c:	e3 05       	[--SP] = (R7:4, P5:3);
8c04fe9e:	28 32       	P5 = R0;
8c04fea0:	86 6f       	SP += -0x10;		/* (-16) */
8c04fea2:	82 ce 02 ce 	R7 = ROT R2 BY 0x0 || [SP + 0x34] = R1 || NOP;
8c04fea6:	71 b3 00 00 
8c04feaa:	22 32       	P4 = R2;
8c04feac:	04 cc 00 40 	R0 = R0 - R0 (NS) || P1 = [SP + 0x34] || R1 = [P5];
8c04feb0:	71 af 29 91 
8c04feb4:	19 32       	P3 = R1;
8c04feb6:	0a 91       	R2 = [P1];
8c04feb8:	11 08       	CC = R1 == R2;
8c04feba:	2f 18       	IF CC JUMP 0x0x8c04ff18;
8c04febc:	00 0c       	CC = R0 == 0x0;
8c04febe:	26 10       	IF !CC JUMP 0x0x8c04ff0a;
8c04fec0:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || P0 = [P5 + 0x4] || R0 = [P3 + 0x8];
8c04fec4:	68 ac 98 a0 
8c04fec8:	08 32       	P1 = R0;
8c04feca:	04 cc 12 44 	R2 = R2 - R2 (NS) || R6 = [P4] || R5 = [P4 + 0x4];
8c04fece:	26 91 65 a0 
8c04fed2:	a4 a0       	R4 = [P4 + 0x8];
8c04fed4:	61 64       	R1 += 0xc;		/* ( 12) */
8c04fed6:	58 30       	R3 = P0;
8c04fed8:	18 0a       	CC = R0 <= R3 (IU);
8c04feda:	50 32       	P2 = P0;
8c04fedc:	08 44       	P0 -= P1;
8c04fede:	d0 07       	IF CC P2 = P0;
8c04fee0:	59 ac       	P1 = [P3 + 0x4];
8c04fee2:	51 5e       	P1 = P1 + (P2 << 0x2);
8c04fee4:	4b 91       	P3 = [P1];
8c04fee6:	1e 93       	[P3] = R6;
8c04fee8:	5d b0       	[P3 + 0x4] = R5;
8c04feea:	9c b0       	[P3 + 0x8] = R4;
8c04feec:	43 30       	R0 = P3;
8c04feee:	60 64       	R0 += 0xc;		/* ( 12) */
8c04fef0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c04fef4:	b8 00 03 00 
8c04fef8:	f3 b0       	[SP + 0xc] = R3;
8c04fefa:	ff e3 3b 75 	CALL 0x0x8c03e970;
8c04fefe:	a0 a2       	R0 = [P4 + 0x28];
8c04ff00:	98 b2       	[P3 + 0x28] = R0;
8c04ff02:	68 a0       	R0 = [P5 + 0x4];
8c04ff04:	08 64       	R0 += 0x1;		/* (  1) */
8c04ff06:	68 b0       	[P5 + 0x4] = R0;
8c04ff08:	d2 2f       	JUMP.S 0x0x8c04feac;
8c04ff0a:	86 6c       	SP += 0x10;		/* ( 16) */
8c04ff0c:	a3 05       	(R7:4, P5:3) = [SP++];
8c04ff0e:	01 e8 00 00 	UNLINK;
8c04ff12:	10 00       	RTS;
8c04ff14:	00 00       	NOP;
8c04ff16:	00 00       	NOP;
8c04ff18:	03 c8 00 18 	MNOP || R0 = [P5 + 0x4] || R1 = [P1 + 0x4];
8c04ff1c:	68 a0 49 a0 
8c04ff20:	08 08       	CC = R0 == R1;
8c04ff22:	00 02       	R0 = CC;
8c04ff24:	cc 2f       	JUMP.S 0x0x8c04febc;
8c04ff26:	00 00       	NOP;
8c04ff28:	00 e8 05 00 	LINK 0x14;		/* (20) */
8c04ff2c:	0a 32       	P1 = R2;
8c04ff2e:	fb 05       	[--SP] = (R7:7, P5:3);
8c04ff30:	01 32       	P0 = R1;
8c04ff32:	86 6f       	SP += -0x10;		/* (-16) */
8c04ff34:	03 c8 00 18 	MNOP || P4 = [FP + 0x14] || [SP + 0x20] = R0;
8c04ff38:	7c ad 30 b2 
8c04ff3c:	4a 91       	P2 = [P1];
8c04ff3e:	b2 be       	[SP + 0x28] = P2;
8c04ff40:	49 ac       	P1 = [P1 + 0x4];
8c04ff42:	62 91       	P2 = [P4];
8c04ff44:	43 91       	P3 = [P0];
8c04ff46:	71 be       	[SP + 0x24] = P1;
8c04ff48:	f2 be       	[SP + 0x2c] = P2;
8c04ff4a:	33 bf       	[SP + 0x30] = P3;
8c04ff4c:	45 ac       	P5 = [P0 + 0x4];
8c04ff4e:	64 ac       	P4 = [P4 + 0x4];
8c04ff50:	04 cc 00 40 	R0 = R0 - R0 (NS) || P1 = [SP + 0x30] || NOP;
8c04ff54:	31 af 00 00 
8c04ff58:	b0 ae       	P0 = [SP + 0x28];
8c04ff5a:	41 08       	CC = P1 == P0;
8c04ff5c:	4e 18       	IF CC JUMP 0x0x8c04fff8;
8c04ff5e:	09 68       	P1 = 0x1 (X);		/*		P1=0x0(  0) */
8c04ff60:	4c 5a       	P1 = P4 + P1;
8c04ff62:	08 68       	P0 = 0x1 (X);		/*		P0=0x0(  0) */
8c04ff64:	00 0c       	CC = R0 == 0x0;
8c04ff66:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP + 0x10] = P1 || NOP;
8c04ff6a:	39 bd 00 00 
8c04ff6e:	c5 5a       	P3 = P5 + P0;
8c04ff70:	39 10       	IF !CC JUMP 0x0x8c04ffe2;
8c04ff72:	f1 ae       	P1 = [SP + 0x2c];
8c04ff74:	30 af       	P0 = [SP + 0x30];
8c04ff76:	7c 30       	R7 = P4;
8c04ff78:	54 32       	P2 = P4;
8c04ff7a:	89 a0       	R1 = [P1 + 0x8];
8c04ff7c:	83 a0       	R3 = [P0 + 0x8];
8c04ff7e:	09 32       	P1 = R1;
8c04ff80:	03 32       	P0 = R3;
8c04ff82:	45 30       	R0 = P5;
8c04ff84:	39 0a       	CC = R1 <= R7 (IU);
8c04ff86:	0c 44       	P4 -= P1;
8c04ff88:	4d 32       	P1 = P5;
8c04ff8a:	05 44       	P5 -= P0;
8c04ff8c:	30 af       	P0 = [SP + 0x30];
8c04ff8e:	d4 07       	IF CC P2 = P4;
8c04ff90:	f4 ae       	P4 = [SP + 0x2c];
8c04ff92:	03 0a       	CC = R3 <= R0 (IU);
8c04ff94:	cd 07       	IF CC P1 = P5;
8c04ff96:	40 ac       	P0 = [P0 + 0x4];
8c04ff98:	64 ac       	P4 = [P4 + 0x4];
8c04ff9a:	6b 32       	P5 = P3;
8c04ff9c:	48 5e       	P1 = P0 + (P1 << 0x2);
8c04ff9e:	4b 91       	P3 = [P1];
8c04ffa0:	94 5e       	P2 = P4 + (P2 << 0x2);
8c04ffa2:	52 91       	P2 = [P2];
8c04ffa4:	3c ad       	P4 = [FP + 0x10];
8c04ffa6:	03 c8 00 18 	MNOP || [FP + 0x10] = P2 || R3 = [P3];
8c04ffaa:	3a bd 1b 91 
8c04ffae:	5f a0       	R7 = [P3 + 0x4];
8c04ffb0:	03 c8 00 18 	MNOP || [P2] = R3 || R3 = [P3 + 0x8];
8c04ffb4:	13 93 9b a0 
8c04ffb8:	57 b0       	[P2 + 0x4] = R7;
8c04ffba:	03 c8 00 18 	MNOP || [P2 + 0x8] = R3 || R0 = [FP + 0x10];
8c04ffbe:	93 b0 38 a1 
8c04ffc2:	4b 30       	R1 = P3;
8c04ffc4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c04ffc8:	b8 00 03 00 
8c04ffcc:	f3 b0       	[SP + 0xc] = R3;
8c04ffce:	60 64       	R0 += 0xc;		/* ( 12) */
8c04ffd0:	61 64       	R1 += 0xc;		/* ( 12) */
8c04ffd2:	ff e3 cf 74 	CALL 0x0x8c03e970;
8c04ffd6:	03 c8 00 18 	MNOP || P1 = [FP + 0x10] || R0 = [P3 + 0x28];
8c04ffda:	39 ad 98 a2 
8c04ffde:	88 b2       	[P1 + 0x28] = R0;
8c04ffe0:	b8 2f       	JUMP.S 0x0x8c04ff50;
8c04ffe2:	fc bc       	[FP + 0xc] = P4;
8c04ffe4:	30 ae       	P0 = [SP + 0x20];
8c04ffe6:	f1 ae       	P1 = [SP + 0x2c];
8c04ffe8:	f8 a0       	R0 = [FP + 0xc];
8c04ffea:	41 93       	[P0] = P1;
8c04ffec:	40 b0       	[P0 + 0x4] = R0;
8c04ffee:	86 6c       	SP += 0x10;		/* ( 16) */
8c04fff0:	bb 05       	(R7:7, P5:3) = [SP++];
8c04fff2:	01 e8 00 00 	UNLINK;
8c04fff6:	10 00       	RTS;
8c04fff8:	71 ae       	P1 = [SP + 0x24];
8c04fffa:	69 08       	CC = P1 == P5;
8c04fffc:	00 02       	R0 = CC;
8c04fffe:	b0 2f       	JUMP.S 0x0x8c04ff5e;
8c050000:	00 e8 05 00 	LINK 0x14;		/* (20) */
8c050004:	01 32       	P0 = R1;
8c050006:	fb 05       	[--SP] = (R7:7, P5:3);
8c050008:	86 6f       	SP += -0x10;		/* (-16) */
8c05000a:	0a 32       	P1 = R2;
8c05000c:	03 c8 00 18 	MNOP || P3 = [FP + 0x14] || [SP + 0x20] = R0;
8c050010:	7b ad 30 b2 
8c050014:	44 91       	P4 = [P0];
8c050016:	b4 be       	[SP + 0x28] = P4;
8c050018:	40 ac       	P0 = [P0 + 0x4];
8c05001a:	5c 91       	P4 = [P3];
8c05001c:	4d 91       	P5 = [P1];
8c05001e:	70 be       	[SP + 0x24] = P0;
8c050020:	34 bf       	[SP + 0x30] = P4;
8c050022:	5a ac       	P2 = [P3 + 0x4];
8c050024:	49 ac       	P1 = [P1 + 0x4];
8c050026:	04 cc 00 40 	R0 = R0 - R0 (NS) || P0 = [SP + 0x28] || NOP;
8c05002a:	b0 ae 00 00 
8c05002e:	fc 6b       	P4 = -0x1 (X);		/*		P4=0x0(  0) */
8c050030:	68 08       	CC = P0 == P5;
8c050032:	4c 18       	IF CC JUMP 0x0x8c0500ca;
8c050034:	f8 6b       	P0 = -0x1 (X);		/*		P0=0x0(  0) */
8c050036:	00 0c       	CC = R0 == 0x0;
8c050038:	01 5a       	P0 = P1 + P0;
8c05003a:	22 5b       	P4 = P2 + P4;
8c05003c:	3c 10       	IF !CC JUMP 0x0x8c0500b4;
8c05003e:	04 cc 12 44 	R2 = R2 - R2 (NS) || P2 = [SP + 0x30] || R7 = [P5 + 0x8];
8c050042:	32 af af a0 
8c050046:	3f b1       	[FP + 0x10] = R7;
8c050048:	5c 32       	P3 = P4;
8c05004a:	44 30       	R0 = P4;
8c05004c:	03 c8 00 18 	MNOP || R3 = [P2 + 0x8] || [SP + 0x2c] = P0;
8c050050:	93 a0 f0 be 
8c050054:	13 32       	P2 = R3;
8c050056:	03 0a       	CC = R3 <= R0 (IU);
8c050058:	48 30       	R1 = P0;
8c05005a:	48 32       	P1 = P0;
8c05005c:	14 44       	P4 -= P2;
8c05005e:	3a ad       	P2 = [FP + 0x10];
8c050060:	3b bd       	[FP + 0x10] = P3;
8c050062:	dc 07       	IF CC P3 = P4;
8c050064:	34 af       	P4 = [SP + 0x30];
8c050066:	0f 0a       	CC = R7 <= R1 (IU);
8c050068:	10 44       	P0 -= P2;
8c05006a:	c8 07       	IF CC P1 = P0;
8c05006c:	6a ac       	P2 = [P5 + 0x4];
8c05006e:	64 ac       	P4 = [P4 + 0x4];
8c050070:	4a 5e       	P1 = P2 + (P1 << 0x2);
8c050072:	1c 5f       	P4 = P4 + (P3 << 0x2);
8c050074:	4b 91       	P3 = [P1];
8c050076:	64 91       	P4 = [P4];
8c050078:	03 c8 00 18 	MNOP || R7 = [P3 + 0x4] || R3 = [P3];
8c05007c:	5f a0 1b 91 
8c050080:	03 c8 00 18 	MNOP || [P4 + 0x4] = R7 || R7 = [P3 + 0x8];
8c050084:	67 b0 9f a0 
8c050088:	23 93       	[P4] = R3;
8c05008a:	a7 b0       	[P4 + 0x8] = R7;
8c05008c:	4b 30       	R1 = P3;
8c05008e:	44 30       	R0 = P4;
8c050090:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c050094:	b8 00 03 00 
8c050098:	f3 b0       	[SP + 0xc] = R3;
8c05009a:	61 64       	R1 += 0xc;		/* ( 12) */
8c05009c:	60 64       	R0 += 0xc;		/* ( 12) */
8c05009e:	ff e3 69 74 	CALL 0x0x8c03e970;
8c0500a2:	03 c8 00 18 	MNOP || P2 = [FP + 0x10] || R0 = [P3 + 0x28];
8c0500a6:	3a ad 98 a2 
8c0500aa:	03 c8 00 18 	MNOP || P1 = [SP + 0x2c] || [P4 + 0x28] = R0;
8c0500ae:	f1 ae a0 b2 
8c0500b2:	ba 2f       	JUMP.S 0x0x8c050026;
8c0500b4:	fa bc       	[FP + 0xc] = P2;
8c0500b6:	30 ae       	P0 = [SP + 0x20];
8c0500b8:	31 af       	P1 = [SP + 0x30];
8c0500ba:	f8 a0       	R0 = [FP + 0xc];
8c0500bc:	41 93       	[P0] = P1;
8c0500be:	40 b0       	[P0 + 0x4] = R0;
8c0500c0:	86 6c       	SP += 0x10;		/* ( 16) */
8c0500c2:	bb 05       	(R7:7, P5:3) = [SP++];
8c0500c4:	01 e8 00 00 	UNLINK;
8c0500c8:	10 00       	RTS;
8c0500ca:	70 ae       	P0 = [SP + 0x24];
8c0500cc:	48 08       	CC = P0 == P1;
8c0500ce:	00 02       	R0 = CC;
8c0500d0:	b2 2f       	JUMP.S 0x0x8c050034;
8c0500d2:	00 00       	NOP;
8c0500d4:	00 e8 28 00 	LINK 0xa0;		/* (160) */
8c0500d8:	e4 05       	[--SP] = (R7:4, P5:4);
8c0500da:	86 6f       	SP += -0x10;		/* (-16) */
8c0500dc:	46 61       	R6 = 0x28 (X);		/*		R6=0x66(102) */
8c0500de:	5e 30       	R3 = SP;
8c0500e0:	20 32       	P4 = R0;
8c0500e2:	73 51       	R5 = R3 + R6;
8c0500e4:	39 30       	R7 = R1;
8c0500e6:	20 30       	R4 = R0;
8c0500e8:	05 30       	R0 = R5;
8c0500ea:	62 61       	R2 = 0x2c (X);		/*		R2=0x75(117) */
8c0500ec:	01 60       	R1 = 0x0 (X);		/*		R1=0xdbff(56319) */
8c0500ee:	00 de 02 04 	CALL.A 0x04022ea8;
8c0500f2:	a8 2e 00 00 
8c0500f6:	03 60       	R3 = 0x0 (X);		/*		R3=0x65(101) */
8c0500f8:	b3 e6 38 00 	B[SP + 0x38] = R3;
8c0500fc:	04 cc 00 40 	R0 = R0 - R0 (NS) || R6 = [P4 + 0x10] || NOP;
8c050100:	26 a1 00 00 
8c050104:	7a 60       	R2 = 0xf (X);		/*		R2=0x75(117) */
8c050106:	be 09       	CC = R6 < R7 (IU);
8c050108:	30 e6 12 00 	[SP + 0x48] = R0;
8c05010c:	04 cc 3e 40 	R0 = R7 - R6 (NS) || [FP -0x7c] = R2 || NOP;
8c050110:	12 ba 00 00 
8c050114:	e0 10       	IF !CC JUMP 0x0x8c0502d4;
8c050116:	00 0c       	CC = R0 == 0x0;
8c050118:	94 18       	IF CC JUMP 0x0x8c050240;
8c05011a:	ff 67       	R7 += -0x1;		/* ( -1) */
8c05011c:	f7 53       	R7 = R7 - R6;
8c05011e:	07 0c       	CC = R7 == 0x0;
8c050120:	0e 30       	R1 = R6;
8c050122:	23 18       	IF CC JUMP 0x0x8c050168;
8c050124:	06 30       	R0 = R6;
8c050126:	08 64       	R0 += 0x1;		/* (  1) */
8c050128:	a1 a0       	R1 = [P4 + 0x8];
8c05012a:	01 0a       	CC = R1 <= R0 (IU);
8c05012c:	83 18       	IF CC JUMP 0x0x8c050232;
8c05012e:	e1 ac       	P1 = [P4 + 0xc];
8c050130:	20 ad       	P0 = [P4 + 0x10];
8c050132:	41 5b       	P5 = P1 + P0;
8c050134:	45 30       	R0 = P5;
8c050136:	01 0a       	CC = R1 <= R0 (IU);
8c050138:	03 10       	IF !CC JUMP 0x0x8c05013e;
8c05013a:	a1 ac       	P1 = [P4 + 0x8];
8c05013c:	0d 44       	P5 -= P1;
8c05013e:	61 ac       	P1 = [P4 + 0x4];
8c050140:	29 5e       	P0 = P1 + (P5 << 0x2);
8c050142:	00 91       	R0 = [P0];
8c050144:	00 0c       	CC = R0 == 0x0;
8c050146:	6c 18       	IF CC JUMP 0x0x8c05021e;
8c050148:	69 5e       	P1 = P1 + (P5 << 0x2);
8c05014a:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || R0 = [P1] || NOP;
8c05014e:	08 91 00 00 
8c050152:	00 0c       	CC = R0 == 0x0;
8c050154:	03 18       	IF CC JUMP 0x0x8c05015a;
8c050156:	ff e3 65 f6 	CALL 0x0x8c04ee20;
8c05015a:	ff 67       	R7 += -0x1;		/* ( -1) */
8c05015c:	07 0c       	CC = R7 == 0x0;
8c05015e:	20 a1       	R0 = [P4 + 0x10];
8c050160:	08 64       	R0 += 0x1;		/* (  1) */
8c050162:	20 b1       	[P4 + 0x10] = R0;
8c050164:	e1 17       	IF !CC JUMP 0x0x8c050126 (BP);
8c050166:	21 a1       	R1 = [P4 + 0x10];
8c050168:	09 64       	R1 += 0x1;		/* (  1) */
8c05016a:	a0 a0       	R0 = [P4 + 0x8];
8c05016c:	08 0a       	CC = R0 <= R1 (IU);
8c05016e:	52 18       	IF CC JUMP 0x0x8c050212;
8c050170:	e1 ac       	P1 = [P4 + 0xc];
8c050172:	20 ad       	P0 = [P4 + 0x10];
8c050174:	41 5b       	P5 = P1 + P0;
8c050176:	4d 30       	R1 = P5;
8c050178:	08 0a       	CC = R0 <= R1 (IU);
8c05017a:	03 10       	IF !CC JUMP 0x0x8c050180;
8c05017c:	a1 ac       	P1 = [P4 + 0x8];
8c05017e:	0d 44       	P5 -= P1;
8c050180:	61 ac       	P1 = [P4 + 0x4];
8c050182:	29 5e       	P0 = P1 + (P5 << 0x2);
8c050184:	00 91       	R0 = [P0];
8c050186:	00 0c       	CC = R0 == 0x0;
8c050188:	3b 18       	IF CC JUMP 0x0x8c0501fe;
8c05018a:	69 5e       	P1 = P1 + (P5 << 0x2);
8c05018c:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || R0 = [P1] || NOP;
8c050190:	08 91 00 00 
8c050194:	00 0c       	CC = R0 == 0x0;
8c050196:	03 18       	IF CC JUMP 0x0x8c05019c;
8c050198:	ff e3 44 f6 	CALL 0x0x8c04ee20;
8c05019c:	20 e1 60 00 	R0 = 0x60 (X);		/*		R0=0x60( 96) */
8c0501a0:	82 ce 05 c4 	R2 = ROT R5 BY 0x0 || [FP -0x40] = P4 || NOP;
8c0501a4:	0c bb 00 00 
8c0501a8:	04 cc 28 00 	R0 = R5 + R0 (NS) || R1 = [P4 + 0x10] || R3 = [P4 + 0xc];
8c0501ac:	21 a1 e3 a0 
8c0501b0:	04 cc 33 06 	R3 = R6 + R3 (NS) || [FP -0x48] = P4 || NOP;
8c0501b4:	ec ba 00 00 
8c0501b8:	09 64       	R1 += 0x1;		/* (  1) */
8c0501ba:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [P4 + 0x10] = R1 || NOP;
8c0501be:	21 b1 00 00 
8c0501c2:	f3 ba       	[FP -0x44] = R3;
8c0501c4:	13 bb       	[FP -0x3c] = R3;
8c0501c6:	c0 67       	R0 += -0x8;		/* ( -8) */
8c0501c8:	ff e3 68 fe 	CALL 0x0x8c04fe98;
8c0501cc:	10 b8       	R0 = [FP -0x7c];
8c0501ce:	81 60       	R1 = 0x10 (X);		/*		R1=0xdbff(56319) */
8c0501d0:	01 0a       	CC = R1 <= R0 (IU);
8c0501d2:	09 18       	IF CC JUMP 0x0x8c0501e4;
8c0501d4:	00 60       	R0 = 0x0 (X);		/*		R0=0x60( 96) */
8c0501d6:	b0 e6 38 00 	B[SP + 0x38] = R0;
8c0501da:	86 6c       	SP += 0x10;		/* ( 16) */
8c0501dc:	a4 05       	(R7:4, P5:4) = [SP++];
8c0501de:	01 e8 00 00 	UNLINK;
8c0501e2:	10 00       	RTS;
8c0501e4:	b0 a3       	R0 = [SP + 0x38];
8c0501e6:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0501ea:	e4 e3 00 00 
8c0501ee:	00 60       	R0 = 0x0 (X);		/*		R0=0x60( 96) */
8c0501f0:	b0 e6 38 00 	B[SP + 0x38] = R0;
8c0501f4:	86 6c       	SP += 0x10;		/* ( 16) */
8c0501f6:	a4 05       	(R7:4, P5:4) = [SP++];
8c0501f8:	01 e8 00 00 	UNLINK;
8c0501fc:	10 00       	RTS;
8c0501fe:	60 61       	R0 = 0x2c (X);		/*		R0=0x60( 96) */
8c050200:	00 de 4c 8d 	CALL.A 0x8d4ce3d4;
8c050204:	d4 e3 00 00 
8c050208:	61 ac       	P1 = [P4 + 0x4];
8c05020a:	69 5e       	P1 = P1 + (P5 << 0x2);
8c05020c:	08 93       	[P1] = R0;
8c05020e:	61 ac       	P1 = [P4 + 0x4];
8c050210:	bd 2f       	JUMP.S 0x0x8c05018a;
8c050212:	04 30       	R0 = R4;
8c050214:	09 60       	R1 = 0x1 (X);		/*		R1=0xdbff(56319) */
8c050216:	ff e3 af f8 	CALL 0x0x8c04f374;
8c05021a:	a0 a0       	R0 = [P4 + 0x8];
8c05021c:	aa 2f       	JUMP.S 0x0x8c050170;
8c05021e:	60 61       	R0 = 0x2c (X);		/*		R0=0x60( 96) */
8c050220:	00 de 4c 8d 	CALL.A 0x8d4ce3d4;
8c050224:	d4 e3 00 00 
8c050228:	61 ac       	P1 = [P4 + 0x4];
8c05022a:	69 5e       	P1 = P1 + (P5 << 0x2);
8c05022c:	08 93       	[P1] = R0;
8c05022e:	61 ac       	P1 = [P4 + 0x4];
8c050230:	8c 2f       	JUMP.S 0x0x8c050148;
8c050232:	04 30       	R0 = R4;
8c050234:	09 60       	R1 = 0x1 (X);		/*		R1=0xdbff(56319) */
8c050236:	ff e3 9f f8 	CALL 0x0x8c04f374;
8c05023a:	a1 a0       	R1 = [P4 + 0x8];
8c05023c:	79 2f       	JUMP.S 0x0x8c05012e;
8c05023e:	00 00       	NOP;
8c050240:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || R4 = [P4 + 0xc] || NOP;
8c050244:	e4 a0 00 00 
8c050248:	0d 30       	R1 = R5;
8c05024a:	60 65       	R0 += 0x2c;		/* ( 44) */
8c05024c:	ff e3 ea f5 	CALL 0x0x8c04ee20;
8c050250:	57 30       	R2 = FP;
8c050252:	02 67       	R2 += -0x20;		/* (-32) */
8c050254:	04 cc 34 0c 	R6 = R6 + R4 (NS) || [SP + 0xc] = R2 || NOP;
8c050258:	f2 b0 00 00 
8c05025c:	c2 67       	R2 += -0x8;		/* ( -8) */
8c05025e:	82 ce 02 c2 	R1 = ROT R2 BY 0x0 || [FP -0x20] = P4 || NOP;
8c050262:	8c bb 00 00 
8c050266:	c1 67       	R1 += -0x8;		/* ( -8) */
8c050268:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || [FP -0x30] = P4 || NOP;
8c05026c:	4c bb 00 00 
8c050270:	6c bb       	[FP -0x28] = P4;
8c050272:	56 bb       	[FP -0x2c] = R6;
8c050274:	76 bb       	[FP -0x24] = R6;
8c050276:	96 bb       	[FP -0x1c] = R6;
8c050278:	c0 67       	R0 += -0x8;		/* ( -8) */
8c05027a:	ff e3 c3 fe 	CALL 0x0x8c050000;
8c05027e:	7e 30       	R7 = SP;
8c050280:	23 e1 54 00 	R3 = 0x54 (X);		/*		R3=0x54( 84) */
8c050284:	04 cc 3b 04 	R2 = R7 + R3 (NS) || [FP -0x20] = P4 || NOP;
8c050288:	8c bb 00 00 
8c05028c:	25 e1 4c 00 	R5 = 0x4c (X);		/*		R5=0x4c( 76) */
8c050290:	04 cc 15 02 	R1 = R2 + R5 (NS) || [FP -0x1c] = R6 || NOP;
8c050294:	96 bb 00 00 
8c050298:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || [FP -0x24] = R6 || NOP;
8c05029c:	76 bb 00 00 
8c0502a0:	6c bb       	[FP -0x28] = P4;
8c0502a2:	40 64       	R0 += 0x8;		/* (  8) */
8c0502a4:	ff e3 fa fd 	CALL 0x0x8c04fe98;
8c0502a8:	c0 b8       	R0 = [FP -0x50];
8c0502aa:	83 60       	R3 = 0x10 (X);		/*		R3=0x54( 84) */
8c0502ac:	03 0a       	CC = R3 <= R0 (IU);
8c0502ae:	0d 18       	IF CC JUMP 0x0x8c0502c8;
8c0502b0:	7b 60       	R3 = 0xf (X);		/*		R3=0x54( 84) */
8c0502b2:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x50] = R3 || R0 = [FP -0x7c];
8c0502b6:	c3 ba 10 b8 
8c0502ba:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP -0x54] = R2 || NOP;
8c0502be:	b2 ba 00 00 
8c0502c2:	b1 e6 64 00 	B[SP + 0x64] = R1;
8c0502c6:	84 2f       	JUMP.S 0x0x8c0501ce;
8c0502c8:	70 b8       	R0 = [FP -0x64];
8c0502ca:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0502ce:	e4 e3 00 00 
8c0502d2:	ef 2f       	JUMP.S 0x0x8c0502b0;
8c0502d4:	b7 09       	CC = R7 < R6 (IU);
8c0502d6:	78 60       	R0 = 0xf (X);		/*		R0=0x60( 96) */
8c0502d8:	7b 13       	IF !CC JUMP 0x0x8c0501ce;
8c0502da:	47 30       	R0 = FP;
8c0502dc:	5f 30       	R3 = FP;
8c0502de:	c0 67       	R0 += -0x8;		/* ( -8) */
8c0502e0:	43 64       	R3 += 0x8;		/* (  8) */
8c0502e2:	82 ce 00 c4 	R2 = ROT R0 BY 0x0 || R1 = [P4 + 0xc] || [SP + 0xc] = R3;
8c0502e6:	e1 a0 f3 b0 
8c0502ea:	c0 67       	R0 += -0x8;		/* ( -8) */
8c0502ec:	04 cc 0e 06 	R3 = R1 + R6 (NS) || [FP -0x10] = P4 || NOP;
8c0502f0:	cc bb 00 00 
8c0502f4:	04 cc 39 0a 	R5 = R7 + R1 (NS) || [FP + 0x8] = P4 || NOP;
8c0502f8:	bc bc 00 00 
8c0502fc:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [FP + 0xc] = R5 || NOP;
8c050300:	fd b0 00 00 
8c050304:	04 cc 1d 4a 	R5 = R3 - R5 (NS) || [FP -0x8] = P4 || NOP;
8c050308:	ec bb 00 00 
8c05030c:	f3 bb       	[FP -0x4] = R3;
8c05030e:	d3 bb       	[FP -0xc] = R3;
8c050310:	c0 67       	R0 += -0x8;		/* ( -8) */
8c050312:	ff e3 0b fe 	CALL 0x0x8c04ff28;
8c050316:	05 0c       	CC = R5 == 0x0;
8c050318:	0f 18       	IF CC JUMP 0x0x8c050336;
8c05031a:	f8 63       	R0 = -0x1 (X);		/*		R0=0x60( 96) */
8c05031c:	38 52       	R0 = R0 - R7;
8c05031e:	c6 51       	R7 = R6 + R0;
8c050320:	07 0c       	CC = R7 == 0x0;
8c050322:	07 18       	IF CC JUMP 0x0x8c050330;
8c050324:	ff 67       	R7 += -0x1;		/* ( -1) */
8c050326:	04 30       	R0 = R4;
8c050328:	ff e3 2c f7 	CALL 0x0x8c04f180;
8c05032c:	07 0c       	CC = R7 == 0x0;
8c05032e:	fb 17       	IF !CC JUMP 0x0x8c050324 (BP);
8c050330:	04 30       	R0 = R4;
8c050332:	ff e3 27 f7 	CALL 0x0x8c04f180;
8c050336:	10 b8       	R0 = [FP -0x7c];
8c050338:	4b 2f       	JUMP.S 0x0x8c0501ce;
8c05033a:	00 00       	NOP;
8c05033c:	00 e8 03 00 	LINK 0xc;		/* (12) */
8c050340:	68 05       	[--SP] = (R7:5);
8c050342:	38 30       	R7 = R0;
8c050344:	0f 32       	P1 = R7;
8c050346:	a6 6f       	SP += -0xc;		/* (-12) */
8c050348:	31 30       	R6 = R1;
8c05034a:	4d a2       	R5 = [P1 + 0x24];
8c05034c:	4f 30       	R1 = FP;
8c05034e:	a1 67       	R1 += -0xc;		/* (-12) */
8c050350:	07 30       	R0 = R7;
8c050352:	ff e3 93 f4 	CALL 0x0x8c04ec78;
8c050356:	00 0c       	CC = R0 == 0x0;
8c050358:	13 18       	IF CC JUMP 0x0x8c05037e;
8c05035a:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || R0 = [SP + 0x18] || NOP;
8c05035e:	b0 a1 00 00 
8c050362:	06 08       	CC = R6 == R0;
8c050364:	03 18       	IF CC JUMP 0x0x8c05036a;
8c050366:	00 0c       	CC = R0 == 0x0;
8c050368:	f2 17       	IF !CC JUMP 0x0x8c05034c (BP);
8c05036a:	a7 64       	R7 += 0x14;		/* ( 20) */
8c05036c:	07 30       	R0 = R7;
8c05036e:	ff e3 b3 fe 	CALL 0x0x8c0500d4;
8c050372:	66 6c       	SP += 0xc;		/* ( 12) */
8c050374:	28 05       	(R7:5) = [SP++];
8c050376:	01 e8 00 00 	UNLINK;
8c05037a:	00 60       	R0 = 0x0 (X);		/*		R0=0x60( 96) */
8c05037c:	10 00       	RTS;
8c05037e:	07 30       	R0 = R7;
8c050380:	a0 64       	R0 += 0x14;		/* ( 20) */
8c050382:	0d 30       	R1 = R5;
8c050384:	ff e3 a8 fe 	CALL 0x0x8c0500d4;
8c050388:	e9 2f       	JUMP.S 0x0x8c05035a;
8c05038a:	00 00       	NOP;
8c05038c:	00 e8 05 00 	LINK 0x14;		/* (20) */
8c050390:	01 68       	P1 = 0x0 (X);		/*		P1=0x0(  0) */
8c050392:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0x10] = R7 || NOP;
8c050396:	37 b1 00 00 
8c05039a:	f1 bc       	[SP + 0xc] = P1;
8c05039c:	ff e3 74 f8 	CALL 0x0x8c04f484;
8c0503a0:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x28] || NOP;
8c0503a4:	b1 a2 00 00 
8c0503a8:	ff e3 ca ff 	CALL 0x0x8c05033c;
8c0503ac:	37 a1       	R7 = [SP + 0x10];
8c0503ae:	01 e8 00 00 	UNLINK;
8c0503b2:	10 00       	RTS;
8c0503b4:	00 e8 0d 00 	LINK 0x34;		/* (52) */
8c0503b8:	e5 05       	[--SP] = (R7:4, P5:5);
8c0503ba:	86 6f       	SP += -0x10;		/* (-16) */
8c0503bc:	77 30       	R6 = FP;
8c0503be:	28 32       	P5 = R0;
8c0503c0:	20 30       	R4 = R0;
8c0503c2:	38 30       	R7 = R0;
8c0503c4:	ff e3 2f f3 	CALL 0x0x8c04ea22;
8c0503c8:	66 66       	R6 += -0x34;		/* (-52) */
8c0503ca:	28 30       	R5 = R0;
8c0503cc:	06 30       	R0 = R6;
8c0503ce:	31 60       	R1 = 0x6 (X);		/*		R1=0xdbff(56319) */
8c0503d0:	00 e3 34 16 	CALL 0x0x8c053038;
8c0503d4:	05 30       	R0 = R5;
8c0503d6:	0e 30       	R1 = R6;
8c0503d8:	00 e3 9c 0b 	CALL 0x0x8c051b10;
8c0503dc:	06 30       	R0 = R6;
8c0503de:	00 e3 2d 0b 	CALL 0x0x8c051a38;
8c0503e2:	04 30       	R0 = R4;
8c0503e4:	ff e3 f5 f0 	CALL 0x0x8c04e5ce;
8c0503e8:	29 e5 13 00 	P1 = [P5 + 0x4c];
8c0503ec:	20 e1 5d 00 	R0 = 0x5d (X);		/*		R0=0x5d( 93) */
8c0503f0:	66 60       	R6 = 0xc (X);		/*		R6=0x66(102) */
8c0503f2:	49 99       	R1 = B[P1] (X);
8c0503f4:	01 08       	CC = R1 == R0;
8c0503f6:	6e 18       	IF CC JUMP 0x0x8c0504d2;
8c0503f8:	04 60       	R4 = 0x0 (X);		/*		R4=0x45( 69) */
8c0503fa:	07 30       	R0 = R7;
8c0503fc:	ff e3 13 f3 	CALL 0x0x8c04ea22;
8c050400:	0c 30       	R1 = R4;
8c050402:	00 e3 71 16 	CALL 0x0x8c0530e4;
8c050406:	4f 30       	R1 = FP;
8c050408:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP + 0x8] = R0 || NOP;
8c05040c:	b8 b0 00 00 
8c050410:	41 64       	R1 += 0x8;		/* (  8) */
8c050412:	ff e3 e9 f6 	CALL 0x0x8c04f1e4;
8c050416:	07 30       	R0 = R7;
8c050418:	00 e3 d2 02 	CALL 0x0x8c0509bc;
8c05041c:	29 a1       	R1 = [P5 + 0x10];
8c05041e:	01 0c       	CC = R1 == 0x0;
8c050420:	06 18       	IF CC JUMP 0x0x8c05042c;
8c050422:	f9 67       	R1 += -0x1;		/* ( -1) */
8c050424:	01 0c       	CC = R1 == 0x0;
8c050426:	29 b1       	[P5 + 0x10] = R1;
8c050428:	02 10       	IF !CC JUMP 0x0x8c05042c;
8c05042a:	e9 b0       	[P5 + 0xc] = R1;
8c05042c:	00 0c       	CC = R0 == 0x0;
8c05042e:	0c 64       	R4 += 0x1;		/* (  1) */
8c050430:	48 18       	IF CC JUMP 0x0x8c0504c0;
8c050432:	6f 30       	R5 = FP;
8c050434:	c5 66       	R5 += -0x28;		/* (-40) */
8c050436:	07 30       	R0 = R7;
8c050438:	0d 30       	R1 = R5;
8c05043a:	ff e3 1f f4 	CALL 0x0x8c04ec78;
8c05043e:	31 a3       	R1 = [SP + 0x30];
8c050440:	31 08       	CC = R1 == R6;
8c050442:	03 10       	IF !CC JUMP 0x0x8c050448;
8c050444:	00 0c       	CC = R0 == 0x0;
8c050446:	f6 17       	IF !CC JUMP 0x0x8c050432 (BP);
8c050448:	00 0c       	CC = R0 == 0x0;
8c05044a:	0b 18       	IF CC JUMP 0x0x8c050460;
8c05044c:	30 a3       	R0 = [SP + 0x30];
8c05044e:	21 60       	R1 = 0x4 (X);		/*		R1=0xdbff(56319) */
8c050450:	08 08       	CC = R0 == R1;
8c050452:	d4 17       	IF !CC JUMP 0x0x8c0503fa (BP);
8c050454:	86 6c       	SP += 0x10;		/* ( 16) */
8c050456:	a5 05       	(R7:4, P5:5) = [SP++];
8c050458:	01 e8 00 00 	UNLINK;
8c05045c:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c05045e:	10 00       	RTS;
8c050460:	47 30       	R0 = FP;
8c050462:	20 67       	R0 += -0x1c;		/* (-28) */
8c050464:	01 da 80 11 	R1=293609420;
8c050468:	cc 1f 00 00 
8c05046c:	ff e3 ca 74 	CALL 0x0x8c03ee00;
8c050470:	07 30       	R0 = R7;
8c050472:	0d 30       	R1 = R5;
8c050474:	61 64       	R1 += 0xc;		/* ( 12) */
8c050476:	21 68       	P1 = 0x4 (X);		/*		P1=0x0(  0) */
8c050478:	82 ce 05 c4 	R2 = ROT R5 BY 0x0 || [SP + 0xc] = P1 || NOP;
8c05047c:	f1 bc 00 00 
8c050480:	ff e3 86 ff 	CALL 0x0x8c05038c;
8c050484:	81 60       	R1 = 0x10 (X);		/*		R1=0xdbff(56319) */
8c050486:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x4] || NOP;
8c05048a:	f0 b9 00 00 
8c05048e:	01 0a       	CC = R1 <= R0 (IU);
8c050490:	0a 18       	IF CC JUMP 0x0x8c0504a4;
8c050492:	01 60       	R1 = 0x0 (X);		/*		R1=0xdbff(56319) */
8c050494:	b1 e6 40 00 	B[SP + 0x40] = R1;
8c050498:	86 6c       	SP += 0x10;		/* ( 16) */
8c05049a:	07 30       	R0 = R7;
8c05049c:	a5 05       	(R7:4, P5:5) = [SP++];
8c05049e:	01 e8 00 00 	UNLINK;
8c0504a2:	10 00       	RTS;
8c0504a4:	a0 b9       	R0 = [FP -0x18];
8c0504a6:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0504aa:	e4 e3 00 00 
8c0504ae:	01 60       	R1 = 0x0 (X);		/*		R1=0xdbff(56319) */
8c0504b0:	b1 e6 40 00 	B[SP + 0x40] = R1;
8c0504b4:	86 6c       	SP += 0x10;		/* ( 16) */
8c0504b6:	07 30       	R0 = R7;
8c0504b8:	a5 05       	(R7:4, P5:5) = [SP++];
8c0504ba:	01 e8 00 00 	UNLINK;
8c0504be:	10 00       	RTS;
8c0504c0:	07 30       	R0 = R7;
8c0504c2:	21 60       	R1 = 0x4 (X);		/*		R1=0xdbff(56319) */
8c0504c4:	ff e3 3c ff 	CALL 0x0x8c05033c;
8c0504c8:	86 6c       	SP += 0x10;		/* ( 16) */
8c0504ca:	a5 05       	(R7:4, P5:5) = [SP++];
8c0504cc:	01 e8 00 00 	UNLINK;
8c0504d0:	10 00       	RTS;
8c0504d2:	4f 30       	R1 = FP;
8c0504d4:	04 30       	R0 = R4;
8c0504d6:	c1 66       	R1 += -0x28;		/* (-40) */
8c0504d8:	ff e3 d0 f3 	CALL 0x0x8c04ec78;
8c0504dc:	86 6c       	SP += 0x10;		/* ( 16) */
8c0504de:	a5 05       	(R7:4, P5:5) = [SP++];
8c0504e0:	01 e8 00 00 	UNLINK;
8c0504e4:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c0504e6:	10 00       	RTS;
8c0504e8:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c0504ec:	f4 05       	[--SP] = (R7:6, P5:4);
8c0504ee:	28 32       	P5 = R0;
8c0504f0:	39 30       	R7 = R1;
8c0504f2:	21 e1 7f 00 	R1 = 0x7f (X);		/*		R1=0x7f(127) */
8c0504f6:	a6 6f       	SP += -0xc;		/* (-12) */
8c0504f8:	02 60       	R2 = 0x0 (X);		/*		R2=0x75(117) */
8c0504fa:	7e 60       	R6 = 0xf (X);		/*		R6=0x66(102) */
8c0504fc:	0f 0a       	CC = R7 <= R1 (IU);
8c0504fe:	6a b1       	[P5 + 0x14] = R2;
8c050500:	aa e6 04 00 	B[P5 + 0x4] = R2;
8c050504:	ae b1       	[P5 + 0x18] = R6;
8c050506:	94 18       	IF CC JUMP 0x0x8c05062e;
8c050508:	21 e1 ff 07 	R1 = 0x7ff (X);		/*		R1=0x7ff(2047) */
8c05050c:	0f 0a       	CC = R7 <= R1 (IU);
8c05050e:	70 18       	IF CC JUMP 0x0x8c0505ee;
8c050510:	81 e1 ff ff 	R1 = 0xffff (Z);		/*		R1=0xffff(65535) */
8c050514:	0f 0a       	CC = R7 <= R1 (IU);
8c050516:	42 18       	IF CC JUMP 0x0x8c05059a;
8c050518:	01 da 10 00 	R1=1114111;
8c05051c:	ff ff 00 00 
8c050520:	0f 0a       	CC = R7 <= R1 (IU);
8c050522:	06 18       	IF CC JUMP 0x0x8c05052e;
8c050524:	66 6c       	SP += 0xc;		/* ( 12) */
8c050526:	b4 05       	(R7:6, P5:4) = [SP++];
8c050528:	01 e8 00 00 	UNLINK;
8c05052c:	10 00       	RTS;
8c05052e:	21 60       	R1 = 0x4 (X);		/*		R1=0xffff(65535) */
8c050530:	ff e3 86 72 	CALL 0x0x8c03ea3c;
8c050534:	45 32       	P0 = P5;
8c050536:	25 6c       	P5 += 0x4;		/* (  4) */
8c050538:	68 a1       	R0 = [P5 + 0x14];
8c05053a:	81 60       	R1 = 0x10 (X);		/*		R1=0xffff(65535) */
8c05053c:	01 0a       	CC = R1 <= R0 (IU);
8c05053e:	4d 32       	P1 = P5;
8c050540:	02 10       	IF !CC JUMP 0x0x8c050544;
8c050542:	69 91       	P1 = [P5];
8c050544:	fa 61       	R2 = 0x3f (X);		/*		R2=0x75(117) */
8c050546:	17 54       	R0 = R7 & R2;
8c050548:	38 4a       	BITSET (R0, 0x7);		/* bit  7 */
8c05054a:	88 e6 03 00 	B[P1 + 0x3] = R0;
8c05054e:	68 a1       	R0 = [P5 + 0x14];
8c050550:	01 0a       	CC = R1 <= R0 (IU);
8c050552:	4d 32       	P1 = P5;
8c050554:	02 10       	IF !CC JUMP 0x0x8c050558;
8c050556:	69 91       	P1 = [P5];
8c050558:	82 c6 d7 81 	R0 = R7 >> 0x6;
8c05055c:	10 54       	R0 = R0 & R2;
8c05055e:	38 4a       	BITSET (R0, 0x7);		/* bit  7 */
8c050560:	88 e6 02 00 	B[P1 + 0x2] = R0;
8c050564:	68 a1       	R0 = [P5 + 0x14];
8c050566:	01 0a       	CC = R1 <= R0 (IU);
8c050568:	4d 32       	P1 = P5;
8c05056a:	02 10       	IF !CC JUMP 0x0x8c05056e;
8c05056c:	69 91       	P1 = [P5];
8c05056e:	82 c6 a7 81 	R0 = R7 >> 0xc;
8c050572:	10 54       	R0 = R0 & R2;
8c050574:	38 4a       	BITSET (R0, 0x7);		/* bit  7 */
8c050576:	88 e6 01 00 	B[P1 + 0x1] = R0;
8c05057a:	80 a1       	R0 = [P0 + 0x18];
8c05057c:	01 0a       	CC = R1 <= R0 (IU);
8c05057e:	02 10       	IF !CC JUMP 0x0x8c050582;
8c050580:	6d 91       	P5 = [P5];
8c050582:	82 c6 77 81 	R0 = R7 >> 0x12;
8c050586:	39 60       	R1 = 0x7 (X);		/*		R1=0xffff(65535) */
8c050588:	08 54       	R0 = R0 & R1;
8c05058a:	81 63       	R1 = -0x10 (X);		/*		R1=0xffff(65535) */
8c05058c:	08 56       	R0 = R0 | R1;
8c05058e:	28 9b       	B[P5] = R0;
8c050590:	66 6c       	SP += 0xc;		/* ( 12) */
8c050592:	b4 05       	(R7:6, P5:4) = [SP++];
8c050594:	01 e8 00 00 	UNLINK;
8c050598:	10 00       	RTS;
8c05059a:	19 60       	R1 = 0x3 (X);		/*		R1=0xffff(65535) */
8c05059c:	ff e3 50 72 	CALL 0x0x8c03ea3c;
8c0505a0:	45 32       	P0 = P5;
8c0505a2:	25 6c       	P5 += 0x4;		/* (  4) */
8c0505a4:	68 a1       	R0 = [P5 + 0x14];
8c0505a6:	81 60       	R1 = 0x10 (X);		/*		R1=0xffff(65535) */
8c0505a8:	01 0a       	CC = R1 <= R0 (IU);
8c0505aa:	4d 32       	P1 = P5;
8c0505ac:	02 10       	IF !CC JUMP 0x0x8c0505b0;
8c0505ae:	69 91       	P1 = [P5];
8c0505b0:	fa 61       	R2 = 0x3f (X);		/*		R2=0x75(117) */
8c0505b2:	17 54       	R0 = R7 & R2;
8c0505b4:	38 4a       	BITSET (R0, 0x7);		/* bit  7 */
8c0505b6:	88 e6 02 00 	B[P1 + 0x2] = R0;
8c0505ba:	68 a1       	R0 = [P5 + 0x14];
8c0505bc:	01 0a       	CC = R1 <= R0 (IU);
8c0505be:	4d 32       	P1 = P5;
8c0505c0:	02 10       	IF !CC JUMP 0x0x8c0505c4;
8c0505c2:	69 91       	P1 = [P5];
8c0505c4:	82 c6 d7 81 	R0 = R7 >> 0x6;
8c0505c8:	10 54       	R0 = R0 & R2;
8c0505ca:	38 4a       	BITSET (R0, 0x7);		/* bit  7 */
8c0505cc:	88 e6 01 00 	B[P1 + 0x1] = R0;
8c0505d0:	80 a1       	R0 = [P0 + 0x18];
8c0505d2:	01 0a       	CC = R1 <= R0 (IU);
8c0505d4:	02 10       	IF !CC JUMP 0x0x8c0505d8;
8c0505d6:	6d 91       	P5 = [P5];
8c0505d8:	82 c6 a7 81 	R0 = R7 >> 0xc;
8c0505dc:	30 54       	R0 = R0 & R6;
8c0505de:	01 63       	R1 = -0x20 (X);		/*		R1=0xffff(65535) */
8c0505e0:	08 56       	R0 = R0 | R1;
8c0505e2:	28 9b       	B[P5] = R0;
8c0505e4:	66 6c       	SP += 0xc;		/* ( 12) */
8c0505e6:	b4 05       	(R7:6, P5:4) = [SP++];
8c0505e8:	01 e8 00 00 	UNLINK;
8c0505ec:	10 00       	RTS;
8c0505ee:	65 32       	P4 = P5;
8c0505f0:	24 6c       	P4 += 0x4;		/* (  4) */
8c0505f2:	11 60       	R1 = 0x2 (X);		/*		R1=0xffff(65535) */
8c0505f4:	ff e3 24 72 	CALL 0x0x8c03ea3c;
8c0505f8:	60 a1       	R0 = [P4 + 0x14];
8c0505fa:	81 60       	R1 = 0x10 (X);		/*		R1=0xffff(65535) */
8c0505fc:	01 0a       	CC = R1 <= R0 (IU);
8c0505fe:	4c 32       	P1 = P4;
8c050600:	02 10       	IF !CC JUMP 0x0x8c050604;
8c050602:	61 91       	P1 = [P4];
8c050604:	f8 61       	R0 = 0x3f (X);		/*		R0=0x5d( 93) */
8c050606:	07 54       	R0 = R7 & R0;
8c050608:	38 4a       	BITSET (R0, 0x7);		/* bit  7 */
8c05060a:	88 e6 01 00 	B[P1 + 0x1] = R0;
8c05060e:	a8 a1       	R0 = [P5 + 0x18];
8c050610:	01 0a       	CC = R1 <= R0 (IU);
8c050612:	02 10       	IF !CC JUMP 0x0x8c050616;
8c050614:	64 91       	P4 = [P4];
8c050616:	82 c6 d7 81 	R0 = R7 >> 0x6;
8c05061a:	f9 60       	R1 = 0x1f (X);		/*		R1=0xffff(65535) */
8c05061c:	08 54       	R0 = R0 & R1;
8c05061e:	01 62       	R1 = -0x40 (X);		/*		R1=0xffff(65535) */
8c050620:	08 56       	R0 = R0 | R1;
8c050622:	20 9b       	B[P4] = R0;
8c050624:	66 6c       	SP += 0xc;		/* ( 12) */
8c050626:	b4 05       	(R7:6, P5:4) = [SP++];
8c050628:	01 e8 00 00 	UNLINK;
8c05062c:	10 00       	RTS;
8c05062e:	09 60       	R1 = 0x1 (X);		/*		R1=0xffff(65535) */
8c050630:	ff e3 06 72 	CALL 0x0x8c03ea3c;
8c050634:	a8 a1       	R0 = [P5 + 0x18];
8c050636:	25 6c       	P5 += 0x4;		/* (  4) */
8c050638:	81 60       	R1 = 0x10 (X);		/*		R1=0xffff(65535) */
8c05063a:	01 0a       	CC = R1 <= R0 (IU);
8c05063c:	02 10       	IF !CC JUMP 0x0x8c050640;
8c05063e:	6d 91       	P5 = [P5];
8c050640:	2f 9b       	B[P5] = R7;
8c050642:	66 6c       	SP += 0xc;		/* ( 12) */
8c050644:	b4 05       	(R7:6, P5:4) = [SP++];
8c050646:	01 e8 00 00 	UNLINK;
8c05064a:	10 00       	RTS;
8c05064c:	00 e8 17 00 	LINK 0x5c;		/* (92) */
8c050650:	e3 05       	[--SP] = (R7:4, P5:3);
8c050652:	66 6f       	SP += -0x14;		/* (-20) */
8c050654:	82 ce 02 c8 	R4 = ROT R2 BY 0x0 || [SP + 0x34] = R1 || NOP;
8c050658:	71 b3 00 00 
8c05065c:	03 c8 00 18 	MNOP || P4 = [SP + 0x34] || [FP + 0x10] = R0;
8c050660:	74 af 38 b1 
8c050664:	2a 32       	P5 = R2;
8c050666:	15 61       	R5 = 0x22 (X);		/*		R5=0x4c( 76) */
8c050668:	26 e1 5c 00 	R6 = 0x5c (X);		/*		R6=0x5c( 92) */
8c05066c:	03 c8 00 18 	MNOP || R7 = [P4 + 0x8] || R3 = [P4 + 0x4];
8c050670:	a7 a0 63 a0 
8c050674:	5f 52       	R1 = R7 - R3;
8c050676:	f1 67       	R1 += -0x2;		/* ( -2) */
8c050678:	6a a1       	R2 = [P5 + 0x14];
8c05067a:	0a 0a       	CC = R2 <= R1 (IU);
8c05067c:	1f 32       	P3 = R7;
8c05067e:	04 10       	IF !CC JUMP 0x0x8c050686;
8c050680:	a8 a1       	R0 = [P5 + 0x18];
8c050682:	01 08       	CC = R1 == R0;
8c050684:	d2 10       	IF !CC JUMP 0x0x8c050828;
8c050686:	0b 64       	R3 += 0x1;		/* (  1) */
8c050688:	fb 6f       	P3 += -0x1;		/* ( -1) */
8c05068a:	fb b0       	[FP + 0xc] = R3;
8c05068c:	0b 32       	P1 = R3;
8c05068e:	27 e1 66 00 	R7 = 0x66 (X);		/*		R7=0x66(102) */
8c050692:	0d da 80 11 	P5=293609524;
8c050696:	34 20 00 00 
8c05069a:	43 30       	R0 = P3;
8c05069c:	03 08       	CC = R3 == R0;
8c05069e:	be 18       	IF CC JUMP 0x0x8c05081a;
8c0506a0:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R2 = B[P1++] (X) || NOP;
8c0506a4:	4a 98 00 00 
8c0506a8:	2a 08       	CC = R2 == R5;
8c0506aa:	f9 bc       	[FP + 0xc] = P1;
8c0506ac:	b1 18       	IF CC JUMP 0x0x8c05080e;
8c0506ae:	32 08       	CC = R2 == R6;
8c0506b0:	ab 10       	IF !CC JUMP 0x0x8c050806;
8c0506b2:	4b 08       	CC = P3 == P1;
8c0506b4:	78 18       	IF CC JUMP 0x0x8c0507a4;
8c0506b6:	82 ce 06 c4 	R2 = ROT R6 BY 0x0 || R0 = B[P1++] (X) || NOP;
8c0506ba:	48 98 00 00 
8c0506be:	f9 bc       	[FP + 0xc] = P1;
8c0506c0:	b0 09       	CC = R0 < R6 (IU);
8c0506c2:	5e 18       	IF CC JUMP 0x0x8c05077e;
8c0506c4:	30 08       	CC = R0 == R6;
8c0506c6:	57 18       	IF CC JUMP 0x0x8c050774;
8c0506c8:	b8 09       	CC = R0 < R7 (IU);
8c0506ca:	4b 18       	IF CC JUMP 0x0x8c050760;
8c0506cc:	38 08       	CC = R0 == R7;
8c0506ce:	40 18       	IF CC JUMP 0x0x8c05074e;
8c0506d0:	22 e1 92 ff 	R2 = -0x6e (X);		/*		R2=0xffffff92(-110) */
8c0506d4:	10 50       	R0 = R0 + R2;
8c0506d6:	41 60       	R1 = 0x8 (X);		/*		R1=0xffff(65535) */
8c0506d8:	08 32       	P1 = R0;
8c0506da:	88 09       	CC = R0 < R1 (IU);
8c0506dc:	09 10       	IF !CC JUMP 0x0x8c0506ee;
8c0506de:	4d 5e       	P1 = P5 + (P1 << 0x2);
8c0506e0:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || P1 = [P1] || NOP;
8c0506e4:	49 91 00 00 
8c0506e8:	52 60       	R2 = 0xa (X);		/*		R2=0xffffff92(-110) */
8c0506ea:	09 60       	R1 = 0x1 (X);		/*		R1=0xffff(65535) */
8c0506ec:	51 00       	JUMP (P1);
8c0506ee:	7f 30       	R7 = FP;
8c0506f0:	47 66       	R7 += -0x38;		/* (-56) */
8c0506f2:	07 30       	R0 = R7;
8c0506f4:	01 da 80 11 	R1=293609492;
8c0506f8:	14 20 00 00 
8c0506fc:	ff e3 82 73 	CALL 0x0x8c03ee00;
8c050700:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R3 = [FP + 0xc] || R2 = [SP + 0x34];
8c050704:	fb a0 72 a3 
8c050708:	03 c8 00 18 	MNOP || [SP + 0xc] = R3 || R0 = [FP + 0x10];
8c05070c:	f3 b0 38 a1 
8c050710:	ff e3 ba f6 	CALL 0x0x8c04f484;
8c050714:	86 60       	R6 = 0x10 (X);		/*		R6=0x5c( 92) */
8c050716:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R1 = [FP -0x20] || R0 = [FP -0x34];
8c05071a:	81 b9 30 b9 
8c05071e:	0e 0a       	CC = R6 <= R1 (IU);
8c050720:	0a 18       	IF CC JUMP 0x0x8c050734;
8c050722:	01 60       	R1 = 0x0 (X);		/*		R1=0xffff(65535) */
8c050724:	b1 e6 58 00 	B[SP + 0x58] = R1;
8c050728:	a6 6c       	SP += 0x14;		/* ( 20) */
8c05072a:	07 30       	R0 = R7;
8c05072c:	a3 05       	(R7:4, P5:3) = [SP++];
8c05072e:	01 e8 00 00 	UNLINK;
8c050732:	10 00       	RTS;
8c050734:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050738:	e4 e3 00 00 
8c05073c:	01 60       	R1 = 0x0 (X);		/*		R1=0xffff(65535) */
8c05073e:	b1 e6 58 00 	B[SP + 0x58] = R1;
8c050742:	a6 6c       	SP += 0x14;		/* ( 20) */
8c050744:	07 30       	R0 = R7;
8c050746:	a3 05       	(R7:4, P5:3) = [SP++];
8c050748:	01 e8 00 00 	UNLINK;
8c05074c:	10 00       	RTS;
8c05074e:	04 30       	R0 = R4;
8c050750:	62 60       	R2 = 0xc (X);		/*		R2=0xffffff92(-110) */
8c050752:	09 60       	R1 = 0x1 (X);		/*		R1=0xffff(65535) */
8c050754:	ff e3 74 71 	CALL 0x0x8c03ea3c;
8c050758:	fb a0       	R3 = [FP + 0xc];
8c05075a:	0b 32       	P1 = R3;
8c05075c:	9f 2f       	JUMP.S 0x0x8c05069a;
8c05075e:	00 00       	NOP;
8c050760:	21 e1 62 00 	R1 = 0x62 (X);		/*		R1=0x62( 98) */
8c050764:	08 08       	CC = R0 == R1;
8c050766:	c4 13       	IF !CC JUMP 0x0x8c0506ee;
8c050768:	04 30       	R0 = R4;
8c05076a:	42 60       	R2 = 0x8 (X);		/*		R2=0xffffff92(-110) */
8c05076c:	09 60       	R1 = 0x1 (X);		/*		R1=0x62( 98) */
8c05076e:	ff e3 67 71 	CALL 0x0x8c03ea3c;
8c050772:	f3 2f       	JUMP.S 0x0x8c050758;
8c050774:	04 30       	R0 = R4;
8c050776:	09 60       	R1 = 0x1 (X);		/*		R1=0x62( 98) */
8c050778:	ff e3 62 71 	CALL 0x0x8c03ea3c;
8c05077c:	ee 2f       	JUMP.S 0x0x8c050758;
8c05077e:	a8 09       	CC = R0 < R5 (IU);
8c050780:	b7 1b       	IF CC JUMP 0x0x8c0506ee;
8c050782:	28 08       	CC = R0 == R5;
8c050784:	0a 18       	IF CC JUMP 0x0x8c050798;
8c050786:	79 61       	R1 = 0x2f (X);		/*		R1=0x62( 98) */
8c050788:	08 08       	CC = R0 == R1;
8c05078a:	b2 13       	IF !CC JUMP 0x0x8c0506ee;
8c05078c:	04 30       	R0 = R4;
8c05078e:	7a 61       	R2 = 0x2f (X);		/*		R2=0xffffff92(-110) */
8c050790:	09 60       	R1 = 0x1 (X);		/*		R1=0x62( 98) */
8c050792:	ff e3 55 71 	CALL 0x0x8c03ea3c;
8c050796:	e1 2f       	JUMP.S 0x0x8c050758;
8c050798:	04 30       	R0 = R4;
8c05079a:	12 61       	R2 = 0x22 (X);		/*		R2=0xffffff92(-110) */
8c05079c:	09 60       	R1 = 0x1 (X);		/*		R1=0x62( 98) */
8c05079e:	ff e3 4f 71 	CALL 0x0x8c03ea3c;
8c0507a2:	db 2f       	JUMP.S 0x0x8c050758;
8c0507a4:	5e 30       	R3 = SP;
8c0507a6:	c7 61       	R7 = 0x38 (X);		/*		R7=0x66(102) */
8c0507a8:	fb 51       	R7 = R3 + R7;
8c0507aa:	07 30       	R0 = R7;
8c0507ac:	01 da 80 11 	R1=293609460;
8c0507b0:	f4 1f 00 00 
8c0507b4:	ff e3 26 73 	CALL 0x0x8c03ee00;
8c0507b8:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R3 = [FP + 0xc] || R2 = [SP + 0x34];
8c0507bc:	fb a0 72 a3 
8c0507c0:	03 c8 00 18 	MNOP || [SP + 0xc] = R3 || R0 = [FP + 0x10];
8c0507c4:	f3 b0 38 a1 
8c0507c8:	ff e3 5e f6 	CALL 0x0x8c04f484;
8c0507cc:	86 60       	R6 = 0x10 (X);		/*		R6=0x5c( 92) */
8c0507ce:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R1 = [FP -0x3c] || R0 = [SP + 0x3c];
8c0507d2:	11 b9 f0 a3 
8c0507d6:	0e 0a       	CC = R6 <= R1 (IU);
8c0507d8:	0a 18       	IF CC JUMP 0x0x8c0507ec;
8c0507da:	01 60       	R1 = 0x0 (X);		/*		R1=0x62( 98) */
8c0507dc:	b1 e6 3c 00 	B[SP + 0x3c] = R1;
8c0507e0:	a6 6c       	SP += 0x14;		/* ( 20) */
8c0507e2:	07 30       	R0 = R7;
8c0507e4:	a3 05       	(R7:4, P5:3) = [SP++];
8c0507e6:	01 e8 00 00 	UNLINK;
8c0507ea:	10 00       	RTS;
8c0507ec:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0507f0:	e4 e3 00 00 
8c0507f4:	01 60       	R1 = 0x0 (X);		/*		R1=0x62( 98) */
8c0507f6:	b1 e6 3c 00 	B[SP + 0x3c] = R1;
8c0507fa:	a6 6c       	SP += 0x14;		/* ( 20) */
8c0507fc:	07 30       	R0 = R7;
8c0507fe:	a3 05       	(R7:4, P5:3) = [SP++];
8c050800:	01 e8 00 00 	UNLINK;
8c050804:	10 00       	RTS;
8c050806:	09 60       	R1 = 0x1 (X);		/*		R1=0x62( 98) */
8c050808:	ff e3 1a 71 	CALL 0x0x8c03ea3c;
8c05080c:	a6 2f       	JUMP.S 0x0x8c050758;
8c05080e:	a6 6c       	SP += 0x14;		/* ( 20) */
8c050810:	a3 05       	(R7:4, P5:3) = [SP++];
8c050812:	01 e8 00 00 	UNLINK;
8c050816:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c050818:	10 00       	RTS;
8c05081a:	a6 6c       	SP += 0x14;		/* ( 20) */
8c05081c:	a3 05       	(R7:4, P5:3) = [SP++];
8c05081e:	01 e8 00 00 	UNLINK;
8c050822:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c050824:	10 00       	RTS;
8c050826:	00 00       	NOP;
8c050828:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || P1 = [P5 + 0x14] || NOP;
8c05082c:	69 ad 00 00 
8c050830:	0a 60       	R2 = 0x1 (X);		/*		R2=0xffffff92(-110) */
8c050832:	31 bf       	[SP + 0x30] = P1;
8c050834:	ff e3 86 6f 	CALL 0x0x8c03e740;
8c050838:	00 0c       	CC = R0 == 0x0;
8c05083a:	03 c8 00 18 	MNOP || P3 = [P4 + 0x8] || R3 = [P4 + 0x4];
8c05083e:	a3 ac 63 a0 
8c050842:	22 1b       	IF CC JUMP 0x0x8c050686;
8c050844:	4d 32       	P1 = P5;
8c050846:	21 6c       	P1 += 0x4;		/* (  4) */
8c050848:	03 c8 00 18 	MNOP || P0 = [SP + 0x30] || R0 = [P5 + 0x18];
8c05084c:	30 af a8 a1 
8c050850:	81 60       	R1 = 0x10 (X);		/*		R1=0x62( 98) */
8c050852:	01 0a       	CC = R1 <= R0 (IU);
8c050854:	02 10       	IF !CC JUMP 0x0x8c050858;
8c050856:	49 91       	P1 = [P1];
8c050858:	00 60       	R0 = 0x0 (X);		/*		R0=0x5d( 93) */
8c05085a:	68 bd       	[P5 + 0x14] = P0;
8c05085c:	41 5a       	P1 = P1 + P0;
8c05085e:	08 9b       	B[P1] = R0;
8c050860:	03 c8 00 18 	MNOP || P3 = [P4 + 0x8] || R3 = [P4 + 0x4];
8c050864:	a3 ac 63 a0 
8c050868:	0f 2f       	JUMP.S 0x0x8c050686;
8c05086a:	00 00       	NOP;
8c05086c:	ff e3 e8 70 	CALL 0x0x8c03ea3c;
8c050870:	74 2f       	JUMP.S 0x0x8c050758;
8c050872:	04 30       	R0 = R4;
8c050874:	6a 60       	R2 = 0xd (X);		/*		R2=0xffffff92(-110) */
8c050876:	09 60       	R1 = 0x1 (X);		/*		R1=0x62( 98) */
8c050878:	ff e3 e2 70 	CALL 0x0x8c03ea3c;
8c05087c:	6e 2f       	JUMP.S 0x0x8c050758;
8c05087e:	04 30       	R0 = R4;
8c050880:	4a 60       	R2 = 0x9 (X);		/*		R2=0xffffff92(-110) */
8c050882:	09 60       	R1 = 0x1 (X);		/*		R1=0x62( 98) */
8c050884:	ff e3 dc 70 	CALL 0x0x8c03ea3c;
8c050888:	68 2f       	JUMP.S 0x0x8c050758;
8c05088a:	57 30       	R2 = FP;
8c05088c:	42 64       	R2 += 0x8;		/* (  8) */
8c05088e:	03 c8 00 18 	MNOP || [SP + 0x10] = R2 || R1 = [SP + 0x34];
8c050892:	32 b1 71 a3 
8c050896:	03 c8 00 18 	MNOP || [SP + 0xc] = P3 || R0 = [FP + 0x10];
8c05089a:	f3 bc 38 a1 
8c05089e:	22 64       	R2 += 0x4;		/* (  4) */
8c0508a0:	ff e3 0c f7 	CALL 0x0x8c04f6b8;
8c0508a4:	00 0c       	CC = R0 == 0x0;
8c0508a6:	2b 18       	IF CC JUMP 0x0x8c0508fc;
8c0508a8:	5f 30       	R3 = FP;
8c0508aa:	23 67       	R3 += -0x1c;		/* (-28) */
8c0508ac:	03 c8 00 18 	MNOP || [SP + 0x30] = R3 || R1 = [FP + 0x8];
8c0508b0:	33 b3 b9 a0 
8c0508b4:	30 a3       	R0 = [SP + 0x30];
8c0508b6:	ff e3 19 fe 	CALL 0x0x8c0504e8;
8c0508ba:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8c0508be:	b8 00 02 00 
8c0508c2:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0xc] = R2 || R1 = [SP + 0x30];
8c0508c6:	f2 b0 31 a3 
8c0508ca:	02 60       	R2 = 0x0 (X);		/*		R2=0xffffff92(-110) */
8c0508cc:	ff e3 e6 6f 	CALL 0x0x8c03e898;
8c0508d0:	f0 b9       	R0 = [FP -0x4];
8c0508d2:	83 60       	R3 = 0x10 (X);		/*		R3=0x54( 84) */
8c0508d4:	03 0a       	CC = R3 <= R0 (IU);
8c0508d6:	0d 18       	IF CC JUMP 0x0x8c0508f0;
8c0508d8:	7a 60       	R2 = 0xf (X);		/*		R2=0xffffff92(-110) */
8c0508da:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP -0x4] = R2 || NOP;
8c0508de:	f2 bb 00 00 
8c0508e2:	04 cc 00 40 	R0 = R0 - R0 (NS) || [FP -0x8] = R1 || NOP;
8c0508e6:	e1 bb 00 00 
8c0508ea:	b0 e6 74 00 	B[SP + 0x74] = R0;
8c0508ee:	35 2f       	JUMP.S 0x0x8c050758;
8c0508f0:	a0 b9       	R0 = [FP -0x18];
8c0508f2:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0508f6:	e4 e3 00 00 
8c0508fa:	ef 2f       	JUMP.S 0x0x8c0508d8;
8c0508fc:	a6 6c       	SP += 0x14;		/* ( 20) */
8c0508fe:	a3 05       	(R7:4, P5:3) = [SP++];
8c050900:	01 e8 00 00 	UNLINK;
8c050904:	00 60       	R0 = 0x0 (X);		/*		R0=0x5d( 93) */
8c050906:	10 00       	RTS;
8c050908:	00 e8 0a 00 	LINK 0x28;		/* (40) */
8c05090c:	68 05       	[--SP] = (R7:5);
8c05090e:	6f 30       	R5 = FP;
8c050910:	a6 6f       	SP += -0xc;		/* (-12) */
8c050912:	7a 60       	R2 = 0xf (X);		/*		R2=0xffffff92(-110) */
8c050914:	25 67       	R5 += -0x1c;		/* (-28) */
8c050916:	04 cc 36 4c 	R6 = R6 - R6 (NS) || [SP + 0x3c] = R2 || NOP;
8c05091a:	f2 b3 00 00 
8c05091e:	b6 e6 28 00 	B[SP + 0x28] = R6;
8c050922:	82 ce 05 c4 	R2 = ROT R5 BY 0x0 || [SP + 0x38] = R6 || NOP;
8c050926:	b6 b3 00 00 
8c05092a:	38 30       	R7 = R0;
8c05092c:	ff e3 90 fe 	CALL 0x0x8c05064c;
8c050930:	00 0c       	CC = R0 == 0x0;
8c050932:	19 10       	IF !CC JUMP 0x0x8c050964;
8c050934:	81 60       	R1 = 0x10 (X);		/*		R1=0x62( 98) */
8c050936:	f2 a3       	R2 = [SP + 0x3c];
8c050938:	11 0a       	CC = R1 <= R2 (IU);
8c05093a:	08 18       	IF CC JUMP 0x0x8c05094a;
8c05093c:	b6 e6 28 00 	B[SP + 0x28] = R6;
8c050940:	66 6c       	SP += 0xc;		/* ( 12) */
8c050942:	28 05       	(R7:5) = [SP++];
8c050944:	01 e8 00 00 	UNLINK;
8c050948:	10 00       	RTS;
8c05094a:	b0 a2       	R0 = [SP + 0x28];
8c05094c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050950:	e4 e3 00 00 
8c050954:	b6 e6 28 00 	B[SP + 0x28] = R6;
8c050958:	66 6c       	SP += 0xc;		/* ( 12) */
8c05095a:	28 05       	(R7:5) = [SP++];
8c05095c:	01 e8 00 00 	UNLINK;
8c050960:	00 60       	R0 = 0x0 (X);		/*		R0=0x5d( 93) */
8c050962:	10 00       	RTS;
8c050964:	07 30       	R0 = R7;
8c050966:	ff e3 5e f0 	CALL 0x0x8c04ea22;
8c05096a:	38 30       	R7 = R0;
8c05096c:	0d 30       	R1 = R5;
8c05096e:	a5 67       	R5 += -0xc;		/* (-12) */
8c050970:	05 30       	R0 = R5;
8c050972:	00 e3 39 08 	CALL 0x0x8c0519e4;
8c050976:	07 30       	R0 = R7;
8c050978:	7f 30       	R7 = FP;
8c05097a:	c7 66       	R7 += -0x28;		/* (-40) */
8c05097c:	0f 30       	R1 = R7;
8c05097e:	00 e3 c9 08 	CALL 0x0x8c051b10;
8c050982:	07 30       	R0 = R7;
8c050984:	00 e3 5a 08 	CALL 0x0x8c051a38;
8c050988:	80 60       	R0 = 0x10 (X);		/*		R0=0x5d( 93) */
8c05098a:	f1 a3       	R1 = [SP + 0x3c];
8c05098c:	08 0a       	CC = R0 <= R1 (IU);
8c05098e:	09 18       	IF CC JUMP 0x0x8c0509a0;
8c050990:	b6 e6 28 00 	B[SP + 0x28] = R6;
8c050994:	66 6c       	SP += 0xc;		/* ( 12) */
8c050996:	28 05       	(R7:5) = [SP++];
8c050998:	01 e8 00 00 	UNLINK;
8c05099c:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c05099e:	10 00       	RTS;
8c0509a0:	b0 a2       	R0 = [SP + 0x28];
8c0509a2:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0509a6:	e4 e3 00 00 
8c0509aa:	b6 e6 28 00 	B[SP + 0x28] = R6;
8c0509ae:	66 6c       	SP += 0xc;		/* ( 12) */
8c0509b0:	28 05       	(R7:5) = [SP++];
8c0509b2:	01 e8 00 00 	UNLINK;
8c0509b6:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c0509b8:	10 00       	RTS;
8c0509ba:	00 00       	NOP;
8c0509bc:	00 e8 1d 00 	LINK 0x74;		/* (116) */
8c0509c0:	ed 05       	[--SP] = (R7:5, P5:5);
8c0509c2:	38 30       	R7 = R0;
8c0509c4:	2f 32       	P5 = R7;
8c0509c6:	86 6f       	SP += -0x10;		/* (-16) */
8c0509c8:	02 61       	R2 = 0x20 (X);		/*		R2=0xffffff92(-110) */
8c0509ca:	4e 30       	R1 = SP;
8c0509cc:	91 51       	R6 = R1 + R2;
8c0509ce:	0e 30       	R1 = R6;
8c0509d0:	ff e3 06 f2 	CALL 0x0x8c04eddc;
8c0509d4:	a8 e4 76 00 	R0 = B[P5 + 0x76] (Z);
8c0509d8:	00 0c       	CC = R0 == 0x0;
8c0509da:	05 18       	IF CC JUMP 0x0x8c0509e4;
8c0509dc:	28 e4 1b 00 	R0 = [P5 + 0x6c];
8c0509e0:	00 0c       	CC = R0 == 0x0;
8c0509e2:	4a 10       	IF !CC JUMP 0x0x8c050a76;
8c0509e4:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || P1 = [SP + 0x20] || NOP;
8c0509e8:	31 ae 00 00 
8c0509ec:	48 68       	P0 = 0x9 (X);		/*		P0=0x0(  0) */
8c0509ee:	07 30       	R0 = R7;
8c0509f0:	6f 30       	R5 = FP;
8c0509f2:	f9 6f       	P1 += -0x1;		/* ( -1) */
8c0509f4:	c1 09       	CC = P1 < P0 (IU);
8c0509f6:	09 10       	IF !CC JUMP 0x0x8c050a08;
8c0509f8:	08 da 80 11 	P0=293609604;
8c0509fc:	84 20 00 00 
8c050a00:	48 5e       	P1 = P0 + (P1 << 0x2);
8c050a02:	49 91       	P1 = [P1];
8c050a04:	c5 66       	R5 += -0x28;		/* (-40) */
8c050a06:	51 00       	JUMP (P1);
8c050a08:	47 30       	R0 = FP;
8c050a0a:	20 67       	R0 += -0x1c;		/* (-28) */
8c050a0c:	01 da 80 11 	R1=293609556;
8c050a10:	54 20 00 00 
8c050a14:	ff e3 f6 71 	CALL 0x0x8c03ee00;
8c050a18:	07 30       	R0 = R7;
8c050a1a:	01 68       	P1 = 0x0 (X);		/*		P1=0x0(  0) */
8c050a1c:	21 e1 58 00 	R1 = 0x58 (X);		/*		R1=0x58( 88) */
8c050a20:	04 cc 31 02 	R1 = R6 + R1 (NS) || [SP + 0xc] = P1 || NOP;
8c050a24:	f1 bc 00 00 
8c050a28:	16 30       	R2 = R6;
8c050a2a:	ff e3 2d f5 	CALL 0x0x8c04f484;
8c050a2e:	81 60       	R1 = 0x10 (X);		/*		R1=0x58( 88) */
8c050a30:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R0 = [FP -0x4] || NOP;
8c050a34:	f0 b9 00 00 
8c050a38:	01 0a       	CC = R1 <= R0 (IU);
8c050a3a:	10 18       	IF CC JUMP 0x0x8c050a5a;
8c050a3c:	00 60       	R0 = 0x0 (X);		/*		R0=0x5d( 93) */
8c050a3e:	b0 e6 7c 00 	B[SP + 0x7c] = R0;
8c050a42:	86 6c       	SP += 0x10;		/* ( 16) */
8c050a44:	70 43       	R0 = R6.B (Z);
8c050a46:	ad 05       	(R7:5, P5:5) = [SP++];
8c050a48:	01 e8 00 00 	UNLINK;
8c050a4c:	10 00       	RTS;
8c050a4e:	86 6c       	SP += 0x10;		/* ( 16) */
8c050a50:	70 43       	R0 = R6.B (Z);
8c050a52:	ad 05       	(R7:5, P5:5) = [SP++];
8c050a54:	01 e8 00 00 	UNLINK;
8c050a58:	10 00       	RTS;
8c050a5a:	a0 b9       	R0 = [FP -0x18];
8c050a5c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050a60:	e4 e3 00 00 
8c050a64:	00 60       	R0 = 0x0 (X);		/*		R0=0x5d( 93) */
8c050a66:	b0 e6 7c 00 	B[SP + 0x7c] = R0;
8c050a6a:	86 6c       	SP += 0x10;		/* ( 16) */
8c050a6c:	70 43       	R0 = R6.B (Z);
8c050a6e:	ad 05       	(R7:5, P5:5) = [SP++];
8c050a70:	01 e8 00 00 	UNLINK;
8c050a74:	10 00       	RTS;
8c050a76:	07 30       	R0 = R7;
8c050a78:	ff e3 d5 ef 	CALL 0x0x8c04ea22;
8c050a7c:	21 e1 58 00 	R1 = 0x58 (X);		/*		R1=0x58( 88) */
8c050a80:	4f 51       	R5 = R7 + R1;
8c050a82:	0d 30       	R1 = R5;
8c050a84:	02 60       	R2 = 0x0 (X);		/*		R2=0xffffff92(-110) */
8c050a86:	00 e3 48 11 	CALL 0x0x8c052d16;
8c050a8a:	05 30       	R0 = R5;
8c050a8c:	02 60       	R2 = 0x0 (X);		/*		R2=0xffffff92(-110) */
8c050a8e:	01 da 80 11 	R1=293608776;
8c050a92:	48 1d 00 00 
8c050a96:	ff e3 51 ee 	CALL 0x0x8c04e738;
8c050a9a:	a5 2f       	JUMP.S 0x0x8c0509e4;
8c050a9c:	0e 30       	R1 = R6;
8c050a9e:	07 30       	R0 = R7;
8c050aa0:	00 e3 5e 00 	CALL 0x0x8c050b5c;
8c050aa4:	30 30       	R6 = R0;
8c050aa6:	a8 e4 76 00 	R0 = B[P5 + 0x76] (Z);
8c050aaa:	00 0c       	CC = R0 == 0x0;
8c050aac:	d1 1f       	IF CC JUMP 0x0x8c050a4e (BP);
8c050aae:	29 e4 13 00 	R1 = [P5 + 0x4c];
8c050ab2:	29 e6 14 00 	[P5 + 0x50] = R1;
8c050ab6:	07 30       	R0 = R7;
8c050ab8:	ff e3 b5 ef 	CALL 0x0x8c04ea22;
8c050abc:	28 e6 15 00 	[P5 + 0x54] = R0;
8c050ac0:	86 6c       	SP += 0x10;		/* ( 16) */
8c050ac2:	70 43       	R0 = R6.B (Z);
8c050ac4:	ad 05       	(R7:5, P5:5) = [SP++];
8c050ac6:	01 e8 00 00 	UNLINK;
8c050aca:	10 00       	RTS;
8c050acc:	0e 30       	R1 = R6;
8c050ace:	07 30       	R0 = R7;
8c050ad0:	ff e3 72 fc 	CALL 0x0x8c0503b4;
8c050ad4:	30 30       	R6 = R0;
8c050ad6:	e8 2f       	JUMP.S 0x0x8c050aa6;
8c050ad8:	0e 30       	R1 = R6;
8c050ada:	07 30       	R0 = R7;
8c050adc:	ff e3 16 ff 	CALL 0x0x8c050908;
8c050ae0:	30 30       	R6 = R0;
8c050ae2:	e2 2f       	JUMP.S 0x0x8c050aa6;
8c050ae4:	ff e3 8e f7 	CALL 0x0x8c04fa00;
8c050ae8:	30 30       	R6 = R0;
8c050aea:	de 2f       	JUMP.S 0x0x8c050aa6;
8c050aec:	07 30       	R0 = R7;
8c050aee:	ff e3 9a ef 	CALL 0x0x8c04ea22;
8c050af2:	30 30       	R6 = R0;
8c050af4:	6f 30       	R5 = FP;
8c050af6:	65 66       	R5 += -0x34;		/* (-52) */
8c050af8:	05 30       	R0 = R5;
8c050afa:	09 60       	R1 = 0x1 (X);		/*		R1=0x58( 88) */
8c050afc:	00 e3 b5 02 	CALL 0x0x8c051066;
8c050b00:	06 30       	R0 = R6;
8c050b02:	0d 30       	R1 = R5;
8c050b04:	00 e3 06 08 	CALL 0x0x8c051b10;
8c050b08:	05 30       	R0 = R5;
8c050b0a:	00 e3 97 07 	CALL 0x0x8c051a38;
8c050b0e:	0e 60       	R6 = 0x1 (X);		/*		R6=0x5c( 92) */
8c050b10:	cb 2f       	JUMP.S 0x0x8c050aa6;
8c050b12:	07 30       	R0 = R7;
8c050b14:	ff e3 87 ef 	CALL 0x0x8c04ea22;
8c050b18:	30 30       	R6 = R0;
8c050b1a:	6f 30       	R5 = FP;
8c050b1c:	65 66       	R5 += -0x34;		/* (-52) */
8c050b1e:	05 30       	R0 = R5;
8c050b20:	01 60       	R1 = 0x0 (X);		/*		R1=0x58( 88) */
8c050b22:	00 e3 a2 02 	CALL 0x0x8c051066;
8c050b26:	06 30       	R0 = R6;
8c050b28:	0d 30       	R1 = R5;
8c050b2a:	00 e3 f3 07 	CALL 0x0x8c051b10;
8c050b2e:	05 30       	R0 = R5;
8c050b30:	00 e3 84 07 	CALL 0x0x8c051a38;
8c050b34:	0e 60       	R6 = 0x1 (X);		/*		R6=0x5c( 92) */
8c050b36:	b8 2f       	JUMP.S 0x0x8c050aa6;
8c050b38:	07 30       	R0 = R7;
8c050b3a:	ff e3 74 ef 	CALL 0x0x8c04ea22;
8c050b3e:	30 30       	R6 = R0;
8c050b40:	05 30       	R0 = R5;
8c050b42:	01 60       	R1 = 0x0 (X);		/*		R1=0x58( 88) */
8c050b44:	00 e3 7a 12 	CALL 0x0x8c053038;
8c050b48:	06 30       	R0 = R6;
8c050b4a:	0d 30       	R1 = R5;
8c050b4c:	00 e3 e2 07 	CALL 0x0x8c051b10;
8c050b50:	05 30       	R0 = R5;
8c050b52:	00 e3 73 07 	CALL 0x0x8c051a38;
8c050b56:	0e 60       	R6 = 0x1 (X);		/*		R6=0x5c( 92) */
8c050b58:	a7 2f       	JUMP.S 0x0x8c050aa6;
8c050b5a:	00 00       	NOP;
8c050b5c:	00 e8 21 00 	LINK 0x84;		/* (132) */
8c050b60:	e5 05       	[--SP] = (R7:4, P5:5);
8c050b62:	86 6f       	SP += -0x10;		/* (-16) */
8c050b64:	03 60       	R3 = 0x0 (X);		/*		R3=0x54( 84) */
8c050b66:	7c 60       	R4 = 0xf (X);		/*		R4=0x45( 69) */
8c050b68:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [FP -0x3c] = R3 || NOP;
8c050b6c:	13 bb 00 00 
8c050b70:	22 61       	R2 = 0x24 (X);		/*		R2=0xffffff92(-110) */
8c050b72:	4e 30       	R1 = SP;
8c050b74:	b5 e6 5c 00 	B[SP + 0x5c] = R5;
8c050b78:	04 cc 0a 0c 	R6 = R1 + R2 (NS) || [FP -0x38] = R4 || NOP;
8c050b7c:	24 bb 00 00 
8c050b80:	28 32       	P5 = R0;
8c050b82:	38 30       	R7 = R0;
8c050b84:	ff e3 4f ef 	CALL 0x0x8c04ea22;
8c050b88:	28 30       	R5 = R0;
8c050b8a:	06 30       	R0 = R6;
8c050b8c:	39 60       	R1 = 0x7 (X);		/*		R1=0x58( 88) */
8c050b8e:	00 e3 55 12 	CALL 0x0x8c053038;
8c050b92:	0e 30       	R1 = R6;
8c050b94:	05 30       	R0 = R5;
8c050b96:	00 e3 bd 07 	CALL 0x0x8c051b10;
8c050b9a:	06 30       	R0 = R6;
8c050b9c:	00 e3 4e 07 	CALL 0x0x8c051a38;
8c050ba0:	66 60       	R6 = 0xc (X);		/*		R6=0x5c( 92) */
8c050ba2:	46 30       	R0 = SP;
8c050ba4:	21 e1 4c 00 	R1 = 0x4c (X);		/*		R1=0x4c( 76) */
8c050ba8:	48 51       	R5 = R0 + R1;
8c050baa:	07 30       	R0 = R7;
8c050bac:	0d 30       	R1 = R5;
8c050bae:	ff e3 65 f0 	CALL 0x0x8c04ec78;
8c050bb2:	00 0c       	CC = R0 == 0x0;
8c050bb4:	37 19       	IF CC JUMP 0x0x8c050e22;
8c050bb6:	91 b8       	R1 = [FP -0x5c];
8c050bb8:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c050bba:	31 08       	CC = R1 == R6;
8c050bbc:	0a 10       	IF !CC JUMP 0x0x8c050bd0;
8c050bbe:	41 43       	R1 = R0.B (Z);
8c050bc0:	01 0c       	CC = R1 == 0x0;
8c050bc2:	07 18       	IF CC JUMP 0x0x8c050bd0;
8c050bc4:	0d 30       	R1 = R5;
8c050bc6:	07 30       	R0 = R7;
8c050bc8:	ff e3 58 f0 	CALL 0x0x8c04ec78;
8c050bcc:	91 b8       	R1 = [FP -0x5c];
8c050bce:	f6 2f       	JUMP.S 0x0x8c050bba;
8c050bd0:	40 43       	R0 = R0.B (Z);
8c050bd2:	00 0c       	CC = R0 == 0x0;
8c050bd4:	27 19       	IF CC JUMP 0x0x8c050e22;
8c050bd6:	90 b8       	R0 = [FP -0x5c];
8c050bd8:	10 0c       	CC = R0 == 0x2;
8c050bda:	60 19       	IF CC JUMP 0x0x8c050e9a;
8c050bdc:	29 60       	R1 = 0x5 (X);		/*		R1=0x4c( 76) */
8c050bde:	08 08       	CC = R0 == R1;
8c050be0:	21 11       	IF !CC JUMP 0x0x8c050e22;
8c050be2:	46 30       	R0 = SP;
8c050be4:	23 e1 58 00 	R3 = 0x58 (X);		/*		R3=0x58( 88) */
8c050be8:	58 51       	R5 = R0 + R3;
8c050bea:	05 30       	R0 = R5;
8c050bec:	02 60       	R2 = 0x0 (X);		/*		R2=0xffffff92(-110) */
8c050bee:	01 da 80 11 	R1=293608776;
8c050bf2:	48 1d 00 00 
8c050bf6:	ff e3 a1 ed 	CALL 0x0x8c04e738;
8c050bfa:	0d 30       	R1 = R5;
8c050bfc:	07 30       	R0 = R7;
8c050bfe:	15 30       	R2 = R5;
8c050c00:	a1 67       	R1 += -0xc;		/* (-12) */
8c050c02:	ff e3 25 fd 	CALL 0x0x8c05064c;
8c050c06:	00 0c       	CC = R0 == 0x0;
8c050c08:	f3 18       	IF CC JUMP 0x0x8c050dee;
8c050c0a:	67 30       	R4 = FP;
8c050c0c:	64 66       	R4 += -0x34;		/* (-52) */
8c050c0e:	07 30       	R0 = R7;
8c050c10:	0c 30       	R1 = R4;
8c050c12:	ff e3 33 f0 	CALL 0x0x8c04ec78;
8c050c16:	00 0c       	CC = R0 == 0x0;
8c050c18:	af 18       	IF CC JUMP 0x0x8c050d76;
8c050c1a:	30 b9       	R0 = [FP -0x34];
8c050c1c:	59 60       	R1 = 0xb (X);		/*		R1=0x4c( 76) */
8c050c1e:	08 08       	CC = R0 == R1;
8c050c20:	ab 10       	IF !CC JUMP 0x0x8c050d76;
8c050c22:	07 30       	R0 = R7;
8c050c24:	ff e3 ff ee 	CALL 0x0x8c04ea22;
8c050c28:	0d 30       	R1 = R5;
8c050c2a:	00 e3 7d 13 	CALL 0x0x8c053324;
8c050c2e:	4f 30       	R1 = FP;
8c050c30:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP + 0x8] = R0 || NOP;
8c050c34:	b8 b0 00 00 
8c050c38:	41 64       	R1 += 0x8;		/* (  8) */
8c050c3a:	ff e3 d5 f2 	CALL 0x0x8c04f1e4;
8c050c3e:	07 30       	R0 = R7;
8c050c40:	ff e3 be fe 	CALL 0x0x8c0509bc;
8c050c44:	29 a1       	R1 = [P5 + 0x10];
8c050c46:	01 0c       	CC = R1 == 0x0;
8c050c48:	06 18       	IF CC JUMP 0x0x8c050c54;
8c050c4a:	f9 67       	R1 += -0x1;		/* ( -1) */
8c050c4c:	01 0c       	CC = R1 == 0x0;
8c050c4e:	29 b1       	[P5 + 0x10] = R1;
8c050c50:	02 10       	IF !CC JUMP 0x0x8c050c54;
8c050c52:	e9 b0       	[P5 + 0xc] = R1;
8c050c54:	00 0c       	CC = R0 == 0x0;
8c050c56:	76 18       	IF CC JUMP 0x0x8c050d42;
8c050c58:	6f 30       	R5 = FP;
8c050c5a:	c5 66       	R5 += -0x28;		/* (-40) */
8c050c5c:	07 30       	R0 = R7;
8c050c5e:	0d 30       	R1 = R5;
8c050c60:	ff e3 0c f0 	CALL 0x0x8c04ec78;
8c050c64:	00 0c       	CC = R0 == 0x0;
8c050c66:	32 18       	IF CC JUMP 0x0x8c050cca;
8c050c68:	61 b9       	R1 = [FP -0x28];
8c050c6a:	11 0c       	CC = R1 == 0x2;
8c050c6c:	2a 10       	IF !CC JUMP 0x0x8c050cc0;
8c050c6e:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c050c70:	31 08       	CC = R1 == R6;
8c050c72:	0a 10       	IF !CC JUMP 0x0x8c050c86;
8c050c74:	40 43       	R0 = R0.B (Z);
8c050c76:	00 0c       	CC = R0 == 0x0;
8c050c78:	07 18       	IF CC JUMP 0x0x8c050c86;
8c050c7a:	0d 30       	R1 = R5;
8c050c7c:	07 30       	R0 = R7;
8c050c7e:	ff e3 fd ef 	CALL 0x0x8c04ec78;
8c050c82:	61 b9       	R1 = [FP -0x28];
8c050c84:	f6 2f       	JUMP.S 0x0x8c050c70;
8c050c86:	11 0c       	CC = R1 == 0x2;
8c050c88:	8d 17       	IF !CC JUMP 0x0x8c050ba2 (BP);
8c050c8a:	20 b9       	R0 = [FP -0x38];
8c050c8c:	81 60       	R1 = 0x10 (X);		/*		R1=0x4c( 76) */
8c050c8e:	01 0a       	CC = R1 <= R0 (IU);
8c050c90:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c050c92:	09 18       	IF CC JUMP 0x0x8c050ca4;
8c050c94:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050c96:	b1 e6 5c 00 	B[SP + 0x5c] = R1;
8c050c9a:	86 6c       	SP += 0x10;		/* ( 16) */
8c050c9c:	a5 05       	(R7:4, P5:5) = [SP++];
8c050c9e:	01 e8 00 00 	UNLINK;
8c050ca2:	10 00       	RTS;
8c050ca4:	d0 b8       	R0 = [FP -0x4c];
8c050ca6:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050caa:	e4 e3 00 00 
8c050cae:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050cb0:	b1 e6 5c 00 	B[SP + 0x5c] = R1;
8c050cb4:	86 6c       	SP += 0x10;		/* ( 16) */
8c050cb6:	a5 05       	(R7:4, P5:5) = [SP++];
8c050cb8:	01 e8 00 00 	UNLINK;
8c050cbc:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c050cbe:	10 00       	RTS;
8c050cc0:	50 60       	R0 = 0xa (X);		/*		R0=0x5d( 93) */
8c050cc2:	01 08       	CC = R1 == R0;
8c050cc4:	d5 1f       	IF CC JUMP 0x0x8c050c6e (BP);
8c050cc6:	31 08       	CC = R1 == R6;
8c050cc8:	d3 1f       	IF CC JUMP 0x0x8c050c6e (BP);
8c050cca:	47 30       	R0 = FP;
8c050ccc:	20 67       	R0 += -0x1c;		/* (-28) */
8c050cce:	01 da 80 11 	R1=293609680;
8c050cd2:	d0 20 00 00 
8c050cd6:	ff e3 95 70 	CALL 0x0x8c03ee00;
8c050cda:	07 30       	R0 = R7;
8c050cdc:	0d 30       	R1 = R5;
8c050cde:	61 64       	R1 += 0xc;		/* ( 12) */
8c050ce0:	11 68       	P1 = 0x2 (X);		/*		P1=0x0(  0) */
8c050ce2:	82 ce 05 c4 	R2 = ROT R5 BY 0x0 || [SP + 0xc] = P1 || NOP;
8c050ce6:	f1 bc 00 00 
8c050cea:	ff e3 51 fb 	CALL 0x0x8c05038c;
8c050cee:	86 60       	R6 = 0x10 (X);		/*		R6=0x5c( 92) */
8c050cf0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x4] || NOP;
8c050cf4:	f0 b9 00 00 
8c050cf8:	06 0a       	CC = R6 <= R0 (IU);
8c050cfa:	1e 18       	IF CC JUMP 0x0x8c050d36;
8c050cfc:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050cfe:	b1 e6 90 00 	B[SP + 0x90] = R1;
8c050d02:	04 cc 12 44 	R2 = R2 - R2 (NS) || R1 = [FP -0x38] || NOP;
8c050d06:	21 b9 00 00 
8c050d0a:	7b 60       	R3 = 0xf (X);		/*		R3=0x58( 88) */
8c050d0c:	0e 0a       	CC = R6 <= R1 (IU);
8c050d0e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP -0x8] = R2 || NOP;
8c050d12:	e2 bb 00 00 
8c050d16:	f3 bb       	[FP -0x4] = R3;
8c050d18:	be 17       	IF !CC JUMP 0x0x8c050c94 (BP);
8c050d1a:	d0 b8       	R0 = [FP -0x4c];
8c050d1c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050d20:	e4 e3 00 00 
8c050d24:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050d26:	b1 e6 5c 00 	B[SP + 0x5c] = R1;
8c050d2a:	86 6c       	SP += 0x10;		/* ( 16) */
8c050d2c:	07 30       	R0 = R7;
8c050d2e:	a5 05       	(R7:4, P5:5) = [SP++];
8c050d30:	01 e8 00 00 	UNLINK;
8c050d34:	10 00       	RTS;
8c050d36:	a0 b9       	R0 = [FP -0x18];
8c050d38:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050d3c:	e4 e3 00 00 
8c050d40:	de 2f       	JUMP.S 0x0x8c050cfc;
8c050d42:	07 30       	R0 = R7;
8c050d44:	11 60       	R1 = 0x2 (X);		/*		R1=0x4c( 76) */
8c050d46:	ff e3 fb fa 	CALL 0x0x8c05033c;
8c050d4a:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x38] || NOP;
8c050d4e:	20 b9 00 00 
8c050d52:	81 60       	R1 = 0x10 (X);		/*		R1=0x4c( 76) */
8c050d54:	01 0a       	CC = R1 <= R0 (IU);
8c050d56:	07 30       	R0 = R7;
8c050d58:	9e 17       	IF !CC JUMP 0x0x8c050c94 (BP);
8c050d5a:	d0 b8       	R0 = [FP -0x4c];
8c050d5c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050d60:	e4 e3 00 00 
8c050d64:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050d66:	b1 e6 5c 00 	B[SP + 0x5c] = R1;
8c050d6a:	86 6c       	SP += 0x10;		/* ( 16) */
8c050d6c:	07 30       	R0 = R7;
8c050d6e:	a5 05       	(R7:4, P5:5) = [SP++];
8c050d70:	01 e8 00 00 	UNLINK;
8c050d74:	10 00       	RTS;
8c050d76:	47 30       	R0 = FP;
8c050d78:	20 67       	R0 += -0x1c;		/* (-28) */
8c050d7a:	01 da 80 11 	R1=293609640;
8c050d7e:	a8 20 00 00 
8c050d82:	ff e3 3f 70 	CALL 0x0x8c03ee00;
8c050d86:	07 30       	R0 = R7;
8c050d88:	0c 30       	R1 = R4;
8c050d8a:	c1 64       	R1 += 0x18;		/* ( 24) */
8c050d8c:	11 68       	P1 = 0x2 (X);		/*		P1=0x0(  0) */
8c050d8e:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || [SP + 0xc] = P1 || NOP;
8c050d92:	f1 bc 00 00 
8c050d96:	ff e3 fb fa 	CALL 0x0x8c05038c;
8c050d9a:	86 60       	R6 = 0x10 (X);		/*		R6=0x5c( 92) */
8c050d9c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x4] || NOP;
8c050da0:	f0 b9 00 00 
8c050da4:	06 0a       	CC = R6 <= R0 (IU);
8c050da6:	1e 18       	IF CC JUMP 0x0x8c050de2;
8c050da8:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050daa:	b1 e6 90 00 	B[SP + 0x90] = R1;
8c050dae:	04 cc 12 44 	R2 = R2 - R2 (NS) || R1 = [FP -0x38] || NOP;
8c050db2:	21 b9 00 00 
8c050db6:	7b 60       	R3 = 0xf (X);		/*		R3=0x58( 88) */
8c050db8:	0e 0a       	CC = R6 <= R1 (IU);
8c050dba:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP -0x8] = R2 || NOP;
8c050dbe:	e2 bb 00 00 
8c050dc2:	f3 bb       	[FP -0x4] = R3;
8c050dc4:	68 17       	IF !CC JUMP 0x0x8c050c94 (BP);
8c050dc6:	d0 b8       	R0 = [FP -0x4c];
8c050dc8:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050dcc:	e4 e3 00 00 
8c050dd0:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050dd2:	b1 e6 5c 00 	B[SP + 0x5c] = R1;
8c050dd6:	86 6c       	SP += 0x10;		/* ( 16) */
8c050dd8:	07 30       	R0 = R7;
8c050dda:	a5 05       	(R7:4, P5:5) = [SP++];
8c050ddc:	01 e8 00 00 	UNLINK;
8c050de0:	10 00       	RTS;
8c050de2:	a0 b9       	R0 = [FP -0x18];
8c050de4:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050de8:	e4 e3 00 00 
8c050dec:	de 2f       	JUMP.S 0x0x8c050da8;
8c050dee:	07 30       	R0 = R7;
8c050df0:	11 60       	R1 = 0x2 (X);		/*		R1=0x4c( 76) */
8c050df2:	ff e3 a5 fa 	CALL 0x0x8c05033c;
8c050df6:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x38] || NOP;
8c050dfa:	20 b9 00 00 
8c050dfe:	81 60       	R1 = 0x10 (X);		/*		R1=0x4c( 76) */
8c050e00:	01 0a       	CC = R1 <= R0 (IU);
8c050e02:	07 30       	R0 = R7;
8c050e04:	48 17       	IF !CC JUMP 0x0x8c050c94 (BP);
8c050e06:	d0 b8       	R0 = [FP -0x4c];
8c050e08:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050e0c:	e4 e3 00 00 
8c050e10:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050e12:	b1 e6 5c 00 	B[SP + 0x5c] = R1;
8c050e16:	86 6c       	SP += 0x10;		/* ( 16) */
8c050e18:	07 30       	R0 = R7;
8c050e1a:	a5 05       	(R7:4, P5:5) = [SP++];
8c050e1c:	01 e8 00 00 	UNLINK;
8c050e20:	10 00       	RTS;
8c050e22:	46 30       	R0 = SP;
8c050e24:	83 61       	R3 = 0x30 (X);		/*		R3=0x58( 88) */
8c050e26:	18 50       	R0 = R0 + R3;
8c050e28:	01 da 80 11 	R1=293609724;
8c050e2c:	fc 20 00 00 
8c050e30:	ff e3 e8 6f 	CALL 0x0x8c03ee00;
8c050e34:	0d 30       	R1 = R5;
8c050e36:	11 68       	P1 = 0x2 (X);		/*		P1=0x0(  0) */
8c050e38:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = P1 || NOP;
8c050e3c:	f1 bc 00 00 
8c050e40:	15 30       	R2 = R5;
8c050e42:	21 67       	R1 += -0x1c;		/* (-28) */
8c050e44:	ff e3 a4 fa 	CALL 0x0x8c05038c;
8c050e48:	86 60       	R6 = 0x10 (X);		/*		R6=0x5c( 92) */
8c050e4a:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R1 = [FP -0x60] || R0 = [SP + 0x34];
8c050e4e:	81 b8 70 a3 
8c050e52:	0e 0a       	CC = R6 <= R1 (IU);
8c050e54:	1e 18       	IF CC JUMP 0x0x8c050e90;
8c050e56:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050e58:	b1 e6 34 00 	B[SP + 0x34] = R1;
8c050e5c:	04 cc 12 44 	R2 = R2 - R2 (NS) || R1 = [FP -0x38] || NOP;
8c050e60:	21 b9 00 00 
8c050e64:	7b 60       	R3 = 0xf (X);		/*		R3=0x58( 88) */
8c050e66:	0e 0a       	CC = R6 <= R1 (IU);
8c050e68:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP -0x64] = R2 || NOP;
8c050e6c:	72 ba 00 00 
8c050e70:	83 ba       	[FP -0x60] = R3;
8c050e72:	11 17       	IF !CC JUMP 0x0x8c050c94 (BP);
8c050e74:	d0 b8       	R0 = [FP -0x4c];
8c050e76:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050e7a:	e4 e3 00 00 
8c050e7e:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050e80:	b1 e6 5c 00 	B[SP + 0x5c] = R1;
8c050e84:	86 6c       	SP += 0x10;		/* ( 16) */
8c050e86:	07 30       	R0 = R7;
8c050e88:	a5 05       	(R7:4, P5:5) = [SP++];
8c050e8a:	01 e8 00 00 	UNLINK;
8c050e8e:	10 00       	RTS;
8c050e90:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050e94:	e4 e3 00 00 
8c050e98:	df 2f       	JUMP.S 0x0x8c050e56;
8c050e9a:	11 b9       	R1 = [FP -0x3c];
8c050e9c:	01 0c       	CC = R1 == 0x0;
8c050e9e:	9f 16       	IF !CC JUMP 0x0x8c050bdc (BP);
8c050ea0:	20 b9       	R0 = [FP -0x38];
8c050ea2:	81 60       	R1 = 0x10 (X);		/*		R1=0x4c( 76) */
8c050ea4:	01 0a       	CC = R1 <= R0 (IU);
8c050ea6:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c050ea8:	f6 16       	IF !CC JUMP 0x0x8c050c94 (BP);
8c050eaa:	d0 b8       	R0 = [FP -0x4c];
8c050eac:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c050eb0:	e4 e3 00 00 
8c050eb4:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8c050eb6:	b1 e6 5c 00 	B[SP + 0x5c] = R1;
8c050eba:	86 6c       	SP += 0x10;		/* ( 16) */
8c050ebc:	a5 05       	(R7:4, P5:5) = [SP++];
8c050ebe:	01 e8 00 00 	UNLINK;
8c050ec2:	08 60       	R0 = 0x1 (X);		/*		R0=0x5d( 93) */
8c050ec4:	10 00       	RTS;
8c050ec6:	00 00       	NOP;
8c050ec8:	00 e8 03 00 	LINK 0xc;		/* (12) */
8c050ecc:	00 da 00 08 	R0=134259784;
8c050ed0:	48 a4 00 00 
8c050ed4:	00 de ed 8f 	CALL.A 0x8fed50b2;
8c050ed8:	b2 50 00 00 
8c050edc:	02 da c0 86 	R2=-2034223356;
8c050ee0:	04 37 00 00 
8c050ee4:	01 da 00 08 	R1=134259784;
8c050ee8:	48 a4 00 00 
8c050eec:	00 da ed 8f 	R0=-1880273006;
8c050ef0:	92 4f 00 00 
8c050ef4:	00 de ed 8f 	CALL.A 0x8fed4b1e;
8c050ef8:	1e 4b 00 00 
8c050efc:	01 e8 00 00 	UNLINK;
