
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8c03d000.bin:     file format binary


Disassembly of section .data:

8c03e040 <.data+0x1040>:
8c03e040:	00 e8 03 00 	LINK 0xc;		/* (12) */
8c03e044:	03 e3 d9 db 	CALL 0x0x8c0b97f6;
8c03e048:	01 e8 00 00 	UNLINK;
8c03e04c:	10 00       	RTS;
8c03e04e:	00 00       	NOP;
8c03e050:	00 e8 10 00 	LINK 0x40;		/* (64) */
8c03e054:	4f 30       	R1 = FP;
8c03e056:	61 66       	R1 += -0x34;		/* (-52) */
8c03e058:	03 e3 75 dc 	CALL 0x0x8c0b9942;
8c03e05c:	b1 a2       	R1 = [SP + 0x28];
8c03e05e:	01 e8 00 00 	UNLINK;
8c03e062:	00 0c       	CC = R0 == 0x0;
8c03e064:	f8 63       	R0 = -0x1 (X);		/*		R0=0x0(  0) */
8c03e066:	01 07       	IF CC R0 = R1;
8c03e068:	10 00       	RTS;
8c03e06a:	00 00       	NOP;
8c03e06c:	00 e8 03 00 	LINK 0xc;		/* (12) */
8c03e070:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8c03e072:	03 e3 6d db 	CALL 0x0x8c0b974c;
8c03e076:	01 e8 00 00 	UNLINK;
8c03e07a:	38 0d       	CC = R0 <= -0x1;
8c03e07c:	10 02       	ILLEGAL;
8c03e07e:	10 00       	RTS;
8c03e080:	00 e8 48 00 	LINK 0x120;		/* (288) */
8c03e084:	e4 05       	[--SP] = (R7:4, P5:4);
8c03e086:	30 30       	R6 = R0;
8c03e088:	a6 6f       	SP += -0xc;		/* (-12) */
8c03e08a:	08 64       	R0 += 0x1;		/* (  1) */
8c03e08c:	79 61       	R1 = 0x2f (X);		/*		R1=0x0(  0) */
8c03e08e:	00 de 02 04 	CALL.A 0x0402319c;
8c03e092:	9c 31 00 00 
8c03e096:	00 0c       	CC = R0 == 0x0;
8c03e098:	21 18       	IF CC JUMP 0x0x8c03e0da;
8c03e09a:	21 69       	P1 = 0x24 (X);		/*		P1=0x0(  0) */
8c03e09c:	38 30       	R7 = R0;
8c03e09e:	0e 5b       	P4 = SP + P1;
8c03e0a0:	25 61       	R5 = 0x24 (X);		/*		R5=0x0(  0) */
8c03e0a2:	b7 52       	R2 = R7 - R6;
8c03e0a4:	2a 32       	P5 = R2;
8c03e0a6:	4e 30       	R1 = SP;
8c03e0a8:	29 51       	R4 = R1 + R5;
8c03e0aa:	0e 30       	R1 = R6;
8c03e0ac:	04 30       	R0 = R4;
8c03e0ae:	00 de 02 04 	CALL.A 0x040232e4;
8c03e0b2:	e4 32 00 00 
8c03e0b6:	6c 5a       	P1 = P4 + P5;
8c03e0b8:	03 60       	R3 = 0x0 (X);		/*		R3=0x0(  0) */
8c03e0ba:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || B[P1] = R3 || NOP;
8c03e0be:	0b 9b 00 00 
8c03e0c2:	ff e3 d5 ff 	CALL 0x0x8c03e06c;
8c03e0c6:	07 30       	R0 = R7;
8c03e0c8:	08 64       	R0 += 0x1;		/* (  1) */
8c03e0ca:	79 61       	R1 = 0x2f (X);		/*		R1=0x0(  0) */
8c03e0cc:	00 de 02 04 	CALL.A 0x0402319c;
8c03e0d0:	9c 31 00 00 
8c03e0d4:	00 0c       	CC = R0 == 0x0;
8c03e0d6:	38 30       	R7 = R0;
8c03e0d8:	e5 17       	IF !CC JUMP 0x0x8c03e0a2 (BP);
8c03e0da:	66 6c       	SP += 0xc;		/* ( 12) */
8c03e0dc:	a4 05       	(R7:4, P5:4) = [SP++];
8c03e0de:	01 e8 00 00 	UNLINK;
8c03e0e2:	10 00       	RTS;
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
8c03e24e:	00 00       	NOP;
8c03e250:	00 e8 03 00 	LINK 0xc;		/* (12) */
8c03e254:	00 de ed 8f 	CALL.A 0x8fed0908;
8c03e258:	08 09 00 00 
8c03e25c:	01 e8 00 00 	UNLINK;
8c03e260:	00 0c       	CC = R0 == 0x0;
8c03e262:	00 02       	R0 = CC;
8c03e264:	10 00       	RTS;
8c03e266:	00 00       	NOP;
8c03e268:	00 e8 06 00 	LINK 0x18;		/* (24) */
8c03e26c:	09 68       	P1 = 0x1 (X);		/*		P1=0x0(  0) */
8c03e26e:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0x14] = R7 || NOP;
8c03e272:	77 b1 00 00 
8c03e276:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0x10] = P1 || NOP;
8c03e27a:	31 bd 00 00 
8c03e27e:	f1 bc       	[SP + 0xc] = P1;
8c03e280:	01 da 03 8c 	R1=-1945902416;
8c03e284:	b0 e2 00 00 
8c03e288:	00 e3 fa 00 	CALL 0x0x8c03e47c;
8c03e28c:	07 30       	R0 = R7;
8c03e28e:	03 e3 07 db 	CALL 0x0x8c0b989c;
8c03e292:	77 a1       	R7 = [SP + 0x14];
8c03e294:	01 e8 00 00 	UNLINK;
8c03e298:	10 00       	RTS;
8c03e29a:	00 00       	NOP;
8c03e29c:	00 e8 03 00 	LINK 0xc;		/* (12) */
8c03e2a0:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8c03e2a2:	03 e3 d0 db 	CALL 0x0x8c0b9a42;
8c03e2a6:	01 e8 00 00 	UNLINK;
8c03e2aa:	38 0c       	CC = R0 == -0x1;
8c03e2ac:	10 02       	ILLEGAL;
8c03e2ae:	10 00       	RTS;
8c03e2b0:	00 e8 04 00 	LINK 0x10;		/* (16) */
8c03e2b4:	01 0c       	CC = R1 == 0x0;
8c03e2b6:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8c03e2ba:	f7 b0 00 00 
8c03e2be:	13 10       	IF !CC JUMP 0x0x8c03e2e4;
8c03e2c0:	03 e3 ee da 	CALL 0x0x8c0b989c;
8c03e2c4:	07 30       	R0 = R7;
8c03e2c6:	ff e3 eb ff 	CALL 0x0x8c03e29c;
8c03e2ca:	00 0c       	CC = R0 == 0x0;
8c03e2cc:	05 10       	IF !CC JUMP 0x0x8c03e2d6;
8c03e2ce:	f7 a0       	R7 = [SP + 0xc];
8c03e2d0:	01 e8 00 00 	UNLINK;
8c03e2d4:	10 00       	RTS;
8c03e2d6:	07 30       	R0 = R7;
8c03e2d8:	03 e3 8f da 	CALL 0x0x8c0b97f6;
8c03e2dc:	f7 a0       	R7 = [SP + 0xc];
8c03e2de:	01 e8 00 00 	UNLINK;
8c03e2e2:	10 00       	RTS;
8c03e2e4:	03 e3 89 da 	CALL 0x0x8c0b97f6;
8c03e2e8:	f7 a0       	R7 = [SP + 0xc];
8c03e2ea:	01 e8 00 00 	UNLINK;
8c03e2ee:	10 00       	RTS;
8c03e2f0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c03e2f4:	70 05       	[--SP] = (R7:6);
8c03e2f6:	39 30       	R7 = R1;
8c03e2f8:	30 30       	R6 = R0;
8c03e2fa:	a6 6f       	SP += -0xc;		/* (-12) */
8c03e2fc:	07 30       	R0 = R7;
8c03e2fe:	ff e3 cf ff 	CALL 0x0x8c03e29c;
8c03e302:	00 0c       	CC = R0 == 0x0;
8c03e304:	0e 10       	IF !CC JUMP 0x0x8c03e320;
8c03e306:	0f 30       	R1 = R7;
8c03e308:	06 30       	R0 = R6;
8c03e30a:	00 de ed 8f 	CALL.A 0x8fed0908;
8c03e30e:	08 09 00 00 
8c03e312:	66 6c       	SP += 0xc;		/* ( 12) */
8c03e314:	30 05       	(R7:6) = [SP++];
8c03e316:	01 e8 00 00 	UNLINK;
8c03e31a:	00 0c       	CC = R0 == 0x0;
8c03e31c:	00 02       	R0 = CC;
8c03e31e:	10 00       	RTS;
8c03e320:	07 30       	R0 = R7;
8c03e322:	ff e3 8f fe 	CALL 0x0x8c03e040;
8c03e326:	f0 2f       	JUMP.S 0x0x8c03e306;
8c03e328:	00 e8 03 00 	LINK 0xc;		/* (12) */
8c03e32c:	03 e3 d7 e1 	CALL 0x0x8c0ba6da;
8c03e330:	00 0c       	CC = R0 == 0x0;
8c03e332:	04 18       	IF CC JUMP 0x0x8c03e33a;
8c03e334:	03 e3 07 e3 	CALL 0x0x8c0ba942;
8c03e338:	08 60       	R0 = 0x1 (X);		/*		R0=0x8000(32768) */
8c03e33a:	01 e8 00 00 	UNLINK;
8c03e33e:	10 00       	RTS;
