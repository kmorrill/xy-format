
os.ldr@0x8d4fd09c:     file format binary


Disassembly of section .data:

8d4fd09c <.data>:
8d4fd09c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4fd0a0:	01 e8 00 00 	UNLINK;
8d4fd0a4:	81 61       	R1 = 0x30 (X);		/*		R1=0x0(  0) */
8d4fd0a6:	02 da 6d 84 	R2=-2073168304;
8d4fd0aa:	50 f6 00 00 
8d4fd0ae:	c8 40       	R0 *= R1;
8d4fd0b0:	02 50       	R0 = R2 + R0;
8d4fd0b2:	80 64       	R0 += 0x10;		/* ( 16) */
8d4fd0b4:	10 00       	RTS;
8d4fd0b6:	80 0c       	CC = R0 < 0x0;
8d4fd0b8:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4fd0bc:	04 18       	IF CC JUMP 0x0x8d4fd0c4;
8d4fd0be:	09 61       	R1 = 0x21 (X);		/*		R1=0x0(  0) */
8d4fd0c0:	88 08       	CC = R0 < R1;
8d4fd0c2:	05 18       	IF CC JUMP 0x0x8d4fd0cc;
8d4fd0c4:	01 e8 00 00 	UNLINK;
8d4fd0c8:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4fd0ca:	10 00       	RTS;
8d4fd0cc:	81 61       	R1 = 0x30 (X);		/*		R1=0x0(  0) */
8d4fd0ce:	02 da 6d 84 	R2=-2073168304;
8d4fd0d2:	50 f6 00 00 
8d4fd0d6:	c8 40       	R0 *= R1;
8d4fd0d8:	02 50       	R0 = R2 + R0;
8d4fd0da:	08 32       	P1 = R0;
8d4fd0dc:	88 e5 10 00 	R0 = B[P1 + 0x10] (X);
8d4fd0e0:	00 0c       	CC = R0 == 0x0;
8d4fd0e2:	f1 1b       	IF CC JUMP 0x0x8d4fd0c4;
8d4fd0e4:	01 e8 00 00 	UNLINK;
8d4fd0e8:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4fd0ea:	10 00       	RTS;
8d4fd0ec:	00 e8 08 00 	LINK 0x20;		/* (32) */
8d4fd0f0:	0a da 04 84 	P2=-2080097236;
8d4fd0f4:	2c 3c 00 00 
8d4fd0f8:	11 90       	R1 = [P2++];
8d4fd0fa:	03 c8 00 18 	MNOP || [SP + 0x0] = R1 || R1 = [P2++];
8d4fd0fe:	31 b0 11 90 
8d4fd102:	4f 32       	P1 = FP;
8d4fd104:	12 90       	R2 = [P2++];
8d4fd106:	00 32       	P0 = R0;
8d4fd108:	01 6f       	P1 += -0x20;		/* (-32) */
8d4fd10a:	03 c8 00 18 	MNOP || R0 = [P2++] || [P1 + 0x4] = R1;
8d4fd10e:	10 90 49 b0 
8d4fd112:	03 c8 00 18 	MNOP || R1 = [P2++] || [P1 + 0x8] = R2;
8d4fd116:	11 90 8a b0 
8d4fd11a:	03 c8 00 18 	MNOP || R2 = [P2++] || [P1 + 0xc] = R0;
8d4fd11e:	12 90 c8 b0 
8d4fd122:	03 c8 00 18 	MNOP || R3 = [P2++] || [P1 + 0x10] = R1;
8d4fd126:	13 90 09 b1 
8d4fd12a:	03 c8 00 18 	MNOP || [P1 + 0x18] = R3 || R3 = [P2];
8d4fd12e:	8b b1 13 91 
8d4fd132:	4a b1       	[P1 + 0x14] = R2;
8d4fd134:	cb b1       	[P1 + 0x1c] = R3;
8d4fd136:	41 5e       	P1 = P1 + (P0 << 0x2);
8d4fd138:	08 91       	R0 = [P1];
8d4fd13a:	01 e8 00 00 	UNLINK;
8d4fd13e:	10 00       	RTS;
8d4fd140:	00 e8 08 00 	LINK 0x20;		/* (32) */
8d4fd144:	0a da 04 84 	P2=-2080097204;
8d4fd148:	4c 3c 00 00 
8d4fd14c:	11 90       	R1 = [P2++];
8d4fd14e:	03 c8 00 18 	MNOP || [SP + 0x0] = R1 || R1 = [P2++];
8d4fd152:	31 b0 11 90 
8d4fd156:	4f 32       	P1 = FP;
8d4fd158:	12 90       	R2 = [P2++];
8d4fd15a:	00 32       	P0 = R0;
8d4fd15c:	01 6f       	P1 += -0x20;		/* (-32) */
8d4fd15e:	03 c8 00 18 	MNOP || R0 = [P2++] || [P1 + 0x4] = R1;
8d4fd162:	10 90 49 b0 
8d4fd166:	03 c8 00 18 	MNOP || R1 = [P2++] || [P1 + 0x8] = R2;
8d4fd16a:	11 90 8a b0 
8d4fd16e:	03 c8 00 18 	MNOP || R2 = [P2++] || [P1 + 0xc] = R0;
8d4fd172:	12 90 c8 b0 
8d4fd176:	03 c8 00 18 	MNOP || R3 = [P2++] || [P1 + 0x10] = R1;
8d4fd17a:	13 90 09 b1 
8d4fd17e:	03 c8 00 18 	MNOP || [P1 + 0x18] = R3 || R3 = [P2];
8d4fd182:	8b b1 13 91 
8d4fd186:	4a b1       	[P1 + 0x14] = R2;
8d4fd188:	cb b1       	[P1 + 0x1c] = R3;
8d4fd18a:	41 5e       	P1 = P1 + (P0 << 0x2);
8d4fd18c:	08 91       	R0 = [P1];
8d4fd18e:	01 e8 00 00 	UNLINK;
8d4fd192:	10 00       	RTS;
8d4fd194:	00 e8 08 00 	LINK 0x20;		/* (32) */
8d4fd198:	0a da 04 84 	P2=-2080097172;
8d4fd19c:	6c 3c 00 00 
8d4fd1a0:	11 90       	R1 = [P2++];
8d4fd1a2:	03 c8 00 18 	MNOP || [SP + 0x0] = R1 || R1 = [P2++];
8d4fd1a6:	31 b0 11 90 
8d4fd1aa:	4f 32       	P1 = FP;
8d4fd1ac:	12 90       	R2 = [P2++];
8d4fd1ae:	00 32       	P0 = R0;
8d4fd1b0:	01 6f       	P1 += -0x20;		/* (-32) */
8d4fd1b2:	03 c8 00 18 	MNOP || R0 = [P2++] || [P1 + 0x4] = R1;
8d4fd1b6:	10 90 49 b0 
8d4fd1ba:	03 c8 00 18 	MNOP || R1 = [P2++] || [P1 + 0x8] = R2;
8d4fd1be:	11 90 8a b0 
8d4fd1c2:	03 c8 00 18 	MNOP || R2 = [P2++] || [P1 + 0xc] = R0;
8d4fd1c6:	12 90 c8 b0 
8d4fd1ca:	03 c8 00 18 	MNOP || R3 = [P2++] || [P1 + 0x10] = R1;
8d4fd1ce:	13 90 09 b1 
8d4fd1d2:	03 c8 00 18 	MNOP || [P1 + 0x18] = R3 || R3 = [P2];
8d4fd1d6:	8b b1 13 91 
8d4fd1da:	4a b1       	[P1 + 0x14] = R2;
8d4fd1dc:	cb b1       	[P1 + 0x1c] = R3;
8d4fd1de:	41 5e       	P1 = P1 + (P0 << 0x2);
8d4fd1e0:	08 91       	R0 = [P1];
8d4fd1e2:	01 e8 00 00 	UNLINK;
8d4fd1e6:	10 00       	RTS;
8d4fd1e8:	00 e8 08 00 	LINK 0x20;		/* (32) */
8d4fd1ec:	0a da 04 84 	P2=-2080097140;
8d4fd1f0:	8c 3c 00 00 
8d4fd1f4:	11 90       	R1 = [P2++];
8d4fd1f6:	03 c8 00 18 	MNOP || [SP + 0x0] = R1 || R1 = [P2++];
8d4fd1fa:	31 b0 11 90 
8d4fd1fe:	4f 32       	P1 = FP;
8d4fd200:	12 90       	R2 = [P2++];
8d4fd202:	00 32       	P0 = R0;
8d4fd204:	01 6f       	P1 += -0x20;		/* (-32) */
8d4fd206:	03 c8 00 18 	MNOP || R0 = [P2++] || [P1 + 0x4] = R1;
8d4fd20a:	10 90 49 b0 
8d4fd20e:	03 c8 00 18 	MNOP || R1 = [P2++] || [P1 + 0x8] = R2;
8d4fd212:	11 90 8a b0 
8d4fd216:	03 c8 00 18 	MNOP || R2 = [P2++] || [P1 + 0xc] = R0;
8d4fd21a:	12 90 c8 b0 
8d4fd21e:	03 c8 00 18 	MNOP || R3 = [P2++] || [P1 + 0x10] = R1;
8d4fd222:	13 90 09 b1 
8d4fd226:	03 c8 00 18 	MNOP || [P1 + 0x18] = R3 || R3 = [P2];
8d4fd22a:	8b b1 13 91 
8d4fd22e:	4a b1       	[P1 + 0x14] = R2;
8d4fd230:	cb b1       	[P1 + 0x1c] = R3;
8d4fd232:	41 5e       	P1 = P1 + (P0 << 0x2);
8d4fd234:	08 91       	R0 = [P1];
8d4fd236:	01 e8 00 00 	UNLINK;
8d4fd23a:	10 00       	RTS;
8d4fd23c:	00 e8 08 00 	LINK 0x20;		/* (32) */
8d4fd240:	0a da 04 84 	P2=-2080097108;
8d4fd244:	ac 3c 00 00 
8d4fd248:	11 90       	R1 = [P2++];
8d4fd24a:	03 c8 00 18 	MNOP || [SP + 0x0] = R1 || R1 = [P2++];
8d4fd24e:	31 b0 11 90 
8d4fd252:	4f 32       	P1 = FP;
8d4fd254:	12 90       	R2 = [P2++];
8d4fd256:	00 32       	P0 = R0;
8d4fd258:	01 6f       	P1 += -0x20;		/* (-32) */
8d4fd25a:	03 c8 00 18 	MNOP || R0 = [P2++] || [P1 + 0x4] = R1;
8d4fd25e:	10 90 49 b0 
8d4fd262:	03 c8 00 18 	MNOP || R1 = [P2++] || [P1 + 0x8] = R2;
8d4fd266:	11 90 8a b0 
8d4fd26a:	03 c8 00 18 	MNOP || R2 = [P2++] || [P1 + 0xc] = R0;
8d4fd26e:	12 90 c8 b0 
8d4fd272:	03 c8 00 18 	MNOP || R3 = [P2++] || [P1 + 0x10] = R1;
8d4fd276:	13 90 09 b1 
8d4fd27a:	03 c8 00 18 	MNOP || [P1 + 0x18] = R3 || R3 = [P2];
8d4fd27e:	8b b1 13 91 
8d4fd282:	4a b1       	[P1 + 0x14] = R2;
8d4fd284:	cb b1       	[P1 + 0x1c] = R3;
8d4fd286:	41 5e       	P1 = P1 + (P0 << 0x2);
8d4fd288:	08 91       	R0 = [P1];
8d4fd28a:	01 e8 00 00 	UNLINK;
8d4fd28e:	10 00       	RTS;
8d4fd290:	00 e8 08 00 	LINK 0x20;		/* (32) */
8d4fd294:	0a da 04 84 	P2=-2080097076;
8d4fd298:	cc 3c 00 00 
8d4fd29c:	11 90       	R1 = [P2++];
8d4fd29e:	03 c8 00 18 	MNOP || [SP + 0x0] = R1 || R1 = [P2++];
8d4fd2a2:	31 b0 11 90 
8d4fd2a6:	4f 32       	P1 = FP;
8d4fd2a8:	12 90       	R2 = [P2++];
8d4fd2aa:	00 32       	P0 = R0;
8d4fd2ac:	01 6f       	P1 += -0x20;		/* (-32) */
8d4fd2ae:	03 c8 00 18 	MNOP || R0 = [P2++] || [P1 + 0x4] = R1;
8d4fd2b2:	10 90 49 b0 
8d4fd2b6:	03 c8 00 18 	MNOP || R1 = [P2++] || [P1 + 0x8] = R2;
8d4fd2ba:	11 90 8a b0 
8d4fd2be:	03 c8 00 18 	MNOP || R2 = [P2++] || [P1 + 0xc] = R0;
8d4fd2c2:	12 90 c8 b0 
8d4fd2c6:	03 c8 00 18 	MNOP || R3 = [P2++] || [P1 + 0x10] = R1;
8d4fd2ca:	13 90 09 b1 
8d4fd2ce:	03 c8 00 18 	MNOP || [P1 + 0x18] = R3 || R3 = [P2];
8d4fd2d2:	8b b1 13 91 
8d4fd2d6:	4a b1       	[P1 + 0x14] = R2;
8d4fd2d8:	cb b1       	[P1 + 0x1c] = R3;
8d4fd2da:	41 5e       	P1 = P1 + (P0 << 0x2);
8d4fd2dc:	08 91       	R0 = [P1];
8d4fd2de:	01 e8 00 00 	UNLINK;
8d4fd2e2:	10 00       	RTS;
8d4fd2e4:	00 e8 08 00 	LINK 0x20;		/* (32) */
8d4fd2e8:	0a da 04 84 	P2=-2080097044;
8d4fd2ec:	ec 3c 00 00 
8d4fd2f0:	11 90       	R1 = [P2++];
8d4fd2f2:	03 c8 00 18 	MNOP || [SP + 0x0] = R1 || R1 = [P2++];
8d4fd2f6:	31 b0 11 90 
8d4fd2fa:	4f 32       	P1 = FP;
