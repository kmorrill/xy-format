
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d4f62dc <.data+0x2a2bc>:
8d4f62dc:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4f62e0:	f4 05       	[--SP] = (R7:6, P5:4);
8d4f62e2:	28 32       	P5 = R0;
8d4f62e4:	39 30       	R7 = R1;
8d4f62e6:	27 32       	P4 = R7;
8d4f62e8:	66 6f       	SP += -0x14;		/* (-20) */
8d4f62ea:	27 64       	R7 += 0x4;		/* (  4) */
8d4f62ec:	68 a0       	R0 = [P5 + 0x4];
8d4f62ee:	00 0c       	CC = R0 == 0x0;
8d4f62f0:	3c 10       	IF !CC JUMP 0x0x8d4f6368;
8d4f62f2:	0f 32       	P1 = R7;
8d4f62f4:	a0 a1       	R0 = [P4 + 0x18];
8d4f62f6:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d4f62f8:	06 0a       	CC = R6 <= R0 (IU);
8d4f62fa:	07 30       	R0 = R7;
8d4f62fc:	02 10       	IF !CC JUMP 0x0x8d4f6300;
8d4f62fe:	08 91       	R0 = [P1];
8d4f6300:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d4f6302:	00 de 05 8c 	CALL.A 0x8c05874a;
8d4f6306:	4a 87 00 00 
8d4f630a:	0f 32       	P1 = R7;
8d4f630c:	00 0c       	CC = R0 == 0x0;
8d4f630e:	68 b0       	[P5 + 0x4] = R0;
8d4f6310:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4f6312:	07 18       	IF CC JUMP 0x0x8d4f6320;
8d4f6314:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4f6316:	b4 05       	(R7:6, P5:4) = [SP++];
8d4f6318:	01 e8 00 00 	UNLINK;
8d4f631c:	10 00       	RTS;
8d4f631e:	00 00       	NOP;
8d4f6320:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4f6324:	fc 1e 00 00 
8d4f6328:	88 0c       	CC = R0 < 0x1;
8d4f632a:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4f632c:	f4 1f       	IF CC JUMP 0x0x8d4f6314 (BP);
8d4f632e:	a0 a1       	R0 = [P4 + 0x18];
8d4f6330:	06 0a       	CC = R6 <= R0 (IU);
8d4f6332:	02 10       	IF !CC JUMP 0x0x8d4f6336;
8d4f6334:	0f 91       	R7 = [P1];
8d4f6336:	09 da 03 84 	P1=-2080126164;
8d4f633a:	2c cb 00 00 
8d4f633e:	37 b1       	[SP + 0x10] = R7;
8d4f6340:	f1 bc       	[SP + 0xc] = P1;
8d4f6342:	5a 61       	R2 = 0x2b (X);		/*		R2=0x0(  0) */
8d4f6344:	01 da 03 84 	R1=-2080126196;
8d4f6348:	0c cb 00 00 
8d4f634c:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4f634e:	00 de 04 8c 	CALL.A 0x8c040574;
8d4f6352:	74 05 00 00 
8d4f6356:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4f6358:	b4 05       	(R7:6, P5:4) = [SP++];
8d4f635a:	01 e8 00 00 	UNLINK;
8d4f635e:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4f6360:	10 00       	RTS;
	...
