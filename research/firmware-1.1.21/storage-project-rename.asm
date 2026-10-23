
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d55f4b8 <.data+0x93498>:
8d55f4b8:	00 e8 39 00 	LINK 0xe4;		/* (228) */
8d55f4bc:	e4 05       	[--SP] = (R7:4, P5:4);
8d55f4be:	46 6f       	SP += -0x18;		/* (-24) */
8d55f4c0:	09 da eb 84 	P1=-2064952336;
8d55f4c4:	f0 53 00 00 
8d55f4c8:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R0 = [P1 + 0x14] || NOP;
8d55f4cc:	48 a1 00 00 
8d55f4d0:	00 0c       	CC = R0 == 0x0;
8d55f4d2:	a3 19       	IF CC JUMP 0x0x8d55f818;
8d55f4d4:	06 30       	R0 = R6;
8d55f4d6:	00 e3 ab 0f 	CALL 0x0x8d56142c;
8d55f4da:	25 e1 68 00 	R5 = 0x68 (X);		/*		R5=0x68(104) */
8d55f4de:	46 30       	R0 = SP;
8d55f4e0:	68 51       	R5 = R0 + R5;
8d55f4e2:	27 e1 84 00 	R7 = 0x84 (X);		/*		R7=0x84(132) */
8d55f4e6:	5e 30       	R3 = SP;
8d55f4e8:	05 30       	R0 = R5;
8d55f4ea:	02 da 06 84 	R2=-2079941204;
8d55f4ee:	ac 9d 00 00 
8d55f4f2:	01 da eb 84 	R1=-2064952336;
8d55f4f6:	f0 53 00 00 
8d55f4fa:	fb 51       	R7 = R3 + R7;
8d55f4fc:	00 de 03 8c 	CALL.A 0x8c03f194;
8d55f500:	94 f1 00 00 
8d55f504:	07 30       	R0 = R7;
8d55f506:	fb e3 6b df 	CALL 0x0x8d4db3dc;
8d55f50a:	07 30       	R0 = R7;
8d55f50c:	0f 30       	R1 = R7;
8d55f50e:	40 66       	R0 += -0x38;		/* (-56) */
8d55f510:	02 e3 94 28 	CALL 0x0x8d5a4638;
8d55f514:	26 e1 4c 00 	R6 = 0x4c (X);		/*		R6=0x4c( 76) */
8d55f518:	5e 30       	R3 = SP;
8d55f51a:	73 50       	R1 = R3 + R6;
8d55f51c:	01 30       	R0 = R1;
8d55f51e:	20 67       	R0 += -0x1c;		/* (-28) */
8d55f520:	7a 61       	R2 = 0x2f (X);		/*		R2=0x0(  0) */
8d55f522:	fc e3 45 15 	CALL 0x0x8d4e1fac;
8d55f526:	0d 30       	R1 = R5;
8d55f528:	41 66       	R1 += -0x38;		/* (-56) */
8d55f52a:	23 e1 70 00 	R3 = 0x70 (X);		/*		R3=0x70(112) */
8d55f52e:	19 50       	R0 = R1 + R3;
8d55f530:	15 30       	R2 = R5;
8d55f532:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d55f536:	e4 f0 00 00 
8d55f53a:	84 60       	R4 = 0x10 (X);		/*		R4=0x0(  0) */
8d55f53c:	30 e4 12 00 	R0 = [SP + 0x48];
8d55f540:	04 0a       	CC = R4 <= R0 (IU);
8d55f542:	64 19       	IF CC JUMP 0x0x8d55f80a;
8d55f544:	05 60       	R5 = 0x0 (X);		/*		R5=0x68(104) */
8d55f546:	35 e6 11 00 	[SP + 0x44] = R5;
8d55f54a:	b5 e6 34 00 	B[SP + 0x34] = R5;
8d55f54e:	30 e4 19 00 	R0 = [SP + 0x64];
8d55f552:	04 0a       	CC = R4 <= R0 (IU);
8d55f554:	7e 60       	R6 = 0xf (X);		/*		R6=0x4c( 76) */
8d55f556:	36 e6 12 00 	[SP + 0x48] = R6;
8d55f55a:	53 19       	IF CC JUMP 0x0x8d55f800;
8d55f55c:	b5 e6 50 00 	B[SP + 0x50] = R5;
8d55f560:	36 e6 19 00 	[SP + 0x64] = R6;
8d55f564:	35 e6 18 00 	[SP + 0x60] = R5;
8d55f568:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d55f56c:	fc 1e 00 00 
8d55f570:	98 0c       	CC = R0 < 0x3;
8d55f572:	0d da 06 84 	P5=-2079940924;
8d55f576:	c4 9e 00 00 
8d55f57a:	21 11       	IF !CC JUMP 0x0x8d55f7bc;
8d55f57c:	4e 30       	R1 = SP;
8d55f57e:	23 e1 a4 00 	R3 = 0xa4 (X);		/*		R3=0xa4(164) */
8d55f582:	04 cc 0b 02 	R1 = R1 + R3 (NS) || R3 = [FP -0x78] || NOP;
8d55f586:	23 b8 00 00 
8d55f58a:	46 30       	R0 = SP;
8d55f58c:	22 e1 88 00 	R2 = 0x88 (X);		/*		R2=0x88(136) */
8d55f590:	1c 0a       	CC = R4 <= R3 (IU);
8d55f592:	04 cc 02 00 	R0 = R0 + R2 (NS) || R2 = [FP -0x5c] || NOP;
8d55f596:	92 b8 00 00 
8d55f59a:	33 e4 22 00 	R3 = [SP + 0x88];
8d55f59e:	03 07       	IF CC R0 = R3;
8d55f5a0:	14 0a       	CC = R4 <= R2 (IU);
8d55f5a2:	43 b8       	R3 = [FP -0x70];
8d55f5a4:	0b 07       	IF CC R1 = R3;
8d55f5a6:	00 de 03 8c 	CALL.A 0x8c03e2f0;
8d55f5aa:	f0 e2 00 00 
8d55f5ae:	00 0c       	CC = R0 == 0x0;
8d55f5b0:	07 10       	IF !CC JUMP 0x0x8d55f5be;
8d55f5b2:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d55f5b6:	fc 1e 00 00 
8d55f5ba:	88 0c       	CC = R0 < 0x1;
8d55f5bc:	ee 10       	IF !CC JUMP 0x0x8d55f798;
8d55f5be:	0f 30       	R1 = R7;
8d55f5c0:	c7 65       	R7 += 0x38;		/* ( 56) */
8d55f5c2:	07 30       	R0 = R7;
8d55f5c4:	00 e3 de 07 	CALL 0x0x8d560580;
8d55f5c8:	27 e1 a0 00 	R7 = 0xa0 (X);		/*		R7=0xa0(160) */
8d55f5cc:	56 30       	R2 = SP;
8d55f5ce:	7a 50       	R1 = R2 + R7;
8d55f5d0:	01 30       	R0 = R1;
8d55f5d2:	c0 65       	R0 += 0x38;		/* ( 56) */
8d55f5d4:	00 e3 d6 07 	CALL 0x0x8d560580;
8d55f5d8:	5e 30       	R3 = SP;
8d55f5da:	22 e1 c0 00 	R2 = 0xc0 (X);		/*		R2=0xc0(192) */
8d55f5de:	04 cc 1a 00 	R0 = R3 + R2 (NS) || R1 = [FP -0x40] || R2 = [FP -0x54];
8d55f5e2:	01 b9 b2 b8 
8d55f5e6:	0c 0a       	CC = R4 <= R1 (IU);
8d55f5e8:	02 07       	IF CC R0 = R2;
8d55f5ea:	00 de 03 8c 	CALL.A 0x8c03e328;
8d55f5ee:	28 e3 00 00 
8d55f5f2:	00 0c       	CC = R0 == 0x0;
8d55f5f4:	7e 10       	IF !CC JUMP 0x0x8d55f6f0;
8d55f5f6:	46 30       	R0 = SP;
8d55f5f8:	b5 e6 50 00 	B[SP + 0x50] = R5;
8d55f5fc:	78 50       	R1 = R0 + R7;
8d55f5fe:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d55f602:	b8 00 03 00 
8d55f606:	27 e1 ac ff 	R7 = -0x54 (X);		/*		R7=0xffffffac(-84) */
8d55f60a:	04 cc 0f 00 	R0 = R1 + R7 (NS) || [SP + 0xc] = R3 || NOP;
8d55f60e:	f3 b0 00 00 
8d55f612:	36 e6 19 00 	[SP + 0x64] = R6;
8d55f616:	35 e6 18 00 	[SP + 0x60] = R5;
8d55f61a:	02 60       	R2 = 0x0 (X);		/*		R2=0xc0(192) */
8d55f61c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d55f620:	70 e9 00 00 
8d55f624:	27 e1 4c 00 	R7 = 0x4c (X);		/*		R7=0x4c( 76) */
8d55f628:	5e 30       	R3 = SP;
8d55f62a:	3b 50       	R0 = R3 + R7;
8d55f62c:	fb e3 2a df 	CALL 0x0x8d4db480;
8d55f630:	30 e4 19 00 	R0 = [SP + 0x64];
8d55f634:	04 0a       	CC = R4 <= R0 (IU);
8d55f636:	55 18       	IF CC JUMP 0x0x8d55f6e0;
8d55f638:	36 e6 19 00 	[SP + 0x64] = R6;
8d55f63c:	35 e6 18 00 	[SP + 0x60] = R5;
8d55f640:	b5 e6 50 00 	B[SP + 0x50] = R5;
8d55f644:	ff e3 7a dc 	CALL 0x0x8d55af38;
8d55f648:	70 b9       	R0 = [FP -0x24];
8d55f64a:	04 0a       	CC = R4 <= R0 (IU);
8d55f64c:	45 18       	IF CC JUMP 0x0x8d55f6d6;
8d55f64e:	65 bb       	[FP -0x28] = R5;
8d55f650:	b5 e6 dc 00 	B[SP + 0xdc] = R5;
8d55f654:	03 c8 00 18 	MNOP || R0 = [FP -0x40] || [FP -0x24] = R6;
8d55f658:	00 b9 76 bb 
8d55f65c:	04 0a       	CC = R4 <= R0 (IU);
8d55f65e:	38 18       	IF CC JUMP 0x0x8d55f6ce;
8d55f660:	f5 ba       	[FP -0x44] = R5;
8d55f662:	b5 e6 c0 00 	B[SP + 0xc0] = R5;
8d55f666:	03 c8 00 18 	MNOP || R0 = [FP -0x5c] || [FP -0x40] = R6;
8d55f66a:	90 b8 06 bb 
8d55f66e:	04 0a       	CC = R4 <= R0 (IU);
8d55f670:	2b 18       	IF CC JUMP 0x0x8d55f6c6;
8d55f672:	85 ba       	[FP -0x60] = R5;
8d55f674:	b5 e6 a4 00 	B[SP + 0xa4] = R5;
8d55f678:	03 c8 00 18 	MNOP || R0 = [FP -0x78] || [FP -0x5c] = R6;
8d55f67c:	20 b8 96 ba 
8d55f680:	04 0a       	CC = R4 <= R0 (IU);
8d55f682:	1d 18       	IF CC JUMP 0x0x8d55f6bc;
8d55f684:	26 ba       	[FP -0x78] = R6;
8d55f686:	15 ba       	[FP -0x7c] = R5;
8d55f688:	b5 e6 88 00 	B[SP + 0x88] = R5;
8d55f68c:	30 e4 20 00 	R0 = [SP + 0x80];
8d55f690:	04 0a       	CC = R4 <= R0 (IU);
8d55f692:	09 18       	IF CC JUMP 0x0x8d55f6a4;
8d55f694:	b5 e6 6c 00 	B[SP + 0x6c] = R5;
8d55f698:	c6 6c       	SP += 0x18;		/* ( 24) */
8d55f69a:	a4 05       	(R7:4, P5:4) = [SP++];
8d55f69c:	01 e8 00 00 	UNLINK;
8d55f6a0:	10 00       	RTS;
8d55f6a2:	00 00       	NOP;
8d55f6a4:	30 e4 1b 00 	R0 = [SP + 0x6c];
8d55f6a8:	fb e3 9e 76 	CALL 0x0x8d4ce3e4;
8d55f6ac:	b5 e6 6c 00 	B[SP + 0x6c] = R5;
8d55f6b0:	c6 6c       	SP += 0x18;		/* ( 24) */
8d55f6b2:	a4 05       	(R7:4, P5:4) = [SP++];
8d55f6b4:	01 e8 00 00 	UNLINK;
8d55f6b8:	10 00       	RTS;
8d55f6ba:	00 00       	NOP;
8d55f6bc:	30 e4 22 00 	R0 = [SP + 0x88];
8d55f6c0:	fb e3 92 76 	CALL 0x0x8d4ce3e4;
8d55f6c4:	e0 2f       	JUMP.S 0x0x8d55f684;
8d55f6c6:	40 b8       	R0 = [FP -0x70];
8d55f6c8:	fb e3 8e 76 	CALL 0x0x8d4ce3e4;
8d55f6cc:	d3 2f       	JUMP.S 0x0x8d55f672;
8d55f6ce:	b0 b8       	R0 = [FP -0x54];
8d55f6d0:	fb e3 8a 76 	CALL 0x0x8d4ce3e4;
8d55f6d4:	c6 2f       	JUMP.S 0x0x8d55f660;
8d55f6d6:	20 b9       	R0 = [FP -0x38];
8d55f6d8:	fb e3 86 76 	CALL 0x0x8d4ce3e4;
8d55f6dc:	b9 2f       	JUMP.S 0x0x8d55f64e;
8d55f6de:	00 00       	NOP;
8d55f6e0:	30 e4 14 00 	R0 = [SP + 0x50];
8d55f6e4:	fb e3 80 76 	CALL 0x0x8d4ce3e4;
8d55f6e8:	a8 2f       	JUMP.S 0x0x8d55f638;
8d55f6ea:	00 00       	NOP;
8d55f6ec:	00 00       	NOP;
8d55f6ee:	00 00       	NOP;
8d55f6f0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d55f6f4:	fc 1e 00 00 
8d55f6f8:	98 0c       	CC = R0 < 0x3;
8d55f6fa:	2f 10       	IF !CC JUMP 0x0x8d55f758;
8d55f6fc:	46 30       	R0 = SP;
8d55f6fe:	22 e1 c0 00 	R2 = 0xc0 (X);		/*		R2=0xc0(192) */
8d55f702:	04 cc 02 00 	R0 = R0 + R2 (NS) || R3 = [FP -0x40] || R2 = [FP -0x54];
8d55f706:	03 b9 b2 b8 
8d55f70a:	1c 0a       	CC = R4 <= R3 (IU);
8d55f70c:	73 b9       	R3 = [FP -0x24];
8d55f70e:	4f 30       	R1 = FP;
8d55f710:	02 07       	IF CC R0 = R2;
8d55f712:	1c 0a       	CC = R4 <= R3 (IU);
8d55f714:	41 66       	R1 += -0x38;		/* (-56) */
8d55f716:	22 b9       	R2 = [FP -0x38];
8d55f718:	0a 07       	IF CC R1 = R2;
8d55f71a:	00 de 03 8c 	CALL.A 0x8c03e2f0;
8d55f71e:	f0 e2 00 00 
8d55f722:	00 0c       	CC = R0 == 0x0;
8d55f724:	69 13       	IF !CC JUMP 0x0x8d55f5f6;
8d55f726:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d55f72a:	fc 1e 00 00 
8d55f72e:	98 0c       	CC = R0 < 0x3;
8d55f730:	63 1f       	IF CC JUMP 0x0x8d55f5f6 (BP);
8d55f732:	09 da 06 84 	P1=-2079941204;
8d55f736:	ac 9d 00 00 
8d55f73a:	a1 6d       	P1 += 0x34;		/* ( 52) */
8d55f73c:	f1 bc       	[SP + 0xc] = P1;
8d55f73e:	22 e1 60 00 	R2 = 0x60 (X);		/*		R2=0x60( 96) */
8d55f742:	01 da 06 84 	R1=-2079941136;
8d55f746:	f0 9d 00 00 
8d55f74a:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d55f74c:	00 de 04 8c 	CALL.A 0x8c040574;
8d55f750:	74 05 00 00 
8d55f754:	51 2f       	JUMP.S 0x0x8d55f5f6;
8d55f756:	00 00       	NOP;
8d55f758:	03 c8 00 18 	MNOP || P2 = [FP -0x54] || R3 = [FP -0x40];
8d55f75c:	ba b8 03 b9 
8d55f760:	03 c8 00 18 	MNOP || [SP + 0xc] = P5 || R2 = [FP -0x24];
8d55f764:	f5 bc 72 b9 
8d55f768:	2d b9       	P5 = [FP -0x38];
8d55f76a:	28 e1 c0 00 	P0 = 0xc0 (X);		/*		P0=0xc0(192) */
8d55f76e:	1c 0a       	CC = R4 <= R3 (IU);
8d55f770:	06 5a       	P0 = SP + P0;
8d55f772:	4f 32       	P1 = FP;
8d55f774:	c2 07       	IF CC P0 = P2;
8d55f776:	14 0a       	CC = R4 <= R2 (IU);
8d55f778:	41 6e       	P1 += -0x38;		/* (-56) */
8d55f77a:	cd 07       	IF CC P1 = P5;
8d55f77c:	30 bd       	[SP + 0x10] = P0;
8d55f77e:	71 bd       	[SP + 0x14] = P1;
8d55f780:	01 da 06 84 	R1=-2079941136;
8d55f784:	f0 9d 00 00 
8d55f788:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d55f78a:	22 e1 5e 00 	R2 = 0x5e (X);		/*		R2=0x5e( 94) */
8d55f78e:	00 de 04 8c 	CALL.A 0x8c040574;
8d55f792:	74 05 00 00 
8d55f796:	b3 2f       	JUMP.S 0x0x8d55f6fc;
8d55f798:	09 da 06 84 	P1=-2079941204;
8d55f79c:	ac 9d 00 00 
8d55f7a0:	21 6d       	P1 += 0x24;		/* ( 36) */
8d55f7a2:	f1 bc       	[SP + 0xc] = P1;
8d55f7a4:	22 e1 58 00 	R2 = 0x58 (X);		/*		R2=0x58( 88) */
8d55f7a8:	01 da 06 84 	R1=-2079941136;
8d55f7ac:	f0 9d 00 00 
8d55f7b0:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d55f7b2:	00 de 04 8c 	CALL.A 0x8c040574;
8d55f7b6:	74 05 00 00 
8d55f7ba:	02 2f       	JUMP.S 0x0x8d55f5be;
8d55f7bc:	34 e5 22 00 	P4 = [SP + 0x88];
8d55f7c0:	03 c8 00 18 	MNOP || P2 = [FP -0x70] || R2 = [FP -0x78];
8d55f7c4:	4a b8 22 b8 
8d55f7c8:	29 e1 88 00 	P1 = 0x88 (X);		/*		P1=0x88(136) */
8d55f7cc:	14 0a       	CC = R4 <= R2 (IU);
8d55f7ce:	4e 5a       	P1 = SP + P1;
8d55f7d0:	03 c8 00 18 	MNOP || R3 = [FP -0x5c] || [SP + 0xc] = P5;
8d55f7d4:	93 b8 f5 bc 
8d55f7d8:	28 e1 a4 00 	P0 = 0xa4 (X);		/*		P0=0xa4(164) */
8d55f7dc:	cc 07       	IF CC P1 = P4;
8d55f7de:	1c 0a       	CC = R4 <= R3 (IU);
8d55f7e0:	06 5a       	P0 = SP + P0;
8d55f7e2:	c2 07       	IF CC P0 = P2;
8d55f7e4:	31 bd       	[SP + 0x10] = P1;
8d55f7e6:	70 bd       	[SP + 0x14] = P0;
8d55f7e8:	01 da 06 84 	R1=-2079941136;
8d55f7ec:	f0 9d 00 00 
8d55f7f0:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d55f7f2:	22 e1 56 00 	R2 = 0x56 (X);		/*		R2=0x56( 86) */
8d55f7f6:	00 de 04 8c 	CALL.A 0x8c040574;
8d55f7fa:	74 05 00 00 
8d55f7fe:	bf 2e       	JUMP.S 0x0x8d55f57c;
8d55f800:	30 e4 14 00 	R0 = [SP + 0x50];
8d55f804:	fb e3 f0 75 	CALL 0x0x8d4ce3e4;
8d55f808:	aa 2e       	JUMP.S 0x0x8d55f55c;
8d55f80a:	70 a3       	R0 = [SP + 0x34];
8d55f80c:	fb e3 ec 75 	CALL 0x0x8d4ce3e4;
8d55f810:	9a 2e       	JUMP.S 0x0x8d55f544;
8d55f812:	00 00       	NOP;
8d55f814:	00 00       	NOP;
8d55f816:	00 00       	NOP;
8d55f818:	00 da 06 84 	R0=-2079940992;
8d55f81c:	80 9e 00 00 
8d55f820:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d55f824:	a4 05 00 00 
8d55f828:	56 2e       	JUMP.S 0x0x8d55f4d4;
8d55f82a:	00 00       	NOP;
8d55f82c:	00 00       	NOP;
8d55f82e:	00 00       	NOP;
8d55f830:	00 e8 32 00 	LINK 0xc8;		/* (200) */
8d55f834:	60 05       	[--SP] = (R7:4);
8d55f836:	86 6f       	SP += -0x10;		/* (-16) */
8d55f838:	09 da eb 84 	P1=-2064952308;
8d55f83c:	0c 54 00 00 
8d55f840:	03 c8 00 18 	MNOP || R1 = [P1 + 0x14] || [FP + 0x8] = R0;
8d55f844:	49 a1 b8 b0 
8d55f848:	01 0c       	CC = R1 == 0x0;
8d55f84a:	af 18       	IF CC JUMP 0x0x8d55f9a8;
8d55f84c:	46 30       	R0 = SP;
8d55f84e:	21 e1 74 00 	R1 = 0x74 (X);		/*		R1=0x74(116) */
8d55f852:	c8 51       	R7 = R0 + R1;
