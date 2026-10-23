
os.ldr@0x8d573360:     file format binary


Disassembly of section .data:

8d573360 <.data>:
8d573360:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d573364:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d573368:	f7 b0 00 00 
8d57336c:	ff e3 5a ff 	CALL 0x0x8d573220;
8d573370:	22 e1 4c 45 	R2 = 0x454c (X);		/*		R2=0x454c(17740) */
8d573374:	10 50       	R0 = R0 + R2;
8d573376:	0f 30       	R1 = R7;
8d573378:	82 61       	R2 = 0x30 (X);		/*		R2=0x454c(17740) */
8d57337a:	00 de 02 04 	CALL.A 0x040232e4;
8d57337e:	e4 32 00 00 
8d573382:	09 da 09 84 	P1=-2079740428;
8d573386:	f4 ad 00 00 
8d57338a:	48 a0       	R0 = [P1 + 0x4];
8d57338c:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d57338e:	04 cc 01 00 	R0 = R0 + R1 (NS) || B[P1] = R1 || NOP;
8d573392:	09 9b 00 00 
8d573396:	48 b0       	[P1 + 0x4] = R0;
8d573398:	f7 a0       	R7 = [SP + 0xc];
8d57339a:	01 e8 00 00 	UNLINK;
8d57339e:	10 00       	RTS;
8d5733a0:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d5733a4:	ff e3 3e ff 	CALL 0x0x8d573220;
8d5733a8:	01 e8 00 00 	UNLINK;
8d5733ac:	21 e1 4c 45 	R1 = 0x454c (X);		/*		R1=0x454c(17740) */
8d5733b0:	08 50       	R0 = R0 + R1;
8d5733b2:	10 00       	RTS;
