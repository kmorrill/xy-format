
os.ldr@0x8d4e1240:     file format binary


Disassembly of section .data:

8d4e1240 <.data>:
8d4e1240:	00 00       	NOP;
8d4e1242:	00 de 02 04 	CALL.A 0x04023068;
8d4e1246:	68 30 00 00 
8d4e124a:	00 0c       	CC = R0 == 0x0;
8d4e124c:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8d4e124e:	0c 10       	IF !CC JUMP 0x0x8d4e1266;
8d4e1250:	8f 09       	CC = R7 < R1 (IU);
8d4e1252:	f8 63       	R0 = -0x1 (X);		/*		R0=0x0(  0) */
8d4e1254:	03 18       	IF CC JUMP 0x0x8d4e125a;
8d4e1256:	39 08       	CC = R1 == R7;
8d4e1258:	10 02       	ILLEGAL;
8d4e125a:	f7 a0       	R7 = [SP + 0xc];
8d4e125c:	01 e8 00 00 	UNLINK;
8d4e1260:	00 0c       	CC = R0 == 0x0;
8d4e1262:	00 02       	R0 = CC;
8d4e1264:	10 00       	RTS;
8d4e1266:	f7 a0       	R7 = [SP + 0xc];
8d4e1268:	01 e8 00 00 	UNLINK;
8d4e126c:	00 0c       	CC = R0 == 0x0;
8d4e126e:	00 02       	R0 = CC;
8d4e1270:	10 00       	RTS;
8d4e1272:	00 00       	NOP;
8d4e1274:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e1278:	ec 05       	[--SP] = (R7:5, P5:4);
8d4e127a:	38 30       	R7 = R0;
8d4e127c:	2f 32       	P5 = R7;
8d4e127e:	86 6f       	SP += -0x10;		/* (-16) */
8d4e1280:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4e1282:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d4e1284:	31 30       	R6 = R1;
8d4e1286:	6a b1       	[P5 + 0x14] = R2;
8d4e1288:	aa e6 04 00 	B[P5 + 0x4] = R2;
8d4e128c:	ab b1       	[P5 + 0x18] = R3;
8d4e128e:	26 32       	P4 = R6;
8d4e1290:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e1294:	b8 00 03 00 
8d4e1298:	f3 b0       	[SP + 0xc] = R3;
8d4e129a:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e129e:	70 e9 00 00 
8d4e12a2:	e5 60       	R5 = 0x1c (X);		/*		R5=0x0(  0) */
8d4e12a4:	2f 50       	R0 = R7 + R5;
8d4e12a6:	6e 50       	R1 = R6 + R5;
8d4e12a8:	ff e3 cc d5 	CALL 0x0x8d4dbe40;
8d4e12ac:	a0 e4 2c 00 	R0 = B[P4 + 0x2c] (Z);
8d4e12b0:	a8 e6 2c 00 	B[P5 + 0x2c] = R0;
8d4e12b4:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e12b6:	ac 05       	(R7:5, P5:4) = [SP++];
8d4e12b8:	01 e8 00 00 	UNLINK;
8d4e12bc:	10 00       	RTS;
8d4e12be:	08 32       	P1 = R0;
8d4e12c0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e12c4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e12c6:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8d4e12c8:	89 b1       	[P1 + 0x18] = R1;
8d4e12ca:	49 b3       	[P1 + 0x34] = R1;
8d4e12cc:	09 e6 14 00 	[P1 + 0x50] = R1;
8d4e12d0:	48 b1       	[P1 + 0x14] = R0;
8d4e12d2:	88 e6 04 00 	B[P1 + 0x4] = R0;
8d4e12d6:	08 b3       	[P1 + 0x30] = R0;
8d4e12d8:	88 e6 20 00 	B[P1 + 0x20] = R0;
8d4e12dc:	08 e6 13 00 	[P1 + 0x4c] = R0;
8d4e12e0:	88 e6 3c 00 	B[P1 + 0x3c] = R0;
8d4e12e4:	01 e8 00 00 	UNLINK;
8d4e12e8:	10 00       	RTS;
8d4e12ea:	00 00       	NOP;
8d4e12ec:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e12f0:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e12f2:	28 32       	P5 = R0;
8d4e12f4:	86 6f       	SP += -0x10;		/* (-16) */
8d4e12f6:	05 60       	R5 = 0x0 (X);		/*		R5=0x0(  0) */
8d4e12f8:	7c 60       	R4 = 0xf (X);		/*		R4=0x0(  0) */
8d4e12fa:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4e12fc:	82 ce 01 cc 	R6 = ROT R1 BY 0x0 || [P5 + 0x18] = R4 || NOP;
8d4e1300:	ac b1 00 00 
8d4e1304:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [P5 + 0x14] = R5 || NOP;
8d4e1308:	6d b1 00 00 
8d4e130c:	ad e6 04 00 	B[P5 + 0x4] = R5;
8d4e1310:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e1314:	b8 00 03 00 
8d4e1318:	f3 b0       	[SP + 0xc] = R3;
8d4e131a:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e131e:	70 e9 00 00 
8d4e1322:	ad e6 20 00 	B[P5 + 0x20] = R5;
8d4e1326:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P5 + 0x34] = R4 || NOP;
8d4e132a:	6c b3 00 00 
8d4e132e:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [P5 + 0x30] = R5 || NOP;
8d4e1332:	2d b3 00 00 
8d4e1336:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e133a:	b8 00 03 00 
8d4e133e:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e1342:	f3 b0 00 00 
8d4e1346:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e1348:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4e134a:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e134e:	70 e9 00 00 
8d4e1352:	2c e6 14 00 	[P5 + 0x50] = R4;
8d4e1356:	2d e6 13 00 	[P5 + 0x4c] = R5;
8d4e135a:	ad e6 3c 00 	B[P5 + 0x3c] = R5;
8d4e135e:	0e 30       	R1 = R6;
8d4e1360:	07 30       	R0 = R7;
8d4e1362:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e1366:	b8 00 03 00 
8d4e136a:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e136e:	f3 b0 00 00 
8d4e1372:	c1 65       	R1 += 0x38;		/* ( 56) */
8d4e1374:	c0 65       	R0 += 0x38;		/* ( 56) */
8d4e1376:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e137a:	70 e9 00 00 
8d4e137e:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e1380:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e1382:	01 e8 00 00 	UNLINK;
8d4e1386:	10 00       	RTS;
8d4e1388:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e138c:	ed 05       	[--SP] = (R7:5, P5:5);
8d4e138e:	28 32       	P5 = R0;
8d4e1390:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e1392:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
8d4e1394:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8d4e1396:	06 60       	R6 = 0x0 (X);		/*		R6=0x0(  0) */
8d4e1398:	28 e4 14 00 	R0 = [P5 + 0x50];
8d4e139c:	05 0a       	CC = R5 <= R0 (IU);
8d4e139e:	2c 18       	IF CC JUMP 0x0x8d4e13f6;
8d4e13a0:	2f e6 14 00 	[P5 + 0x50] = R7;
8d4e13a4:	68 a3       	R0 = [P5 + 0x34];
8d4e13a6:	05 0a       	CC = R5 <= R0 (IU);
8d4e13a8:	2e e6 13 00 	[P5 + 0x4c] = R6;
8d4e13ac:	ae e6 3c 00 	B[P5 + 0x3c] = R6;
8d4e13b0:	1f 18       	IF CC JUMP 0x0x8d4e13ee;
8d4e13b2:	2e b3       	[P5 + 0x30] = R6;
8d4e13b4:	ae e6 20 00 	B[P5 + 0x20] = R6;
8d4e13b8:	03 c8 00 18 	MNOP || R0 = [P5 + 0x18] || [P5 + 0x34] = R7;
8d4e13bc:	a8 a1 6f b3 
8d4e13c0:	05 0a       	CC = R5 <= R0 (IU);
8d4e13c2:	0a 18       	IF CC JUMP 0x0x8d4e13d6;
8d4e13c4:	af b1       	[P5 + 0x18] = R7;
8d4e13c6:	6e b1       	[P5 + 0x14] = R6;
8d4e13c8:	ae e6 04 00 	B[P5 + 0x4] = R6;
8d4e13cc:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e13ce:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e13d0:	01 e8 00 00 	UNLINK;
8d4e13d4:	10 00       	RTS;
8d4e13d6:	68 a0       	R0 = [P5 + 0x4];
8d4e13d8:	ff e3 06 68 	CALL 0x0x8d4ce3e4;
8d4e13dc:	af b1       	[P5 + 0x18] = R7;
8d4e13de:	6e b1       	[P5 + 0x14] = R6;
8d4e13e0:	ae e6 04 00 	B[P5 + 0x4] = R6;
8d4e13e4:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e13e6:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e13e8:	01 e8 00 00 	UNLINK;
8d4e13ec:	10 00       	RTS;
8d4e13ee:	28 a2       	R0 = [P5 + 0x20];
8d4e13f0:	ff e3 fa 67 	CALL 0x0x8d4ce3e4;
8d4e13f4:	df 2f       	JUMP.S 0x0x8d4e13b2;
8d4e13f6:	e8 a3       	R0 = [P5 + 0x3c];
8d4e13f8:	ff e3 f6 67 	CALL 0x0x8d4ce3e4;
8d4e13fc:	d2 2f       	JUMP.S 0x0x8d4e13a0;
8d4e13fe:	08 32       	P1 = R0;
8d4e1400:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e1404:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e1406:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8d4e1408:	08 92       	[P1++] = R0;
8d4e140a:	c9 b1       	[P1 + 0x1c] = R1;
8d4e140c:	08 9b       	B[P1] = R0;
8d4e140e:	88 b1       	[P1 + 0x18] = R0;
8d4e1410:	88 e6 08 00 	B[P1 + 0x8] = R0;
8d4e1414:	01 e8 00 00 	UNLINK;
8d4e1418:	10 00       	RTS;
8d4e141a:	00 00       	NOP;
8d4e141c:	00 00       	NOP;
8d4e141e:	00 00       	NOP;
8d4e1420:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e1424:	f5 05       	[--SP] = (R7:6, P5:5);
8d4e1426:	28 32       	P5 = R0;
8d4e1428:	86 6f       	SP += -0x10;		/* (-16) */
8d4e142a:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R6 = [SP + 0x30] || NOP;
8d4e142e:	36 a3 00 00 
8d4e1432:	01 0c       	CC = R1 == 0x0;
8d4e1434:	00 da 03 84 	R0=-2080151640;
8d4e1438:	a8 67 00 00 
8d4e143c:	29 93       	[P5] = R1;
8d4e143e:	ae b0       	[P5 + 0x8] = R6;
8d4e1440:	ef b0       	[P5 + 0xc] = R7;
8d4e1442:	6f b1       	[P5 + 0x14] = R7;
8d4e1444:	af b1       	[P5 + 0x18] = R7;
8d4e1446:	af e6 1c 00 	B[P5 + 0x1c] = R7;
8d4e144a:	6a b0       	[P5 + 0x4] = R2;
8d4e144c:	2a b1       	[P5 + 0x10] = R2;
8d4e144e:	4f 18       	IF CC JUMP 0x0x8d4e14ec;
8d4e1450:	a6 0d       	CC = R6 < 0x4 (IU);
8d4e1452:	43 18       	IF CC JUMP 0x0x8d4e14d8;
8d4e1454:	03 c8 00 18 	MNOP || R0 = [P5 + 0x10] || R1 = [P5 + 0xc];
8d4e1458:	28 a1 e9 a0 
8d4e145c:	88 09       	CC = R0 < R1 (IU);
8d4e145e:	09 10       	IF !CC JUMP 0x0x8d4e1470;
8d4e1460:	08 64       	R0 += 0x1;		/* (  1) */
8d4e1462:	28 b1       	[P5 + 0x10] = R0;
8d4e1464:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e1466:	b5 05       	(R7:6, P5:5) = [SP++];
8d4e1468:	01 e8 00 00 	UNLINK;
8d4e146c:	10 00       	RTS;
8d4e146e:	00 00       	NOP;
8d4e1470:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e1474:	00 0c       	CC = R0 == 0x0;
8d4e1476:	f7 17       	IF !CC JUMP 0x0x8d4e1464 (BP);
8d4e1478:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d4e147a:	0e 60       	R6 = 0x1 (X);		/*		R6=0x0(  0) */
8d4e147c:	03 c8 00 18 	MNOP || R0 = [P5 + 0x14] || R2 = [P5 + 0x18];
8d4e1480:	68 a1 aa a1 
8d4e1484:	04 cc 02 04 	R2 = R0 + R2 (NS) || R3 = [P5] || R0 = [P5 + 0x4];
8d4e1488:	2b 91 68 a0 
8d4e148c:	f3 b0       	[SP + 0xc] = R3;
8d4e148e:	03 c8 00 18 	MNOP || [P5 + 0x18] = R2 || R2 = [P5 + 0x8];
8d4e1492:	aa b1 aa a0 
8d4e1496:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e149a:	bc 05 00 00 
8d4e149e:	03 c8 00 18 	MNOP || R1 = [P5 + 0x4] || R2 = [P5 + 0x8];
8d4e14a2:	69 a0 aa a0 
8d4e14a6:	04 cc 08 02 	R1 = R1 + R0 (NS) || [P5 + 0x10] = R1 || NOP;
8d4e14aa:	29 b1 00 00 
8d4e14ae:	90 09       	CC = R0 < R2 (IU);
8d4e14b0:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || [P5 + 0x14] = R0 || NOP;
8d4e14b4:	68 b1 00 00 
8d4e14b8:	f9 67       	R1 += -0x1;		/* ( -1) */
8d4e14ba:	08 32       	P1 = R0;
8d4e14bc:	e9 b0       	[P5 + 0xc] = R1;
8d4e14be:	d3 13       	IF !CC JUMP 0x0x8d4e1464;
8d4e14c0:	0f 9b       	B[P1] = R7;
8d4e14c2:	e8 a0       	R0 = [P5 + 0xc];
8d4e14c4:	08 64       	R0 += 0x1;		/* (  1) */
8d4e14c6:	ae e6 1c 00 	B[P5 + 0x1c] = R6;
8d4e14ca:	e8 b0       	[P5 + 0xc] = R0;
8d4e14cc:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e14ce:	b5 05       	(R7:6, P5:5) = [SP++];
8d4e14d0:	01 e8 00 00 	UNLINK;
8d4e14d4:	10 00       	RTS;
8d4e14d6:	00 00       	NOP;
8d4e14d8:	00 da 03 84 	R0=-2080151568;
8d4e14dc:	f0 67 00 00 
8d4e14e0:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e14e4:	d4 34 00 00 
8d4e14e8:	b6 2f       	JUMP.S 0x0x8d4e1454;
8d4e14ea:	00 00       	NOP;
8d4e14ec:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e14f0:	d4 34 00 00 
8d4e14f4:	ae 2f       	JUMP.S 0x0x8d4e1450;
8d4e14f6:	00 00       	NOP;
8d4e14f8:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e14fc:	e4 05       	[--SP] = (R7:4, P5:4);
8d4e14fe:	29 32       	P5 = R1;
8d4e1500:	86 6f       	SP += -0x10;		/* (-16) */
8d4e1502:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [SP + 0x30] = R2 || NOP;
8d4e1506:	32 b3 00 00 
8d4e150a:	20 32       	P4 = R0;
8d4e150c:	26 60       	R6 = 0x4 (X);		/*		R6=0x0(  0) */
8d4e150e:	25 e1 41 00 	R5 = 0x41 (X);		/*		R5=0x41( 65) */
8d4e1512:	84 61       	R4 = 0x30 (X);		/*		R4=0x0(  0) */
8d4e1514:	82 ce 27 80 	R0 = R7 << 0x4 || P1 = [P5 + 0x10] || NOP;
8d4e1518:	29 ad 00 00 
8d4e151c:	49 99       	R1 = B[P1] (X);
8d4e151e:	0c 09       	CC = R4 <= R1;
8d4e1520:	c1 51       	R7 = R1 + R0;
8d4e1522:	47 10       	IF !CC JUMP 0x0x8d4e15b0;
8d4e1524:	c8 61       	R0 = 0x39 (X);		/*		R0=0x0(  0) */
8d4e1526:	01 09       	CC = R1 <= R0;
8d4e1528:	44 10       	IF !CC JUMP 0x0x8d4e15b0;
8d4e152a:	87 66       	R7 += -0x30;		/* (-48) */
8d4e152c:	e9 a0       	R1 = [P5 + 0xc];
8d4e152e:	41 30       	R0 = P1;
8d4e1530:	88 09       	CC = R0 < R1 (IU);
8d4e1532:	0d 10       	IF !CC JUMP 0x0x8d4e154c;
8d4e1534:	09 6c       	P1 += 0x1;		/* (  1) */
8d4e1536:	29 bd       	[P5 + 0x10] = P1;
8d4e1538:	fe 67       	R6 += -0x1;		/* ( -1) */
8d4e153a:	06 0c       	CC = R6 == 0x0;
8d4e153c:	ec 17       	IF !CC JUMP 0x0x8d4e1514 (BP);
8d4e153e:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e1540:	07 30       	R0 = R7;
8d4e1542:	a4 05       	(R7:4, P5:4) = [SP++];
8d4e1544:	01 e8 00 00 	UNLINK;
8d4e1548:	10 00       	RTS;
8d4e154a:	00 00       	NOP;
8d4e154c:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e1550:	00 0c       	CC = R0 == 0x0;
8d4e1552:	f3 17       	IF !CC JUMP 0x0x8d4e1538 (BP);
8d4e1554:	03 c8 00 18 	MNOP || R2 = [P5 + 0x14] || R3 = [P5 + 0x18];
8d4e1558:	6a a1 ab a1 
8d4e155c:	04 cc 13 04 	R2 = R2 + R3 (NS) || R3 = [P5] || R0 = [P5 + 0x4];
8d4e1560:	2b 91 68 a0 
8d4e1564:	03 c8 00 18 	MNOP || [P5 + 0x18] = R2 || R2 = [P5 + 0x8];
8d4e1568:	aa b1 aa a0 
8d4e156c:	f3 b0       	[SP + 0xc] = R3;
8d4e156e:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d4e1570:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1574:	bc 05 00 00 
8d4e1578:	03 c8 00 18 	MNOP || R3 = [P5 + 0x4] || R1 = [P5 + 0x8];
8d4e157c:	6b a0 a9 a0 
8d4e1580:	04 cc 18 04 	R2 = R3 + R0 (NS) || [P5 + 0x14] = R0 || NOP;
8d4e1584:	68 b1 00 00 
8d4e1588:	88 09       	CC = R0 < R1 (IU);
8d4e158a:	82 ce 02 c2 	R1 = ROT R2 BY 0x0 || [P5 + 0x10] = R3 || NOP;
8d4e158e:	2b b1 00 00 
8d4e1592:	fa 67       	R2 += -0x1;		/* ( -1) */
8d4e1594:	09 32       	P1 = R1;
8d4e1596:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0xc] = R2 || NOP;
8d4e159a:	ea b0 00 00 
8d4e159e:	cd 13       	IF !CC JUMP 0x0x8d4e1538;
8d4e15a0:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e15a2:	08 9b       	B[P1] = R0;
8d4e15a4:	e8 a0       	R0 = [P5 + 0xc];
8d4e15a6:	08 64       	R0 += 0x1;		/* (  1) */
8d4e15a8:	aa e6 1c 00 	B[P5 + 0x1c] = R2;
8d4e15ac:	e8 b0       	[P5 + 0xc] = R0;
8d4e15ae:	c5 2f       	JUMP.S 0x0x8d4e1538;
8d4e15b0:	0d 09       	CC = R5 <= R1;
8d4e15b2:	07 10       	IF !CC JUMP 0x0x8d4e15c0;
8d4e15b4:	20 e1 46 00 	R0 = 0x46 (X);		/*		R0=0x46( 70) */
8d4e15b8:	01 09       	CC = R1 <= R0;
8d4e15ba:	03 10       	IF !CC JUMP 0x0x8d4e15c0;
8d4e15bc:	4f 66       	R7 += -0x37;		/* (-55) */
8d4e15be:	b7 2f       	JUMP.S 0x0x8d4e152c;
8d4e15c0:	20 e1 61 00 	R0 = 0x61 (X);		/*		R0=0x61( 97) */
8d4e15c4:	08 09       	CC = R0 <= R1;
8d4e15c6:	09 10       	IF !CC JUMP 0x0x8d4e15d8;
8d4e15c8:	20 e1 66 00 	R0 = 0x66 (X);		/*		R0=0x66(102) */
8d4e15cc:	01 09       	CC = R1 <= R0;
8d4e15ce:	05 10       	IF !CC JUMP 0x0x8d4e15d8;
8d4e15d0:	20 e1 a9 ff 	R0 = -0x57 (X);		/*		R0=0xffffffa9(-87) */
8d4e15d4:	c7 51       	R7 = R7 + R0;
8d4e15d6:	ab 2f       	JUMP.S 0x0x8d4e152c;
8d4e15d8:	03 c8 00 18 	MNOP || R0 = [P4 + 0x18] || R2 = [SP + 0x30];
8d4e15dc:	a0 a1 32 a3 
8d4e15e0:	00 0c       	CC = R0 == 0x0;
8d4e15e2:	0b 10       	IF !CC JUMP 0x0x8d4e15f8;
8d4e15e4:	00 60       	R0 = 0x0 (X);		/*		R0=0xffffffa9(-87) */
8d4e15e6:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8d4e15e8:	e2 b1       	[P4 + 0x1c] = R2;
8d4e15ea:	a1 b1       	[P4 + 0x18] = R1;
8d4e15ec:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e15ee:	a4 05       	(R7:4, P5:4) = [SP++];
8d4e15f0:	01 e8 00 00 	UNLINK;
8d4e15f4:	10 00       	RTS;
8d4e15f6:	00 00       	NOP;
8d4e15f8:	00 da 03 84 	R0=-2080151480;
8d4e15fc:	48 68 00 00 
8d4e1600:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1604:	d4 34 00 00 
8d4e1608:	04 cc 00 40 	R0 = R0 - R0 (NS) || R2 = [SP + 0x30] || NOP;
8d4e160c:	32 a3 00 00 
8d4e1610:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8d4e1612:	e2 b1       	[P4 + 0x1c] = R2;
8d4e1614:	a1 b1       	[P4 + 0x18] = R1;
8d4e1616:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e1618:	a4 05       	(R7:4, P5:4) = [SP++];
8d4e161a:	01 e8 00 00 	UNLINK;
8d4e161e:	10 00       	RTS;
8d4e1620:	00 00       	NOP;
8d4e1622:	08 32       	P1 = R0;
8d4e1624:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e1628:	fd 05       	[--SP] = (R7:7, P5:5);
8d4e162a:	86 6f       	SP += -0x10;		/* (-16) */
8d4e162c:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8d4e162e:	4d 91       	P5 = [P1];
8d4e1630:	29 ad       	P1 = [P5 + 0x10];
8d4e1632:	48 99       	R0 = B[P1] (X);
8d4e1634:	01 08       	CC = R1 == R0;
8d4e1636:	43 10       	IF !CC JUMP 0x0x8d4e16bc;
8d4e1638:	e9 a0       	R1 = [P5 + 0xc];
8d4e163a:	41 30       	R0 = P1;
8d4e163c:	88 09       	CC = R0 < R1 (IU);
8d4e163e:	09 10       	IF !CC JUMP 0x0x8d4e1650;
8d4e1640:	09 6c       	P1 += 0x1;		/* (  1) */
8d4e1642:	29 bd       	[P5 + 0x10] = P1;
8d4e1644:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e1646:	bd 05       	(R7:7, P5:5) = [SP++];
8d4e1648:	01 e8 00 00 	UNLINK;
8d4e164c:	08 60       	R0 = 0x1 (X);		/*		R0=0xffffffa9(-87) */
8d4e164e:	10 00       	RTS;
8d4e1650:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e1654:	00 0c       	CC = R0 == 0x0;
8d4e1656:	f7 17       	IF !CC JUMP 0x0x8d4e1644 (BP);
8d4e1658:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d4e165a:	03 c8 00 18 	MNOP || R0 = [P5 + 0x14] || R2 = [P5 + 0x18];
8d4e165e:	68 a1 aa a1 
8d4e1662:	04 cc 02 04 	R2 = R0 + R2 (NS) || R3 = [P5] || R0 = [P5 + 0x4];
8d4e1666:	2b 91 68 a0 
8d4e166a:	f3 b0       	[SP + 0xc] = R3;
8d4e166c:	03 c8 00 18 	MNOP || [P5 + 0x18] = R2 || R2 = [P5 + 0x8];
8d4e1670:	aa b1 aa a0 
8d4e1674:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1678:	bc 05 00 00 
8d4e167c:	03 c8 00 18 	MNOP || R1 = [P5 + 0x4] || R2 = [P5 + 0x8];
8d4e1680:	69 a0 aa a0 
8d4e1684:	04 cc 08 02 	R1 = R1 + R0 (NS) || [P5 + 0x10] = R1 || NOP;
8d4e1688:	29 b1 00 00 
8d4e168c:	90 09       	CC = R0 < R2 (IU);
8d4e168e:	09 32       	P1 = R1;
8d4e1690:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || [P5 + 0x14] = R0 || NOP;
8d4e1694:	68 b1 00 00 
8d4e1698:	f8 67       	R0 += -0x1;		/* ( -1) */
8d4e169a:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0xc] = R0 || NOP;
8d4e169e:	e8 b0 00 00 
8d4e16a2:	d1 13       	IF !CC JUMP 0x0x8d4e1644;
8d4e16a4:	08 9b       	B[P1] = R0;
8d4e16a6:	e8 a0       	R0 = [P5 + 0xc];
8d4e16a8:	08 64       	R0 += 0x1;		/* (  1) */
8d4e16aa:	e8 b0       	[P5 + 0xc] = R0;
8d4e16ac:	af e6 1c 00 	B[P5 + 0x1c] = R7;
8d4e16b0:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e16b2:	bd 05       	(R7:7, P5:5) = [SP++];
8d4e16b4:	01 e8 00 00 	UNLINK;
8d4e16b8:	08 60       	R0 = 0x1 (X);		/*		R0=0xffffffa9(-87) */
8d4e16ba:	10 00       	RTS;
8d4e16bc:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e16be:	bd 05       	(R7:7, P5:5) = [SP++];
8d4e16c0:	01 e8 00 00 	UNLINK;
8d4e16c4:	00 60       	R0 = 0x0 (X);		/*		R0=0xffffffa9(-87) */
8d4e16c6:	10 00       	RTS;
8d4e16c8:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e16cc:	e4 05       	[--SP] = (R7:4, P5:4);
8d4e16ce:	20 32       	P4 = R0;
8d4e16d0:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e16d2:	31 30       	R6 = R1;
8d4e16d4:	65 91       	P5 = [P4];
8d4e16d6:	03 c8 00 18 	MNOP || R0 = [P5 + 0x10] || R1 = [P5 + 0xc];
8d4e16da:	28 a1 e9 a0 
8d4e16de:	88 52       	R2 = R0 - R1;
8d4e16e0:	8a 0c       	CC = R2 < 0x1;
8d4e16e2:	26 10       	IF !CC JUMP 0x0x8d4e172e;
8d4e16e4:	af a0       	R7 = [P5 + 0x8];
8d4e16e6:	07 0c       	CC = R7 == 0x0;
8d4e16e8:	51 18       	IF CC JUMP 0x0x8d4e178a;
8d4e16ea:	b8 52       	R2 = R0 - R7;
8d4e16ec:	02 30       	R0 = R2;
8d4e16ee:	08 64       	R0 += 0x1;		/* (  1) */
8d4e16f0:	08 4e       	R0 >>= 0x1;
8d4e16f2:	42 51       	R5 = R2 + R0;
8d4e16f4:	39 52       	R0 = R1 - R7;
8d4e16f6:	20 30       	R4 = R0;
8d4e16f8:	08 64       	R0 += 0x1;		/* (  1) */
8d4e16fa:	85 09       	CC = R5 < R0 (IU);
8d4e16fc:	28 07       	IF CC R5 = R0;
8d4e16fe:	05 0c       	CC = R5 == 0x0;
8d4e1700:	08 10       	IF !CC JUMP 0x0x8d4e1710;
8d4e1702:	07 30       	R0 = R7;
8d4e1704:	00 de ed 8f 	CALL.A 0x8fed376c;
8d4e1708:	6c 37 00 00 
8d4e170c:	00 60       	R0 = 0x0 (X);		/*		R0=0xffffffa9(-87) */
8d4e170e:	07 20       	JUMP.S 0x0x8d4e171c;
8d4e1710:	0d 30       	R1 = R5;
8d4e1712:	07 30       	R0 = R7;
8d4e1714:	00 de ed 8f 	CALL.A 0x8fed32e8;
8d4e1718:	e8 32 00 00 
8d4e171c:	04 cc 04 02 	R1 = R0 + R4 (NS) || [P5 + 0x8] = R0 || NOP;
8d4e1720:	a8 b0 00 00 
8d4e1724:	04 cc 05 00 	R0 = R0 + R5 (NS) || [P5 + 0xc] = R1 || NOP;
8d4e1728:	e9 b0 00 00 
8d4e172c:	28 b1       	[P5 + 0x10] = R0;
8d4e172e:	01 0c       	CC = R1 == 0x0;
8d4e1730:	24 18       	IF CC JUMP 0x0x8d4e1778;
8d4e1732:	03 c8 00 18 	MNOP || R0 = [P5 + 0xc] || R1 = [P5 + 0x10];
8d4e1736:	e8 a0 29 a1 
8d4e173a:	08 32       	P1 = R0;
8d4e173c:	01 52       	R0 = R1 - R0;
8d4e173e:	88 0c       	CC = R0 < 0x1;
8d4e1740:	10 18       	IF CC JUMP 0x0x8d4e1760;
8d4e1742:	41 32       	P0 = P1;
8d4e1744:	08 6c       	P0 += 0x1;		/* (  1) */
8d4e1746:	e8 bc       	[P5 + 0xc] = P0;
8d4e1748:	0e 9b       	B[P1] = R6;
8d4e174a:	60 a0       	R0 = [P4 + 0x4];
8d4e174c:	08 64       	R0 += 0x1;		/* (  1) */
8d4e174e:	60 b0       	[P4 + 0x4] = R0;
8d4e1750:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e1752:	a4 05       	(R7:4, P5:4) = [SP++];
8d4e1754:	01 e8 00 00 	UNLINK;
8d4e1758:	10 00       	RTS;
8d4e175a:	00 00       	NOP;
8d4e175c:	00 00       	NOP;
8d4e175e:	00 00       	NOP;
8d4e1760:	00 da 03 84 	R0=-2080151332;
8d4e1764:	dc 68 00 00 
8d4e1768:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e176c:	d4 34 00 00 
8d4e1770:	e9 ac       	P1 = [P5 + 0xc];
8d4e1772:	e8 2f       	JUMP.S 0x0x8d4e1742;
8d4e1774:	00 00       	NOP;
8d4e1776:	00 00       	NOP;
8d4e1778:	00 da 03 84 	R0=-2080151408;
8d4e177c:	90 68 00 00 
8d4e1780:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1784:	d4 34 00 00 
8d4e1788:	d5 2f       	JUMP.S 0x0x8d4e1732;
8d4e178a:	28 91       	R0 = [P5];
8d4e178c:	00 0c       	CC = R0 == 0x0;
8d4e178e:	03 18       	IF CC JUMP 0x0x8d4e1794;
8d4e1790:	6d a1       	R5 = [P5 + 0x14];
8d4e1792:	b1 2f       	JUMP.S 0x0x8d4e16f4;
8d4e1794:	08 60       	R0 = 0x1 (X);		/*		R0=0xffffffa9(-87) */
8d4e1796:	ff e3 1f 66 	CALL 0x0x8d4ce3d4;
8d4e179a:	00 0c       	CC = R0 == 0x0;
8d4e179c:	08 18       	IF CC JUMP 0x0x8d4e17ac;
8d4e179e:	38 30       	R7 = R0;
8d4e17a0:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e17a2:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4e17a4:	00 de 02 04 	CALL.A 0x04022ea8;
8d4e17a8:	a8 2e 00 00 
8d4e17ac:	03 c8 00 18 	MNOP || [P5] = R7 || R1 = [P5 + 0xc];
8d4e17b0:	2f 93 e9 a0 
8d4e17b4:	03 c8 00 18 	MNOP || [P5 + 0x4] = R7 || R7 = [P5 + 0x8];
8d4e17b8:	6f b0 af a0 
8d4e17bc:	ea 2f       	JUMP.S 0x0x8d4e1790;
8d4e17be:	00 00       	NOP;
8d4e17c0:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4e17c4:	e3 05       	[--SP] = (R7:4, P5:3);
8d4e17c6:	29 32       	P5 = R1;
8d4e17c8:	86 6f       	SP += -0x10;		/* (-16) */
8d4e17ca:	14 61       	R4 = 0x22 (X);		/*		R4=0x0(  0) */
8d4e17cc:	38 b1       	[FP + 0x10] = R0;
8d4e17ce:	70 b3       	[SP + 0x34] = R0;
8d4e17d0:	65 32       	P4 = P5;
8d4e17d2:	84 6c       	P4 += 0x10;		/* ( 16) */
8d4e17d4:	03 c8 00 18 	MNOP || P1 = [P4] || [SP + 0x38] = R1;
8d4e17d8:	61 91 b1 b3 
8d4e17dc:	f2 b2       	[SP + 0x2c] = R2;
8d4e17de:	00 da 03 84 	R0=-2080150560;
8d4e17e2:	e0 6b 00 00 
8d4e17e6:	4b 99       	R3 = B[P1] (X);
8d4e17e8:	23 08       	CC = R3 == R4;
8d4e17ea:	02 1c       	IF CC JUMP 0x0x8d4e17ee (BP);
8d4e17ec:	da 23       	JUMP.S 0x0x8d4e1fa0;
8d4e17ee:	20 91       	R0 = [P4];
8d4e17f0:	21 e4 ff ff 	R1 = [P4 + -0x4];
8d4e17f4:	88 09       	CC = R0 < R1 (IU);
8d4e17f6:	02 1c       	IF CC JUMP 0x0x8d4e17fa (BP);
8d4e17f8:	9e 23       	JUMP.S 0x0x8d4e1f34;
8d4e17fa:	08 64       	R0 += 0x1;		/* (  1) */
8d4e17fc:	20 93       	[P4] = R0;
8d4e17fe:	04 cc 00 40 	R0 = R0 - R0 (NS) || P1 = [FP + 0x10] || NOP;
8d4e1802:	39 ad 00 00 
8d4e1806:	f8 b0       	[FP + 0xc] = R0;
8d4e1808:	b9 bc       	[FP + 0x8] = P1;
8d4e180a:	25 e1 5c 00 	R5 = 0x5c (X);		/*		R5=0x5c( 92) */
8d4e180e:	61 91       	P1 = [P4];
8d4e1810:	00 61       	R0 = 0x20 (X);		/*		R0=0xffffffa9(-87) */
8d4e1812:	4f 99       	R7 = B[P1] (X);
8d4e1814:	2f 08       	CC = R7 == R5;
8d4e1816:	02 1c       	IF CC JUMP 0x0x8d4e181a (BP);
8d4e1818:	cf 22       	JUMP.S 0x0x8d4e1db6;
8d4e181a:	49 30       	R1 = P1;
8d4e181c:	03 c8 00 18 	MNOP || R0 = [P5 + 0x4] || R2 = [P5 + 0xc];
8d4e1820:	68 a0 ea a0 
8d4e1824:	91 09       	CC = R1 < R2 (IU);
8d4e1826:	04 cc 08 42 	R1 = R1 - R0 (NS) || R3 = [P5 + 0x18] || NOP;
8d4e182a:	ab a1 00 00 
8d4e182e:	8b 51       	R6 = R3 + R1;
8d4e1830:	02 1c       	IF CC JUMP 0x0x8d4e1834 (BP);
8d4e1832:	8d 22       	JUMP.S 0x0x8d4e1d4c;
8d4e1834:	09 6c       	P1 += 0x1;		/* (  1) */
8d4e1836:	61 93       	[P4] = P1;
8d4e1838:	0a 99       	R2 = B[P1] (Z);
8d4e183a:	00 da 03 84 	R0=-2080149088;
8d4e183e:	a0 71 00 00 
8d4e1842:	10 50       	R0 = R0 + R2;
8d4e1844:	18 32       	P3 = R0;
8d4e1846:	10 43       	R0 = R2.B (X);
8d4e1848:	59 99       	R1 = B[P3] (X);
8d4e184a:	01 0c       	CC = R1 == 0x0;
8d4e184c:	42 18       	IF CC JUMP 0x0x8d4e18d0;
8d4e184e:	ea a0       	R2 = [P5 + 0xc];
8d4e1850:	41 30       	R0 = P1;
8d4e1852:	90 09       	CC = R0 < R2 (IU);
8d4e1854:	0a 10       	IF !CC JUMP 0x0x8d4e1868;
8d4e1856:	09 6c       	P1 += 0x1;		/* (  1) */
8d4e1858:	61 93       	[P4] = P1;
8d4e185a:	59 99       	R1 = B[P3] (X);
8d4e185c:	47 30       	R0 = FP;
8d4e185e:	40 64       	R0 += 0x8;		/* (  8) */
8d4e1860:	ff e3 34 ff 	CALL 0x0x8d4e16c8;
8d4e1864:	d5 2f       	JUMP.S 0x0x8d4e180e;
8d4e1866:	00 00       	NOP;
8d4e1868:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e186c:	00 0c       	CC = R0 == 0x0;
8d4e186e:	f7 17       	IF !CC JUMP 0x0x8d4e185c (BP);
8d4e1870:	03 c8 00 18 	MNOP || R2 = [P5 + 0x14] || R3 = [P5 + 0x18];
8d4e1874:	6a a1 ab a1 
8d4e1878:	04 cc 13 04 	R2 = R2 + R3 (NS) || R7 = [P5] || R0 = [P5 + 0x4];
8d4e187c:	2f 91 68 a0 
8d4e1880:	03 c8 00 18 	MNOP || [P5 + 0x18] = R2 || R2 = [P5 + 0x8];
8d4e1884:	aa b1 aa a0 
8d4e1888:	f7 b0       	[SP + 0xc] = R7;
8d4e188a:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d4e188c:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1890:	bc 05 00 00 
8d4e1894:	03 c8 00 18 	MNOP || R3 = [P5 + 0x4] || R7 = [P5 + 0x8];
8d4e1898:	6b a0 af a0 
8d4e189c:	04 cc 18 04 	R2 = R3 + R0 (NS) || [P5 + 0x14] = R0 || NOP;
8d4e18a0:	68 b1 00 00 
8d4e18a4:	82 ce 02 c2 	R1 = ROT R2 BY 0x0 || [P5 + 0x10] = R3 || NOP;
8d4e18a8:	2b b1 00 00 
8d4e18ac:	0a 32       	P1 = R2;
8d4e18ae:	f9 67       	R1 += -0x1;		/* ( -1) */
8d4e18b0:	e9 b0       	[P5 + 0xc] = R1;
8d4e18b2:	b8 09       	CC = R0 < R7 (IU);
8d4e18b4:	04 cc 00 40 	R0 = R0 - R0 (NS) || R1 = B[P3] (X) || NOP;
8d4e18b8:	59 99 00 00 
8d4e18bc:	d0 13       	IF !CC JUMP 0x0x8d4e185c;
8d4e18be:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d4e18c0:	08 9b       	B[P1] = R0;
8d4e18c2:	e8 a0       	R0 = [P5 + 0xc];
8d4e18c4:	08 64       	R0 += 0x1;		/* (  1) */
8d4e18c6:	a9 e6 1c 00 	B[P5 + 0x1c] = R1;
8d4e18ca:	e8 b0       	[P5 + 0xc] = R0;
8d4e18cc:	59 99       	R1 = B[P3] (X);
8d4e18ce:	c7 2f       	JUMP.S 0x0x8d4e185c;
8d4e18d0:	21 e1 75 00 	R1 = 0x75 (X);		/*		R1=0x75(117) */
8d4e18d4:	08 08       	CC = R0 == R1;
8d4e18d6:	02 1c       	IF CC JUMP 0x0x8d4e18da (BP);
8d4e18d8:	27 22       	JUMP.S 0x0x8d4e1d26;
8d4e18da:	e9 a0       	R1 = [P5 + 0xc];
8d4e18dc:	41 30       	R0 = P1;
8d4e18de:	88 09       	CC = R0 < R1 (IU);
8d4e18e0:	02 1c       	IF CC JUMP 0x0x8d4e18e4 (BP);
8d4e18e2:	eb 21       	JUMP.S 0x0x8d4e1cb8;
8d4e18e4:	09 6c       	P1 += 0x1;		/* (  1) */
8d4e18e6:	61 93       	[P4] = P1;
8d4e18e8:	82 ce 06 c4 	R2 = ROT R6 BY 0x0 || R1 = [SP + 0x38] || R0 = [SP + 0x34];
8d4e18ec:	b1 a3 70 a3 
8d4e18f0:	ff e3 04 fe 	CALL 0x0x8d4e14f8;
8d4e18f4:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P1 = [FP + 0x10] || NOP;
8d4e18f8:	39 ad 00 00 
8d4e18fc:	80 e1 00 d8 	R0 = 0xd800 (Z);		/*		R0=0xd800(55296) */
8d4e1900:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4e1902:	89 a1       	R1 = [P1 + 0x18];
8d4e1904:	01 0c       	CC = R1 == 0x0;
8d4e1906:	02 1c       	IF CC JUMP 0x0x8d4e190a (BP);
8d4e1908:	d5 21       	JUMP.S 0x0x8d4e1cb2;
8d4e190a:	38 0a       	CC = R0 <= R7 (IU);
8d4e190c:	78 18       	IF CC JUMP 0x0x8d4e19fc;
8d4e190e:	20 e1 7f 00 	R0 = 0x7f (X);		/*		R0=0x7f(127) */
8d4e1912:	07 0a       	CC = R7 <= R0 (IU);
8d4e1914:	04 10       	IF !CC JUMP 0x0x8d4e191c;
8d4e1916:	39 43       	R1 = R7.B (X);
8d4e1918:	a2 2f       	JUMP.S 0x0x8d4e185c;
8d4e191a:	00 00       	NOP;
8d4e191c:	20 e1 ff 07 	R0 = 0x7ff (X);		/*		R0=0x7ff(2047) */
8d4e1920:	07 0a       	CC = R7 <= R0 (IU);
8d4e1922:	5f 18       	IF CC JUMP 0x0x8d4e19e0;
8d4e1924:	80 e1 ff ff 	R0 = 0xffff (Z);		/*		R0=0xffff(65535) */
8d4e1928:	07 0a       	CC = R7 <= R0 (IU);
8d4e192a:	3d 18       	IF CC JUMP 0x0x8d4e19a4;
8d4e192c:	00 da 10 00 	R0=1114111;
8d4e1930:	ff ff 00 00 
8d4e1934:	07 0a       	CC = R7 <= R0 (IU);
8d4e1936:	2d 10       	IF !CC JUMP 0x0x8d4e1990;
8d4e1938:	82 c6 a7 81 	R0 = R7 >> 0xc;
8d4e193c:	fb 61       	R3 = 0x3f (X);		/*		R3=0x0(  0) */
8d4e193e:	18 54       	R0 = R0 & R3;
8d4e1940:	82 c6 77 83 	R1 = R7 >> 0x12;
8d4e1944:	82 63       	R2 = -0x10 (X);		/*		R2=0x0(  0) */
8d4e1946:	77 30       	R6 = FP;
8d4e1948:	38 4a       	BITSET (R0, 0x7);		/* bit  7 */
8d4e194a:	51 56       	R1 = R1 | R2;
8d4e194c:	46 64       	R6 += 0x8;		/* (  8) */
8d4e194e:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0x30] = R0 || NOP;
8d4e1952:	30 b3 00 00 
8d4e1956:	09 43       	R1 = R1.B (X);
8d4e1958:	ff e3 b8 fe 	CALL 0x0x8d4e16c8;
8d4e195c:	fb 61       	R3 = 0x3f (X);		/*		R3=0x0(  0) */
8d4e195e:	df 54       	R3 = R7 & R3;
8d4e1960:	82 ce d7 85 	R2 = R7 >> 0x6 || R1 = [SP + 0x30] || NOP;
8d4e1964:	31 a3 00 00 
8d4e1968:	f8 61       	R0 = 0x3f (X);		/*		R0=0xffff(65535) */
8d4e196a:	3b 4a       	BITSET (R3, 0x7);		/* bit  7 */
8d4e196c:	82 54       	R2 = R2 & R0;
8d4e196e:	82 ce 02 ce 	R7 = ROT R2 BY 0x0 || [SP + 0x30] = R3 || NOP;
8d4e1972:	33 b3 00 00 
8d4e1976:	09 43       	R1 = R1.B (X);
8d4e1978:	06 30       	R0 = R6;
8d4e197a:	ff e3 a7 fe 	CALL 0x0x8d4e16c8;
8d4e197e:	3f 4a       	BITSET (R7, 0x7);		/* bit  7 */
8d4e1980:	06 30       	R0 = R6;
8d4e1982:	39 43       	R1 = R7.B (X);
8d4e1984:	ff e3 a2 fe 	CALL 0x0x8d4e16c8;
8d4e1988:	32 a3       	R2 = [SP + 0x30];
8d4e198a:	11 43       	R1 = R2.B (X);
8d4e198c:	68 2f       	JUMP.S 0x0x8d4e185c;
8d4e198e:	00 00       	NOP;
8d4e1990:	00 da 03 84 	R0=-2080151192;
8d4e1994:	68 69 00 00 
8d4e1998:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e199c:	d4 34 00 00 
8d4e19a0:	cc 2f       	JUMP.S 0x0x8d4e1938;
8d4e19a2:	00 00       	NOP;
8d4e19a4:	82 c6 a7 81 	R0 = R7 >> 0xc;
8d4e19a8:	01 63       	R1 = -0x20 (X);		/*		R1=0x75(117) */
8d4e19aa:	08 56       	R0 = R0 | R1;
8d4e19ac:	fb 61       	R3 = 0x3f (X);		/*		R3=0x0(  0) */
8d4e19ae:	01 43       	R1 = R0.B (X);
8d4e19b0:	df 54       	R3 = R7 & R3;
8d4e19b2:	82 c6 d7 85 	R2 = R7 >> 0x6;
8d4e19b6:	77 30       	R6 = FP;
8d4e19b8:	f8 61       	R0 = 0x3f (X);		/*		R0=0xffff(65535) */
8d4e19ba:	3b 4a       	BITSET (R3, 0x7);		/* bit  7 */
8d4e19bc:	82 54       	R2 = R2 & R0;
8d4e19be:	46 64       	R6 += 0x8;		/* (  8) */
8d4e19c0:	82 ce 02 ce 	R7 = ROT R2 BY 0x0 || [SP + 0x30] = R3 || NOP;
8d4e19c4:	33 b3 00 00 
8d4e19c8:	06 30       	R0 = R6;
8d4e19ca:	ff e3 7f fe 	CALL 0x0x8d4e16c8;
8d4e19ce:	3f 4a       	BITSET (R7, 0x7);		/* bit  7 */
8d4e19d0:	06 30       	R0 = R6;
8d4e19d2:	39 43       	R1 = R7.B (X);
8d4e19d4:	ff e3 7a fe 	CALL 0x0x8d4e16c8;
8d4e19d8:	32 a3       	R2 = [SP + 0x30];
8d4e19da:	11 43       	R1 = R2.B (X);
8d4e19dc:	40 2f       	JUMP.S 0x0x8d4e185c;
8d4e19de:	00 00       	NOP;
8d4e19e0:	82 c6 d7 85 	R2 = R7 >> 0x6;
8d4e19e4:	03 62       	R3 = -0x40 (X);		/*		R3=0x0(  0) */
8d4e19e6:	9a 56       	R2 = R2 | R3;
8d4e19e8:	fe 61       	R6 = 0x3f (X);		/*		R6=0x0(  0) */
8d4e19ea:	47 30       	R0 = FP;
8d4e19ec:	b7 55       	R6 = R7 & R6;
8d4e19ee:	11 43       	R1 = R2.B (X);
8d4e19f0:	40 64       	R0 += 0x8;		/* (  8) */
8d4e19f2:	ff e3 6b fe 	CALL 0x0x8d4e16c8;
8d4e19f6:	3e 4a       	BITSET (R6, 0x7);		/* bit  7 */
8d4e19f8:	31 43       	R1 = R6.B (X);
8d4e19fa:	31 2f       	JUMP.S 0x0x8d4e185c;
8d4e19fc:	80 e1 ff df 	R0 = 0xdfff (Z);		/*		R0=0xdfff(57343) */
8d4e1a00:	07 0a       	CC = R7 <= R0 (IU);
8d4e1a02:	86 13       	IF !CC JUMP 0x0x8d4e190e;
8d4e1a04:	80 e1 ff db 	R0 = 0xdbff (Z);		/*		R0=0xdbff(56319) */
8d4e1a08:	07 0a       	CC = R7 <= R0 (IU);
8d4e1a0a:	41 11       	IF !CC JUMP 0x0x8d4e1c8c;
8d4e1a0c:	61 91       	P1 = [P4];
8d4e1a0e:	48 99       	R0 = B[P1] (X);
8d4e1a10:	28 08       	CC = R0 == R5;
8d4e1a12:	08 10       	IF !CC JUMP 0x0x8d4e1a22;
8d4e1a14:	e9 a0       	R1 = [P5 + 0xc];
8d4e1a16:	41 30       	R0 = P1;
8d4e1a18:	88 09       	CC = R0 < R1 (IU);
8d4e1a1a:	05 11       	IF !CC JUMP 0x0x8d4e1c24;
8d4e1a1c:	09 6c       	P1 += 0x1;		/* (  1) */
8d4e1a1e:	61 93       	[P4] = P1;
8d4e1a20:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1a22:	02 0c       	CC = R2 == 0x0;
8d4e1a24:	b9 18       	IF CC JUMP 0x0x8d4e1b96;
8d4e1a26:	04 cc 12 44 	R2 = R2 - R2 (NS) || P1 = [P4] || NOP;
8d4e1a2a:	61 91 00 00 
8d4e1a2e:	21 e1 75 00 	R1 = 0x75 (X);		/*		R1=0x75(117) */
8d4e1a32:	48 99       	R0 = B[P1] (X);
8d4e1a34:	08 08       	CC = R0 == R1;
8d4e1a36:	08 10       	IF !CC JUMP 0x0x8d4e1a46;
8d4e1a38:	e9 a0       	R1 = [P5 + 0xc];
8d4e1a3a:	41 30       	R0 = P1;
8d4e1a3c:	88 09       	CC = R0 < R1 (IU);
8d4e1a3e:	bf 10       	IF !CC JUMP 0x0x8d4e1bbc;
8d4e1a40:	09 6c       	P1 += 0x1;		/* (  1) */
8d4e1a42:	61 93       	[P4] = P1;
8d4e1a44:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1a46:	02 0c       	CC = R2 == 0x0;
8d4e1a48:	a7 18       	IF CC JUMP 0x0x8d4e1b96;
8d4e1a4a:	82 ce 06 c4 	R2 = ROT R6 BY 0x0 || R1 = [SP + 0x38] || R0 = [SP + 0x34];
8d4e1a4e:	b1 a3 70 a3 
8d4e1a52:	ff e3 53 fd 	CALL 0x0x8d4e14f8;
8d4e1a56:	39 ad       	P1 = [FP + 0x10];
8d4e1a58:	02 da ff ff 	R2=-56320;
8d4e1a5c:	00 24 00 00 
8d4e1a60:	03 da 01 00 	R3=65536;
8d4e1a64:	00 00 00 00 
8d4e1a68:	89 a1       	R1 = [P1 + 0x18];
8d4e1a6a:	01 0c       	CC = R1 == 0x0;
8d4e1a6c:	93 10       	IF !CC JUMP 0x0x8d4e1b92;
8d4e1a6e:	81 e1 00 dc 	R1 = 0xdc00 (Z);		/*		R1=0xdc00(56320) */
8d4e1a72:	88 09       	CC = R0 < R1 (IU);
8d4e1a74:	0f 18       	IF CC JUMP 0x0x8d4e1a92;
8d4e1a76:	81 e1 ff df 	R1 = 0xdfff (Z);		/*		R1=0xdfff(57343) */
8d4e1a7a:	81 09       	CC = R1 < R0 (IU);
8d4e1a7c:	0b 18       	IF CC JUMP 0x0x8d4e1a92;
8d4e1a7e:	01 da ff ff 	R1=-55296;
8d4e1a82:	00 28 00 00 
8d4e1a86:	4f 50       	R1 = R7 + R1;
8d4e1a88:	10 50       	R0 = R0 + R2;
8d4e1a8a:	51 4f       	R1 <<= 0xa;
8d4e1a8c:	01 56       	R0 = R1 | R0;
8d4e1a8e:	d8 51       	R7 = R0 + R3;
8d4e1a90:	3f 2f       	JUMP.S 0x0x8d4e190e;
8d4e1a92:	88 a1       	R0 = [P1 + 0x18];
8d4e1a94:	00 0c       	CC = R0 == 0x0;
8d4e1a96:	75 10       	IF !CC JUMP 0x0x8d4e1b80;
8d4e1a98:	39 ad       	P1 = [FP + 0x10];
8d4e1a9a:	48 60       	R0 = 0x9 (X);		/*		R0=0xdbff(56319) */
8d4e1a9c:	ce b1       	[P1 + 0x1c] = R6;
8d4e1a9e:	88 b1       	[P1 + 0x18] = R0;
8d4e1aa0:	00 0c       	CC = R0 == 0x0;
8d4e1aa2:	34 10       	IF !CC JUMP 0x0x8d4e1b0a;
8d4e1aa4:	03 c8 00 18 	MNOP || P4 = [FP + 0x8] || R7 = [FP + 0xc];
8d4e1aa8:	bc ac ff a0 
8d4e1aac:	f3 ae       	P3 = [SP + 0x2c];
8d4e1aae:	03 c8 00 18 	MNOP || R0 = [P4 + 0xc] || R1 = [P4 + 0x8];
8d4e1ab2:	e0 a0 a1 a0 
8d4e1ab6:	08 52       	R0 = R0 - R1;
8d4e1ab8:	07 0a       	CC = R7 <= R0 (IU);
8d4e1aba:	57 10       	IF !CC JUMP 0x0x8d4e1b68;
8d4e1abc:	03 c8 00 18 	MNOP || R0 = [P4 + 0xc] || R2 = [FP + 0x14];
8d4e1ac0:	e0 a0 7a a1 
8d4e1ac4:	78 52       	R1 = R0 - R7;
8d4e1ac6:	02 0c       	CC = R2 == 0x0;
8d4e1ac8:	e1 b0       	[P4 + 0xc] = R1;
8d4e1aca:	3f 18       	IF CC JUMP 0x0x8d4e1b48;
8d4e1acc:	18 91       	R0 = [P3];
8d4e1ace:	08 0c       	CC = R0 == 0x1;
8d4e1ad0:	00 60       	R0 = 0x0 (X);		/*		R0=0xdbff(56319) */
8d4e1ad2:	2c 18       	IF CC JUMP 0x0x8d4e1b2a;
8d4e1ad4:	98 e6 04 00 	B[P3 + 0x4] = R0;
8d4e1ad8:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1ada:	39 ad       	P1 = [FP + 0x10];
8d4e1adc:	02 0c       	CC = R2 == 0x0;
8d4e1ade:	16 10       	IF !CC JUMP 0x0x8d4e1b0a;
8d4e1ae0:	88 a1       	R0 = [P1 + 0x18];
8d4e1ae2:	00 0c       	CC = R0 == 0x0;
8d4e1ae4:	1a 10       	IF !CC JUMP 0x0x8d4e1b18;
8d4e1ae6:	03 c8 00 18 	MNOP || P1 = [FP + 0x10] || R1 = [P5 + 0x10];
8d4e1aea:	39 ad 29 a1 
8d4e1aee:	03 c8 00 18 	MNOP || R2 = [P5 + 0x4] || R3 = [P5 + 0x18];
8d4e1af2:	6a a0 ab a1 
8d4e1af6:	51 52       	R1 = R1 - R2;
8d4e1af8:	4b 50       	R1 = R3 + R1;
8d4e1afa:	80 60       	R0 = 0x10 (X);		/*		R0=0xdbff(56319) */
8d4e1afc:	c9 b1       	[P1 + 0x1c] = R1;
8d4e1afe:	88 b1       	[P1 + 0x18] = R0;
8d4e1b00:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e1b02:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e1b04:	01 e8 00 00 	UNLINK;
8d4e1b08:	10 00       	RTS;
8d4e1b0a:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e1b0c:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e1b0e:	01 e8 00 00 	UNLINK;
8d4e1b12:	10 00       	RTS;
8d4e1b14:	00 00       	NOP;
8d4e1b16:	00 00       	NOP;
8d4e1b18:	00 da 03 84 	R0=-2080150488;
8d4e1b1c:	28 6c 00 00 
8d4e1b20:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1b24:	d4 34 00 00 
8d4e1b28:	df 2f       	JUMP.S 0x0x8d4e1ae6;
8d4e1b2a:	01 30       	R0 = R1;
8d4e1b2c:	01 da 03 84 	R1=-2080151488;
8d4e1b30:	40 68 00 00 
8d4e1b34:	00 de 02 04 	CALL.A 0x040231b4;
8d4e1b38:	b4 31 00 00 
8d4e1b3c:	00 0c       	CC = R0 == 0x0;
8d4e1b3e:	08 60       	R0 = 0x1 (X);		/*		R0=0xdbff(56319) */
8d4e1b40:	ca 1b       	IF CC JUMP 0x0x8d4e1ad4;
8d4e1b42:	00 60       	R0 = 0x0 (X);		/*		R0=0xdbff(56319) */
8d4e1b44:	c8 2f       	JUMP.S 0x0x8d4e1ad4;
8d4e1b46:	00 00       	NOP;
8d4e1b48:	98 e4 04 00 	R0 = B[P3 + 0x4] (Z);
8d4e1b4c:	00 0c       	CC = R0 == 0x0;
8d4e1b4e:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1b50:	c5 1f       	IF CC JUMP 0x0x8d4e1ada (BP);
8d4e1b52:	f0 a2       	R0 = [SP + 0x2c];
8d4e1b54:	40 64       	R0 += 0x8;		/* (  8) */
8d4e1b56:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e1b5a:	76 a3 00 00 
8d4e1b5e:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4e1b60:	bd 2f       	JUMP.S 0x0x8d4e1ada;
8d4e1b62:	00 00       	NOP;
8d4e1b64:	00 00       	NOP;
8d4e1b66:	00 00       	NOP;
8d4e1b68:	00 da 03 84 	R0=-2080150656;
8d4e1b6c:	80 6b 00 00 
8d4e1b70:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1b74:	d4 34 00 00 
8d4e1b78:	a2 2f       	JUMP.S 0x0x8d4e1abc;
8d4e1b7a:	00 00       	NOP;
8d4e1b7c:	00 00       	NOP;
8d4e1b7e:	00 00       	NOP;
8d4e1b80:	00 da 03 84 	R0=-2080151036;
8d4e1b84:	04 6a 00 00 
8d4e1b88:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1b8c:	d4 34 00 00 
8d4e1b90:	84 2f       	JUMP.S 0x0x8d4e1a98;
8d4e1b92:	88 a1       	R0 = [P1 + 0x18];
8d4e1b94:	86 2f       	JUMP.S 0x0x8d4e1aa0;
8d4e1b96:	39 ad       	P1 = [FP + 0x10];
8d4e1b98:	88 a1       	R0 = [P1 + 0x18];
8d4e1b9a:	00 0c       	CC = R0 == 0x0;
8d4e1b9c:	06 10       	IF !CC JUMP 0x0x8d4e1ba8;
8d4e1b9e:	38 ad       	P0 = [FP + 0x10];
8d4e1ba0:	48 60       	R0 = 0x9 (X);		/*		R0=0xdbff(56319) */
8d4e1ba2:	c6 b1       	[P0 + 0x1c] = R6;
8d4e1ba4:	80 b1       	[P0 + 0x18] = R0;
8d4e1ba6:	7d 2f       	JUMP.S 0x0x8d4e1aa0;
8d4e1ba8:	00 da 03 84 	R0=-2080151112;
8d4e1bac:	b8 69 00 00 
8d4e1bb0:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1bb4:	d4 34 00 00 
8d4e1bb8:	f3 2f       	JUMP.S 0x0x8d4e1b9e;
8d4e1bba:	00 00       	NOP;
8d4e1bbc:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e1bc0:	00 0c       	CC = R0 == 0x0;
8d4e1bc2:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1bc4:	41 17       	IF !CC JUMP 0x0x8d4e1a46 (BP);
8d4e1bc6:	03 c8 00 18 	MNOP || R2 = [P4 + 0x4] || R3 = [P4 + 0x8];
8d4e1bca:	62 a0 a3 a0 
8d4e1bce:	04 cc 13 04 	R2 = R2 + R3 (NS) || R1 = [P5] || R0 = [P5 + 0x4];
8d4e1bd2:	29 91 68 a0 
8d4e1bd6:	03 c8 00 18 	MNOP || [P4 + 0x8] = R2 || R2 = [P5 + 0x8];
8d4e1bda:	a2 b0 aa a0 
8d4e1bde:	f1 b0       	[SP + 0xc] = R1;
8d4e1be0:	09 60       	R1 = 0x1 (X);		/*		R1=0xdfff(57343) */
8d4e1be2:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1be6:	bc 05 00 00 
8d4e1bea:	03 c8 00 18 	MNOP || R3 = [P5 + 0x4] || R2 = [P5 + 0x8];
8d4e1bee:	6b a0 aa a0 
8d4e1bf2:	04 cc 18 02 	R1 = R3 + R0 (NS) || [P5 + 0x10] = R3 || NOP;
8d4e1bf6:	2b b1 00 00 
8d4e1bfa:	82 ce 01 c6 	R3 = ROT R1 BY 0x0 || [P5 + 0x14] = R0 || NOP;
8d4e1bfe:	68 b1 00 00 
8d4e1c02:	09 32       	P1 = R1;
8d4e1c04:	fb 67       	R3 += -0x1;		/* ( -1) */
8d4e1c06:	90 09       	CC = R0 < R2 (IU);
8d4e1c08:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0xc] = R3 || NOP;
8d4e1c0c:	eb b0 00 00 
8d4e1c10:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1c12:	1a 13       	IF !CC JUMP 0x0x8d4e1a46;
8d4e1c14:	0b 60       	R3 = 0x1 (X);		/*		R3=0x0(  0) */
8d4e1c16:	08 9b       	B[P1] = R0;
8d4e1c18:	e8 a0       	R0 = [P5 + 0xc];
8d4e1c1a:	08 64       	R0 += 0x1;		/* (  1) */
8d4e1c1c:	ab e6 1c 00 	B[P5 + 0x1c] = R3;
8d4e1c20:	e8 b0       	[P5 + 0xc] = R0;
8d4e1c22:	12 2f       	JUMP.S 0x0x8d4e1a46;
8d4e1c24:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e1c28:	00 0c       	CC = R0 == 0x0;
8d4e1c2a:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1c2c:	fb 16       	IF !CC JUMP 0x0x8d4e1a22 (BP);
8d4e1c2e:	03 c8 00 18 	MNOP || R2 = [P4 + 0x4] || R3 = [P4 + 0x8];
8d4e1c32:	62 a0 a3 a0 
8d4e1c36:	04 cc 13 04 	R2 = R2 + R3 (NS) || R1 = [P5] || R0 = [P5 + 0x4];
8d4e1c3a:	29 91 68 a0 
8d4e1c3e:	03 c8 00 18 	MNOP || [P4 + 0x8] = R2 || R2 = [P5 + 0x8];
8d4e1c42:	a2 b0 aa a0 
8d4e1c46:	f1 b0       	[SP + 0xc] = R1;
8d4e1c48:	09 60       	R1 = 0x1 (X);		/*		R1=0xdfff(57343) */
8d4e1c4a:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1c4e:	bc 05 00 00 
8d4e1c52:	03 c8 00 18 	MNOP || R1 = [P5 + 0x4] || R2 = [P5 + 0x8];
8d4e1c56:	69 a0 aa a0 
8d4e1c5a:	04 cc 08 06 	R3 = R1 + R0 (NS) || [P4] = R1 || NOP;
8d4e1c5e:	21 93 00 00 
8d4e1c62:	82 ce 03 c2 	R1 = ROT R3 BY 0x0 || [P4 + 0x4] = R0 || NOP;
8d4e1c66:	60 b0 00 00 
8d4e1c6a:	fb 67       	R3 += -0x1;		/* ( -1) */
8d4e1c6c:	09 32       	P1 = R1;
8d4e1c6e:	90 09       	CC = R0 < R2 (IU);
8d4e1c70:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0xc] = R3 || NOP;
8d4e1c74:	eb b0 00 00 
8d4e1c78:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1c7a:	d4 12       	IF !CC JUMP 0x0x8d4e1a22;
8d4e1c7c:	0b 60       	R3 = 0x1 (X);		/*		R3=0x0(  0) */
8d4e1c7e:	08 9b       	B[P1] = R0;
8d4e1c80:	e8 a0       	R0 = [P5 + 0xc];
8d4e1c82:	08 64       	R0 += 0x1;		/* (  1) */
8d4e1c84:	ab e6 1c 00 	B[P5 + 0x1c] = R3;
8d4e1c88:	e8 b0       	[P5 + 0xc] = R0;
8d4e1c8a:	cc 2e       	JUMP.S 0x0x8d4e1a22;
8d4e1c8c:	88 a1       	R0 = [P1 + 0x18];
8d4e1c8e:	00 0c       	CC = R0 == 0x0;
8d4e1c90:	08 10       	IF !CC JUMP 0x0x8d4e1ca0;
8d4e1c92:	39 ad       	P1 = [FP + 0x10];
8d4e1c94:	48 60       	R0 = 0x9 (X);		/*		R0=0xdbff(56319) */
8d4e1c96:	ce b1       	[P1 + 0x1c] = R6;
8d4e1c98:	88 b1       	[P1 + 0x18] = R0;
8d4e1c9a:	03 2f       	JUMP.S 0x0x8d4e1aa0;
8d4e1c9c:	00 00       	NOP;
8d4e1c9e:	00 00       	NOP;
8d4e1ca0:	00 da 03 84 	R0=-2080150960;
8d4e1ca4:	50 6a 00 00 
8d4e1ca8:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1cac:	d4 34 00 00 
8d4e1cb0:	f1 2f       	JUMP.S 0x0x8d4e1c92;
8d4e1cb2:	88 a1       	R0 = [P1 + 0x18];
8d4e1cb4:	f6 2e       	JUMP.S 0x0x8d4e1aa0;
8d4e1cb6:	00 00       	NOP;
8d4e1cb8:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e1cbc:	00 0c       	CC = R0 == 0x0;
8d4e1cbe:	05 18       	IF CC JUMP 0x0x8d4e1cc8;
8d4e1cc0:	14 2e       	JUMP.S 0x0x8d4e18e8;
8d4e1cc2:	00 00       	NOP;
8d4e1cc4:	00 00       	NOP;
8d4e1cc6:	00 00       	NOP;
8d4e1cc8:	03 c8 00 18 	MNOP || R2 = [P5 + 0x14] || R3 = [P5 + 0x18];
8d4e1ccc:	6a a1 ab a1 
8d4e1cd0:	04 cc 13 04 	R2 = R2 + R3 (NS) || R7 = [P5] || R0 = [P5 + 0x4];
8d4e1cd4:	2f 91 68 a0 
8d4e1cd8:	03 c8 00 18 	MNOP || [P5 + 0x18] = R2 || R2 = [P5 + 0x8];
8d4e1cdc:	aa b1 aa a0 
8d4e1ce0:	f7 b0       	[SP + 0xc] = R7;
8d4e1ce2:	09 60       	R1 = 0x1 (X);		/*		R1=0xdfff(57343) */
8d4e1ce4:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1ce8:	bc 05 00 00 
8d4e1cec:	03 c8 00 18 	MNOP || R3 = [P5 + 0x4] || R7 = [P5 + 0x8];
8d4e1cf0:	6b a0 af a0 
8d4e1cf4:	04 cc 18 02 	R1 = R3 + R0 (NS) || [P5 + 0x14] = R0 || NOP;
8d4e1cf8:	68 b1 00 00 
8d4e1cfc:	82 ce 01 c4 	R2 = ROT R1 BY 0x0 || [P5 + 0x10] = R3 || NOP;
8d4e1d00:	2b b1 00 00 
8d4e1d04:	09 32       	P1 = R1;
8d4e1d06:	fa 67       	R2 += -0x1;		/* ( -1) */
8d4e1d08:	b8 09       	CC = R0 < R7 (IU);
8d4e1d0a:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0xc] = R2 || NOP;
8d4e1d0e:	ea b0 00 00 
8d4e1d12:	02 1c       	IF CC JUMP 0x0x8d4e1d16 (BP);
8d4e1d14:	ea 2d       	JUMP.S 0x0x8d4e18e8;
8d4e1d16:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1d18:	08 9b       	B[P1] = R0;
8d4e1d1a:	e8 a0       	R0 = [P5 + 0xc];
8d4e1d1c:	08 64       	R0 += 0x1;		/* (  1) */
8d4e1d1e:	aa e6 1c 00 	B[P5 + 0x1c] = R2;
8d4e1d22:	e8 b0       	[P5 + 0xc] = R0;
8d4e1d24:	e2 2d       	JUMP.S 0x0x8d4e18e8;
8d4e1d26:	39 ad       	P1 = [FP + 0x10];
8d4e1d28:	88 a1       	R0 = [P1 + 0x18];
8d4e1d2a:	00 0c       	CC = R0 == 0x0;
8d4e1d2c:	06 10       	IF !CC JUMP 0x0x8d4e1d38;
8d4e1d2e:	39 ad       	P1 = [FP + 0x10];
8d4e1d30:	50 60       	R0 = 0xa (X);		/*		R0=0xdbff(56319) */
8d4e1d32:	ce b1       	[P1 + 0x1c] = R6;
8d4e1d34:	88 b1       	[P1 + 0x18] = R0;
8d4e1d36:	b5 2e       	JUMP.S 0x0x8d4e1aa0;
8d4e1d38:	00 da 03 84 	R0=-2080150884;
8d4e1d3c:	9c 6a 00 00 
8d4e1d40:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1d44:	d4 34 00 00 
8d4e1d48:	f3 2f       	JUMP.S 0x0x8d4e1d2e;
8d4e1d4a:	00 00       	NOP;
8d4e1d4c:	a9 e4 1c 00 	R1 = B[P5 + 0x1c] (Z);
8d4e1d50:	01 0c       	CC = R1 == 0x0;
8d4e1d52:	03 18       	IF CC JUMP 0x0x8d4e1d58;
8d4e1d54:	72 2d       	JUMP.S 0x0x8d4e1838;
8d4e1d56:	00 00       	NOP;
8d4e1d58:	03 c8 00 18 	MNOP || R7 = [P5 + 0x14] || R2 = [P5];
8d4e1d5c:	6f a1 2a 91 
8d4e1d60:	04 cc 3b 06 	R3 = R7 + R3 (NS) || [SP + 0xc] = R2 || R2 = [P5 + 0x8];
8d4e1d64:	f2 b0 aa a0 
8d4e1d68:	ab b1       	[P5 + 0x18] = R3;
8d4e1d6a:	09 60       	R1 = 0x1 (X);		/*		R1=0xdfff(57343) */
8d4e1d6c:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1d70:	bc 05 00 00 
8d4e1d74:	03 c8 00 18 	MNOP || R3 = [P5 + 0x4] || R7 = [P5 + 0x8];
8d4e1d78:	6b a0 af a0 
8d4e1d7c:	04 cc 18 04 	R2 = R3 + R0 (NS) || [P5 + 0x14] = R0 || NOP;
8d4e1d80:	68 b1 00 00 
8d4e1d84:	82 ce 02 c2 	R1 = ROT R2 BY 0x0 || [P5 + 0x10] = R3 || NOP;
8d4e1d88:	2b b1 00 00 
8d4e1d8c:	fa 67       	R2 += -0x1;		/* ( -1) */
8d4e1d8e:	b8 09       	CC = R0 < R7 (IU);
8d4e1d90:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0xc] = R2 || NOP;
8d4e1d94:	ea b0 00 00 
8d4e1d98:	0b 32       	P1 = R3;
8d4e1d9a:	02 1c       	IF CC JUMP 0x0x8d4e1d9e (BP);
8d4e1d9c:	4e 2d       	JUMP.S 0x0x8d4e1838;
8d4e1d9e:	09 32       	P1 = R1;
8d4e1da0:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1da2:	08 9b       	B[P1] = R0;
8d4e1da4:	03 c8 00 18 	MNOP || P1 = [P5 + 0x10] || R0 = [P5 + 0xc];
8d4e1da8:	29 ad e8 a0 
8d4e1dac:	08 64       	R0 += 0x1;		/* (  1) */
8d4e1dae:	aa e6 1c 00 	B[P5 + 0x1c] = R2;
8d4e1db2:	e8 b0       	[P5 + 0xc] = R0;
8d4e1db4:	42 2d       	JUMP.S 0x0x8d4e1838;
8d4e1db6:	27 08       	CC = R7 == R4;
8d4e1db8:	7d 18       	IF CC JUMP 0x0x8d4e1eb2;
8d4e1dba:	87 09       	CC = R7 < R0 (IU);
8d4e1dbc:	41 18       	IF CC JUMP 0x0x8d4e1e3e;
8d4e1dbe:	e9 a0       	R1 = [P5 + 0xc];
8d4e1dc0:	41 30       	R0 = P1;
8d4e1dc2:	88 09       	CC = R0 < R1 (IU);
8d4e1dc4:	08 10       	IF !CC JUMP 0x0x8d4e1dd4;
8d4e1dc6:	09 6c       	P1 += 0x1;		/* (  1) */
8d4e1dc8:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [P5 + 0x10] = P1 || NOP;
8d4e1dcc:	29 bd 00 00 
8d4e1dd0:	46 2d       	JUMP.S 0x0x8d4e185c;
8d4e1dd2:	00 00       	NOP;
8d4e1dd4:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e1dd8:	00 0c       	CC = R0 == 0x0;
8d4e1dda:	0f 30       	R1 = R7;
8d4e1ddc:	02 18       	IF CC JUMP 0x0x8d4e1de0;
8d4e1dde:	3f 2d       	JUMP.S 0x0x8d4e185c;
8d4e1de0:	03 c8 00 18 	MNOP || R2 = [P5 + 0x14] || R3 = [P5 + 0x18];
8d4e1de4:	6a a1 ab a1 
8d4e1de8:	04 cc 13 04 	R2 = R2 + R3 (NS) || R6 = [P5] || R0 = [P5 + 0x4];
8d4e1dec:	2e 91 68 a0 
8d4e1df0:	03 c8 00 18 	MNOP || [P5 + 0x18] = R2 || R2 = [P5 + 0x8];
8d4e1df4:	aa b1 aa a0 
8d4e1df8:	f6 b0       	[SP + 0xc] = R6;
8d4e1dfa:	09 60       	R1 = 0x1 (X);		/*		R1=0xdfff(57343) */
8d4e1dfc:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1e00:	bc 05 00 00 
8d4e1e04:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R6 = [P5 + 0x4] || R3 = [P5 + 0x8];
8d4e1e08:	6e a0 ab a0 
8d4e1e0c:	04 cc 30 04 	R2 = R6 + R0 (NS) || [P5 + 0x14] = R0 || NOP;
8d4e1e10:	68 b1 00 00 
8d4e1e14:	98 09       	CC = R0 < R3 (IU);
8d4e1e16:	0a 32       	P1 = R2;
8d4e1e18:	82 ce 02 c6 	R3 = ROT R2 BY 0x0 || [P5 + 0x10] = R6 || NOP;
8d4e1e1c:	2e b1 00 00 
8d4e1e20:	fb 67       	R3 += -0x1;		/* ( -1) */
8d4e1e22:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0xc] = R3 || NOP;
8d4e1e26:	eb b0 00 00 
8d4e1e2a:	02 1c       	IF CC JUMP 0x0x8d4e1e2e (BP);
8d4e1e2c:	18 2d       	JUMP.S 0x0x8d4e185c;
8d4e1e2e:	0b 60       	R3 = 0x1 (X);		/*		R3=0x0(  0) */
8d4e1e30:	08 9b       	B[P1] = R0;
8d4e1e32:	e8 a0       	R0 = [P5 + 0xc];
8d4e1e34:	08 64       	R0 += 0x1;		/* (  1) */
8d4e1e36:	ab e6 1c 00 	B[P5 + 0x1c] = R3;
8d4e1e3a:	e8 b0       	[P5 + 0xc] = R0;
8d4e1e3c:	10 2d       	JUMP.S 0x0x8d4e185c;
8d4e1e3e:	39 ad       	P1 = [FP + 0x10];
8d4e1e40:	07 0c       	CC = R7 == 0x0;
8d4e1e42:	88 a1       	R0 = [P1 + 0x18];
8d4e1e44:	1b 10       	IF !CC JUMP 0x0x8d4e1e7a;
8d4e1e46:	00 0c       	CC = R0 == 0x0;
8d4e1e48:	10 10       	IF !CC JUMP 0x0x8d4e1e68;
8d4e1e4a:	03 c8 00 18 	MNOP || P1 = [FP + 0x10] || R1 = [P5 + 0x10];
8d4e1e4e:	39 ad 29 a1 
8d4e1e52:	03 c8 00 18 	MNOP || R2 = [P5 + 0x4] || R3 = [P5 + 0x18];
8d4e1e56:	6a a0 ab a1 
8d4e1e5a:	51 52       	R1 = R1 - R2;
8d4e1e5c:	4b 50       	R1 = R3 + R1;
8d4e1e5e:	58 60       	R0 = 0xb (X);		/*		R0=0xdbff(56319) */
8d4e1e60:	c9 b1       	[P1 + 0x1c] = R1;
8d4e1e62:	88 b1       	[P1 + 0x18] = R0;
8d4e1e64:	1e 2e       	JUMP.S 0x0x8d4e1aa0;
8d4e1e66:	00 00       	NOP;
8d4e1e68:	00 da 03 84 	R0=-2080150808;
8d4e1e6c:	e8 6a 00 00 
8d4e1e70:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1e74:	d4 34 00 00 
8d4e1e78:	e9 2f       	JUMP.S 0x0x8d4e1e4a;
8d4e1e7a:	00 0c       	CC = R0 == 0x0;
8d4e1e7c:	12 10       	IF !CC JUMP 0x0x8d4e1ea0;
8d4e1e7e:	03 c8 00 18 	MNOP || P1 = [FP + 0x10] || R1 = [P5 + 0x10];
8d4e1e82:	39 ad 29 a1 
8d4e1e86:	03 c8 00 18 	MNOP || R2 = [P5 + 0x4] || R3 = [P5 + 0x18];
8d4e1e8a:	6a a0 ab a1 
8d4e1e8e:	51 52       	R1 = R1 - R2;
8d4e1e90:	4b 50       	R1 = R3 + R1;
8d4e1e92:	60 60       	R0 = 0xc (X);		/*		R0=0xdbff(56319) */
8d4e1e94:	c9 b1       	[P1 + 0x1c] = R1;
8d4e1e96:	88 b1       	[P1 + 0x18] = R0;
8d4e1e98:	04 2e       	JUMP.S 0x0x8d4e1aa0;
8d4e1e9a:	00 00       	NOP;
8d4e1e9c:	00 00       	NOP;
8d4e1e9e:	00 00       	NOP;
8d4e1ea0:	00 da 03 84 	R0=-2080150732;
8d4e1ea4:	34 6b 00 00 
8d4e1ea8:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1eac:	d4 34 00 00 
8d4e1eb0:	e7 2f       	JUMP.S 0x0x8d4e1e7e;
8d4e1eb2:	20 91       	R0 = [P4];
8d4e1eb4:	21 e4 ff ff 	R1 = [P4 + -0x4];
8d4e1eb8:	88 09       	CC = R0 < R1 (IU);
8d4e1eba:	0b 10       	IF !CC JUMP 0x0x8d4e1ed0;
8d4e1ebc:	08 64       	R0 += 0x1;		/* (  1) */
8d4e1ebe:	20 93       	[P4] = R0;
8d4e1ec0:	47 30       	R0 = FP;
8d4e1ec2:	40 64       	R0 += 0x8;		/* (  8) */
8d4e1ec4:	01 60       	R1 = 0x0 (X);		/*		R1=0xdfff(57343) */
8d4e1ec6:	ff e3 01 fc 	CALL 0x0x8d4e16c8;
8d4e1eca:	39 ad       	P1 = [FP + 0x10];
8d4e1ecc:	88 a1       	R0 = [P1 + 0x18];
8d4e1ece:	e9 2d       	JUMP.S 0x0x8d4e1aa0;
8d4e1ed0:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e1ed4:	00 0c       	CC = R0 == 0x0;
8d4e1ed6:	f5 17       	IF !CC JUMP 0x0x8d4e1ec0 (BP);
8d4e1ed8:	09 60       	R1 = 0x1 (X);		/*		R1=0xdfff(57343) */
8d4e1eda:	03 c8 00 18 	MNOP || R0 = [P5 + 0x14] || R2 = [P5 + 0x18];
8d4e1ede:	68 a1 aa a1 
8d4e1ee2:	04 cc 02 04 	R2 = R0 + R2 (NS) || R3 = [P5] || R0 = [P5 + 0x4];
8d4e1ee6:	2b 91 68 a0 
8d4e1eea:	f3 b0       	[SP + 0xc] = R3;
8d4e1eec:	03 c8 00 18 	MNOP || [P5 + 0x18] = R2 || R2 = [P5 + 0x8];
8d4e1ef0:	aa b1 aa a0 
8d4e1ef4:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1ef8:	bc 05 00 00 
8d4e1efc:	03 c8 00 18 	MNOP || R1 = [P5 + 0x4] || R2 = [P5 + 0x8];
8d4e1f00:	69 a0 aa a0 
8d4e1f04:	04 cc 08 02 	R1 = R1 + R0 (NS) || [P5 + 0x10] = R1 || NOP;
8d4e1f08:	29 b1 00 00 
8d4e1f0c:	90 09       	CC = R0 < R2 (IU);
8d4e1f0e:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || [P5 + 0x14] = R0 || NOP;
8d4e1f12:	68 b1 00 00 
8d4e1f16:	f9 67       	R1 += -0x1;		/* ( -1) */
8d4e1f18:	08 32       	P1 = R0;
8d4e1f1a:	04 cc 09 42 	R1 = R1 - R1 (NS) || [P5 + 0xc] = R1 || NOP;
8d4e1f1e:	e9 b0 00 00 
8d4e1f22:	cf 13       	IF !CC JUMP 0x0x8d4e1ec0;
8d4e1f24:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e1f26:	09 9b       	B[P1] = R1;
8d4e1f28:	e8 a0       	R0 = [P5 + 0xc];
8d4e1f2a:	08 64       	R0 += 0x1;		/* (  1) */
8d4e1f2c:	aa e6 1c 00 	B[P5 + 0x1c] = R2;
8d4e1f30:	e8 b0       	[P5 + 0xc] = R0;
8d4e1f32:	c7 2f       	JUMP.S 0x0x8d4e1ec0;
8d4e1f34:	a8 e4 1c 00 	R0 = B[P5 + 0x1c] (Z);
8d4e1f38:	00 0c       	CC = R0 == 0x0;
8d4e1f3a:	03 18       	IF CC JUMP 0x0x8d4e1f40;
8d4e1f3c:	61 2c       	JUMP.S 0x0x8d4e17fe;
8d4e1f3e:	00 00       	NOP;
8d4e1f40:	03 c8 00 18 	MNOP || R2 = [P5 + 0x14] || R3 = [P5 + 0x18];
8d4e1f44:	6a a1 ab a1 
8d4e1f48:	04 cc 13 04 	R2 = R2 + R3 (NS) || R6 = [P5] || R0 = [P5 + 0x4];
8d4e1f4c:	2e 91 68 a0 
8d4e1f50:	03 c8 00 18 	MNOP || [P5 + 0x18] = R2 || R2 = [P5 + 0x8];
8d4e1f54:	aa b1 aa a0 
8d4e1f58:	f6 b0       	[SP + 0xc] = R6;
8d4e1f5a:	09 60       	R1 = 0x1 (X);		/*		R1=0xdfff(57343) */
8d4e1f5c:	00 de ed 8f 	CALL.A 0x8fed05bc;
8d4e1f60:	bc 05 00 00 
8d4e1f64:	03 c8 00 18 	MNOP || R3 = [P5 + 0x4] || R6 = [P5 + 0x8];
8d4e1f68:	6b a0 ae a0 
8d4e1f6c:	04 cc 18 02 	R1 = R3 + R0 (NS) || [P5 + 0x14] = R0 || NOP;
8d4e1f70:	68 b1 00 00 
8d4e1f74:	82 ce 01 c4 	R2 = ROT R1 BY 0x0 || [P5 + 0x10] = R3 || NOP;
8d4e1f78:	2b b1 00 00 
8d4e1f7c:	09 32       	P1 = R1;
8d4e1f7e:	fa 67       	R2 += -0x1;		/* ( -1) */
8d4e1f80:	b0 09       	CC = R0 < R6 (IU);
8d4e1f82:	04 cc 00 40 	R0 = R0 - R0 (NS) || [P5 + 0xc] = R2 || NOP;
8d4e1f86:	ea b0 00 00 
8d4e1f8a:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8d4e1f8c:	02 1c       	IF CC JUMP 0x0x8d4e1f90 (BP);
8d4e1f8e:	38 2c       	JUMP.S 0x0x8d4e17fe;
8d4e1f90:	08 9b       	B[P1] = R0;
8d4e1f92:	af e6 1c 00 	B[P5 + 0x1c] = R7;
8d4e1f96:	e8 a0       	R0 = [P5 + 0xc];
8d4e1f98:	08 64       	R0 += 0x1;		/* (  1) */
8d4e1f9a:	e8 b0       	[P5 + 0xc] = R0;
8d4e1f9c:	31 2c       	JUMP.S 0x0x8d4e17fe;
8d4e1f9e:	00 00       	NOP;
8d4e1fa0:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d4e1fa4:	d4 34 00 00 
8d4e1fa8:	23 2c       	JUMP.S 0x0x8d4e17ee;
8d4e1faa:	00 00       	NOP;
8d4e1fac:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d4e1fb0:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e1fb2:	86 6f       	SP += -0x10;		/* (-16) */
8d4e1fb4:	05 60       	R5 = 0x0 (X);		/*		R5=0x5c( 92) */
8d4e1fb6:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4e1fba:	7f 30       	R7 = FP;
8d4e1fbc:	82 ce 02 cc 	R6 = ROT R2 BY 0x0 || [SP + 0x38] = R5 || NOP;
8d4e1fc0:	b5 b3 00 00 
8d4e1fc4:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
8d4e1fc6:	27 67       	R7 += -0x1c;		/* (-28) */
8d4e1fc8:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e1fcc:	b8 00 03 00 
8d4e1fd0:	28 32       	P5 = R0;
8d4e1fd2:	82 ce 00 c8 	R4 = ROT R0 BY 0x0 || [SP + 0x3c] = R2 || NOP;
8d4e1fd6:	f2 b3 00 00 
8d4e1fda:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4e1fde:	f3 b0 00 00 
8d4e1fe2:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4e1fe4:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e1fe8:	70 e9 00 00 
8d4e1fec:	07 30       	R0 = R7;
8d4e1fee:	16 30       	R2 = R6;
8d4e1ff0:	09 60       	R1 = 0x1 (X);		/*		R1=0xdfff(57343) */
8d4e1ff2:	00 de 03 8c 	CALL.A 0x8c03ea3c;
8d4e1ff6:	3c ea 00 00 
8d4e1ffa:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d4e1ffc:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [P5 + 0x14] = R5 || NOP;
8d4e2000:	6d b1 00 00 
8d4e2004:	ad e6 04 00 	B[P5 + 0x4] = R5;
8d4e2008:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [P5 + 0x18] = R3 || NOP;
8d4e200c:	ab b1 00 00 
8d4e2010:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2014:	b8 00 03 00 
8d4e2018:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e201c:	f3 b0 00 00 
8d4e2020:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2024:	70 e9 00 00 
8d4e2028:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e202a:	f0 a3       	R0 = [SP + 0x3c];
8d4e202c:	07 0a       	CC = R7 <= R0 (IU);
8d4e202e:	08 18       	IF CC JUMP 0x0x8d4e203e;
8d4e2030:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4e2034:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e2036:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e2038:	01 e8 00 00 	UNLINK;
8d4e203c:	10 00       	RTS;
8d4e203e:	b0 a2       	R0 = [SP + 0x28];
8d4e2040:	ff e3 d2 61 	CALL 0x0x8d4ce3e4;
8d4e2044:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4e2048:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e204a:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e204c:	01 e8 00 00 	UNLINK;
8d4e2050:	10 00       	RTS;
8d4e2052:	08 32       	P1 = R0;
8d4e2054:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e2058:	00 60       	R0 = 0x0 (X);		/*		R0=0xdbff(56319) */
8d4e205a:	79 60       	R1 = 0xf (X);		/*		R1=0xdfff(57343) */
8d4e205c:	89 b1       	[P1 + 0x18] = R1;
8d4e205e:	48 b1       	[P1 + 0x14] = R0;
8d4e2060:	88 e6 04 00 	B[P1 + 0x4] = R0;
8d4e2064:	08 b2       	[P1 + 0x20] = R0;
8d4e2066:	48 b2       	[P1 + 0x24] = R0;
8d4e2068:	88 b2       	[P1 + 0x28] = R0;
8d4e206a:	88 e6 2c 00 	B[P1 + 0x2c] = R0;
8d4e206e:	01 e8 00 00 	UNLINK;
8d4e2072:	10 00       	RTS;
8d4e2074:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4e2078:	82 ce 01 c0 	R0 = ROT R1 BY 0x0 || [SP + 0xc] = P5 || NOP;
8d4e207c:	f5 bc 00 00 
8d4e2080:	28 32       	P5 = R0;
8d4e2082:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e2084:	ff e3 ec bb 	CALL 0x0x8d4d985c;
8d4e2088:	80 60       	R0 = 0x10 (X);		/*		R0=0xdbff(56319) */
8d4e208a:	a9 a1       	R1 = [P5 + 0x18];
8d4e208c:	08 0a       	CC = R0 <= R1 (IU);
8d4e208e:	0b 18       	IF CC JUMP 0x0x8d4e20a4;
8d4e2090:	00 60       	R0 = 0x0 (X);		/*		R0=0xdbff(56319) */
8d4e2092:	68 b1       	[P5 + 0x14] = R0;
8d4e2094:	a8 e6 04 00 	B[P5 + 0x4] = R0;
8d4e2098:	78 60       	R0 = 0xf (X);		/*		R0=0xdbff(56319) */
8d4e209a:	a8 b1       	[P5 + 0x18] = R0;
8d4e209c:	f5 ac       	P5 = [SP + 0xc];
8d4e209e:	01 e8 00 00 	UNLINK;
8d4e20a2:	10 00       	RTS;
8d4e20a4:	68 a0       	R0 = [P5 + 0x4];
8d4e20a6:	ff e3 9f 61 	CALL 0x0x8d4ce3e4;
8d4e20aa:	00 60       	R0 = 0x0 (X);		/*		R0=0xdbff(56319) */
8d4e20ac:	68 b1       	[P5 + 0x14] = R0;
8d4e20ae:	a8 e6 04 00 	B[P5 + 0x4] = R0;
8d4e20b2:	78 60       	R0 = 0xf (X);		/*		R0=0xdbff(56319) */
8d4e20b4:	a8 b1       	[P5 + 0x18] = R0;
8d4e20b6:	f5 ac       	P5 = [SP + 0xc];
8d4e20b8:	01 e8 00 00 	UNLINK;
8d4e20bc:	10 00       	RTS;
8d4e20be:	00 00       	NOP;
8d4e20c0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e20c4:	ed 05       	[--SP] = (R7:5, P5:5);
8d4e20c6:	28 32       	P5 = R0;
8d4e20c8:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e20ca:	30 30       	R6 = R0;
8d4e20cc:	68 a0       	R0 = [P5 + 0x4];
8d4e20ce:	00 0c       	CC = R0 == 0x0;
8d4e20d0:	1a 18       	IF CC JUMP 0x0x8d4e2104;
8d4e20d2:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R5 = [P5 + 0x8] || NOP;
8d4e20d6:	ad a0 00 00 
8d4e20da:	28 08       	CC = R0 == R5;
8d4e20dc:	09 18       	IF CC JUMP 0x0x8d4e20ee;
8d4e20de:	0f 30       	R1 = R7;
8d4e20e0:	87 65       	R7 += 0x30;		/* ( 48) */
8d4e20e2:	06 30       	R0 = R6;
8d4e20e4:	ff e3 c8 ff 	CALL 0x0x8d4e2074;
8d4e20e8:	3d 08       	CC = R5 == R7;
8d4e20ea:	fa 17       	IF !CC JUMP 0x0x8d4e20de (BP);
8d4e20ec:	68 a0       	R0 = [P5 + 0x4];
8d4e20ee:	ff e3 7b 61 	CALL 0x0x8d4ce3e4;
8d4e20f2:	00 60       	R0 = 0x0 (X);		/*		R0=0xdbff(56319) */
8d4e20f4:	68 b0       	[P5 + 0x4] = R0;
8d4e20f6:	a8 b0       	[P5 + 0x8] = R0;
8d4e20f8:	e8 b0       	[P5 + 0xc] = R0;
8d4e20fa:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e20fc:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e20fe:	01 e8 00 00 	UNLINK;
8d4e2102:	10 00       	RTS;
8d4e2104:	00 60       	R0 = 0x0 (X);		/*		R0=0xdbff(56319) */
8d4e2106:	68 b0       	[P5 + 0x4] = R0;
8d4e2108:	a8 b0       	[P5 + 0x8] = R0;
8d4e210a:	e8 b0       	[P5 + 0xc] = R0;
8d4e210c:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e210e:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e2110:	01 e8 00 00 	UNLINK;
8d4e2114:	10 00       	RTS;
8d4e2116:	00 00       	NOP;
8d4e2118:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4e211c:	e3 05       	[--SP] = (R7:4, P5:3);
8d4e211e:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e2120:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [SP + 0x2c] = R0 || NOP;
8d4e2124:	f0 b2 00 00 
8d4e2128:	03 c8 00 18 	MNOP || P0 = [SP + 0x2c] || [SP + 0x34] = R2;
8d4e212c:	f0 ae 72 b3 
8d4e2130:	0c 60       	R4 = 0x1 (X);		/*		R4=0x0(  0) */
8d4e2132:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d4e2134:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8d4e2136:	40 ac       	P0 = [P0 + 0x4];
8d4e2138:	72 af       	P2 = [SP + 0x34];
8d4e213a:	f5 ae       	P5 = [SP + 0x2c];
8d4e213c:	03 91       	R3 = [P0];
8d4e213e:	0b 08       	CC = R3 == R1;
8d4e2140:	02 14       	IF !CC JUMP 0x0x8d4e2144 (BP);
8d4e2142:	47 22       	JUMP.S 0x0x8d4e25d0;
8d4e2144:	b9 b0       	[FP + 0x8] = R1;
8d4e2146:	b9 ac       	P1 = [FP + 0x8];
8d4e2148:	70 af       	P0 = [SP + 0x34];
8d4e214a:	41 08       	CC = P1 == P0;
8d4e214c:	02 14       	IF !CC JUMP 0x0x8d4e2150 (BP);
8d4e214e:	3a 22       	JUMP.S 0x0x8d4e25c2;
8d4e2150:	bd ac       	P5 = [FP + 0x8];
8d4e2152:	89 e5 2d 00 	R1 = B[P1 + 0x2d] (X);
8d4e2156:	01 0c       	CC = R1 == 0x0;
8d4e2158:	16 10       	IF !CC JUMP 0x0x8d4e2184;
8d4e215a:	ad ac       	P5 = [P5 + 0x8];
8d4e215c:	a8 e5 2d 00 	R0 = B[P5 + 0x2d] (X);
8d4e2160:	00 0c       	CC = R0 == 0x0;
8d4e2162:	02 1c       	IF CC JUMP 0x0x8d4e2166 (BP);
8d4e2164:	20 22       	JUMP.S 0x0x8d4e25a4;
8d4e2166:	69 91       	P1 = [P5];
8d4e2168:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e216c:	00 0c       	CC = R0 == 0x0;
8d4e216e:	0b 10       	IF !CC JUMP 0x0x8d4e2184;
8d4e2170:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4e217e) LC0 count_fields=0x0/0x0;
8d4e2174:	69 32       	P5 = P1;
8d4e2176:	69 91       	P1 = [P5];
8d4e2178:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e217c:	00 0c       	CC = R0 == 0x0;
8d4e217e:	03 10       	IF !CC JUMP 0x0x8d4e2184;
8d4e2180:	69 91       	P1 = [P5];
8d4e2182:	f7 2f       	JUMP.S 0x0x8d4e2170;
8d4e2184:	01 0c       	CC = R1 == 0x0;
8d4e2186:	b9 ac       	P1 = [FP + 0x8];
8d4e2188:	02 1c       	IF CC JUMP 0x0x8d4e218c (BP);
8d4e218a:	07 22       	JUMP.S 0x0x8d4e2598;
8d4e218c:	88 ac       	P0 = [P1 + 0x8];
8d4e218e:	bc ac       	P4 = [FP + 0x8];
8d4e2190:	81 e5 2d 00 	R1 = B[P0 + 0x2d] (X);
8d4e2194:	01 0c       	CC = R1 == 0x0;
8d4e2196:	64 91       	P4 = [P4];
8d4e2198:	02 1c       	IF CC JUMP 0x0x8d4e219c (BP);
8d4e219a:	ef 21       	JUMP.S 0x0x8d4e2578;
8d4e219c:	41 91       	P1 = [P0];
8d4e219e:	50 32       	P2 = P0;
8d4e21a0:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e21a4:	00 0c       	CC = R0 == 0x0;
8d4e21a6:	0b 10       	IF !CC JUMP 0x0x8d4e21bc;
8d4e21a8:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4e21b6) LC0 count_fields=0x0/0x0;
8d4e21ac:	51 32       	P2 = P1;
8d4e21ae:	51 91       	P1 = [P2];
8d4e21b0:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e21b4:	00 0c       	CC = R0 == 0x0;
8d4e21b6:	03 10       	IF !CC JUMP 0x0x8d4e21bc;
8d4e21b8:	51 91       	P1 = [P2];
8d4e21ba:	f7 2f       	JUMP.S 0x0x8d4e21a8;
8d4e21bc:	b9 ac       	P1 = [FP + 0x8];
8d4e21be:	a0 e5 2d 00 	R0 = B[P4 + 0x2d] (X);
8d4e21c2:	00 0c       	CC = R0 == 0x0;
8d4e21c4:	06 10       	IF !CC JUMP 0x0x8d4e21d0;
8d4e21c6:	01 0c       	CC = R1 == 0x0;
8d4e21c8:	44 32       	P0 = P4;
8d4e21ca:	03 10       	IF !CC JUMP 0x0x8d4e21d0;
8d4e21cc:	90 ac       	P0 = [P2 + 0x8];
8d4e21ce:	4a 32       	P1 = P2;
8d4e21d0:	ba ac       	P2 = [FP + 0x8];
8d4e21d2:	51 08       	CC = P1 == P2;
8d4e21d4:	7e 19       	IF CC JUMP 0x0x8d4e24d0;
8d4e21d6:	61 bc       	[P4 + 0x4] = P1;
8d4e21d8:	11 91       	R1 = [P2];
8d4e21da:	09 93       	[P1] = R1;
8d4e21dc:	91 a0       	R1 = [P2 + 0x8];
8d4e21de:	41 30       	R0 = P1;
8d4e21e0:	01 08       	CC = R1 == R0;
8d4e21e2:	51 32       	P2 = P1;
8d4e21e4:	0d 18       	IF CC JUMP 0x0x8d4e21fe;
8d4e21e6:	80 e5 2d 00 	R0 = B[P0 + 0x2d] (X);
8d4e21ea:	bc ac       	P4 = [FP + 0x8];
8d4e21ec:	00 0c       	CC = R0 == 0x0;
8d4e21ee:	4a ac       	P2 = [P1 + 0x4];
8d4e21f0:	02 10       	IF !CC JUMP 0x0x8d4e21f4;
8d4e21f2:	42 bc       	[P0 + 0x4] = P2;
8d4e21f4:	50 93       	[P2] = P0;
8d4e21f6:	a0 a0       	R0 = [P4 + 0x8];
8d4e21f8:	88 b0       	[P1 + 0x8] = R0;
8d4e21fa:	a4 ac       	P4 = [P4 + 0x8];
8d4e21fc:	61 bc       	[P4 + 0x4] = P1;
8d4e21fe:	03 c8 00 18 	MNOP || P4 = [SP + 0x2c] || R1 = [FP + 0x8];
8d4e2202:	f4 ae b9 a0 
8d4e2206:	63 ac       	P3 = [P4 + 0x4];
8d4e2208:	bc ac       	P4 = [FP + 0x8];
8d4e220a:	23 6c       	P3 += 0x4;		/* (  4) */
8d4e220c:	18 91       	R0 = [P3];
8d4e220e:	08 08       	CC = R0 == R1;
8d4e2210:	08 18       	IF CC JUMP 0x0x8d4e2220;
8d4e2212:	63 ac       	P3 = [P4 + 0x4];
8d4e2214:	18 91       	R0 = [P3];
8d4e2216:	63 32       	P4 = P3;
8d4e2218:	08 08       	CC = R0 == R1;
8d4e221a:	44 6c       	P4 += 0x8;		/* (  8) */
8d4e221c:	dc 06       	IF !CC P3 = P4;
8d4e221e:	3c bd       	[FP + 0x10] = P4;
8d4e2220:	bc ac       	P4 = [FP + 0x8];
8d4e2222:	59 93       	[P3] = P1;
8d4e2224:	60 a0       	R0 = [P4 + 0x4];
8d4e2226:	48 b0       	[P1 + 0x4] = R0;
8d4e2228:	88 e4 2c 00 	R0 = B[P1 + 0x2c] (Z);
8d4e222c:	a1 e4 2c 00 	R1 = B[P4 + 0x2c] (Z);
8d4e2230:	89 e6 2c 00 	B[P1 + 0x2c] = R1;
8d4e2234:	a0 e6 2c 00 	B[P4 + 0x2c] = R0;
8d4e2238:	b9 ac       	P1 = [FP + 0x8];
8d4e223a:	88 e5 2c 00 	R0 = B[P1 + 0x2c] (X);
8d4e223e:	08 0c       	CC = R0 == 0x1;
8d4e2240:	a1 10       	IF !CC JUMP 0x0x8d4e2382;
8d4e2242:	c0 e0 3d 00 	LSETUP_IMM(bottom=0x8d4e22bc) LC0 count_fields=0x0/0x0;
8d4e2246:	f1 ae       	P1 = [SP + 0x2c];
8d4e2248:	48 30       	R1 = P0;
8d4e224a:	49 ac       	P1 = [P1 + 0x4];
8d4e224c:	48 a0       	R0 = [P1 + 0x4];
8d4e224e:	08 08       	CC = R0 == R1;
8d4e2250:	97 18       	IF CC JUMP 0x0x8d4e237e;
8d4e2252:	80 e5 2c 00 	R0 = B[P0 + 0x2c] (X);
8d4e2256:	08 0c       	CC = R0 == 0x1;
8d4e2258:	93 10       	IF !CC JUMP 0x0x8d4e237e;
8d4e225a:	10 91       	R0 = [P2];
8d4e225c:	08 32       	P1 = R0;
8d4e225e:	08 08       	CC = R0 == R1;
8d4e2260:	aa 18       	IF CC JUMP 0x0x8d4e23b4;
8d4e2262:	88 e5 2c 00 	R0 = B[P1 + 0x2c] (X);
8d4e2266:	00 0c       	CC = R0 == 0x0;
8d4e2268:	24 10       	IF !CC JUMP 0x0x8d4e22b0;
8d4e226a:	8c e6 2c 00 	B[P1 + 0x2c] = R4;
8d4e226e:	54 91       	P4 = [P2];
8d4e2270:	95 e6 2c 00 	B[P2 + 0x2c] = R5;
8d4e2274:	a0 a0       	R0 = [P4 + 0x8];
8d4e2276:	10 93       	[P2] = R0;
8d4e2278:	a1 ac       	P1 = [P4 + 0x8];
8d4e227a:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e227e:	00 0c       	CC = R0 == 0x0;
8d4e2280:	02 10       	IF !CC JUMP 0x0x8d4e2284;
8d4e2282:	4a bc       	[P1 + 0x4] = P2;
8d4e2284:	03 c8 00 18 	MNOP || P1 = [SP + 0x2c] || R1 = [P2 + 0x4];
8d4e2288:	f1 ae 51 a0 
8d4e228c:	61 b0       	[P4 + 0x4] = R1;
8d4e228e:	42 30       	R0 = P2;
8d4e2290:	49 ac       	P1 = [P1 + 0x4];
8d4e2292:	21 6c       	P1 += 0x4;		/* (  4) */
8d4e2294:	09 91       	R1 = [P1];
8d4e2296:	01 08       	CC = R1 == R0;
8d4e2298:	08 18       	IF CC JUMP 0x0x8d4e22a8;
8d4e229a:	51 ac       	P1 = [P2 + 0x4];
8d4e229c:	39 bd       	[FP + 0x10] = P1;
8d4e229e:	3b ad       	P3 = [FP + 0x10];
8d4e22a0:	89 a0       	R1 = [P1 + 0x8];
8d4e22a2:	01 08       	CC = R1 == R0;
8d4e22a4:	41 6c       	P1 += 0x8;		/* (  8) */
8d4e22a6:	cb 06       	IF !CC P1 = P3;
8d4e22a8:	4c 93       	[P1] = P4;
8d4e22aa:	a2 bc       	[P4 + 0x8] = P2;
8d4e22ac:	51 91       	P1 = [P2];
8d4e22ae:	54 bc       	[P2 + 0x4] = P4;
8d4e22b0:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e22b4:	00 0c       	CC = R0 == 0x0;
8d4e22b6:	05 18       	IF CC JUMP 0x0x8d4e22c0;
8d4e22b8:	51 ac       	P1 = [P2 + 0x4];
8d4e22ba:	42 32       	P0 = P2;
8d4e22bc:	51 32       	P2 = P1;
8d4e22be:	c2 2f       	JUMP.S 0x0x8d4e2242;
8d4e22c0:	8c ac       	P4 = [P1 + 0x8];
8d4e22c2:	a0 e5 2c 00 	R0 = B[P4 + 0x2c] (X);
8d4e22c6:	08 0c       	CC = R0 == 0x1;
8d4e22c8:	09 10       	IF !CC JUMP 0x0x8d4e22da;
8d4e22ca:	4c 91       	P4 = [P1];
8d4e22cc:	a0 e5 2c 00 	R0 = B[P4 + 0x2c] (X);
8d4e22d0:	08 0c       	CC = R0 == 0x1;
8d4e22d2:	04 10       	IF !CC JUMP 0x0x8d4e22da;
8d4e22d4:	8d e6 2c 00 	B[P1 + 0x2c] = R5;
8d4e22d8:	f0 2f       	JUMP.S 0x0x8d4e22b8;
8d4e22da:	4c 91       	P4 = [P1];
8d4e22dc:	a0 e5 2c 00 	R0 = B[P4 + 0x2c] (X);
8d4e22e0:	08 0c       	CC = R0 == 0x1;
8d4e22e2:	27 10       	IF !CC JUMP 0x0x8d4e2330;
8d4e22e4:	8c ac       	P4 = [P1 + 0x8];
8d4e22e6:	a4 e6 2c 00 	B[P4 + 0x2c] = R4;
8d4e22ea:	8c ac       	P4 = [P1 + 0x8];
8d4e22ec:	8d e6 2c 00 	B[P1 + 0x2c] = R5;
8d4e22f0:	3c bd       	[FP + 0x10] = P4;
8d4e22f2:	20 91       	R0 = [P4];
8d4e22f4:	88 b0       	[P1 + 0x8] = R0;
8d4e22f6:	63 91       	P3 = [P4];
8d4e22f8:	98 e5 2d 00 	R0 = B[P3 + 0x2d] (X);
8d4e22fc:	00 0c       	CC = R0 == 0x0;
8d4e22fe:	02 10       	IF !CC JUMP 0x0x8d4e2302;
8d4e2300:	59 bc       	[P3 + 0x4] = P1;
8d4e2302:	03 c8 00 18 	MNOP || P3 = [SP + 0x2c] || R1 = [P1 + 0x4];
8d4e2306:	f3 ae 49 a0 
8d4e230a:	61 b0       	[P4 + 0x4] = R1;
8d4e230c:	41 30       	R0 = P1;
8d4e230e:	5b ac       	P3 = [P3 + 0x4];
8d4e2310:	23 6c       	P3 += 0x4;		/* (  4) */
8d4e2312:	19 91       	R1 = [P3];
8d4e2314:	01 08       	CC = R1 == R0;
8d4e2316:	08 18       	IF CC JUMP 0x0x8d4e2326;
8d4e2318:	4b ac       	P3 = [P1 + 0x4];
8d4e231a:	19 91       	R1 = [P3];
8d4e231c:	63 32       	P4 = P3;
8d4e231e:	01 08       	CC = R1 == R0;
8d4e2320:	44 6c       	P4 += 0x8;		/* (  8) */
8d4e2322:	dc 06       	IF !CC P3 = P4;
8d4e2324:	34 bf       	[SP + 0x30] = P4;
8d4e2326:	3c ad       	P4 = [FP + 0x10];
8d4e2328:	5c 93       	[P3] = P4;
8d4e232a:	61 93       	[P4] = P1;
8d4e232c:	4c bc       	[P1 + 0x4] = P4;
8d4e232e:	51 91       	P1 = [P2];
8d4e2330:	90 e4 2c 00 	R0 = B[P2 + 0x2c] (Z);
8d4e2334:	88 e6 2c 00 	B[P1 + 0x2c] = R0;
8d4e2338:	94 e6 2c 00 	B[P2 + 0x2c] = R4;
8d4e233c:	49 91       	P1 = [P1];
8d4e233e:	8c e6 2c 00 	B[P1 + 0x2c] = R4;
8d4e2342:	54 91       	P4 = [P2];
8d4e2344:	a0 a0       	R0 = [P4 + 0x8];
8d4e2346:	10 93       	[P2] = R0;
8d4e2348:	a1 ac       	P1 = [P4 + 0x8];
8d4e234a:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e234e:	00 0c       	CC = R0 == 0x0;
8d4e2350:	02 10       	IF !CC JUMP 0x0x8d4e2354;
8d4e2352:	4a bc       	[P1 + 0x4] = P2;
8d4e2354:	03 c8 00 18 	MNOP || P1 = [SP + 0x2c] || R1 = [P2 + 0x4];
8d4e2358:	f1 ae 51 a0 
8d4e235c:	61 b0       	[P4 + 0x4] = R1;
8d4e235e:	42 30       	R0 = P2;
8d4e2360:	49 ac       	P1 = [P1 + 0x4];
8d4e2362:	21 6c       	P1 += 0x4;		/* (  4) */
8d4e2364:	09 91       	R1 = [P1];
8d4e2366:	01 08       	CC = R1 == R0;
8d4e2368:	08 18       	IF CC JUMP 0x0x8d4e2378;
8d4e236a:	51 ac       	P1 = [P2 + 0x4];
8d4e236c:	39 bd       	[FP + 0x10] = P1;
8d4e236e:	3b ad       	P3 = [FP + 0x10];
8d4e2370:	41 6c       	P1 += 0x8;		/* (  8) */
8d4e2372:	09 91       	R1 = [P1];
8d4e2374:	01 08       	CC = R1 == R0;
8d4e2376:	cb 06       	IF !CC P1 = P3;
8d4e2378:	4c 93       	[P1] = P4;
8d4e237a:	a2 bc       	[P4 + 0x8] = P2;
8d4e237c:	54 bc       	[P2 + 0x4] = P4;
8d4e237e:	84 e6 2c 00 	B[P0 + 0x2c] = R4;
8d4e2382:	b9 ac       	P1 = [FP + 0x8];
8d4e2384:	f3 ae       	P3 = [SP + 0x2c];
8d4e2386:	88 a2       	R0 = [P1 + 0x28];
8d4e2388:	06 0a       	CC = R6 <= R0 (IU);
8d4e238a:	11 18       	IF CC JUMP 0x0x8d4e23ac;
8d4e238c:	b8 ac       	P0 = [FP + 0x8];
8d4e238e:	b9 ac       	P1 = [FP + 0x8];
8d4e2390:	87 b2       	[P0 + 0x28] = R7;
8d4e2392:	45 b2       	[P0 + 0x24] = R5;
8d4e2394:	85 e6 14 00 	B[P0 + 0x14] = R5;
8d4e2398:	41 30       	R0 = P1;
8d4e239a:	ff e3 25 60 	CALL 0x0x8d4ce3e4;
8d4e239e:	98 a0       	R0 = [P3 + 0x8];
8d4e23a0:	00 0c       	CC = R0 == 0x0;
8d4e23a2:	03 18       	IF CC JUMP 0x0x8d4e23a8;
8d4e23a4:	f8 67       	R0 += -0x1;		/* ( -1) */
8d4e23a6:	98 b0       	[P3 + 0x8] = R0;
8d4e23a8:	bd bc       	[FP + 0x8] = P5;
8d4e23aa:	ce 2e       	JUMP.S 0x0x8d4e2146;
8d4e23ac:	48 a1       	R0 = [P1 + 0x14];
8d4e23ae:	ff e3 1b 60 	CALL 0x0x8d4ce3e4;
8d4e23b2:	ed 2f       	JUMP.S 0x0x8d4e238c;
8d4e23b4:	91 ac       	P1 = [P2 + 0x8];
8d4e23b6:	88 e5 2c 00 	R0 = B[P1 + 0x2c] (X);
8d4e23ba:	00 0c       	CC = R0 == 0x0;
8d4e23bc:	26 10       	IF !CC JUMP 0x0x8d4e2408;
8d4e23be:	8c e6 2c 00 	B[P1 + 0x2c] = R4;
8d4e23c2:	91 ac       	P1 = [P2 + 0x8];
8d4e23c4:	95 e6 2c 00 	B[P2 + 0x2c] = R5;
8d4e23c8:	b1 be       	[SP + 0x28] = P1;
8d4e23ca:	08 91       	R0 = [P1];
8d4e23cc:	90 b0       	[P2 + 0x8] = R0;
8d4e23ce:	4c 91       	P4 = [P1];
8d4e23d0:	a0 e5 2d 00 	R0 = B[P4 + 0x2d] (X);
8d4e23d4:	00 0c       	CC = R0 == 0x0;
8d4e23d6:	02 10       	IF !CC JUMP 0x0x8d4e23da;
8d4e23d8:	62 bc       	[P4 + 0x4] = P2;
8d4e23da:	51 a0       	R1 = [P2 + 0x4];
8d4e23dc:	03 c8 00 18 	MNOP || P1 = [SP + 0x2c] || [P1 + 0x4] = R1;
8d4e23e0:	f1 ae 49 b0 
8d4e23e4:	42 30       	R0 = P2;
8d4e23e6:	49 ac       	P1 = [P1 + 0x4];
8d4e23e8:	21 6c       	P1 += 0x4;		/* (  4) */
8d4e23ea:	09 91       	R1 = [P1];
8d4e23ec:	01 08       	CC = R1 == R0;
8d4e23ee:	08 18       	IF CC JUMP 0x0x8d4e23fe;
8d4e23f0:	54 ac       	P4 = [P2 + 0x4];
8d4e23f2:	21 91       	R1 = [P4];
8d4e23f4:	4c 32       	P1 = P4;
8d4e23f6:	01 08       	CC = R1 == R0;
8d4e23f8:	44 6c       	P4 += 0x8;		/* (  8) */
8d4e23fa:	cc 06       	IF !CC P1 = P4;
8d4e23fc:	3c bd       	[FP + 0x10] = P4;
8d4e23fe:	b4 ae       	P4 = [SP + 0x28];
8d4e2400:	4c 93       	[P1] = P4;
8d4e2402:	62 93       	[P4] = P2;
8d4e2404:	91 ac       	P1 = [P2 + 0x8];
8d4e2406:	54 bc       	[P2 + 0x4] = P4;
8d4e2408:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e240c:	00 0c       	CC = R0 == 0x0;
8d4e240e:	55 13       	IF !CC JUMP 0x0x8d4e22b8;
8d4e2410:	4c 91       	P4 = [P1];
8d4e2412:	a0 e5 2c 00 	R0 = B[P4 + 0x2c] (X);
8d4e2416:	08 0c       	CC = R0 == 0x1;
8d4e2418:	09 10       	IF !CC JUMP 0x0x8d4e242a;
8d4e241a:	8c ac       	P4 = [P1 + 0x8];
8d4e241c:	a0 e5 2c 00 	R0 = B[P4 + 0x2c] (X);
8d4e2420:	08 0c       	CC = R0 == 0x1;
8d4e2422:	04 10       	IF !CC JUMP 0x0x8d4e242a;
8d4e2424:	8d e6 2c 00 	B[P1 + 0x2c] = R5;
8d4e2428:	48 2f       	JUMP.S 0x0x8d4e22b8;
8d4e242a:	8c ac       	P4 = [P1 + 0x8];
8d4e242c:	a0 e5 2c 00 	R0 = B[P4 + 0x2c] (X);
8d4e2430:	08 0c       	CC = R0 == 0x1;
8d4e2432:	27 10       	IF !CC JUMP 0x0x8d4e2480;
8d4e2434:	4c 91       	P4 = [P1];
8d4e2436:	a4 e6 2c 00 	B[P4 + 0x2c] = R4;
8d4e243a:	4c 91       	P4 = [P1];
8d4e243c:	8d e6 2c 00 	B[P1 + 0x2c] = R5;
8d4e2440:	3c bd       	[FP + 0x10] = P4;
8d4e2442:	a0 a0       	R0 = [P4 + 0x8];
8d4e2444:	08 93       	[P1] = R0;
8d4e2446:	a3 ac       	P3 = [P4 + 0x8];
8d4e2448:	98 e5 2d 00 	R0 = B[P3 + 0x2d] (X);
8d4e244c:	00 0c       	CC = R0 == 0x0;
8d4e244e:	02 10       	IF !CC JUMP 0x0x8d4e2452;
8d4e2450:	59 bc       	[P3 + 0x4] = P1;
8d4e2452:	03 c8 00 18 	MNOP || P3 = [SP + 0x2c] || R1 = [P1 + 0x4];
8d4e2456:	f3 ae 49 a0 
8d4e245a:	61 b0       	[P4 + 0x4] = R1;
8d4e245c:	41 30       	R0 = P1;
8d4e245e:	5c ac       	P4 = [P3 + 0x4];
8d4e2460:	24 6c       	P4 += 0x4;		/* (  4) */
8d4e2462:	21 91       	R1 = [P4];
8d4e2464:	01 08       	CC = R1 == R0;
8d4e2466:	08 18       	IF CC JUMP 0x0x8d4e2476;
8d4e2468:	4c ac       	P4 = [P1 + 0x4];
8d4e246a:	34 bf       	[SP + 0x30] = P4;
8d4e246c:	33 af       	P3 = [SP + 0x30];
8d4e246e:	44 6c       	P4 += 0x8;		/* (  8) */
8d4e2470:	21 91       	R1 = [P4];
8d4e2472:	01 08       	CC = R1 == R0;
8d4e2474:	e3 06       	IF !CC P4 = P3;
8d4e2476:	3b ad       	P3 = [FP + 0x10];
8d4e2478:	63 93       	[P4] = P3;
8d4e247a:	99 bc       	[P3 + 0x8] = P1;
8d4e247c:	4b bc       	[P1 + 0x4] = P3;
8d4e247e:	91 ac       	P1 = [P2 + 0x8];
8d4e2480:	90 e4 2c 00 	R0 = B[P2 + 0x2c] (Z);
8d4e2484:	88 e6 2c 00 	B[P1 + 0x2c] = R0;
8d4e2488:	94 e6 2c 00 	B[P2 + 0x2c] = R4;
8d4e248c:	89 ac       	P1 = [P1 + 0x8];
8d4e248e:	8c e6 2c 00 	B[P1 + 0x2c] = R4;
8d4e2492:	93 ac       	P3 = [P2 + 0x8];
8d4e2494:	18 91       	R0 = [P3];
8d4e2496:	90 b0       	[P2 + 0x8] = R0;
8d4e2498:	59 91       	P1 = [P3];
8d4e249a:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e249e:	00 0c       	CC = R0 == 0x0;
8d4e24a0:	02 10       	IF !CC JUMP 0x0x8d4e24a4;
8d4e24a2:	4a bc       	[P1 + 0x4] = P2;
8d4e24a4:	03 c8 00 18 	MNOP || P1 = [SP + 0x2c] || R1 = [P2 + 0x4];
8d4e24a8:	f1 ae 51 a0 
8d4e24ac:	59 b0       	[P3 + 0x4] = R1;
8d4e24ae:	42 30       	R0 = P2;
8d4e24b0:	4c ac       	P4 = [P1 + 0x4];
8d4e24b2:	24 6c       	P4 += 0x4;		/* (  4) */
8d4e24b4:	21 91       	R1 = [P4];
8d4e24b6:	01 08       	CC = R1 == R0;
8d4e24b8:	08 18       	IF CC JUMP 0x0x8d4e24c8;
8d4e24ba:	54 ac       	P4 = [P2 + 0x4];
8d4e24bc:	21 91       	R1 = [P4];
8d4e24be:	4c 32       	P1 = P4;
8d4e24c0:	01 08       	CC = R1 == R0;
8d4e24c2:	41 6c       	P1 += 0x8;		/* (  8) */
8d4e24c4:	e1 06       	IF !CC P4 = P1;
8d4e24c6:	39 bd       	[FP + 0x10] = P1;
8d4e24c8:	63 93       	[P4] = P3;
8d4e24ca:	5a 93       	[P3] = P2;
8d4e24cc:	53 bc       	[P2 + 0x4] = P3;
8d4e24ce:	58 2f       	JUMP.S 0x0x8d4e237e;
8d4e24d0:	03 c8 00 18 	MNOP || P1 = [SP + 0x2c] || R1 = [FP + 0x8];
8d4e24d4:	f1 ae b9 a0 
8d4e24d8:	80 e5 2d 00 	R0 = B[P0 + 0x2d] (X);
8d4e24dc:	00 0c       	CC = R0 == 0x0;
8d4e24de:	52 ac       	P2 = [P2 + 0x4];
8d4e24e0:	02 10       	IF !CC JUMP 0x0x8d4e24e4;
8d4e24e2:	42 bc       	[P0 + 0x4] = P2;
8d4e24e4:	4c ac       	P4 = [P1 + 0x4];
8d4e24e6:	24 6c       	P4 += 0x4;		/* (  4) */
8d4e24e8:	20 91       	R0 = [P4];
8d4e24ea:	08 08       	CC = R0 == R1;
8d4e24ec:	07 18       	IF CC JUMP 0x0x8d4e24fa;
8d4e24ee:	10 91       	R0 = [P2];
8d4e24f0:	08 08       	CC = R0 == R1;
8d4e24f2:	4a 32       	P1 = P2;
8d4e24f4:	62 32       	P4 = P2;
8d4e24f6:	41 6c       	P1 += 0x8;		/* (  8) */
8d4e24f8:	e1 06       	IF !CC P4 = P1;
8d4e24fa:	f1 ae       	P1 = [SP + 0x2c];
8d4e24fc:	60 93       	[P4] = P0;
8d4e24fe:	f3 ae       	P3 = [SP + 0x2c];
8d4e2500:	49 ac       	P1 = [P1 + 0x4];
8d4e2502:	39 bd       	[FP + 0x10] = P1;
8d4e2504:	62 32       	P4 = P2;
8d4e2506:	08 91       	R0 = [P1];
8d4e2508:	08 08       	CC = R0 == R1;
8d4e250a:	1d 18       	IF CC JUMP 0x0x8d4e2544;
8d4e250c:	39 ad       	P1 = [FP + 0x10];
8d4e250e:	88 a0       	R0 = [P1 + 0x8];
8d4e2510:	08 08       	CC = R0 == R1;
8d4e2512:	93 16       	IF !CC JUMP 0x0x8d4e2238 (BP);
8d4e2514:	80 e5 2d 00 	R0 = B[P0 + 0x2d] (X);
8d4e2518:	00 0c       	CC = R0 == 0x0;
8d4e251a:	62 32       	P4 = P2;
8d4e251c:	11 10       	IF !CC JUMP 0x0x8d4e253e;
8d4e251e:	81 ac       	P1 = [P0 + 0x8];
8d4e2520:	60 32       	P4 = P0;
8d4e2522:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e2526:	00 0c       	CC = R0 == 0x0;
8d4e2528:	0b 10       	IF !CC JUMP 0x0x8d4e253e;
8d4e252a:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4e2538) LC0 count_fields=0x0/0x0;
8d4e252e:	61 32       	P4 = P1;
8d4e2530:	a1 ac       	P1 = [P4 + 0x8];
8d4e2532:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e2536:	00 0c       	CC = R0 == 0x0;
8d4e2538:	03 10       	IF !CC JUMP 0x0x8d4e253e;
8d4e253a:	a1 ac       	P1 = [P4 + 0x8];
8d4e253c:	f7 2f       	JUMP.S 0x0x8d4e252a;
8d4e253e:	39 ad       	P1 = [FP + 0x10];
8d4e2540:	8c bc       	[P1 + 0x8] = P4;
8d4e2542:	7b 2e       	JUMP.S 0x0x8d4e2238;
8d4e2544:	80 e5 2d 00 	R0 = B[P0 + 0x2d] (X);
8d4e2548:	00 0c       	CC = R0 == 0x0;
8d4e254a:	11 10       	IF !CC JUMP 0x0x8d4e256c;
8d4e254c:	41 91       	P1 = [P0];
8d4e254e:	60 32       	P4 = P0;
8d4e2550:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e2554:	00 0c       	CC = R0 == 0x0;
8d4e2556:	0b 10       	IF !CC JUMP 0x0x8d4e256c;
8d4e2558:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4e2566) LC0 count_fields=0x0/0x0;
8d4e255c:	61 32       	P4 = P1;
8d4e255e:	61 91       	P1 = [P4];
8d4e2560:	88 e5 2d 00 	R0 = B[P1 + 0x2d] (X);
8d4e2564:	00 0c       	CC = R0 == 0x0;
8d4e2566:	03 10       	IF !CC JUMP 0x0x8d4e256c;
8d4e2568:	61 91       	P1 = [P4];
8d4e256a:	f7 2f       	JUMP.S 0x0x8d4e2558;
8d4e256c:	39 ad       	P1 = [FP + 0x10];
8d4e256e:	4c 93       	[P1] = P4;
8d4e2570:	59 ac       	P1 = [P3 + 0x4];
8d4e2572:	39 bd       	[FP + 0x10] = P1;
8d4e2574:	cc 2f       	JUMP.S 0x0x8d4e250c;
8d4e2576:	00 00       	NOP;
8d4e2578:	c0 e0 0d 00 	LSETUP_IMM(bottom=0x8d4e2592) LC0 count_fields=0x0/0x0;
8d4e257c:	4a ac       	P2 = [P1 + 0x4];
8d4e257e:	90 e5 2d 00 	R0 = B[P2 + 0x2d] (X);
8d4e2582:	00 0c       	CC = R0 == 0x0;
8d4e2584:	02 1c       	IF CC JUMP 0x0x8d4e2588 (BP);
8d4e2586:	1b 2e       	JUMP.S 0x0x8d4e21bc;
8d4e2588:	41 30       	R0 = P1;
8d4e258a:	92 a0       	R2 = [P2 + 0x8];
8d4e258c:	02 08       	CC = R2 == R0;
8d4e258e:	02 1c       	IF CC JUMP 0x0x8d4e2592 (BP);
8d4e2590:	16 2e       	JUMP.S 0x0x8d4e21bc;
8d4e2592:	4a 32       	P1 = P2;
8d4e2594:	f2 2f       	JUMP.S 0x0x8d4e2578;
8d4e2596:	00 00       	NOP;
8d4e2598:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4e259c:	24 2b 00 00 
8d4e25a0:	00 00       	NOP;
8d4e25a2:	00 00       	NOP;
8d4e25a4:	c0 e0 0d 00 	LSETUP_IMM(bottom=0x8d4e25be) LC0 count_fields=0x0/0x0;
8d4e25a8:	4d ac       	P5 = [P1 + 0x4];
8d4e25aa:	a8 e5 2d 00 	R0 = B[P5 + 0x2d] (X);
8d4e25ae:	00 0c       	CC = R0 == 0x0;
8d4e25b0:	02 1c       	IF CC JUMP 0x0x8d4e25b4 (BP);
8d4e25b2:	e9 2d       	JUMP.S 0x0x8d4e2184;
8d4e25b4:	41 30       	R0 = P1;
8d4e25b6:	aa a0       	R2 = [P5 + 0x8];
8d4e25b8:	02 08       	CC = R2 == R0;
8d4e25ba:	02 1c       	IF CC JUMP 0x0x8d4e25be (BP);
8d4e25bc:	e4 2d       	JUMP.S 0x0x8d4e2184;
8d4e25be:	4d 32       	P1 = P5;
8d4e25c0:	f2 2f       	JUMP.S 0x0x8d4e25a4;
8d4e25c2:	f9 bc       	[FP + 0xc] = P1;
8d4e25c4:	f8 a0       	R0 = [FP + 0xc];
8d4e25c6:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e25c8:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e25ca:	01 e8 00 00 	UNLINK;
8d4e25ce:	10 00       	RTS;
8d4e25d0:	50 08       	CC = P0 == P2;
8d4e25d2:	03 18       	IF CC JUMP 0x0x8d4e25d8;
8d4e25d4:	b8 2d       	JUMP.S 0x0x8d4e2144;
8d4e25d6:	00 00       	NOP;
8d4e25d8:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R1 = [P0 + 0x4] || NOP;
8d4e25dc:	41 a0 00 00 
8d4e25e0:	ff e3 4e bc 	CALL 0x0x8d4d9e7c;
8d4e25e4:	f1 ae       	P1 = [SP + 0x2c];
8d4e25e6:	49 ac       	P1 = [P1 + 0x4];
8d4e25e8:	49 bc       	[P1 + 0x4] = P1;
8d4e25ea:	03 c8 00 18 	MNOP || P1 = [P5 + 0x4] || [P5 + 0x8] = R7;
8d4e25ee:	69 ac af b0 
8d4e25f2:	49 93       	[P1] = P1;
8d4e25f4:	69 ac       	P1 = [P5 + 0x4];
8d4e25f6:	89 bc       	[P1 + 0x8] = P1;
8d4e25f8:	69 ac       	P1 = [P5 + 0x4];
8d4e25fa:	08 91       	R0 = [P1];
8d4e25fc:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e25fe:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e2600:	01 e8 00 00 	UNLINK;
8d4e2604:	10 00       	RTS;
8d4e2606:	00 00       	NOP;
8d4e2608:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e260c:	ed 05       	[--SP] = (R7:5, P5:5);
8d4e260e:	28 32       	P5 = R0;
8d4e2610:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e2612:	25 e1 54 00 	R5 = 0x54 (X);		/*		R5=0x54( 84) */
8d4e2616:	68 a0       	R0 = [P5 + 0x4];
8d4e2618:	00 0c       	CC = R0 == 0x0;
8d4e261a:	19 18       	IF CC JUMP 0x0x8d4e264c;
8d4e261c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R6 = [P5 + 0x8] || NOP;
8d4e2620:	ae a0 00 00 
8d4e2624:	30 08       	CC = R0 == R6;
8d4e2626:	08 18       	IF CC JUMP 0x0x8d4e2636;
8d4e2628:	07 30       	R0 = R7;
8d4e262a:	ff e3 af f6 	CALL 0x0x8d4e1388;
8d4e262e:	ef 51       	R7 = R7 + R5;
8d4e2630:	3e 08       	CC = R6 == R7;
8d4e2632:	fb 17       	IF !CC JUMP 0x0x8d4e2628 (BP);
8d4e2634:	68 a0       	R0 = [P5 + 0x4];
8d4e2636:	ff e3 d7 5e 	CALL 0x0x8d4ce3e4;
8d4e263a:	00 60       	R0 = 0x0 (X);		/*		R0=0xdbff(56319) */
8d4e263c:	68 b0       	[P5 + 0x4] = R0;
8d4e263e:	a8 b0       	[P5 + 0x8] = R0;
8d4e2640:	e8 b0       	[P5 + 0xc] = R0;
8d4e2642:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e2644:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e2646:	01 e8 00 00 	UNLINK;
8d4e264a:	10 00       	RTS;
8d4e264c:	00 60       	R0 = 0x0 (X);		/*		R0=0xdbff(56319) */
8d4e264e:	68 b0       	[P5 + 0x4] = R0;
8d4e2650:	a8 b0       	[P5 + 0x8] = R0;
8d4e2652:	e8 b0       	[P5 + 0xc] = R0;
8d4e2654:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e2656:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e2658:	01 e8 00 00 	UNLINK;
8d4e265c:	10 00       	RTS;
8d4e265e:	00 00       	NOP;
8d4e2660:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e2664:	ed 05       	[--SP] = (R7:5, P5:5);
8d4e2666:	2a 32       	P5 = R2;
8d4e2668:	38 30       	R7 = R0;
8d4e266a:	01 30       	R0 = R1;
8d4e266c:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e266e:	01 da 03 84 	R1=-2080149280;
8d4e2672:	e0 70 00 00 
8d4e2676:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4e267a:	88 bf 00 00 
8d4e267e:	00 0c       	CC = R0 == 0x0;
8d4e2680:	10 18       	IF CC JUMP 0x0x8d4e26a0;
8d4e2682:	03 c8 00 18 	MNOP || R6 = [P5 + 0x4] || R5 = [P5 + 0x8];
8d4e2686:	6e a0 ad a0 
8d4e268a:	2e 08       	CC = R6 == R5;
8d4e268c:	0a 18       	IF CC JUMP 0x0x8d4e26a0;
8d4e268e:	0e 30       	R1 = R6;
8d4e2690:	e6 64       	R6 += 0x1c;		/* ( 28) */
8d4e2692:	07 30       	R0 = R7;
8d4e2694:	00 de 03 8c 	CALL.A 0x8c03fd94;
8d4e2698:	94 fd 00 00 
8d4e269c:	35 08       	CC = R5 == R6;
8d4e269e:	f8 17       	IF !CC JUMP 0x0x8d4e268e (BP);
8d4e26a0:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e26a2:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e26a4:	01 e8 00 00 	UNLINK;
8d4e26a8:	10 00       	RTS;
8d4e26aa:	00 00       	NOP;
8d4e26ac:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e26b0:	60 05       	[--SP] = (R7:4);
8d4e26b2:	2a 30       	R5 = R2;
8d4e26b4:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e26b6:	29 08       	CC = R1 == R5;
8d4e26b8:	82 ce 00 c8 	R4 = ROT R0 BY 0x0 || R0 = [SP + 0x30] || R6 = [SP + 0x30];
8d4e26bc:	30 a3 36 a3 
8d4e26c0:	0f 18       	IF CC JUMP 0x0x8d4e26de;
8d4e26c2:	39 30       	R7 = R1;
8d4e26c4:	17 30       	R2 = R7;
8d4e26c6:	e7 64       	R7 += 0x1c;		/* ( 28) */
8d4e26c8:	0e 30       	R1 = R6;
8d4e26ca:	e6 64       	R6 += 0x1c;		/* ( 28) */
8d4e26cc:	04 30       	R0 = R4;
8d4e26ce:	00 de 03 8c 	CALL.A 0x8c03fcda;
8d4e26d2:	da fc 00 00 
8d4e26d6:	3d 08       	CC = R5 == R7;
8d4e26d8:	17 30       	R2 = R7;
8d4e26da:	f6 17       	IF !CC JUMP 0x0x8d4e26c6 (BP);
8d4e26dc:	06 30       	R0 = R6;
8d4e26de:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e26e0:	20 05       	(R7:4) = [SP++];
8d4e26e2:	01 e8 00 00 	UNLINK;
8d4e26e6:	10 00       	RTS;
8d4e26e8:	00 e8 01 00 	LINK 0x4;		/* (4) */
8d4e26ec:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e26ee:	28 32       	P5 = R0;
8d4e26f0:	86 6f       	SP += -0x10;		/* (-16) */
8d4e26f2:	82 ce 02 ce 	R7 = ROT R2 BY 0x0 || R5 = [SP + 0x3c] || [SP + 0x34] = R1;
8d4e26f6:	f5 a3 71 b3 
8d4e26fa:	04 cc 2a 4a 	R5 = R5 - R2 (NS) || [SP + 0x30] = R1 || NOP;
8d4e26fe:	31 b3 00 00 
8d4e2702:	04 da 49 92 	R4=-1840700269;
8d4e2706:	93 24 00 00 
8d4e270a:	31 cb ac 20 	R2 = R5 * R4 (M,T) || R1 = [P5 + 0x4] || NOP;
8d4e270e:	69 a0 00 00 
8d4e2712:	fd 4d       	R5 >>>= 0x1f;
8d4e2714:	22 4d       	R2 >>>= 0x4;
8d4e2716:	01 0c       	CC = R1 == 0x0;
8d4e2718:	6a 53       	R5 = R2 - R5;
8d4e271a:	30 30       	R6 = R0;
8d4e271c:	03 60       	R3 = 0x0 (X);		/*		R3=0x0(  0) */
8d4e271e:	09 18       	IF CC JUMP 0x0x8d4e2730;
8d4e2720:	ea a0       	R2 = [P5 + 0xc];
8d4e2722:	8a 52       	R2 = R2 - R1;
8d4e2724:	82 c6 0a 07 	R3 = R2 >>> 0x1f;
8d4e2728:	31 c3 94 20 	R2 = R2 * R4 (M,T);
8d4e272c:	22 4d       	R2 >>>= 0x4;
8d4e272e:	da 52       	R3 = R2 - R3;
8d4e2730:	05 0c       	CC = R5 == 0x0;
8d4e2732:	3f 18       	IF CC JUMP 0x0x8d4e27b0;
8d4e2734:	aa a0       	R2 = [P5 + 0x8];
8d4e2736:	04 cc 11 42 	R1 = R2 - R1 (NS) || [SP + 0x24] = R2 || NOP;
8d4e273a:	72 b2 00 00 
8d4e273e:	82 c6 09 05 	R2 = R1 >>> 0x1f;
8d4e2742:	31 c3 4c 20 	R1 = R1 * R4 (M,T);
8d4e2746:	21 4d       	R1 >>>= 0x4;
8d4e2748:	51 52       	R1 = R1 - R2;
8d4e274a:	02 da 24 09 	R2=153391689;
8d4e274e:	49 92 00 00 
8d4e2752:	8a 52       	R2 = R2 - R1;
8d4e2754:	aa 09       	CC = R2 < R5 (IU);
8d4e2756:	8d 18       	IF CC JUMP 0x0x8d4e2870;
8d4e2758:	04 cc 29 02 	R1 = R5 + R1 (NS) || R2 = [SP + 0x3c] || NOP;
8d4e275c:	f2 a3 00 00 
8d4e2760:	8b 09       	CC = R3 < R1 (IU);
8d4e2762:	2d 18       	IF CC JUMP 0x0x8d4e27bc;
8d4e2764:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R3 = [SP + 0x24] || NOP;
8d4e2768:	73 a2 00 00 
8d4e276c:	f3 b0       	[SP + 0xc] = R3;
8d4e276e:	ff e3 9f ff 	CALL 0x0x8d4e26ac;
8d4e2772:	e4 60       	R4 = 0x1c (X);		/*		R4=0x0(  0) */
8d4e2774:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R2 = [P5 + 0x8] || R1 = [SP + 0x30];
8d4e2778:	aa a0 31 a3 
8d4e277c:	00 de 0a 8c 	CALL.A 0x8c0ad60c;
8d4e2780:	0c d6 00 00 
8d4e2784:	71 ca ec 21 	R7 = R5 * R4 (IS,NS) || R1 = [P5 + 0x8] || NOP;
8d4e2788:	a9 a0 00 00 
8d4e278c:	b9 50       	R2 = R1 + R7;
8d4e278e:	06 30       	R0 = R6;
8d4e2790:	00 de 0a 8c 	CALL.A 0x8c0ad60c;
8d4e2794:	0c d6 00 00 
8d4e2798:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R2 = [P5 + 0x8] || R1 = [SP + 0x30];
8d4e279c:	aa a0 31 a3 
8d4e27a0:	ba 50       	R2 = R2 + R7;
8d4e27a2:	00 de 0a 8c 	CALL.A 0x8c0ad60c;
8d4e27a6:	0c d6 00 00 
8d4e27aa:	a8 a0       	R0 = [P5 + 0x8];
8d4e27ac:	38 50       	R0 = R0 + R7;
8d4e27ae:	a8 b0       	[P5 + 0x8] = R0;
8d4e27b0:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e27b2:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e27b4:	01 e8 00 00 	UNLINK;
8d4e27b8:	10 00       	RTS;
8d4e27ba:	00 00       	NOP;
8d4e27bc:	82 c6 fb 85 	R2 = R3 >> 0x1;
8d4e27c0:	00 da 24 09 	R0=153391689;
8d4e27c4:	49 92 00 00 
8d4e27c8:	10 52       	R0 = R0 - R2;
8d4e27ca:	98 09       	CC = R0 < R3 (IU);
8d4e27cc:	93 50       	R2 = R3 + R2;
8d4e27ce:	03 60       	R3 = 0x0 (X);		/*		R3=0x0(  0) */
8d4e27d0:	1a 06       	IF !CC R3 = R2;
8d4e27d2:	8b 09       	CC = R3 < R1 (IU);
8d4e27d4:	19 07       	IF CC R3 = R1;
8d4e27d6:	e1 60       	R1 = 0x1c (X);		/*		R1=0xdfff(57343) */
8d4e27d8:	d9 40       	R1 *= R3;
8d4e27da:	b1 b3       	[SP + 0x38] = R1;
8d4e27dc:	b0 a3       	R0 = [SP + 0x38];
8d4e27de:	ff e3 fb 5d 	CALL 0x0x8d4ce3d4;
8d4e27e2:	03 c8 00 18 	MNOP || [SP + 0xc] = R0 || R1 = [P5 + 0x4];
8d4e27e6:	f0 b0 69 a0 
8d4e27ea:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0x30] = R0 || R2 = [SP + 0x34];
8d4e27ee:	30 b3 72 a3 
8d4e27f2:	00 de 03 8c 	CALL.A 0x8c03fd50;
8d4e27f6:	50 fd 00 00 
8d4e27fa:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = R0 || R2 = [SP + 0x3c];
8d4e27fe:	f0 b0 f2 a3 
8d4e2802:	06 30       	R0 = R6;
8d4e2804:	ff e3 54 ff 	CALL 0x0x8d4e26ac;
8d4e2808:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R0 || R2 = [P5 + 0x8];
8d4e280c:	f0 b0 aa a0 
8d4e2810:	71 a3       	R1 = [SP + 0x34];
8d4e2812:	00 de 03 8c 	CALL.A 0x8c03fd50;
8d4e2816:	50 fd 00 00 
8d4e281a:	03 c8 00 18 	MNOP || R1 = [P5 + 0x4] || R2 = [P5 + 0x8];
8d4e281e:	69 a0 aa a0 
8d4e2822:	0a 52       	R0 = R2 - R1;
8d4e2824:	82 c6 08 0f 	R7 = R0 >>> 0x1f;
8d4e2828:	31 c3 c4 20 	R3 = R0 * R4 (M,T);
8d4e282c:	23 4d       	R3 >>>= 0x4;
8d4e282e:	3b 52       	R0 = R3 - R7;
8d4e2830:	01 0c       	CC = R1 == 0x0;
8d4e2832:	c5 51       	R7 = R5 + R0;
8d4e2834:	09 18       	IF CC JUMP 0x0x8d4e2846;
8d4e2836:	06 30       	R0 = R6;
8d4e2838:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e283c:	a4 f9 00 00 
8d4e2840:	68 a0       	R0 = [P5 + 0x4];
8d4e2842:	ff e3 d1 5d 	CALL 0x0x8d4ce3e4;
8d4e2846:	e0 60       	R0 = 0x1c (X);		/*		R0=0xdbff(56319) */
8d4e2848:	03 c8 00 18 	MNOP || R3 = [SP + 0x30] || R6 = [SP + 0x38];
8d4e284c:	33 a3 b6 a3 
8d4e2850:	71 ca 38 20 	R0 = R7 * R0 (IS,NS) || [P5 + 0x4] = R3 || NOP;
8d4e2854:	6b b0 00 00 
8d4e2858:	73 50       	R1 = R3 + R6;
8d4e285a:	04 cc 18 00 	R0 = R3 + R0 (NS) || [P5 + 0xc] = R1 || NOP;
8d4e285e:	e9 b0 00 00 
8d4e2862:	a8 b0       	[P5 + 0x8] = R0;
8d4e2864:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e2866:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e2868:	01 e8 00 00 	UNLINK;
8d4e286c:	10 00       	RTS;
8d4e286e:	00 00       	NOP;
8d4e2870:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4e2874:	24 2b 00 00 
8d4e2878:	08 32       	P1 = R0;
8d4e287a:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4e287e:	82 ce 01 c4 	R2 = ROT R1 BY 0x0 || [SP + 0xc] = R2 || NOP;
8d4e2882:	f2 b0 00 00 
8d4e2886:	01 60       	R1 = 0x0 (X);		/*		R1=0xdfff(57343) */
8d4e2888:	49 b0       	[P1 + 0x4] = R1;
8d4e288a:	89 b0       	[P1 + 0x8] = R1;
8d4e288c:	c9 b0       	[P1 + 0xc] = R1;
8d4e288e:	ff e3 2d ff 	CALL 0x0x8d4e26e8;
8d4e2892:	01 e8 00 00 	UNLINK;
8d4e2896:	10 00       	RTS;
8d4e2898:	00 e8 17 00 	LINK 0x5c;		/* (92) */
8d4e289c:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e289e:	28 32       	P5 = R0;
8d4e28a0:	86 6f       	SP += -0x10;		/* (-16) */
8d4e28a2:	82 ce 02 cc 	R6 = ROT R2 BY 0x0 || [SP + 0x28] = R2 || NOP;
8d4e28a6:	b2 b2 00 00 
8d4e28aa:	39 30       	R7 = R1;
8d4e28ac:	03 60       	R3 = 0x0 (X);		/*		R3=0x0(  0) */
8d4e28ae:	6d a0       	R5 = [P5 + 0x4];
8d4e28b0:	05 0c       	CC = R5 == 0x0;
8d4e28b2:	0e 18       	IF CC JUMP 0x0x8d4e28ce;
8d4e28b4:	e8 a0       	R0 = [P5 + 0xc];
8d4e28b6:	a8 52       	R2 = R0 - R5;
8d4e28b8:	00 da c3 30 	R0=818089009;
8d4e28bc:	31 0c 00 00 
8d4e28c0:	79 c2 10 20 	(R1:0) = R2 * R0 (IS,NS);
8d4e28c4:	82 c6 e1 01 	R0 = R1 >>> 0x4;
8d4e28c8:	82 c6 0a 03 	R1 = R2 >>> 0x1f;
8d4e28cc:	c8 52       	R3 = R0 - R1;
8d4e28ce:	b0 a2       	R0 = [SP + 0x28];
8d4e28d0:	00 0c       	CC = R0 == 0x0;
8d4e28d2:	be 18       	IF CC JUMP 0x0x8d4e2a4e;
8d4e28d4:	ac a0       	R4 = [P5 + 0x8];
8d4e28d6:	6c 53       	R5 = R4 - R5;
8d4e28d8:	00 da c3 30 	R0=818089009;
8d4e28dc:	31 0c 00 00 
8d4e28e0:	79 c2 28 20 	(R1:0) = R5 * R0 (IS,NS);
8d4e28e4:	82 ce 0d 05 	R2 = R5 >>> 0x1f || R5 = [SP + 0x28] || NOP;
8d4e28e8:	b5 a2 00 00 
8d4e28ec:	82 c6 e1 01 	R0 = R1 >>> 0x4;
8d4e28f0:	90 52       	R2 = R0 - R2;
8d4e28f2:	01 da 0c 03 	R1=51130563;
8d4e28f6:	c3 30 00 00 
8d4e28fa:	11 52       	R0 = R1 - R2;
8d4e28fc:	a8 09       	CC = R0 < R5 (IU);
8d4e28fe:	02 14       	IF !CC JUMP 0x0x8d4e2902 (BP);
8d4e2900:	ec 21       	JUMP.S 0x0x8d4e2cd8;
8d4e2902:	95 50       	R2 = R5 + R2;
8d4e2904:	93 09       	CC = R3 < R2 (IU);
8d4e2906:	63 19       	IF CC JUMP 0x0x8d4e2bcc;
8d4e2908:	04 cc 27 46 	R3 = R4 - R7 (NS) || R4 = [SP + 0x28] || NOP;
8d4e290c:	b4 a2 00 00 
8d4e2910:	00 da c3 30 	R0=818089009;
8d4e2914:	31 0c 00 00 
8d4e2918:	79 c2 18 20 	(R1:0) = R3 * R0 (IS,NS);
8d4e291c:	82 c6 0b 0d 	R6 = R3 >>> 0x1f;
8d4e2920:	82 ce e1 01 	R0 = R1 >>> 0x4 || R1 = [FP + 0x14] || NOP;
8d4e2924:	79 a1 00 00 
8d4e2928:	04 cc 06 40 	R0 = R0 - R6 (NS) || R6 = [SP + 0x28] || NOP;
8d4e292c:	b6 a2 00 00 
8d4e2930:	a8 09       	CC = R0 < R5 (IU);
8d4e2932:	56 30       	R2 = SP;
8d4e2934:	92 10       	IF !CC JUMP 0x0x8d4e2a58;
8d4e2936:	63 61       	R3 = 0x2c (X);		/*		R3=0x0(  0) */
8d4e2938:	04 cc 13 04 	R2 = R2 + R3 (NS) || R1 = [FP + 0x14] || NOP;
8d4e293c:	79 a1 00 00 
8d4e2940:	3a b1       	[FP + 0x10] = R2;
8d4e2942:	25 e1 54 00 	R5 = 0x54 (X);		/*		R5=0x54( 84) */
8d4e2946:	38 a1       	R0 = [FP + 0x10];
8d4e2948:	ff e3 d2 f4 	CALL 0x0x8d4e12ec;
8d4e294c:	71 ca e5 20 	R3 = R4 * R5 (IS,NS) || R6 = [P5 + 0x8] || NOP;
8d4e2950:	ae a0 00 00 
8d4e2954:	37 08       	CC = R7 == R6;
8d4e2956:	82 ce 07 c8 	R4 = ROT R7 BY 0x0 || [FP + 0x8] = R3 || NOP;
8d4e295a:	bb b0 00 00 
8d4e295e:	0c 18       	IF CC JUMP 0x0x8d4e2976;
8d4e2960:	b8 a0       	R0 = [FP + 0x8];
8d4e2962:	04 50       	R0 = R4 + R0;
8d4e2964:	00 0c       	CC = R0 == 0x0;
8d4e2966:	04 18       	IF CC JUMP 0x0x8d4e296e;
8d4e2968:	0c 30       	R1 = R4;
8d4e296a:	ff e3 c1 f4 	CALL 0x0x8d4e12ec;
8d4e296e:	2c 51       	R4 = R4 + R5;
8d4e2970:	26 08       	CC = R6 == R4;
8d4e2972:	f7 17       	IF !CC JUMP 0x0x8d4e2960 (BP);
8d4e2974:	ae a0       	R6 = [P5 + 0x8];
8d4e2976:	04 cc 37 44 	R2 = R6 - R7 (NS) || R4 = [SP + 0x28] || NOP;
8d4e297a:	b4 a2 00 00 
8d4e297e:	00 da c3 30 	R0=818089009;
8d4e2982:	31 0c 00 00 
8d4e2986:	79 c2 10 20 	(R1:0) = R2 * R0 (IS,NS);
8d4e298a:	82 c6 0a 07 	R3 = R2 >>> 0x1f;
8d4e298e:	82 c6 e1 01 	R0 = R1 >>> 0x4;
8d4e2992:	58 52       	R1 = R0 - R3;
8d4e2994:	0c 52       	R0 = R4 - R1;
8d4e2996:	00 0c       	CC = R0 == 0x0;
8d4e2998:	1a 18       	IF CC JUMP 0x0x8d4e29cc;
8d4e299a:	b0 a2       	R0 = [SP + 0x28];
8d4e299c:	f8 67       	R0 += -0x1;		/* ( -1) */
8d4e299e:	08 53       	R4 = R0 - R1;
8d4e29a0:	04 0c       	CC = R4 == 0x0;
8d4e29a2:	0d 18       	IF CC JUMP 0x0x8d4e29bc;
8d4e29a4:	06 0c       	CC = R6 == 0x0;
8d4e29a6:	07 18       	IF CC JUMP 0x0x8d4e29b4;
8d4e29a8:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d4e29ac:	39 a1 00 00 
8d4e29b0:	ff e3 9e f4 	CALL 0x0x8d4e12ec;
8d4e29b4:	fc 67       	R4 += -0x1;		/* ( -1) */
8d4e29b6:	04 0c       	CC = R4 == 0x0;
8d4e29b8:	ae 51       	R6 = R6 + R5;
8d4e29ba:	f5 17       	IF !CC JUMP 0x0x8d4e29a4 (BP);
8d4e29bc:	06 0c       	CC = R6 == 0x0;
8d4e29be:	07 18       	IF CC JUMP 0x0x8d4e29cc;
8d4e29c0:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d4e29c4:	39 a1 00 00 
8d4e29c8:	ff e3 92 f4 	CALL 0x0x8d4e12ec;
8d4e29cc:	82 ce 07 cc 	R6 = ROT R7 BY 0x0 || R4 = [P5 + 0x8] || R0 = [FP + 0x8];
8d4e29d0:	ac a0 b8 a0 
8d4e29d4:	04 50       	R0 = R4 + R0;
8d4e29d6:	3c 08       	CC = R4 == R7;
8d4e29d8:	a8 b0       	[P5 + 0x8] = R0;
8d4e29da:	32 18       	IF CC JUMP 0x0x8d4e2a3e;
8d4e29dc:	e7 64       	R7 += 0x1c;		/* ( 28) */
8d4e29de:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e29e2:	b8 00 03 00 
8d4e29e6:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R3 || R1 = [FP + 0x10];
8d4e29ea:	f3 b0 39 a1 
8d4e29ee:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4e29f0:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e29f4:	70 e9 00 00 
8d4e29f8:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e29fc:	b8 00 03 00 
8d4e2a00:	4f 30       	R1 = FP;
8d4e2a02:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4e2a06:	f3 b0 00 00 
8d4e2a0a:	41 66       	R1 += -0x38;		/* (-56) */
8d4e2a0c:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4e2a0e:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2a12:	70 e9 00 00 
8d4e2a16:	07 30       	R0 = R7;
8d4e2a18:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2a1c:	b8 00 03 00 
8d4e2a20:	4f 30       	R1 = FP;
8d4e2a22:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e2a26:	f3 b0 00 00 
8d4e2a2a:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e2a2c:	21 67       	R1 += -0x1c;		/* (-28) */
8d4e2a2e:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2a32:	70 e9 00 00 
8d4e2a36:	ae 51       	R6 = R6 + R5;
8d4e2a38:	34 08       	CC = R4 == R6;
8d4e2a3a:	ef 51       	R7 = R7 + R5;
8d4e2a3c:	d1 17       	IF !CC JUMP 0x0x8d4e29de (BP);
8d4e2a3e:	38 a1       	R0 = [FP + 0x10];
8d4e2a40:	ff e3 a4 f4 	CALL 0x0x8d4e1388;
8d4e2a44:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e2a46:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e2a48:	01 e8 00 00 	UNLINK;
8d4e2a4c:	10 00       	RTS;
8d4e2a4e:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e2a50:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e2a52:	01 e8 00 00 	UNLINK;
8d4e2a56:	10 00       	RTS;
8d4e2a58:	63 61       	R3 = 0x2c (X);		/*		R3=0x0(  0) */
8d4e2a5a:	9a 50       	R2 = R2 + R3;
8d4e2a5c:	3a b1       	[FP + 0x10] = R2;
8d4e2a5e:	25 e1 54 00 	R5 = 0x54 (X);		/*		R5=0x54( 84) */
8d4e2a62:	ee 40       	R6 *= R5;
8d4e2a64:	b6 b2       	[SP + 0x28] = R6;
8d4e2a66:	38 a1       	R0 = [FP + 0x10];
8d4e2a68:	ff e3 42 f4 	CALL 0x0x8d4e12ec;
8d4e2a6c:	a9 a0       	R1 = [P5 + 0x8];
8d4e2a6e:	04 cc 0e 44 	R2 = R1 - R6 (NS) || [SP + 0x24] = R1 || NOP;
8d4e2a72:	71 b2 00 00 
8d4e2a76:	03 c8 00 18 	MNOP || [FP + 0x8] = R2 || R6 = [SP + 0x24];
8d4e2a7a:	ba b0 76 a2 
8d4e2a7e:	11 08       	CC = R1 == R2;
8d4e2a80:	bc a0       	R4 = [FP + 0x8];
8d4e2a82:	70 a2       	R0 = [SP + 0x24];
8d4e2a84:	12 18       	IF CC JUMP 0x0x8d4e2aa8;
8d4e2a86:	28 50       	R0 = R0 + R5;
8d4e2a88:	06 0c       	CC = R6 == 0x0;
8d4e2a8a:	f8 b0       	[FP + 0xc] = R0;
8d4e2a8c:	05 18       	IF CC JUMP 0x0x8d4e2a96;
8d4e2a8e:	0c 30       	R1 = R4;
8d4e2a90:	06 30       	R0 = R6;
8d4e2a92:	ff e3 2d f4 	CALL 0x0x8d4e12ec;
8d4e2a96:	04 cc 25 08 	R4 = R4 + R5 (NS) || R1 = [SP + 0x24] || R0 = [FP + 0xc];
8d4e2a9a:	71 a2 f8 a0 
8d4e2a9e:	21 08       	CC = R1 == R4;
8d4e2aa0:	ae 51       	R6 = R6 + R5;
8d4e2aa2:	28 50       	R0 = R0 + R5;
8d4e2aa4:	f2 17       	IF !CC JUMP 0x0x8d4e2a88 (BP);
8d4e2aa6:	f8 a0       	R0 = [FP + 0xc];
8d4e2aa8:	03 c8 00 18 	MNOP || R1 = [FP + 0x8] || [P5 + 0x8] = R0;
8d4e2aac:	b9 a0 a8 b0 
8d4e2ab0:	39 08       	CC = R1 == R7;
8d4e2ab2:	48 18       	IF CC JUMP 0x0x8d4e2b42;
8d4e2ab4:	03 c8 00 18 	MNOP || R6 = [FP + 0x8] || R1 = [SP + 0x24];
8d4e2ab8:	be a0 71 a2 
8d4e2abc:	20 e1 ac ff 	R0 = -0x54 (X);		/*		R0=0xffffffac(-84) */
8d4e2ac0:	04 cc 08 08 	R4 = R1 + R0 (NS) || R3 = [FP + 0x8] || NOP;
8d4e2ac4:	bb a0 00 00 
8d4e2ac8:	46 66       	R6 += -0x38;		/* (-56) */
8d4e2aca:	21 e1 ac ff 	R1 = -0x54 (X);		/*		R1=0xffffffac(-84) */
8d4e2ace:	cb 50       	R3 = R3 + R1;
8d4e2ad0:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP + 0x8] = R3 || NOP;
8d4e2ad4:	bb b0 00 00 
8d4e2ad8:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4e2adc:	b8 00 02 00 
8d4e2ae0:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R2 || NOP;
8d4e2ae4:	f2 b0 00 00 
8d4e2ae8:	b9 a0       	R1 = [FP + 0x8];
8d4e2aea:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2aee:	70 e9 00 00 
8d4e2af2:	04 30       	R0 = R4;
8d4e2af4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2af8:	b8 00 03 00 
8d4e2afc:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4e2b00:	f3 b0 00 00 
8d4e2b04:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e2b06:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4e2b08:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2b0c:	70 e9 00 00 
8d4e2b10:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2b14:	b8 00 03 00 
8d4e2b18:	22 e1 ac ff 	R2 = -0x54 (X);		/*		R2=0xffffffac(-84) */
8d4e2b1c:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4e2b20:	f3 b0 00 00 
8d4e2b24:	0e 30       	R1 = R6;
8d4e2b26:	23 e1 ac ff 	R3 = -0x54 (X);		/*		R3=0xffffffac(-84) */
8d4e2b2a:	96 51       	R6 = R6 + R2;
8d4e2b2c:	c0 65       	R0 += 0x38;		/* ( 56) */
8d4e2b2e:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4e2b30:	02 60       	R2 = 0x0 (X);		/*		R2=0xffffffac(-84) */
8d4e2b32:	1c 51       	R4 = R4 + R3;
8d4e2b34:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2b38:	70 e9 00 00 
8d4e2b3c:	bb a0       	R3 = [FP + 0x8];
8d4e2b3e:	1f 08       	CC = R7 == R3;
8d4e2b40:	c5 17       	IF !CC JUMP 0x0x8d4e2aca (BP);
8d4e2b42:	82 ce 07 cc 	R6 = ROT R7 BY 0x0 || R0 = [SP + 0x28] || NOP;
8d4e2b46:	b0 a2 00 00 
8d4e2b4a:	07 50       	R0 = R7 + R0;
8d4e2b4c:	07 08       	CC = R7 == R0;
8d4e2b4e:	b0 b2       	[SP + 0x28] = R0;
8d4e2b50:	35 18       	IF CC JUMP 0x0x8d4e2bba;
8d4e2b52:	e6 64       	R6 += 0x1c;		/* ( 28) */
8d4e2b54:	e4 60       	R4 = 0x1c (X);		/*		R4=0x0(  0) */
8d4e2b56:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2b5a:	b8 00 03 00 
8d4e2b5e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R3 || R1 = [FP + 0x10];
8d4e2b62:	f3 b0 39 a1 
8d4e2b66:	02 60       	R2 = 0x0 (X);		/*		R2=0xffffffac(-84) */
8d4e2b68:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2b6c:	70 e9 00 00 
8d4e2b70:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2b74:	b8 00 03 00 
8d4e2b78:	4f 30       	R1 = FP;
8d4e2b7a:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4e2b7e:	f3 b0 00 00 
8d4e2b82:	41 66       	R1 += -0x38;		/* (-56) */
8d4e2b84:	02 60       	R2 = 0x0 (X);		/*		R2=0xffffffac(-84) */
8d4e2b86:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2b8a:	70 e9 00 00 
8d4e2b8e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2b92:	b8 00 03 00 
8d4e2b96:	4f 30       	R1 = FP;
8d4e2b98:	04 cc 34 00 	R0 = R6 + R4 (NS) || [SP + 0xc] = R3 || NOP;
8d4e2b9c:	f3 b0 00 00 
8d4e2ba0:	21 67       	R1 += -0x1c;		/* (-28) */
8d4e2ba2:	02 60       	R2 = 0x0 (X);		/*		R2=0xffffffac(-84) */
8d4e2ba4:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2ba8:	70 e9 00 00 
8d4e2bac:	04 cc 3d 0e 	R7 = R7 + R5 (NS) || R3 = [SP + 0x28] || NOP;
8d4e2bb0:	b3 a2 00 00 
8d4e2bb4:	3b 08       	CC = R3 == R7;
8d4e2bb6:	ae 51       	R6 = R6 + R5;
8d4e2bb8:	cf 17       	IF !CC JUMP 0x0x8d4e2b56 (BP);
8d4e2bba:	38 a1       	R0 = [FP + 0x10];
8d4e2bbc:	ff e3 e6 f3 	CALL 0x0x8d4e1388;
8d4e2bc0:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e2bc2:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e2bc4:	01 e8 00 00 	UNLINK;
8d4e2bc8:	10 00       	RTS;
8d4e2bca:	00 00       	NOP;
8d4e2bcc:	82 c6 fb 8b 	R5 = R3 >> 0x1;
8d4e2bd0:	29 52       	R0 = R1 - R5;
8d4e2bd2:	98 09       	CC = R0 < R3 (IU);
8d4e2bd4:	6b 51       	R5 = R3 + R5;
8d4e2bd6:	01 60       	R1 = 0x0 (X);		/*		R1=0xffffffac(-84) */
8d4e2bd8:	0d 06       	IF !CC R1 = R5;
8d4e2bda:	91 09       	CC = R1 < R2 (IU);
8d4e2bdc:	0a 07       	IF CC R1 = R2;
8d4e2bde:	24 e1 54 00 	R4 = 0x54 (X);		/*		R4=0x54( 84) */
8d4e2be2:	e1 40       	R1 *= R4;
8d4e2be4:	39 b1       	[FP + 0x10] = R1;
8d4e2be6:	38 a1       	R0 = [FP + 0x10];
8d4e2be8:	ff e3 f6 5b 	CALL 0x0x8d4ce3d4;
8d4e2bec:	03 c8 00 18 	MNOP || [FP + 0x8] = R0 || R5 = [P5 + 0x4];
8d4e2bf0:	b8 b0 6d a0 
8d4e2bf4:	3d 08       	CC = R5 == R7;
8d4e2bf6:	04 cc 04 00 	R0 = R0 + R4 (NS) || [SP + 0x24] = R0 || R1 = [FP + 0x8];
8d4e2bfa:	70 b2 b9 a0 
8d4e2bfe:	19 18       	IF CC JUMP 0x0x8d4e2c30;
8d4e2c00:	f9 b0       	[FP + 0xc] = R1;
8d4e2c02:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || [SP + 0x24] = R0;
8d4e2c06:	f9 a0 70 b2 
8d4e2c0a:	01 0c       	CC = R1 == 0x0;
8d4e2c0c:	07 18       	IF CC JUMP 0x0x8d4e2c1a;
8d4e2c0e:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4e2c12:	f8 a0 00 00 
8d4e2c16:	ff e3 6b f3 	CALL 0x0x8d4e12ec;
8d4e2c1a:	04 cc 2c 0a 	R5 = R5 + R4 (NS) || R1 = [FP + 0xc] || R0 = [SP + 0x24];
8d4e2c1e:	f9 a0 70 a2 
8d4e2c22:	61 50       	R1 = R1 + R4;
8d4e2c24:	2f 08       	CC = R7 == R5;
8d4e2c26:	04 cc 04 00 	R0 = R0 + R4 (NS) || [FP + 0xc] = R1 || NOP;
8d4e2c2a:	f9 b0 00 00 
8d4e2c2e:	ea 17       	IF !CC JUMP 0x0x8d4e2c02 (BP);
8d4e2c30:	75 a2       	R5 = [SP + 0x24];
8d4e2c32:	05 0c       	CC = R5 == 0x0;
8d4e2c34:	07 18       	IF CC JUMP 0x0x8d4e2c42;
8d4e2c36:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || R1 = [FP + 0x14] || NOP;
8d4e2c3a:	79 a1 00 00 
8d4e2c3e:	ff e3 57 f3 	CALL 0x0x8d4e12ec;
8d4e2c42:	fe 67       	R6 += -0x1;		/* ( -1) */
8d4e2c44:	06 0c       	CC = R6 == 0x0;
8d4e2c46:	04 cc 2c 0a 	R5 = R5 + R4 (NS) || R0 = [SP + 0x28] || NOP;
8d4e2c4a:	b0 a2 00 00 
8d4e2c4e:	f2 17       	IF !CC JUMP 0x0x8d4e2c32 (BP);
8d4e2c50:	ae a0       	R6 = [P5 + 0x8];
8d4e2c52:	71 ca 04 20 	R0 = R0 * R4 (IS,NS) || R1 = [SP + 0x24] || NOP;
8d4e2c56:	71 a2 00 00 
8d4e2c5a:	37 08       	CC = R7 == R6;
8d4e2c5c:	41 51       	R5 = R1 + R0;
8d4e2c5e:	0c 18       	IF CC JUMP 0x0x8d4e2c76;
8d4e2c60:	05 0c       	CC = R5 == 0x0;
8d4e2c62:	05 18       	IF CC JUMP 0x0x8d4e2c6c;
8d4e2c64:	0f 30       	R1 = R7;
8d4e2c66:	05 30       	R0 = R5;
8d4e2c68:	ff e3 42 f3 	CALL 0x0x8d4e12ec;
8d4e2c6c:	e7 51       	R7 = R7 + R4;
8d4e2c6e:	3e 08       	CC = R6 == R7;
8d4e2c70:	65 51       	R5 = R5 + R4;
8d4e2c72:	f7 17       	IF !CC JUMP 0x0x8d4e2c60 (BP);
8d4e2c74:	ae a0       	R6 = [P5 + 0x8];
8d4e2c76:	03 c8 00 18 	MNOP || R0 = [P5 + 0x4] || R5 = [SP + 0x28];
8d4e2c7a:	68 a0 b5 a2 
8d4e2c7e:	46 52       	R1 = R6 - R0;
8d4e2c80:	02 da c3 30 	R2=818089009;
8d4e2c84:	31 0c 00 00 
8d4e2c88:	79 c2 8a 20 	(R3:2) = R1 * R2 (IS,NS);
8d4e2c8c:	82 c6 09 0f 	R7 = R1 >>> 0x1f;
8d4e2c90:	82 c6 e3 05 	R2 = R3 >>> 0x4;
8d4e2c94:	7a 52       	R1 = R2 - R7;
8d4e2c96:	00 0c       	CC = R0 == 0x0;
8d4e2c98:	4d 51       	R5 = R5 + R1;
8d4e2c9a:	0d 18       	IF CC JUMP 0x0x8d4e2cb4;
8d4e2c9c:	06 08       	CC = R6 == R0;
8d4e2c9e:	09 18       	IF CC JUMP 0x0x8d4e2cb0;
8d4e2ca0:	38 30       	R7 = R0;
8d4e2ca2:	07 30       	R0 = R7;
8d4e2ca4:	ff e3 72 f3 	CALL 0x0x8d4e1388;
8d4e2ca8:	e7 51       	R7 = R7 + R4;
8d4e2caa:	3e 08       	CC = R6 == R7;
8d4e2cac:	fb 17       	IF !CC JUMP 0x0x8d4e2ca2 (BP);
8d4e2cae:	68 a0       	R0 = [P5 + 0x4];
8d4e2cb0:	ff e3 9a 5b 	CALL 0x0x8d4ce3e4;
8d4e2cb4:	71 ca 2c 20 	R0 = R5 * R4 (IS,NS) || R3 = [FP + 0x8] || R7 = [FP + 0x10];
8d4e2cb8:	bb a0 3f a1 
8d4e2cbc:	04 cc 1f 02 	R1 = R3 + R7 (NS) || [P5 + 0x4] = R3 || NOP;
8d4e2cc0:	6b b0 00 00 
8d4e2cc4:	04 cc 18 00 	R0 = R3 + R0 (NS) || [P5 + 0xc] = R1 || NOP;
8d4e2cc8:	e9 b0 00 00 
8d4e2ccc:	a8 b0       	[P5 + 0x8] = R0;
8d4e2cce:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e2cd0:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e2cd2:	01 e8 00 00 	UNLINK;
8d4e2cd6:	10 00       	RTS;
8d4e2cd8:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4e2cdc:	24 2b 00 00 
8d4e2ce0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e2ce4:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e2ce6:	28 32       	P5 = R0;
8d4e2ce8:	86 6f       	SP += -0x10;		/* (-16) */
8d4e2cea:	04 da c3 30 	R4=818089009;
8d4e2cee:	31 0c 00 00 
8d4e2cf2:	04 cc 36 4c 	R6 = R6 - R6 (NS) || [SP + 0x2c] = R0 || NOP;
8d4e2cf6:	f0 b2 00 00 
8d4e2cfa:	03 c8 00 18 	MNOP || R5 = [P5 + 0x4] || R7 = [P5 + 0x8];
8d4e2cfe:	6d a0 af a0 
8d4e2d02:	af 52       	R2 = R7 - R5;
8d4e2d04:	82 c6 0a 01 	R0 = R2 >>> 0x1f;
8d4e2d08:	79 c2 94 20 	(R3:2) = R2 * R4 (IS,NS);
8d4e2d0c:	82 c6 e3 05 	R2 = R3 >>> 0x4;
8d4e2d10:	05 0c       	CC = R5 == 0x0;
8d4e2d12:	02 52       	R0 = R2 - R0;
8d4e2d14:	0a 18       	IF CC JUMP 0x0x8d4e2d28;
8d4e2d16:	ea a0       	R2 = [P5 + 0xc];
8d4e2d18:	aa 52       	R2 = R2 - R5;
8d4e2d1a:	82 c6 0a 0d 	R6 = R2 >>> 0x1f;
8d4e2d1e:	79 c2 94 20 	(R3:2) = R2 * R4 (IS,NS);
8d4e2d22:	82 c6 e3 05 	R2 = R3 >>> 0x4;
8d4e2d26:	b2 53       	R6 = R2 - R6;
8d4e2d28:	b0 09       	CC = R0 < R6 (IU);
8d4e2d2a:	0f 10       	IF !CC JUMP 0x0x8d4e2d48;
8d4e2d2c:	07 0c       	CC = R7 == 0x0;
8d4e2d2e:	04 18       	IF CC JUMP 0x0x8d4e2d36;
8d4e2d30:	07 30       	R0 = R7;
8d4e2d32:	ff e3 dd f2 	CALL 0x0x8d4e12ec;
8d4e2d36:	20 e1 54 00 	R0 = 0x54 (X);		/*		R0=0x54( 84) */
8d4e2d3a:	07 50       	R0 = R7 + R0;
8d4e2d3c:	a8 b0       	[P5 + 0x8] = R0;
8d4e2d3e:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e2d40:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e2d42:	01 e8 00 00 	UNLINK;
8d4e2d46:	10 00       	RTS;
8d4e2d48:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = R1 || R0 = [SP + 0x2c];
8d4e2d4c:	f1 b0 f0 a2 
8d4e2d50:	0a 60       	R2 = 0x1 (X);		/*		R2=0xffffffac(-84) */
8d4e2d52:	ff e3 a3 fd 	CALL 0x0x8d4e2898;
8d4e2d56:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e2d58:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e2d5a:	01 e8 00 00 	UNLINK;
8d4e2d5e:	10 00       	RTS;
8d4e2d60:	00 e8 15 00 	LINK 0x54;		/* (84) */
8d4e2d64:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e2d66:	86 6f       	SP += -0x10;		/* (-16) */
8d4e2d68:	27 61       	R7 = 0x24 (X);		/*		R7=0x0(  0) */
8d4e2d6a:	5e 30       	R3 = SP;
8d4e2d6c:	28 32       	P5 = R0;
8d4e2d6e:	04 cc 1f 08 	R4 = R3 + R7 (NS) || [FP + 0x8] = R0 || NOP;
8d4e2d72:	b8 b0 00 00 
8d4e2d76:	29 30       	R5 = R1;
8d4e2d78:	04 30       	R0 = R4;
8d4e2d7a:	22 e1 54 00 	R2 = 0x54 (X);		/*		R2=0x54( 84) */
8d4e2d7e:	01 60       	R1 = 0x0 (X);		/*		R1=0xffffffac(-84) */
8d4e2d80:	00 de 02 04 	CALL.A 0x04022ea8;
8d4e2d84:	a8 2e 00 00 
8d4e2d88:	04 30       	R0 = R4;
8d4e2d8a:	ff e3 9a f2 	CALL 0x0x8d4e12be;
8d4e2d8e:	03 c8 00 18 	MNOP || R7 = [P5 + 0x8] || R3 = [P5 + 0x4];
8d4e2d92:	af a0 6b a0 
8d4e2d96:	9f 52       	R2 = R7 - R3;
8d4e2d98:	00 da c3 30 	R0=818089009;
8d4e2d9c:	31 0c 00 00 
8d4e2da0:	79 c2 10 20 	(R1:0) = R2 * R0 (IS,NS);
8d4e2da4:	fa 4d       	R2 >>>= 0x1f;
8d4e2da6:	82 c6 e1 01 	R0 = R1 >>> 0x4;
8d4e2daa:	04 cc 02 42 	R1 = R0 - R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4e2dae:	b8 a0 00 00 
8d4e2db2:	a9 09       	CC = R1 < R5 (IU);
8d4e2db4:	26 e1 54 00 	R6 = 0x54 (X);		/*		R6=0x54( 84) */
8d4e2db8:	1c 18       	IF CC JUMP 0x0x8d4e2df0;
8d4e2dba:	8d 09       	CC = R5 < R1 (IU);
8d4e2dbc:	12 10       	IF !CC JUMP 0x0x8d4e2de0;
8d4e2dbe:	71 c2 2e 20 	R0 = R5 * R6 (IS,NS);
8d4e2dc2:	03 50       	R0 = R3 + R0;
8d4e2dc4:	b8 b0       	[FP + 0x8] = R0;
8d4e2dc6:	07 08       	CC = R7 == R0;
8d4e2dc8:	0c 18       	IF CC JUMP 0x0x8d4e2de0;
8d4e2dca:	bd a0       	R5 = [FP + 0x8];
8d4e2dcc:	05 30       	R0 = R5;
8d4e2dce:	ff e3 dd f2 	CALL 0x0x8d4e1388;
8d4e2dd2:	04 cc 2e 0a 	R5 = R5 + R6 (NS) || R0 = [FP + 0x8] || NOP;
8d4e2dd6:	b8 a0 00 00 
8d4e2dda:	2f 08       	CC = R7 == R5;
8d4e2ddc:	f8 17       	IF !CC JUMP 0x0x8d4e2dcc (BP);
8d4e2dde:	a8 b0       	[P5 + 0x8] = R0;
8d4e2de0:	04 30       	R0 = R4;
8d4e2de2:	ff e3 d3 f2 	CALL 0x0x8d4e1388;
8d4e2de6:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e2de8:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e2dea:	01 e8 00 00 	UNLINK;
8d4e2dee:	10 00       	RTS;
8d4e2df0:	04 cc 29 44 	R2 = R5 - R1 (NS) || [SP + 0xc] = R4 || NOP;
8d4e2df4:	f4 b0 00 00 
8d4e2df8:	0f 30       	R1 = R7;
8d4e2dfa:	ff e3 4f fd 	CALL 0x0x8d4e2898;
8d4e2dfe:	f1 2f       	JUMP.S 0x0x8d4e2de0;
8d4e2e00:	08 32       	P1 = R0;
8d4e2e02:	01 32       	P0 = R1;
8d4e2e04:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e2e08:	70 05       	[--SP] = (R7:6);
8d4e2e0a:	48 08       	CC = P0 == P1;
8d4e2e0c:	27 18       	IF CC JUMP 0x0x8d4e2e5a;
8d4e2e0e:	03 c8 00 18 	MNOP || R0 = [P0 + 0x4] || R1 = [P0 + 0x8];
8d4e2e12:	40 a0 81 a0 
8d4e2e16:	03 c8 00 18 	MNOP || R2 = [P0 + 0xc] || R3 = [P0 + 0x10];
8d4e2e1a:	c2 a0 03 a1 
8d4e2e1e:	03 c8 00 18 	MNOP || R7 = [P1 + 0x4] || R6 = [P1 + 0x8];
8d4e2e22:	4f a0 8e a0 
8d4e2e26:	48 b0       	[P1 + 0x4] = R0;
8d4e2e28:	03 c8 00 18 	MNOP || R0 = [P1 + 0xc] || [P1 + 0x8] = R1;
8d4e2e2c:	c8 a0 89 b0 
8d4e2e30:	03 c8 00 18 	MNOP || R1 = [P1 + 0x10] || [P1 + 0xc] = R2;
8d4e2e34:	09 a1 ca b0 
8d4e2e38:	0b b1       	[P1 + 0x10] = R3;
8d4e2e3a:	c0 b0       	[P0 + 0xc] = R0;
8d4e2e3c:	47 b0       	[P0 + 0x4] = R7;
8d4e2e3e:	86 b0       	[P0 + 0x8] = R6;
8d4e2e40:	03 c8 00 18 	MNOP || [P0 + 0x10] = R1 || R0 = [P0 + 0x14];
8d4e2e44:	01 b1 40 a1 
8d4e2e48:	49 a1       	R1 = [P1 + 0x14];
8d4e2e4a:	48 b1       	[P1 + 0x14] = R0;
8d4e2e4c:	03 c8 00 18 	MNOP || [P0 + 0x14] = R1 || R0 = [P0 + 0x18];
8d4e2e50:	41 b1 80 a1 
8d4e2e54:	89 a1       	R1 = [P1 + 0x18];
8d4e2e56:	88 b1       	[P1 + 0x18] = R0;
8d4e2e58:	81 b1       	[P0 + 0x18] = R1;
8d4e2e5a:	30 05       	(R7:6) = [SP++];
8d4e2e5c:	01 e8 00 00 	UNLINK;
8d4e2e60:	10 00       	RTS;
8d4e2e62:	00 00       	NOP;
8d4e2e64:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e2e68:	68 05       	[--SP] = (R7:5);
8d4e2e6a:	31 30       	R6 = R1;
8d4e2e6c:	38 30       	R7 = R0;
8d4e2e6e:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e2e70:	06 30       	R0 = R6;
8d4e2e72:	0f 30       	R1 = R7;
8d4e2e74:	2a 30       	R5 = R2;
8d4e2e76:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e2e7a:	32 41 00 00 
8d4e2e7e:	80 0c       	CC = R0 < 0x0;
8d4e2e80:	24 18       	IF CC JUMP 0x0x8d4e2ec8;
8d4e2e82:	0e 30       	R1 = R6;
8d4e2e84:	05 30       	R0 = R5;
8d4e2e86:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e2e8a:	32 41 00 00 
8d4e2e8e:	80 0c       	CC = R0 < 0x0;
8d4e2e90:	17 18       	IF CC JUMP 0x0x8d4e2ebe;
8d4e2e92:	0f 30       	R1 = R7;
8d4e2e94:	06 30       	R0 = R6;
8d4e2e96:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e2e9a:	32 41 00 00 
8d4e2e9e:	80 0c       	CC = R0 < 0x0;
8d4e2ea0:	06 18       	IF CC JUMP 0x0x8d4e2eac;
8d4e2ea2:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e2ea4:	28 05       	(R7:5) = [SP++];
8d4e2ea6:	01 e8 00 00 	UNLINK;
8d4e2eaa:	10 00       	RTS;
8d4e2eac:	0f 30       	R1 = R7;
8d4e2eae:	06 30       	R0 = R6;
8d4e2eb0:	ff e3 a8 ff 	CALL 0x0x8d4e2e00;
8d4e2eb4:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e2eb6:	28 05       	(R7:5) = [SP++];
8d4e2eb8:	01 e8 00 00 	UNLINK;
8d4e2ebc:	10 00       	RTS;
8d4e2ebe:	0e 30       	R1 = R6;
8d4e2ec0:	05 30       	R0 = R5;
8d4e2ec2:	ff e3 9f ff 	CALL 0x0x8d4e2e00;
8d4e2ec6:	e6 2f       	JUMP.S 0x0x8d4e2e92;
8d4e2ec8:	0f 30       	R1 = R7;
8d4e2eca:	06 30       	R0 = R6;
8d4e2ecc:	ff e3 9a ff 	CALL 0x0x8d4e2e00;
8d4e2ed0:	d9 2f       	JUMP.S 0x0x8d4e2e82;
8d4e2ed2:	00 00       	NOP;
8d4e2ed4:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d4e2ed8:	60 05       	[--SP] = (R7:4);
8d4e2eda:	86 6f       	SP += -0x10;		/* (-16) */
8d4e2edc:	82 ce 09 8e 	R7 = R1 << 0x1 || [FP + 0x10] = R1 || NOP;
8d4e2ee0:	39 b1 00 00 
8d4e2ee4:	17 64       	R7 += 0x2;		/* (  2) */
8d4e2ee6:	97 08       	CC = R7 < R2;
8d4e2ee8:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || [FP + 0xc] = R2 || NOP;
8d4e2eec:	fa b0 00 00 
8d4e2ef0:	3e a1       	R6 = [FP + 0x10];
8d4e2ef2:	2d 10       	IF !CC JUMP 0x0x8d4e2f4c;
8d4e2ef4:	e4 60       	R4 = 0x1c (X);		/*		R4=0x54( 84) */
8d4e2ef6:	be b0       	[FP + 0x8] = R6;
8d4e2ef8:	71 c2 3c 20 	R0 = R7 * R4 (IS,NS);
8d4e2efc:	37 30       	R6 = R7;
8d4e2efe:	ff 67       	R7 += -0x1;		/* ( -1) */
8d4e2f00:	05 50       	R0 = R5 + R0;
8d4e2f02:	71 c2 7c 20 	R1 = R7 * R4 (IS,NS);
8d4e2f06:	4d 50       	R1 = R5 + R1;
8d4e2f08:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e2f0c:	32 41 00 00 
8d4e2f10:	80 0c       	CC = R0 < 0x0;
8d4e2f12:	37 07       	IF CC R6 = R7;
8d4e2f14:	82 ce 0e 8e 	R7 = R6 << 0x1 || R2 = [FP + 0x8] || NOP;
8d4e2f18:	ba a0 00 00 
8d4e2f1c:	71 ca 94 20 	R2 = R2 * R4 (IS,NS) || [FP + 0x8] = R6 || NOP;
8d4e2f20:	be b0 00 00 
8d4e2f24:	71 c2 74 20 	R1 = R6 * R4 (IS,NS);
8d4e2f28:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2f2c:	b8 00 03 00 
8d4e2f30:	04 cc 2a 00 	R0 = R5 + R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e2f34:	f3 b0 00 00 
8d4e2f38:	4d 50       	R1 = R5 + R1;
8d4e2f3a:	02 60       	R2 = 0x0 (X);		/*		R2=0x54( 84) */
8d4e2f3c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2f40:	70 e9 00 00 
8d4e2f44:	17 64       	R7 += 0x2;		/* (  2) */
8d4e2f46:	fb a0       	R3 = [FP + 0xc];
8d4e2f48:	9f 08       	CC = R7 < R3;
8d4e2f4a:	d7 1f       	IF CC JUMP 0x0x8d4e2ef8 (BP);
8d4e2f4c:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP + 0xc] || NOP;
8d4e2f50:	f8 a0 00 00 
8d4e2f54:	38 08       	CC = R0 == R7;
8d4e2f56:	6c 18       	IF CC JUMP 0x0x8d4e302e;
8d4e2f58:	57 30       	R2 = FP;
8d4e2f5a:	22 67       	R2 += -0x1c;		/* (-28) */
8d4e2f5c:	04 cc 24 48 	R4 = R4 - R4 (NS) || [FP + 0xc] = R2 || R1 = [FP + 0x14];
8d4e2f60:	fa b0 79 a1 
8d4e2f64:	7b 60       	R3 = 0xf (X);		/*		R3=0xffffffac(-84) */
8d4e2f66:	b4 e6 24 00 	B[SP + 0x24] = R4;
8d4e2f6a:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [SP + 0x38] = R3 || NOP;
8d4e2f6e:	b3 b3 00 00 
8d4e2f72:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2f76:	b8 00 03 00 
8d4e2f7a:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0x34] = R7 || R0 = [FP + 0xc];
8d4e2f7e:	77 b3 f8 a0 
8d4e2f82:	f3 b0       	[SP + 0xc] = R3;
8d4e2f84:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2f88:	70 e9 00 00 
8d4e2f8c:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R2 = [FP + 0x10] || NOP;
8d4e2f90:	3a a1 00 00 
8d4e2f94:	f8 67       	R0 += -0x1;		/* ( -1) */
8d4e2f96:	82 c6 08 83 	R1 = R0 >> 0x1f;
8d4e2f9a:	04 cc 01 00 	R0 = R0 + R1 (NS) || R1 = [FP + 0xc] || NOP;
8d4e2f9e:	f9 a0 00 00 
8d4e2fa2:	b2 08       	CC = R2 < R6;
8d4e2fa4:	82 c6 f8 09 	R4 = R0 >>> 0x1;
8d4e2fa8:	1d 10       	IF !CC JUMP 0x0x8d4e2fe2;
8d4e2faa:	e0 60       	R0 = 0x1c (X);		/*		R0=0x54( 84) */
8d4e2fac:	e0 40       	R0 *= R4;
8d4e2fae:	c5 51       	R7 = R5 + R0;
8d4e2fb0:	07 30       	R0 = R7;
8d4e2fb2:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e2fb6:	32 41 00 00 
8d4e2fba:	80 0c       	CC = R0 < 0x0;
8d4e2fbc:	13 10       	IF !CC JUMP 0x0x8d4e2fe2;
8d4e2fbe:	e0 60       	R0 = 0x1c (X);		/*		R0=0x54( 84) */
8d4e2fc0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2fc4:	b8 00 03 00 
8d4e2fc8:	71 ca 30 20 	R0 = R6 * R0 (IS,NS) || [SP + 0xc] = R3 || NOP;
8d4e2fcc:	f3 b0 00 00 
8d4e2fd0:	05 50       	R0 = R5 + R0;
8d4e2fd2:	0f 30       	R1 = R7;
8d4e2fd4:	02 60       	R2 = 0x0 (X);		/*		R2=0x54( 84) */
8d4e2fd6:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2fda:	70 e9 00 00 
8d4e2fde:	34 30       	R6 = R4;
8d4e2fe0:	d6 2f       	JUMP.S 0x0x8d4e2f8c;
8d4e2fe2:	e0 60       	R0 = 0x1c (X);		/*		R0=0x54( 84) */
8d4e2fe4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e2fe8:	b8 00 03 00 
8d4e2fec:	71 ca 30 20 	R0 = R6 * R0 (IS,NS) || [SP + 0xc] = R3 || R1 = [FP + 0xc];
8d4e2ff0:	f3 b0 f9 a0 
8d4e2ff4:	05 50       	R0 = R5 + R0;
8d4e2ff6:	02 60       	R2 = 0x0 (X);		/*		R2=0x54( 84) */
8d4e2ff8:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e2ffc:	70 e9 00 00 
8d4e3000:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e3002:	b0 a3       	R0 = [SP + 0x38];
8d4e3004:	07 0a       	CC = R7 <= R0 (IU);
8d4e3006:	09 18       	IF CC JUMP 0x0x8d4e3018;
8d4e3008:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e300a:	b0 e6 24 00 	B[SP + 0x24] = R0;
8d4e300e:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e3010:	20 05       	(R7:4) = [SP++];
8d4e3012:	01 e8 00 00 	UNLINK;
8d4e3016:	10 00       	RTS;
8d4e3018:	70 a2       	R0 = [SP + 0x24];
8d4e301a:	ff e3 e5 59 	CALL 0x0x8d4ce3e4;
8d4e301e:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e3020:	b0 e6 24 00 	B[SP + 0x24] = R0;
8d4e3024:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e3026:	20 05       	(R7:4) = [SP++];
8d4e3028:	01 e8 00 00 	UNLINK;
8d4e302c:	10 00       	RTS;
8d4e302e:	ff a0       	R7 = [FP + 0xc];
8d4e3030:	ff 67       	R7 += -0x1;		/* ( -1) */
8d4e3032:	e3 60       	R3 = 0x1c (X);		/*		R3=0xffffffac(-84) */
8d4e3034:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0004;
8d4e3038:	b8 00 04 00 
8d4e303c:	71 ca 33 20 	R0 = R6 * R3 (IS,NS) || [SP + 0xc] = R4 || NOP;
8d4e3040:	f4 b0 00 00 
8d4e3044:	71 c2 7b 20 	R1 = R7 * R3 (IS,NS);
8d4e3048:	05 50       	R0 = R5 + R0;
8d4e304a:	4d 50       	R1 = R5 + R1;
8d4e304c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3050:	70 e9 00 00 
8d4e3054:	37 30       	R6 = R7;
8d4e3056:	81 2f       	JUMP.S 0x0x8d4e2f58;
8d4e3058:	00 e8 11 00 	LINK 0x44;		/* (68) */
8d4e305c:	60 05       	[--SP] = (R7:4);
8d4e305e:	86 6f       	SP += -0x10;		/* (-16) */
8d4e3060:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || [FP + 0xc] = R0 || NOP;
8d4e3064:	f8 b0 00 00 
8d4e3068:	b2 b2       	[SP + 0x28] = R2;
8d4e306a:	f8 a0       	R0 = [FP + 0xc];
8d4e306c:	07 52       	R0 = R7 - R0;
8d4e306e:	01 da 49 92 	R1=-1840700269;
8d4e3072:	93 24 00 00 
8d4e3076:	31 c3 41 20 	R1 = R0 * R1 (M,T);
8d4e307a:	82 c6 08 05 	R2 = R0 >>> 0x1f;
8d4e307e:	21 4d       	R1 >>>= 0x4;
8d4e3080:	51 52       	R1 = R1 - R2;
8d4e3082:	03 61       	R3 = 0x20 (X);		/*		R3=0xffffffac(-84) */
8d4e3084:	8b 08       	CC = R3 < R1;
8d4e3086:	58 11       	IF !CC JUMP 0x0x8d4e3336;
8d4e3088:	03 c8 00 18 	MNOP || R0 = [SP + 0x28] || R2 = [FP + 0xc];
8d4e308c:	b0 a2 fa a0 
8d4e3090:	00 0d       	CC = R0 <= 0x0;
8d4e3092:	52 19       	IF CC JUMP 0x0x8d4e3336;
8d4e3094:	82 ce f9 83 	R1 = R1 >> 0x1 || [FP + 0x10] = R7 || NOP;
8d4e3098:	3f b1 00 00 
8d4e309c:	27 67       	R7 += -0x1c;		/* (-28) */
8d4e309e:	04 cc 3a 44 	R2 = R7 - R2 (NS) || R6 = [FP + 0xc] || NOP;
8d4e30a2:	fe a0 00 00 
8d4e30a6:	00 da 49 92 	R0=-1840700269;
8d4e30aa:	93 24 00 00 
8d4e30ae:	31 c3 10 20 	R0 = R2 * R0 (M,T);
8d4e30b2:	e3 60       	R3 = 0x1c (X);		/*		R3=0xffffffac(-84) */
8d4e30b4:	fa 4d       	R2 >>>= 0x1f;
8d4e30b6:	20 4d       	R0 >>>= 0x4;
8d4e30b8:	10 52       	R0 = R0 - R2;
8d4e30ba:	44 61       	R4 = 0x28 (X);		/*		R4=0x54( 84) */
8d4e30bc:	71 c2 4b 21 	R5 = R1 * R3 (IS,NS);
8d4e30c0:	84 08       	CC = R4 < R0;
8d4e30c2:	04 cc 35 0c 	R6 = R6 + R5 (NS) || R4 = [FP + 0xc] || NOP;
8d4e30c6:	fc a0 00 00 
8d4e30ca:	fa 18       	IF CC JUMP 0x0x8d4e32be;
8d4e30cc:	82 ce 07 c4 	R2 = ROT R7 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4e30d0:	f8 a0 00 00 
8d4e30d4:	0e 30       	R1 = R6;
8d4e30d6:	ff e3 c7 fe 	CALL 0x0x8d4e2e64;
8d4e30da:	82 ce 06 c8 	R4 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4e30de:	f8 a0 00 00 
8d4e30e2:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e30e4:	68 51       	R5 = R0 + R5;
8d4e30e6:	e4 64       	R4 += 0x1c;		/* ( 28) */
8d4e30e8:	82 ce 06 ce 	R7 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4e30ec:	f8 a0 00 00 
8d4e30f0:	b0 09       	CC = R0 < R6 (IU);
8d4e30f2:	35 30       	R6 = R5;
8d4e30f4:	25 67       	R5 += -0x1c;		/* (-28) */
8d4e30f6:	11 10       	IF !CC JUMP 0x0x8d4e3118;
8d4e30f8:	0f 30       	R1 = R7;
8d4e30fa:	06 30       	R0 = R6;
8d4e30fc:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e3100:	32 41 00 00 
8d4e3104:	80 0c       	CC = R0 < 0x0;
8d4e3106:	09 18       	IF CC JUMP 0x0x8d4e3118;
8d4e3108:	0e 30       	R1 = R6;
8d4e310a:	07 30       	R0 = R7;
8d4e310c:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e3110:	32 41 00 00 
8d4e3114:	80 0c       	CC = R0 < 0x0;
8d4e3116:	e9 17       	IF !CC JUMP 0x0x8d4e30e8 (BP);
8d4e3118:	34 30       	R6 = R4;
8d4e311a:	82 ce 04 ca 	R5 = ROT R4 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e311e:	38 a1 00 00 
8d4e3122:	84 09       	CC = R4 < R0 (IU);
8d4e3124:	e4 64       	R4 += 0x1c;		/* ( 28) */
8d4e3126:	12 10       	IF !CC JUMP 0x0x8d4e314a;
8d4e3128:	0f 30       	R1 = R7;
8d4e312a:	06 30       	R0 = R6;
8d4e312c:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e3130:	32 41 00 00 
8d4e3134:	80 0c       	CC = R0 < 0x0;
8d4e3136:	0a 18       	IF CC JUMP 0x0x8d4e314a;
8d4e3138:	0e 30       	R1 = R6;
8d4e313a:	07 30       	R0 = R7;
8d4e313c:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e3140:	32 41 00 00 
8d4e3144:	80 0c       	CC = R0 < 0x0;
8d4e3146:	34 30       	R6 = R4;
8d4e3148:	e9 17       	IF !CC JUMP 0x0x8d4e311a (BP);
8d4e314a:	35 30       	R6 = R5;
8d4e314c:	27 30       	R4 = R7;
8d4e314e:	bd b0       	[FP + 0x8] = R5;
8d4e3150:	38 a1       	R0 = [FP + 0x10];
8d4e3152:	86 09       	CC = R6 < R0 (IU);
8d4e3154:	20 10       	IF !CC JUMP 0x0x8d4e3194;
8d4e3156:	0e 30       	R1 = R6;
8d4e3158:	07 30       	R0 = R7;
8d4e315a:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e315e:	32 41 00 00 
8d4e3162:	80 0c       	CC = R0 < 0x0;
8d4e3164:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4e3168:	b9 a0 00 00 
8d4e316c:	04 10       	IF !CC JUMP 0x0x8d4e3174;
8d4e316e:	b9 b0       	[FP + 0x8] = R1;
8d4e3170:	e6 64       	R6 += 0x1c;		/* ( 28) */
8d4e3172:	ef 2f       	JUMP.S 0x0x8d4e3150;
8d4e3174:	0f 30       	R1 = R7;
8d4e3176:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e317a:	32 41 00 00 
8d4e317e:	80 0c       	CC = R0 < 0x0;
8d4e3180:	0a 18       	IF CC JUMP 0x0x8d4e3194;
8d4e3182:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4e3186:	b8 a0 00 00 
8d4e318a:	ff e3 3b fe 	CALL 0x0x8d4e2e00;
8d4e318e:	b9 a0       	R1 = [FP + 0x8];
8d4e3190:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4e3192:	ee 2f       	JUMP.S 0x0x8d4e316e;
8d4e3194:	f8 a0       	R0 = [FP + 0xc];
8d4e3196:	a0 09       	CC = R0 < R4 (IU);
8d4e3198:	1c 10       	IF !CC JUMP 0x0x8d4e31d0;
8d4e319a:	2c 30       	R5 = R4;
8d4e319c:	25 67       	R5 += -0x1c;		/* (-28) */
8d4e319e:	0f 30       	R1 = R7;
8d4e31a0:	05 30       	R0 = R5;
8d4e31a2:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e31a6:	32 41 00 00 
8d4e31aa:	80 0c       	CC = R0 < 0x0;
8d4e31ac:	03 10       	IF !CC JUMP 0x0x8d4e31b2;
8d4e31ae:	25 30       	R4 = R5;
8d4e31b0:	f2 2f       	JUMP.S 0x0x8d4e3194;
8d4e31b2:	0d 30       	R1 = R5;
8d4e31b4:	07 30       	R0 = R7;
8d4e31b6:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e31ba:	32 41 00 00 
8d4e31be:	80 0c       	CC = R0 < 0x0;
8d4e31c0:	08 18       	IF CC JUMP 0x0x8d4e31d0;
8d4e31c2:	27 67       	R7 += -0x1c;		/* (-28) */
8d4e31c4:	0d 30       	R1 = R5;
8d4e31c6:	07 30       	R0 = R7;
8d4e31c8:	ff e3 1c fe 	CALL 0x0x8d4e2e00;
8d4e31cc:	f1 2f       	JUMP.S 0x0x8d4e31ae;
8d4e31ce:	00 00       	NOP;
8d4e31d0:	03 c8 00 18 	MNOP || R0 = [FP + 0xc] || R3 = [SP + 0x28];
8d4e31d4:	f8 a0 b3 a2 
8d4e31d8:	04 08       	CC = R4 == R0;
8d4e31da:	37 18       	IF CC JUMP 0x0x8d4e3248;
8d4e31dc:	f8 a0       	R0 = [FP + 0xc];
8d4e31de:	04 08       	CC = R4 == R0;
8d4e31e0:	1e 18       	IF CC JUMP 0x0x8d4e321c;
8d4e31e2:	38 a1       	R0 = [FP + 0x10];
8d4e31e4:	06 08       	CC = R6 == R0;
8d4e31e6:	24 67       	R4 += -0x1c;		/* (-28) */
8d4e31e8:	0a 18       	IF CC JUMP 0x0x8d4e31fc;
8d4e31ea:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R5 = [FP + 0x8] || NOP;
8d4e31ee:	bd a0 00 00 
8d4e31f2:	0c 30       	R1 = R4;
8d4e31f4:	ff e3 06 fe 	CALL 0x0x8d4e2e00;
8d4e31f8:	e6 64       	R6 += 0x1c;		/* ( 28) */
8d4e31fa:	aa 2f       	JUMP.S 0x0x8d4e314e;
8d4e31fc:	27 67       	R7 += -0x1c;		/* (-28) */
8d4e31fe:	3c 08       	CC = R4 == R7;
8d4e3200:	05 18       	IF CC JUMP 0x0x8d4e320a;
8d4e3202:	0f 30       	R1 = R7;
8d4e3204:	04 30       	R0 = R4;
8d4e3206:	ff e3 fd fd 	CALL 0x0x8d4e2e00;
8d4e320a:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R5 = [FP + 0x8] || NOP;
8d4e320e:	bd a0 00 00 
8d4e3212:	25 67       	R5 += -0x1c;		/* (-28) */
8d4e3214:	0d 30       	R1 = R5;
8d4e3216:	ff e3 f5 fd 	CALL 0x0x8d4e2e00;
8d4e321a:	9a 2f       	JUMP.S 0x0x8d4e314e;
8d4e321c:	b8 a0       	R0 = [FP + 0x8];
8d4e321e:	06 08       	CC = R6 == R0;
8d4e3220:	07 18       	IF CC JUMP 0x0x8d4e322e;
8d4e3222:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x8] || NOP;
8d4e3226:	b9 a0 00 00 
8d4e322a:	ff e3 eb fd 	CALL 0x0x8d4e2e00;
8d4e322e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R5 = [FP + 0x8] || NOP;
8d4e3232:	bd a0 00 00 
8d4e3236:	0e 30       	R1 = R6;
8d4e3238:	ff e3 e4 fd 	CALL 0x0x8d4e2e00;
8d4e323c:	e7 64       	R7 += 0x1c;		/* ( 28) */
8d4e323e:	e5 64       	R5 += 0x1c;		/* ( 28) */
8d4e3240:	e6 64       	R6 += 0x1c;		/* ( 28) */
8d4e3242:	86 2f       	JUMP.S 0x0x8d4e314e;
8d4e3244:	00 00       	NOP;
8d4e3246:	00 00       	NOP;
8d4e3248:	82 ce f3 83 	R1 = R3 >> 0x2 || R0 = [FP + 0x10] || R5 = [FP + 0xc];
8d4e324c:	38 a1 fd a0 
8d4e3250:	06 08       	CC = R6 == R0;
8d4e3252:	c5 17       	IF !CC JUMP 0x0x8d4e31dc (BP);
8d4e3254:	82 ce fb 81 	R0 = R3 >> 0x1 || R4 = [FP + 0x8] || NOP;
8d4e3258:	bc a0 00 00 
8d4e325c:	04 cc 01 0c 	R6 = R0 + R1 (NS) || R0 = [FP + 0x10] || NOP;
8d4e3260:	38 a1 00 00 
8d4e3264:	6f 53       	R5 = R7 - R5;
8d4e3266:	20 53       	R4 = R0 - R4;
8d4e3268:	02 da 49 92 	R2=-1840700269;
8d4e326c:	93 24 00 00 
8d4e3270:	03 da 49 92 	R3=-1840700269;
8d4e3274:	93 24 00 00 
8d4e3278:	31 c3 aa 20 	R2 = R5 * R2 (M,T);
8d4e327c:	31 c3 e3 20 	R3 = R4 * R3 (M,T);
8d4e3280:	82 c6 0d 03 	R1 = R5 >>> 0x1f;
8d4e3284:	82 c6 0c 01 	R0 = R4 >>> 0x1f;
8d4e3288:	22 4d       	R2 >>>= 0x4;
8d4e328a:	23 4d       	R3 >>>= 0x4;
8d4e328c:	4a 52       	R1 = R2 - R1;
8d4e328e:	03 52       	R0 = R3 - R0;
8d4e3290:	81 08       	CC = R1 < R0;
8d4e3292:	0b 18       	IF CC JUMP 0x0x8d4e32a8;
8d4e3294:	82 ce 06 c4 	R2 = ROT R6 BY 0x0 || R1 = [FP + 0x10] || R0 = [FP + 0x8];
8d4e3298:	39 a1 b8 a0 
8d4e329c:	ff e3 de fe 	CALL 0x0x8d4e3058;
8d4e32a0:	fa a0       	R2 = [FP + 0xc];
8d4e32a2:	0b 20       	JUMP.S 0x0x8d4e32b8;
8d4e32a4:	00 00       	NOP;
8d4e32a6:	00 00       	NOP;
8d4e32a8:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP + 0xc] || R7 = [FP + 0x10];
8d4e32ac:	f8 a0 3f a1 
8d4e32b0:	16 30       	R2 = R6;
8d4e32b2:	ff e3 d3 fe 	CALL 0x0x8d4e3058;
8d4e32b6:	ba a0       	R2 = [FP + 0x8];
8d4e32b8:	fa b0       	[FP + 0xc] = R2;
8d4e32ba:	b6 b2       	[SP + 0x28] = R6;
8d4e32bc:	d7 2e       	JUMP.S 0x0x8d4e306a;
8d4e32be:	08 64       	R0 += 0x1;		/* (  1) */
8d4e32c0:	82 c6 08 03 	R1 = R0 >>> 0x1f;
8d4e32c4:	e9 4e       	R1 >>= 0x1d;
8d4e32c6:	08 50       	R0 = R0 + R1;
8d4e32c8:	18 4d       	R0 >>>= 0x3;
8d4e32ca:	82 c6 08 84 	R2 = R0 << 0x1;
8d4e32ce:	71 c2 43 20 	R1 = R0 * R3 (IS,NS);
8d4e32d2:	07 cc 00 c2 	R1 = -R0 (NS) || [SP + 0x20] = R1 || NOP;
8d4e32d6:	31 b2 00 00 
8d4e32da:	30 a2       	R0 = [SP + 0x20];
8d4e32dc:	04 51       	R4 = R4 + R0;
8d4e32de:	07 cc 10 c0 	R0 = -R2 (NS) || [SP + 0x24] = R4 || NOP;
8d4e32e2:	74 b2 00 00 
8d4e32e6:	71 ca 0b 21 	R4 = R1 * R3 (IS,NS) || R1 = [FP + 0xc] || NOP;
8d4e32ea:	f9 a0 00 00 
8d4e32ee:	da 40       	R2 *= R3;
8d4e32f0:	71 ca c3 20 	R3 = R0 * R3 (IS,NS) || R0 = [FP + 0xc] || NOP;
8d4e32f4:	f8 a0 00 00 
8d4e32f8:	04 cc 0a 04 	R2 = R1 + R2 (NS) || R1 = [SP + 0x24] || [FP + 0x8] = R3;
8d4e32fc:	71 a2 bb b0 
8d4e3300:	ff e3 b2 fd 	CALL 0x0x8d4e2e64;
8d4e3304:	04 cc 34 00 	R0 = R6 + R4 (NS) || R3 = [SP + 0x20] || NOP;
8d4e3308:	33 a2 00 00 
8d4e330c:	9e 50       	R2 = R6 + R3;
8d4e330e:	0e 30       	R1 = R6;
8d4e3310:	ff e3 aa fd 	CALL 0x0x8d4e2e64;
8d4e3314:	04 cc 3c 08 	R4 = R7 + R4 (NS) || R1 = [FP + 0x8] || NOP;
8d4e3318:	b9 a0 00 00 
8d4e331c:	0f 50       	R0 = R7 + R1;
8d4e331e:	17 30       	R2 = R7;
8d4e3320:	0c 30       	R1 = R4;
8d4e3322:	ff e3 a1 fd 	CALL 0x0x8d4e2e64;
8d4e3326:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || R0 = [SP + 0x24] || NOP;
8d4e332a:	70 a2 00 00 
8d4e332e:	0e 30       	R1 = R6;
8d4e3330:	ff e3 9a fd 	CALL 0x0x8d4e2e64;
8d4e3334:	d3 2e       	JUMP.S 0x0x8d4e30da;
8d4e3336:	8b 08       	CC = R3 < R1;
8d4e3338:	ef 10       	IF !CC JUMP 0x0x8d4e3516;
8d4e333a:	f8 a0       	R0 = [FP + 0xc];
8d4e333c:	87 53       	R6 = R7 - R0;
8d4e333e:	01 da 49 92 	R1=-1840700269;
8d4e3342:	93 24 00 00 
8d4e3346:	31 c3 71 20 	R1 = R6 * R1 (M,T);
8d4e334a:	82 c6 0e 01 	R0 = R6 >>> 0x1f;
8d4e334e:	21 4d       	R1 >>>= 0x4;
8d4e3350:	01 52       	R0 = R1 - R0;
8d4e3352:	08 0d       	CC = R0 <= 0x1;
8d4e3354:	82 ce f8 8b 	R5 = R0 >> 0x1 || [FP + 0x8] = R0 || R0 = [FP + 0xc];
8d4e3358:	b8 b0 f8 a0 
8d4e335c:	3c 18       	IF CC JUMP 0x0x8d4e33d4;
8d4e335e:	05 0d       	CC = R5 <= 0x0;
8d4e3360:	3a 18       	IF CC JUMP 0x0x8d4e33d4;
8d4e3362:	e1 60       	R1 = 0x1c (X);		/*		R1=0xffffffac(-84) */
8d4e3364:	e9 40       	R1 *= R5;
8d4e3366:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e3368:	08 50       	R0 = R0 + R1;
8d4e336a:	70 b2       	[SP + 0x24] = R0;
8d4e336c:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e336e:	b0 e6 30 00 	B[SP + 0x30] = R0;
8d4e3372:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e3376:	b8 00 03 00 
8d4e337a:	67 30       	R4 = FP;
8d4e337c:	04 cc 1b 46 	R3 = R3 - R3 (NS) || [SP + 0xc] = R3 || NOP;
8d4e3380:	f3 b0 00 00 
8d4e3384:	79 60       	R1 = 0xf (X);		/*		R1=0xffffffac(-84) */
8d4e3386:	44 66       	R4 += -0x38;		/* (-56) */
8d4e3388:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP -0x20] = R1 || R1 = [SP + 0x24];
8d4e338c:	81 bb 71 a2 
8d4e3390:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x24] = R3 || NOP;
8d4e3394:	73 bb 00 00 
8d4e3398:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e339c:	70 e9 00 00 
8d4e33a0:	fd 67       	R5 += -0x1;		/* ( -1) */
8d4e33a2:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || [SP + 0xc] = R4 || R0 = [FP + 0xc];
8d4e33a6:	f4 b0 f8 a0 
8d4e33aa:	ba a0       	R2 = [FP + 0x8];
8d4e33ac:	ff e3 94 fd 	CALL 0x0x8d4e2ed4;
8d4e33b0:	80 b9       	R0 = [FP -0x20];
8d4e33b2:	81 60       	R1 = 0x10 (X);		/*		R1=0xffffffac(-84) */
8d4e33b4:	01 0a       	CC = R1 <= R0 (IU);
8d4e33b6:	ac 18       	IF CC JUMP 0x0x8d4e350e;
8d4e33b8:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [SP + 0x24] || NOP;
8d4e33bc:	70 a2 00 00 
8d4e33c0:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e33c2:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP -0x24] = R2 || NOP;
8d4e33c6:	72 bb 00 00 
8d4e33ca:	05 0d       	CC = R5 <= 0x0;
8d4e33cc:	70 b2       	[SP + 0x24] = R0;
8d4e33ce:	b1 e6 30 00 	B[SP + 0x30] = R1;
8d4e33d2:	cd 17       	IF !CC JUMP 0x0x8d4e336c (BP);
8d4e33d4:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || R0 = [FP + 0x8] || NOP;
8d4e33d8:	b8 a0 00 00 
8d4e33dc:	08 0d       	CC = R0 <= 0x1;
8d4e33de:	1c 18       	IF CC JUMP 0x0x8d4e3416;
8d4e33e0:	27 67       	R7 += -0x1c;		/* (-28) */
8d4e33e2:	00 da 49 92 	R0=-1840700269;
8d4e33e6:	93 24 00 00 
8d4e33ea:	31 c3 30 20 	R0 = R6 * R0 (M,T);
8d4e33ee:	82 c6 0e 03 	R1 = R6 >>> 0x1f;
8d4e33f2:	20 4d       	R0 >>>= 0x4;
8d4e33f4:	08 52       	R0 = R0 - R1;
8d4e33f6:	08 0d       	CC = R0 <= 0x1;
8d4e33f8:	14 10       	IF !CC JUMP 0x0x8d4e3420;
8d4e33fa:	26 67       	R6 += -0x1c;		/* (-28) */
8d4e33fc:	01 da 49 92 	R1=-1840700269;
8d4e3400:	93 24 00 00 
8d4e3404:	31 c3 71 20 	R1 = R6 * R1 (M,T);
8d4e3408:	82 c6 0e 01 	R0 = R6 >>> 0x1f;
8d4e340c:	21 4d       	R1 >>>= 0x4;
8d4e340e:	01 52       	R0 = R1 - R0;
8d4e3410:	08 0d       	CC = R0 <= 0x1;
8d4e3412:	27 67       	R7 += -0x1c;		/* (-28) */
8d4e3414:	e7 17       	IF !CC JUMP 0x0x8d4e33e2 (BP);
8d4e3416:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e3418:	20 05       	(R7:4) = [SP++];
8d4e341a:	01 e8 00 00 	UNLINK;
8d4e341e:	10 00       	RTS;
8d4e3420:	b5 e6 30 00 	B[SP + 0x30] = R5;
8d4e3424:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e3428:	b8 00 03 00 
8d4e342c:	4f 30       	R1 = FP;
8d4e342e:	67 30       	R4 = FP;
8d4e3430:	21 67       	R1 += -0x1c;		/* (-28) */
8d4e3432:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e3436:	f3 b0 00 00 
8d4e343a:	44 66       	R4 += -0x38;		/* (-56) */
8d4e343c:	7b 60       	R3 = 0xf (X);		/*		R3=0xffffffac(-84) */
8d4e343e:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP + 0x8] = R1 || NOP;
8d4e3442:	b9 b0 00 00 
8d4e3446:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [FP -0x24] = R5 || NOP;
8d4e344a:	75 bb 00 00 
8d4e344e:	83 bb       	[FP -0x20] = R3;
8d4e3450:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3454:	70 e9 00 00 
8d4e3458:	1e 30       	R3 = R6;
8d4e345a:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4e345e:	b8 00 02 00 
8d4e3462:	23 67       	R3 += -0x1c;		/* (-28) */
8d4e3464:	82 ce 0b 03 	R1 = R3 >>> 0x1f || [SP + 0xc] = R2 || NOP;
8d4e3468:	f2 b0 00 00 
8d4e346c:	02 da 49 92 	R2=-1840700269;
8d4e3470:	93 24 00 00 
8d4e3474:	31 c3 da 20 	R3 = R3 * R2 (M,T);
8d4e3478:	23 4d       	R3 >>>= 0x4;
8d4e347a:	04 cc 19 46 	R3 = R3 - R1 (NS) || R1 = [FP + 0xc] || NOP;
8d4e347e:	f9 a0 00 00 
8d4e3482:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0x24] = R3 || NOP;
8d4e3486:	73 b2 00 00 
8d4e348a:	02 60       	R2 = 0x0 (X);		/*		R2=0x54( 84) */
8d4e348c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3490:	70 e9 00 00 
8d4e3494:	7b 60       	R3 = 0xf (X);		/*		R3=0xffffffac(-84) */
8d4e3496:	b5 e6 4c 00 	B[SP + 0x4c] = R5;
8d4e349a:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [FP -0x4] = R3 || NOP;
8d4e349e:	f3 bb 00 00 
8d4e34a2:	e4 64       	R4 += 0x1c;		/* ( 28) */
8d4e34a4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e34a8:	b8 00 03 00 
8d4e34ac:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0xc] = R3 || R4 = [FP + 0x8];
8d4e34b0:	f3 b0 bc a0 
8d4e34b4:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x8] = R5 || NOP;
8d4e34b8:	e5 bb 00 00 
8d4e34bc:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e34c0:	70 e9 00 00 
8d4e34c4:	04 cc 09 42 	R1 = R1 - R1 (NS) || [SP + 0xc] = R4 || R0 = [FP + 0xc];
8d4e34c8:	f4 b0 f8 a0 
8d4e34cc:	72 a2       	R2 = [SP + 0x24];
8d4e34ce:	ff e3 03 fd 	CALL 0x0x8d4e2ed4;
8d4e34d2:	f0 b9       	R0 = [FP -0x4];
8d4e34d4:	83 60       	R3 = 0x10 (X);		/*		R3=0xffffffac(-84) */
8d4e34d6:	03 0a       	CC = R3 <= R0 (IU);
8d4e34d8:	17 18       	IF CC JUMP 0x0x8d4e3506;
8d4e34da:	03 c8 00 18 	MNOP || R0 = [FP -0x20] || [FP -0x8] = R5;
8d4e34de:	80 b9 e5 bb 
8d4e34e2:	82 60       	R2 = 0x10 (X);		/*		R2=0x54( 84) */
8d4e34e4:	79 60       	R1 = 0xf (X);		/*		R1=0xffffffac(-84) */
8d4e34e6:	02 0a       	CC = R2 <= R0 (IU);
8d4e34e8:	b5 e6 4c 00 	B[SP + 0x4c] = R5;
8d4e34ec:	03 c8 00 18 	MNOP || [FP -0x4] = R1 || R0 = [SP + 0x30];
8d4e34f0:	f1 bb 30 a3 
8d4e34f4:	06 18       	IF CC JUMP 0x0x8d4e3500;
8d4e34f6:	75 bb       	[FP -0x24] = R5;
8d4e34f8:	b5 e6 30 00 	B[SP + 0x30] = R5;
8d4e34fc:	7f 2f       	JUMP.S 0x0x8d4e33fa;
8d4e34fe:	00 00       	NOP;
8d4e3500:	ff e3 72 57 	CALL 0x0x8d4ce3e4;
8d4e3504:	f9 2f       	JUMP.S 0x0x8d4e34f6;
8d4e3506:	a0 b9       	R0 = [FP -0x18];
8d4e3508:	ff e3 6e 57 	CALL 0x0x8d4ce3e4;
8d4e350c:	e7 2f       	JUMP.S 0x0x8d4e34da;
8d4e350e:	30 a3       	R0 = [SP + 0x30];
8d4e3510:	ff e3 6a 57 	CALL 0x0x8d4ce3e4;
8d4e3514:	52 2f       	JUMP.S 0x0x8d4e33b8;
8d4e3516:	09 0d       	CC = R1 <= 0x1;
8d4e3518:	7f 1b       	IF CC JUMP 0x0x8d4e3416;
8d4e351a:	03 c8 00 18 	MNOP || R0 = [FP + 0xc] || R1 = [FP + 0xc];
8d4e351e:	f8 a0 f9 a0 
8d4e3522:	38 08       	CC = R0 == R7;
8d4e3524:	79 1b       	IF CC JUMP 0x0x8d4e3416;
8d4e3526:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e3528:	b8 b0       	[FP + 0x8] = R0;
8d4e352a:	38 08       	CC = R0 == R7;
8d4e352c:	75 1b       	IF CC JUMP 0x0x8d4e3416;
8d4e352e:	f8 a0       	R0 = [FP + 0xc];
8d4e3530:	21 67       	R1 += -0x1c;		/* (-28) */
8d4e3532:	03 c8 00 18 	MNOP || R2 = [FP + 0x8] || [FP + 0x10] = R0;
8d4e3536:	ba a0 38 b1 
8d4e353a:	b0 b2       	[SP + 0x28] = R0;
8d4e353c:	31 b2       	[SP + 0x20] = R1;
8d4e353e:	72 b2       	[SP + 0x24] = R2;
8d4e3540:	01 60       	R1 = 0x0 (X);		/*		R1=0xffffffac(-84) */
8d4e3542:	b1 e6 30 00 	B[SP + 0x30] = R1;
8d4e3546:	6f 30       	R5 = FP;
8d4e3548:	45 66       	R5 += -0x38;		/* (-56) */
8d4e354a:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0006;
8d4e354e:	b8 00 06 00 
8d4e3552:	7b 60       	R3 = 0xf (X);		/*		R3=0xffffffac(-84) */
8d4e3554:	04 cc 24 48 	R4 = R4 - R4 (NS) || [FP -0x20] = R3 || R1 = [SP + 0x24];
8d4e3558:	83 bb 71 a2 
8d4e355c:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [SP + 0xc] = R6 || R6 = [SP + 0x24];
8d4e3560:	f6 b0 76 a2 
8d4e3564:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x24] = R4 || R4 = [SP + 0x20];
8d4e3568:	74 bb 34 a2 
8d4e356c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3570:	70 e9 00 00 
8d4e3574:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || R1 = [FP + 0xc] || NOP;
8d4e3578:	f9 a0 00 00 
8d4e357c:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e3580:	32 41 00 00 
8d4e3584:	80 0c       	CC = R0 < 0x0;
8d4e3586:	71 10       	IF !CC JUMP 0x0x8d4e3668;
8d4e3588:	03 c8 00 18 	MNOP || R0 = [FP + 0xc] || R1 = [SP + 0x24];
8d4e358c:	f8 a0 71 a2 
8d4e3590:	01 08       	CC = R1 == R0;
8d4e3592:	39 18       	IF CC JUMP 0x0x8d4e3604;
8d4e3594:	03 c8 00 18 	MNOP || R1 = [SP + 0x28] || R3 = [FP + 0x8];
8d4e3598:	b1 a2 bb a0 
8d4e359c:	01 08       	CC = R1 == R0;
8d4e359e:	d8 60       	R0 = 0x1b (X);		/*		R0=0x54( 84) */
8d4e35a0:	04 cc 03 40 	R0 = R0 - R3 (NS) || R4 = [SP + 0x24] || R1 = [FP + 0x10];
8d4e35a4:	74 a2 39 a1 
8d4e35a8:	04 cc 20 00 	R0 = R4 + R0 (NS) || R6 = [FP + 0x10] || NOP;
8d4e35ac:	3e a1 00 00 
8d4e35b0:	10 4e       	R0 >>= 0x2;
8d4e35b2:	02 da 92 24 	R2=613566757;
8d4e35b6:	25 49 00 00 
8d4e35ba:	b1 c2 02 21 	R4 = R0 * R2 (TFU);
8d4e35be:	15 18       	IF CC JUMP 0x0x8d4e35e8;
8d4e35c0:	06 30       	R0 = R6;
8d4e35c2:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e35c6:	b8 00 03 00 
8d4e35ca:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4e35ce:	f3 b0 00 00 
8d4e35d2:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e35d4:	02 60       	R2 = 0x0 (X);		/*		R2=0x54( 84) */
8d4e35d6:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e35da:	70 e9 00 00 
8d4e35de:	fc 67       	R4 += -0x1;		/* ( -1) */
8d4e35e0:	04 0c       	CC = R4 == 0x0;
8d4e35e2:	26 67       	R6 += -0x1c;		/* (-28) */
8d4e35e4:	ee 17       	IF !CC JUMP 0x0x8d4e35c0 (BP);
8d4e35e6:	0e 30       	R1 = R6;
8d4e35e8:	01 30       	R0 = R1;
8d4e35ea:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e35ee:	b8 00 03 00 
8d4e35f2:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e35f6:	f3 b0 00 00 
8d4e35fa:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e35fc:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3600:	70 e9 00 00 
8d4e3604:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e3608:	b8 00 03 00 
8d4e360c:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || [SP + 0xc] = R3 || R0 = [FP + 0xc];
8d4e3610:	f3 b0 f8 a0 
8d4e3614:	02 60       	R2 = 0x0 (X);		/*		R2=0x54( 84) */
8d4e3616:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e361a:	70 e9 00 00 
8d4e361e:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || R0 = [FP -0x20] || NOP;
8d4e3622:	80 b9 00 00 
8d4e3626:	81 60       	R1 = 0x10 (X);		/*		R1=0xffffffac(-84) */
8d4e3628:	01 0a       	CC = R1 <= R0 (IU);
8d4e362a:	1b 18       	IF CC JUMP 0x0x8d4e3660;
8d4e362c:	03 c8 00 18 	MNOP || R0 = [SP + 0x24] || R1 = [FP + 0x10];
8d4e3630:	70 a2 39 a1 
8d4e3634:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R2 = [SP + 0x20] || R3 = [SP + 0x28];
8d4e3638:	32 a2 b3 a2 
8d4e363c:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e363e:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4e3640:	e3 64       	R3 += 0x1c;		/* ( 28) */
8d4e3642:	e2 64       	R2 += 0x1c;		/* ( 28) */
8d4e3644:	38 08       	CC = R0 == R7;
8d4e3646:	75 bb       	[FP -0x24] = R5;
8d4e3648:	b6 e6 30 00 	B[SP + 0x30] = R6;
8d4e364c:	70 b2       	[SP + 0x24] = R0;
8d4e364e:	39 b1       	[FP + 0x10] = R1;
8d4e3650:	b3 b2       	[SP + 0x28] = R3;
8d4e3652:	32 b2       	[SP + 0x20] = R2;
8d4e3654:	76 17       	IF !CC JUMP 0x0x8d4e3540 (BP);
8d4e3656:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e3658:	20 05       	(R7:4) = [SP++];
8d4e365a:	01 e8 00 00 	UNLINK;
8d4e365e:	10 00       	RTS;
8d4e3660:	30 a3       	R0 = [SP + 0x30];
8d4e3662:	ff e3 c1 56 	CALL 0x0x8d4ce3e4;
8d4e3666:	e3 2f       	JUMP.S 0x0x8d4e362c;
8d4e3668:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || R1 = [SP + 0x28] || NOP;
8d4e366c:	b1 a2 00 00 
8d4e3670:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e3674:	32 41 00 00 
8d4e3678:	80 0c       	CC = R0 < 0x0;
8d4e367a:	1c 10       	IF !CC JUMP 0x0x8d4e36b2;
8d4e367c:	b3 a2       	R3 = [SP + 0x28];
8d4e367e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4e3682:	b8 00 02 00 
8d4e3686:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0xc] = R2 || NOP;
8d4e368a:	f2 b0 00 00 
8d4e368e:	0b 30       	R1 = R3;
8d4e3690:	c0 65       	R0 += 0x38;		/* ( 56) */
8d4e3692:	02 60       	R2 = 0x0 (X);		/*		R2=0x54( 84) */
8d4e3694:	33 30       	R6 = R3;
8d4e3696:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e369a:	70 e9 00 00 
8d4e369e:	0c 30       	R1 = R4;
8d4e36a0:	05 30       	R0 = R5;
8d4e36a2:	00 de 0a 8c 	CALL.A 0x8c0a4132;
8d4e36a6:	32 41 00 00 
8d4e36aa:	80 0c       	CC = R0 < 0x0;
8d4e36ac:	1c 30       	R3 = R4;
8d4e36ae:	24 67       	R4 += -0x1c;		/* (-28) */
8d4e36b0:	e7 1f       	IF CC JUMP 0x0x8d4e367e (BP);
8d4e36b2:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e36b6:	b8 00 03 00 
8d4e36ba:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4e36be:	f3 b0 00 00 
8d4e36c2:	0d 30       	R1 = R5;
8d4e36c4:	02 60       	R2 = 0x0 (X);		/*		R2=0x54( 84) */
8d4e36c6:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e36ca:	70 e9 00 00 
8d4e36ce:	a8 2f       	JUMP.S 0x0x8d4e361e;
8d4e36d0:	08 32       	P1 = R0;
8d4e36d2:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e36d6:	f4 05       	[--SP] = (R7:6, P5:4);
8d4e36d8:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e36da:	01 34       	I0 = R1;
8d4e36dc:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || P0 = [P1 + 0x4] || NOP;
8d4e36e0:	48 ac 00 00 
8d4e36e4:	45 ac       	P5 = [P0 + 0x4];
8d4e36e6:	50 32       	P2 = P0;
8d4e36e8:	a9 e5 2d 00 	R1 = B[P5 + 0x2d] (X);
8d4e36ec:	01 0c       	CC = R1 == 0x0;
8d4e36ee:	0f 10       	IF !CC JUMP 0x0x8d4e370c;
8d4e36f0:	02 9d       	R2 = [I0];
8d4e36f2:	4d 32       	P1 = P5;
8d4e36f4:	c0 e0 0a 00 	LSETUP_IMM(bottom=0x8d4e3708) LC0 count_fields=0x0/0x0;
8d4e36f8:	cb a0       	R3 = [P1 + 0xc];
8d4e36fa:	93 09       	CC = R3 < R2 (IU);
8d4e36fc:	64 10       	IF !CC JUMP 0x0x8d4e37c4;
8d4e36fe:	41 6c       	P1 += 0x8;		/* (  8) */
8d4e3700:	49 91       	P1 = [P1];
8d4e3702:	8b e5 2d 00 	R3 = B[P1 + 0x2d] (X);
8d4e3706:	03 0c       	CC = R3 == 0x0;
8d4e3708:	02 10       	IF !CC JUMP 0x0x8d4e370c;
8d4e370a:	f5 2f       	JUMP.S 0x0x8d4e36f4;
8d4e370c:	92 e5 2d 00 	R2 = B[P2 + 0x2d] (X);
8d4e3710:	02 0c       	CC = R2 == 0x0;
8d4e3712:	04 10       	IF !CC JUMP 0x0x8d4e371a;
8d4e3714:	55 91       	P5 = [P2];
8d4e3716:	a9 e5 2d 00 	R1 = B[P5 + 0x2d] (X);
8d4e371a:	01 0c       	CC = R1 == 0x0;
8d4e371c:	13 10       	IF !CC JUMP 0x0x8d4e3742;
8d4e371e:	01 9d       	R1 = [I0];
8d4e3720:	4a 32       	P1 = P2;
8d4e3722:	c0 e0 0e 00 	LSETUP_IMM(bottom=0x8d4e373e) LC0 count_fields=0x0/0x0;
8d4e3726:	ea a0       	R2 = [P5 + 0xc];
8d4e3728:	65 32       	P4 = P5;
8d4e372a:	91 09       	CC = R1 < R2 (IU);
8d4e372c:	45 6c       	P5 += 0x8;		/* (  8) */
8d4e372e:	54 32       	P2 = P4;
8d4e3730:	e5 06       	IF !CC P4 = P5;
8d4e3732:	d1 06       	IF !CC P2 = P1;
8d4e3734:	65 91       	P5 = [P4];
8d4e3736:	aa e5 2d 00 	R2 = B[P5 + 0x2d] (X);
8d4e373a:	02 0c       	CC = R2 == 0x0;
8d4e373c:	03 10       	IF !CC JUMP 0x0x8d4e3742;
8d4e373e:	4a 32       	P1 = P2;
8d4e3740:	f0 2f       	JUMP.S 0x0x8d4e3720;
8d4e3742:	50 08       	CC = P0 == P2;
8d4e3744:	23 18       	IF CC JUMP 0x0x8d4e378a;
8d4e3746:	68 32       	P5 = P0;
8d4e3748:	a9 e5 2d 00 	R1 = B[P5 + 0x2d] (X);
8d4e374c:	d0 e0 1c 00 	LSETUP_IMM(bottom=0x8d4e3784) LC1 count_fields=0x0/0x0;
8d4e3750:	01 0c       	CC = R1 == 0x0;
8d4e3752:	0f 64       	R7 += 0x1;		/* (  1) */
8d4e3754:	16 10       	IF !CC JUMP 0x0x8d4e3780;
8d4e3756:	ac ac       	P4 = [P5 + 0x8];
8d4e3758:	a1 e5 2d 00 	R1 = B[P4 + 0x2d] (X);
8d4e375c:	01 0c       	CC = R1 == 0x0;
8d4e375e:	21 10       	IF !CC JUMP 0x0x8d4e37a0;
8d4e3760:	61 91       	P1 = [P4];
8d4e3762:	6c 32       	P5 = P4;
8d4e3764:	89 e5 2d 00 	R1 = B[P1 + 0x2d] (X);
8d4e3768:	01 0c       	CC = R1 == 0x0;
8d4e376a:	0b 10       	IF !CC JUMP 0x0x8d4e3780;
8d4e376c:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4e377a) LC0 count_fields=0x0/0x0;
8d4e3770:	69 32       	P5 = P1;
8d4e3772:	69 91       	P1 = [P5];
8d4e3774:	89 e5 2d 00 	R1 = B[P1 + 0x2d] (X);
8d4e3778:	01 0c       	CC = R1 == 0x0;
8d4e377a:	03 10       	IF !CC JUMP 0x0x8d4e3780;
8d4e377c:	69 91       	P1 = [P5];
8d4e377e:	f7 2f       	JUMP.S 0x0x8d4e376c;
8d4e3780:	6a 08       	CC = P2 == P5;
8d4e3782:	04 18       	IF CC JUMP 0x0x8d4e378a;
8d4e3784:	a9 e5 2d 00 	R1 = B[P5 + 0x2d] (X);
8d4e3788:	e0 2f       	JUMP.S 0x0x8d4e3748;
8d4e378a:	52 30       	R2 = P2;
8d4e378c:	48 30       	R1 = P0;
8d4e378e:	ff e3 c5 f4 	CALL 0x0x8d4e2118;
8d4e3792:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e3794:	07 30       	R0 = R7;
8d4e3796:	b4 05       	(R7:6, P5:4) = [SP++];
8d4e3798:	01 e8 00 00 	UNLINK;
8d4e379c:	10 00       	RTS;
8d4e379e:	00 00       	NOP;
8d4e37a0:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d4e37b6) LC0 count_fields=0x0/0x0;
8d4e37a4:	69 ac       	P1 = [P5 + 0x4];
8d4e37a6:	89 e5 2d 00 	R1 = B[P1 + 0x2d] (X);
8d4e37aa:	01 0c       	CC = R1 == 0x0;
8d4e37ac:	09 10       	IF !CC JUMP 0x0x8d4e37be;
8d4e37ae:	4d 30       	R1 = P5;
8d4e37b0:	8a a0       	R2 = [P1 + 0x8];
8d4e37b2:	0a 08       	CC = R2 == R1;
8d4e37b4:	03 10       	IF !CC JUMP 0x0x8d4e37ba;
8d4e37b6:	69 32       	P5 = P1;
8d4e37b8:	f4 2f       	JUMP.S 0x0x8d4e37a0;
8d4e37ba:	69 32       	P5 = P1;
8d4e37bc:	e2 2f       	JUMP.S 0x0x8d4e3780;
8d4e37be:	69 32       	P5 = P1;
8d4e37c0:	e0 2f       	JUMP.S 0x0x8d4e3780;
8d4e37c2:	00 00       	NOP;
8d4e37c4:	96 e5 2d 00 	R6 = B[P2 + 0x2d] (X);
8d4e37c8:	06 0c       	CC = R6 == 0x0;
8d4e37ca:	03 18       	IF CC JUMP 0x0x8d4e37d0;
8d4e37cc:	9a 09       	CC = R2 < R3 (IU);
8d4e37ce:	d1 07       	IF CC P2 = P1;
8d4e37d0:	41 32       	P0 = P1;
8d4e37d2:	97 2f       	JUMP.S 0x0x8d4e3700;
8d4e37d4:	00 e8 23 00 	LINK 0x8c;		/* (140) */
8d4e37d8:	e3 05       	[--SP] = (R7:4, P5:3);
8d4e37da:	86 6f       	SP += -0x10;		/* (-16) */
8d4e37dc:	04 cc 36 4c 	R6 = R6 - R6 (NS) || P1 = [FP + 0x14] || [FP + 0x10] = R1;
8d4e37e0:	79 ad 39 b1 
8d4e37e4:	7d 60       	R5 = 0xf (X);		/*		R5=0x54( 84) */
8d4e37e6:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e37e8:	03 c8 00 18 	MNOP || P0 = [P1 + 0x8] || R0 = [P1 + 0x4];
8d4e37ec:	88 ac 48 a0 
8d4e37f0:	b8 bc       	[FP + 0x8] = P0;
8d4e37f2:	4d ac       	P5 = [P1 + 0x4];
8d4e37f4:	ba a0       	R2 = [FP + 0x8];
8d4e37f6:	10 08       	CC = R0 == R2;
8d4e37f8:	4a 18       	IF CC JUMP 0x0x8d4e388c;
8d4e37fa:	46 30       	R0 = SP;
8d4e37fc:	62 61       	R2 = 0x2c (X);		/*		R2=0x54( 84) */
8d4e37fe:	b6 e6 30 00 	B[SP + 0x30] = R6;
8d4e3802:	04 cc 02 00 	R0 = R0 + R2 (NS) || [FP -0x74] = R5 || NOP;
8d4e3806:	35 ba 00 00 
8d4e380a:	04 cc 24 48 	R4 = R4 - R4 (NS) || [FP -0x78] = R6 || NOP;
8d4e380e:	26 ba 00 00 
8d4e3812:	01 da 03 84 	R1=-2080149268;
8d4e3816:	ec 70 00 00 
8d4e381a:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e381e:	76 a3 00 00 
8d4e3822:	03 c8 00 18 	MNOP || R1 = [P5 + 0x14] || R0 = [FP -0x78];
8d4e3826:	69 a1 20 b8 
8d4e382a:	81 09       	CC = R1 < R0 (IU);
8d4e382c:	19 32       	P3 = R1;
8d4e382e:	1f 18       	IF CC JUMP 0x0x8d4e386c;
8d4e3830:	03 c8 00 18 	MNOP || P4 = [SP + 0x30] || R2 = [FP -0x74];
8d4e3834:	34 af 32 b8 
8d4e3838:	82 69       	P2 = 0x30 (X);		/*		P2=0x0(  0) */
8d4e383a:	17 0a       	CC = R7 <= R2 (IU);
8d4e383c:	96 5a       	P2 = SP + P2;
8d4e383e:	d4 07       	IF CC P2 = P4;
8d4e3840:	00 32       	P0 = R0;
8d4e3842:	ab a1       	R3 = [P5 + 0x18];
8d4e3844:	4d 32       	P1 = P5;
8d4e3846:	1f 0a       	CC = R7 <= R3 (IU);
8d4e3848:	21 6c       	P1 += 0x4;		/* (  4) */
8d4e384a:	02 5b       	P4 = P2 + P0;
8d4e384c:	02 10       	IF !CC JUMP 0x0x8d4e3850;
8d4e384e:	69 ac       	P1 = [P5 + 0x4];
8d4e3850:	62 08       	CC = P2 == P4;
8d4e3852:	fc 6f       	P4 += -0x1;		/* ( -1) */
8d4e3854:	59 5a       	P1 = P1 + P3;
8d4e3856:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d4e3858:	09 18       	IF CC JUMP 0x0x8d4e386a;
8d4e385a:	a2 e0 07 00 	LSETUP(0x8d4e385e, 0x8d4e3868) LC0 = P0;
8d4e385e:	03 c8 00 18 	MNOP || R0 = B[P4--] (X) || R1 = B[P1--] (X);
8d4e3862:	e0 98 c9 98 
8d4e3866:	08 08       	CC = R0 == R1;
8d4e3868:	02 10       	IF !CC JUMP 0x0x8d4e386c;
8d4e386a:	0c 60       	R4 = 0x1 (X);		/*		R4=0x54( 84) */
8d4e386c:	30 b8       	R0 = [FP -0x74];
8d4e386e:	07 0a       	CC = R7 <= R0 (IU);
8d4e3870:	55 18       	IF CC JUMP 0x0x8d4e391a;
8d4e3872:	04 0c       	CC = R4 == 0x0;
8d4e3874:	03 c8 00 18 	MNOP || [FP -0x74] = R5 || R1 = [FP + 0x10];
8d4e3878:	35 ba 39 a1 
8d4e387c:	26 ba       	[FP -0x78] = R6;
8d4e387e:	b6 e6 30 00 	B[SP + 0x30] = R6;
8d4e3882:	0a 10       	IF !CC JUMP 0x0x8d4e3896;
8d4e3884:	b9 ac       	P1 = [FP + 0x8];
8d4e3886:	e5 6c       	P5 += 0x1c;		/* ( 28) */
8d4e3888:	69 08       	CC = P1 == P5;
8d4e388a:	b8 17       	IF !CC JUMP 0x0x8d4e37fa (BP);
8d4e388c:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e388e:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e3890:	01 e8 00 00 	UNLINK;
8d4e3894:	10 00       	RTS;
8d4e3896:	46 30       	R0 = SP;
8d4e3898:	23 e1 48 00 	R3 = 0x48 (X);		/*		R3=0x48( 72) */
8d4e389c:	67 30       	R4 = FP;
8d4e389e:	18 50       	R0 = R0 + R3;
8d4e38a0:	24 67       	R4 += -0x1c;		/* (-28) */
8d4e38a2:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [FP + 0xc] = R0 || NOP;
8d4e38a6:	f8 b0 00 00 
8d4e38aa:	55 30       	R2 = P5;
8d4e38ac:	06 e3 fd 07 	CALL 0x0x8d5a48a6;
8d4e38b0:	b6 e6 4c 00 	B[SP + 0x4c] = R6;
8d4e38b4:	b6 e6 68 00 	B[SP + 0x68] = R6;
8d4e38b8:	b6 e6 84 00 	B[SP + 0x84] = R6;
8d4e38bc:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [FP -0x40] = R6 || NOP;
8d4e38c0:	06 bb 00 00 
8d4e38c4:	24 67       	R4 += -0x1c;		/* (-28) */
8d4e38c6:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e38ca:	b8 00 03 00 
8d4e38ce:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0xc] = R3 || NOP;
8d4e38d2:	f3 b0 00 00 
8d4e38d6:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x20] = R5 || NOP;
8d4e38da:	85 bb 00 00 
8d4e38de:	76 bb       	[FP -0x24] = R6;
8d4e38e0:	a5 ba       	[FP -0x58] = R5;
8d4e38e2:	96 ba       	[FP -0x5c] = R6;
8d4e38e4:	15 bb       	[FP -0x3c] = R5;
8d4e38e6:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e38ea:	70 e9 00 00 
8d4e38ee:	f9 a0       	R1 = [FP + 0xc];
8d4e38f0:	00 da 29 84 	R0=-2077631692;
8d4e38f4:	34 db 00 00 
8d4e38f8:	ff e3 f4 f9 	CALL 0x0x8d4e2ce0;
8d4e38fc:	f8 a0       	R0 = [FP + 0xc];
8d4e38fe:	ff e3 45 ed 	CALL 0x0x8d4e1388;
8d4e3902:	f0 b9       	R0 = [FP -0x4];
8d4e3904:	07 0a       	CC = R7 <= R0 (IU);
8d4e3906:	06 18       	IF CC JUMP 0x0x8d4e3912;
8d4e3908:	f5 bb       	[FP -0x4] = R5;
8d4e390a:	e6 bb       	[FP -0x8] = R6;
8d4e390c:	b6 e6 a0 00 	B[SP + 0xa0] = R6;
8d4e3910:	ba 2f       	JUMP.S 0x0x8d4e3884;
8d4e3912:	a0 b9       	R0 = [FP -0x18];
8d4e3914:	ff e3 68 55 	CALL 0x0x8d4ce3e4;
8d4e3918:	f8 2f       	JUMP.S 0x0x8d4e3908;
8d4e391a:	30 a3       	R0 = [SP + 0x30];
8d4e391c:	ff e3 64 55 	CALL 0x0x8d4ce3e4;
8d4e3920:	a9 2f       	JUMP.S 0x0x8d4e3872;
8d4e3922:	00 00       	NOP;
8d4e3924:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d4e3928:	ec 05       	[--SP] = (R7:5, P5:4);
8d4e392a:	6f 30       	R5 = FP;
8d4e392c:	86 6f       	SP += -0x10;		/* (-16) */
8d4e392e:	45 64       	R5 += 0x8;		/* (  8) */
8d4e3930:	7b 61       	R3 = 0x2f (X);		/*		R3=0x48( 72) */
8d4e3932:	0d 68       	P5 = 0x1 (X);		/*		P5=0x0(  0) */
8d4e3934:	82 ce 05 c2 	R1 = ROT R5 BY 0x0 || [FP + 0x10] = R1 || NOP;
8d4e3938:	39 b1 00 00 
8d4e393c:	b3 e6 48 00 	B[SP + 0x48] = R3;
8d4e3940:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = P5 || NOP;
8d4e3944:	f5 bc 00 00 
8d4e3948:	04 cc 36 4c 	R6 = R6 - R6 (NS) || [FP + 0xc] = R0 || NOP;
8d4e394c:	f8 b0 00 00 
8d4e3950:	ff e3 00 ec 	CALL 0x0x8d4e1150;
8d4e3954:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d4e3958:	b8 00 01 00 
8d4e395c:	08 08       	CC = R0 == R1;
8d4e395e:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P4 = [FP + 0xc] || NOP;
8d4e3962:	fc ac 00 00 
8d4e3966:	16 18       	IF CC JUMP 0x0x8d4e3992;
8d4e3968:	37 08       	CC = R7 == R6;
8d4e396a:	4f 10       	IF !CC JUMP 0x0x8d4e3a08;
8d4e396c:	82 ce 07 cc 	R6 = ROT R7 BY 0x0 || [SP + 0xc] = P5 || R0 = [FP + 0xc];
8d4e3970:	f5 bc f8 a0 
8d4e3974:	79 61       	R1 = 0x2f (X);		/*		R1=0xffffffac(-84) */
8d4e3976:	0e 64       	R6 += 0x1;		/* (  1) */
8d4e3978:	b1 e6 48 00 	B[SP + 0x48] = R1;
8d4e397c:	16 30       	R2 = R6;
8d4e397e:	0d 30       	R1 = R5;
8d4e3980:	ff e3 e8 eb 	CALL 0x0x8d4e1150;
8d4e3984:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d4e3988:	b8 00 01 00 
8d4e398c:	08 08       	CC = R0 == R1;
8d4e398e:	38 30       	R7 = R0;
8d4e3990:	ec 17       	IF !CC JUMP 0x0x8d4e3968 (BP);
8d4e3992:	03 c8 00 18 	MNOP || R0 = [P4 + 0x14] || R1 = [FP + 0xc];
8d4e3996:	60 a1 f9 a0 
8d4e399a:	86 09       	CC = R6 < R0 (IU);
8d4e399c:	06 18       	IF CC JUMP 0x0x8d4e39a8;
8d4e399e:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e39a0:	ac 05       	(R7:5, P5:4) = [SP++];
8d4e39a2:	01 e8 00 00 	UNLINK;
8d4e39a6:	10 00       	RTS;
8d4e39a8:	7f 30       	R7 = FP;
8d4e39aa:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4e39ae:	b8 00 02 00 
8d4e39b2:	27 67       	R7 += -0x1c;		/* (-28) */
8d4e39b4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R2 || NOP;
8d4e39b8:	f2 b0 00 00 
8d4e39bc:	16 30       	R2 = R6;
8d4e39be:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d4e39c2:	a6 ec 00 00 
8d4e39c6:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e39ca:	38 a1 00 00 
8d4e39ce:	00 de 03 8c 	CALL.A 0x8c03fd94;
8d4e39d2:	94 fd 00 00 
8d4e39d6:	83 60       	R3 = 0x10 (X);		/*		R3=0x48( 72) */
8d4e39d8:	f0 a3       	R0 = [SP + 0x3c];
8d4e39da:	03 0a       	CC = R3 <= R0 (IU);
8d4e39dc:	09 18       	IF CC JUMP 0x0x8d4e39ee;
8d4e39de:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e39e0:	b0 e6 28 00 	B[SP + 0x28] = R0;
8d4e39e4:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e39e6:	ac 05       	(R7:5, P5:4) = [SP++];
8d4e39e8:	01 e8 00 00 	UNLINK;
8d4e39ec:	10 00       	RTS;
8d4e39ee:	b0 a2       	R0 = [SP + 0x28];
8d4e39f0:	ff e3 fa 54 	CALL 0x0x8d4ce3e4;
8d4e39f4:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e39f6:	b0 e6 28 00 	B[SP + 0x28] = R0;
8d4e39fa:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e39fc:	ac 05       	(R7:5, P5:4) = [SP++];
8d4e39fe:	01 e8 00 00 	UNLINK;
8d4e3a02:	10 00       	RTS;
8d4e3a04:	00 00       	NOP;
8d4e3a06:	00 00       	NOP;
8d4e3a08:	04 cc 3e 40 	R0 = R7 - R6 (NS) || R1 = [FP + 0xc] || NOP;
8d4e3a0c:	f9 a0 00 00 
8d4e3a10:	82 ce 06 c4 	R2 = ROT R6 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d4e3a14:	f0 b0 00 00 
8d4e3a18:	77 30       	R6 = FP;
8d4e3a1a:	26 67       	R6 += -0x1c;		/* (-28) */
8d4e3a1c:	06 30       	R0 = R6;
8d4e3a1e:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d4e3a22:	a6 ec 00 00 
8d4e3a26:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e3a2a:	38 a1 00 00 
8d4e3a2e:	00 de 03 8c 	CALL.A 0x8c03fd94;
8d4e3a32:	94 fd 00 00 
8d4e3a36:	f0 a3       	R0 = [SP + 0x3c];
8d4e3a38:	83 60       	R3 = 0x10 (X);		/*		R3=0x48( 72) */
8d4e3a3a:	03 0a       	CC = R3 <= R0 (IU);
8d4e3a3c:	0d 18       	IF CC JUMP 0x0x8d4e3a56;
8d4e3a3e:	7a 60       	R2 = 0xf (X);		/*		R2=0x54( 84) */
8d4e3a40:	04 cc 09 42 	R1 = R1 - R1 (NS) || [SP + 0x3c] = R2 || NOP;
8d4e3a44:	f2 b3 00 00 
8d4e3a48:	04 cc 00 40 	R0 = R0 - R0 (NS) || [SP + 0x38] = R1 || NOP;
8d4e3a4c:	b1 b3 00 00 
8d4e3a50:	b0 e6 28 00 	B[SP + 0x28] = R0;
8d4e3a54:	8c 2f       	JUMP.S 0x0x8d4e396c;
8d4e3a56:	b0 a2       	R0 = [SP + 0x28];
8d4e3a58:	ff e3 c6 54 	CALL 0x0x8d4ce3e4;
8d4e3a5c:	f1 2f       	JUMP.S 0x0x8d4e3a3e;
8d4e3a5e:	00 00       	NOP;
8d4e3a60:	00 e8 2a 00 	LINK 0xa8;		/* (168) */
8d4e3a64:	e3 05       	[--SP] = (R7:4, P5:3);
8d4e3a66:	86 6f       	SP += -0x10;		/* (-16) */
8d4e3a68:	27 e1 64 00 	R7 = 0x64 (X);		/*		R7=0x64(100) */
8d4e3a6c:	5e 30       	R3 = SP;
8d4e3a6e:	04 cc 1f 06 	R3 = R3 + R7 (NS) || [FP + 0x10] = R1 || NOP;
8d4e3a72:	39 b1 00 00 
8d4e3a76:	33 e6 11 00 	[SP + 0x44] = R3;
8d4e3a7a:	04 cc 36 4c 	R6 = R6 - R6 (NS) || P4 = [FP + 0x10] || [FP + 0xc] = R2;
8d4e3a7e:	3c ad fa b0 
8d4e3a82:	03 c8 00 18 	MNOP || P5 = [FP + 0xc] || [FP -0x6c] = R6;
8d4e3a86:	fd ac 56 ba 
8d4e3a8a:	76 ba       	[FP -0x64] = R6;
8d4e3a8c:	66 ba       	[FP -0x68] = R6;
8d4e3a8e:	31 e4 11 00 	R1 = [SP + 0x44];
8d4e3a92:	ff e3 49 ff 	CALL 0x0x8d4e3924;
8d4e3a96:	03 c8 00 18 	MNOP || R2 = [FP -0x68] || R1 = [FP -0x6c];
8d4e3a9a:	62 b8 51 b8 
8d4e3a9e:	0a 52       	R0 = R2 - R1;
8d4e3aa0:	03 da 49 92 	R3=-1840700269;
8d4e3aa4:	93 24 00 00 
8d4e3aa8:	31 c3 c3 20 	R3 = R0 * R3 (M,T);
8d4e3aac:	82 c6 08 0f 	R7 = R0 >>> 0x1f;
8d4e3ab0:	23 4d       	R3 >>>= 0x4;
8d4e3ab2:	3b 52       	R0 = R3 - R7;
8d4e3ab4:	30 0e       	CC = R0 <= 0x6 (IU);
8d4e3ab6:	0b da 03 84 	P3=-2080149256;
8d4e3aba:	f8 70 00 00 
8d4e3abe:	57 18       	IF CC JUMP 0x0x8d4e3b6c;
8d4e3ac0:	00 da 03 84 	R0=-2080149256;
8d4e3ac4:	f8 70 00 00 
8d4e3ac8:	e0 67       	R0 += -0x4;		/* ( -4) */
8d4e3aca:	b8 b0       	[FP + 0x8] = R0;
8d4e3acc:	0c 60       	R4 = 0x1 (X);		/*		R4=0x54( 84) */
8d4e3ace:	e7 60       	R7 = 0x1c (X);		/*		R7=0x64(100) */
8d4e3ad0:	8a 52       	R2 = R2 - R1;
8d4e3ad2:	03 da 49 92 	R3=-1840700269;
8d4e3ad6:	93 24 00 00 
8d4e3ada:	31 c3 d3 20 	R3 = R2 * R3 (M,T);
8d4e3ade:	82 c6 0a 01 	R0 = R2 >>> 0x1f;
8d4e3ae2:	23 4d       	R3 >>>= 0x4;
8d4e3ae4:	83 52       	R2 = R3 - R0;
8d4e3ae6:	94 09       	CC = R4 < R2 (IU);
8d4e3ae8:	2c 30       	R5 = R4;
8d4e3aea:	07 30       	R0 = R7;
8d4e3aec:	0c 64       	R4 += 0x1;		/* (  1) */
8d4e3aee:	e7 64       	R7 += 0x1c;		/* ( 28) */
8d4e3af0:	04 1c       	IF CC JUMP 0x0x8d4e3af8 (BP);
8d4e3af2:	52 24       	JUMP.S 0x0x8d4e4396;
8d4e3af4:	00 00       	NOP;
8d4e3af6:	00 00       	NOP;
8d4e3af8:	04 cc 08 00 	R0 = R1 + R0 (NS) || R1 = [FP + 0x8] || NOP;
8d4e3afc:	b9 a0 00 00 
8d4e3b00:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4e3b04:	88 bf 00 00 
8d4e3b08:	00 0c       	CC = R0 == 0x0;
8d4e3b0a:	03 c8 00 18 	MNOP || R2 = [FP -0x68] || R1 = [FP -0x6c];
8d4e3b0e:	62 b8 51 b8 
8d4e3b12:	df 1f       	IF CC JUMP 0x0x8d4e3ad0 (BP);
8d4e3b14:	e0 60       	R0 = 0x1c (X);		/*		R0=0x54( 84) */
8d4e3b16:	71 c2 28 21 	R4 = R5 * R0 (IS,NS);
8d4e3b1a:	15 64       	R5 += 0x2;		/* (  2) */
8d4e3b1c:	c4 65       	R4 += 0x38;		/* ( 56) */
8d4e3b1e:	82 ce 05 ce 	R7 = ROT R5 BY 0x0 || R0 = [FP -0x68] || R2 = [FP -0x6c];
8d4e3b22:	60 b8 52 b8 
8d4e3b26:	10 52       	R0 = R0 - R2;
8d4e3b28:	03 da 49 92 	R3=-1840700269;
8d4e3b2c:	93 24 00 00 
8d4e3b30:	31 c3 c3 20 	R3 = R0 * R3 (M,T);
8d4e3b34:	f8 4d       	R0 >>>= 0x1f;
8d4e3b36:	23 4d       	R3 >>>= 0x4;
8d4e3b38:	03 52       	R0 = R3 - R0;
8d4e3b3a:	0c 30       	R1 = R4;
8d4e3b3c:	87 09       	CC = R7 < R0 (IU);
8d4e3b3e:	0d 64       	R5 += 0x1;		/* (  1) */
8d4e3b40:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4e3b42:	02 1c       	IF CC JUMP 0x0x8d4e3b46 (BP);
8d4e3b44:	27 24       	JUMP.S 0x0x8d4e4392;
8d4e3b46:	22 50       	R0 = R2 + R4;
8d4e3b48:	21 30       	R4 = R1;
8d4e3b4a:	01 da 03 84 	R1=-2080149256;
8d4e3b4e:	f8 70 00 00 
8d4e3b52:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4e3b56:	88 bf 00 00 
8d4e3b5a:	00 0c       	CC = R0 == 0x0;
8d4e3b5c:	e1 1f       	IF CC JUMP 0x0x8d4e3b1e (BP);
8d4e3b5e:	07 0c       	CC = R7 == 0x0;
8d4e3b60:	03 c8 00 18 	MNOP || R2 = [FP -0x68] || R1 = [FP -0x6c];
8d4e3b64:	62 b8 51 b8 
8d4e3b68:	02 1c       	IF CC JUMP 0x0x8d4e3b6c (BP);
8d4e3b6a:	7f 22       	JUMP.S 0x0x8d4e4068;
8d4e3b6c:	0a 52       	R0 = R2 - R1;
8d4e3b6e:	07 da 49 92 	R7=-1840700269;
8d4e3b72:	93 24 00 00 
8d4e3b76:	31 c3 c7 21 	R7 = R0 * R7 (M,T);
8d4e3b7a:	82 c6 08 07 	R3 = R0 >>> 0x1f;
8d4e3b7e:	27 4d       	R7 >>>= 0x4;
8d4e3b80:	df 52       	R3 = R7 - R3;
8d4e3b82:	9b 0d       	CC = R3 < 0x3 (IU);
8d4e3b84:	02 14       	IF !CC JUMP 0x0x8d4e3b88 (BP);
8d4e3b86:	5f 22       	JUMP.S 0x0x8d4e4044;
8d4e3b88:	33 0e       	CC = R3 <= 0x6 (IU);
8d4e3b8a:	02 1c       	IF CC JUMP 0x0x8d4e3b8e (BP);
8d4e3b8c:	5c 22       	JUMP.S 0x0x8d4e4044;
8d4e3b8e:	fb 67       	R3 += -0x1;		/* ( -1) */
8d4e3b90:	e4 60       	R4 = 0x1c (X);		/*		R4=0x54( 84) */
8d4e3b92:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d4e3b96:	b8 00 00 00 
8d4e3b9a:	71 ca dc 20 	R3 = R3 * R4 (IS,NS) || R5 = [P3 + 0x10] || R4 = [P3 + 0xc];
8d4e3b9e:	1d a1 dc a0 
8d4e3ba2:	04 cc 0b 02 	R1 = R1 + R3 (NS) || [SP + 0xc] = R0 || R0 = [FP + 0x10];
8d4e3ba6:	f0 b0 38 a1 
8d4e3baa:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x60] = R4 || NOP;
8d4e3bae:	84 ba 00 00 
8d4e3bb2:	75 e6 3c 00 	W[SP + 0x78] = R5;
8d4e3bb6:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3bba:	70 e9 00 00 
8d4e3bbe:	7e 30       	R7 = SP;
8d4e3bc0:	23 e1 74 00 	R3 = 0x74 (X);		/*		R3=0x74(116) */
8d4e3bc4:	04 cc 3b 02 	R1 = R7 + R3 (NS) || [FP -0x78] = R6 || NOP;
8d4e3bc8:	26 ba 00 00 
8d4e3bcc:	01 30       	R0 = R1;
8d4e3bce:	7d 60       	R5 = 0xf (X);		/*		R5=0x54( 84) */
8d4e3bd0:	b6 e6 4c 00 	B[SP + 0x4c] = R6;
8d4e3bd4:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [FP -0x74] = R5 || NOP;
8d4e3bd8:	35 ba 00 00 
8d4e3bdc:	a0 66       	R0 += -0x2c;		/* (-44) */
8d4e3bde:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e3be2:	76 a3 00 00 
8d4e3be6:	03 c8 00 18 	MNOP || R1 = [P4 + 0x14] || R0 = [FP -0x78];
8d4e3bea:	61 a1 20 b8 
8d4e3bee:	81 09       	CC = R1 < R0 (IU);
8d4e3bf0:	10 32       	P2 = R0;
8d4e3bf2:	25 18       	IF CC JUMP 0x0x8d4e3c3c;
8d4e3bf4:	30 e5 13 00 	P0 = [SP + 0x4c];
8d4e3bf8:	82 60       	R2 = 0x10 (X);		/*		R2=0x54( 84) */
8d4e3bfa:	03 c8 00 18 	MNOP || R3 = [FP -0x74] || R7 = [P4 + 0x18];
8d4e3bfe:	33 b8 a7 a1 
8d4e3c02:	29 e1 4c 00 	P1 = 0x4c (X);		/*		P1=0x4c( 76) */
8d4e3c06:	1a 0a       	CC = R2 <= R3 (IU);
8d4e3c08:	4e 5a       	P1 = SP + P1;
8d4e3c0a:	c8 07       	IF CC P1 = P0;
8d4e3c0c:	3a 0a       	CC = R2 <= R7 (IU);
8d4e3c0e:	5c 32       	P3 = P4;
8d4e3c10:	23 6c       	P3 += 0x4;		/* (  4) */
8d4e3c12:	11 5a       	P0 = P1 + P2;
8d4e3c14:	02 10       	IF !CC JUMP 0x0x8d4e3c18;
8d4e3c16:	5b 91       	P3 = [P3];
8d4e3c18:	b9 b0       	[FP + 0x8] = R1;
8d4e3c1a:	41 08       	CC = P1 == P0;
8d4e3c1c:	b9 ac       	P1 = [FP + 0x8];
8d4e3c1e:	f8 6f       	P0 += -0x1;		/* ( -1) */
8d4e3c20:	cb 5a       	P3 = P3 + P1;
8d4e3c22:	fb 6f       	P3 += -0x1;		/* ( -1) */
8d4e3c24:	0b 18       	IF CC JUMP 0x0x8d4e3c3a;
8d4e3c26:	a2 e0 09 20 	LSETUP(0x8d4e3c2a, 0x8d4e3c38) LC0 = P2;
8d4e3c2a:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R0 = B[P0--] (X) || R1 = B[P3--] (X);
8d4e3c2e:	c0 98 d9 98 
8d4e3c32:	08 08       	CC = R0 == R1;
8d4e3c34:	02 1c       	IF CC JUMP 0x0x8d4e3c38 (BP);
8d4e3c36:	06 22       	JUMP.S 0x0x8d4e4042;
8d4e3c38:	00 00       	NOP;
8d4e3c3a:	0f 60       	R7 = 0x1 (X);		/*		R7=0x64(100) */
8d4e3c3c:	30 b8       	R0 = [FP -0x74];
8d4e3c3e:	81 60       	R1 = 0x10 (X);		/*		R1=0xffffffac(-84) */
8d4e3c40:	01 0a       	CC = R1 <= R0 (IU);
8d4e3c42:	02 14       	IF !CC JUMP 0x0x8d4e3c46 (BP);
8d4e3c44:	fa 21       	JUMP.S 0x0x8d4e4038;
8d4e3c46:	78 60       	R0 = 0xf (X);		/*		R0=0x54( 84) */
8d4e3c48:	07 0c       	CC = R7 == 0x0;
8d4e3c4a:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x78] = R6 || R1 = [FP -0x6c];
8d4e3c4e:	26 ba 51 b8 
8d4e3c52:	b6 e6 4c 00 	B[SP + 0x4c] = R6;
8d4e3c56:	04 cc 00 40 	R0 = R0 - R0 (NS) || [FP -0x74] = R0 || R3 = [FP -0x68];
8d4e3c5a:	30 ba 63 b8 
8d4e3c5e:	02 14       	IF !CC JUMP 0x0x8d4e3c62 (BP);
8d4e3c60:	da 21       	JUMP.S 0x0x8d4e4014;
8d4e3c62:	f8 a0       	R0 = [FP + 0xc];
8d4e3c64:	cb 52       	R3 = R3 - R1;
8d4e3c66:	07 da 49 92 	R7=-1840700269;
8d4e3c6a:	93 24 00 00 
8d4e3c6e:	31 c3 df 21 	R7 = R3 * R7 (M,T);
8d4e3c72:	82 c6 0b 09 	R4 = R3 >>> 0x1f;
8d4e3c76:	27 4d       	R7 >>>= 0x4;
8d4e3c78:	e7 52       	R3 = R7 - R4;
8d4e3c7a:	f3 67       	R3 += -0x2;		/* ( -2) */
8d4e3c7c:	e7 60       	R7 = 0x1c (X);		/*		R7=0x64(100) */
8d4e3c7e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0004;
8d4e3c82:	b8 00 04 00 
8d4e3c86:	71 ca df 20 	R3 = R3 * R7 (IS,NS) || [SP + 0xc] = R4 || NOP;
8d4e3c8a:	f4 b0 00 00 
8d4e3c8e:	59 50       	R1 = R1 + R3;
8d4e3c90:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3c94:	70 e9 00 00 
8d4e3c98:	6e 30       	R5 = SP;
8d4e3c9a:	7c 60       	R4 = 0xf (X);		/*		R4=0x54( 84) */
8d4e3c9c:	22 e1 48 00 	R2 = 0x48 (X);		/*		R2=0x48( 72) */
8d4e3ca0:	01 da 03 84 	R1=-2080149256;
8d4e3ca4:	f8 70 00 00 
8d4e3ca8:	b6 e6 4c 00 	B[SP + 0x4c] = R6;
8d4e3cac:	04 cc 2a 00 	R0 = R5 + R2 (NS) || [FP -0x78] = R6 || NOP;
8d4e3cb0:	26 ba 00 00 
8d4e3cb4:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [FP -0x74] = R4 || NOP;
8d4e3cb8:	34 ba 00 00 
8d4e3cbc:	a1 64       	R1 += 0x14;		/* ( 20) */
8d4e3cbe:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e3cc2:	76 a3 00 00 
8d4e3cc6:	03 c8 00 18 	MNOP || R1 = [P5 + 0x14] || R0 = [FP -0x78];
8d4e3cca:	69 a1 20 b8 
8d4e3cce:	81 09       	CC = R1 < R0 (IU);
8d4e3cd0:	19 32       	P3 = R1;
8d4e3cd2:	08 32       	P1 = R0;
8d4e3cd4:	21 18       	IF CC JUMP 0x0x8d4e3d16;
8d4e3cd6:	32 e5 13 00 	P2 = [SP + 0x4c];
8d4e3cda:	03 c8 00 18 	MNOP || R2 = [FP -0x74] || R3 = [P5 + 0x18];
8d4e3cde:	32 b8 ab a1 
8d4e3ce2:	28 e1 4c 00 	P0 = 0x4c (X);		/*		P0=0x4c( 76) */
8d4e3ce6:	85 60       	R5 = 0x10 (X);		/*		R5=0x54( 84) */
8d4e3ce8:	15 0a       	CC = R5 <= R2 (IU);
8d4e3cea:	06 5a       	P0 = SP + P0;
8d4e3cec:	c2 07       	IF CC P0 = P2;
8d4e3cee:	87 60       	R7 = 0x10 (X);		/*		R7=0x64(100) */
8d4e3cf0:	1f 0a       	CC = R7 <= R3 (IU);
8d4e3cf2:	25 6c       	P5 += 0x4;		/* (  4) */
8d4e3cf4:	88 5a       	P2 = P0 + P1;
8d4e3cf6:	02 10       	IF !CC JUMP 0x0x8d4e3cfa;
8d4e3cf8:	6d 91       	P5 = [P5];
8d4e3cfa:	50 08       	CC = P0 == P2;
8d4e3cfc:	fa 6f       	P2 += -0x1;		/* ( -1) */
8d4e3cfe:	1d 5a       	P0 = P5 + P3;
8d4e3d00:	f8 6f       	P0 += -0x1;		/* ( -1) */
8d4e3d02:	09 18       	IF CC JUMP 0x0x8d4e3d14;
8d4e3d04:	a2 e0 07 10 	LSETUP(0x8d4e3d08, 0x8d4e3d12) LC0 = P1;
8d4e3d08:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R0 = B[P2--] (X) || R1 = B[P0--] (X);
8d4e3d0c:	d0 98 c1 98 
8d4e3d10:	08 08       	CC = R0 == R1;
8d4e3d12:	80 11       	IF !CC JUMP 0x0x8d4e4012;
8d4e3d14:	0f 60       	R7 = 0x1 (X);		/*		R7=0x64(100) */
8d4e3d16:	30 b8       	R0 = [FP -0x74];
8d4e3d18:	81 60       	R1 = 0x10 (X);		/*		R1=0xffffffac(-84) */
8d4e3d1a:	01 0a       	CC = R1 <= R0 (IU);
8d4e3d1c:	76 19       	IF CC JUMP 0x0x8d4e4008;
8d4e3d1e:	78 60       	R0 = 0xf (X);		/*		R0=0x54( 84) */
8d4e3d20:	07 0c       	CC = R7 == 0x0;
8d4e3d22:	26 ba       	[FP -0x78] = R6;
8d4e3d24:	b6 e6 4c 00 	B[SP + 0x4c] = R6;
8d4e3d28:	03 c8 00 18 	MNOP || [FP -0x74] = R0 || R0 = [FP + 0x10];
8d4e3d2c:	30 ba 38 a1 
8d4e3d30:	4c 11       	IF !CC JUMP 0x0x8d4e3fc8;
8d4e3d32:	07 0c       	CC = R7 == 0x0;
8d4e3d34:	26 11       	IF !CC JUMP 0x0x8d4e3f80;
8d4e3d36:	00 da 03 84 	R0=-2080149256;
8d4e3d3a:	f8 70 00 00 
8d4e3d3e:	40 65       	R0 += 0x28;		/* ( 40) */
8d4e3d40:	07 0c       	CC = R7 == 0x0;
8d4e3d42:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP + 0x8] = R0 || R1 = [FP + 0xc];
8d4e3d46:	b8 b0 f9 a0 
8d4e3d4a:	9b 10       	IF !CC JUMP 0x0x8d4e3e80;
8d4e3d4c:	63 a1       	R3 = [P4 + 0x14];
8d4e3d4e:	29 e1 74 00 	P1 = 0x74 (X);		/*		P1=0x74(116) */
8d4e3d52:	0e 5a       	P0 = SP + P1;
8d4e3d54:	48 32       	P1 = P0;
8d4e3d56:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = B[P1++] (Z) || NOP;
8d4e3d5a:	08 98 00 00 
8d4e3d5e:	00 0c       	CC = R0 == 0x0;
8d4e3d60:	fb 17       	IF !CC JUMP 0x0x8d4e3d56 (BP);
8d4e3d62:	01 44       	P1 -= P0;
8d4e3d64:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d4e3d66:	41 30       	R0 = P1;
8d4e3d68:	04 cc 18 42 	R1 = R3 - R0 (NS) || R0 = [FP + 0x10] || NOP;
8d4e3d6c:	38 a1 00 00 
8d4e3d70:	19 0a       	CC = R1 <= R3 (IU);
8d4e3d72:	0b 10       	IF !CC JUMP 0x0x8d4e3d88;
8d4e3d74:	38 a1       	R0 = [FP + 0x10];
8d4e3d76:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4e3d7a:	b8 00 02 00 
8d4e3d7e:	00 de 03 8c 	CALL.A 0x8c03e65c;
8d4e3d82:	5c e6 00 00 
8d4e3d86:	06 20       	JUMP.S 0x0x8d4e3d92;
8d4e3d88:	59 52       	R1 = R1 - R3;
8d4e3d8a:	00 de 03 8c 	CALL.A 0x8c03ea3c;
8d4e3d8e:	3c ea 00 00 
8d4e3d92:	03 c8 00 18 	MNOP || R0 = [FP -0x68] || R1 = [FP -0x6c];
8d4e3d96:	60 b8 51 b8 
8d4e3d9a:	08 52       	R0 = R0 - R1;
8d4e3d9c:	03 da 49 92 	R3=-1840700269;
8d4e3da0:	93 24 00 00 
8d4e3da4:	31 c3 c3 20 	R3 = R0 * R3 (M,T);
8d4e3da8:	82 ce 08 05 	R2 = R0 >>> 0x1f || R0 = [FP + 0xc] || NOP;
8d4e3dac:	f8 a0 00 00 
8d4e3db0:	23 4d       	R3 >>>= 0x4;
8d4e3db2:	53 53       	R5 = R3 - R2;
8d4e3db4:	3d 30       	R7 = R5;
8d4e3db6:	f5 67       	R5 += -0x2;		/* ( -2) */
8d4e3db8:	95 0c       	CC = R5 < 0x2;
8d4e3dba:	57 18       	IF CC JUMP 0x0x8d4e3e68;
8d4e3dbc:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e3dc0:	b8 00 03 00 
8d4e3dc4:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e3dc8:	f3 b0 00 00 
8d4e3dcc:	c1 65       	R1 += 0x38;		/* ( 56) */
8d4e3dce:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3dd2:	70 e9 00 00 
8d4e3dd6:	9d 0c       	CC = R5 < 0x3;
8d4e3dd8:	2b 18       	IF CC JUMP 0x0x8d4e3e2e;
8d4e3dda:	e7 67       	R7 += -0x4;		/* ( -4) */
8d4e3ddc:	25 e1 54 00 	R5 = 0x54 (X);		/*		R5=0x54( 84) */
8d4e3de0:	46 30       	R0 = SP;
8d4e3de2:	24 e1 7c 00 	R4 = 0x7c (X);		/*		R4=0x7c(124) */
8d4e3de6:	04 cc 04 08 	R4 = R0 + R4 (NS) || R3 = [FP -0x6c] || R1 = [FP + 0x8];
8d4e3dea:	53 b8 b9 a0 
8d4e3dee:	ab 50       	R2 = R3 + R5;
8d4e3df0:	04 30       	R0 = R4;
8d4e3df2:	00 de 04 8c 	CALL.A 0x8c04ee6c;
8d4e3df6:	6c ee 00 00 
8d4e3dfa:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e3dfe:	b8 00 03 00 
8d4e3e02:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0xc] = R3 || R0 = [FP + 0xc];
8d4e3e06:	f3 b0 f8 a0 
8d4e3e0a:	02 60       	R2 = 0x0 (X);		/*		R2=0x48( 72) */
8d4e3e0c:	00 de 03 8c 	CALL.A 0x8c03e898;
8d4e3e10:	98 e8 00 00 
8d4e3e14:	84 60       	R4 = 0x10 (X);		/*		R4=0x7c(124) */
8d4e3e16:	00 b9       	R0 = [FP -0x40];
8d4e3e18:	04 0a       	CC = R4 <= R0 (IU);
8d4e3e1a:	22 18       	IF CC JUMP 0x0x8d4e3e5e;
8d4e3e1c:	ff 67       	R7 += -0x1;		/* ( -1) */
8d4e3e1e:	78 60       	R0 = 0xf (X);		/*		R0=0x54( 84) */
8d4e3e20:	07 0c       	CC = R7 == 0x0;
8d4e3e22:	f6 ba       	[FP -0x44] = R6;
8d4e3e24:	b6 e6 80 00 	B[SP + 0x80] = R6;
8d4e3e28:	00 bb       	[FP -0x40] = R0;
8d4e3e2a:	e5 64       	R5 += 0x1c;		/* ( 28) */
8d4e3e2c:	da 17       	IF !CC JUMP 0x0x8d4e3de0 (BP);
8d4e3e2e:	51 b8       	R1 = [FP -0x6c];
8d4e3e30:	01 0c       	CC = R1 == 0x0;
8d4e3e32:	0b 18       	IF CC JUMP 0x0x8d4e3e48;
8d4e3e34:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e3e38:	62 b8       	R2 = [FP -0x68];
8d4e3e3a:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e3e3e:	a4 f9 00 00 
8d4e3e42:	50 b8       	R0 = [FP -0x6c];
8d4e3e44:	ff e3 d0 52 	CALL 0x0x8d4ce3e4;
8d4e3e48:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e3e4a:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e3e4c:	01 e8 00 00 	UNLINK;
8d4e3e50:	08 60       	R0 = 0x1 (X);		/*		R0=0x54( 84) */
8d4e3e52:	10 00       	RTS;
8d4e3e54:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e3e56:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e3e58:	01 e8 00 00 	UNLINK;
8d4e3e5c:	10 00       	RTS;
8d4e3e5e:	b0 b8       	R0 = [FP -0x54];
8d4e3e60:	ff e3 c2 52 	CALL 0x0x8d4ce3e4;
8d4e3e64:	dc 2f       	JUMP.S 0x0x8d4e3e1c;
8d4e3e66:	00 00       	NOP;
8d4e3e68:	03 c8 00 18 	MNOP || R1 = [FP + 0x8] || R0 = [FP + 0xc];
8d4e3e6c:	b9 a0 f8 a0 
8d4e3e70:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e3e74:	76 a3 00 00 
8d4e3e78:	db 2f       	JUMP.S 0x0x8d4e3e2e;
8d4e3e7a:	00 00       	NOP;
8d4e3e7c:	00 00       	NOP;
8d4e3e7e:	00 00       	NOP;
8d4e3e80:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e3e84:	b8 00 03 00 
8d4e3e88:	f3 b0       	[SP + 0xc] = R3;
8d4e3e8a:	38 a1       	R0 = [FP + 0x10];
8d4e3e8c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3e90:	70 e9 00 00 
8d4e3e94:	60 a1       	R0 = [P4 + 0x14];
8d4e3e96:	08 30       	R1 = R0;
8d4e3e98:	c9 67       	R1 += -0x7;		/* ( -7) */
8d4e3e9a:	01 0a       	CC = R1 <= R0 (IU);
8d4e3e9c:	0b 10       	IF !CC JUMP 0x0x8d4e3eb2;
8d4e3e9e:	38 a1       	R0 = [FP + 0x10];
8d4e3ea0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4e3ea4:	b8 00 02 00 
8d4e3ea8:	00 de 03 8c 	CALL.A 0x8c03e65c;
8d4e3eac:	5c e6 00 00 
8d4e3eb0:	08 20       	JUMP.S 0x0x8d4e3ec0;
8d4e3eb2:	38 a1       	R0 = [FP + 0x10];
8d4e3eb4:	02 60       	R2 = 0x0 (X);		/*		R2=0x48( 72) */
8d4e3eb6:	c9 63       	R1 = -0x7 (X);		/*		R1=0xffffffac(-84) */
8d4e3eb8:	00 de 03 8c 	CALL.A 0x8c03ea3c;
8d4e3ebc:	3c ea 00 00 
8d4e3ec0:	03 c8 00 18 	MNOP || R0 = [FP -0x68] || R1 = [FP -0x6c];
8d4e3ec4:	60 b8 51 b8 
8d4e3ec8:	08 52       	R0 = R0 - R1;
8d4e3eca:	03 da 49 92 	R3=-1840700269;
8d4e3ece:	93 24 00 00 
8d4e3ed2:	31 c3 c3 20 	R3 = R0 * R3 (M,T);
8d4e3ed6:	82 ce 08 05 	R2 = R0 >>> 0x1f || R0 = [FP + 0xc] || NOP;
8d4e3eda:	f8 a0 00 00 
8d4e3ede:	23 4d       	R3 >>>= 0x4;
8d4e3ee0:	53 53       	R5 = R3 - R2;
8d4e3ee2:	3d 30       	R7 = R5;
8d4e3ee4:	ed 67       	R5 += -0x3;		/* ( -3) */
8d4e3ee6:	95 0c       	CC = R5 < 0x2;
8d4e3ee8:	40 18       	IF CC JUMP 0x0x8d4e3f68;
8d4e3eea:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e3eee:	b8 00 03 00 
8d4e3ef2:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e3ef6:	f3 b0 00 00 
8d4e3efa:	c1 65       	R1 += 0x38;		/* ( 56) */
8d4e3efc:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e3f00:	70 e9 00 00 
8d4e3f04:	9d 0c       	CC = R5 < 0x3;
8d4e3f06:	94 1b       	IF CC JUMP 0x0x8d4e3e2e;
8d4e3f08:	df 67       	R7 += -0x5;		/* ( -5) */
8d4e3f0a:	25 e1 54 00 	R5 = 0x54 (X);		/*		R5=0x54( 84) */
8d4e3f0e:	46 30       	R0 = SP;
8d4e3f10:	24 e1 7c 00 	R4 = 0x7c (X);		/*		R4=0x7c(124) */
8d4e3f14:	04 cc 04 08 	R4 = R0 + R4 (NS) || R3 = [FP -0x6c] || R1 = [FP + 0x8];
8d4e3f18:	53 b8 b9 a0 
8d4e3f1c:	ab 50       	R2 = R3 + R5;
8d4e3f1e:	04 30       	R0 = R4;
8d4e3f20:	00 de 04 8c 	CALL.A 0x8c04ee6c;
8d4e3f24:	6c ee 00 00 
8d4e3f28:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e3f2c:	b8 00 03 00 
8d4e3f30:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0xc] = R3 || R0 = [FP + 0xc];
8d4e3f34:	f3 b0 f8 a0 
8d4e3f38:	02 60       	R2 = 0x0 (X);		/*		R2=0x48( 72) */
8d4e3f3a:	00 de 03 8c 	CALL.A 0x8c03e898;
8d4e3f3e:	98 e8 00 00 
8d4e3f42:	84 60       	R4 = 0x10 (X);		/*		R4=0x7c(124) */
8d4e3f44:	00 b9       	R0 = [FP -0x40];
8d4e3f46:	04 0a       	CC = R4 <= R0 (IU);
8d4e3f48:	0b 18       	IF CC JUMP 0x0x8d4e3f5e;
8d4e3f4a:	ff 67       	R7 += -0x1;		/* ( -1) */
8d4e3f4c:	78 60       	R0 = 0xf (X);		/*		R0=0x54( 84) */
8d4e3f4e:	07 0c       	CC = R7 == 0x0;
8d4e3f50:	f6 ba       	[FP -0x44] = R6;
8d4e3f52:	b6 e6 80 00 	B[SP + 0x80] = R6;
8d4e3f56:	00 bb       	[FP -0x40] = R0;
8d4e3f58:	e5 64       	R5 += 0x1c;		/* ( 28) */
8d4e3f5a:	da 17       	IF !CC JUMP 0x0x8d4e3f0e (BP);
8d4e3f5c:	69 2f       	JUMP.S 0x0x8d4e3e2e;
8d4e3f5e:	b0 b8       	R0 = [FP -0x54];
8d4e3f60:	ff e3 42 52 	CALL 0x0x8d4ce3e4;
8d4e3f64:	f3 2f       	JUMP.S 0x0x8d4e3f4a;
8d4e3f66:	00 00       	NOP;
8d4e3f68:	03 c8 00 18 	MNOP || R1 = [FP + 0x8] || R0 = [FP + 0xc];
8d4e3f6c:	b9 a0 f8 a0 
8d4e3f70:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e3f74:	76 a3 00 00 
8d4e3f78:	5b 2f       	JUMP.S 0x0x8d4e3e2e;
8d4e3f7a:	00 00       	NOP;
8d4e3f7c:	00 00       	NOP;
8d4e3f7e:	00 00       	NOP;
8d4e3f80:	03 c8 00 18 	MNOP || R2 = [FP -0x68] || R1 = [FP -0x6c];
8d4e3f84:	62 b8 51 b8 
8d4e3f88:	0a 52       	R0 = R2 - R1;
8d4e3f8a:	03 da 49 92 	R3=-1840700269;
8d4e3f8e:	93 24 00 00 
8d4e3f92:	31 c3 c3 20 	R3 = R0 * R3 (M,T);
8d4e3f96:	82 c6 08 0b 	R5 = R0 >>> 0x1f;
8d4e3f9a:	23 4d       	R3 >>>= 0x4;
8d4e3f9c:	2b 52       	R0 = R3 - R5;
8d4e3f9e:	18 0c       	CC = R0 == 0x3;
8d4e3fa0:	cb 16       	IF !CC JUMP 0x0x8d4e3d36 (BP);
8d4e3fa2:	01 0c       	CC = R1 == 0x0;
8d4e3fa4:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e3fa6:	57 1b       	IF CC JUMP 0x0x8d4e3e54;
8d4e3fa8:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e3fac:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e3fb0:	a4 f9 00 00 
8d4e3fb4:	50 b8       	R0 = [FP -0x6c];
8d4e3fb6:	ff e3 17 52 	CALL 0x0x8d4ce3e4;
8d4e3fba:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e3fbc:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e3fbe:	01 e8 00 00 	UNLINK;
8d4e3fc2:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e3fc4:	10 00       	RTS;
8d4e3fc6:	00 00       	NOP;
8d4e3fc8:	01 da 03 84 	R1=-2080149256;
8d4e3fcc:	f8 70 00 00 
8d4e3fd0:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4e3fd2:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4e3fd6:	88 bf 00 00 
8d4e3fda:	00 0c       	CC = R0 == 0x0;
8d4e3fdc:	ab 16       	IF !CC JUMP 0x0x8d4e3d32 (BP);
8d4e3fde:	03 c8 00 18 	MNOP || R1 = [FP -0x6c] || R2 = [FP -0x68];
8d4e3fe2:	51 b8 62 b8 
8d4e3fe6:	01 0c       	CC = R1 == 0x0;
8d4e3fe8:	36 1b       	IF CC JUMP 0x0x8d4e3e54;
8d4e3fea:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e3fee:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e3ff2:	a4 f9 00 00 
8d4e3ff6:	50 b8       	R0 = [FP -0x6c];
8d4e3ff8:	ff e3 f6 51 	CALL 0x0x8d4ce3e4;
8d4e3ffc:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e3ffe:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e4000:	01 e8 00 00 	UNLINK;
8d4e4004:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e4006:	10 00       	RTS;
8d4e4008:	30 e4 13 00 	R0 = [SP + 0x4c];
8d4e400c:	ff e3 ec 51 	CALL 0x0x8d4ce3e4;
8d4e4010:	87 2e       	JUMP.S 0x0x8d4e3d1e;
8d4e4012:	82 2e       	JUMP.S 0x0x8d4e3d16;
8d4e4014:	01 0c       	CC = R1 == 0x0;
8d4e4016:	1f 1b       	IF CC JUMP 0x0x8d4e3e54;
8d4e4018:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e401c:	62 b8       	R2 = [FP -0x68];
8d4e401e:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e4022:	a4 f9 00 00 
8d4e4026:	50 b8       	R0 = [FP -0x6c];
8d4e4028:	ff e3 de 51 	CALL 0x0x8d4ce3e4;
8d4e402c:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e402e:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e4030:	01 e8 00 00 	UNLINK;
8d4e4034:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e4036:	10 00       	RTS;
8d4e4038:	30 e4 13 00 	R0 = [SP + 0x4c];
8d4e403c:	ff e3 d4 51 	CALL 0x0x8d4ce3e4;
8d4e4040:	03 2e       	JUMP.S 0x0x8d4e3c46;
8d4e4042:	fd 2d       	JUMP.S 0x0x8d4e3c3c;
8d4e4044:	01 0c       	CC = R1 == 0x0;
8d4e4046:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e4048:	06 1b       	IF CC JUMP 0x0x8d4e3e54;
8d4e404a:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e404e:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e4052:	a4 f9 00 00 
8d4e4056:	50 b8       	R0 = [FP -0x6c];
8d4e4058:	ff e3 c6 51 	CALL 0x0x8d4ce3e4;
8d4e405c:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e405e:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e4060:	01 e8 00 00 	UNLINK;
8d4e4064:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e4066:	10 00       	RTS;
8d4e4068:	5f 30       	R3 = FP;
8d4e406a:	83 67       	R3 += -0x10;		/* (-16) */
8d4e406c:	bb b0       	[FP + 0x8] = R3;
8d4e406e:	e5 60       	R5 = 0x1c (X);		/*		R5=0x54( 84) */
8d4e4070:	04 da 49 92 	R4=-1840700269;
8d4e4074:	93 24 00 00 
8d4e4078:	ef 40       	R7 *= R5;
8d4e407a:	04 cc 0f 02 	R1 = R1 + R7 (NS) || R0 = [FP + 0x8] || NOP;
8d4e407e:	b8 a0 00 00 
8d4e4082:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4e4084:	ff e3 fa f3 	CALL 0x0x8d4e2878;
8d4e4088:	56 30       	R2 = SP;
8d4e408a:	23 e1 8c 00 	R3 = 0x8c (X);		/*		R3=0x8c(140) */
8d4e408e:	04 cc 13 04 	R2 = R2 + R3 (NS) || [FP -0x34] = R6 || NOP;
8d4e4092:	36 bb 00 00 
8d4e4096:	b2 b3       	[SP + 0x38] = R2;
8d4e4098:	29 e1 64 00 	P1 = 0x64 (X);		/*		P1=0x64(100) */
8d4e409c:	28 e1 7c 00 	P0 = 0x7c (X);		/*		P0=0x7c(124) */
8d4e40a0:	7f 60       	R7 = 0xf (X);		/*		R7=0x64(100) */
8d4e40a2:	01 da 03 84 	R1=-2080149256;
8d4e40a6:	f8 70 00 00 
8d4e40aa:	4e 5a       	P1 = SP + P1;
8d4e40ac:	06 5a       	P0 = SP + P0;
8d4e40ae:	b6 e6 90 00 	B[SP + 0x90] = R6;
8d4e40b2:	03 c8 00 18 	MNOP || [FP -0x30] = R7 || R0 = [SP + 0x38];
8d4e40b6:	47 bb b0 a3 
8d4e40ba:	41 64       	R1 += 0x8;		/* (  8) */
8d4e40bc:	31 e7 10 00 	[SP + 0x40] = P1;
8d4e40c0:	f0 bf       	[SP + 0x3c] = P0;
8d4e40c2:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e40c6:	76 a3 00 00 
8d4e40ca:	25 e1 7c 00 	R5 = 0x7c (X);		/*		R5=0x7c(124) */
8d4e40ce:	5e 30       	R3 = SP;
8d4e40d0:	04 cc 1d 06 	R3 = R3 + R5 (NS) || [FP -0x14] = R7 || NOP;
8d4e40d4:	b7 bb 00 00 
8d4e40d8:	73 b3       	[SP + 0x34] = R3;
8d4e40da:	47 30       	R0 = FP;
8d4e40dc:	a6 bb       	[FP -0x18] = R6;
8d4e40de:	b6 e6 ac 00 	B[SP + 0xac] = R6;
8d4e40e2:	a0 66       	R0 += -0x2c;		/* (-44) */
8d4e40e4:	01 da 03 84 	R1=-2080149256;
8d4e40e8:	f8 70 00 00 
8d4e40ec:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e40f0:	76 a3 00 00 
8d4e40f4:	03 c8 00 18 	MNOP || R0 = [SP + 0x34] || R1 = [SP + 0x38];
8d4e40f8:	70 a3 b1 a3 
8d4e40fc:	12 60       	R2 = 0x2 (X);		/*		R2=0x48( 72) */
8d4e40fe:	00 de 0a 8c 	CALL.A 0x8c0ae58c;
8d4e4102:	8c e5 00 00 
8d4e4106:	31 e5 10 00 	P1 = [SP + 0x40];
8d4e410a:	03 c8 00 18 	MNOP || P0 = [SP + 0x3c] || R0 = [FP -0x50];
8d4e410e:	f0 af c0 b8 
8d4e4112:	03 c8 00 18 	MNOP || R5 = [FP -0x54] || R2 = [FP -0x68];
8d4e4116:	b5 b8 62 b8 
8d4e411a:	57 b8       	R7 = [FP -0x6c];
8d4e411c:	41 08       	CC = P1 == P0;
8d4e411e:	60 18       	IF CC JUMP 0x0x8d4e41de;
8d4e4120:	04 cc 05 42 	R1 = R0 - R5 (NS) || P1 = [FP -0x6c] || NOP;
8d4e4124:	59 b8 00 00 
8d4e4128:	30 e6 10 00 	[SP + 0x40] = R0;
8d4e412c:	31 cb 0c 20 	R0 = R1 * R4 (M,T) || [SP + 0x3c] = R2 || NOP;
8d4e4130:	f2 b3 00 00 
8d4e4134:	82 ce 09 07 	R3 = R1 >>> 0x1f || [SP + 0x30] = P1 || NOP;
8d4e4138:	31 bf 00 00 
8d4e413c:	20 4d       	R0 >>>= 0x4;
8d4e413e:	d8 52       	R3 = R0 - R3;
8d4e4140:	03 0c       	CC = R3 == 0x0;
8d4e4142:	1c 19       	IF CC JUMP 0x0x8d4e437a;
8d4e4144:	3a 52       	R0 = R2 - R7;
8d4e4146:	01 da 49 92 	R1=-1840700269;
8d4e414a:	93 24 00 00 
8d4e414e:	31 c3 41 20 	R1 = R0 * R1 (M,T);
8d4e4152:	82 c6 08 05 	R2 = R0 >>> 0x1f;
8d4e4156:	21 4d       	R1 >>>= 0x4;
8d4e4158:	04 cc 0a 48 	R4 = R1 - R2 (NS) || R1 = [FP -0x64] || R2 = [SP + 0x3c];
8d4e415c:	71 b8 f2 a3 
8d4e4160:	23 0a       	CC = R3 <= R4 (IU);
8d4e4162:	d5 18       	IF CC JUMP 0x0x8d4e430c;
8d4e4164:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e4166:	b9 52       	R2 = R1 - R7;
8d4e4168:	82 c6 0a 03 	R1 = R2 >>> 0x1f;
8d4e416c:	f1 b2       	[SP + 0x2c] = R1;
8d4e416e:	01 da 49 92 	R1=-1840700269;
8d4e4172:	93 24 00 00 
8d4e4176:	31 c3 91 20 	R2 = R2 * R1 (M,T);
8d4e417a:	22 4d       	R2 >>>= 0x4;
8d4e417c:	f1 a2       	R1 = [SP + 0x2c];
8d4e417e:	07 0c       	CC = R7 == 0x0;
8d4e4180:	04 cc 11 44 	R2 = R2 - R1 (NS) || R1 = [SP + 0x3c] || NOP;
8d4e4184:	f1 a3 00 00 
8d4e4188:	02 06       	IF !CC R0 = R2;
8d4e418a:	03 0a       	CC = R3 <= R0 (IU);
8d4e418c:	6c 10       	IF !CC JUMP 0x0x8d4e4264;
8d4e418e:	e0 60       	R0 = 0x1c (X);		/*		R0=0x54( 84) */
8d4e4190:	e0 40       	R0 *= R4;
8d4e4192:	05 51       	R4 = R5 + R0;
8d4e4194:	25 08       	CC = R5 == R4;
8d4e4196:	32 e4 10 00 	R2 = [SP + 0x40];
8d4e419a:	17 18       	IF CC JUMP 0x0x8d4e41c8;
8d4e419c:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d4e41a0:	b8 00 01 00 
8d4e41a4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R1 || NOP;
8d4e41a8:	f1 b0 00 00 
8d4e41ac:	0d 30       	R1 = R5;
8d4e41ae:	02 60       	R2 = 0x0 (X);		/*		R2=0x48( 72) */
8d4e41b0:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e41b4:	70 e9 00 00 
8d4e41b8:	e5 64       	R5 += 0x1c;		/* ( 28) */
8d4e41ba:	2c 08       	CC = R4 == R5;
8d4e41bc:	e7 64       	R7 += 0x1c;		/* ( 28) */
8d4e41be:	ef 17       	IF !CC JUMP 0x0x8d4e419c (BP);
8d4e41c0:	03 c8 00 18 	MNOP || R2 = [FP -0x50] || R1 = [FP -0x68];
8d4e41c4:	c2 b8 61 b8 
8d4e41c8:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0xc] = R1 || NOP;
8d4e41cc:	f1 b0 00 00 
8d4e41d0:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e41d4:	00 de 03 8c 	CALL.A 0x8c03fd50;
8d4e41d8:	50 fd 00 00 
8d4e41dc:	60 ba       	[FP -0x68] = R0;
8d4e41de:	03 c8 00 18 	MNOP || R1 = [FP -0x54] || R0 = [SP + 0x34];
8d4e41e2:	b1 b8 70 a3 
8d4e41e6:	01 0c       	CC = R1 == 0x0;
8d4e41e8:	09 18       	IF CC JUMP 0x0x8d4e41fa;
8d4e41ea:	c2 b8       	R2 = [FP -0x50];
8d4e41ec:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e41f0:	a4 f9 00 00 
8d4e41f4:	b0 b8       	R0 = [FP -0x54];
8d4e41f6:	ff e3 f7 50 	CALL 0x0x8d4ce3e4;
8d4e41fa:	09 da 09 8c 	P1=-1945525452;
8d4e41fe:	34 a3 00 00 
8d4e4202:	03 c8 00 18 	MNOP || [SP + 0xc] = P1 || R0 = [SP + 0x38];
8d4e4206:	f1 bc b0 a3 
8d4e420a:	b6 ba       	[FP -0x54] = R6;
8d4e420c:	c6 ba       	[FP -0x50] = R6;
8d4e420e:	d6 ba       	[FP -0x4c] = R6;
8d4e4210:	e2 60       	R2 = 0x1c (X);		/*		R2=0x48( 72) */
8d4e4212:	11 60       	R1 = 0x2 (X);		/*		R1=0xffffffac(-84) */
8d4e4214:	00 de ed 8f 	CALL.A 0x8fed536e;
8d4e4218:	6e 53 00 00 
8d4e421c:	03 c8 00 18 	MNOP || R3 = [FP -0x8] || R1 = [FP -0x68];
8d4e4220:	e3 b9 61 b8 
8d4e4224:	03 c8 00 18 	MNOP || [SP + 0xc] = R3 || R2 = [FP -0xc];
8d4e4228:	f3 b0 d2 b9 
8d4e422c:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e4230:	ff e3 5c f2 	CALL 0x0x8d4e26e8;
8d4e4234:	03 c8 00 18 	MNOP || R1 = [FP -0xc] || R0 = [FP + 0x8];
8d4e4238:	d1 b9 b8 a0 
8d4e423c:	01 0c       	CC = R1 == 0x0;
8d4e423e:	09 18       	IF CC JUMP 0x0x8d4e4250;
8d4e4240:	e2 b9       	R2 = [FP -0x8];
8d4e4242:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e4246:	a4 f9 00 00 
8d4e424a:	d0 b9       	R0 = [FP -0xc];
8d4e424c:	ff e3 cc 50 	CALL 0x0x8d4ce3e4;
8d4e4250:	f6 bb       	[FP -0x4] = R6;
8d4e4252:	03 c8 00 18 	MNOP || [FP -0xc] = R6 || R2 = [FP -0x68];
8d4e4256:	d6 bb 62 b8 
8d4e425a:	03 c8 00 18 	MNOP || [FP -0x8] = R6 || R1 = [FP -0x6c];
8d4e425e:	e6 bb 51 b8 
8d4e4262:	85 2c       	JUMP.S 0x0x8d4e3b6c;
8d4e4264:	07 0c       	CC = R7 == 0x0;
8d4e4266:	30 e4 10 00 	R0 = [SP + 0x40];
8d4e426a:	12 18       	IF CC JUMP 0x0x8d4e428e;
8d4e426c:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R2 = [SP + 0x3c] || NOP;
8d4e4270:	f2 a3 00 00 
8d4e4274:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e4278:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e427c:	a4 f9 00 00 
8d4e4280:	50 b8       	R0 = [FP -0x6c];
8d4e4282:	ff e3 b1 50 	CALL 0x0x8d4ce3e4;
8d4e4286:	03 c8 00 18 	MNOP || R5 = [FP -0x54] || R0 = [FP -0x50];
8d4e428a:	b5 b8 c0 b8 
8d4e428e:	04 cc 05 40 	R0 = R0 - R5 (NS) || [FP -0x6c] = R6 || NOP;
8d4e4292:	56 ba 00 00 
8d4e4296:	03 da 49 92 	R3=-1840700269;
8d4e429a:	93 24 00 00 
8d4e429e:	31 cb c3 20 	R3 = R0 * R3 (M,T) || [FP -0x68] = R6 || NOP;
8d4e42a2:	66 ba 00 00 
8d4e42a6:	82 ce 08 05 	R2 = R0 >>> 0x1f || [FP -0x64] = R6 || NOP;
8d4e42aa:	76 ba 00 00 
8d4e42ae:	23 4d       	R3 >>>= 0x4;
8d4e42b0:	13 52       	R0 = R3 - R2;
8d4e42b2:	00 0c       	CC = R0 == 0x0;
8d4e42b4:	01 60       	R1 = 0x0 (X);		/*		R1=0xffffffac(-84) */
8d4e42b6:	18 18       	IF CC JUMP 0x0x8d4e42e6;
8d4e42b8:	01 da 24 09 	R1=153391689;
8d4e42bc:	49 92 00 00 
8d4e42c0:	81 09       	CC = R1 < R0 (IU);
8d4e42c2:	05 10       	IF !CC JUMP 0x0x8d4e42cc;
8d4e42c4:	00 de ed 8f 	CALL.A 0x8fed2b24;
8d4e42c8:	24 2b 00 00 
8d4e42cc:	e2 60       	R2 = 0x1c (X);		/*		R2=0x48( 72) */
8d4e42ce:	71 c2 c2 21 	R7 = R0 * R2 (IS,NS);
8d4e42d2:	07 30       	R0 = R7;
8d4e42d4:	ff e3 80 50 	CALL 0x0x8d4ce3d4;
8d4e42d8:	04 cc 07 04 	R2 = R0 + R7 (NS) || [FP -0x6c] = R0 || NOP;
8d4e42dc:	50 ba 00 00 
8d4e42e0:	60 ba       	[FP -0x68] = R0;
8d4e42e2:	72 ba       	[FP -0x64] = R2;
8d4e42e4:	09 60       	R1 = 0x1 (X);		/*		R1=0xffffffac(-84) */
8d4e42e6:	01 0c       	CC = R1 == 0x0;
8d4e42e8:	7b 1f       	IF CC JUMP 0x0x8d4e41de (BP);
8d4e42ea:	03 c8 00 18 	MNOP || R3 = [FP -0x6c] || R1 = [FP -0x54];
8d4e42ee:	53 b8 b1 b8 
8d4e42f2:	03 c8 00 18 	MNOP || [SP + 0xc] = R3 || R2 = [FP -0x50];
8d4e42f6:	f3 b0 c2 b8 
8d4e42fa:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e42fe:	00 de 03 8c 	CALL.A 0x8c03fd50;
8d4e4302:	50 fd 00 00 
8d4e4306:	60 ba       	[FP -0x68] = R0;
8d4e4308:	6b 2f       	JUMP.S 0x0x8d4e41de;
8d4e430a:	00 00       	NOP;
8d4e430c:	30 e4 10 00 	R0 = [SP + 0x40];
8d4e4310:	28 08       	CC = R0 == R5;
8d4e4312:	16 18       	IF CC JUMP 0x0x8d4e433e;
8d4e4314:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d4e4318:	b8 00 01 00 
8d4e431c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R1 || NOP;
8d4e4320:	f1 b0 00 00 
8d4e4324:	0d 30       	R1 = R5;
8d4e4326:	02 60       	R2 = 0x0 (X);		/*		R2=0x48( 72) */
8d4e4328:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e432c:	70 e9 00 00 
8d4e4330:	e5 64       	R5 += 0x1c;		/* ( 28) */
8d4e4332:	31 e4 10 00 	R1 = [SP + 0x40];
8d4e4336:	29 08       	CC = R1 == R5;
8d4e4338:	e7 64       	R7 += 0x1c;		/* ( 28) */
8d4e433a:	ed 17       	IF !CC JUMP 0x0x8d4e4314 (BP);
8d4e433c:	62 b8       	R2 = [FP -0x68];
8d4e433e:	0f 30       	R1 = R7;
8d4e4340:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e4344:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e4348:	a4 f9 00 00 
8d4e434c:	03 c8 00 18 	MNOP || R0 = [FP -0x50] || R1 = [FP -0x54];
8d4e4350:	c0 b8 b1 b8 
8d4e4354:	04 cc 01 40 	R0 = R0 - R1 (NS) || R3 = [FP -0x6c] || NOP;
8d4e4358:	53 b8 00 00 
8d4e435c:	05 da 49 92 	R5=-1840700269;
8d4e4360:	93 24 00 00 
8d4e4364:	31 c3 85 20 	R2 = R0 * R5 (M,T);
8d4e4368:	82 c6 08 03 	R1 = R0 >>> 0x1f;
8d4e436c:	22 4d       	R2 >>>= 0x4;
8d4e436e:	0a 52       	R0 = R2 - R1;
8d4e4370:	e7 60       	R7 = 0x1c (X);		/*		R7=0x64(100) */
8d4e4372:	f8 40       	R0 *= R7;
8d4e4374:	03 50       	R0 = R3 + R0;
8d4e4376:	60 ba       	[FP -0x68] = R0;
8d4e4378:	33 2f       	JUMP.S 0x0x8d4e41de;
8d4e437a:	17 08       	CC = R7 == R2;
8d4e437c:	31 1b       	IF CC JUMP 0x0x8d4e41de;
8d4e437e:	0f 30       	R1 = R7;
8d4e4380:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e4384:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e4388:	a4 f9 00 00 
8d4e438c:	31 af       	P1 = [SP + 0x30];
8d4e438e:	69 ba       	[FP -0x68] = P1;
8d4e4390:	27 2f       	JUMP.S 0x0x8d4e41de;
8d4e4392:	07 60       	R7 = 0x0 (X);		/*		R7=0x64(100) */
8d4e4394:	e5 2b       	JUMP.S 0x0x8d4e3b5e;
8d4e4396:	07 60       	R7 = 0x0 (X);		/*		R7=0x64(100) */
8d4e4398:	e3 2b       	JUMP.S 0x0x8d4e3b5e;
8d4e439a:	00 00       	NOP;
8d4e439c:	00 e8 1c 00 	LINK 0x70;		/* (112) */
8d4e43a0:	e3 05       	[--SP] = (R7:4, P5:3);
8d4e43a2:	38 30       	R7 = R0;
8d4e43a4:	2f 32       	P5 = R7;
8d4e43a6:	66 6f       	SP += -0x14;		/* (-20) */
8d4e43a8:	06 60       	R6 = 0x0 (X);		/*		R6=0x54( 84) */
8d4e43aa:	83 61       	R3 = 0x30 (X);		/*		R3=0x8c(140) */
8d4e43ac:	7d 60       	R5 = 0xf (X);		/*		R5=0x7c(124) */
8d4e43ae:	56 30       	R2 = SP;
8d4e43b0:	04 cc 13 00 	R0 = R2 + R3 (NS) || [FP -0x5c] = R6 || NOP;
8d4e43b4:	96 ba 00 00 
8d4e43b8:	b6 e6 34 00 	B[SP + 0x34] = R6;
8d4e43bc:	04 cc 24 48 	R4 = R4 - R4 (NS) || [FP -0x58] = R5 || NOP;
8d4e43c0:	a5 ba 00 00 
8d4e43c4:	01 da 03 84 	R1=-2080149268;
8d4e43c8:	ec 70 00 00 
8d4e43cc:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e43d0:	76 a3 00 00 
8d4e43d4:	03 c8 00 18 	MNOP || R1 = [P5 + 0x14] || R0 = [FP -0x5c];
8d4e43d8:	69 a1 90 b8 
8d4e43dc:	81 09       	CC = R1 < R0 (IU);
8d4e43de:	19 32       	P3 = R1;
8d4e43e0:	20 18       	IF CC JUMP 0x0x8d4e4420;
8d4e43e2:	03 c8 00 18 	MNOP || P1 = [SP + 0x34] || R2 = [FP -0x58];
8d4e43e6:	71 af a2 b8 
8d4e43ea:	83 60       	R3 = 0x10 (X);		/*		R3=0x8c(140) */
8d4e43ec:	a0 69       	P0 = 0x34 (X);		/*		P0=0x7c(124) */
8d4e43ee:	13 0a       	CC = R3 <= R2 (IU);
8d4e43f0:	86 5a       	P2 = SP + P0;
8d4e43f2:	d1 07       	IF CC P2 = P1;
8d4e43f4:	00 32       	P0 = R0;
8d4e43f6:	a8 a1       	R0 = [P5 + 0x18];
8d4e43f8:	03 0a       	CC = R3 <= R0 (IU);
8d4e43fa:	4d 32       	P1 = P5;
8d4e43fc:	21 6c       	P1 += 0x4;		/* (  4) */
8d4e43fe:	02 5b       	P4 = P2 + P0;
8d4e4400:	02 10       	IF !CC JUMP 0x0x8d4e4404;
8d4e4402:	49 91       	P1 = [P1];
8d4e4404:	62 08       	CC = P2 == P4;
8d4e4406:	fc 6f       	P4 += -0x1;		/* ( -1) */
8d4e4408:	59 5a       	P1 = P1 + P3;
8d4e440a:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d4e440c:	09 18       	IF CC JUMP 0x0x8d4e441e;
8d4e440e:	a2 e0 07 00 	LSETUP(0x8d4e4412, 0x8d4e441c) LC0 = P0;
8d4e4412:	03 c8 00 18 	MNOP || R0 = B[P4--] (X) || R1 = B[P1--] (X);
8d4e4416:	e0 98 c9 98 
8d4e441a:	08 08       	CC = R0 == R1;
8d4e441c:	02 10       	IF !CC JUMP 0x0x8d4e4420;
8d4e441e:	0c 60       	R4 = 0x1 (X);		/*		R4=0x7c(124) */
8d4e4420:	a0 b8       	R0 = [FP -0x58];
8d4e4422:	81 60       	R1 = 0x10 (X);		/*		R1=0xffffffac(-84) */
8d4e4424:	01 0a       	CC = R1 <= R0 (IU);
8d4e4426:	b7 18       	IF CC JUMP 0x0x8d4e4594;
8d4e4428:	04 0c       	CC = R4 == 0x0;
8d4e442a:	a5 ba       	[FP -0x58] = R5;
8d4e442c:	96 ba       	[FP -0x5c] = R6;
8d4e442e:	b6 e6 34 00 	B[SP + 0x34] = R6;
8d4e4432:	06 10       	IF !CC JUMP 0x0x8d4e443e;
8d4e4434:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e4436:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e4438:	01 e8 00 00 	UNLINK;
8d4e443c:	10 00       	RTS;
8d4e443e:	46 30       	R0 = SP;
8d4e4440:	21 e1 4c 00 	R1 = 0x4c (X);		/*		R1=0x4c( 76) */
8d4e4444:	88 51       	R6 = R0 + R1;
8d4e4446:	06 30       	R0 = R6;
8d4e4448:	ff e3 3b e7 	CALL 0x0x8d4e12be;
8d4e444c:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d4e4450:	b8 00 00 00 
8d4e4454:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d4e4458:	f0 b0 00 00 
8d4e445c:	47 30       	R0 = FP;
8d4e445e:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e4460:	02 60       	R2 = 0x0 (X);		/*		R2=0x48( 72) */
8d4e4462:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e4466:	70 e9 00 00 
8d4e446a:	07 30       	R0 = R7;
8d4e446c:	0e 30       	R1 = R6;
8d4e446e:	e1 64       	R1 += 0x1c;		/* ( 28) */
8d4e4470:	16 30       	R2 = R6;
8d4e4472:	ff e3 f7 fa 	CALL 0x0x8d4e3a60;
8d4e4476:	00 0c       	CC = R0 == 0x0;
8d4e4478:	01 da 03 84 	R1=-2080148832;
8d4e447c:	a0 72 00 00 
8d4e4480:	68 18       	IF CC JUMP 0x0x8d4e4550;
8d4e4482:	03 c8 00 18 	MNOP || P0 = [FP -0x34] || R0 = [FP -0x40];
8d4e4486:	38 b9 00 b9 
8d4e448a:	0a 61       	R2 = 0x21 (X);		/*		R2=0x48( 72) */
8d4e448c:	82 09       	CC = R2 < R0 (IU);
8d4e448e:	39 18       	IF CC JUMP 0x0x8d4e4500;
8d4e4490:	03 c8 00 18 	MNOP || R0 = [FP -0x24] || R3 = [FP -0x20];
8d4e4494:	70 b9 83 b9 
8d4e4498:	42 61       	R2 = 0x28 (X);		/*		R2=0x48( 72) */
8d4e449a:	82 09       	CC = R2 < R0 (IU);
8d4e449c:	22 10       	IF !CC JUMP 0x0x8d4e44e0;
8d4e449e:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e44a2:	fc 1e 00 00 
8d4e44a6:	98 0c       	CC = R0 < 0x3;
8d4e44a8:	09 10       	IF !CC JUMP 0x0x8d4e44ba;
8d4e44aa:	06 30       	R0 = R6;
8d4e44ac:	ff e3 6e e7 	CALL 0x0x8d4e1388;
8d4e44b0:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e44b2:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e44b4:	01 e8 00 00 	UNLINK;
8d4e44b8:	10 00       	RTS;
8d4e44ba:	4f 32       	P1 = FP;
8d4e44bc:	87 60       	R7 = 0x10 (X);		/*		R7=0x64(100) */
8d4e44be:	1f 0a       	CC = R7 <= R3 (IU);
8d4e44c0:	61 6e       	P1 += -0x34;		/* (-52) */
8d4e44c2:	c8 07       	IF CC P1 = P0;
8d4e44c4:	0a da 03 84 	P2=-2080148748;
8d4e44c8:	f4 72 00 00 
8d4e44cc:	31 bd       	[SP + 0x10] = P1;
8d4e44ce:	f2 bc       	[SP + 0xc] = P2;
8d4e44d0:	22 e1 d1 00 	R2 = 0xd1 (X);		/*		R2=0xd1(209) */
8d4e44d4:	18 60       	R0 = 0x3 (X);		/*		R0=0x54( 84) */
8d4e44d6:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e44da:	74 05 00 00 
8d4e44de:	e6 2f       	JUMP.S 0x0x8d4e44aa;
8d4e44e0:	0e 30       	R1 = R6;
8d4e44e2:	00 da 29 84 	R0=-2077631692;
8d4e44e6:	34 db 00 00 
8d4e44ea:	ff e3 fb f3 	CALL 0x0x8d4e2ce0;
8d4e44ee:	06 30       	R0 = R6;
8d4e44f0:	ff e3 4c e7 	CALL 0x0x8d4e1388;
8d4e44f4:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e44f6:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e44f8:	01 e8 00 00 	UNLINK;
8d4e44fc:	10 00       	RTS;
8d4e44fe:	00 00       	NOP;
8d4e4500:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e4504:	fc 1e 00 00 
8d4e4508:	98 0c       	CC = R0 < 0x3;
8d4e450a:	0b 10       	IF !CC JUMP 0x0x8d4e4520;
8d4e450c:	06 30       	R0 = R6;
8d4e450e:	ff e3 3d e7 	CALL 0x0x8d4e1388;
8d4e4512:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e4514:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e4516:	01 e8 00 00 	UNLINK;
8d4e451a:	10 00       	RTS;
8d4e451c:	00 00       	NOP;
8d4e451e:	00 00       	NOP;
8d4e4520:	03 c8 00 18 	MNOP || P0 = [FP -0x50] || R3 = [FP -0x3c];
8d4e4524:	c8 b8 13 b9 
8d4e4528:	29 e1 50 00 	P1 = 0x50 (X);		/*		P1=0x50( 80) */
8d4e452c:	87 60       	R7 = 0x10 (X);		/*		R7=0x64(100) */
8d4e452e:	1f 0a       	CC = R7 <= R3 (IU);
8d4e4530:	4e 5a       	P1 = SP + P1;
8d4e4532:	c8 07       	IF CC P1 = P0;
8d4e4534:	0a da 03 84 	P2=-2080148776;
8d4e4538:	d8 72 00 00 
8d4e453c:	31 bd       	[SP + 0x10] = P1;
8d4e453e:	f2 bc       	[SP + 0xc] = P2;
8d4e4540:	22 e1 cc 00 	R2 = 0xcc (X);		/*		R2=0xcc(204) */
8d4e4544:	18 60       	R0 = 0x3 (X);		/*		R0=0x54( 84) */
8d4e4546:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e454a:	74 05 00 00 
8d4e454e:	df 2f       	JUMP.S 0x0x8d4e450c;
8d4e4550:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e4554:	fc 1e 00 00 
8d4e4558:	98 0c       	CC = R0 < 0x3;
8d4e455a:	09 10       	IF !CC JUMP 0x0x8d4e456c;
8d4e455c:	06 30       	R0 = R6;
8d4e455e:	ff e3 15 e7 	CALL 0x0x8d4e1388;
8d4e4562:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e4564:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e4566:	01 e8 00 00 	UNLINK;
8d4e456a:	10 00       	RTS;
8d4e456c:	a8 a1       	R0 = [P5 + 0x18];
8d4e456e:	82 60       	R2 = 0x10 (X);		/*		R2=0xcc(204) */
8d4e4570:	02 0a       	CC = R2 <= R0 (IU);
8d4e4572:	25 6c       	P5 += 0x4;		/* (  4) */
8d4e4574:	02 10       	IF !CC JUMP 0x0x8d4e4578;
8d4e4576:	6d 91       	P5 = [P5];
8d4e4578:	35 bd       	[SP + 0x10] = P5;
8d4e457a:	09 da 03 84 	P1=-2080148800;
8d4e457e:	c0 72 00 00 
8d4e4582:	f1 bc       	[SP + 0xc] = P1;
8d4e4584:	22 e1 c7 00 	R2 = 0xc7 (X);		/*		R2=0xc7(199) */
8d4e4588:	18 60       	R0 = 0x3 (X);		/*		R0=0x54( 84) */
8d4e458a:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e458e:	74 05 00 00 
8d4e4592:	e5 2f       	JUMP.S 0x0x8d4e455c;
8d4e4594:	70 a3       	R0 = [SP + 0x34];
8d4e4596:	ff e3 27 4f 	CALL 0x0x8d4ce3e4;
8d4e459a:	47 2f       	JUMP.S 0x0x8d4e4428;
8d4e459c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4e45a0:	ed 05       	[--SP] = (R7:5, P5:5);
8d4e45a2:	29 32       	P5 = R1;
8d4e45a4:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e45a6:	01 da 03 84 	R1=-2080149212;
8d4e45aa:	24 71 00 00 
8d4e45ae:	00 de 09 8c 	CALL.A 0x8c09bf88;
8d4e45b2:	88 bf 00 00 
8d4e45b6:	00 0c       	CC = R0 == 0x0;
8d4e45b8:	9e 18       	IF CC JUMP 0x0x8d4e46f4;
8d4e45ba:	68 a1       	R0 = [P5 + 0x14];
8d4e45bc:	51 60       	R1 = 0xa (X);		/*		R1=0x4c( 76) */
8d4e45be:	81 09       	CC = R1 < R0 (IU);
8d4e45c0:	9a 10       	IF !CC JUMP 0x0x8d4e46f4;
8d4e45c2:	25 6c       	P5 += 0x4;		/* (  4) */
8d4e45c4:	04 cc 00 40 	R0 = R0 - R0 (NS) || R3 = [P5 + 0x14] || NOP;
8d4e45c8:	6b a1 00 00 
8d4e45cc:	82 60       	R2 = 0x10 (X);		/*		R2=0xc7(199) */
8d4e45ce:	1a 0a       	CC = R2 <= R3 (IU);
8d4e45d0:	4d 32       	P1 = P5;
8d4e45d2:	02 10       	IF !CC JUMP 0x0x8d4e45d6;
8d4e45d4:	69 91       	P1 = [P5];
8d4e45d6:	4e 99       	R6 = B[P1] (X);
8d4e45d8:	87 61       	R7 = 0x30 (X);		/*		R7=0x64(100) */
8d4e45da:	37 09       	CC = R7 <= R6;
8d4e45dc:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8d4e45de:	04 10       	IF !CC JUMP 0x0x8d4e45e6;
8d4e45e0:	c9 61       	R1 = 0x39 (X);		/*		R1=0x4c( 76) */
8d4e45e2:	0e 09       	CC = R6 <= R1;
8d4e45e4:	01 02       	R1 = CC;
8d4e45e6:	01 0c       	CC = R1 == 0x0;
8d4e45e8:	81 18       	IF CC JUMP 0x0x8d4e46ea;
8d4e45ea:	1a 0a       	CC = R2 <= R3 (IU);
8d4e45ec:	4d 32       	P1 = P5;
8d4e45ee:	02 10       	IF !CC JUMP 0x0x8d4e45f2;
8d4e45f0:	69 91       	P1 = [P5];
8d4e45f2:	8e e5 01 00 	R6 = B[P1 + 0x1] (X);
8d4e45f6:	37 09       	CC = R7 <= R6;
8d4e45f8:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8d4e45fa:	04 10       	IF !CC JUMP 0x0x8d4e4602;
8d4e45fc:	c9 61       	R1 = 0x39 (X);		/*		R1=0x4c( 76) */
8d4e45fe:	0e 09       	CC = R6 <= R1;
8d4e4600:	01 02       	R1 = CC;
8d4e4602:	01 0c       	CC = R1 == 0x0;
8d4e4604:	73 18       	IF CC JUMP 0x0x8d4e46ea;
8d4e4606:	1a 0a       	CC = R2 <= R3 (IU);
8d4e4608:	4d 32       	P1 = P5;
8d4e460a:	02 10       	IF !CC JUMP 0x0x8d4e460e;
8d4e460c:	69 91       	P1 = [P5];
8d4e460e:	8e e5 02 00 	R6 = B[P1 + 0x2] (X);
8d4e4612:	37 09       	CC = R7 <= R6;
8d4e4614:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8d4e4616:	04 10       	IF !CC JUMP 0x0x8d4e461e;
8d4e4618:	c9 61       	R1 = 0x39 (X);		/*		R1=0x4c( 76) */
8d4e461a:	0e 09       	CC = R6 <= R1;
8d4e461c:	01 02       	R1 = CC;
8d4e461e:	01 0c       	CC = R1 == 0x0;
8d4e4620:	65 18       	IF CC JUMP 0x0x8d4e46ea;
8d4e4622:	1a 0a       	CC = R2 <= R3 (IU);
8d4e4624:	4d 32       	P1 = P5;
8d4e4626:	02 10       	IF !CC JUMP 0x0x8d4e462a;
8d4e4628:	69 91       	P1 = [P5];
8d4e462a:	8e e5 03 00 	R6 = B[P1 + 0x3] (X);
8d4e462e:	37 09       	CC = R7 <= R6;
8d4e4630:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8d4e4632:	04 10       	IF !CC JUMP 0x0x8d4e463a;
8d4e4634:	c9 61       	R1 = 0x39 (X);		/*		R1=0x4c( 76) */
8d4e4636:	0e 09       	CC = R6 <= R1;
8d4e4638:	01 02       	R1 = CC;
8d4e463a:	01 0c       	CC = R1 == 0x0;
8d4e463c:	57 18       	IF CC JUMP 0x0x8d4e46ea;
8d4e463e:	1a 0a       	CC = R2 <= R3 (IU);
8d4e4640:	4d 32       	P1 = P5;
8d4e4642:	02 10       	IF !CC JUMP 0x0x8d4e4646;
8d4e4644:	69 91       	P1 = [P5];
8d4e4646:	89 e5 04 00 	R1 = B[P1 + 0x4] (X);
8d4e464a:	6e 61       	R6 = 0x2d (X);		/*		R6=0x54( 84) */
8d4e464c:	31 08       	CC = R1 == R6;
8d4e464e:	4e 10       	IF !CC JUMP 0x0x8d4e46ea;
8d4e4650:	1a 0a       	CC = R2 <= R3 (IU);
8d4e4652:	4d 32       	P1 = P5;
8d4e4654:	02 10       	IF !CC JUMP 0x0x8d4e4658;
8d4e4656:	69 91       	P1 = [P5];
8d4e4658:	8d e5 05 00 	R5 = B[P1 + 0x5] (X);
8d4e465c:	2f 09       	CC = R7 <= R5;
8d4e465e:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8d4e4660:	04 10       	IF !CC JUMP 0x0x8d4e4668;
8d4e4662:	c9 61       	R1 = 0x39 (X);		/*		R1=0x4c( 76) */
8d4e4664:	0d 09       	CC = R5 <= R1;
8d4e4666:	01 02       	R1 = CC;
8d4e4668:	01 0c       	CC = R1 == 0x0;
8d4e466a:	40 18       	IF CC JUMP 0x0x8d4e46ea;
8d4e466c:	1a 0a       	CC = R2 <= R3 (IU);
8d4e466e:	4d 32       	P1 = P5;
8d4e4670:	02 10       	IF !CC JUMP 0x0x8d4e4674;
8d4e4672:	69 91       	P1 = [P5];
8d4e4674:	8d e5 06 00 	R5 = B[P1 + 0x6] (X);
8d4e4678:	2f 09       	CC = R7 <= R5;
8d4e467a:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8d4e467c:	04 10       	IF !CC JUMP 0x0x8d4e4684;
8d4e467e:	c9 61       	R1 = 0x39 (X);		/*		R1=0x4c( 76) */
8d4e4680:	0d 09       	CC = R5 <= R1;
8d4e4682:	01 02       	R1 = CC;
8d4e4684:	01 0c       	CC = R1 == 0x0;
8d4e4686:	32 18       	IF CC JUMP 0x0x8d4e46ea;
8d4e4688:	1a 0a       	CC = R2 <= R3 (IU);
8d4e468a:	4d 32       	P1 = P5;
8d4e468c:	02 10       	IF !CC JUMP 0x0x8d4e4690;
8d4e468e:	69 91       	P1 = [P5];
8d4e4690:	89 e5 07 00 	R1 = B[P1 + 0x7] (X);
8d4e4694:	31 08       	CC = R1 == R6;
8d4e4696:	2a 10       	IF !CC JUMP 0x0x8d4e46ea;
8d4e4698:	1a 0a       	CC = R2 <= R3 (IU);
8d4e469a:	4d 32       	P1 = P5;
8d4e469c:	02 10       	IF !CC JUMP 0x0x8d4e46a0;
8d4e469e:	69 91       	P1 = [P5];
8d4e46a0:	8e e5 08 00 	R6 = B[P1 + 0x8] (X);
8d4e46a4:	37 09       	CC = R7 <= R6;
8d4e46a6:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8d4e46a8:	04 10       	IF !CC JUMP 0x0x8d4e46b0;
8d4e46aa:	c9 61       	R1 = 0x39 (X);		/*		R1=0x4c( 76) */
8d4e46ac:	0e 09       	CC = R6 <= R1;
8d4e46ae:	01 02       	R1 = CC;
8d4e46b0:	01 0c       	CC = R1 == 0x0;
8d4e46b2:	1c 18       	IF CC JUMP 0x0x8d4e46ea;
8d4e46b4:	1a 0a       	CC = R2 <= R3 (IU);
8d4e46b6:	4d 32       	P1 = P5;
8d4e46b8:	02 10       	IF !CC JUMP 0x0x8d4e46bc;
8d4e46ba:	69 91       	P1 = [P5];
8d4e46bc:	8e e5 09 00 	R6 = B[P1 + 0x9] (X);
8d4e46c0:	37 09       	CC = R7 <= R6;
8d4e46c2:	01 60       	R1 = 0x0 (X);		/*		R1=0x4c( 76) */
8d4e46c4:	04 10       	IF !CC JUMP 0x0x8d4e46cc;
8d4e46c6:	c9 61       	R1 = 0x39 (X);		/*		R1=0x4c( 76) */
8d4e46c8:	0e 09       	CC = R6 <= R1;
8d4e46ca:	01 02       	R1 = CC;
8d4e46cc:	01 0c       	CC = R1 == 0x0;
8d4e46ce:	0e 18       	IF CC JUMP 0x0x8d4e46ea;
8d4e46d0:	1a 0a       	CC = R2 <= R3 (IU);
8d4e46d2:	02 10       	IF !CC JUMP 0x0x8d4e46d6;
8d4e46d4:	6d 91       	P5 = [P5];
8d4e46d6:	a8 e5 0a 00 	R0 = B[P5 + 0xa] (X);
8d4e46da:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e46dc:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e46de:	01 e8 00 00 	UNLINK;
8d4e46e2:	01 61       	R1 = 0x20 (X);		/*		R1=0x4c( 76) */
8d4e46e4:	08 08       	CC = R0 == R1;
8d4e46e6:	00 02       	R0 = CC;
8d4e46e8:	10 00       	RTS;
8d4e46ea:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e46ec:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e46ee:	Address 0x8d4e46f0 is out of bounds.

