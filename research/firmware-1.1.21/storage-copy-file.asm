
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8c03d000.bin:     file format binary


Disassembly of section .data:

8c03e0e4 <.data+0x10e4>:
8c03e0e4:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c03e0e8:	60 05       	[--SP] = (R7:4);
8c03e0ea:	02 0c       	CC = R2 == 0x0;
8c03e0ec:	28 30       	R5 = R0;
8c03e0ee:	30 30       	R6 = R0;
8c03e0f0:	39 30       	R7 = R1;
8c03e0f2:	66 6f       	SP += -0x14;		/* (-20) */
8c03e0f4:	a1 18       	IF CC JUMP 0x0x8c03e236;
8c03e0f6:	06 30       	R0 = R6;
8c03e0f8:	01 da 90 11 	R1=294680268;
8c03e0fc:	cc 76 00 00 
8c03e100:	00 de ed 8f 	CALL.A 0x8fed0348;
8c03e104:	48 03 00 00 
8c03e108:	30 30       	R6 = R0;
8c03e10a:	06 0c       	CC = R6 == 0x0;
8c03e10c:	04 da 90 11 	R4=294680312;
8c03e110:	f8 76 00 00 
8c03e114:	76 18       	IF CC JUMP 0x0x8c03e200;
8c03e116:	07 30       	R0 = R7;
8c03e118:	ff e3 b4 ff 	CALL 0x0x8c03e080;
8c03e11c:	01 da 90 11 	R1=294680268;
8c03e120:	cc 76 00 00 
8c03e124:	21 64       	R1 += 0x4;		/* (  4) */
8c03e126:	07 30       	R0 = R7;
8c03e128:	00 de ed 8f 	CALL.A 0x8fed0348;
8c03e12c:	48 03 00 00 
8c03e130:	28 30       	R5 = R0;
8c03e132:	05 0c       	CC = R5 == 0x0;
8c03e134:	46 18       	IF CC JUMP 0x0x8c03e1c0;
8c03e136:	80 e1 00 80 	R0 = 0x8000 (Z);		/*		R0=0x8000(32768) */
8c03e13a:	00 de ed 8f 	CALL.A 0x8fed5158;
8c03e13e:	58 51 00 00 
8c03e142:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R6 || NOP;
8c03e146:	f6 b0 00 00 
8c03e14a:	82 e1 00 80 	R2 = 0x8000 (Z);		/*		R2=0x8000(32768) */
8c03e14e:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8c03e150:	00 de ed 8f 	CALL.A 0x8fed05bc;
8c03e154:	bc 05 00 00 
8c03e158:	10 30       	R2 = R0;
8c03e15a:	02 0c       	CC = R2 == 0x0;
8c03e15c:	18 18       	IF CC JUMP 0x0x8c03e18c;
8c03e15e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R5 || NOP;
8c03e162:	f5 b0 00 00 
8c03e166:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8c03e168:	00 de ed 8f 	CALL.A 0x8fed0780;
8c03e16c:	80 07 00 00 
8c03e170:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R6 || NOP;
8c03e174:	f6 b0 00 00 
8c03e178:	82 e1 00 80 	R2 = 0x8000 (Z);		/*		R2=0x8000(32768) */
8c03e17c:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8c03e17e:	00 de ed 8f 	CALL.A 0x8fed05bc;
8c03e182:	bc 05 00 00 
8c03e186:	00 0c       	CC = R0 == 0x0;
8c03e188:	10 30       	R2 = R0;
8c03e18a:	ea 17       	IF !CC JUMP 0x0x8c03e15e (BP);
8c03e18c:	06 30       	R0 = R6;
8c03e18e:	00 de ed 8f 	CALL.A 0x8fed00ae;
8c03e192:	ae 00 00 00 
8c03e196:	05 30       	R0 = R5;
8c03e198:	00 de ed 8f 	CALL.A 0x8fed00ae;
8c03e19c:	ae 00 00 00 
8c03e1a0:	07 30       	R0 = R7;
8c03e1a2:	00 de ed 8f 	CALL.A 0x8fed4aa4;
8c03e1a6:	a4 4a 00 00 
8c03e1aa:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03e1ac:	20 05       	(R7:4) = [SP++];
8c03e1ae:	01 e8 00 00 	UNLINK;
8c03e1b2:	08 60       	R0 = 0x1 (X);		/*		R0=0x8000(32768) */
8c03e1b4:	10 00       	RTS;
8c03e1b6:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03e1b8:	20 05       	(R7:4) = [SP++];
8c03e1ba:	01 e8 00 00 	UNLINK;
8c03e1be:	10 00       	RTS;
8c03e1c0:	06 30       	R0 = R6;
8c03e1c2:	00 de ed 8f 	CALL.A 0x8fed00ae;
8c03e1c6:	ae 00 00 00 
8c03e1ca:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c03e1ce:	fc 1e 00 00 
8c03e1d2:	98 0c       	CC = R0 < 0x3;
8c03e1d4:	00 60       	R0 = 0x0 (X);		/*		R0=0x8000(32768) */
8c03e1d6:	f0 1f       	IF CC JUMP 0x0x8c03e1b6 (BP);
8c03e1d8:	09 da 90 11 	P1=294680384;
8c03e1dc:	40 77 00 00 
8c03e1e0:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0x10] = R7 || NOP;
8c03e1e4:	37 b1 00 00 
8c03e1e8:	f1 bc       	[SP + 0xc] = P1;
8c03e1ea:	22 e1 7b 00 	R2 = 0x7b (X);		/*		R2=0x7b(123) */
8c03e1ee:	18 60       	R0 = 0x3 (X);		/*		R0=0x8000(32768) */
8c03e1f0:	00 e3 c2 11 	CALL 0x0x8c040574;
8c03e1f4:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03e1f6:	20 05       	(R7:4) = [SP++];
8c03e1f8:	01 e8 00 00 	UNLINK;
8c03e1fc:	00 60       	R0 = 0x0 (X);		/*		R0=0x8000(32768) */
8c03e1fe:	10 00       	RTS;
8c03e200:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c03e204:	fc 1e 00 00 
8c03e208:	98 0c       	CC = R0 < 0x3;
8c03e20a:	00 60       	R0 = 0x0 (X);		/*		R0=0x8000(32768) */
8c03e20c:	d5 1f       	IF CC JUMP 0x0x8c03e1b6 (BP);
8c03e20e:	09 da 90 11 	P1=294680360;
8c03e212:	28 77 00 00 
8c03e216:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0x10] = R5 || NOP;
8c03e21a:	35 b1 00 00 
8c03e21e:	f1 bc       	[SP + 0xc] = P1;
8c03e220:	22 e1 70 00 	R2 = 0x70 (X);		/*		R2=0x70(112) */
8c03e224:	18 60       	R0 = 0x3 (X);		/*		R0=0x8000(32768) */
8c03e226:	00 e3 a7 11 	CALL 0x0x8c040574;
8c03e22a:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03e22c:	20 05       	(R7:4) = [SP++];
8c03e22e:	01 e8 00 00 	UNLINK;
8c03e232:	00 60       	R0 = 0x0 (X);		/*		R0=0x8000(32768) */
8c03e234:	10 00       	RTS;
8c03e236:	07 30       	R0 = R7;
8c03e238:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8c03e23a:	03 e3 04 dc 	CALL 0x0x8c0b9a42;
8c03e23e:	38 0c       	CC = R0 == -0x1;
8c03e240:	5b 1f       	IF CC JUMP 0x0x8c03e0f6 (BP);
8c03e242:	a6 6c       	SP += 0x14;		/* ( 20) */
8c03e244:	20 05       	(R7:4) = [SP++];
8c03e246:	01 e8 00 00 	UNLINK;
8c03e24a:	00 60       	R0 = 0x0 (X);		/*		R0=0x8000(32768) */
8c03e24c:	10 00       	RTS;
	...
