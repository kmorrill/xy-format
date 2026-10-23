
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d4f66b4 <.data+0x2a694>:
8d4f66b4:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d4f66b8:	e4 05       	[--SP] = (R7:4, P5:4);
8d4f66ba:	28 32       	P5 = R0;
8d4f66bc:	66 6f       	SP += -0x14;		/* (-20) */
8d4f66be:	39 30       	R7 = R1;
8d4f66c0:	77 30       	R6 = FP;
8d4f66c2:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
8d4f66c4:	03 c8 00 18 	MNOP || P1 = [P5] || R0 = [P5];
8d4f66c8:	69 91 28 91 
8d4f66cc:	00 0c       	CC = R0 == 0x0;
8d4f66ce:	04 18       	IF CC JUMP 0x0x8d4f66d6;
8d4f66d0:	49 91       	P1 = [P1];
8d4f66d2:	49 ac       	P1 = [P1 + 0x4];
8d4f66d4:	61 00       	CALL (P1);
8d4f66d6:	0f 30       	R1 = R7;
8d4f66d8:	46 66       	R6 += -0x38;		/* (-56) */
8d4f66da:	06 30       	R0 = R6;
8d4f66dc:	05 e3 b2 70 	CALL 0x0x8d5a4840;
8d4f66e0:	06 30       	R0 = R6;
8d4f66e2:	0e 30       	R1 = R6;
8d4f66e4:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4f66e6:	05 e3 e5 71 	CALL 0x0x8d5a4ab0;
8d4f66ea:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R0 = [FP -0x20] || NOP;
8d4f66ee:	80 b9 00 00 
8d4f66f2:	05 0a       	CC = R5 <= R0 (IU);
8d4f66f4:	b1 18       	IF CC JUMP 0x0x8d4f6856;
8d4f66f6:	67 30       	R4 = FP;
8d4f66f8:	24 67       	R4 += -0x1c;		/* (-28) */
8d4f66fa:	b6 e6 30 00 	B[SP + 0x30] = R6;
8d4f66fe:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d4f6700:	80 bb       	[FP -0x20] = R0;
8d4f6702:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP -0x24] = R6 || NOP;
8d4f6706:	76 bb 00 00 
8d4f670a:	01 da 03 84 	R1=-2080125684;
8d4f670e:	0c cd 00 00 
8d4f6712:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4f6716:	88 bf 00 00 
8d4f671a:	00 0c       	CC = R0 == 0x0;
8d4f671c:	0c da 03 84 	P4=-2080126260;
8d4f6720:	cc ca 00 00 
8d4f6724:	36 18       	IF CC JUMP 0x0x8d4f6790;
8d4f6726:	60 60       	R0 = 0xc (X);		/*		R0=0x0(  0) */
8d4f6728:	fe e3 56 be 	CALL 0x0x8d4ce3d4;
8d4f672c:	08 32       	P1 = R0;
8d4f672e:	00 0c       	CC = R0 == 0x0;
8d4f6730:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4f6732:	0d 18       	IF CC JUMP 0x0x8d4f674c;
8d4f6734:	21 e4 fd ff 	R1 = [P4 + -0xc];
8d4f6738:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [P1++] = R1 || NOP;
8d4f673c:	09 92 00 00 
8d4f6740:	20 e4 fe ff 	R0 = [P4 + -0x8];
8d4f6744:	08 92       	[P1++] = R0;
8d4f6746:	20 e4 ff ff 	R0 = [P4 + -0x4];
8d4f674a:	08 93       	[P1] = R0;
8d4f674c:	01 30       	R0 = R1;
8d4f674e:	08 32       	P1 = R0;
8d4f6750:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [P5] = R0 || NOP;
8d4f6754:	28 93 00 00 
8d4f6758:	49 91       	P1 = [P1];
8d4f675a:	89 ac       	P1 = [P1 + 0x8];
8d4f675c:	61 00       	CALL (P1);
8d4f675e:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x4] || NOP;
8d4f6762:	f0 b9 00 00 
8d4f6766:	05 0a       	CC = R5 <= R0 (IU);
8d4f6768:	07 30       	R0 = R7;
8d4f676a:	08 18       	IF CC JUMP 0x0x8d4f677a;
8d4f676c:	b6 e6 4c 00 	B[SP + 0x4c] = R6;
8d4f6770:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4f6772:	a4 05       	(R7:4, P5:4) = [SP++];
8d4f6774:	01 e8 00 00 	UNLINK;
8d4f6778:	10 00       	RTS;
8d4f677a:	a0 b9       	R0 = [FP -0x18];
8d4f677c:	fe e3 34 be 	CALL 0x0x8d4ce3e4;
8d4f6780:	b6 e6 4c 00 	B[SP + 0x4c] = R6;
8d4f6784:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4f6786:	07 30       	R0 = R7;
8d4f6788:	a4 05       	(R7:4, P5:4) = [SP++];
8d4f678a:	01 e8 00 00 	UNLINK;
8d4f678e:	10 00       	RTS;
8d4f6790:	01 da 03 84 	R1=-2080125684;
8d4f6794:	0c cd 00 00 
8d4f6798:	41 64       	R1 += 0x8;		/* (  8) */
8d4f679a:	04 30       	R0 = R4;
8d4f679c:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4f67a0:	88 bf 00 00 
8d4f67a4:	00 0c       	CC = R0 == 0x0;
8d4f67a6:	49 10       	IF !CC JUMP 0x0x8d4f6838;
8d4f67a8:	01 da 03 84 	R1=-2080125684;
8d4f67ac:	0c cd 00 00 
8d4f67b0:	81 64       	R1 += 0x10;		/* ( 16) */
8d4f67b2:	04 30       	R0 = R4;
8d4f67b4:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4f67b8:	88 bf 00 00 
8d4f67bc:	00 0c       	CC = R0 == 0x0;
8d4f67be:	3d 10       	IF !CC JUMP 0x0x8d4f6838;
8d4f67c0:	01 da 03 84 	R1=-2080125684;
8d4f67c4:	0c cd 00 00 
8d4f67c8:	04 30       	R0 = R4;
8d4f67ca:	c1 64       	R1 += 0x18;		/* ( 24) */
8d4f67cc:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4f67d0:	88 bf 00 00 
8d4f67d4:	00 0c       	CC = R0 == 0x0;
8d4f67d6:	31 10       	IF !CC JUMP 0x0x8d4f6838;
8d4f67d8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4f67dc:	fc 1e 00 00 
8d4f67e0:	88 0c       	CC = R0 < 0x1;
8d4f67e2:	12 10       	IF !CC JUMP 0x0x8d4f6806;
8d4f67e4:	04 cc 00 40 	R0 = R0 - R0 (NS) || R1 = [FP -0x4] || [P5] = R6;
8d4f67e8:	f1 b9 2e 93 
8d4f67ec:	0d 0a       	CC = R5 <= R1 (IU);
8d4f67ee:	bf 17       	IF !CC JUMP 0x0x8d4f676c (BP);
8d4f67f0:	a0 b9       	R0 = [FP -0x18];
8d4f67f2:	fe e3 f9 bd 	CALL 0x0x8d4ce3e4;
8d4f67f6:	b6 e6 4c 00 	B[SP + 0x4c] = R6;
8d4f67fa:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4f67fc:	a4 05       	(R7:4, P5:4) = [SP++];
8d4f67fe:	01 e8 00 00 	UNLINK;
8d4f6802:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4f6804:	10 00       	RTS;
8d4f6806:	0f 32       	P1 = R7;
8d4f6808:	27 64       	R7 += 0x4;		/* (  4) */
8d4f680a:	22 e1 00 01 	R2 = 0x100 (X);		/*		R2=0x100(256) */
8d4f680e:	01 da 03 84 	R1=-2080125652;
8d4f6812:	2c cd 00 00 
8d4f6816:	88 a1       	R0 = [P1 + 0x18];
8d4f6818:	0f 32       	P1 = R7;
8d4f681a:	05 0a       	CC = R5 <= R0 (IU);
8d4f681c:	02 10       	IF !CC JUMP 0x0x8d4f6820;
8d4f681e:	0f 91       	R7 = [P1];
8d4f6820:	37 b1       	[SP + 0x10] = R7;
8d4f6822:	09 da 03 84 	P1=-2080125620;
8d4f6826:	4c cd 00 00 
8d4f682a:	f1 bc       	[SP + 0xc] = P1;
8d4f682c:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4f682e:	00 de 04 8c 	CALL.A 0x8c040574;
8d4f6832:	74 05 00 00 
8d4f6836:	d7 2f       	JUMP.S 0x0x8d4f67e4;
8d4f6838:	40 60       	R0 = 0x8 (X);		/*		R0=0x0(  0) */
8d4f683a:	fe e3 cd bd 	CALL 0x0x8d4ce3d4;
8d4f683e:	08 32       	P1 = R0;
8d4f6840:	00 0c       	CC = R0 == 0x0;
8d4f6842:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4f6844:	07 18       	IF CC JUMP 0x0x8d4f6852;
8d4f6846:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || R0 = [P4] || R2 = [P4 + 0x4];
8d4f684a:	20 91 62 a0 
8d4f684e:	08 92       	[P1++] = R0;
8d4f6850:	0a 93       	[P1] = R2;
8d4f6852:	01 30       	R0 = R1;
8d4f6854:	7d 2f       	JUMP.S 0x0x8d4f674e;
8d4f6856:	30 a3       	R0 = [SP + 0x30];
8d4f6858:	fe e3 c6 bd 	CALL 0x0x8d4ce3e4;
8d4f685c:	4d 2f       	JUMP.S 0x0x8d4f66f6;
