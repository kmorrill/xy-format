
os.ldr@0x8d4d7624:     file format binary


Disassembly of section .data:

8d4d7624 <.data>:
8d4d7624:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4d7628:	eb 05       	[--SP] = (R7:5, P5:3);
8d4d762a:	38 30       	R7 = R0;
8d4d762c:	2f 32       	P5 = R7;
8d4d762e:	a6 6f       	SP += -0xc;		/* (-12) */
8d4d7630:	b1 e6 30 00 	B[SP + 0x30] = R1;
8d4d7634:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
8d4d7636:	68 a1       	R0 = [P5 + 0x14];
8d4d7638:	00 0c       	CC = R0 == 0x0;
8d4d763a:	1b 18       	IF CC JUMP 0x0x8d4d7670;
8d4d763c:	ab a1       	R3 = [P5 + 0x18];
8d4d763e:	1d 0a       	CC = R5 <= R3 (IU);
8d4d7640:	65 32       	P4 = P5;
8d4d7642:	25 6c       	P5 += 0x4;		/* (  4) */
8d4d7644:	4d 32       	P1 = P5;
8d4d7646:	02 10       	IF !CC JUMP 0x0x8d4d764a;
8d4d7648:	69 91       	P1 = [P5];
8d4d764a:	f8 67       	R0 += -0x1;		/* ( -1) */
8d4d764c:	82 09       	CC = R2 < R0 (IU);
8d4d764e:	02 07       	IF CC R0 = R2;
8d4d7650:	00 32       	P0 = R0;
8d4d7652:	c1 5a       	P3 = P1 + P0;
8d4d7654:	0b 6c       	P3 += 0x1;		/* (  1) */
8d4d7656:	fb 6f       	P3 += -0x1;		/* ( -1) */
8d4d7658:	58 99       	R0 = B[P3] (X);
8d4d765a:	08 08       	CC = R0 == R1;
8d4d765c:	13 18       	IF CC JUMP 0x0x8d4d7682;
8d4d765e:	a0 a1       	R0 = [P4 + 0x18];
8d4d7660:	05 0a       	CC = R5 <= R0 (IU);
8d4d7662:	4d 32       	P1 = P5;
8d4d7664:	02 10       	IF !CC JUMP 0x0x8d4d7668;
8d4d7666:	61 ac       	P1 = [P4 + 0x4];
8d4d7668:	4b 08       	CC = P3 == P1;
8d4d766a:	b1 e5 30 00 	R1 = B[SP + 0x30] (X);
8d4d766e:	f4 17       	IF !CC JUMP 0x0x8d4d7656 (BP);
8d4d7670:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d4d7674:	b8 00 00 00 
8d4d7678:	66 6c       	SP += 0xc;		/* ( 12) */
8d4d767a:	ab 05       	(R7:5, P5:3) = [SP++];
8d4d767c:	01 e8 00 00 	UNLINK;
8d4d7680:	10 00       	RTS;
8d4d7682:	73 30       	R6 = P3;
8d4d7684:	4f 30       	R1 = FP;
8d4d7686:	61 64       	R1 += 0xc;		/* ( 12) */
8d4d7688:	06 30       	R0 = R6;
8d4d768a:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4d768c:	00 de 02 04 	CALL.A 0x04023068;
8d4d7690:	68 30 00 00 
8d4d7694:	00 0c       	CC = R0 == 0x0;
8d4d7696:	e4 17       	IF !CC JUMP 0x0x8d4d765e (BP);
8d4d7698:	a0 a1       	R0 = [P4 + 0x18];
8d4d769a:	05 0a       	CC = R5 <= R0 (IU);
8d4d769c:	27 64       	R7 += 0x4;		/* (  4) */
8d4d769e:	02 10       	IF !CC JUMP 0x0x8d4d76a2;
8d4d76a0:	2f 91       	R7 = [P5];
8d4d76a2:	66 6c       	SP += 0xc;		/* ( 12) */
8d4d76a4:	3e 52       	R0 = R6 - R7;
8d4d76a6:	ab 05       	(R7:5, P5:3) = [SP++];
8d4d76a8:	01 e8 00 00 	UNLINK;
8d4d76ac:	10 00       	RTS;
8d4d76ae:	08 32       	P1 = R0;
8d4d76b0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4d76b4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4d76b6:	48 b0       	[P1 + 0x4] = R0;
8d4d76b8:	88 b0       	[P1 + 0x8] = R0;
8d4d76ba:	88 e6 0c 00 	B[P1 + 0xc] = R0;
8d4d76be:	88 e6 0d 00 	B[P1 + 0xd] = R0;
8d4d76c2:	88 e6 0e 00 	B[P1 + 0xe] = R0;
8d4d76c6:	01 e8 00 00 	UNLINK;
8d4d76ca:	10 00       	RTS;
8d4d76cc:	08 32       	P1 = R0;
8d4d76ce:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4d76d2:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4d76d4:	08 e6 e4 14 	[P1 + 0x5390] = R0;
8d4d76d8:	08 e6 c3 14 	[P1 + 0x530c] = R0;
