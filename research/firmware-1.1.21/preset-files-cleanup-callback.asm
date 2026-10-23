
os.ldr@0x8d4dca38:     file format binary


Disassembly of section .data:

8d4dca38 <.data>:
8d4dca38:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d4dca3c:	e3 05       	[--SP] = (R7:4, P5:3);
8d4dca3e:	a6 6f       	SP += -0xc;		/* (-12) */
8d4dca40:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P1 = [FP + 0x14] || [FP + 0xc] = R0;
8d4dca44:	79 ad f8 b0 
8d4dca48:	39 b1       	[FP + 0x10] = R1;
8d4dca4a:	03 c8 00 18 	MNOP || R5 = [P1 + 0x4] || R4 = [P1 + 0x8];
8d4dca4e:	4d a0 8c a0 
8d4dca52:	25 08       	CC = R5 == R4;
8d4dca54:	60 18       	IF CC JUMP 0x0x8d4dcb14;
8d4dca56:	f9 ac       	P1 = [FP + 0xc];
8d4dca58:	4c ac       	P4 = [P1 + 0x4];
8d4dca5a:	63 ac       	P3 = [P4 + 0x4];
8d4dca5c:	6c 32       	P5 = P4;
8d4dca5e:	98 e5 29 00 	R0 = B[P3 + 0x29] (X);
8d4dca62:	00 0c       	CC = R0 == 0x0;
8d4dca64:	10 10       	IF !CC JUMP 0x0x8d4dca84;
8d4dca66:	73 30       	R6 = P3;
8d4dca68:	66 64       	R6 += 0xc;		/* ( 12) */
8d4dca6a:	15 30       	R2 = R5;
8d4dca6c:	07 30       	R0 = R7;
8d4dca6e:	0e 30       	R1 = R6;
8d4dca70:	ff e3 b4 f9 	CALL 0x0x8d4dbdd8;
8d4dca74:	00 0c       	CC = R0 == 0x0;
8d4dca76:	ad 18       	IF CC JUMP 0x0x8d4dcbd0;
8d4dca78:	43 6c       	P3 += 0x8;		/* (  8) */
8d4dca7a:	5b 91       	P3 = [P3];
8d4dca7c:	98 e5 29 00 	R0 = B[P3 + 0x29] (X);
8d4dca80:	00 0c       	CC = R0 == 0x0;
8d4dca82:	f2 1f       	IF CC JUMP 0x0x8d4dca66 (BP);
8d4dca84:	a8 e5 29 00 	R0 = B[P5 + 0x29] (X);
8d4dca88:	00 0c       	CC = R0 == 0x0;
8d4dca8a:	4d 32       	P1 = P5;
8d4dca8c:	04 18       	IF CC JUMP 0x0x8d4dca94;
8d4dca8e:	f9 ac       	P1 = [FP + 0xc];
8d4dca90:	49 ac       	P1 = [P1 + 0x4];
8d4dca92:	21 6c       	P1 += 0x4;		/* (  4) */
8d4dca94:	4b 91       	P3 = [P1];
8d4dca96:	98 e5 29 00 	R0 = B[P3 + 0x29] (X);
8d4dca9a:	00 0c       	CC = R0 == 0x0;
8d4dca9c:	15 10       	IF !CC JUMP 0x0x8d4dcac6;
8d4dca9e:	bd bc       	[FP + 0x8] = P5;
8d4dcaa0:	53 30       	R2 = P3;
8d4dcaa2:	0d 30       	R1 = R5;
8d4dcaa4:	07 30       	R0 = R7;
8d4dcaa6:	62 64       	R2 += 0xc;		/* ( 12) */
8d4dcaa8:	ff e3 98 f9 	CALL 0x0x8d4dbdd8;
8d4dcaac:	6b 32       	P5 = P3;
8d4dcaae:	00 0c       	CC = R0 == 0x0;
8d4dcab0:	43 6c       	P3 += 0x8;		/* (  8) */
8d4dcab2:	4d 32       	P1 = P5;
8d4dcab4:	cb 07       	IF CC P1 = P3;
8d4dcab6:	b8 ac       	P0 = [FP + 0x8];
8d4dcab8:	4b 91       	P3 = [P1];
8d4dcaba:	e8 07       	IF CC P5 = P0;
8d4dcabc:	bd bc       	[FP + 0x8] = P5;
8d4dcabe:	98 e5 29 00 	R0 = B[P3 + 0x29] (X);
8d4dcac2:	00 0c       	CC = R0 == 0x0;
8d4dcac4:	ee 1f       	IF CC JUMP 0x0x8d4dcaa0 (BP);
8d4dcac6:	6c 08       	CC = P4 == P5;
8d4dcac8:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4dcaca:	20 18       	IF CC JUMP 0x0x8d4dcb0a;
8d4dcacc:	d0 e0 1d 00 	LSETUP_IMM(bottom=0x8d4dcb06) LC1 count_fields=0x0/0x0;
8d4dcad0:	08 64       	R0 += 0x1;		/* (  1) */
8d4dcad2:	a1 e5 29 00 	R1 = B[P4 + 0x29] (X);
8d4dcad6:	01 0c       	CC = R1 == 0x0;
8d4dcad8:	16 10       	IF !CC JUMP 0x0x8d4dcb04;
8d4dcada:	a0 ac       	P0 = [P4 + 0x8];
8d4dcadc:	81 e5 29 00 	R1 = B[P0 + 0x29] (X);
8d4dcae0:	01 0c       	CC = R1 == 0x0;
8d4dcae2:	65 10       	IF !CC JUMP 0x0x8d4dcbac;
8d4dcae4:	41 91       	P1 = [P0];
8d4dcae6:	60 32       	P4 = P0;
8d4dcae8:	89 e5 29 00 	R1 = B[P1 + 0x29] (X);
8d4dcaec:	01 0c       	CC = R1 == 0x0;
8d4dcaee:	0b 10       	IF !CC JUMP 0x0x8d4dcb04;
8d4dcaf0:	c0 e0 07 00 	LSETUP_IMM(bottom=0x8d4dcafe) LC0 count_fields=0x0/0x0;
8d4dcaf4:	61 32       	P4 = P1;
8d4dcaf6:	61 91       	P1 = [P4];
8d4dcaf8:	89 e5 29 00 	R1 = B[P1 + 0x29] (X);
8d4dcafc:	01 0c       	CC = R1 == 0x0;
8d4dcafe:	03 10       	IF !CC JUMP 0x0x8d4dcb04;
8d4dcb00:	61 91       	P1 = [P4];
8d4dcb02:	f7 2f       	JUMP.S 0x0x8d4dcaf0;
8d4dcb04:	65 08       	CC = P5 == P4;
8d4dcb06:	02 18       	IF CC JUMP 0x0x8d4dcb0a;
8d4dcb08:	e2 2f       	JUMP.S 0x0x8d4dcacc;
8d4dcb0a:	00 0c       	CC = R0 == 0x0;
8d4dcb0c:	09 18       	IF CC JUMP 0x0x8d4dcb1e;
8d4dcb0e:	e5 64       	R5 += 0x1c;		/* ( 28) */
8d4dcb10:	2c 08       	CC = R4 == R5;
8d4dcb12:	a2 17       	IF !CC JUMP 0x0x8d4dca56 (BP);
8d4dcb14:	66 6c       	SP += 0xc;		/* ( 12) */
8d4dcb16:	a3 05       	(R7:4, P5:3) = [SP++];
8d4dcb18:	01 e8 00 00 	UNLINK;
8d4dcb1c:	10 00       	RTS;
8d4dcb1e:	77 30       	R6 = FP;
8d4dcb20:	46 66       	R6 += -0x38;		/* (-56) */
8d4dcb22:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d4dcb26:	39 a1 00 00 
8d4dcb2a:	02 da 03 84 	R2=-2080152856;
8d4dcb2e:	e8 62 00 00 
8d4dcb32:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4dcb36:	94 f1 00 00 
8d4dcb3a:	06 30       	R0 = R6;
8d4dcb3c:	0e 30       	R1 = R6;
8d4dcb3e:	15 30       	R2 = R5;
8d4dcb40:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4dcb42:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d4dcb46:	e4 f0 00 00 
8d4dcb4a:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d4dcb4c:	80 b9       	R0 = [FP -0x20];
8d4dcb4e:	06 0a       	CC = R6 <= R0 (IU);
8d4dcb50:	29 18       	IF CC JUMP 0x0x8d4dcba2;
8d4dcb52:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4dcb54:	b1 e6 2c 00 	B[SP + 0x2c] = R1;
8d4dcb58:	04 cc 12 44 	R2 = R2 - R2 (NS) || R1 = [FP -0x4] || NOP;
8d4dcb5c:	f1 b9 00 00 
8d4dcb60:	47 30       	R0 = FP;
8d4dcb62:	03 c8 00 18 	MNOP || [SP + 0x3c] = R2 || R2 = [FP -0x18];
8d4dcb66:	f2 b3 a2 b9 
8d4dcb6a:	0e 0a       	CC = R6 <= R1 (IU);
8d4dcb6c:	40 67       	R0 += -0x18;		/* (-24) */
8d4dcb6e:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d4dcb70:	02 07       	IF CC R0 = R2;
8d4dcb72:	83 bb       	[FP -0x20] = R3;
8d4dcb74:	00 de 03 8c 	CALL.A 0x8c03e040;
8d4dcb78:	40 e0 00 00 
8d4dcb7c:	f0 b9       	R0 = [FP -0x4];
8d4dcb7e:	06 0a       	CC = R6 <= R0 (IU);
8d4dcb80:	0d 18       	IF CC JUMP 0x0x8d4dcb9a;
8d4dcb82:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
8d4dcb84:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP -0x4] = R2 || NOP;
8d4dcb88:	f2 bb 00 00 
8d4dcb8c:	04 cc 00 40 	R0 = R0 - R0 (NS) || [FP -0x8] = R1 || NOP;
8d4dcb90:	e1 bb 00 00 
8d4dcb94:	b0 e6 48 00 	B[SP + 0x48] = R0;
8d4dcb98:	bb 2f       	JUMP.S 0x0x8d4dcb0e;
8d4dcb9a:	a0 b9       	R0 = [FP -0x18];
8d4dcb9c:	ff e3 24 8c 	CALL 0x0x8d4ce3e4;
8d4dcba0:	f1 2f       	JUMP.S 0x0x8d4dcb82;
8d4dcba2:	f0 a2       	R0 = [SP + 0x2c];
8d4dcba4:	ff e3 20 8c 	CALL 0x0x8d4ce3e4;
8d4dcba8:	d5 2f       	JUMP.S 0x0x8d4dcb52;
8d4dcbaa:	00 00       	NOP;
8d4dcbac:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d4dcbc2) LC0 count_fields=0x0/0x0;
8d4dcbb0:	61 ac       	P1 = [P4 + 0x4];
8d4dcbb2:	89 e5 29 00 	R1 = B[P1 + 0x29] (X);
8d4dcbb6:	01 0c       	CC = R1 == 0x0;
8d4dcbb8:	09 10       	IF !CC JUMP 0x0x8d4dcbca;
8d4dcbba:	4c 30       	R1 = P4;
8d4dcbbc:	8a a0       	R2 = [P1 + 0x8];
8d4dcbbe:	0a 08       	CC = R2 == R1;
8d4dcbc0:	03 10       	IF !CC JUMP 0x0x8d4dcbc6;
8d4dcbc2:	61 32       	P4 = P1;
8d4dcbc4:	f4 2f       	JUMP.S 0x0x8d4dcbac;
8d4dcbc6:	61 32       	P4 = P1;
8d4dcbc8:	9e 2f       	JUMP.S 0x0x8d4dcb04;
8d4dcbca:	61 32       	P4 = P1;
8d4dcbcc:	9c 2f       	JUMP.S 0x0x8d4dcb04;
8d4dcbce:	00 00       	NOP;
8d4dcbd0:	a8 e5 29 00 	R0 = B[P5 + 0x29] (X);
8d4dcbd4:	00 0c       	CC = R0 == 0x0;
8d4dcbd6:	03 10       	IF !CC JUMP 0x0x8d4dcbdc;
8d4dcbd8:	63 32       	P4 = P3;
8d4dcbda:	50 2f       	JUMP.S 0x0x8d4dca7a;
8d4dcbdc:	16 30       	R2 = R6;
8d4dcbde:	0d 30       	R1 = R5;
8d4dcbe0:	07 30       	R0 = R7;
8d4dcbe2:	ff e3 fb f8 	CALL 0x0x8d4dbdd8;
8d4dcbe6:	00 0c       	CC = R0 == 0x0;
8d4dcbe8:	eb 06       	IF !CC P5 = P3;
8d4dcbea:	f7 2f       	JUMP.S 0x0x8d4dcbd8;
