
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d560580 <.data+0x94560>:
8d560580:	00 e8 15 00 	LINK 0x54;		/* (84) */
8d560584:	68 05       	[--SP] = (R7:5);
8d560586:	77 30       	R6 = FP;
8d560588:	46 66       	R6 += -0x38;		/* (-56) */
8d56058a:	38 30       	R7 = R0;
8d56058c:	a6 6f       	SP += -0xc;		/* (-12) */
8d56058e:	06 30       	R0 = R6;
8d560590:	02 e3 54 22 	CALL 0x0x8d5a4a38;
8d560594:	0e 30       	R1 = R6;
8d560596:	2e 30       	R5 = R6;
8d560598:	26 67       	R6 += -0x1c;		/* (-28) */
8d56059a:	06 30       	R0 = R6;
8d56059c:	02 da 06 84 	R2=-2079940796;
8d5605a0:	44 9f 00 00 
8d5605a4:	00 de 03 8c 	CALL.A 0x8c03f194;
8d5605a8:	94 f1 00 00 
8d5605ac:	57 30       	R2 = FP;
8d5605ae:	0e 30       	R1 = R6;
8d5605b0:	07 30       	R0 = R7;
8d5605b2:	22 67       	R2 += -0x1c;		/* (-28) */
8d5605b4:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d5605b8:	e4 f0 00 00 
8d5605bc:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8d5605be:	31 a3       	R1 = [SP + 0x30];
8d5605c0:	08 0a       	CC = R0 <= R1 (IU);
8d5605c2:	13 18       	IF CC JUMP 0x0x8d5605e8;
8d5605c4:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d5605c6:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [SP + 0x2c] = R1 || NOP;
8d5605ca:	f1 b2 00 00 
8d5605ce:	b1 e6 1c 00 	B[SP + 0x1c] = R1;
8d5605d2:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8d5605d4:	31 b3       	[SP + 0x30] = R1;
8d5605d6:	00 de 08 8c 	CALL.A 0x8c084c48;
8d5605da:	48 4c 00 00 
8d5605de:	66 6c       	SP += 0xc;		/* ( 12) */
8d5605e0:	28 05       	(R7:5) = [SP++];
8d5605e2:	01 e8 00 00 	UNLINK;
8d5605e6:	10 00       	RTS;
8d5605e8:	f0 a1       	R0 = [SP + 0x1c];
8d5605ea:	fb e3 fd 6e 	CALL 0x0x8d4ce3e4;
8d5605ee:	eb 2f       	JUMP.S 0x0x8d5605c4;
