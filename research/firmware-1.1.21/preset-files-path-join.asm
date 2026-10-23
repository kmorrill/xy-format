
os.ldr@0x8d5a48a6:     file format binary


Disassembly of section .data:

8d5a48a6 <.data>:
8d5a48a6:	09 32       	P1 = R1;
8d5a48a8:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d5a48ac:	e5 05       	[--SP] = (R7:4, P5:5);
8d5a48ae:	86 6f       	SP += -0x10;		/* (-16) */
8d5a48b0:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d5a48b4:	ba b0 00 00 
8d5a48b8:	4b a1       	R3 = [P1 + 0x14];
8d5a48ba:	03 0c       	CC = R3 == 0x0;
8d5a48bc:	00 32       	P0 = R0;
8d5a48be:	a6 18       	IF CC JUMP 0x0x8d5a4a0a;
8d5a48c0:	03 32       	P0 = R3;
8d5a48c2:	8f a1       	R7 = [P1 + 0x18];
8d5a48c4:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d5a48c6:	3e 0a       	CC = R6 <= R7 (IU);
8d5a48c8:	21 6c       	P1 += 0x4;		/* (  4) */
8d5a48ca:	f8 6f       	P0 += -0x1;		/* ( -1) */
8d5a48cc:	02 10       	IF !CC JUMP 0x0x8d5a48d0;
8d5a48ce:	49 91       	P1 = [P1];
8d5a48d0:	41 5a       	P1 = P1 + P0;
8d5a48d2:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R3 = B[P1] (X) || NOP;
8d5a48d6:	4b 99 00 00 
8d5a48da:	7f 61       	R7 = 0x2f (X);		/*		R7=0x0(  0) */
8d5a48dc:	3b 08       	CC = R3 == R7;
8d5a48de:	0b 10       	IF !CC JUMP 0x0x8d5a48f4;
8d5a48e0:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d5a48e4:	e4 f0 00 00 
8d5a48e8:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a48ea:	a5 05       	(R7:4, P5:5) = [SP++];
8d5a48ec:	01 e8 00 00 	UNLINK;
8d5a48f0:	10 00       	RTS;
8d5a48f2:	00 00       	NOP;
8d5a48f4:	b6 e6 44 00 	B[SP + 0x44] = R6;
8d5a48f8:	7f 30       	R7 = FP;
8d5a48fa:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d5a48fe:	b8 00 00 00 
8d5a4902:	27 67       	R7 += -0x1c;		/* (-28) */
8d5a4904:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d5a4906:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d5a490a:	f0 b0 00 00 
8d5a490e:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x8] = R6 || NOP;
8d5a4912:	e6 bb 00 00 
8d5a4916:	f3 bb       	[FP -0x4] = R3;
8d5a4918:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a491c:	70 e9 00 00 
8d5a4920:	e4 b9       	R4 = [FP -0x8];
8d5a4922:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d5a4926:	b8 00 00 00 
8d5a492a:	20 52       	R0 = R0 - R4;
8d5a492c:	08 0e       	CC = R0 <= 0x1 (IU);
8d5a492e:	67 18       	IF CC JUMP 0x0x8d5a49fc;
8d5a4930:	0c 64       	R4 += 0x1;		/* (  1) */
8d5a4932:	07 30       	R0 = R7;
8d5a4934:	0c 30       	R1 = R4;
8d5a4936:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a4938:	00 de 03 8c 	CALL.A 0x8c03e740;
8d5a493c:	40 e7 00 00 
8d5a4940:	00 0c       	CC = R0 == 0x0;
8d5a4942:	1a 18       	IF CC JUMP 0x0x8d5a4976;
8d5a4944:	03 c8 00 18 	MNOP || P2 = [FP -0x18] || R0 = [FP -0x4];
8d5a4948:	aa b9 f0 b9 
8d5a494c:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d5a494e:	4f 32       	P1 = FP;
8d5a4950:	01 0a       	CC = R1 <= R0 (IU);
8d5a4952:	41 6f       	P1 += -0x18;		/* (-24) */
8d5a4954:	ca 07       	IF CC P1 = P2;
8d5a4956:	ed b9       	P5 = [FP -0x8];
8d5a4958:	78 61       	R0 = 0x2f (X);		/*		R0=0x0(  0) */
8d5a495a:	47 32       	P0 = FP;
8d5a495c:	40 6f       	P0 += -0x18;		/* (-24) */
8d5a495e:	69 5a       	P1 = P1 + P5;
8d5a4960:	08 9b       	B[P1] = R0;
8d5a4962:	03 c8 00 18 	MNOP || P1 = [FP -0x18] || R0 = [FP -0x4];
8d5a4966:	a9 b9 f0 b9 
8d5a496a:	01 0a       	CC = R1 <= R0 (IU);
8d5a496c:	14 32       	P2 = R4;
8d5a496e:	e4 bb       	[FP -0x8] = R4;
8d5a4970:	c1 07       	IF CC P0 = P1;
8d5a4972:	50 5a       	P1 = P0 + P2;
8d5a4974:	0e 9b       	B[P1] = R6;
8d5a4976:	b6 e6 28 00 	B[SP + 0x28] = R6;
8d5a497a:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0x38] = R6 || NOP;
8d5a497e:	b6 b3 00 00 
8d5a4982:	27 67       	R7 += -0x1c;		/* (-28) */
8d5a4984:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a4988:	b8 00 03 00 
8d5a498c:	7c 60       	R4 = 0xf (X);		/*		R4=0x0(  0) */
8d5a498e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0x3c] = R4 || NOP;
8d5a4992:	f4 b3 00 00 
8d5a4996:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d5a499a:	f3 b0 00 00 
8d5a499e:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a49a2:	70 e9 00 00 
8d5a49a6:	84 60       	R4 = 0x10 (X);		/*		R4=0x0(  0) */
8d5a49a8:	f0 b9       	R0 = [FP -0x4];
8d5a49aa:	04 0a       	CC = R4 <= R0 (IU);
8d5a49ac:	24 18       	IF CC JUMP 0x0x8d5a49f4;
8d5a49ae:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d5a49b0:	4f 30       	R1 = FP;
8d5a49b2:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP -0x8] = R6 || R2 = [FP + 0x8];
8d5a49b6:	e6 bb ba a0 
8d5a49ba:	b6 e6 44 00 	B[SP + 0x44] = R6;
8d5a49be:	f3 bb       	[FP -0x4] = R3;
8d5a49c0:	41 66       	R1 += -0x38;		/* (-56) */
8d5a49c2:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d5a49c6:	e4 f0 00 00 
8d5a49ca:	f0 a3       	R0 = [SP + 0x3c];
8d5a49cc:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d5a49ce:	03 0a       	CC = R3 <= R0 (IU);
8d5a49d0:	08 18       	IF CC JUMP 0x0x8d5a49e0;
8d5a49d2:	b6 e6 28 00 	B[SP + 0x28] = R6;
8d5a49d6:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a49d8:	a5 05       	(R7:4, P5:5) = [SP++];
8d5a49da:	01 e8 00 00 	UNLINK;
8d5a49de:	10 00       	RTS;
8d5a49e0:	b0 a2       	R0 = [SP + 0x28];
8d5a49e2:	f9 e3 01 4d 	CALL 0x0x8d4ce3e4;
8d5a49e6:	b6 e6 28 00 	B[SP + 0x28] = R6;
8d5a49ea:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a49ec:	a5 05       	(R7:4, P5:5) = [SP++];
8d5a49ee:	01 e8 00 00 	UNLINK;
8d5a49f2:	10 00       	RTS;
8d5a49f4:	a0 b9       	R0 = [FP -0x18];
8d5a49f6:	f9 e3 f7 4c 	CALL 0x0x8d4ce3e4;
8d5a49fa:	da 2f       	JUMP.S 0x0x8d5a49ae;
8d5a49fc:	07 30       	R0 = R7;
8d5a49fe:	00 de ed 8f 	CALL.A 0x8fed519c;
8d5a4a02:	9c 51 00 00 
8d5a4a06:	e4 b9       	R4 = [FP -0x8];
8d5a4a08:	94 2f       	JUMP.S 0x0x8d5a4930;
8d5a4a0a:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8d5a4a0c:	82 ce 02 c2 	R1 = ROT R2 BY 0x0 || [P0 + 0x18] = R7 || NOP;
8d5a4a10:	87 b1 00 00 
8d5a4a14:	43 b1       	[P0 + 0x14] = R3;
8d5a4a16:	83 e6 04 00 	B[P0 + 0x4] = R3;
8d5a4a1a:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a4a1e:	b8 00 03 00 
8d5a4a22:	f3 b0       	[SP + 0xc] = R3;
8d5a4a24:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a4a26:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a4a2a:	70 e9 00 00 
8d5a4a2e:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a4a30:	a5 05       	(R7:4, P5:5) = [SP++];
8d5a4a32:	01 e8 00 00 	UNLINK;
8d5a4a36:	10 00       	RTS;
