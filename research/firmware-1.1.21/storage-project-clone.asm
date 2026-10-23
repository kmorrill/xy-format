
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d55b070 <.data+0x8f050>:
8d55b070:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d55b074:	ed 05       	[--SP] = (R7:5, P5:5);
8d55b076:	30 30       	R6 = R0;
8d55b078:	2e 32       	P5 = R6;
8d55b07a:	46 6f       	SP += -0x18;		/* (-24) */
8d55b07c:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d55b080:	fc 1e 00 00 
8d55b084:	98 0c       	CC = R0 < 0x3;
8d55b086:	4e 10       	IF !CC JUMP 0x0x8d55b122;
8d55b088:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
8d55b08a:	82 ce 06 ce 	R7 = ROT R6 BY 0x0 || R0 = [P5 + 0x18] || NOP;
8d55b08e:	a8 a1 00 00 
8d55b092:	05 0a       	CC = R5 <= R0 (IU);
8d55b094:	26 64       	R6 += 0x4;		/* (  4) */
8d55b096:	03 10       	IF !CC JUMP 0x0x8d55b09c;
8d55b098:	0e 32       	P1 = R6;
8d55b09a:	0e 91       	R6 = [P1];
8d55b09c:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [P5 + 0x34] || NOP;
8d55b0a0:	68 a3 00 00 
8d55b0a4:	05 0a       	CC = R5 <= R0 (IU);
8d55b0a6:	01 65       	R1 += 0x20;		/* ( 32) */
8d55b0a8:	03 10       	IF !CC JUMP 0x0x8d55b0ae;
8d55b0aa:	09 32       	P1 = R1;
8d55b0ac:	09 91       	R1 = [P1];
8d55b0ae:	06 30       	R0 = R6;
8d55b0b0:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d55b0b2:	00 de 03 8c 	CALL.A 0x8c03e0e4;
8d55b0b6:	e4 e0 00 00 
8d55b0ba:	00 0c       	CC = R0 == 0x0;
8d55b0bc:	07 10       	IF !CC JUMP 0x0x8d55b0ca;
8d55b0be:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d55b0c2:	fc 1e 00 00 
8d55b0c6:	88 0c       	CC = R0 < 0x1;
8d55b0c8:	0e 10       	IF !CC JUMP 0x0x8d55b0e4;
8d55b0ca:	45 0c       	CC = P5 == 0x0;
8d55b0cc:	07 18       	IF CC JUMP 0x0x8d55b0da;
8d55b0ce:	07 30       	R0 = R7;
8d55b0d0:	ff e3 a4 ff 	CALL 0x0x8d55b018;
8d55b0d4:	07 30       	R0 = R7;
8d55b0d6:	fb e3 87 99 	CALL 0x0x8d4ce3e4;
8d55b0da:	c6 6c       	SP += 0x18;		/* ( 24) */
8d55b0dc:	ad 05       	(R7:5, P5:5) = [SP++];
8d55b0de:	01 e8 00 00 	UNLINK;
8d55b0e2:	10 00       	RTS;
8d55b0e4:	a8 a1       	R0 = [P5 + 0x18];
8d55b0e6:	05 0a       	CC = R5 <= R0 (IU);
8d55b0e8:	4d 32       	P1 = P5;
8d55b0ea:	21 6c       	P1 += 0x4;		/* (  4) */
8d55b0ec:	02 10       	IF !CC JUMP 0x0x8d55b0f0;
8d55b0ee:	49 91       	P1 = [P1];
8d55b0f0:	68 a3       	R0 = [P5 + 0x34];
8d55b0f2:	05 0a       	CC = R5 <= R0 (IU);
8d55b0f4:	45 32       	P0 = P5;
8d55b0f6:	00 6d       	P0 += 0x20;		/* ( 32) */
8d55b0f8:	02 10       	IF !CC JUMP 0x0x8d55b0fc;
8d55b0fa:	40 91       	P0 = [P0];
8d55b0fc:	70 bd       	[SP + 0x14] = P0;
8d55b0fe:	31 bd       	[SP + 0x10] = P1;
8d55b100:	09 da 06 84 	P1=-2079941792;
8d55b104:	60 9b 00 00 
8d55b108:	f1 bc       	[SP + 0xc] = P1;
8d55b10a:	22 e1 32 01 	R2 = 0x132 (X);		/*		R2=0x132(306) */
8d55b10e:	01 da 06 84 	R1=-2079941892;
8d55b112:	fc 9a 00 00 
8d55b116:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d55b118:	00 de 04 8c 	CALL.A 0x8c040574;
8d55b11c:	74 05 00 00 
8d55b120:	d5 2f       	JUMP.S 0x0x8d55b0ca;
8d55b122:	4d 32       	P1 = P5;
8d55b124:	21 6c       	P1 += 0x4;		/* (  4) */
8d55b126:	a8 a1       	R0 = [P5 + 0x18];
8d55b128:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d55b12a:	01 0a       	CC = R1 <= R0 (IU);
8d55b12c:	02 10       	IF !CC JUMP 0x0x8d55b130;
8d55b12e:	49 91       	P1 = [P1];
8d55b130:	68 a3       	R0 = [P5 + 0x34];
8d55b132:	01 0a       	CC = R1 <= R0 (IU);
8d55b134:	45 32       	P0 = P5;
8d55b136:	00 6d       	P0 += 0x20;		/* ( 32) */
8d55b138:	02 10       	IF !CC JUMP 0x0x8d55b13c;
8d55b13a:	40 91       	P0 = [P0];
8d55b13c:	70 bd       	[SP + 0x14] = P0;
8d55b13e:	31 bd       	[SP + 0x10] = P1;
8d55b140:	09 da 06 84 	P1=-2079941808;
8d55b144:	50 9b 00 00 
8d55b148:	f1 bc       	[SP + 0xc] = P1;
8d55b14a:	22 e1 30 01 	R2 = 0x130 (X);		/*		R2=0x130(304) */
8d55b14e:	01 da 06 84 	R1=-2079941892;
8d55b152:	fc 9a 00 00 
8d55b156:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d55b158:	00 de 04 8c 	CALL.A 0x8c040574;
8d55b15c:	74 05 00 00 
8d55b160:	94 2f       	JUMP.S 0x0x8d55b088;
	...
