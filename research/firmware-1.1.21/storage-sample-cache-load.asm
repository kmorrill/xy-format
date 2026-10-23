
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d50362c <.data+0x3760c>:
8d50362c:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d503630:	e5 05       	[--SP] = (R7:4, P5:5);
8d503632:	38 30       	R7 = R0;
8d503634:	66 6f       	SP += -0x14;		/* (-20) */
8d503636:	2f 32       	P5 = R7;
8d503638:	0f 30       	R1 = R7;
8d50363a:	00 da a4 84 	R0=-2069571776;
8d50363e:	40 d7 00 00 
8d503642:	ff e3 92 ee 	CALL 0x0x8d501366;
8d503646:	09 da a4 84 	P1=-2069571776;
8d50364a:	40 d7 00 00 
8d50364e:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R1 = [P1 + 0x4] || NOP;
8d503652:	49 a0 00 00 
8d503656:	01 08       	CC = R1 == R0;
8d503658:	44 18       	IF CC JUMP 0x0x8d5036e0;
8d50365a:	6f 30       	R5 = FP;
8d50365c:	25 67       	R5 += -0x1c;		/* (-28) */
8d50365e:	0f 30       	R1 = R7;
8d503660:	00 da a4 84 	R0=-2069571776;
8d503664:	40 d7 00 00 
8d503668:	ff e3 7f ee 	CALL 0x0x8d501366;
8d50366c:	08 30       	R1 = R0;
8d50366e:	81 64       	R1 += 0x10;		/* ( 16) */
8d503670:	05 30       	R0 = R5;
8d503672:	05 e3 1f 06 	CALL 0x0x8d5a42b0;
8d503676:	20 e1 40 00 	R0 = 0x40 (X);		/*		R0=0x40( 64) */
8d50367a:	fe e3 ad 56 	CALL 0x0x8d4ce3d4;
8d50367e:	20 30       	R4 = R0;
8d503680:	04 0c       	CC = R4 == 0x0;
8d503682:	08 30       	R1 = R0;
8d503684:	00 60       	R0 = 0x0 (X);		/*		R0=0x40( 64) */
8d503686:	05 18       	IF CC JUMP 0x0x8d503690;
8d503688:	01 30       	R0 = R1;
8d50368a:	ff e3 c1 e3 	CALL 0x0x8d4ffe0c;
8d50368e:	04 30       	R0 = R4;
8d503690:	0d 30       	R1 = R5;
8d503692:	68 b0       	[P5 + 0x4] = R0;
8d503694:	ff e3 53 e5 	CALL 0x0x8d50013a;
8d503698:	00 0c       	CC = R0 == 0x0;
8d50369a:	28 30       	R5 = R0;
8d50369c:	0a 10       	IF !CC JUMP 0x0x8d5036b0;
8d50369e:	6f a0       	R7 = [P5 + 0x4];
8d5036a0:	07 0c       	CC = R7 == 0x0;
8d5036a2:	07 18       	IF CC JUMP 0x0x8d5036b0;
8d5036a4:	07 30       	R0 = R7;
8d5036a6:	ff e3 d9 e3 	CALL 0x0x8d4ffe58;
8d5036aa:	07 30       	R0 = R7;
8d5036ac:	fe e3 9c 56 	CALL 0x0x8d4ce3e4;
8d5036b0:	f0 b9       	R0 = [FP -0x4];
8d5036b2:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d5036b4:	01 0a       	CC = R1 <= R0 (IU);
8d5036b6:	09 18       	IF CC JUMP 0x0x8d5036c8;
8d5036b8:	b6 e6 2c 00 	B[SP + 0x2c] = R6;
8d5036bc:	a6 6c       	SP += 0x14;		/* ( 20) */
8d5036be:	05 30       	R0 = R5;
8d5036c0:	a5 05       	(R7:4, P5:5) = [SP++];
8d5036c2:	01 e8 00 00 	UNLINK;
8d5036c6:	10 00       	RTS;
8d5036c8:	f0 a2       	R0 = [SP + 0x2c];
8d5036ca:	fe e3 8d 56 	CALL 0x0x8d4ce3e4;
8d5036ce:	b6 e6 2c 00 	B[SP + 0x2c] = R6;
8d5036d2:	a6 6c       	SP += 0x14;		/* ( 20) */
8d5036d4:	05 30       	R0 = R5;
8d5036d6:	a5 05       	(R7:4, P5:5) = [SP++];
8d5036d8:	01 e8 00 00 	UNLINK;
8d5036dc:	10 00       	RTS;
8d5036de:	00 00       	NOP;
8d5036e0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5036e4:	fc 1e 00 00 
8d5036e8:	80 0c       	CC = R0 < 0x0;
8d5036ea:	05 10       	IF !CC JUMP 0x0x8d5036f4;
8d5036ec:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d5036f0:	24 2b 00 00 
8d5036f4:	0f 32       	P1 = R7;
8d5036f6:	08 da 04 84 	P0=-2080095100;
8d5036fa:	84 44 00 00 
8d5036fe:	04 cc 00 40 	R0 = R0 - R0 (NS) || [SP + 0xc] = P0 || NOP;
8d503702:	f0 bc 00 00 
8d503706:	22 e1 45 00 	R2 = 0x45 (X);		/*		R2=0x45( 69) */
8d50370a:	01 da 04 84 	R1=-2080095164;
8d50370e:	44 44 00 00 
8d503712:	0b 91       	R3 = [P1];
8d503714:	33 b1       	[SP + 0x10] = R3;
8d503716:	00 de 04 8c 	CALL.A 0x8c040574;
8d50371a:	74 05 00 00 
8d50371e:	e7 2f       	JUMP.S 0x0x8d5036ec;
