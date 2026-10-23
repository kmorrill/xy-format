
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d57e306 <.data+0xb22e6>:
8d57e306:	09 da 0b 86 	P1=-2046053592;
8d57e30a:	28 b3 00 00 
8d57e30e:	48 99       	R0 = B[P1] (X);
8d57e310:	00 0c       	CC = R0 == 0x0;
8d57e312:	43 18       	IF CC JUMP 0x0x8d57e398;
8d57e314:	09 da 09 84 	P1=-2079740428;
8d57e318:	f4 ad 00 00 
8d57e31c:	08 99       	R0 = B[P1] (Z);
8d57e31e:	00 0c       	CC = R0 == 0x0;
8d57e320:	0c 10       	IF !CC JUMP 0x0x8d57e338;
8d57e322:	00 da 0c 86 	R0=-2046028816;
8d57e326:	f0 13 00 00 
8d57e32a:	01 e3 2b 53 	CALL 0x0x8d5a8980;
8d57e32e:	86 6c       	SP += 0x10;		/* ( 16) */
8d57e330:	b5 05       	(R7:6, P5:5) = [SP++];
8d57e332:	01 e8 00 00 	UNLINK;
8d57e336:	10 00       	RTS;
8d57e338:	09 da 0c 86 	P1=-2046028816;
8d57e33c:	f0 13 00 00 
8d57e340:	08 90       	R0 = [P1++];
8d57e342:	09 91       	R1 = [P1];
8d57e344:	01 e3 96 52 	CALL 0x0x8d5a8870;
8d57e348:	22 e1 e8 03 	R2 = 0x3e8 (X);		/*		R2=0x3e8(1000) */
8d57e34c:	82 09       	CC = R2 < R0 (IU);
8d57e34e:	86 03       	AQ = CC;
8d57e350:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d57e352:	0f 08       	CC = R7 == R1;
8d57e354:	c6 03       	AQ &= CC;
8d57e356:	8f 09       	CC = R7 < R1 (IU);
8d57e358:	26 03       	CC |= AQ;
8d57e35a:	ea 17       	IF !CC JUMP 0x0x8d57e32e (BP);
8d57e35c:	00 da 0a 84 	R0=-2079711604;
8d57e360:	8c 1e 00 00 
8d57e364:	fa e3 0c d8 	CALL 0x0x8d4d937c;
8d57e368:	00 0c       	CC = R0 == 0x0;
8d57e36a:	0b 18       	IF CC JUMP 0x0x8d57e380;
8d57e36c:	00 d8 09 84 	LdStAbs addr=0x8409adf4 control=0x0a07;
8d57e370:	f4 ad 07 0a 
8d57e374:	86 6c       	SP += 0x10;		/* ( 16) */
8d57e376:	b5 05       	(R7:6, P5:5) = [SP++];
8d57e378:	01 e8 00 00 	UNLINK;
8d57e37c:	10 00       	RTS;
8d57e37e:	00 00       	NOP;
8d57e380:	00 da 0c 86 	R0=-2046028816;
8d57e384:	f0 13 00 00 
8d57e388:	01 e3 fc 52 	CALL 0x0x8d5a8980;
8d57e38c:	86 6c       	SP += 0x10;		/* ( 16) */
8d57e38e:	b5 05       	(R7:6, P5:5) = [SP++];
8d57e390:	01 e8 00 00 	UNLINK;
8d57e394:	10 00       	RTS;
	...
