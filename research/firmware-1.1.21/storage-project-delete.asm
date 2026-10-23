
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d5605f0 <.data+0x945d0>:
8d5605f0:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d5605f4:	f5 05       	[--SP] = (R7:6, P5:5);
8d5605f6:	38 30       	R7 = R0;
8d5605f8:	2f 32       	P5 = R7;
8d5605fa:	66 6f       	SP += -0x14;		/* (-20) */
8d5605fc:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d560600:	fc 1e 00 00 
8d560604:	98 0c       	CC = R0 < 0x3;
8d560606:	59 10       	IF !CC JUMP 0x0x8d5606b8;
8d560608:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [P5 + 0x18] || NOP;
8d56060c:	a9 a1 00 00 
8d560610:	20 64       	R0 += 0x4;		/* (  4) */
8d560612:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d560614:	08 32       	P1 = R0;
8d560616:	0e 0a       	CC = R6 <= R1 (IU);
8d560618:	02 10       	IF !CC JUMP 0x0x8d56061c;
8d56061a:	08 91       	R0 = [P1];
8d56061c:	00 de 03 8c 	CALL.A 0x8c03e040;
8d560620:	40 e0 00 00 
8d560624:	0f 30       	R1 = R7;
8d560626:	47 30       	R0 = FP;
8d560628:	20 67       	R0 += -0x1c;		/* (-28) */
8d56062a:	ff e3 ab ff 	CALL 0x0x8d560580;
8d56062e:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d560632:	fc 1e 00 00 
8d560636:	98 0c       	CC = R0 < 0x3;
8d560638:	24 10       	IF !CC JUMP 0x0x8d560680;
8d56063a:	47 30       	R0 = FP;
8d56063c:	40 67       	R0 += -0x18;		/* (-24) */
8d56063e:	03 c8 00 18 	MNOP || R1 = [SP + 0x38] || R2 = [SP + 0x24];
8d560642:	b1 a3 72 a2 
8d560646:	0e 0a       	CC = R6 <= R1 (IU);
8d560648:	02 07       	IF CC R0 = R2;
8d56064a:	00 de 03 8c 	CALL.A 0x8c03e268;
8d56064e:	68 e2 00 00 
8d560652:	b0 a3       	R0 = [SP + 0x38];
8d560654:	06 0a       	CC = R6 <= R0 (IU);
8d560656:	09 18       	IF CC JUMP 0x0x8d560668;
8d560658:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d56065a:	b0 e6 24 00 	B[SP + 0x24] = R0;
8d56065e:	a6 6c       	SP += 0x14;		/* ( 20) */
8d560660:	b5 05       	(R7:6, P5:5) = [SP++];
8d560662:	01 e8 00 00 	UNLINK;
8d560666:	10 00       	RTS;
8d560668:	70 a2       	R0 = [SP + 0x24];
8d56066a:	fb e3 bd 6e 	CALL 0x0x8d4ce3e4;
8d56066e:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d560670:	b0 e6 24 00 	B[SP + 0x24] = R0;
8d560674:	a6 6c       	SP += 0x14;		/* ( 20) */
8d560676:	b5 05       	(R7:6, P5:5) = [SP++];
8d560678:	01 e8 00 00 	UNLINK;
8d56067c:	10 00       	RTS;
8d56067e:	00 00       	NOP;
8d560680:	03 c8 00 18 	MNOP || P0 = [SP + 0x24] || R0 = [SP + 0x38];
8d560684:	70 ae b0 a3 
8d560688:	4f 32       	P1 = FP;
8d56068a:	06 0a       	CC = R6 <= R0 (IU);
8d56068c:	41 6f       	P1 += -0x18;		/* (-24) */
8d56068e:	c8 07       	IF CC P1 = P0;
8d560690:	31 bd       	[SP + 0x10] = P1;
8d560692:	09 da 06 84 	P1=-2079940640;
8d560696:	e0 9f 00 00 
8d56069a:	f1 bc       	[SP + 0xc] = P1;
8d56069c:	22 e1 9e 00 	R2 = 0x9e (X);		/*		R2=0x9e(158) */
8d5606a0:	01 da 06 84 	R1=-2079940696;
8d5606a4:	a8 9f 00 00 
8d5606a8:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d5606aa:	00 de 04 8c 	CALL.A 0x8c040574;
8d5606ae:	74 05 00 00 
8d5606b2:	c4 2f       	JUMP.S 0x0x8d56063a;
8d5606b4:	00 00       	NOP;
8d5606b6:	00 00       	NOP;
8d5606b8:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [P5 + 0x18] || NOP;
8d5606bc:	a9 a1 00 00 
8d5606c0:	20 64       	R0 += 0x4;		/* (  4) */
8d5606c2:	82 60       	R2 = 0x10 (X);		/*		R2=0x9e(158) */
8d5606c4:	08 32       	P1 = R0;
8d5606c6:	0a 0a       	CC = R2 <= R1 (IU);
8d5606c8:	02 10       	IF !CC JUMP 0x0x8d5606cc;
8d5606ca:	08 91       	R0 = [P1];
8d5606cc:	30 b1       	[SP + 0x10] = R0;
8d5606ce:	09 da 06 84 	P1=-2079940660;
8d5606d2:	cc 9f 00 00 
8d5606d6:	f1 bc       	[SP + 0xc] = P1;
8d5606d8:	22 e1 9b 00 	R2 = 0x9b (X);		/*		R2=0x9b(155) */
8d5606dc:	01 da 06 84 	R1=-2079940696;
8d5606e0:	a8 9f 00 00 
8d5606e4:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d5606e6:	00 de 04 8c 	CALL.A 0x8c040574;
8d5606ea:	74 05 00 00 
8d5606ee:	8d 2f       	JUMP.S 0x0x8d560608;
8d5606f0:	00 00       	NOP;
8d5606f2:	00 00       	NOP;
8d5606f4:	00 e8 1f 00 	LINK 0x7c;		/* (124) */
8d5606f8:	e3 05       	[--SP] = (R7:4, P5:3);
8d5606fa:	86 6f       	SP += -0x10;		/* (-16) */
8d5606fc:	04 cc 36 4c 	R6 = R6 - R6 (NS) || [FP + 0xc] = R0 || NOP;
8d560700:	    
