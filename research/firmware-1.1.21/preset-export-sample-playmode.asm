
os.ldr@0x8d4db756:     file format binary


Disassembly of section .data:

8d4db756 <.data>:
8d4db756:	08 30       	R1 = R0;
8d4db758:	a1 0d       	CC = R1 < 0x4 (IU);
8d4db75a:	09 32       	P1 = R1;
8d4db75c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4db760:	00 da 03 84 	R0=-2080152984;
8d4db764:	68 62 00 00 
8d4db768:	09 10       	IF !CC JUMP 0x0x8d4db77a;
8d4db76a:	08 da 03 84 	P0=-2080152248;
8d4db76e:	48 65 00 00 
8d4db772:	48 5e       	P1 = P0 + (P1 << 0x2);
8d4db774:	49 91       	P1 = [P1];
8d4db776:	51 00       	JUMP (P1);
8d4db778:	c0 67       	R0 += -0x8;		/* ( -8) */
8d4db77a:	01 e8 00 00 	UNLINK;
8d4db77e:	10 00       	RTS;
8d4db780:	01 e8 00 00 	UNLINK;
8d4db784:	40 64       	R0 += 0x8;		/* (  8) */
8d4db786:	10 00       	RTS;
8d4db788:	01 e8 00 00 	UNLINK;
8d4db78c:	80 64       	R0 += 0x10;		/* ( 16) */
8d4db78e:	10 00       	RTS;
8d4db790:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4db794:	e5 05       	[--SP] = (R7:4, P5:5);
8d4db796:	28 32       	P5 = R0;
8d4db798:	86 6f       	SP += -0x10;		/* (-16) */
8d4db79a:	82 ce 01 c6 	R3 = ROT R1 BY 0x0 || R5 = [SP + 0x38] || R1 = [SP + 0x3c];
8d4db79e:	b5 a3 f1 a3 
8d4db7a2:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4db7a4:	7e 60       	R6 = 0xf (X);		/*		R6=0x0(  0) */
8d4db7a6:	04 cc 12 44 	R2 = R2 - R2 (NS) || [P5 + 0x4] = R2 || NOP;
8d4db7aa:	6a b0 00 00 
8d4db7ae:	03 c8 00 18 	MNOP || [P5 + 0x24] = R6 || R6 = [FP + 0x1c];
8d4db7b2:	6e b2 fe a1 
8d4db7b6:	2b 93       	[P5] = R3;
8d4db7b8:	ad b0       	[P5 + 0x8] = R5;
8d4db7ba:	2f b2       	[P5 + 0x20] = R7;
8d4db7bc:	af e6 10 00 	B[P5 + 0x10] = R7;
8d4db7c0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4db7c4:	b8 00 03 00 
8d4db7c8:	64 60       	R4 = 0xc (X);		/*		R4=0x0(  0) */
8d4db7ca:	04 cc 04 00 	R0 = R0 + R4 (NS) || [SP + 0xc] = R3 || NOP;
8d4db7ce:	f3 b0 00 00 
8d4db7d2:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4db7d6:	70 e9 00 00 
8d4db7da:	ae e6 28 00 	B[P5 + 0x28] = R6;
8d4db7de:	af e6 29 00 	B[P5 + 0x29] = R7;
8d4db7e2:	86 6c       	SP += 0x10;		/* ( 16) */
8d4db7e4:	a5 05       	(R7:4, P5:5) = [SP++];
