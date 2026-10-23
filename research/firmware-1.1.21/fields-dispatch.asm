
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d584600 <.data+0xb85e0>:
8d584600:	81 64       	R1 += 0x10;		/* ( 16) */
8d584602:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d584604:	ff e3 48 c3 	CALL 0x0x8d57cc94;
8d584608:	fe 63       	R6 = -0x1 (X);		/*		R6=0x0(  0) */
8d58460a:	03 c8 00 18 	MNOP || R3 = [SP + 0x30] || W[FP + 0xc] = R6;
8d58460e:	33 a3 be b5 
8d584612:	03 c8 00 18 	MNOP || [FP + 0x8] = R3 || R1 = [SP + 0x28];
8d584616:	bb b0 b1 a2 
8d58461a:	6d e5 7f 26 	R5 = W[P5 + 0x4cfe] (X);
8d58461e:	f0 a2       	R0 = [SP + 0x2c];
8d584620:	32 60       	R2 = 0x6 (X);		/*		R2=0x0(  0) */
8d584622:	00 de 02 04 	CALL.A 0x040230c4;
8d584626:	c4 30 00 00 
8d58462a:	70 e5 1e 00 	R0 = W[SP + 0x3c] (X);
8d58462e:	05 08       	CC = R5 == R0;
8d584630:	25 18       	IF CC JUMP 0x0x8d58467a;
8d584632:	29 e1 7c 45 	P1 = 0x457c (X);		/*		P1=0x457c(17788) */
8d584636:	0d 5b       	P4 = P5 + P1;
8d584638:	6f 32       	P5 = FP;
8d58463a:	e5 6f       	P5 += -0x4;		/* ( -4) */
8d58463c:	82 ce 25 80 	R0 = R5 << 0x4 || R1 = [SP + 0x30] || NOP;
8d584640:	31 a3 00 00 
8d584644:	01 50       	R0 = R1 + R0;
8d584646:	18 32       	P3 = R0;
8d584648:	0f 30       	R1 = R7;
8d58464a:	20 64       	R0 += 0x4;		/* (  4) */
8d58464c:	ff e3 aa fe 	CALL 0x0x8d5843a0;
8d584650:	3d 0c       	CC = R5 == -0x1;
8d584652:	4f 18       	IF CC JUMP 0x0x8d5846f0;
8d584654:	5c a8       	R4 = W[P3 + 0x2] (X);
8d584656:	25 08       	CC = R5 == R4;
8d584658:	40 18       	IF CC JUMP 0x0x8d5846d8;
8d58465a:	82 ce 04 ca 	R5 = ROT R4 BY 0x0 || [FP + 0x8] = P4 || R1 = [SP + 0x28];
8d58465e:	bc bc b1 a2 
8d584662:	03 c8 00 18 	MNOP || W[FP + 0xc] = R6 || R0 = [SP + 0x2c];
8d584666:	be b5 f0 a2 
8d58466a:	32 60       	R2 = 0x6 (X);		/*		R2=0x0(  0) */
8d58466c:	00 de 02 04 	CALL.A 0x040230c4;
8d584670:	c4 30 00 00 
8d584674:	68 95       	R0 = W[P5] (X);
8d584676:	04 08       	CC = R4 == R0;
8d584678:	e2 17       	IF !CC JUMP 0x0x8d58463c (BP);
8d58467a:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R6 = [SP + 0x34] || R5 = [SP + 0x34];
8d58467e:	76 a3 75 a3 
8d584682:	22 e1 04 4d 	R2 = 0x4d04 (X);		/*		R2=0x4d04(19716) */
8d584686:	16 50       	R0 = R6 + R2;
8d584688:	ff e3 98 fe 	CALL 0x0x8d5843b8;
8d58468c:	23 e1 08 4f 	R3 = 0x4f08 (X);		/*		R3=0x4f08(20232) */
8d584690:	1e 50       	R0 = R6 + R3;
8d584692:	0f 30       	R1 = R7;
8d584694:	ff e3 92 fe 	CALL 0x0x8d5843b8;
8d584698:	22 e1 0c 51 	R2 = 0x510c (X);		/*		R2=0x510c(20748) */
8d58469c:	16 50       	R0 = R6 + R2;
8d58469e:	0f 30       	R1 = R7;
8d5846a0:	ff e3 8c fe 	CALL 0x0x8d5843b8;
8d5846a4:	23 e1 10 53 	R3 = 0x5310 (X);		/*		R3=0x5310(21264) */
8d5846a8:	1d 50       	R0 = R5 + R3;
8d5846aa:	0f 30       	R1 = R7;
8d5846ac:	ff e3 aa fe 	CALL 0x0x8d584400;
8d5846b0:	26 e1 94 53 	R6 = 0x5394 (X);		/*		R6=0x5394(21396) */
8d5846b4:	75 50       	R1 = R5 + R6;
8d5846b6:	07 30       	R0 = R7;
8d5846b8:	82 61       	R2 = 0x30 (X);		/*		R2=0x510c(20748) */
8d5846ba:	ff e3 ed c2 	CALL 0x0x8d57cc94;
8d5846be:	23 e1 c4 53 	R3 = 0x53c4 (X);		/*		R3=0x53c4(21444) */
8d5846c2:	5d 50       	R1 = R5 + R3;
8d5846c4:	07 30       	R0 = R7;
8d5846c6:	82 61       	R2 = 0x30 (X);		/*		R2=0x510c(20748) */
8d5846c8:	ff e3 e6 c2 	CALL 0x0x8d57cc94;
8d5846cc:	66 6c       	SP += 0xc;		/* ( 12) */
8d5846ce:	a3 05       	(R7:4, P5:3) = [SP++];
8d5846d0:	01 e8 00 00 	UNLINK;
8d5846d4:	10 00       	RTS;
8d5846d6:	00 00       	NOP;
8d5846d8:	00 da 00 84 	R0=-2080342352;
8d5846dc:	b0 7e 00 00 
8d5846e0:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d5846e4:	a4 05 00 00 
8d5846e8:	5c a8       	R4 = W[P3 + 0x2] (X);
8d5846ea:	b8 2f       	JUMP.S 0x0x8d58465a;
8d5846ec:	00 00       	NOP;
8d5846ee:	00 00       	NOP;
8d5846f0:	00 da 00 84 	R0=-2080342396;
8d5846f4:	84 7e 00 00 
8d5846f8:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d5846fc:	a4 05 00 00 
8d584700:	aa 2f       	JUMP.S 0x0x8d584654;
8d584702:	00 00       	NOP;
8d584704:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d584708:	e5 05       	[--SP] = (R7:4, P5:5);
8d58470a:	30 30       	R6 = R0;
8d58470c:	0e 32       	P1 = R6;
8d58470e:	08 da 05 00 	P0=343872;
8d584712:	40 3f 00 00 
8d584716:	a6 6f       	SP += -0xc;		/* (-12) */
8d584718:	01 30       	R0 = R1;
8d58471a:	29 30       	R5 = R1;
8d58471c:	41 5b       	P5 = P1 + P0;
8d58471e:	82 ce 06 ce 	R7 = ROT R6 BY 0x0 || R3 = B[P5] (Z) || NOP;
8d584722:	2b 99 00 00 
8d584726:	4f 30       	R1 = FP;
8d584728:	b3 e6 28 00 	B[SP + 0x28] = R3;
8d58472c:	41 64       	R1 += 0x8;		/* (  8) */
8d58472e:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d584730:	ff e3 b2 c2 	CALL 0x0x8d57cc94;
8d584734:	28 91       	R0 = [P5];
8d584736:	24 e1 f4 53 	R4 = 0x53f4 (X);		/*		R4=0x53f4(21492) */
8d58473a:	e0 40       	R0 *= R4;
8d58473c:	06 50       	R0 = R6 + R0;
8d58473e:	06 08       	CC = R6 == R0;
8d584740:	0d 18       	IF CC JUMP 0x0x8d58475a;
8d584742:	07 30       	R0 = R7;
8d584744:	0d 30       	R1 = R5;
8d584746:	ff e3 81 fe 	CALL 0x0x8d584448;
8d58474a:	04 cc 3c 0e 	R7 = R7 + R4 (NS) || R0 = [P5] || NOP;
8d58474e:	28 91 00 00 
8d584752:	e0 40       	R0 *= R4;
8d584754:	06 50       	R0 = R6 + R0;
8d584756:	07 08       	CC = R7 == R0;
8d584758:	f5 17       	IF !CC JUMP 0x0x8d584742 (BP);
8d58475a:	66 6c       	SP += 0xc;		/* ( 12) */
8d58475c:	a5 05       	(R7:4, P5:5) = [SP++];
8d58475e:	01 e8 00 00 	UNLINK;
8d584762:	10 00       	RTS;
8d584764:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d584768:	ed 05       	[--SP] = (R7:5, P5:5);
8d58476a:	30 30       	R6 = R0;
8d58476c:	2e 32       	P5 = R6;
8d58476e:	a6 6f       	SP += -0xc;		/* (-12) */
8d584770:	29 30       	R5 = R1;
8d584772:	4f 30       	R1 = FP;
8d584774:	05 30       	R0 = R5;
8d584776:	ab e4 60 00 	R3 = B[P5 + 0x60] (Z);
8d58477a:	b3 e6 24 00 	B[SP + 0x24] = R3;
8d58477e:	41 64       	R1 += 0x8;		/* (  8) */
8d584780:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d584782:	ff e3 89 c2 	CALL 0x0x8d57cc94;
8d584786:	28 e4 18 00 	R0 = [P5 + 0x60];
8d58478a:	06 50       	R0 = R6 + R0;
8d58478c:	06 08       	CC = R6 == R0;
8d58478e:	0d 18       	IF CC JUMP 0x0x8d5847a8;
8d584790:	3e 30       	R7 = R6;
8d584792:	0f 30       	R1 = R7;
8d584794:	0f 64       	R7 += 0x1;		/* (  1) */
8d584796:	05 30       	R0 = R5;
8d584798:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d58479a:	ff e3 7d c2 	CALL 0x0x8d57cc94;
8d58479e:	28 e4 18 00 	R0 = [P5 + 0x60];
8d5847a2:	06 50       	R0 = R6 + R0;
8d5847a4:	07 08       	CC = R7 == R0;
8d5847a6:	f6 17       	IF !CC JUMP 0x0x8d584792 (BP);
8d5847a8:	20 e1 64 00 	R0 = 0x64 (X);		/*		R0=0x64(100) */
8d5847ac:	46 50       	R1 = R6 + R0;
8d5847ae:	05 30       	R0 = R5;
8d5847b0:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d5847b2:	ff e3 71 c2 	CALL 0x0x8d57cc94;
8d5847b6:	21 e1 65 00 	R1 = 0x65 (X);		/*		R1=0x65(101) */
8d5847ba:	4e 50       	R1 = R6 + R1;
8d5847bc:	05 30       	R0 = R5;
8d5847be:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d5847c0:	ff e3 6a c2 	CALL 0x0x8d57cc94;
8d5847c4:	66 6c       	SP += 0xc;		/* ( 12) */
8d5847c6:	ad 05       	(R7:5, P5:5) = [SP++];
8d5847c8:	01 e8 00 00 	UNLINK;
8d5847cc:	10 00       	RTS;
8d5847ce:	00 00       	NOP;
8d5847d0:	00 00       	NOP;
8d5847d2:	00 00       	NOP;
8d5847d4:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d5847d8:	e5 05       	[--SP] = (R7:4, P5:5);
8d5847da:	66 6f       	SP += -0x14;		/* (-20) */
8d5847dc:	82 ce 01 ca 	R5 = ROT R1 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d5847e0:	38 b1 00 00 
8d5847e4:	fa e3 ac b6 	CALL 0x0x8d4db53c;
8d5847e8:	00 0c       	CC = R0 == 0x0;
8d5847ea:	07 da 0a 84 	R7=-2079711276;
8d5847ee:	d4 1f 00 00 
8d5847f2:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || P5 = [FP + 0x10] || R4 = [FP + 0x10];
8d5847f6:	3d ad 3c a1 
8d5847fa:	ff 10       	IF !CC JUMP 0x0x8d5849f8;
8d5847fc:	00 de 03 8c 	CALL.A 0x8c03e080;
8d584800:	80 e0 00 00 
8d584804:	77 30       	R6 = FP;
8d584806:	46 66       	R6 += -0x38;		/* (-56) */
8d584808:	06 30       	R0 = R6;
8d58480a:	ff e3 0b c1 	CALL 0x0x8d57ca20;
8d58480e:	0d 30       	R1 = R5;
8d584810:	06 30       	R0 = R6;
8d584812:	ff e3 73 c0 	CALL 0x0x8d57c8f8;
8d584816:	00 0c       	CC = R0 == 0x0;
8d584818:	cc 18       	IF CC JUMP 0x0x8d5849b0;
8d58481a:	02 da bb aa 	R2=-1430532899;
8d58481e:	dd cc 00 00 
8d584822:	4b 60       	R3 = 0x9 (X);		/*		R3=0x53c4(21444) */
8d584824:	9d 60       	R5 = 0x13 (X);		/*		R5=0x0(  0) */
8d584826:	4f 30       	R1 = FP;
8d584828:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d58482c:	ba b0 00 00 
8d584830:	b3 e6 6c 00 	B[SP + 0x6c] = R3;
8d584834:	b5 e6 6d 00 	B[SP + 0x6d] = R5;
8d584838:	41 64       	R1 += 0x8;		/* (  8) */
8d58483a:	42 60       	R2 = 0x8 (X);		/*		R2=0x510c(20748) */
8d58483c:	ff e3 2c c2 	CALL 0x0x8d57cc94;
8d584840:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d584844:	39 a1 00 00 
8d584848:	12 60       	R2 = 0x2 (X);		/*		R2=0x510c(20748) */
8d58484a:	ff e3 25 c2 	CALL 0x0x8d57cc94;
8d58484e:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d584852:	39 a1 00 00 
8d584856:	11 64       	R1 += 0x2;		/* (  2) */
8d584858:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d58485a:	ff e3 1d c2 	CALL 0x0x8d57cc94;
8d58485e:	4d 30       	R1 = P5;
8d584860:	06 30       	R0 = R6;
8d584862:	19 64       	R1 += 0x3;		/* (  3) */
8d584864:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d584866:	ff e3 17 c2 	CALL 0x0x8d57cc94;
8d58486a:	4d 30       	R1 = P5;
8d58486c:	06 30       	R0 = R6;
8d58486e:	21 64       	R1 += 0x4;		/* (  4) */
8d584870:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d584872:	ff e3 11 c2 	CALL 0x0x8d57cc94;
8d584876:	4d 30       	R1 = P5;
8d584878:	06 30       	R0 = R6;
8d58487a:	29 64       	R1 += 0x5;		/* (  5) */
8d58487c:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d58487e:	ff e3 0b c2 	CALL 0x0x8d57cc94;
8d584882:	4d 30       	R1 = P5;
8d584884:	06 30       	R0 = R6;
8d584886:	31 64       	R1 += 0x6;		/* (  6) */
8d584888:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d58488a:	ff e3 05 c2 	CALL 0x0x8d57cc94;
8d58488e:	4d 30       	R1 = P5;
8d584890:	06 30       	R0 = R6;
8d584892:	39 64       	R1 += 0x7;		/* (  7) */
8d584894:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d584896:	ff e3 ff c1 	CALL 0x0x8d57cc94;
8d58489a:	4d 30       	R1 = P5;
8d58489c:	06 30       	R0 = R6;
8d58489e:	41 64       	R1 += 0x8;		/* (  8) */
8d5848a0:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d5848a2:	ff e3 f9 c1 	CALL 0x0x8d57cc94;
8d5848a6:	4d 30       	R1 = P5;
8d5848a8:	06 30       	R0 = R6;
8d5848aa:	61 64       	R1 += 0xc;		/* ( 12) */
8d5848ac:	12 60       	R2 = 0x2 (X);		/*		R2=0x510c(20748) */
8d5848ae:	ff e3 f3 c1 	CALL 0x0x8d57cc94;
8d5848b2:	4d 30       	R1 = P5;
8d5848b4:	06 30       	R0 = R6;
8d5848b6:	71 64       	R1 += 0xe;		/* ( 14) */
8d5848b8:	82 60       	R2 = 0x10 (X);		/*		R2=0x510c(20748) */
8d5848ba:	ff e3 ed c1 	CALL 0x0x8d57cc94;
8d5848be:	4d 30       	R1 = P5;
8d5848c0:	06 30       	R0 = R6;
8d5848c2:	f1 64       	R1 += 0x1e;		/* ( 30) */
8d5848c4:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d5848c6:	ff e3 e7 c1 	CALL 0x0x8d57cc94;
8d5848ca:	4d 30       	R1 = P5;
8d5848cc:	06 30       	R0 = R6;
8d5848ce:	f9 64       	R1 += 0x1f;		/* ( 31) */
8d5848d0:	0a 60       	R2 = 0x1 (X);		/*		R2=0x510c(20748) */
8d5848d2:	ff e3 e1 c1 	CALL 0x0x8d57cc94;
8d5848d6:	4d 30       	R1 = P5;
8d5848d8:	06 30       	R0 = R6;
8d5848da:	01 65       	R1 += 0x20;		/* ( 32) */
8d5848dc:	82 60       	R2 = 0x10 (X);		/*		R2=0x510c(20748) */
8d5848de:	ff e3 db c1 	CALL 0x0x8d57cc94;
8d5848e2:	4d 30       	R1 = P5;
8d5848e4:	06 30       	R0 = R6;
8d5848e6:	81 65       	R1 += 0x30;		/* ( 48) */
8d5848e8:	82 60       	R2 = 0x10 (X);		/*		R2=0x510c(20748) */
8d5848ea:	ff e3 d5 c1 	CALL 0x0x8d57cc94;
8d5848ee:	23 e1 40 00 	R3 = 0x40 (X);		/*		R3=0x40( 64) */
8d5848f2:	5c 50       	R1 = R4 + R3;
8d5848f4:	06 30       	R0 = R6;
8d5848f6:	82 60       	R2 = 0x10 (X);		/*		R2=0x510c(20748) */
8d5848f8:	ff e3 ce c1 	CALL 0x0x8d57cc94;
8d5848fc:	25 e1 50 00 	R5 = 0x50 (X);		/*		R5=0x50( 80) */
8d584900:	6c 50       	R1 = R4 + R5;
8d584902:	06 30       	R0 = R6;
8d584904:	42 60       	R2 = 0x8 (X);		/*		R2=0x510c(20748) */
8d584906:	ff e3 c7 c1 	CALL 0x0x8d57cc94;
8d58490a:	23 e1 58 00 	R3 = 0x58 (X);		/*		R3=0x58( 88) */
8d58490e:	5c 50       	R1 = R4 + R3;
8d584910:	06 30       	R0 = R6;
8d584912:	82 60       	R2 = 0x10 (X);		/*		R2=0x510c(20748) */
8d584914:	ff e3 c0 c1 	CALL 0x0x8d57cc94;
8d584918:	25 e1 68 00 	R5 = 0x68 (X);		/*		R5=0x68(104) */
8d58491c:	6c 50       	R1 = R4 + R5;
8d58491e:	06 30       	R0 = R6;
8d584920:	82 60       	R2 = 0x10 (X);		/*		R2=0x510c(20748) */
8d584922:	ff e3 b9 c1 	CALL 0x0x8d57cc94;
8d584926:	23 e1 78 00 	R3 = 0x78 (X);		/*		R3=0x78(120) */
8d58492a:	5c 50       	R1 = R4 + R3;
8d58492c:	06 30       	R0 = R6;
8d58492e:	82 60       	R2 = 0x10 (X);		/*		R2=0x510c(20748) */
8d584930:	ff e3 b2 c1 	CALL 0x0x8d57cc94;
8d584934:	25 e1 88 00 	R5 = 0x88 (X);		/*		R5=0x88(136) */
8d584938:	6c 50       	R1 = R4 + R5;
8d58493a:	06 30       	R0 = R6;
8d58493c:	82 60       	R2 = 0x10 (X);		/*		R2=0x510c(20748) */
8d58493e:	ff e3 ab c1 	CALL 0x0x8d57cc94;
8d584942:	23 e1 98 00 	R3 = 0x98 (X);		/*		R3=0x98(152) */
8d584946:	27 e1 7c 0d 	R7 = 0xd7c (X);		/*		R7=0xd7c(3452) */
8d58494a:	5c 50       	R1 = R4 + R3;
8d58494c:	06 30       	R0 = R6;
8d58494e:	22 e1 e4 0c 	R2 = 0xce4 (X);		/*		R2=0xce4(3300) */
8d584952:	fc 51       	R7 = R4 + R7;
8d584954:	ff e3 a0 c1 	CALL 0x0x8d57cc94;
8d584958:	05 da 05 00 	R5=343876;
8d58495c:	44 3f 00 00 
8d584960:	84 60       	R4 = 0x10 (X);		/*		R4=0x53f4(21492) */
8d584962:	07 30       	R0 = R7;
8d584964:	0e 30       	R1 = R6;
8d584966:	ff e3 cf fe 	CALL 0x0x8d584704;
8d58496a:	fc 67       	R4 += -0x1;		/* ( -1) */
8d58496c:	04 0c       	CC = R4 == 0x0;
8d58496e:	04 cc 3d 0e 	R7 = R7 + R5 (NS) || R1 = [FP + 0x10] || NOP;
8d584972:	39 a1 00 00 
8d584976:	f6 17       	IF !CC JUMP 0x0x8d584962 (BP);
8d584978:	00 da 54 00 	R0=5505468;
8d58497c:	bc 01 00 00 
8d584980:	41 51       	R5 = R1 + R0;
8d584982:	77 60       	R7 = 0xe (X);		/*		R7=0xd7c(3452) */
8d584984:	21 e1 68 00 	R1 = 0x68 (X);		/*		R1=0x68(104) */
8d584988:	05 30       	R0 = R5;
8d58498a:	4d 51       	R5 = R5 + R1;
8d58498c:	0e 30       	R1 = R6;
8d58498e:	ff e3 eb fe 	CALL 0x0x8d584764;
8d584992:	ff 67       	R7 += -0x1;		/* ( -1) */
8d584994:	07 0c       	CC = R7 == 0x0;
8d584996:	f7 17       	IF !CC JUMP 0x0x8d584984 (BP);
8d584998:	06 30       	R0 = R6;
8d58499a:	ff e3 6b c2 	CALL 0x0x8d57ce70;
8d58499e:	a6 6c       	SP += 0x14;		/* ( 20) */
8d5849a0:	a5 05       	(R7:4, P5:5) = [SP++];
8d5849a2:	01 e8 00 00 	UNLINK;
8d5849a6:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
8d5849a8:	10 00       	RTS;
8d5849aa:	00 00       	NOP;
8d5849ac:	00 00       	NOP;
8d5849ae:	00 00       	NOP;
8d5849b0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5849b4:	fc 1e 00 00 
8d5849b8:	98 0c       	CC = R0 < 0x3;
8d5849ba:	0b 10       	IF !CC JUMP 0x0x8d5849d0;
8d5849bc:	06 30       	R0 = R6;
8d5849be:	ff e3 59 c2 	CALL 0x0x8d57ce70;
8d5849c2:	a6 6c       	SP += 0x14;		/* ( 20) */
8d5849c4:	a5 05       	(R7:4, P5:5) = [SP++];
8d5849c6:	01 e8 00 00 	UNLINK;
8d5849ca:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d5849cc:	10 00       	RTS;
8d5849ce:	00 00       	NOP;
8d5849d0:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0x10] = R5 || NOP;
8d5849d4:	35 b1 00 00 
8d5849d8:	09 da 0a 84 	P1=-2079711196;
8d5849dc:	24 20 00 00 
8d5849e0:	f1 bc       	[SP + 0xc] = P1;
8d5849e2:	22 e1 99 00 	R2 = 0x99 (X);		/*		R2=0x99(153) */
8d5849e6:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d5849e8:	00 de 04 8c 	CALL.A 0x8c040574;
8d5849ec:	74 05 00 00 
8d5849f0:	e6 2f       	JUMP.S 0x0x8d5849bc;
8d5849f2:	00 00       	NOP;
8d5849f4:	00 00       	NOP;
8d5849f6:	00 00       	NOP;
8d5849f8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5849fc:	fc 1e 00 00 
8d584a00:	98 0c       	CC = R0 < 0x3;
8d584a02:	07 10       	IF !CC JUMP 0x0x8d584a10;
8d584a04:	a6 6c       	SP += 0x14;		/* ( 20) */
8d584a06:	a5 05       	(R7:4, P5:5) = [SP++];
8d584a08:	01 e8 00 00 	UNLINK;
8d584a0c:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d584a0e:	10 00       	RTS;
8d584a10:	09 da 0a 84 	P1=-2079711232;
8d584a14:	00 20 00 00 
8d584a18:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = P1 || NOP;
8d584a1c:	f1 bc 00 00 
8d584a20:	22 e1 91 00 	R2 = 0x91 (X);		/*		R2=0x91(145) */
8d584a24:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584a26:	00 de 04 8c 	CALL.A 0x8c040574;
8d584a2a:	74 05 00 00 
8d584a2e:	a6 6c       	SP += 0x14;		/* ( 20) */
8d584a30:	a5 05       	(R7:4, P5:5) = [SP++];
8d584a32:	01 e8 00 00 	UNLINK;
8d584a36:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d584a38:	10 00       	RTS;
8d584a3a:	00 00       	NOP;
8d584a3c:	00 00       	NOP;
8d584a3e:	00 00       	NOP;
8d584a40:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d584a44:	82 c6 41 86 	R3 = R1 << 0x8;
8d584a48:	e3 05       	[--SP] = (R7:4, P5:3);
8d584a4a:	9a 57       	R6 = R2 | R3;
8d584a4c:	f3 42       	R3 = R6.L (Z);
8d584a4e:	27 e1 01 08 	R7 = 0x801 (X);		/*		R7=0x801(2049) */
8d584a52:	bb 09       	CC = R3 < R7 (IU);
8d584a54:	46 6f       	SP += -0x18;		/* (-24) */
8d584a56:	0d da 0c 86 	P5=-2045991292;
8d584a5a:	84 a6 00 00 
8d584a5e:	bb 18       	IF CC JUMP 0x0x8d584bd4;
8d584a60:	3b 08       	CC = R3 == R7;
8d584a62:	13 18       	IF CC JUMP 0x0x8d584a88;
8d584a64:	25 e1 00 f7 	R5 = -0x900 (X);		/*		R5=0xfffff700(-2304) */
8d584a68:	eb 50       	R3 = R3 + R5;
8d584a6a:	a5 60       	R5 = 0x14 (X);		/*		R5=0xfffff700(-2304) */
8d584a6c:	0b 32       	P1 = R3;
8d584a6e:	ab 09       	CC = R3 < R5 (IU);
8d584a70:	b6 10       	IF !CC JUMP 0x0x8d584bdc;
8d584a72:	08 da 0a 84 	P0=-2079710588;
8d584a76:	84 22 00 00 
8d584a7a:	48 5e       	P1 = P0 + (P1 << 0x2);
8d584a7c:	49 91       	P1 = [P1];
8d584a7e:	4d 30       	R1 = P5;
8d584a80:	51 00       	JUMP (P1);
8d584a82:	00 00       	NOP;
8d584a84:	00 00       	NOP;
8d584a86:	00 00       	NOP;
8d584a88:	01 da 0c 86 	R1=-2045991292;
8d584a8c:	84 a6 00 00 
8d584a90:	00 e3 1c 0c 	CALL 0x0x8d5862c8;
8d584a94:	09 da 64 86 	P1=-2040221924;
8d584a98:	1c af 00 00 
8d584a9c:	24 e1 00 08 	R4 = 0x800 (X);		/*		R4=0x800(2048) */
8d584aa0:	0b da 0a 84 	P3=-2079710668;
8d584aa4:	34 22 00 00 
8d584aa8:	25 e1 13 09 	R5 = 0x913 (X);		/*		R5=0x913(2323) */
8d584aac:	61 32       	P4 = P1;
8d584aae:	f0 42       	R0 = R6.L (Z);
8d584ab0:	b8 09       	CC = R0 < R7 (IU);
8d584ab2:	70 18       	IF CC JUMP 0x0x8d584b92;
8d584ab4:	38 08       	CC = R0 == R7;
8d584ab6:	39 18       	IF CC JUMP 0x0x8d584b28;
8d584ab8:	21 e1 00 f7 	R1 = -0x900 (X);		/*		R1=0xfffff700(-2304) */
8d584abc:	08 50       	R0 = R0 + R1;
8d584abe:	a2 60       	R2 = 0x14 (X);		/*		R2=0x91(145) */
8d584ac0:	08 32       	P1 = R0;
8d584ac2:	90 09       	CC = R0 < R2 (IU);
8d584ac4:	0e 10       	IF !CC JUMP 0x0x8d584ae0;
8d584ac6:	4b 5e       	P1 = P3 + (P1 << 0x2);
8d584ac8:	49 91       	P1 = [P1];
8d584aca:	22 e1 2a 01 	R2 = 0x12a (X);		/*		R2=0x12a(298) */
8d584ace:	01 da 0a 84 	R1=-2079711276;
8d584ad2:	d4 1f 00 00 
8d584ad6:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584ada:	fc 1e 00 00 
8d584ade:	51 00       	JUMP (P1);
8d584ae0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584ae4:	fc 1e 00 00 
8d584ae8:	88 0c       	CC = R0 < 0x1;
8d584aea:	07 10       	IF !CC JUMP 0x0x8d584af8;
8d584aec:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584aee:	a3 05       	(R7:4, P5:3) = [SP++];
8d584af0:	01 e8 00 00 	UNLINK;
8d584af4:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d584af6:	10 00       	RTS;
8d584af8:	f0 42       	R0 = R6.L (Z);
8d584afa:	09 da 0a 84 	P1=-2079710712;
8d584afe:	08 22 00 00 
8d584b02:	30 b1       	[SP + 0x10] = R0;
8d584b04:	f1 bc       	[SP + 0xc] = P1;
8d584b06:	22 e1 8b 01 	R2 = 0x18b (X);		/*		R2=0x18b(395) */
8d584b0a:	01 da 0a 84 	R1=-2079711276;
8d584b0e:	d4 1f 00 00 
8d584b12:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
8d584b14:	00 de 04 8c 	CALL.A 0x8c040574;
8d584b18:	74 05 00 00 
8d584b1c:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584b1e:	a3 05       	(R7:4, P5:3) = [SP++];
8d584b20:	01 e8 00 00 	UNLINK;
8d584b24:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d584b26:	10 00       	RTS;
8d584b28:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584b2c:	fc 1e 00 00 
8d584b30:	98 0c       	CC = R0 < 0x3;
8d584b32:	1f 10       	IF !CC JUMP 0x0x8d584b70;
8d584b34:	4c 30       	R1 = P4;
8d584b36:	45 30       	R0 = P5;
8d584b38:	00 e3 e4 50 	CALL 0x0x8d58ed00;
8d584b3c:	26 e1 00 09 	R6 = 0x900 (X);		/*		R6=0x900(2304) */
8d584b40:	f0 42       	R0 = R6.L (Z);
8d584b42:	28 08       	CC = R0 == R5;
8d584b44:	4d 32       	P1 = P5;
8d584b46:	6c 32       	P5 = P4;
8d584b48:	b2 17       	IF !CC JUMP 0x0x8d584aac (BP);
8d584b4a:	79 ad       	P1 = [FP + 0x14];
8d584b4c:	4c 30       	R1 = P4;
8d584b4e:	02 da 54 00 	R2=5506924;
8d584b52:	6c 07 00 00 
8d584b56:	41 30       	R0 = P1;
8d584b58:	00 de 02 04 	CALL.A 0x040201c4;
8d584b5c:	c4 01 00 00 
8d584b60:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584b62:	a3 05       	(R7:4, P5:3) = [SP++];
8d584b64:	01 e8 00 00 	UNLINK;
8d584b68:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
8d584b6a:	10 00       	RTS;
8d584b6c:	00 00       	NOP;
8d584b6e:	00 00       	NOP;
8d584b70:	09 da 0a 84 	P1=-2079711112;
8d584b74:	78 20 00 00 
8d584b78:	f1 bc       	[SP + 0xc] = P1;
8d584b7a:	22 e1 25 01 	R2 = 0x125 (X);		/*		R2=0x125(293) */
8d584b7e:	01 da 0a 84 	R1=-2079711276;
8d584b82:	d4 1f 00 00 
8d584b86:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584b88:	00 de 04 8c 	CALL.A 0x8c040574;
8d584b8c:	74 05 00 00 
8d584b90:	d2 2f       	JUMP.S 0x0x8d584b34;
8d584b92:	20 08       	CC = R0 == R4;
8d584b94:	a6 13       	IF !CC JUMP 0x0x8d584ae0;
8d584b96:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584b9a:	fc 1e 00 00 
8d584b9e:	98 0c       	CC = R0 < 0x3;
8d584ba0:	08 10       	IF !CC JUMP 0x0x8d584bb0;
8d584ba2:	4c 30       	R1 = P4;
8d584ba4:	45 30       	R0 = P5;
8d584ba6:	00 e3 9d 46 	CALL 0x0x8d58d8e0;
8d584baa:	26 e1 01 08 	R6 = 0x801 (X);		/*		R6=0x801(2049) */
8d584bae:	c9 2f       	JUMP.S 0x0x8d584b40;
8d584bb0:	09 da 0a 84 	P1=-2079711132;
8d584bb4:	64 20 00 00 
8d584bb8:	f1 bc       	[SP + 0xc] = P1;
8d584bba:	22 e1 20 01 	R2 = 0x120 (X);		/*		R2=0x120(288) */
8d584bbe:	01 da 0a 84 	R1=-2079711276;
8d584bc2:	d4 1f 00 00 
8d584bc6:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584bc8:	00 de 04 8c 	CALL.A 0x8c040574;
8d584bcc:	74 05 00 00 
8d584bd0:	e9 2f       	JUMP.S 0x0x8d584ba2;
8d584bd2:	00 00       	NOP;
8d584bd4:	25 e1 00 08 	R5 = 0x800 (X);		/*		R5=0x800(2048) */
8d584bd8:	2b 08       	CC = R3 == R5;
8d584bda:	27 18       	IF CC JUMP 0x0x8d584c28;
8d584bdc:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584be0:	fc 1e 00 00 
8d584be4:	88 0c       	CC = R0 < 0x1;
8d584be6:	09 10       	IF !CC JUMP 0x0x8d584bf8;
8d584be8:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584bea:	a3 05       	(R7:4, P5:3) = [SP++];
8d584bec:	01 e8 00 00 	UNLINK;
8d584bf0:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d584bf2:	10 00       	RTS;
8d584bf4:	00 00       	NOP;
8d584bf6:	00 00       	NOP;
8d584bf8:	09 da 0a 84 	P1=-2079711168;
8d584bfc:	40 20 00 00 
8d584c00:	72 b1       	[SP + 0x14] = R2;
8d584c02:	31 b1       	[SP + 0x10] = R1;
8d584c04:	f1 bc       	[SP + 0xc] = P1;
8d584c06:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
8d584c08:	22 e1 19 01 	R2 = 0x119 (X);		/*		R2=0x119(281) */
8d584c0c:	01 da 0a 84 	R1=-2079711276;
8d584c10:	d4 1f 00 00 
8d584c14:	00 de 04 8c 	CALL.A 0x8c040574;
8d584c18:	74 05 00 00 
8d584c1c:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584c1e:	a3 05       	(R7:4, P5:3) = [SP++];
8d584c20:	01 e8 00 00 	UNLINK;
8d584c24:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d584c26:	10 00       	RTS;
8d584c28:	01 da 0c 86 	R1=-2045991292;
8d584c2c:	84 a6 00 00 
8d584c30:	00 e3 8c 07 	CALL 0x0x8d585b48;
8d584c34:	30 2f       	JUMP.S 0x0x8d584a94;
8d584c36:	00 00       	NOP;
8d584c38:	00 e3 04 0f 	CALL 0x0x8d586a40;
8d584c3c:	2c 2f       	JUMP.S 0x0x8d584a94;
8d584c3e:	4d 30       	R1 = P5;
8d584c40:	00 e3 bc 12 	CALL 0x0x8d5871b8;
8d584c44:	28 2f       	JUMP.S 0x0x8d584a94;
8d584c46:	4d 30       	R1 = P5;
8d584c48:	00 e3 f8 35 	CALL 0x0x8d58b838;
8d584c4c:	24 2f       	JUMP.S 0x0x8d584a94;
8d584c4e:	4d 30       	R1 = P5;
8d584c50:	00 e3 a8 39 	CALL 0x0x8d58bfa0;
8d584c54:	20 2f       	JUMP.S 0x0x8d584a94;
8d584c56:	4d 30       	R1 = P5;
8d584c58:	00 e3 6c 3d 	CALL 0x0x8d58c730;
8d584c5c:	1c 2f       	JUMP.S 0x0x8d584a94;
8d584c5e:	4d 30       	R1 = P5;
8d584c60:	00 e3 30 41 	CALL 0x0x8d58cec0;
8d584c64:	18 2f       	JUMP.S 0x0x8d584a94;
8d584c66:	4d 30       	R1 = P5;
8d584c68:	00 e3 94 45 	CALL 0x0x8d58d790;
8d584c6c:	14 2f       	JUMP.S 0x0x8d584a94;
8d584c6e:	4d 30       	R1 = P5;
8d584c70:	00 e3 f4 16 	CALL 0x0x8d587a58;
8d584c74:	10 2f       	JUMP.S 0x0x8d584a94;
8d584c76:	4d 30       	R1 = P5;
8d584c78:	00 e3 f0 16 	CALL 0x0x8d587a58;
8d584c7c:	0c 2f       	JUMP.S 0x0x8d584a94;
8d584c7e:	4d 30       	R1 = P5;
8d584c80:	00 e3 ec 16 	CALL 0x0x8d587a58;
8d584c84:	08 2f       	JUMP.S 0x0x8d584a94;
8d584c86:	4d 30       	R1 = P5;
8d584c88:	00 e3 e8 16 	CALL 0x0x8d587a58;
8d584c8c:	04 2f       	JUMP.S 0x0x8d584a94;
8d584c8e:	4d 30       	R1 = P5;
8d584c90:	00 e3 e4 16 	CALL 0x0x8d587a58;
8d584c94:	00 2f       	JUMP.S 0x0x8d584a94;
8d584c96:	4d 30       	R1 = P5;
8d584c98:	00 e3 20 1b 	CALL 0x0x8d5882d8;
8d584c9c:	fc 2e       	JUMP.S 0x0x8d584a94;
8d584c9e:	4d 30       	R1 = P5;
8d584ca0:	00 e3 98 1f 	CALL 0x0x8d588bd0;
8d584ca4:	f8 2e       	JUMP.S 0x0x8d584a94;
8d584ca6:	4d 30       	R1 = P5;
8d584ca8:	00 e3 18 24 	CALL 0x0x8d5894d8;
8d584cac:	f4 2e       	JUMP.S 0x0x8d584a94;
8d584cae:	4d 30       	R1 = P5;
8d584cb0:	00 e3 14 24 	CALL 0x0x8d5894d8;
8d584cb4:	f0 2e       	JUMP.S 0x0x8d584a94;
8d584cb6:	4d 30       	R1 = P5;
8d584cb8:	00 e3 92 28 	CALL 0x0x8d589ddc;
8d584cbc:	ec 2e       	JUMP.S 0x0x8d584a94;
8d584cbe:	4d 30       	R1 = P5;
8d584cc0:	00 e3 2e 2d 	CALL 0x0x8d58a71c;
8d584cc4:	e8 2e       	JUMP.S 0x0x8d584a94;
8d584cc6:	4d 30       	R1 = P5;
8d584cc8:	00 e3 ca 31 	CALL 0x0x8d58b05c;
8d584ccc:	e4 2e       	JUMP.S 0x0x8d584a94;
8d584cce:	79 ad       	P1 = [FP + 0x14];
8d584cd0:	49 30       	R1 = P1;
8d584cd2:	00 e3 a1 83 	CALL 0x0x8d595414;
8d584cd6:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584cd8:	a3 05       	(R7:4, P5:3) = [SP++];
8d584cda:	01 e8 00 00 	UNLINK;
8d584cde:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
8d584ce0:	10 00       	RTS;
8d584ce2:	00 00       	NOP;
8d584ce4:	00 00       	NOP;
8d584ce6:	00 00       	NOP;
8d584ce8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584cec:	fc 1e 00 00 
8d584cf0:	98 0c       	CC = R0 < 0x3;
8d584cf2:	0b 10       	IF !CC JUMP 0x0x8d584d08;
8d584cf4:	4c 30       	R1 = P4;
8d584cf6:	45 30       	R0 = P5;
8d584cf8:	00 e3 52 52 	CALL 0x0x8d58f19c;
8d584cfc:	26 e1 01 09 	R6 = 0x901 (X);		/*		R6=0x901(2305) */
8d584d00:	20 2f       	JUMP.S 0x0x8d584b40;
8d584d02:	00 00       	NOP;
8d584d04:	00 00       	NOP;
8d584d06:	00 00       	NOP;
8d584d08:	09 da 0a 84 	P1=-2079711092;
8d584d0c:	8c 20 00 00 
8d584d10:	f1 bc       	[SP + 0xc] = P1;
8d584d12:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584d14:	00 de 04 8c 	CALL.A 0x8c040574;
8d584d18:	74 05 00 00 
8d584d1c:	ec 2f       	JUMP.S 0x0x8d584cf4;
8d584d1e:	00 00       	NOP;
8d584d20:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584d24:	fc 1e 00 00 
8d584d28:	98 0c       	CC = R0 < 0x3;
8d584d2a:	0b 10       	IF !CC JUMP 0x0x8d584d40;
8d584d2c:	4c 30       	R1 = P4;
8d584d2e:	45 30       	R0 = P5;
8d584d30:	00 e3 da 54 	CALL 0x0x8d58f6e4;
8d584d34:	26 e1 02 09 	R6 = 0x902 (X);		/*		R6=0x902(2306) */
8d584d38:	04 2f       	JUMP.S 0x0x8d584b40;
8d584d3a:	00 00       	NOP;
8d584d3c:	00 00       	NOP;
8d584d3e:	00 00       	NOP;
8d584d40:	09 da 0a 84 	P1=-2079711072;
8d584d44:	a0 20 00 00 
8d584d48:	f1 bc       	[SP + 0xc] = P1;
8d584d4a:	22 e1 2f 01 	R2 = 0x12f (X);		/*		R2=0x12f(303) */
8d584d4e:	01 da 0a 84 	R1=-2079711276;
8d584d52:	d4 1f 00 00 
8d584d56:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584d58:	00 de 04 8c 	CALL.A 0x8c040574;
8d584d5c:	74 05 00 00 
8d584d60:	e6 2f       	JUMP.S 0x0x8d584d2c;
8d584d62:	00 00       	NOP;
8d584d64:	00 00       	NOP;
8d584d66:	00 00       	NOP;
8d584d68:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584d6c:	fc 1e 00 00 
8d584d70:	98 0c       	CC = R0 < 0x3;
8d584d72:	0b 10       	IF !CC JUMP 0x0x8d584d88;
8d584d74:	4c 30       	R1 = P4;
8d584d76:	45 30       	R0 = P5;
8d584d78:	00 e3 c6 57 	CALL 0x0x8d58fd04;
8d584d7c:	26 e1 03 09 	R6 = 0x903 (X);		/*		R6=0x903(2307) */
8d584d80:	e0 2e       	JUMP.S 0x0x8d584b40;
8d584d82:	00 00       	NOP;
8d584d84:	00 00       	NOP;
8d584d86:	00 00       	NOP;
8d584d88:	09 da 0a 84 	P1=-2079711052;
8d584d8c:	b4 20 00 00 
8d584d90:	f1 bc       	[SP + 0xc] = P1;
8d584d92:	22 e1 34 01 	R2 = 0x134 (X);		/*		R2=0x134(308) */
8d584d96:	01 da 0a 84 	R1=-2079711276;
8d584d9a:	d4 1f 00 00 
8d584d9e:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584da0:	00 de 04 8c 	CALL.A 0x8c040574;
8d584da4:	74 05 00 00 
8d584da8:	e6 2f       	JUMP.S 0x0x8d584d74;
8d584daa:	00 00       	NOP;
8d584dac:	00 00       	NOP;
8d584dae:	00 00       	NOP;
8d584db0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584db4:	fc 1e 00 00 
8d584db8:	98 0c       	CC = R0 < 0x3;
8d584dba:	0b 10       	IF !CC JUMP 0x0x8d584dd0;
8d584dbc:	4c 30       	R1 = P4;
8d584dbe:	45 30       	R0 = P5;
8d584dc0:	00 e3 26 5a 	CALL 0x0x8d59020c;
8d584dc4:	26 e1 04 09 	R6 = 0x904 (X);		/*		R6=0x904(2308) */
8d584dc8:	bc 2e       	JUMP.S 0x0x8d584b40;
8d584dca:	00 00       	NOP;
8d584dcc:	00 00       	NOP;
8d584dce:	00 00       	NOP;
8d584dd0:	09 da 0a 84 	P1=-2079711032;
8d584dd4:	c8 20 00 00 
8d584dd8:	f1 bc       	[SP + 0xc] = P1;
8d584dda:	22 e1 39 01 	R2 = 0x139 (X);		/*		R2=0x139(313) */
8d584dde:	01 da 0a 84 	R1=-2079711276;
8d584de2:	d4 1f 00 00 
8d584de6:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584de8:	00 de 04 8c 	CALL.A 0x8c040574;
8d584dec:	74 05 00 00 
8d584df0:	e6 2f       	JUMP.S 0x0x8d584dbc;
8d584df2:	00 00       	NOP;
8d584df4:	00 00       	NOP;
8d584df6:	00 00       	NOP;
8d584df8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584dfc:	fc 1e 00 00 
8d584e00:	98 0c       	CC = R0 < 0x3;
8d584e02:	0b 10       	IF !CC JUMP 0x0x8d584e18;
8d584e04:	4c 30       	R1 = P4;
8d584e06:	45 30       	R0 = P5;
8d584e08:	00 e3 22 5c 	CALL 0x0x8d59064c;
8d584e0c:	26 e1 05 09 	R6 = 0x905 (X);		/*		R6=0x905(2309) */
8d584e10:	98 2e       	JUMP.S 0x0x8d584b40;
8d584e12:	00 00       	NOP;
8d584e14:	00 00       	NOP;
8d584e16:	00 00       	NOP;
8d584e18:	09 da 0a 84 	P1=-2079711012;
8d584e1c:	dc 20 00 00 
8d584e20:	f1 bc       	[SP + 0xc] = P1;
8d584e22:	22 e1 3e 01 	R2 = 0x13e (X);		/*		R2=0x13e(318) */
8d584e26:	01 da 0a 84 	R1=-2079711276;
8d584e2a:	d4 1f 00 00 
8d584e2e:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584e30:	00 de 04 8c 	CALL.A 0x8c040574;
8d584e34:	74 05 00 00 
8d584e38:	e6 2f       	JUMP.S 0x0x8d584e04;
8d584e3a:	00 00       	NOP;
8d584e3c:	00 00       	NOP;
8d584e3e:	00 00       	NOP;
8d584e40:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584e44:	fc 1e 00 00 
8d584e48:	98 0c       	CC = R0 < 0x3;
8d584e4a:	0b 10       	IF !CC JUMP 0x0x8d584e60;
8d584e4c:	4c 30       	R1 = P4;
8d584e4e:	45 30       	R0 = P5;
8d584e50:	00 e3 5a 5e 	CALL 0x0x8d590b04;
8d584e54:	26 e1 06 09 	R6 = 0x906 (X);		/*		R6=0x906(2310) */
8d584e58:	74 2e       	JUMP.S 0x0x8d584b40;
8d584e5a:	00 00       	NOP;
8d584e5c:	00 00       	NOP;
8d584e5e:	00 00       	NOP;
8d584e60:	09 da 0a 84 	P1=-2079710992;
8d584e64:	f0 20 00 00 
8d584e68:	f1 bc       	[SP + 0xc] = P1;
8d584e6a:	22 e1 43 01 	R2 = 0x143 (X);		/*		R2=0x143(323) */
8d584e6e:	01 da 0a 84 	R1=-2079711276;
8d584e72:	d4 1f 00 00 
8d584e76:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584e78:	00 de 04 8c 	CALL.A 0x8c040574;
8d584e7c:	74 05 00 00 
8d584e80:	e6 2f       	JUMP.S 0x0x8d584e4c;
8d584e82:	00 00       	NOP;
8d584e84:	00 00       	NOP;
8d584e86:	00 00       	NOP;
8d584e88:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584e8c:	fc 1e 00 00 
8d584e90:	98 0c       	CC = R0 < 0x3;
8d584e92:	0b 10       	IF !CC JUMP 0x0x8d584ea8;
8d584e94:	4c 30       	R1 = P4;
8d584e96:	45 30       	R0 = P5;
8d584e98:	00 e3 48 61 	CALL 0x0x8d591128;
8d584e9c:	26 e1 07 09 	R6 = 0x907 (X);		/*		R6=0x907(2311) */
8d584ea0:	50 2e       	JUMP.S 0x0x8d584b40;
8d584ea2:	00 00       	NOP;
8d584ea4:	00 00       	NOP;
8d584ea6:	00 00       	NOP;
8d584ea8:	09 da 0a 84 	P1=-2079710972;
8d584eac:	04 21 00 00 
8d584eb0:	f1 bc       	[SP + 0xc] = P1;
8d584eb2:	22 e1 48 01 	R2 = 0x148 (X);		/*		R2=0x148(328) */
8d584eb6:	01 da 0a 84 	R1=-2079711276;
8d584eba:	d4 1f 00 00 
8d584ebe:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584ec0:	00 de 04 8c 	CALL.A 0x8c040574;
8d584ec4:	74 05 00 00 
8d584ec8:	e6 2f       	JUMP.S 0x0x8d584e94;
8d584eca:	00 00       	NOP;
8d584ecc:	00 00       	NOP;
8d584ece:	00 00       	NOP;
8d584ed0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584ed4:	fc 1e 00 00 
8d584ed8:	98 0c       	CC = R0 < 0x3;
8d584eda:	0b 10       	IF !CC JUMP 0x0x8d584ef0;
8d584edc:	4c 30       	R1 = P4;
8d584ede:	45 30       	R0 = P5;
8d584ee0:	00 e3 4c 64 	CALL 0x0x8d591778;
8d584ee4:	26 e1 08 09 	R6 = 0x908 (X);		/*		R6=0x908(2312) */
8d584ee8:	2c 2e       	JUMP.S 0x0x8d584b40;
8d584eea:	00 00       	NOP;
8d584eec:	00 00       	NOP;
8d584eee:	00 00       	NOP;
8d584ef0:	09 da 0a 84 	P1=-2079710952;
8d584ef4:	18 21 00 00 
8d584ef8:	f1 bc       	[SP + 0xc] = P1;
8d584efa:	22 e1 4d 01 	R2 = 0x14d (X);		/*		R2=0x14d(333) */
8d584efe:	01 da 0a 84 	R1=-2079711276;
8d584f02:	d4 1f 00 00 
8d584f06:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584f08:	00 de 04 8c 	CALL.A 0x8c040574;
8d584f0c:	74 05 00 00 
8d584f10:	e6 2f       	JUMP.S 0x0x8d584edc;
8d584f12:	00 00       	NOP;
8d584f14:	00 00       	NOP;
8d584f16:	00 00       	NOP;
8d584f18:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584f1c:	fc 1e 00 00 
8d584f20:	98 0c       	CC = R0 < 0x3;
8d584f22:	0b 10       	IF !CC JUMP 0x0x8d584f38;
8d584f24:	4c 30       	R1 = P4;
8d584f26:	45 30       	R0 = P5;
8d584f28:	00 e3 8e 64 	CALL 0x0x8d591844;
8d584f2c:	26 e1 09 09 	R6 = 0x909 (X);		/*		R6=0x909(2313) */
8d584f30:	08 2e       	JUMP.S 0x0x8d584b40;
8d584f32:	00 00       	NOP;
8d584f34:	00 00       	NOP;
8d584f36:	00 00       	NOP;
8d584f38:	09 da 0a 84 	P1=-2079710932;
8d584f3c:	2c 21 00 00 
8d584f40:	f1 bc       	[SP + 0xc] = P1;
8d584f42:	22 e1 52 01 	R2 = 0x152 (X);		/*		R2=0x152(338) */
8d584f46:	01 da 0a 84 	R1=-2079711276;
8d584f4a:	d4 1f 00 00 
8d584f4e:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584f50:	00 de 04 8c 	CALL.A 0x8c040574;
8d584f54:	74 05 00 00 
8d584f58:	e6 2f       	JUMP.S 0x0x8d584f24;
8d584f5a:	00 00       	NOP;
8d584f5c:	00 00       	NOP;
8d584f5e:	00 00       	NOP;
8d584f60:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584f64:	fc 1e 00 00 
8d584f68:	98 0c       	CC = R0 < 0x3;
8d584f6a:	0b 10       	IF !CC JUMP 0x0x8d584f80;
8d584f6c:	4c 30       	R1 = P4;
8d584f6e:	45 30       	R0 = P5;
8d584f70:	00 e3 f8 64 	CALL 0x0x8d591960;
8d584f74:	26 e1 0a 09 	R6 = 0x90a (X);		/*		R6=0x90a(2314) */
8d584f78:	e4 2d       	JUMP.S 0x0x8d584b40;
8d584f7a:	00 00       	NOP;
8d584f7c:	00 00       	NOP;
8d584f7e:	00 00       	NOP;
8d584f80:	09 da 0a 84 	P1=-2079710912;
8d584f84:	40 21 00 00 
8d584f88:	f1 bc       	[SP + 0xc] = P1;
8d584f8a:	22 e1 57 01 	R2 = 0x157 (X);		/*		R2=0x157(343) */
8d584f8e:	01 da 0a 84 	R1=-2079711276;
8d584f92:	d4 1f 00 00 
8d584f96:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584f98:	00 de 04 8c 	CALL.A 0x8c040574;
8d584f9c:	74 05 00 00 
8d584fa0:	e6 2f       	JUMP.S 0x0x8d584f6c;
8d584fa2:	00 00       	NOP;
8d584fa4:	00 00       	NOP;
8d584fa6:	00 00       	NOP;
8d584fa8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584fac:	fc 1e 00 00 
8d584fb0:	98 0c       	CC = R0 < 0x3;
8d584fb2:	0b 10       	IF !CC JUMP 0x0x8d584fc8;
8d584fb4:	4c 30       	R1 = P4;
8d584fb6:	45 30       	R0 = P5;
8d584fb8:	00 e3 80 65 	CALL 0x0x8d591ab8;
8d584fbc:	26 e1 0b 09 	R6 = 0x90b (X);		/*		R6=0x90b(2315) */
8d584fc0:	c0 2d       	JUMP.S 0x0x8d584b40;
8d584fc2:	00 00       	NOP;
8d584fc4:	00 00       	NOP;
8d584fc6:	00 00       	NOP;
8d584fc8:	09 da 0a 84 	P1=-2079710892;
8d584fcc:	54 21 00 00 
8d584fd0:	f1 bc       	[SP + 0xc] = P1;
8d584fd2:	22 e1 5c 01 	R2 = 0x15c (X);		/*		R2=0x15c(348) */
8d584fd6:	01 da 0a 84 	R1=-2079711276;
8d584fda:	d4 1f 00 00 
8d584fde:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d584fe0:	00 de 04 8c 	CALL.A 0x8c040574;
8d584fe4:	74 05 00 00 
8d584fe8:	e6 2f       	JUMP.S 0x0x8d584fb4;
8d584fea:	00 00       	NOP;
8d584fec:	00 00       	NOP;
8d584fee:	00 00       	NOP;
8d584ff0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584ff4:	fc 1e 00 00 
8d584ff8:	98 0c       	CC = R0 < 0x3;
8d584ffa:	0b 10       	IF !CC JUMP 0x0x8d585010;
8d584ffc:	4c 30       	R1 = P4;
8d584ffe:	45 30       	R0 = P5;
8d585000:	00 e3 a2 66 	CALL 0x0x8d591d44;
8d585004:	26 e1 0c 09 	R6 = 0x90c (X);		/*		R6=0x90c(2316) */
8d585008:	9c 2d       	JUMP.S 0x0x8d584b40;
8d58500a:	00 00       	NOP;
8d58500c:	00 00       	NOP;
8d58500e:	00 00       	NOP;
8d585010:	09 da 0a 84 	P1=-2079710872;
8d585014:	68 21 00 00 
8d585018:	f1 bc       	[SP + 0xc] = P1;
8d58501a:	22 e1 61 01 	R2 = 0x161 (X);		/*		R2=0x161(353) */
8d58501e:	01 da 0a 84 	R1=-2079711276;
8d585022:	d4 1f 00 00 
8d585026:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d585028:	00 de 04 8c 	CALL.A 0x8c040574;
8d58502c:	74 05 00 00 
8d585030:	e6 2f       	JUMP.S 0x0x8d584ffc;
8d585032:	00 00       	NOP;
8d585034:	00 00       	NOP;
8d585036:	00 00       	NOP;
8d585038:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d58503c:	fc 1e 00 00 
8d585040:	98 0c       	CC = R0 < 0x3;
8d585042:	0b 10       	IF !CC JUMP 0x0x8d585058;
8d585044:	4c 30       	R1 = P4;
8d585046:	45 30       	R0 = P5;
8d585048:	00 e3 86 69 	CALL 0x0x8d592354;
8d58504c:	26 e1 0d 09 	R6 = 0x90d (X);		/*		R6=0x90d(2317) */
8d585050:	78 2d       	JUMP.S 0x0x8d584b40;
8d585052:	00 00       	NOP;
8d585054:	00 00       	NOP;
8d585056:	00 00       	NOP;
8d585058:	09 da 0a 84 	P1=-2079710852;
8d58505c:	7c 21 00 00 
8d585060:	f1 bc       	[SP + 0xc] = P1;
8d585062:	22 e1 66 01 	R2 = 0x166 (X);		/*		R2=0x166(358) */
8d585066:	01 da 0a 84 	R1=-2079711276;
8d58506a:	d4 1f 00 00 
8d58506e:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d585070:	00 de 04 8c 	CALL.A 0x8c040574;
8d585074:	74 05 00 00 
8d585078:	e6 2f       	JUMP.S 0x0x8d585044;
8d58507a:	00 00       	NOP;
8d58507c:	00 00       	NOP;
8d58507e:	00 00       	NOP;
8d585080:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d585084:	fc 1e 00 00 
8d585088:	98 0c       	CC = R0 < 0x3;
8d58508a:	0b 10       	IF !CC JUMP 0x0x8d5850a0;
8d58508c:	4c 30       	R1 = P4;
8d58508e:	45 30       	R0 = P5;
8d585090:	00 e3 56 6c 	CALL 0x0x8d59293c;
8d585094:	26 e1 0e 09 	R6 = 0x90e (X);		/*		R6=0x90e(2318) */
8d585098:	54 2d       	JUMP.S 0x0x8d584b40;
8d58509a:	00 00       	NOP;
8d58509c:	00 00       	NOP;
8d58509e:	00 00       	NOP;
8d5850a0:	09 da 0a 84 	P1=-2079710832;
8d5850a4:	90 21 00 00 
8d5850a8:	f1 bc       	[SP + 0xc] = P1;
8d5850aa:	22 e1 6b 01 	R2 = 0x16b (X);		/*		R2=0x16b(363) */
8d5850ae:	01 da 0a 84 	R1=-2079711276;
8d5850b2:	d4 1f 00 00 
8d5850b6:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d5850b8:	00 de 04 8c 	CALL.A 0x8c040574;
8d5850bc:	74 05 00 00 
8d5850c0:	e6 2f       	JUMP.S 0x0x8d58508c;
8d5850c2:	00 00       	NOP;
8d5850c4:	00 00       	NOP;
8d5850c6:	00 00       	NOP;
8d5850c8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5850cc:	fc 1e 00 00 
8d5850d0:	98 0c       	CC = R0 < 0x3;
8d5850d2:	0b 10       	IF !CC JUMP 0x0x8d5850e8;
8d5850d4:	4c 30       	R1 = P4;
8d5850d6:	45 30       	R0 = P5;
8d5850d8:	00 e3 fe 6f 	CALL 0x0x8d5930d4;
8d5850dc:	26 e1 0f 09 	R6 = 0x90f (X);		/*		R6=0x90f(2319) */
8d5850e0:	30 2d       	JUMP.S 0x0x8d584b40;
8d5850e2:	00 00       	NOP;
8d5850e4:	00 00       	NOP;
8d5850e6:	00 00       	NOP;
8d5850e8:	09 da 0a 84 	P1=-2079710812;
8d5850ec:	a4 21 00 00 
8d5850f0:	f1 bc       	[SP + 0xc] = P1;
8d5850f2:	22 e1 70 01 	R2 = 0x170 (X);		/*		R2=0x170(368) */
8d5850f6:	01 da 0a 84 	R1=-2079711276;
8d5850fa:	d4 1f 00 00 
8d5850fe:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d585100:	00 de 04 8c 	CALL.A 0x8c040574;
8d585104:	74 05 00 00 
8d585108:	e6 2f       	JUMP.S 0x0x8d5850d4;
8d58510a:	00 00       	NOP;
8d58510c:	00 00       	NOP;
8d58510e:	00 00       	NOP;
8d585110:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d585114:	fc 1e 00 00 
8d585118:	98 0c       	CC = R0 < 0x3;
8d58511a:	0b 10       	IF !CC JUMP 0x0x8d585130;
8d58511c:	4c 30       	R1 = P4;
8d58511e:	45 30       	R0 = P5;
8d585120:	00 e3 40 70 	CALL 0x0x8d5931a0;
8d585124:	26 e1 10 09 	R6 = 0x910 (X);		/*		R6=0x910(2320) */
8d585128:	0c 2d       	JUMP.S 0x0x8d584b40;
8d58512a:	00 00       	NOP;
8d58512c:	00 00       	NOP;
8d58512e:	00 00       	NOP;
8d585130:	09 da 0a 84 	P1=-2079710792;
8d585134:	b8 21 00 00 
8d585138:	f1 bc       	[SP + 0xc] = P1;
8d58513a:	22 e1 75 01 	R2 = 0x175 (X);		/*		R2=0x175(373) */
8d58513e:	01 da 0a 84 	R1=-2079711276;
8d585142:	d4 1f 00 00 
8d585146:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d585148:	00 de 04 8c 	CALL.A 0x8c040574;
8d58514c:	74 05 00 00 
8d585150:	e6 2f       	JUMP.S 0x0x8d58511c;
8d585152:	00 00       	NOP;
8d585154:	00 00       	NOP;
8d585156:	00 00       	NOP;
8d585158:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d58515c:	fc 1e 00 00 
8d585160:	98 0c       	CC = R0 < 0x3;
8d585162:	0b 10       	IF !CC JUMP 0x0x8d585178;
8d585164:	4c 30       	R1 = P4;
8d585166:	45 30       	R0 = P5;
8d585168:	00 e3 ae 73 	CALL 0x0x8d5938c4;
8d58516c:	26 e1 11 09 	R6 = 0x911 (X);		/*		R6=0x911(2321) */
8d585170:	e8 2c       	JUMP.S 0x0x8d584b40;
8d585172:	00 00       	NOP;
8d585174:	00 00       	NOP;
8d585176:	00 00       	NOP;
8d585178:	09 da 0a 84 	P1=-2079710772;
8d58517c:	cc 21 00 00 
8d585180:	f1 bc       	[SP + 0xc] = P1;
8d585182:	22 e1 7a 01 	R2 = 0x17a (X);		/*		R2=0x17a(378) */
8d585186:	01 da 0a 84 	R1=-2079711276;
8d58518a:	d4 1f 00 00 
8d58518e:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d585190:	00 de 04 8c 	CALL.A 0x8c040574;
8d585194:	74 05 00 00 
8d585198:	e6 2f       	JUMP.S 0x0x8d585164;
8d58519a:	00 00       	NOP;
8d58519c:	00 00       	NOP;
8d58519e:	00 00       	NOP;
8d5851a0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5851a4:	fc 1e 00 00 
8d5851a8:	98 0c       	CC = R0 < 0x3;
8d5851aa:	0b 10       	IF !CC JUMP 0x0x8d5851c0;
8d5851ac:	4c 30       	R1 = P4;
8d5851ae:	45 30       	R0 = P5;
8d5851b0:	00 e3 86 76 	CALL 0x0x8d593ebc;
8d5851b4:	26 e1 12 09 	R6 = 0x912 (X);		/*		R6=0x912(2322) */
8d5851b8:	c4 2c       	JUMP.S 0x0x8d584b40;
8d5851ba:	00 00       	NOP;
8d5851bc:	00 00       	NOP;
8d5851be:	00 00       	NOP;
8d5851c0:	09 da 0a 84 	P1=-2079710752;
8d5851c4:	e0 21 00 00 
8d5851c8:	f1 bc       	[SP + 0xc] = P1;
8d5851ca:	22 e1 7f 01 	R2 = 0x17f (X);		/*		R2=0x17f(383) */
8d5851ce:	01 da 0a 84 	R1=-2079711276;
8d5851d2:	d4 1f 00 00 
8d5851d6:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d5851d8:	00 de 04 8c 	CALL.A 0x8c040574;
8d5851dc:	74 05 00 00 
8d5851e0:	e6 2f       	JUMP.S 0x0x8d5851ac;
8d5851e2:	98 0c       	CC = R0 < 0x3;
8d5851e4:	0a 10       	IF !CC JUMP 0x0x8d5851f8;
8d5851e6:	4c 30       	R1 = P4;
8d5851e8:	45 30       	R0 = P5;
8d5851ea:	00 e3 fd 79 	CALL 0x0x8d5945e4;
8d5851ee:	35 30       	R6 = R5;
8d5851f0:	a8 2c       	JUMP.S 0x0x8d584b40;
8d5851f2:	00 00       	NOP;
8d5851f4:	00 00       	NOP;
8d5851f6:	00 00       	NOP;
8d5851f8:	09 da 0a 84 	P1=-2079710732;
8d5851fc:	f4 21 00 00 
8d585200:	f1 bc       	[SP + 0xc] = P1;
8d585202:	22 e1 84 01 	R2 = 0x184 (X);		/*		R2=0x184(388) */
8d585206:	01 da 0a 84 	R1=-2079711276;
8d58520a:	d4 1f 00 00 
8d58520e:	18 60       	R0 = 0x3 (X);		/*		R0=0x64(100) */
8d585210:	00 de 04 8c 	CALL.A 0x8c040574;
8d585214:	74 05 00 00 
8d585218:	e7 2f       	JUMP.S 0x0x8d5851e6;
8d58521a:	00 00       	NOP;
8d58521c:	00 00       	NOP;
8d58521e:	00 00       	NOP;
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
8d585262:	42 60       	R2 = 0x8 (X);		/*		R2=0x184(388) */
8d585264:	ff e3 d4 b9 	CALL 0x0x8d57c60c;
8d585268:	03 c8 00 18 	MNOP || R6 = [FP -0x4] || R1 = [FP + 0x8];
8d58526c:	f6 b9 b9 a0 
8d585270:	06 0c       	CC = R6 == 0x0;
8d585272:	43 60       	R3 = 0x8 (X);		/*		R3=0x98(152) */
8d585274:	ee 10       	IF !CC JUMP 0x0x8d585450;
8d585276:	00 da bb aa 	R0=-1430532899;
8d58527a:	dd cc 00 00 
8d58527e:	01 08       	CC = R1 == R0;
8d585280:	cc 10       	IF !CC JUMP 0x0x8d585418;
8d585282:	b1 e4 64 00 	R1 = B[SP + 0x64] (Z);
8d585286:	99 08       	CC = R1 < R3;
8d585288:	ac 18       	IF CC JUMP 0x0x8d5853e0;
8d58528a:	48 60       	R0 = 0x9 (X);		/*		R0=0x64(100) */
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
8d5852c2:	87 60       	R7 = 0x10 (X);		/*		R7=0x801(2049) */
8d5852c4:	3d bd       	[FP + 0x10] = P5;
8d5852c6:	39 ad       	P1 = [FP + 0x10];
8d5852c8:	08 da 05 00 	P0=343876;
8d5852cc:	44 3f 00 00 
8d5852d0:	05 60       	R5 = 0x0 (X);		/*		R5=0x800(2048) */
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
8d5852fe:	44 60       	R4 = 0x8 (X);		/*		R4=0x800(2048) */
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
8d585390:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
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
8d5853ce:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
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
8d585404:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
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
8d58543e:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
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
8d58545c:	06 60       	R6 = 0x0 (X);		/*		R6=0x912(2322) */
8d58545e:	63 2f       	JUMP.S 0x0x8d585324;
8d585460:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0x10] = R5 || NOP;
8d585464:	35 b1 00 00 
8d585468:	09 da 0a 84 	P1=-2079710508;
8d58546c:	d4 22 00 00 
8d585470:	f1 bc       	[SP + 0xc] = P1;
8d585472:	22 e1 a7 01 	R2 = 0x1a7 (X);		/*		R2=0x1a7(423) */
8d585476:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
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
8d5854aa:	08 60       	R0 = 0x1 (X);		/*		R0=0x64(100) */
8d5854ac:	00 de 04 8c 	CALL.A 0x8c040574;
8d5854b0:	74 05 00 00 
8d5854b4:	38 2f       	JUMP.S 0x0x8d585324;
8d5854b6:	00 00       	NOP;
8d5854b8:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d5854bc:	00 da 0c 86 	R0=-2045991296;
8d5854c0:	80 a6 00 00 
8d5854c4:	00 de ed 8f 	CALL.A 0x8fed50b2;
8d5854c8:	b2 50 00 00 
8d5854cc:	02 da c0 86 	R2=-2034223356;
8d5854d0:	04 37 00 00 
8d5854d4:	01 da 0c 86 	R1=-2045991296;
8d5854d8:	80 a6 00 00 
8d5854dc:	00 da ed 8f 	R0=-1880273006;
8d5854e0:	92 4f 00 00 
8d5854e4:	00 de ed 8f 	CALL.A 0x8fed4b1e;
8d5854e8:	1e 4b 00 00 
8d5854ec:	01 e8 00 00 	UNLINK;
8d5854f0:	10 00       	RTS;
8d5854f2:	00 00       	NOP;
8d5854f4:	08 32       	P1 = R0;
8d5854f6:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5854fa:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d5854fc:	08 92       	[P1++] = R0;
8d5854fe:	09 8a       	W[P1] = R0.L;
8d585500:	01 e8 00 00 	UNLINK;
8d585504:	10 00       	RTS;
8d585506:	08 32       	P1 = R0;
8d585508:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d58550c:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d58550e:	88 e6 0f 00 	B[P1 + 0xf] = R0;
8d585512:	01 e8 00 00 	UNLINK;
8d585516:	10 00       	RTS;
8d585518:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d58551c:	fd 05       	[--SP] = (R7:7, P5:5);
8d58551e:	28 32       	P5 = R0;
8d585520:	66 6f       	SP += -0x14;		/* (-20) */
8d585522:	01 68       	P1 = 0x0 (X);		/*		P1=0x53f4(21492) */
8d585524:	08 da 58 8d 	P0=-1923590924;
8d585528:	f4 54 00 00 
8d58552c:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [SP + 0x10] = P1 || NOP;
8d585530:	31 bd 00 00 
8d585534:	f0 bc       	[SP + 0xc] = P0;
8d585536:	42 60       	R2 = 0x8 (X);		/*		R2=0x1a0(416) */
8d585538:	41 61       	R1 = 0x28 (X);		/*		R1=0xfffff700(-2304) */
8d58553a:	00 de ed 8f 	CALL.A 0x8fed52b4;
8d58553e:	b4 52 00 00 
8d585542:	2f e6 50 00 	[P5 + 0x140] = R7;
8d585546:	a6 6c       	SP += 0x14;		/* ( 20) */
8d585548:	bd 05       	(R7:7, P5:5) = [SP++];
8d58554a:	01 e8 00 00 	UNLINK;
8d58554e:	10 00       	RTS;
8d585550:	08 32       	P1 = R0;
8d585552:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d585556:	00 60       	R0 = 0x0 (X);		/*		R0=0x64(100) */
8d585558:	08 e6 50 00 	[P1 + 0x140] = R0;
8d58555c:	01 e8 00 00 	UNLINK;
8d585560:	10 00       	RTS;
8d585562:	10 30       	R2 = R0;
8d585564:	01 30       	R0 = R1;
8d585566:	0a 30       	R1 = R2;
8d585568:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d58556c:	42 60       	R2 = 0x8 (X);		/*		R2=0x1a0(416) */
8d58556e:	ff e3 4f b8 	CALL 0x0x8d57c60c;
8d585572:	01 e8 00 00 	UNLINK;
8d585576:	10 00       	RTS;
8d585578:	10 30       	R2 = R0;
8d58557a:	01 30       	R0 = R1;
8d58557c:	0a 30       	R1 = R2;
8d58557e:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d585582:	62 60       	R2 = 0xc (X);		/*		R2=0x1a0(416) */
8d585584:	ff e3 44 b8 	CALL 0x0x8d57c60c;
8d585588:	01 e8 00 00 	UNLINK;
8d58558c:	10 00       	RTS;
8d58558e:	00 00       	NOP;
8d585590:	00 e8 06 00 	LINK 0x18;		/* (24) */
8d585594:	e3 05       	[--SP] = (R7:4, P5:3);
8d585596:	a6 6f       	SP += -0xc;		/* (-12) */
8d585598:	03 cc 36 0c 	R6.L = R6.L - R6.L (NS) || [SP + 0x30] = R1 || NOP;
8d58559c:	31 b3 00 00 
8d5855a0:	b0 b2       	[SP + 0x28] = R0;
8d5855a2:	0a 60       	R2 = 0x1 (X);		/*		R2=0x1a0(416) */
8d5855a4:	b5 ae       	P5 = [SP + 0x28];
8d5855a6:	30 a3       	R0 = [SP + 0x30];
8d5855a8:	03 c8 00 18 	MNOP || R1 = [SP + 0x28] || R5 = [SP + 0x28];
8d5855ac:	b1 a2 b5 a2 
8d5855b0:	ff e3 2e b8 	CALL 0x0x8d57c60c;
8d5855b4:	03 c8 00 18 	MNOP || R1 = [SP + 0x28] || R0 = [SP + 0x30];
8d5855b8:	b1 a2 30 a3 
8d5855bc:	21 64       	R1 += 0x4;		/* (  4) */
8d5855be:	22 60       	R2 = 0x4 (X);		/*		R2=0x1a0(416) */
8d5855c0:	ff e3 26 b8 	CALL 0x0x8d57c60c;
8d5855c4:	03 c8 00 18 	MNOP || R1 = [SP + 0x28] || R0 = [SP + 0x30];
8d5855c8:	b1 a2 30 a3 
8d5855cc:	41 64       	R1 += 0x8;		/* (  8) */
8d5855ce:	0a 60       	R2 = 0x1 (X);		/*		R2=0x1a0(416) */
8d5855d0:	ff e3 1e b8 	CALL 0x0x8d57c60c;
8d5855d4:	4d 30       	R1 = P5;
8d5855d6:	49 64       	R1 += 0x9;		/* (  9) */
8d5855d8:	03 c8 00 18 	MNOP || R0 = [SP + 0x30] || R4 = [SP + 0x28];
8d5855dc:	30 a3 b4 a2 
8d5855e0:	0a 60       	R2 = 0x1 (X);		/*		R2=0x1a0(416) */
8d5855e2:	ff e3 15 b8 	CALL 0x0x8d57c60c;
8d5855e6:	4d 30       	R1 = P5;
8d5855e8:	51 64       	R1 += 0xa;		/* ( 10) */
8d5855ea:	30 a3       	R0 = [SP + 0x30];
8d5855ec:	0a 60       	R2 = 0x1 (X);		/*		R2=0x1a0(416) */
8d5855ee:	ff e3 0f b8 	CALL 0x0x8d57c60c;
8d5855f2:	4d 30       	R1 = P5;
8d5855f4:	61 64       	R1 += 0xc;		/* ( 12) */
8d5855f6:	30 a3       	R0 = [SP + 0x30];
8d5855f8:	22 60       	R2 = 0x4 (X);		/*		R2=0x1a0(416) */
8d5855fa:	ff e3 09 b8 	CALL 0x0x8d57c60c;
8d5855fe:	4d 30       	R1 = P5;

