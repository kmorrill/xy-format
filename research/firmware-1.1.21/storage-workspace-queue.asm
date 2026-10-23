
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d4d937c <.data+0xd35c>:
8d4d937c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4d9380:	f5 05       	[--SP] = (R7:6, P5:5);
8d4d9382:	30 30       	R6 = R0;
8d4d9384:	86 6f       	SP += -0x10;		/* (-16) */
8d4d9386:	20 61       	R0 = 0x24 (X);		/*		R0=0x0(  0) */
8d4d9388:	ff e3 26 a8 	CALL 0x0x8d4ce3d4;
8d4d938c:	08 32       	P1 = R0;
8d4d938e:	00 0c       	CC = R0 == 0x0;
8d4d9390:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4d9392:	13 18       	IF CC JUMP 0x0x8d4d93b8;
8d4d9394:	31 60       	R1 = 0x6 (X);		/*		R1=0x0(  0) */
8d4d9396:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [P1 + 0x4] = R1 || NOP;
8d4d939a:	49 b0 00 00 
8d4d939e:	40 64       	R0 += 0x8;		/* (  8) */
8d4d93a0:	01 da 03 84 	R1=-2080154204;
8d4d93a4:	a4 5d 00 00 
8d4d93a8:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [P1] = R1 || NOP;
8d4d93ac:	09 93 00 00 
8d4d93b0:	00 de 03 8c 	CALL.A 0x8c03ee00;
8d4d93b4:	00 ee 00 00 
8d4d93b8:	00 d8 03 84 	LdStAbs addr=0x8403591c control=0x0001;
8d4d93bc:	1c 59 01 00 
8d4d93c0:	01 0c       	CC = R1 == 0x0;
8d4d93c2:	33 18       	IF CC JUMP 0x0x8d4d9428;
8d4d93c4:	2f 32       	P5 = R7;
8d4d93c6:	07 30       	R0 = R7;
8d4d93c8:	69 91       	P1 = [P5];
8d4d93ca:	c9 ad       	P1 = [P1 + 0x1c];
8d4d93cc:	61 00       	CALL (P1);
8d4d93ce:	00 0c       	CC = R0 == 0x0;
8d4d93d0:	2c 18       	IF CC JUMP 0x0x8d4d9428;
8d4d93d2:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4d93d6:	fc 1e 00 00 
8d4d93da:	98 0c       	CC = R0 < 0x3;
8d4d93dc:	12 10       	IF !CC JUMP 0x0x8d4d9400;
8d4d93de:	07 0c       	CC = R7 == 0x0;
8d4d93e0:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4d93e2:	08 18       	IF CC JUMP 0x0x8d4d93f2;
8d4d93e4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || P1 = [P5] || NOP;
8d4d93e8:	69 91 00 00 
8d4d93ec:	49 ac       	P1 = [P1 + 0x4];
8d4d93ee:	61 00       	CALL (P1);
8d4d93f0:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4d93f2:	86 6c       	SP += 0x10;		/* ( 16) */
8d4d93f4:	b5 05       	(R7:6, P5:5) = [SP++];
8d4d93f6:	01 e8 00 00 	UNLINK;
8d4d93fa:	10 00       	RTS;
8d4d93fc:	00 00       	NOP;
8d4d93fe:	00 00       	NOP;
8d4d9400:	09 da 03 84 	P1=-2080154012;
8d4d9404:	64 5e 00 00 
8d4d9408:	f1 bc       	[SP + 0xc] = P1;
8d4d940a:	22 e1 c1 02 	R2 = 0x2c1 (X);		/*		R2=0x2c1(705) */
8d4d940e:	01 da 03 84 	R1=-2080154092;
8d4d9412:	14 5e 00 00 
8d4d9416:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d4d9418:	00 de 04 8c 	CALL.A 0x8c040574;
8d4d941c:	74 05 00 00 
8d4d9420:	df 2f       	JUMP.S 0x0x8d4d93de;
8d4d9422:	00 00       	NOP;
8d4d9424:	00 00       	NOP;
8d4d9426:	00 00       	NOP;
8d4d9428:	00 d8 29 84 	LdStAbs addr=0x84298310 control=0x0000;
8d4d942c:	10 83 00 00 
8d4d9430:	f9 63       	R1 = -0x1 (X);		/*		R1=0x0(  0) */
8d4d9432:	00 de a0 11 	CALL.A 0x11a0ad3c;
8d4d9436:	3c ad 00 00 
8d4d943a:	4f 30       	R1 = FP;
8d4d943c:	77 b2       	[SP + 0x24] = R7;
8d4d943e:	41 64       	R1 += 0x8;		/* (  8) */
8d4d9440:	00 da 29 84 	R0=-2077654248;
8d4d9444:	18 83 00 00 
8d4d9448:	ff e3 4a ec 	CALL 0x0x8d4d6cdc;
8d4d944c:	05 68       	P5 = 0x0 (X);		/*		P5=0x0(  0) */
8d4d944e:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = P5 || NOP;
8d4d9452:	f5 bc 00 00 
8d4d9456:	00 d8 29 84 	LdStAbs addr=0x84298310 control=0x0000;
8d4d945a:	10 83 00 00 
8d4d945e:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4d9460:	00 de a0 11 	CALL.A 0x11a0b040;
8d4d9464:	40 b0 00 00 
8d4d9468:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = P5 || NOP;
8d4d946c:	f5 bc 00 00 
8d4d9470:	00 d8 29 84 	LdStAbs addr=0x8429830c control=0x0000;
8d4d9474:	0c 83 00 00 
8d4d9478:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4d947a:	00 de a0 11 	CALL.A 0x11a0b040;
8d4d947e:	40 b0 00 00 
8d4d9482:	86 6c       	SP += 0x10;		/* ( 16) */
8d4d9484:	b5 05       	(R7:6, P5:5) = [SP++];
8d4d9486:	01 e8 00 00 	UNLINK;
8d4d948a:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4d948c:	10 00       	RTS;
	...
