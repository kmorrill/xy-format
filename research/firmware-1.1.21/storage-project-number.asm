
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d55b32e <.data+0x8f30e>:
8d55b32e:	00 32       	P0 = R0;
8d55b330:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d55b334:	eb 05       	[--SP] = (R7:5, P5:3);
8d55b336:	86 6f       	SP += -0x10;		/* (-16) */
8d55b338:	02 68       	P2 = 0x0 (X);		/*		P2=0x0(  0) */
8d55b33a:	41 a1       	R1 = [P0 + 0x14];
8d55b33c:	99 0d       	CC = R1 < 0x3 (IU);
8d55b33e:	53 18       	IF CC JUMP 0x0x8d55b3e4;
8d55b340:	82 a1       	R2 = [P0 + 0x18];
8d55b342:	48 32       	P1 = P0;
8d55b344:	20 6c       	P0 += 0x4;		/* (  4) */
8d55b346:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d55b348:	0c da 02 04 	P4=67255722;
8d55b34c:	aa 3d 00 00 
8d55b350:	c0 e0 11 0c 	LSETUP_IMM(bottom=0x8d55b372) LC0 count_fields=0x0/0x3;
8d55b354:	16 0a       	CC = R6 <= R2 (IU);
8d55b356:	6a 32       	P5 = P2;
8d55b358:	58 32       	P3 = P0;
8d55b35a:	0a 6c       	P2 += 0x1;		/* (  1) */
8d55b35c:	02 10       	IF !CC JUMP 0x0x8d55b360;
8d55b35e:	4b ac       	P3 = [P1 + 0x4];
8d55b360:	6b 5b       	P5 = P3 + P5;
8d55b362:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || R1 = B[P5] (Z) || NOP;
8d55b366:	29 99 00 00 
8d55b36a:	29 32       	P5 = R1;
8d55b36c:	6c 5d       	P5 = P4 + (P5 << 0x1);
8d55b36e:	6d 82       	R1.L = W[P5];
8d55b370:	29 49       	CC = BITTST (R1, 0x5);		/* bit  5 */
8d55b372:	33 10       	IF !CC JUMP 0x0x8d55b3d8;
8d55b374:	08 30       	R1 = R0;
8d55b376:	19 68       	P1 = 0x3 (X);		/*		P1=0x0(  0) */
8d55b378:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = P1 || NOP;
8d55b37c:	f1 bc 00 00 
8d55b380:	47 30       	R0 = FP;
8d55b382:	20 67       	R0 += -0x1c;		/* (-28) */
8d55b384:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d55b388:	a6 ec 00 00 
8d55b38c:	47 30       	R0 = FP;
8d55b38e:	40 67       	R0 += -0x18;		/* (-24) */
8d55b390:	52 60       	R2 = 0xa (X);		/*		R2=0x0(  0) */
8d55b392:	04 cc 09 42 	R1 = R1 - R1 (NS) || R3 = [FP -0x4] || R7 = [SP + 0x2c];
8d55b396:	f3 b9 f7 a2 
8d55b39a:	1e 0a       	CC = R6 <= R3 (IU);
8d55b39c:	07 07       	IF CC R0 = R7;
8d55b39e:	00 de ed 8f 	CALL.A 0x8fed45ac;
8d55b3a2:	ac 45 00 00 
8d55b3a6:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x4] || NOP;
8d55b3aa:	f0 b9 00 00 
8d55b3ae:	06 0a       	CC = R6 <= R0 (IU);
8d55b3b0:	09 18       	IF CC JUMP 0x0x8d55b3c2;
8d55b3b2:	b5 e6 2c 00 	B[SP + 0x2c] = R5;
8d55b3b6:	86 6c       	SP += 0x10;		/* ( 16) */
8d55b3b8:	07 30       	R0 = R7;
8d55b3ba:	ab 05       	(R7:5, P5:3) = [SP++];
8d55b3bc:	01 e8 00 00 	UNLINK;
8d55b3c0:	10 00       	RTS;
8d55b3c2:	f0 a2       	R0 = [SP + 0x2c];
8d55b3c4:	fb e3 10 98 	CALL 0x0x8d4ce3e4;
8d55b3c8:	b5 e6 2c 00 	B[SP + 0x2c] = R5;
8d55b3cc:	86 6c       	SP += 0x10;		/* ( 16) */
8d55b3ce:	07 30       	R0 = R7;
8d55b3d0:	ab 05       	(R7:5, P5:3) = [SP++];
8d55b3d2:	01 e8 00 00 	UNLINK;
8d55b3d6:	10 00       	RTS;
8d55b3d8:	86 6c       	SP += 0x10;		/* ( 16) */
8d55b3da:	ab 05       	(R7:5, P5:3) = [SP++];
8d55b3dc:	01 e8 00 00 	UNLINK;
8d55b3e0:	f8 63       	R0 = -0x1 (X);		/*		R0=0x0(  0) */
8d55b3e2:	10 00       	RTS;
8d55b3e4:	86 6c       	SP += 0x10;		/* ( 16) */
8d55b3e6:	ab 05       	(R7:5, P5:3) = [SP++];
8d55b3e8:	01 e8 00 00 	UNLINK;
8d55b3ec:	f8 63       	R0 = -0x1 (X);		/*		R0=0x0(  0) */
8d55b3ee:	10 00       	RTS;
