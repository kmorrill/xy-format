
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d503720 <.data+0x37700>:
8d503720:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d503724:	fb 05       	[--SP] = (R7:7, P5:3);
8d503726:	28 32       	P5 = R0;
8d503728:	a6 6f       	SP += -0xc;		/* (-12) */
8d50372a:	09 da a4 84 	P1=-2069571776;
8d50372e:	40 d7 00 00 
8d503732:	03 c8 00 18 	MNOP || P0 = [P1 + 0x4] || R0 = [P5 + 0x8];
8d503736:	48 ac a8 a0 
8d50373a:	00 0d       	CC = R0 <= 0x0;
8d50373c:	88 10       	IF !CC JUMP 0x0x8d50384c;
8d50373e:	44 ac       	P4 = [P0 + 0x4];
8d503740:	50 32       	P2 = P0;
8d503742:	a0 e5 2d 00 	R0 = B[P4 + 0x2d] (X);
8d503746:	00 0c       	CC = R0 == 0x0;
8d503748:	10 10       	IF !CC JUMP 0x0x8d503768;
8d50374a:	29 91       	R1 = [P5];
8d50374c:	4c 32       	P1 = P4;
8d50374e:	c0 e0 0a 00 	LSETUP_IMM(bottom=0x8d503762) LC0 count_fields=0x0/0x0;
8d503752:	ca a0       	R2 = [P1 + 0xc];
8d503754:	8a 09       	CC = R2 < R1 (IU);
8d503756:	73 10       	IF !CC JUMP 0x0x8d50383c;
8d503758:	41 6c       	P1 += 0x8;		/* (  8) */
8d50375a:	49 91       	P1 = [P1];
8d50375c:	8a e5 2d 00 	R2 = B[P1 + 0x2d] (X);
8d503760:	02 0c       	CC = R2 == 0x0;
8d503762:	03 10       	IF !CC JUMP 0x0x8d503768;
8d503764:	f5 2f       	JUMP.S 0x0x8d50374e;
8d503766:	00 00       	NOP;
8d503768:	91 e5 2d 00 	R1 = B[P2 + 0x2d] (X);
8d50376c:	01 0c       	CC = R1 == 0x0;
8d50376e:	04 10       	IF !CC JUMP 0x0x8d503776;
8d503770:	54 91       	P4 = [P2];
8d503772:	a0 e5 2d 00 	R0 = B[P4 + 0x2d] (X);
8d503776:	00 0c       	CC = R0 == 0x0;
8d503778:	13 10       	IF !CC JUMP 0x0x8d50379e;
8d50377a:	28 91       	R0 = [P5];
8d50377c:	4a 32       	P1 = P2;
8d50377e:	c0 e0 0e 00 	LSETUP_IMM(bottom=0x8d50379a) LC0 count_fields=0x0/0x0;
8d503782:	e1 a0       	R1 = [P4 + 0xc];
8d503784:	5c 32       	P3 = P4;
8d503786:	88 09       	CC = R0 < R1 (IU);
8d503788:	44 6c       	P4 += 0x8;		/* (  8) */
8d50378a:	53 32       	P2 = P3;
8d50378c:	dc 06       	IF !CC P3 = P4;
8d50378e:	d1 06       	IF !CC P2 = P1;
8d503790:	5c 91       	P4 = [P3];
8d503792:	a1 e5 2d 00 	R1 = B[P4 + 0x2d] (X);
8d503796:	01 0c       	CC = R1 == 0x0;
8d503798:	03 10       	IF !CC JUMP 0x0x8d50379e;
8d50379a:	4a 32       	P1 = P2;
8d50379c:	f0 2f       	JUMP.S 0x0x8d50377c;
8d50379e:	50 08       	CC = P0 == P2;
8d5037a0:	20 18       	IF CC JUMP 0x0x8d5037e0;
8d5037a2:	60 32       	P4 = P0;
8d5037a4:	d0 e0 1c 00 	LSETUP_IMM(bottom=0x8d5037dc) LC1 count_fields=0x0/0x0;
8d5037a8:	a0 e5 2d 00 	R0 = B[P4 + 0x2d] (X);
8d5037ac:	00 0c       	CC = R0 == 0x0;
8d5037ae:	16 10       	IF !CC JUMP 0x0x8d5037da;
8d5037b0:	a3 ac       	P3 = [P4 + 0x8];
8d5037b2:	98 e5 2d 00 	R0 = B[P3 + 0x2d] (X);
8d5037b6:	00 0c       	CC = R0 == 0x0;
8d5037b8:	30 10       	IF !CC JUMP 0x0x8d503818;
8d5037ba:	59 91       	P1 = [P3];
8d5037bc:	63 32       	P4 = P3;
8d5037be:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d5037c2:	00 0c       	CC = R0 == 0x0;
8d5037c4:	0b 10       	IF !CC JUMP 0x0x8d5037da;
8d5037c6:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d5037d4) LC0 count_fields=0x0/0x0;
8d5037ca:	61 32       	P4 = P1;
8d5037cc:	61 91       	P1 = [P4];
8d5037ce:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d5037d2:	00 0c       	CC = R0 == 0x0;
8d5037d4:	03 10       	IF !CC JUMP 0x0x8d5037da;
8d5037d6:	61 91       	P1 = [P4];
8d5037d8:	f7 2f       	JUMP.S 0x0x8d5037c6;
8d5037da:	62 08       	CC = P2 == P4;
8d5037dc:	02 18       	IF CC JUMP 0x0x8d5037e0;
8d5037de:	e3 2f       	JUMP.S 0x0x8d5037a4;
8d5037e0:	09 da a4 84 	P1=-2069571776;
8d5037e4:	40 d7 00 00 
8d5037e8:	52 30       	R2 = P2;
8d5037ea:	48 30       	R1 = P0;
8d5037ec:	41 30       	R0 = P1;
8d5037ee:	fe e3 95 f4 	CALL 0x0x8d4e2118;
8d5037f2:	a8 e4 0d 00 	R0 = B[P5 + 0xd] (Z);
8d5037f6:	00 0c       	CC = R0 == 0x0;
8d5037f8:	0a 18       	IF CC JUMP 0x0x8d50380c;
8d5037fa:	6f a0       	R7 = [P5 + 0x4];
8d5037fc:	07 0c       	CC = R7 == 0x0;
8d5037fe:	07 18       	IF CC JUMP 0x0x8d50380c;
8d503800:	07 30       	R0 = R7;
8d503802:	ff e3 2b e3 	CALL 0x0x8d4ffe58;
8d503806:	07 30       	R0 = R7;
8d503808:	fe e3 ee 55 	CALL 0x0x8d4ce3e4;
8d50380c:	66 6c       	SP += 0xc;		/* ( 12) */
8d50380e:	bb 05       	(R7:7, P5:3) = [SP++];
8d503810:	01 e8 00 00 	UNLINK;
8d503814:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d503816:	10 00       	RTS;
8d503818:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d50382e) LC0 count_fields=0x0/0x0;
8d50381c:	61 ac       	P1 = [P4 + 0x4];
8d50381e:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d503822:	00 0c       	CC = R0 == 0x0;
8d503824:	09 10       	IF !CC JUMP 0x0x8d503836;
8d503826:	44 30       	R0 = P4;
8d503828:	89 a0       	R1 = [P1 + 0x8];
8d50382a:	01 08       	CC = R1 == R0;
8d50382c:	03 10       	IF !CC JUMP 0x0x8d503832;
8d50382e:	61 32       	P4 = P1;
8d503830:	f4 2f       	JUMP.S 0x0x8d503818;
8d503832:	61 32       	P4 = P1;
8d503834:	d3 2f       	JUMP.S 0x0x8d5037da;
8d503836:	61 32       	P4 = P1;
8d503838:	d1 2f       	JUMP.S 0x0x8d5037da;
8d50383a:	00 00       	NOP;
8d50383c:	93 e5 2d 00 	R3 = B[P2 + 0x2d] (X);
8d503840:	03 0c       	CC = R3 == 0x0;
8d503842:	03 18       	IF CC JUMP 0x0x8d503848;
8d503844:	91 09       	CC = R1 < R2 (IU);
8d503846:	d1 07       	IF CC P2 = P1;
8d503848:	41 32       	P0 = P1;
8d50384a:	88 2f       	JUMP.S 0x0x8d50375a;
8d50384c:	66 6c       	SP += 0xc;		/* ( 12) */
8d50384e:	bb 05       	(R7:7, P5:3) = [SP++];
8d503850:	01 e8 00 00 	UNLINK;
8d503854:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d503856:	10 00       	RTS;
