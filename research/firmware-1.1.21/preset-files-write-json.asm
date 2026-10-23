
os.ldr@0x8c03f500:     file format binary


Disassembly of section .data:

8c03f500 <.data>:
8c03f500:	00 e8 15 00 	LINK 0x54;		/* (84) */
8c03f504:	60 05       	[--SP] = (R7:4);
8c03f506:	86 6f       	SP += -0x10;		/* (-16) */
8c03f508:	03 61       	R3 = 0x20 (X);		/*		R3=0x0(  0) */
8c03f50a:	56 30       	R2 = SP;
8c03f50c:	04 cc 13 0e 	R7 = R2 + R3 (NS) || [FP + 0x8] = R0 || NOP;
8c03f510:	b8 b0 00 00 
8c03f514:	07 30       	R0 = R7;
8c03f516:	31 30       	R6 = R1;
8c03f518:	ff e3 b5 fc 	CALL 0x0x8c03ee82;
8c03f51c:	0f 30       	R1 = R7;
8c03f51e:	e7 64       	R7 += 0x1c;		/* ( 28) */
8c03f520:	02 da 90 11 	R2=294680284;
8c03f524:	dc 76 00 00 
8c03f528:	07 30       	R0 = R7;
8c03f52a:	42 64       	R2 += 0x8;		/* (  8) */
8c03f52c:	ff e3 34 fe 	CALL 0x0x8c03f194;
8c03f530:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
8c03f532:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R0 = [SP + 0x38] || NOP;
8c03f536:	b0 a3 00 00 
8c03f53a:	05 0a       	CC = R5 <= R0 (IU);
8c03f53c:	6e 18       	IF CC JUMP 0x0x8c03f618;
8c03f53e:	b7 e6 24 00 	B[SP + 0x24] = R7;
8c03f542:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8c03f544:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0x34] = R7 || NOP;
8c03f548:	77 b3 00 00 
8c03f54c:	b3 b3       	[SP + 0x38] = R3;
8c03f54e:	01 da 90 11 	R1=294680284;
8c03f552:	dc 76 00 00 
8c03f556:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8c03f55a:	b8 00 02 00 
8c03f55e:	ff e3 33 f8 	CALL 0x0x8c03e5c4;
8c03f562:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8c03f566:	b8 00 01 00 
8c03f56a:	08 08       	CC = R0 == R1;
8c03f56c:	67 30       	R4 = FP;
8c03f56e:	3e 18       	IF CC JUMP 0x0x8c03f5ea;
8c03f570:	0e 32       	P1 = R6;
8c03f572:	08 64       	R0 += 0x1;		/* (  1) */
8c03f574:	24 67       	R4 += -0x1c;		/* (-28) */
8c03f576:	10 30       	R2 = R0;
8c03f578:	0e 30       	R1 = R6;
8c03f57a:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R3 = [P1 + 0x14] || NOP;
8c03f57e:	4b a1 00 00 
8c03f582:	f3 b0       	[SP + 0xc] = R3;
8c03f584:	ff e3 91 fb 	CALL 0x0x8c03eca6;
8c03f588:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8c03f58c:	b8 a0 00 00 
8c03f590:	14 30       	R2 = R4;
8c03f592:	21 67       	R1 += -0x1c;		/* (-28) */
8c03f594:	ff e3 a8 fd 	CALL 0x0x8c03f0e4;
8c03f598:	f0 b9       	R0 = [FP -0x4];
8c03f59a:	05 0a       	CC = R5 <= R0 (IU);
8c03f59c:	21 18       	IF CC JUMP 0x0x8c03f5de;
8c03f59e:	03 c8 00 18 	MNOP || R0 = [FP -0x20] || [FP -0x8] = R7;
8c03f5a2:	80 b9 e7 bb 
8c03f5a6:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8c03f5a8:	05 0a       	CC = R5 <= R0 (IU);
8c03f5aa:	b7 e6 5c 00 	B[SP + 0x5c] = R7;
8c03f5ae:	03 c8 00 18 	MNOP || [FP -0x4] = R1 || R0 = [FP -0x34];
8c03f5b2:	f1 bb 30 b9 
8c03f5b6:	09 18       	IF CC JUMP 0x0x8c03f5c8;
8c03f5b8:	b7 e6 40 00 	B[SP + 0x40] = R7;
8c03f5bc:	86 6c       	SP += 0x10;		/* ( 16) */
8c03f5be:	20 05       	(R7:4) = [SP++];
8c03f5c0:	01 e8 00 00 	UNLINK;
8c03f5c4:	10 00       	RTS;
8c03f5c6:	00 00       	NOP;
8c03f5c8:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f5cc:	e4 e3 00 00 
8c03f5d0:	b7 e6 40 00 	B[SP + 0x40] = R7;
8c03f5d4:	86 6c       	SP += 0x10;		/* ( 16) */
8c03f5d6:	20 05       	(R7:4) = [SP++];
8c03f5d8:	01 e8 00 00 	UNLINK;
8c03f5dc:	10 00       	RTS;
8c03f5de:	a0 b9       	R0 = [FP -0x18];
8c03f5e0:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f5e4:	e4 e3 00 00 
8c03f5e8:	db 2f       	JUMP.S 0x0x8c03f59e;
8c03f5ea:	44 66       	R4 += -0x38;		/* (-56) */
8c03f5ec:	82 ce 06 c4 	R2 = ROT R6 BY 0x0 || R0 = [FP + 0x8] || NOP;
8c03f5f0:	b8 a0 00 00 
8c03f5f4:	0c 30       	R1 = R4;
8c03f5f6:	ff e3 77 fd 	CALL 0x0x8c03f0e4;
8c03f5fa:	80 b9       	R0 = [FP -0x20];
8c03f5fc:	05 0a       	CC = R5 <= R0 (IU);
8c03f5fe:	dd 17       	IF !CC JUMP 0x0x8c03f5b8 (BP);
8c03f600:	30 b9       	R0 = [FP -0x34];
8c03f602:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f606:	e4 e3 00 00 
8c03f60a:	b7 e6 40 00 	B[SP + 0x40] = R7;
8c03f60e:	86 6c       	SP += 0x10;		/* ( 16) */
8c03f610:	20 05       	(R7:4) = [SP++];
8c03f612:	01 e8 00 00 	UNLINK;
8c03f616:	10 00       	RTS;
8c03f618:	70 a2       	R0 = [SP + 0x24];
8c03f61a:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f61e:	e4 e3 00 00 
8c03f622:	8e 2f       	JUMP.S 0x0x8c03f53e;
8c03f624:	00 e8 17 00 	LINK 0x5c;		/* (92) */
8c03f628:	e5 05       	[--SP] = (R7:4, P5:5);
8c03f62a:	46 6f       	SP += -0x18;		/* (-24) */
8c03f62c:	31 30       	R6 = R1;
8c03f62e:	20 30       	R4 = R0;
8c03f630:	61 61       	R1 = 0x2c (X);		/*		R1=0x0(  0) */
8c03f632:	46 30       	R0 = SP;
8c03f634:	48 51       	R5 = R0 + R1;
8c03f636:	05 30       	R0 = R5;
8c03f638:	00 e3 0d a9 	CALL 0x0x8c054852;
8c03f63c:	05 30       	R0 = R5;
8c03f63e:	16 30       	R2 = R6;
8c03f640:	0d 30       	R1 = R5;
8c03f642:	20 65       	R0 += 0x24;		/* ( 36) */
8c03f644:	7f 30       	R7 = FP;
8c03f646:	00 e3 41 a9 	CALL 0x0x8c0548c8;
8c03f64a:	27 67       	R7 += -0x1c;		/* (-28) */
8c03f64c:	07 30       	R0 = R7;
8c03f64e:	0c 30       	R1 = R4;
8c03f650:	ff e3 58 ff 	CALL 0x0x8c03f500;
8c03f654:	03 c8 00 18 	MNOP || R3 = [FP -0x20] || R0 = [FP -0x34];
8c03f658:	83 b9 30 b9 
8c03f65c:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8c03f65e:	4f 30       	R1 = FP;
8c03f660:	1e 0a       	CC = R6 <= R3 (IU);
8c03f662:	61 66       	R1 += -0x34;		/* (-52) */
8c03f664:	08 07       	IF CC R1 = R0;
8c03f666:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R2 = [FP -0x24] || NOP;
8c03f66a:	72 b9 00 00 
8c03f66e:	ff e3 33 fb 	CALL 0x0x8c03ecd4;
8c03f672:	00 0c       	CC = R0 == 0x0;
8c03f674:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P0 = [FP -0x18] || R1 = [FP -0x4];
8c03f678:	a8 b9 f1 b9 
8c03f67c:	5c 10       	IF !CC JUMP 0x0x8c03f734;
8c03f67e:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c03f682:	fc 1e 00 00 
8c03f686:	98 0c       	CC = R0 < 0x3;
8c03f688:	41 10       	IF !CC JUMP 0x0x8c03f70a;
8c03f68a:	f0 b9       	R0 = [FP -0x4];
8c03f68c:	06 0a       	CC = R6 <= R0 (IU);
8c03f68e:	38 18       	IF CC JUMP 0x0x8c03f6fe;
8c03f690:	b7 e6 70 00 	B[SP + 0x70] = R7;
8c03f694:	03 c8 00 18 	MNOP || R0 = [FP -0x20] || [FP -0x8] = R7;
8c03f698:	80 b9 e7 bb 
8c03f69c:	06 0a       	CC = R6 <= R0 (IU);
8c03f69e:	7c 60       	R4 = 0xf (X);		/*		R4=0x0(  0) */
8c03f6a0:	03 c8 00 18 	MNOP || [FP -0x4] = R4 || R0 = [FP -0x34];
8c03f6a4:	f4 bb 30 b9 
8c03f6a8:	26 18       	IF CC JUMP 0x0x8c03f6f4;
8c03f6aa:	00 da 80 11 	R0=293612244;
8c03f6ae:	d4 2a 00 00 
8c03f6b2:	03 c8 00 18 	MNOP || [SP + 0x2c] = R0 || R0 = [FP -0x40];
8c03f6b6:	f0 b2 00 b9 
8c03f6ba:	06 0a       	CC = R6 <= R0 (IU);
8c03f6bc:	77 bb       	[FP -0x24] = R7;
8c03f6be:	b7 e6 54 00 	B[SP + 0x54] = R7;
8c03f6c2:	03 c8 00 18 	MNOP || [FP -0x20] = R4 || R0 = [SP + 0x34];
8c03f6c6:	84 bb 70 a3 
8c03f6ca:	0f 18       	IF CC JUMP 0x0x8c03f6e8;
8c03f6cc:	04 bb       	[FP -0x40] = R4;
8c03f6ce:	f7 ba       	[FP -0x44] = R7;
8c03f6d0:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8c03f6d2:	b1 e6 34 00 	B[SP + 0x34] = R1;
8c03f6d6:	05 30       	R0 = R5;
8c03f6d8:	00 e3 b6 a8 	CALL 0x0x8c054844;
8c03f6dc:	c6 6c       	SP += 0x18;		/* ( 24) */
8c03f6de:	07 30       	R0 = R7;
8c03f6e0:	a5 05       	(R7:4, P5:5) = [SP++];
8c03f6e2:	01 e8 00 00 	UNLINK;
8c03f6e6:	10 00       	RTS;
8c03f6e8:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f6ec:	e4 e3 00 00 
8c03f6f0:	ee 2f       	JUMP.S 0x0x8c03f6cc;
8c03f6f2:	00 00       	NOP;
8c03f6f4:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f6f8:	e4 e3 00 00 
8c03f6fc:	d7 2f       	JUMP.S 0x0x8c03f6aa;
8c03f6fe:	a0 b9       	R0 = [FP -0x18];
8c03f700:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f704:	e4 e3 00 00 
8c03f708:	c4 2f       	JUMP.S 0x0x8c03f690;
8c03f70a:	f0 b9       	R0 = [FP -0x4];
8c03f70c:	4f 32       	P1 = FP;
8c03f70e:	06 0a       	CC = R6 <= R0 (IU);
8c03f710:	41 6f       	P1 += -0x18;		/* (-24) */
8c03f712:	c8 07       	IF CC P1 = P0;
8c03f714:	31 bd       	[SP + 0x10] = P1;
8c03f716:	09 da 90 11 	P1=294680632;
8c03f71a:	38 78 00 00 
8c03f71e:	f1 bc       	[SP + 0xc] = P1;
8c03f720:	22 e1 f5 01 	R2 = 0x1f5 (X);		/*		R2=0x1f5(501) */
8c03f724:	01 da 90 11 	R1=294680312;
8c03f728:	f8 76 00 00 
8c03f72c:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8c03f72e:	00 e3 23 07 	CALL 0x0x8c040574;
8c03f732:	ac 2f       	JUMP.S 0x0x8c03f68a;
8c03f734:	2c 32       	P5 = R4;
8c03f736:	a2 b9       	R2 = [FP -0x18];
8c03f738:	47 30       	R0 = FP;
8c03f73a:	0e 0a       	CC = R6 <= R1 (IU);
8c03f73c:	40 67       	R0 += -0x18;		/* (-24) */
8c03f73e:	02 07       	IF CC R0 = R2;
8c03f740:	24 64       	R4 += 0x4;		/* (  4) */
8c03f742:	a9 a1       	R1 = [P5 + 0x18];
8c03f744:	0c 32       	P1 = R4;
8c03f746:	0e 0a       	CC = R6 <= R1 (IU);
8c03f748:	0c 30       	R1 = R4;
8c03f74a:	02 10       	IF !CC JUMP 0x0x8c03f74e;
8c03f74c:	09 91       	R1 = [P1];
8c03f74e:	ff e3 d1 f5 	CALL 0x0x8c03e2f0;
8c03f752:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P1 = [FP -0x18] || R0 = [FP -0x4];
8c03f756:	a9 b9 f0 b9 
8c03f75a:	07 0c       	CC = R7 == 0x0;
8c03f75c:	58 10       	IF !CC JUMP 0x0x8c03f80c;
8c03f75e:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c03f762:	fc 1e 00 00 
8c03f766:	98 0c       	CC = R0 < 0x3;
8c03f768:	37 10       	IF !CC JUMP 0x0x8c03f7d6;
8c03f76a:	f0 b9       	R0 = [FP -0x4];
8c03f76c:	06 0a       	CC = R6 <= R0 (IU);
8c03f76e:	2e 18       	IF CC JUMP 0x0x8c03f7ca;
8c03f770:	b7 e6 70 00 	B[SP + 0x70] = R7;
8c03f774:	03 c8 00 18 	MNOP || R0 = [FP -0x20] || [FP -0x8] = R7;
8c03f778:	80 b9 e7 bb 
8c03f77c:	06 0a       	CC = R6 <= R0 (IU);
8c03f77e:	7c 60       	R4 = 0xf (X);		/*		R4=0x0(  0) */
8c03f780:	03 c8 00 18 	MNOP || [FP -0x4] = R4 || R0 = [FP -0x34];
8c03f784:	f4 bb 30 b9 
8c03f788:	1c 18       	IF CC JUMP 0x0x8c03f7c0;
8c03f78a:	00 da 80 11 	R0=293612244;
8c03f78e:	d4 2a 00 00 
8c03f792:	03 c8 00 18 	MNOP || [SP + 0x2c] = R0 || R0 = [FP -0x40];
8c03f796:	f0 b2 00 b9 
8c03f79a:	06 0a       	CC = R6 <= R0 (IU);
8c03f79c:	77 bb       	[FP -0x24] = R7;
8c03f79e:	b7 e6 54 00 	B[SP + 0x54] = R7;
8c03f7a2:	03 c8 00 18 	MNOP || [FP -0x20] = R4 || R0 = [SP + 0x34];
8c03f7a6:	84 bb 70 a3 
8c03f7aa:	05 18       	IF CC JUMP 0x0x8c03f7b4;
8c03f7ac:	04 bb       	[FP -0x40] = R4;
8c03f7ae:	f7 ba       	[FP -0x44] = R7;
8c03f7b0:	90 2f       	JUMP.S 0x0x8c03f6d0;
8c03f7b2:	00 00       	NOP;
8c03f7b4:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f7b8:	e4 e3 00 00 
8c03f7bc:	f8 2f       	JUMP.S 0x0x8c03f7ac;
8c03f7be:	00 00       	NOP;
8c03f7c0:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f7c4:	e4 e3 00 00 
8c03f7c8:	e1 2f       	JUMP.S 0x0x8c03f78a;
8c03f7ca:	a0 b9       	R0 = [FP -0x18];
8c03f7cc:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f7d0:	e4 e3 00 00 
8c03f7d4:	ce 2f       	JUMP.S 0x0x8c03f770;
8c03f7d6:	a8 a1       	R0 = [P5 + 0x18];
8c03f7d8:	f1 b9       	R1 = [FP -0x4];
8c03f7da:	47 32       	P0 = FP;
8c03f7dc:	0e 0a       	CC = R6 <= R1 (IU);
8c03f7de:	40 6f       	P0 += -0x18;		/* (-24) */
8c03f7e0:	c1 07       	IF CC P0 = P1;
8c03f7e2:	0c 32       	P1 = R4;
8c03f7e4:	06 0a       	CC = R6 <= R0 (IU);
8c03f7e6:	02 10       	IF !CC JUMP 0x0x8c03f7ea;
8c03f7e8:	0c 91       	R4 = [P1];
8c03f7ea:	74 b1       	[SP + 0x14] = R4;
8c03f7ec:	30 bd       	[SP + 0x10] = P0;
8c03f7ee:	09 da 90 11 	P1=294680668;
8c03f7f2:	5c 78 00 00 
8c03f7f6:	f1 bc       	[SP + 0xc] = P1;
8c03f7f8:	22 e1 ff 01 	R2 = 0x1ff (X);		/*		R2=0x1ff(511) */
8c03f7fc:	01 da 90 11 	R1=294680312;
8c03f800:	f8 76 00 00 
8c03f804:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8c03f806:	00 e3 b7 06 	CALL 0x0x8c040574;
8c03f80a:	b0 2f       	JUMP.S 0x0x8c03f76a;
8c03f80c:	06 0a       	CC = R6 <= R0 (IU);
8c03f80e:	2c 18       	IF CC JUMP 0x0x8c03f866;
8c03f810:	7c 60       	R4 = 0xf (X);		/*		R4=0x0(  0) */
8c03f812:	f4 bb       	[FP -0x4] = R4;
8c03f814:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R0 = [FP -0x20] || NOP;
8c03f818:	80 b9 00 00 
8c03f81c:	06 0a       	CC = R6 <= R0 (IU);
8c03f81e:	e7 bb       	[FP -0x8] = R7;
8c03f820:	b7 e6 70 00 	B[SP + 0x70] = R7;
8c03f824:	1b 18       	IF CC JUMP 0x0x8c03f85a;
8c03f826:	00 da 80 11 	R0=293612244;
8c03f82a:	d4 2a 00 00 
8c03f82e:	03 c8 00 18 	MNOP || [SP + 0x2c] = R0 || R0 = [FP -0x40];
8c03f832:	f0 b2 00 b9 
8c03f836:	06 0a       	CC = R6 <= R0 (IU);
8c03f838:	77 bb       	[FP -0x24] = R7;
8c03f83a:	b7 e6 54 00 	B[SP + 0x54] = R7;
8c03f83e:	03 c8 00 18 	MNOP || [FP -0x20] = R4 || R0 = [SP + 0x34];
8c03f842:	84 bb 70 a3 
8c03f846:	05 18       	IF CC JUMP 0x0x8c03f850;
8c03f848:	04 bb       	[FP -0x40] = R4;
8c03f84a:	f7 ba       	[FP -0x44] = R7;
8c03f84c:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8c03f84e:	41 2f       	JUMP.S 0x0x8c03f6d0;
8c03f850:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f854:	e4 e3 00 00 
8c03f858:	f8 2f       	JUMP.S 0x0x8c03f848;
8c03f85a:	30 b9       	R0 = [FP -0x34];
8c03f85c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f860:	e4 e3 00 00 
8c03f864:	e1 2f       	JUMP.S 0x0x8c03f826;
8c03f866:	a0 b9       	R0 = [FP -0x18];
8c03f868:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03f86c:	e4 e3 00 00 
8c03f870:	d0 2f       	JUMP.S 0x0x8c03f810;
