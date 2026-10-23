
os.ldr@0x8d4e9470:     file format binary


Disassembly of section .data:

8d4e9470 <.data>:
8d4e9470:	00 e8 40 00 	LINK 0x100;		/* (256) */
8d4e9474:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e9476:	66 6f       	SP += -0x14;		/* (-20) */
8d4e9478:	39 30       	R7 = R1;
8d4e947a:	08 30       	R1 = R0;
8d4e947c:	22 30       	R4 = R2;
8d4e947e:	46 30       	R0 = SP;
8d4e9480:	22 e1 44 00 	R2 = 0x44 (X);		/*		R2=0x44( 68) */
8d4e9484:	10 50       	R0 = R0 + R2;
8d4e9486:	ff e3 51 e4 	CALL 0x0x8d4e5d28;
8d4e948a:	30 e4 16 00 	R0 = [SP + 0x58];
8d4e948e:	00 0c       	CC = R0 == 0x0;
8d4e9490:	31 10       	IF !CC JUMP 0x0x8d4e94f2;
8d4e9492:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e9496:	fc 1e 00 00 
8d4e949a:	98 0c       	CC = R0 < 0x3;
8d4e949c:	1a 10       	IF !CC JUMP 0x0x8d4e94d0;
8d4e949e:	30 e4 17 00 	R0 = [SP + 0x5c];
8d4e94a2:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e94a4:	01 0a       	CC = R1 <= R0 (IU);
8d4e94a6:	09 18       	IF CC JUMP 0x0x8d4e94b8;
8d4e94a8:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e94aa:	b0 e6 48 00 	B[SP + 0x48] = R0;
8d4e94ae:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e94b0:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e94b2:	01 e8 00 00 	UNLINK;
8d4e94b6:	10 00       	RTS;
8d4e94b8:	30 e4 12 00 	R0 = [SP + 0x48];
8d4e94bc:	ff e3 94 27 	CALL 0x0x8d4ce3e4;
8d4e94c0:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e94c2:	b0 e6 48 00 	B[SP + 0x48] = R0;
8d4e94c6:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e94c8:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e94ca:	01 e8 00 00 	UNLINK;
8d4e94ce:	10 00       	RTS;
8d4e94d0:	09 da 03 84 	P1=-2080148240;
8d4e94d4:	f0 74 00 00 
8d4e94d8:	f1 bc       	[SP + 0xc] = P1;
8d4e94da:	22 e1 6c 02 	R2 = 0x26c (X);		/*		R2=0x26c(620) */
8d4e94de:	01 da 03 84 	R1=-2080148832;
8d4e94e2:	a0 72 00 00 
8d4e94e6:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d4e94e8:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e94ec:	74 05 00 00 
8d4e94f0:	d7 2f       	JUMP.S 0x0x8d4e949e;
8d4e94f2:	46 30       	R0 = SP;
8d4e94f4:	21 e1 60 00 	R1 = 0x60 (X);		/*		R1=0x60( 96) */
8d4e94f8:	88 50       	R2 = R0 + R1;
8d4e94fa:	02 30       	R0 = R2;
8d4e94fc:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e94fe:	06 60       	R6 = 0x0 (X);		/*		R6=0x0(  0) */
8d4e9500:	7d 60       	R5 = 0xf (X);		/*		R5=0x0(  0) */
8d4e9502:	08 30       	R1 = R0;
8d4e9504:	36 e6 1d 00 	[SP + 0x74] = R6;
8d4e9508:	b6 e6 64 00 	B[SP + 0x64] = R6;
8d4e950c:	36 e6 24 00 	[SP + 0x90] = R6;
8d4e9510:	b6 e6 80 00 	B[SP + 0x80] = R6;
8d4e9514:	35 e6 1e 00 	[SP + 0x78] = R5;
8d4e9518:	35 e6 25 00 	[SP + 0x94] = R5;
8d4e951c:	40 66       	R0 += -0x38;		/* (-56) */
8d4e951e:	ff e3 a1 d2 	CALL 0x0x8d4e3a60;
8d4e9522:	00 0c       	CC = R0 == 0x0;
8d4e9524:	56 10       	IF !CC JUMP 0x0x8d4e95d0;
8d4e9526:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e952a:	fc 1e 00 00 
8d4e952e:	98 0c       	CC = R0 < 0x3;
8d4e9530:	34 10       	IF !CC JUMP 0x0x8d4e9598;
8d4e9532:	30 e4 25 00 	R0 = [SP + 0x94];
8d4e9536:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e9538:	07 0a       	CC = R7 <= R0 (IU);
8d4e953a:	27 18       	IF CC JUMP 0x0x8d4e9588;
8d4e953c:	35 e6 25 00 	[SP + 0x94] = R5;
8d4e9540:	36 e6 24 00 	[SP + 0x90] = R6;
8d4e9544:	b6 e6 80 00 	B[SP + 0x80] = R6;
8d4e9548:	30 e4 1e 00 	R0 = [SP + 0x78];
8d4e954c:	07 0a       	CC = R7 <= R0 (IU);
8d4e954e:	17 18       	IF CC JUMP 0x0x8d4e957c;
8d4e9550:	35 e6 1e 00 	[SP + 0x78] = R5;
8d4e9554:	36 e6 1d 00 	[SP + 0x74] = R6;
8d4e9558:	b6 e6 64 00 	B[SP + 0x64] = R6;
8d4e955c:	30 e4 17 00 	R0 = [SP + 0x5c];
8d4e9560:	07 0a       	CC = R7 <= R0 (IU);
8d4e9562:	a3 17       	IF !CC JUMP 0x0x8d4e94a8 (BP);
8d4e9564:	30 e4 12 00 	R0 = [SP + 0x48];
8d4e9568:	ff e3 3e 27 	CALL 0x0x8d4ce3e4;
8d4e956c:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e956e:	b0 e6 48 00 	B[SP + 0x48] = R0;
8d4e9572:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e9574:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e9576:	01 e8 00 00 	UNLINK;
8d4e957a:	10 00       	RTS;
8d4e957c:	30 e4 19 00 	R0 = [SP + 0x64];
8d4e9580:	ff e3 32 27 	CALL 0x0x8d4ce3e4;
8d4e9584:	e6 2f       	JUMP.S 0x0x8d4e9550;
8d4e9586:	00 00       	NOP;
8d4e9588:	30 e4 20 00 	R0 = [SP + 0x80];
8d4e958c:	ff e3 2c 27 	CALL 0x0x8d4ce3e4;
8d4e9590:	d6 2f       	JUMP.S 0x0x8d4e953c;
8d4e9592:	00 00       	NOP;
8d4e9594:	00 00       	NOP;
8d4e9596:	00 00       	NOP;
8d4e9598:	09 da 03 84 	P1=-2080148560;
8d4e959c:	b0 73 00 00 
8d4e95a0:	f1 bc       	[SP + 0xc] = P1;
8d4e95a2:	22 e1 73 02 	R2 = 0x273 (X);		/*		R2=0x273(627) */
8d4e95a6:	01 da 03 84 	R1=-2080148832;
8d4e95aa:	a0 72 00 00 
8d4e95ae:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d4e95b0:	30 e5 12 00 	P0 = [SP + 0x48];
8d4e95b4:	33 e4 17 00 	R3 = [SP + 0x5c];
8d4e95b8:	29 e1 48 00 	P1 = 0x48 (X);		/*		P1=0x48( 72) */
8d4e95bc:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e95be:	1f 0a       	CC = R7 <= R3 (IU);
8d4e95c0:	4e 5a       	P1 = SP + P1;
8d4e95c2:	c8 07       	IF CC P1 = P0;
8d4e95c4:	31 bd       	[SP + 0x10] = P1;
8d4e95c6:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e95ca:	74 05 00 00 
8d4e95ce:	b2 2f       	JUMP.S 0x0x8d4e9532;
8d4e95d0:	46 30       	R0 = SP;
8d4e95d2:	23 e1 60 00 	R3 = 0x60 (X);		/*		R3=0x60( 96) */
8d4e95d6:	18 50       	R0 = R0 + R3;
8d4e95d8:	01 da 03 84 	R1=-2080149216;
8d4e95dc:	20 71 00 00 
8d4e95e0:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4e95e4:	88 bf 00 00 
8d4e95e8:	00 0c       	CC = R0 == 0x0;
8d4e95ea:	02 da 03 84 	R2=-2080149216;
8d4e95ee:	20 71 00 00 
8d4e95f2:	5f 30       	R3 = FP;
8d4e95f4:	10 18       	IF CC JUMP 0x0x8d4e9614;
8d4e95f6:	20 e1 54 ff 	R0 = -0xac (X);		/*		R0=0xffffff54(-172) */
8d4e95fa:	03 50       	R0 = R3 + R0;
8d4e95fc:	21 e1 5c 00 	R1 = 0x5c (X);		/*		R1=0x5c( 92) */
8d4e9600:	4a 50       	R1 = R2 + R1;
8d4e9602:	10 30       	R2 = R0;
8d4e9604:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e9606:	00 de 04 8c 	CALL.A 0x8c04ee6c;
8d4e960a:	6c ee 00 00 
8d4e960e:	03 60       	R3 = 0x0 (X);		/*		R3=0x60( 96) */
8d4e9610:	1a 20       	JUMP.S 0x0x8d4e9644;
8d4e9612:	00 00       	NOP;
8d4e9614:	20 e1 38 ff 	R0 = -0xc8 (X);		/*		R0=0xffffff38(-200) */
8d4e9618:	03 50       	R0 = R3 + R0;
8d4e961a:	08 30       	R1 = R0;
8d4e961c:	40 66       	R0 += -0x38;		/* (-56) */
8d4e961e:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e9622:	94 f1 00 00 
8d4e9626:	5e 30       	R3 = SP;
8d4e9628:	21 e1 7c 00 	R1 = 0x7c (X);		/*		R1=0x7c(124) */
8d4e962c:	8b 50       	R2 = R3 + R1;
8d4e962e:	20 e1 ac ff 	R0 = -0x54 (X);		/*		R0=0xffffffac(-84) */
8d4e9632:	42 50       	R1 = R2 + R0;
8d4e9634:	20 e1 70 00 	R0 = 0x70 (X);		/*		R0=0x70(112) */
8d4e9638:	01 50       	R0 = R1 + R0;
8d4e963a:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d4e963e:	e4 f0 00 00 
8d4e9642:	0b 60       	R3 = 0x1 (X);		/*		R3=0x60( 96) */
8d4e9644:	03 0c       	CC = R3 == 0x0;
8d4e9646:	0b 18       	IF CC JUMP 0x0x8d4e965c;
8d4e9648:	30 e4 10 00 	R0 = [SP + 0x40];
8d4e964c:	81 60       	R1 = 0x10 (X);		/*		R1=0x7c(124) */
8d4e964e:	01 0a       	CC = R1 <= R0 (IU);
8d4e9650:	e7 18       	IF CC JUMP 0x0x8d4e981e;
8d4e9652:	35 e6 10 00 	[SP + 0x40] = R5;
8d4e9656:	f6 b3       	[SP + 0x3c] = R6;
8d4e9658:	b6 e6 2c 00 	B[SP + 0x2c] = R6;
8d4e965c:	46 30       	R0 = SP;
8d4e965e:	21 e1 60 00 	R1 = 0x60 (X);		/*		R1=0x60( 96) */
8d4e9662:	04 cc 01 04 	R2 = R0 + R1 (NS) || [SP + 0xc] = R7 || NOP;
8d4e9666:	f7 b0 00 00 
8d4e966a:	0a 30       	R1 = R2;
8d4e966c:	c1 65       	R1 += 0x38;		/* ( 56) */
8d4e966e:	01 30       	R0 = R1;
8d4e9670:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e9672:	ff e3 d5 f6 	CALL 0x0x8d4e841c;
8d4e9676:	80 b8       	R0 = [FP -0x60];
8d4e9678:	00 0c       	CC = R0 == 0x0;
8d4e967a:	4c 10       	IF !CC JUMP 0x0x8d4e9712;
8d4e967c:	90 b8       	R0 = [FP -0x5c];
8d4e967e:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e9680:	07 0a       	CC = R7 <= R0 (IU);
8d4e9682:	44 18       	IF CC JUMP 0x0x8d4e970a;
8d4e9684:	86 ba       	[FP -0x60] = R6;
8d4e9686:	b6 e6 b8 00 	B[SP + 0xb8] = R6;
8d4e968a:	03 c8 00 18 	MNOP || R0 = [FP -0x78] || [FP -0x5c] = R5;
8d4e968e:	20 b8 95 ba 
8d4e9692:	07 0a       	CC = R7 <= R0 (IU);
8d4e9694:	36 18       	IF CC JUMP 0x0x8d4e9700;
8d4e9696:	25 ba       	[FP -0x78] = R5;
8d4e9698:	16 ba       	[FP -0x7c] = R6;
8d4e969a:	b6 e6 9c 00 	B[SP + 0x9c] = R6;
8d4e969e:	30 e4 25 00 	R0 = [SP + 0x94];
8d4e96a2:	07 0a       	CC = R7 <= R0 (IU);
8d4e96a4:	28 18       	IF CC JUMP 0x0x8d4e96f4;
8d4e96a6:	35 e6 25 00 	[SP + 0x94] = R5;
8d4e96aa:	36 e6 24 00 	[SP + 0x90] = R6;
8d4e96ae:	b6 e6 80 00 	B[SP + 0x80] = R6;
8d4e96b2:	30 e4 1e 00 	R0 = [SP + 0x78];
8d4e96b6:	07 0a       	CC = R7 <= R0 (IU);
8d4e96b8:	18 18       	IF CC JUMP 0x0x8d4e96e8;
8d4e96ba:	35 e6 1e 00 	[SP + 0x78] = R5;
8d4e96be:	36 e6 1d 00 	[SP + 0x74] = R6;
8d4e96c2:	b6 e6 64 00 	B[SP + 0x64] = R6;
8d4e96c6:	30 e4 17 00 	R0 = [SP + 0x5c];
8d4e96ca:	07 0a       	CC = R7 <= R0 (IU);
8d4e96cc:	ee 16       	IF !CC JUMP 0x0x8d4e94a8 (BP);
8d4e96ce:	30 e4 12 00 	R0 = [SP + 0x48];
8d4e96d2:	ff e3 89 26 	CALL 0x0x8d4ce3e4;
8d4e96d6:	00 60       	R0 = 0x0 (X);		/*		R0=0x70(112) */
8d4e96d8:	b0 e6 48 00 	B[SP + 0x48] = R0;
8d4e96dc:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e96de:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e96e0:	01 e8 00 00 	UNLINK;
8d4e96e4:	10 00       	RTS;
8d4e96e6:	00 00       	NOP;
8d4e96e8:	30 e4 19 00 	R0 = [SP + 0x64];
8d4e96ec:	ff e3 7c 26 	CALL 0x0x8d4ce3e4;
8d4e96f0:	e5 2f       	JUMP.S 0x0x8d4e96ba;
8d4e96f2:	00 00       	NOP;
8d4e96f4:	30 e4 20 00 	R0 = [SP + 0x80];
8d4e96f8:	ff e3 76 26 	CALL 0x0x8d4ce3e4;
8d4e96fc:	d5 2f       	JUMP.S 0x0x8d4e96a6;
8d4e96fe:	00 00       	NOP;
8d4e9700:	30 e4 27 00 	R0 = [SP + 0x9c];
8d4e9704:	ff e3 70 26 	CALL 0x0x8d4ce3e4;
8d4e9708:	c7 2f       	JUMP.S 0x0x8d4e9696;
8d4e970a:	40 b8       	R0 = [FP -0x70];
8d4e970c:	ff e3 6c 26 	CALL 0x0x8d4ce3e4;
8d4e9710:	ba 2f       	JUMP.S 0x0x8d4e9684;
8d4e9712:	04 0c       	CC = R4 == 0x0;
8d4e9714:	33 18       	IF CC JUMP 0x0x8d4e977a;
8d4e9716:	4e 30       	R1 = SP;
8d4e9718:	23 e1 60 00 	R3 = 0x60 (X);		/*		R3=0x60( 96) */
8d4e971c:	59 50       	R1 = R1 + R3;
8d4e971e:	20 e1 70 00 	R0 = 0x70 (X);		/*		R0=0x70(112) */
8d4e9722:	01 50       	R0 = R1 + R0;
8d4e9724:	7a 61       	R2 = 0x2f (X);		/*		R2=0x273(627) */
8d4e9726:	ff e3 43 c4 	CALL 0x0x8d4e1fac;
8d4e972a:	5e 30       	R3 = SP;
8d4e972c:	21 e1 d0 00 	R1 = 0xd0 (X);		/*		R1=0xd0(208) */
8d4e9730:	4b 50       	R1 = R3 + R1;
8d4e9732:	01 30       	R0 = R1;
8d4e9734:	17 30       	R2 = R7;
8d4e9736:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e9738:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d4e973c:	e4 f0 00 00 
8d4e9740:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e9742:	00 b9       	R0 = [FP -0x40];
8d4e9744:	07 0a       	CC = R7 <= R0 (IU);
8d4e9746:	68 18       	IF CC JUMP 0x0x8d4e9816;
8d4e9748:	b6 e6 d4 00 	B[SP + 0xd4] = R6;
8d4e974c:	47 30       	R0 = FP;
8d4e974e:	03 c8 00 18 	MNOP || R2 = [FP -0x24] || R1 = [FP -0x38];
8d4e9752:	72 b9 21 b9 
8d4e9756:	2c 32       	P5 = R4;
8d4e9758:	17 0a       	CC = R7 <= R2 (IU);
8d4e975a:	40 66       	R0 += -0x38;		/* (-56) */
8d4e975c:	05 bb       	[FP -0x40] = R5;
8d4e975e:	f6 ba       	[FP -0x44] = R6;
8d4e9760:	01 07       	IF CC R0 = R1;
8d4e9762:	ff e3 e4 bc 	CALL 0x0x8d4e112a;
8d4e9766:	03 c8 00 18 	MNOP || [P5] = R0 || R0 = [FP -0x24];
8d4e976a:	28 93 70 b9 
8d4e976e:	07 0a       	CC = R7 <= R0 (IU);
8d4e9770:	4f 18       	IF CC JUMP 0x0x8d4e980e;
8d4e9772:	75 bb       	[FP -0x24] = R5;
8d4e9774:	66 bb       	[FP -0x28] = R6;
8d4e9776:	b6 e6 f0 00 	B[SP + 0xf0] = R6;
8d4e977a:	90 b8       	R0 = [FP -0x5c];
8d4e977c:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e977e:	07 0a       	CC = R7 <= R0 (IU);
8d4e9780:	43 18       	IF CC JUMP 0x0x8d4e9806;
8d4e9782:	86 ba       	[FP -0x60] = R6;
8d4e9784:	b6 e6 b8 00 	B[SP + 0xb8] = R6;
8d4e9788:	03 c8 00 18 	MNOP || R0 = [FP -0x78] || [FP -0x5c] = R5;
8d4e978c:	20 b8 95 ba 
8d4e9790:	07 0a       	CC = R7 <= R0 (IU);
8d4e9792:	35 18       	IF CC JUMP 0x0x8d4e97fc;
8d4e9794:	25 ba       	[FP -0x78] = R5;
8d4e9796:	16 ba       	[FP -0x7c] = R6;
8d4e9798:	b6 e6 9c 00 	B[SP + 0x9c] = R6;
8d4e979c:	30 e4 25 00 	R0 = [SP + 0x94];
8d4e97a0:	07 0a       	CC = R7 <= R0 (IU);
8d4e97a2:	27 18       	IF CC JUMP 0x0x8d4e97f0;
8d4e97a4:	35 e6 25 00 	[SP + 0x94] = R5;
8d4e97a8:	36 e6 24 00 	[SP + 0x90] = R6;
8d4e97ac:	b6 e6 80 00 	B[SP + 0x80] = R6;
8d4e97b0:	30 e4 1e 00 	R0 = [SP + 0x78];
8d4e97b4:	07 0a       	CC = R7 <= R0 (IU);
8d4e97b6:	17 18       	IF CC JUMP 0x0x8d4e97e4;
8d4e97b8:	35 e6 1e 00 	[SP + 0x78] = R5;
8d4e97bc:	36 e6 1d 00 	[SP + 0x74] = R6;
8d4e97c0:	b6 e6 64 00 	B[SP + 0x64] = R6;
8d4e97c4:	30 e4 17 00 	R0 = [SP + 0x5c];
8d4e97c8:	07 0a       	CC = R7 <= R0 (IU);
8d4e97ca:	6f 16       	IF !CC JUMP 0x0x8d4e94a8 (BP);
8d4e97cc:	30 e4 12 00 	R0 = [SP + 0x48];
8d4e97d0:	ff e3 0a 26 	CALL 0x0x8d4ce3e4;
8d4e97d4:	00 60       	R0 = 0x0 (X);		/*		R0=0x70(112) */
8d4e97d6:	b0 e6 48 00 	B[SP + 0x48] = R0;
8d4e97da:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e97dc:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e97de:	01 e8 00 00 	UNLINK;
8d4e97e2:	10 00       	RTS;
8d4e97e4:	30 e4 19 00 	R0 = [SP + 0x64];
8d4e97e8:	ff e3 fe 25 	CALL 0x0x8d4ce3e4;
8d4e97ec:	e6 2f       	JUMP.S 0x0x8d4e97b8;
8d4e97ee:	00 00       	NOP;
8d4e97f0:	30 e4 20 00 	R0 = [SP + 0x80];
8d4e97f4:	ff e3 f8 25 	CALL 0x0x8d4ce3e4;
8d4e97f8:	d6 2f       	JUMP.S 0x0x8d4e97a4;
8d4e97fa:	00 00       	NOP;
8d4e97fc:	30 e4 27 00 	R0 = [SP + 0x9c];
8d4e9800:	ff e3 f2 25 	CALL 0x0x8d4ce3e4;
8d4e9804:	c8 2f       	JUMP.S 0x0x8d4e9794;
8d4e9806:	40 b8       	R0 = [FP -0x70];
8d4e9808:	ff e3 ee 25 	CALL 0x0x8d4ce3e4;
8d4e980c:	bb 2f       	JUMP.S 0x0x8d4e9782;
8d4e980e:	20 b9       	R0 = [FP -0x38];
8d4e9810:	ff e3 ea 25 	CALL 0x0x8d4ce3e4;
8d4e9814:	af 2f       	JUMP.S 0x0x8d4e9772;
8d4e9816:	b0 b8       	R0 = [FP -0x54];
8d4e9818:	ff e3 e6 25 	CALL 0x0x8d4ce3e4;
8d4e981c:	96 2f       	JUMP.S 0x0x8d4e9748;
8d4e981e:	f0 a2       	R0 = [SP + 0x2c];
8d4e9820:	ff e3 e2 25 	CALL 0x0x8d4ce3e4;
8d4e9824:	17 2f       	JUMP.S 0x0x8d4e9652;
8d4e9826:	00 00       	NOP;
