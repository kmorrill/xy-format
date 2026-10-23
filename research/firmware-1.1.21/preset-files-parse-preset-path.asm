
os.ldr@0x8d4e3924:     file format binary


Disassembly of section .data:

8d4e3924 <.data>:
8d4e3924:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d4e3928:	ec 05       	[--SP] = (R7:5, P5:4);
8d4e392a:	6f 30       	R5 = FP;
8d4e392c:	86 6f       	SP += -0x10;		/* (-16) */
8d4e392e:	45 64       	R5 += 0x8;		/* (  8) */
8d4e3930:	7b 61       	R3 = 0x2f (X);		/*		R3=0x0(  0) */
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
8d4e3974:	79 61       	R1 = 0x2f (X);		/*		R1=0x0(  0) */
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
8d4e39d6:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d4e39d8:	f0 a3       	R0 = [SP + 0x3c];
8d4e39da:	03 0a       	CC = R3 <= R0 (IU);
8d4e39dc:	09 18       	IF CC JUMP 0x0x8d4e39ee;
8d4e39de:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e39e0:	b0 e6 28 00 	B[SP + 0x28] = R0;
8d4e39e4:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e39e6:	ac 05       	(R7:5, P5:4) = [SP++];
8d4e39e8:	01 e8 00 00 	UNLINK;
8d4e39ec:	10 00       	RTS;
8d4e39ee:	b0 a2       	R0 = [SP + 0x28];
8d4e39f0:	ff e3 fa 54 	CALL 0x0x8d4ce3e4;
8d4e39f4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
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
8d4e3a38:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d4e3a3a:	03 0a       	CC = R3 <= R0 (IU);
8d4e3a3c:	0d 18       	IF CC JUMP 0x0x8d4e3a56;
8d4e3a3e:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
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
8d4e3acc:	0c 60       	R4 = 0x1 (X);		/*		R4=0x0(  0) */
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
8d4e3b14:	e0 60       	R0 = 0x1c (X);		/*		R0=0x0(  0) */
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
8d4e3b90:	e4 60       	R4 = 0x1c (X);		/*		R4=0x0(  0) */
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
8d4e3bce:	7d 60       	R5 = 0xf (X);		/*		R5=0x0(  0) */
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
8d4e3bf8:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
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
8d4e3c3e:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e3c40:	01 0a       	CC = R1 <= R0 (IU);
8d4e3c42:	02 14       	IF !CC JUMP 0x0x8d4e3c46 (BP);
8d4e3c44:	fa 21       	JUMP.S 0x0x8d4e4038;
8d4e3c46:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
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
8d4e3c9a:	7c 60       	R4 = 0xf (X);		/*		R4=0x0(  0) */
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
8d4e3ce6:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
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
8d4e3d18:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e3d1a:	01 0a       	CC = R1 <= R0 (IU);
8d4e3d1c:	76 19       	IF CC JUMP 0x0x8d4e4008;
8d4e3d1e:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
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
8d4e3e1e:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
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
8d4e3e50:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
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
8d4e3eb6:	c9 63       	R1 = -0x7 (X);		/*		R1=0x0(  0) */
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
8d4e3f4c:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
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
8d4e3fa4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e3fa6:	57 1b       	IF CC JUMP 0x0x8d4e3e54;
8d4e3fa8:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e3fac:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e3fb0:	a4 f9 00 00 
8d4e3fb4:	50 b8       	R0 = [FP -0x6c];
8d4e3fb6:	ff e3 17 52 	CALL 0x0x8d4ce3e4;
8d4e3fba:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e3fbc:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e3fbe:	01 e8 00 00 	UNLINK;
8d4e3fc2:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
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
8d4e4004:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
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
8d4e4034:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e4036:	10 00       	RTS;
8d4e4038:	30 e4 13 00 	R0 = [SP + 0x4c];
8d4e403c:	ff e3 d4 51 	CALL 0x0x8d4ce3e4;
8d4e4040:	03 2e       	JUMP.S 0x0x8d4e3c46;
8d4e4042:	fd 2d       	JUMP.S 0x0x8d4e3c3c;
8d4e4044:	01 0c       	CC = R1 == 0x0;
8d4e4046:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e4048:	06 1b       	IF CC JUMP 0x0x8d4e3e54;
8d4e404a:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e404e:	00 de 03 8c 	CALL.A 0x8c03f9a4;
8d4e4052:	a4 f9 00 00 
8d4e4056:	50 b8       	R0 = [FP -0x6c];
8d4e4058:	ff e3 c6 51 	CALL 0x0x8d4ce3e4;
8d4e405c:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e405e:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e4060:	01 e8 00 00 	UNLINK;
8d4e4064:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
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
8d4e4164:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
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
8d4e418e:	e0 60       	R0 = 0x1c (X);		/*		R0=0x0(  0) */
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
8d4e4212:	11 60       	R1 = 0x2 (X);		/*		R1=0x0(  0) */
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
8d4e42b4:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
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
8d4e42e4:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
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
8d4e43a8:	06 60       	R6 = 0x0 (X);		/*		R6=0x0(  0) */
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
8d4e4422:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
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
8d4e44d4:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
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
8d4e4544:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
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
8d4e4588:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
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
8d4e464a:	6e 61       	R6 = 0x2d (X);		/*		R6=0x0(  0) */
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
8d4e46ee:	01 e8 00 00 	UNLINK;
8d4e46f2:	10 00       	RTS;
8d4e46f4:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e46f6:	ad 05       	(R7:5, P5:5) = [SP++];
8d4e46f8:	01 e8 00 00 	UNLINK;
8d4e46fc:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e46fe:	10 00       	RTS;
8d4e4700:	08 32       	P1 = R0;
8d4e4702:	00 e8 26 00 	LINK 0x98;		/* (152) */
8d4e4706:	e3 05       	[--SP] = (R7:4, P5:3);
8d4e4708:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e470a:	85 60       	R5 = 0x10 (X);		/*		R5=0x7c(124) */
8d4e470c:	03 c8 00 18 	MNOP || R2 = [P1 + 0x18] || [SP + 0x30] = R0;
8d4e4710:	8a a1 30 b3 
8d4e4714:	15 0a       	CC = R5 <= R2 (IU);
8d4e4716:	39 b1       	[FP + 0x10] = R1;
8d4e4718:	20 64       	R0 += 0x4;		/* (  4) */
8d4e471a:	03 10       	IF !CC JUMP 0x0x8d4e4720;
8d4e471c:	08 32       	P1 = R0;
8d4e471e:	08 91       	R0 = [P1];
8d4e4720:	00 de 0b 8c 	CALL.A 0x8c0ba6da;
8d4e4724:	da a6 00 00 
8d4e4728:	00 0c       	CC = R0 == 0x0;
8d4e472a:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [FP + 0xc] = R0 || NOP;
8d4e472e:	f8 b0 00 00 
8d4e4732:	51 19       	IF CC JUMP 0x0x8d4e49d4;
8d4e4734:	00 da 03 84 	R0=-2080149236;
8d4e4738:	0c 71 00 00 
8d4e473c:	01 da 03 84 	R1=-2080149236;
8d4e4740:	0c 71 00 00 
8d4e4744:	a0 64       	R0 += 0x14;		/* ( 20) */
8d4e4746:	21 65       	R1 += 0x24;		/* ( 36) */
8d4e4748:	f0 b2       	[SP + 0x2c] = R0;
8d4e474a:	b1 b2       	[SP + 0x28] = R1;
8d4e474c:	7e 60       	R6 = 0xf (X);		/*		R6=0x0(  0) */
8d4e474e:	2d e1 54 00 	P5 = 0x54 (X);		/*		P5=0x54( 84) */
8d4e4752:	f8 a0       	R0 = [FP + 0xc];
8d4e4754:	00 de 0b 8c 	CALL.A 0x8c0ba834;
8d4e4758:	34 a8 00 00 
8d4e475c:	00 0c       	CC = R0 == 0x0;
8d4e475e:	36 19       	IF CC JUMP 0x0x8d4e49ca;
8d4e4760:	20 30       	R4 = R0;
8d4e4762:	5c 64       	R4 += 0xb;		/* ( 11) */
8d4e4764:	0c 32       	P1 = R4;
8d4e4766:	72 61       	R2 = 0x2e (X);		/*		R2=0xc7(199) */
8d4e4768:	a3 61       	R3 = 0x34 (X);		/*		R3=0x8c(140) */
8d4e476a:	c4 69       	P4 = 0x38 (X);		/*		P4=0x0(  0) */
8d4e476c:	49 99       	R1 = B[P1] (X);
8d4e476e:	08 32       	P1 = R0;
8d4e4770:	11 08       	CC = R1 == R2;
8d4e4772:	f0 1b       	IF CC JUMP 0x0x8d4e4752;
8d4e4774:	21 60       	R1 = 0x4 (X);		/*		R1=0x4c( 76) */
8d4e4776:	88 e4 0a 00 	R0 = B[P1 + 0xa] (Z);
8d4e477a:	08 08       	CC = R0 == R1;
8d4e477c:	ed 10       	IF !CC JUMP 0x0x8d4e4956;
8d4e477e:	4e 30       	R1 = SP;
8d4e4780:	04 cc 0b 00 	R0 = R1 + R3 (NS) || [FP -0x74] = R6 || NOP;
8d4e4784:	36 ba 00 00 
8d4e4788:	b7 e6 38 00 	B[SP + 0x38] = R7;
8d4e478c:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [FP -0x78] = R7 || NOP;
8d4e4790:	27 ba 00 00 
8d4e4794:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e4798:	76 a3 00 00 
8d4e479c:	56 30       	R2 = SP;
8d4e479e:	23 e1 50 00 	R3 = 0x50 (X);		/*		R3=0x50( 80) */
8d4e47a2:	b7 e6 54 00 	B[SP + 0x54] = R7;
8d4e47a6:	04 cc 13 00 	R0 = R2 + R3 (NS) || [FP -0x58] = R6 || NOP;
8d4e47aa:	a6 ba 00 00 
8d4e47ae:	97 ba       	[FP -0x5c] = R7;
8d4e47b0:	01 da 03 84 	R1=-2080149236;
8d4e47b4:	0c 71 00 00 
8d4e47b8:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e47bc:	76 a3 00 00 
8d4e47c0:	04 cc 12 44 	R2 = R2 - R2 (NS) || R0 = [FP -0x5c] || R1 = [FP -0x78];
8d4e47c4:	90 b8 21 b8 
8d4e47c8:	81 09       	CC = R1 < R0 (IU);
8d4e47ca:	08 32       	P1 = R0;
8d4e47cc:	03 c8 00 18 	MNOP || P2 = [FP -0x6c] || [FP + 0x8] = R2;
8d4e47d0:	5a b8 ba b0 
8d4e47d4:	1d 18       	IF CC JUMP 0x0x8d4e480e;
8d4e47d6:	a2 b8       	R2 = [FP -0x58];
8d4e47d8:	03 c8 00 18 	MNOP || P0 = [SP + 0x38] || R3 = [FP -0x74];
8d4e47dc:	b0 af 33 b8 
8d4e47e0:	15 0a       	CC = R5 <= R2 (IU);
8d4e47e2:	ee 5a       	P3 = SP + P5;
8d4e47e4:	da 07       	IF CC P3 = P2;
8d4e47e6:	1d 0a       	CC = R5 <= R3 (IU);
8d4e47e8:	26 5b       	P4 = SP + P4;
8d4e47ea:	e0 07       	IF CC P4 = P0;
8d4e47ec:	01 32       	P0 = R1;
8d4e47ee:	8b 5a       	P2 = P3 + P1;
8d4e47f0:	53 08       	CC = P3 == P2;
8d4e47f2:	04 5a       	P0 = P4 + P0;
8d4e47f4:	fa 6f       	P2 += -0x1;		/* ( -1) */
8d4e47f6:	f8 6f       	P0 += -0x1;		/* ( -1) */
8d4e47f8:	09 18       	IF CC JUMP 0x0x8d4e480a;
8d4e47fa:	a2 e0 07 10 	LSETUP(0x8d4e47fe, 0x8d4e4808) LC0 = P1;
8d4e47fe:	03 c8 00 18 	MNOP || R0 = B[P2--] (X) || R1 = B[P0--] (X);
8d4e4802:	d0 98 c1 98 
8d4e4806:	08 08       	CC = R0 == R1;
8d4e4808:	a5 10       	IF !CC JUMP 0x0x8d4e4952;
8d4e480a:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4e480c:	b8 b0       	[FP + 0x8] = R0;
8d4e480e:	a0 b8       	R0 = [FP -0x58];
8d4e4810:	05 0a       	CC = R5 <= R0 (IU);
8d4e4812:	9c 18       	IF CC JUMP 0x0x8d4e494a;
8d4e4814:	97 ba       	[FP -0x5c] = R7;
8d4e4816:	b7 e6 54 00 	B[SP + 0x54] = R7;
8d4e481a:	03 c8 00 18 	MNOP || R0 = [FP -0x74] || [FP -0x58] = R6;
8d4e481e:	30 b8 a6 ba 
8d4e4822:	05 0a       	CC = R5 <= R0 (IU);
8d4e4824:	8f 18       	IF CC JUMP 0x0x8d4e4942;
8d4e4826:	03 c8 00 18 	MNOP || R0 = [FP + 0x8] || [FP -0x74] = R6;
8d4e482a:	b8 a0 36 ba 
8d4e482e:	00 0c       	CC = R0 == 0x0;
8d4e4830:	03 c8 00 18 	MNOP || [FP -0x78] = R7 || R2 = [SP + 0x2c];
8d4e4834:	27 ba f2 a2 
8d4e4838:	b7 e6 38 00 	B[SP + 0x38] = R7;
8d4e483c:	5f 30       	R3 = FP;
8d4e483e:	4f 18       	IF CC JUMP 0x0x8d4e48dc;
8d4e4840:	23 67       	R3 += -0x1c;		/* (-28) */
8d4e4842:	03 c8 00 18 	MNOP || [FP + 0x8] = R3 || R2 = [SP + 0x2c];
8d4e4846:	bb b0 f2 a2 
8d4e484a:	31 a3       	R1 = [SP + 0x30];
8d4e484c:	b8 a0       	R0 = [FP + 0x8];
8d4e484e:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e4852:	94 f1 00 00 
8d4e4856:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || R1 = [FP + 0x8];
8d4e485a:	b8 a0 b9 a0 
8d4e485e:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e4860:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e4864:	94 f1 00 00 
8d4e4868:	47 30       	R0 = FP;
8d4e486a:	40 66       	R0 += -0x38;		/* (-56) */
8d4e486c:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || R2 = [SP + 0x28] || NOP;
8d4e4870:	b2 a2 00 00 
8d4e4874:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e4876:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e487a:	94 f1 00 00 
8d4e487e:	24 e1 ac ff 	R4 = -0x54 (X);		/*		R4=0xffffffac(-84) */
8d4e4882:	5f 30       	R3 = FP;
8d4e4884:	04 cc 1c 00 	R0 = R3 + R4 (NS) || R1 = [FP + 0x10] || NOP;
8d4e4888:	39 a1 00 00 
8d4e488c:	ff e3 88 fd 	CALL 0x0x8d4e439c;
8d4e4890:	10 b9       	R0 = [FP -0x3c];
8d4e4892:	05 0a       	CC = R5 <= R0 (IU);
8d4e4894:	20 18       	IF CC JUMP 0x0x8d4e48d4;
8d4e4896:	07 bb       	[FP -0x40] = R7;
8d4e4898:	b7 e6 70 00 	B[SP + 0x70] = R7;
8d4e489c:	03 c8 00 18 	MNOP || R0 = [FP -0x20] || [FP -0x3c] = R6;
8d4e48a0:	80 b9 16 bb 
8d4e48a4:	05 0a       	CC = R5 <= R0 (IU);
8d4e48a6:	13 18       	IF CC JUMP 0x0x8d4e48cc;
8d4e48a8:	77 bb       	[FP -0x24] = R7;
8d4e48aa:	b7 e6 8c 00 	B[SP + 0x8c] = R7;
8d4e48ae:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || [FP -0x20] = R6;
8d4e48b2:	f0 b9 86 bb 
8d4e48b6:	05 0a       	CC = R5 <= R0 (IU);
8d4e48b8:	06 18       	IF CC JUMP 0x0x8d4e48c4;
8d4e48ba:	f6 bb       	[FP -0x4] = R6;
8d4e48bc:	e7 bb       	[FP -0x8] = R7;
8d4e48be:	b7 e6 a8 00 	B[SP + 0xa8] = R7;
8d4e48c2:	48 2f       	JUMP.S 0x0x8d4e4752;
8d4e48c4:	a0 b9       	R0 = [FP -0x18];
8d4e48c6:	ff e3 8f 4d 	CALL 0x0x8d4ce3e4;
8d4e48ca:	f8 2f       	JUMP.S 0x0x8d4e48ba;
8d4e48cc:	30 b9       	R0 = [FP -0x34];
8d4e48ce:	ff e3 8b 4d 	CALL 0x0x8d4ce3e4;
8d4e48d2:	eb 2f       	JUMP.S 0x0x8d4e48a8;
8d4e48d4:	c0 b8       	R0 = [FP -0x50];
8d4e48d6:	ff e3 87 4d 	CALL 0x0x8d4ce3e4;
8d4e48da:	de 2f       	JUMP.S 0x0x8d4e4896;
8d4e48dc:	43 66       	R3 += -0x38;		/* (-56) */
8d4e48de:	bb b0       	[FP + 0x8] = R3;
8d4e48e0:	31 a3       	R1 = [SP + 0x30];
8d4e48e2:	b8 a0       	R0 = [FP + 0x8];
8d4e48e4:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e48e8:	94 f1 00 00 
8d4e48ec:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || R1 = [FP + 0x8];
8d4e48f0:	b8 a0 b9 a0 
8d4e48f4:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e48f6:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e48fa:	94 f1 00 00 
8d4e48fe:	24 e1 ac ff 	R4 = -0x54 (X);		/*		R4=0xffffffac(-84) */
8d4e4902:	5f 30       	R3 = FP;
8d4e4904:	04 cc 1c 00 	R0 = R3 + R4 (NS) || R1 = [FP + 0x10] || NOP;
8d4e4908:	39 a1 00 00 
8d4e490c:	ff e3 fa fe 	CALL 0x0x8d4e4700;
8d4e4910:	10 b9       	R0 = [FP -0x3c];
8d4e4912:	05 0a       	CC = R5 <= R0 (IU);
8d4e4914:	13 18       	IF CC JUMP 0x0x8d4e493a;
8d4e4916:	07 bb       	[FP -0x40] = R7;
8d4e4918:	b7 e6 70 00 	B[SP + 0x70] = R7;
8d4e491c:	03 c8 00 18 	MNOP || R0 = [FP -0x20] || [FP -0x3c] = R6;
8d4e4920:	80 b9 16 bb 
8d4e4924:	05 0a       	CC = R5 <= R0 (IU);
8d4e4926:	06 18       	IF CC JUMP 0x0x8d4e4932;
8d4e4928:	86 bb       	[FP -0x20] = R6;
8d4e492a:	77 bb       	[FP -0x24] = R7;
8d4e492c:	b7 e6 8c 00 	B[SP + 0x8c] = R7;
8d4e4930:	11 2f       	JUMP.S 0x0x8d4e4752;
8d4e4932:	30 b9       	R0 = [FP -0x34];
8d4e4934:	ff e3 58 4d 	CALL 0x0x8d4ce3e4;
8d4e4938:	f8 2f       	JUMP.S 0x0x8d4e4928;
8d4e493a:	c0 b8       	R0 = [FP -0x50];
8d4e493c:	ff e3 54 4d 	CALL 0x0x8d4ce3e4;
8d4e4940:	eb 2f       	JUMP.S 0x0x8d4e4916;
8d4e4942:	b0 a3       	R0 = [SP + 0x38];
8d4e4944:	ff e3 50 4d 	CALL 0x0x8d4ce3e4;
8d4e4948:	6f 2f       	JUMP.S 0x0x8d4e4826;
8d4e494a:	50 b8       	R0 = [FP -0x6c];
8d4e494c:	ff e3 4c 4d 	CALL 0x0x8d4ce3e4;
8d4e4950:	62 2f       	JUMP.S 0x0x8d4e4814;
8d4e4952:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e4954:	5c 2f       	JUMP.S 0x0x8d4e480c;
8d4e4956:	41 60       	R1 = 0x8 (X);		/*		R1=0x4c( 76) */
8d4e4958:	08 08       	CC = R0 == R1;
8d4e495a:	fc 16       	IF !CC JUMP 0x0x8d4e4752 (BP);
8d4e495c:	5e 30       	R3 = SP;
8d4e495e:	21 e1 50 00 	R1 = 0x50 (X);		/*		R1=0x50( 80) */
8d4e4962:	04 cc 19 06 	R3 = R3 + R1 (NS) || R2 = [SP + 0x2c] || R1 = [SP + 0x30];
8d4e4966:	f2 a2 31 a3 
8d4e496a:	bb b0       	[FP + 0x8] = R3;
8d4e496c:	b8 a0       	R0 = [FP + 0x8];
8d4e496e:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e4972:	94 f1 00 00 
8d4e4976:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || R1 = [FP + 0x8];
8d4e497a:	b8 a0 b9 a0 
8d4e497e:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e4980:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e4984:	94 f1 00 00 
8d4e4988:	a4 61       	R4 = 0x34 (X);		/*		R4=0xffffffac(-84) */
8d4e498a:	5e 30       	R3 = SP;
8d4e498c:	04 cc 1c 00 	R0 = R3 + R4 (NS) || R1 = [FP + 0x10] || NOP;
8d4e4990:	39 a1 00 00 
8d4e4994:	ff e3 04 fd 	CALL 0x0x8d4e439c;
8d4e4998:	30 b8       	R0 = [FP -0x74];
8d4e499a:	05 0a       	CC = R5 <= R0 (IU);
8d4e499c:	13 18       	IF CC JUMP 0x0x8d4e49c2;
8d4e499e:	27 ba       	[FP -0x78] = R7;
8d4e49a0:	b7 e6 38 00 	B[SP + 0x38] = R7;
8d4e49a4:	03 c8 00 18 	MNOP || R0 = [FP -0x58] || [FP -0x74] = R6;
8d4e49a8:	a0 b8 36 ba 
8d4e49ac:	05 0a       	CC = R5 <= R0 (IU);
8d4e49ae:	06 18       	IF CC JUMP 0x0x8d4e49ba;
8d4e49b0:	a6 ba       	[FP -0x58] = R6;
8d4e49b2:	97 ba       	[FP -0x5c] = R7;
8d4e49b4:	b7 e6 54 00 	B[SP + 0x54] = R7;
8d4e49b8:	cd 2e       	JUMP.S 0x0x8d4e4752;
8d4e49ba:	50 b8       	R0 = [FP -0x6c];
8d4e49bc:	ff e3 14 4d 	CALL 0x0x8d4ce3e4;
8d4e49c0:	f8 2f       	JUMP.S 0x0x8d4e49b0;
8d4e49c2:	b0 a3       	R0 = [SP + 0x38];
8d4e49c4:	ff e3 10 4d 	CALL 0x0x8d4ce3e4;
8d4e49c8:	eb 2f       	JUMP.S 0x0x8d4e499e;
8d4e49ca:	f8 a0       	R0 = [FP + 0xc];
8d4e49cc:	00 de 0b 8c 	CALL.A 0x8c0ba942;
8d4e49d0:	42 a9 00 00 
8d4e49d4:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e49d6:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e49d8:	01 e8 00 00 	UNLINK;
8d4e49dc:	10 00       	RTS;
8d4e49de:	08 32       	P1 = R0;
8d4e49e0:	00 e8 10 00 	LINK 0x40;		/* (64) */
8d4e49e4:	81 60       	R1 = 0x10 (X);		/*		R1=0x50( 80) */
8d4e49e6:	20 64       	R0 += 0x4;		/* (  4) */
8d4e49e8:	8a a1       	R2 = [P1 + 0x18];
8d4e49ea:	08 32       	P1 = R0;
8d4e49ec:	11 0a       	CC = R1 <= R2 (IU);
8d4e49ee:	02 10       	IF !CC JUMP 0x0x8d4e49f2;
8d4e49f0:	08 91       	R0 = [P1];
8d4e49f2:	4f 30       	R1 = FP;
8d4e49f4:	61 66       	R1 += -0x34;		/* (-52) */
8d4e49f6:	00 de 0b 8c 	CALL.A 0x8c0b9942;
8d4e49fa:	42 99 00 00 
8d4e49fe:	00 0c       	CC = R0 == 0x0;
8d4e4a00:	06 18       	IF CC JUMP 0x0x8d4e4a0c;
8d4e4a02:	01 e8 00 00 	UNLINK;
8d4e4a06:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4e4a08:	10 00       	RTS;
8d4e4a0a:	00 00       	NOP;
8d4e4a0c:	00 de ed 8f 	CALL.A 0x8fed34c4;
8d4e4a10:	c4 34 00 00 
8d4e4a14:	b1 a3       	R1 = [SP + 0x38];
8d4e4a16:	01 e8 00 00 	UNLINK;
8d4e4a1a:	08 52       	R0 = R0 - R1;
8d4e4a1c:	01 da 09 00 	R1=604800;
8d4e4a20:	80 3a 00 00 
8d4e4a24:	01 0a       	CC = R1 <= R0 (IU);
8d4e4a26:	00 02       	R0 = CC;
8d4e4a28:	10 00       	RTS;
8d4e4a2a:	0a 32       	P1 = R2;
8d4e4a2c:	00 e8 32 00 	LINK 0xc8;		/* (200) */
8d4e4a30:	e3 05       	[--SP] = (R7:4, P5:3);
8d4e4a32:	66 6f       	SP += -0x14;		/* (-20) */
8d4e4a34:	85 60       	R5 = 0x10 (X);		/*		R5=0x7c(124) */
8d4e4a36:	03 c8 00 18 	MNOP || P0 = [FP + 0x14] || R3 = [P1 + 0x18];
8d4e4a3a:	78 ad 8b a1 
8d4e4a3e:	1d 0a       	CC = R5 <= R3 (IU);
8d4e4a40:	d2 bb       	[FP -0xc] = R2;
8d4e4a42:	f1 bb       	[FP -0x4] = R1;
8d4e4a44:	38 b1       	[FP + 0x10] = R0;
8d4e4a46:	b8 bb       	[FP -0x14] = P0;
8d4e4a48:	22 64       	R2 += 0x4;		/* (  4) */
8d4e4a4a:	03 10       	IF !CC JUMP 0x0x8d4e4a50;
8d4e4a4c:	0a 32       	P1 = R2;
8d4e4a4e:	0a 91       	R2 = [P1];
8d4e4a50:	02 30       	R0 = R2;
8d4e4a52:	00 de 0b 8c 	CALL.A 0x8c0ba6da;
8d4e4a56:	da a6 00 00 
8d4e4a5a:	00 0c       	CC = R0 == 0x0;
8d4e4a5c:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [FP + 0xc] = R0 || NOP;
8d4e4a60:	f8 b0 00 00 
8d4e4a64:	8e 19       	IF CC JUMP 0x0x8d4e4d80;
8d4e4a66:	00 da 03 84 	R0=-2080149236;
8d4e4a6a:	0c 71 00 00 
8d4e4a6e:	01 da 03 84 	R1=-2080149236;
8d4e4a72:	0c 71 00 00 
8d4e4a76:	a0 64       	R0 += 0x14;		/* ( 20) */
8d4e4a78:	c1 64       	R1 += 0x18;		/* ( 24) */
8d4e4a7a:	e0 bb       	[FP -0x8] = R0;
8d4e4a7c:	c1 bb       	[FP -0x10] = R1;
8d4e4a7e:	7e 60       	R6 = 0xf (X);		/*		R6=0x0(  0) */
8d4e4a80:	2d e1 50 00 	P5 = 0x50 (X);		/*		P5=0x50( 80) */
