
os.ldr@0x8d5a2220:     file format binary


Disassembly of section .data:

8d5a2220 <.data>:
8d5a2220:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a2224:	e3 05       	[--SP] = (R7:4, P5:3);
8d5a2226:	a6 6f       	SP += -0xc;		/* (-12) */
8d5a2228:	09 da bd 86 	P1=-2034412020;
8d5a222c:	0c 56 00 00 
8d5a2230:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R0 = B[P1] (X) || NOP;
8d5a2234:	48 99 00 00 
8d5a2238:	06 da bd 86 	R6=-2034412012;
8d5a223c:	14 56 00 00 
8d5a2240:	00 0c       	CC = R0 == 0x0;
8d5a2242:	26 64       	R6 += 0x4;		/* (  4) */
8d5a2244:	07 da bd 86 	R7=-2034412012;
8d5a2248:	14 56 00 00 
8d5a224c:	0b da bd 86 	P3=-2034412012;
8d5a2250:	14 56 00 00 
8d5a2254:	96 18       	IF CC JUMP 0x0x8d5a2380;
8d5a2256:	05 30       	R0 = R5;
8d5a2258:	fa e3 22 d7 	CALL 0x0x8d4fd09c;
8d5a225c:	20 30       	R4 = R0;
8d5a225e:	0c 32       	P1 = R4;
8d5a2260:	61 32       	P4 = P1;
8d5a2262:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || R0 = B[P4++] (Z) || R1 = [P3 + 0x18];
8d5a2266:	20 98 99 a1 
8d5a226a:	00 0c       	CC = R0 == 0x0;
8d5a226c:	fb 17       	IF !CC JUMP 0x0x8d5a2262 (BP);
8d5a226e:	0c 44       	P4 -= P1;
8d5a2270:	04 0c       	CC = R4 == 0x0;
8d5a2272:	fc 6f       	P4 += -0x1;		/* ( -1) */
8d5a2274:	04 cc 00 40 	R0 = R0 - R0 (NS) || R2 = [P3 + 0x4] || NOP;
8d5a2278:	5a a0 00 00 
8d5a227c:	0b 18       	IF CC JUMP 0x0x8d5a2292;
8d5a227e:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d5a2280:	0b 0a       	CC = R3 <= R1 (IU);
8d5a2282:	0e 30       	R1 = R6;
8d5a2284:	0a 07       	IF CC R1 = R2;
8d5a2286:	8c 09       	CC = R4 < R1 (IU);
8d5a2288:	05 18       	IF CC JUMP 0x0x8d5a2292;
8d5a228a:	58 a1       	R0 = [P3 + 0x14];
8d5a228c:	01 50       	R0 = R1 + R0;
8d5a228e:	20 0a       	CC = R0 <= R4 (IU);
8d5a2290:	10 02       	ILLEGAL;
8d5a2292:	00 0c       	CC = R0 == 0x0;
8d5a2294:	45 18       	IF CC JUMP 0x0x8d5a231e;
8d5a2296:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d5a2298:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R2 = [P3 + 0x18] || R3 = [P3 + 0x4];
8d5a229c:	9a a1 5b a0 
8d5a22a0:	11 0a       	CC = R1 <= R2 (IU);
8d5a22a2:	03 07       	IF CC R0 = R3;
8d5a22a4:	04 cc 20 4a 	R5 = R4 - R0 (NS) || R0 = [P3 + 0x14] || NOP;
8d5a22a8:	58 a1 00 00 
8d5a22ac:	a8 09       	CC = R0 < R5 (IU);
8d5a22ae:	31 18       	IF CC JUMP 0x0x8d5a2310;
8d5a22b0:	68 52       	R1 = R0 - R5;
8d5a22b2:	44 30       	R0 = P4;
8d5a22b4:	88 09       	CC = R0 < R1 (IU);
8d5a22b6:	08 07       	IF CC R1 = R0;
8d5a22b8:	4d 50       	R1 = R5 + R1;
8d5a22ba:	07 30       	R0 = R7;
8d5a22bc:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d5a22c0:	b8 00 02 00 
8d5a22c4:	00 de 03 8c 	CALL.A 0x8c03e65c;
8d5a22c8:	5c e6 00 00 
8d5a22cc:	15 30       	R2 = R5;
8d5a22ce:	07 30       	R0 = R7;
8d5a22d0:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d5a22d2:	00 de 03 8c 	CALL.A 0x8c03e65c;
8d5a22d6:	5c e6 00 00 
8d5a22da:	03 c8 00 18 	MNOP || R1 = [P3 + 0x18] || R0 = [P3 + 0x4];
8d5a22de:	99 a1 58 a0 
8d5a22e2:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8d5a22e4:	0a 0a       	CC = R2 <= R1 (IU);
8d5a22e6:	66 6c       	SP += 0xc;		/* ( 12) */
8d5a22e8:	06 06       	IF !CC R0 = R6;
8d5a22ea:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a22ec:	01 e8 00 00 	UNLINK;
8d5a22f0:	10 00       	RTS;
8d5a22f2:	00 00       	NOP;
8d5a22f4:	00 00       	NOP;
8d5a22f6:	00 00       	NOP;
8d5a22f8:	03 c8 00 18 	MNOP || R1 = [P3 + 0x18] || R0 = [P3 + 0x4];
8d5a22fc:	99 a1 58 a0 
8d5a2300:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8d5a2302:	0a 0a       	CC = R2 <= R1 (IU);
8d5a2304:	66 6c       	SP += 0xc;		/* ( 12) */
8d5a2306:	06 06       	IF !CC R0 = R6;
8d5a2308:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a230a:	01 e8 00 00 	UNLINK;
8d5a230e:	10 00       	RTS;
8d5a2310:	07 30       	R0 = R7;
8d5a2312:	00 de ed 8f 	CALL.A 0x8fed51a2;
8d5a2316:	a2 51 00 00 
8d5a231a:	58 a1       	R0 = [P3 + 0x14];
8d5a231c:	ca 2f       	JUMP.S 0x0x8d5a22b0;
8d5a231e:	07 30       	R0 = R7;
8d5a2320:	7c 30       	R7 = P4;
8d5a2322:	0f 30       	R1 = R7;
8d5a2324:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a2326:	00 de 03 8c 	CALL.A 0x8c03e740;
8d5a232a:	40 e7 00 00 
8d5a232e:	0e 32       	P1 = R6;
8d5a2330:	00 0c       	CC = R0 == 0x0;
8d5a2332:	e3 1b       	IF CC JUMP 0x0x8d5a22f8;
8d5a2334:	82 ce 07 c4 	R2 = ROT R7 BY 0x0 || P0 = [P3 + 0x4] || R0 = [P3 + 0x18];
8d5a2338:	58 ac 98 a1 
8d5a233c:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d5a233e:	07 0a       	CC = R7 <= R0 (IU);
8d5a2340:	c8 07       	IF CC P1 = P0;
8d5a2342:	0c 30       	R1 = R4;
8d5a2344:	2e 32       	P5 = R6;
8d5a2346:	41 30       	R0 = P1;
8d5a2348:	00 de 02 04 	CALL.A 0x040201c4;
8d5a234c:	c4 01 00 00 
8d5a2350:	03 c8 00 18 	MNOP || P1 = [P3 + 0x4] || R0 = [P3 + 0x18];
8d5a2354:	59 ac 98 a1 
8d5a2358:	07 0a       	CC = R7 <= R0 (IU);
8d5a235a:	5c bd       	[P3 + 0x14] = P4;
8d5a235c:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8d5a235e:	e9 07       	IF CC P5 = P1;
8d5a2360:	65 5a       	P1 = P5 + P4;
8d5a2362:	0d 9b       	B[P1] = R5;
8d5a2364:	03 c8 00 18 	MNOP || R1 = [P3 + 0x18] || R0 = [P3 + 0x4];
8d5a2368:	99 a1 58 a0 
8d5a236c:	0a 0a       	CC = R2 <= R1 (IU);
8d5a236e:	66 6c       	SP += 0xc;		/* ( 12) */
8d5a2370:	06 06       	IF !CC R0 = R6;
8d5a2372:	a3 05       	(R7:4, P5:3) = [SP++];
8d5a2374:	01 e8 00 00 	UNLINK;
8d5a2378:	10 00       	RTS;
8d5a237a:	00 00       	NOP;
8d5a237c:	00 00       	NOP;
8d5a237e:	00 00       	NOP;
8d5a2380:	00 da bd 86 	R0=-2034412020;
8d5a2384:	0c 56 00 00 
8d5a2388:	00 de ed 8f 	CALL.A 0x8fed4cec;
8d5a238c:	ec 4c 00 00 
8d5a2390:	00 0c       	CC = R0 == 0x0;
8d5a2392:	62 1f       	IF CC JUMP 0x0x8d5a2256 (BP);
8d5a2394:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a2396:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [P3 + 0x14] = R0 || NOP;
8d5a239a:	58 b1 00 00 
8d5a239e:	98 e6 04 00 	B[P3 + 0x4] = R0;
8d5a23a2:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d5a23a4:	98 b1       	[P3 + 0x18] = R0;
8d5a23a6:	02 da c0 86 	R2=-2034223356;
8d5a23aa:	04 37 00 00 
8d5a23ae:	00 da 09 8c 	R0=-1945525452;
8d5a23b2:	34 a3 00 00 
8d5a23b6:	00 de ed 8f 	CALL.A 0x8fed4b1e;
8d5a23ba:	1e 4b 00 00 
8d5a23be:	00 da bd 86 	R0=-2034412020;
8d5a23c2:	0c 56 00 00 
8d5a23c6:	00 de ed 8f 	CALL.A 0x8fed4ce4;
8d5a23ca:	e4 4c 00 00 
8d5a23ce:	44 2f       	JUMP.S 0x0x8d5a2256;
8d5a23d0:	08 32       	P1 = R0;
8d5a23d2:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a23d6:	f8 63       	R0 = -0x1 (X);		/*		R0=0x0(  0) */
8d5a23d8:	08 93       	[P1] = R0;
8d5a23da:	01 e8 00 00 	UNLINK;
8d5a23de:	10 00       	RTS;
8d5a23e0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a23e4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a23e6:	09 da bd 86 	P1=-2034409500;
8d5a23ea:	e4 5f 00 00 
8d5a23ee:	c0 e0 08 60 	LSETUP_IMM(bottom=0x8d5a23fe) LC0 count_fields=0x0/0x18;
8d5a23f2:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || R2 = B[P1++] (Z) || NOP;
8d5a23f6:	0a 98 00 00 
8d5a23fa:	02 0c       	CC = R2 == 0x0;
8d5a23fc:	09 64       	R1 += 0x1;		/* (  1) */
8d5a23fe:	01 06       	IF !CC R0 = R1;
8d5a2400:	00 d8 0a 84 	LdStAbs addr=0x840a6a8c control=0x0200;
8d5a2404:	8c 6a 00 02 
8d5a2408:	01 e8 00 00 	UNLINK;
8d5a240c:	10 00       	RTS;
8d5a240e:	00 00       	NOP;
8d5a2410:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a2414:	00 d8 0a 84 	LdStAbs addr=0x840a6a8a control=0x0400;
8d5a2418:	8a 6a 00 04 
8d5a241c:	01 e8 00 00 	UNLINK;
8d5a2420:	10 00       	RTS;
8d5a2422:	00 00       	NOP;
8d5a2424:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a2428:	01 e8 00 00 	UNLINK;
8d5a242c:	00 da bd 86 	R0=-2034409500;
8d5a2430:	e4 5f 00 00 
8d5a2434:	10 00       	RTS;
8d5a2436:	00 00       	NOP;
8d5a2438:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a243c:	00 d8 0a 84 	LdStAbs addr=0x840a6a8c control=0x0000;
8d5a2440:	8c 6a 00 00 
8d5a2444:	01 e8 00 00 	UNLINK;
8d5a2448:	10 00       	RTS;
8d5a244a:	00 00       	NOP;
8d5a244c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a2450:	00 d8 0a 84 	LdStAbs addr=0x840a6a8c control=0x0000;
8d5a2454:	8c 6a 00 00 
8d5a2458:	01 e8 00 00 	UNLINK;
8d5a245c:	00 0d       	CC = R0 <= 0x0;
8d5a245e:	10 02       	ILLEGAL;
8d5a2460:	10 00       	RTS;
8d5a2462:	00 00       	NOP;
8d5a2464:	00 00       	NOP;
8d5a2466:	00 00       	NOP;
8d5a2468:	01 da bd 86 	R1=-2034409500;
8d5a246c:	e4 5f 00 00 
