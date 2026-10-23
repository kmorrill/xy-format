
os.ldr@0x8d581abc:     file format binary


Disassembly of section .data:

8d581abc <.data>:
8d581abc:	00 e8 01 00 	LINK 0x4;		/* (4) */
8d581ac0:	e3 05       	[--SP] = (R7:4, P5:3);
8d581ac2:	46 6f       	SP += -0x18;		/* (-24) */
8d581ac4:	82 ce 02 c8 	R4 = ROT R2 BY 0x0 || P4 = [FP + 0x18] || [FP + 0x8] = R1;
8d581ac8:	bc ad b9 b0 
8d581acc:	03 c8 00 18 	MNOP || P5 = [FP + 0x14] || [FP + 0x10] = R0;
8d581ad0:	7d ad 38 b1 
8d581ad4:	18 32       	P3 = R0;
8d581ad6:	03 c8 00 18 	MNOP || R5 = [P4 + 0x8] || R3 = [P4 + 0x14];
8d581ada:	a5 a0 63 a1 
8d581ade:	05 0c       	CC = R5 == 0x0;
8d581ae0:	16 02       	ILLEGAL;
8d581ae2:	04 ce 37 8e 	R7 = PACK (R7.H, R6.L) || [P4 + 0x14] = R2 || NOP;
8d581ae6:	62 b1 00 00 
8d581aea:	fb b0       	[FP + 0xc] = R3;
8d581aec:	08 10       	IF !CC JUMP 0x0x8d581afc;
8d581aee:	03 c8 00 18 	MNOP || R3 = [P4] || R2 = [P4 + 0x4];
8d581af2:	23 91 62 a0 
8d581af6:	13 56       	R0 = R3 | R2;
8d581af8:	00 0c       	CC = R0 == 0x0;
8d581afa:	9b 10       	IF !CC JUMP 0x0x8d581c30;
8d581afc:	f8 a1       	R0 = [FP + 0x1c];
8d581afe:	00 0c       	CC = R0 == 0x0;
8d581b00:	24 18       	IF CC JUMP 0x0x8d581b48;
8d581b02:	a0 e4 18 00 	R0 = B[P4 + 0x18] (Z);
8d581b06:	00 0c       	CC = R0 == 0x0;
8d581b08:	20 10       	IF !CC JUMP 0x0x8d581b48;
8d581b0a:	a0 a0       	R0 = [P4 + 0x8];
8d581b0c:	00 0c       	CC = R0 == 0x0;
8d581b0e:	1d 18       	IF CC JUMP 0x0x8d581b48;
8d581b10:	98 e4 30 3e 	R0 = B[P3 + 0x3e30] (Z);
8d581b14:	00 0c       	CC = R0 == 0x0;
8d581b16:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d581b18:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d581b1a:	05 10       	IF !CC JUMP 0x0x8d581b24;
8d581b1c:	98 e4 2f 3e 	R0 = B[P3 + 0x3e2f] (Z);
8d581b20:	00 0c       	CC = R0 == 0x0;
8d581b22:	10 02       	ILLEGAL;
8d581b24:	00 0c       	CC = R0 == 0x0;
8d581b26:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d581b28:	0c 18       	IF CC JUMP 0x0x8d581b40;
8d581b2a:	98 e4 2d 3e 	R0 = B[P3 + 0x3e2d] (Z);
8d581b2e:	00 0c       	CC = R0 == 0x0;
8d581b30:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d581b32:	05 10       	IF !CC JUMP 0x0x8d581b3c;
8d581b34:	98 e4 2e 3e 	R0 = B[P3 + 0x3e2e] (Z);
8d581b38:	00 0c       	CC = R0 == 0x0;
8d581b3a:	10 02       	ILLEGAL;
8d581b3c:	00 0c       	CC = R0 == 0x0;
8d581b3e:	10 02       	ILLEGAL;
8d581b40:	00 0c       	CC = R0 == 0x0;
8d581b42:	03 18       	IF CC JUMP 0x0x8d581b48;
8d581b44:	a1 e6 18 00 	B[P4 + 0x18] = R1;
8d581b48:	a0 e4 18 00 	R0 = B[P4 + 0x18] (Z);
8d581b4c:	00 0c       	CC = R0 == 0x0;
8d581b4e:	11 18       	IF CC JUMP 0x0x8d581b70;
8d581b50:	78 43       	R0 = R7.B (Z);
8d581b52:	00 0c       	CC = R0 == 0x0;
8d581b54:	0b 18       	IF CC JUMP 0x0x8d581b6a;
8d581b56:	03 c8 00 18 	MNOP || R0 = [P4] || R1 = [P4 + 0x4];
8d581b5a:	20 91 61 a0 
8d581b5e:	08 56       	R0 = R0 | R1;
8d581b60:	00 0c       	CC = R0 == 0x0;
8d581b62:	4f 10       	IF !CC JUMP 0x0x8d581c00;
8d581b64:	f8 a0       	R0 = [FP + 0xc];
8d581b66:	84 08       	CC = R4 < R0;
8d581b68:	4c 10       	IF !CC JUMP 0x0x8d581c00;
8d581b6a:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d581b6c:	a0 e6 18 00 	B[P4 + 0x18] = R0;
8d581b70:	78 43       	R0 = R7.B (Z);
8d581b72:	00 0c       	CC = R0 == 0x0;
8d581b74:	3a 10       	IF !CC JUMP 0x0x8d581be8;
8d581b76:	28 e4 80 00 	R0 = [P5 + 0x200];
8d581b7a:	00 0c       	CC = R0 == 0x0;
8d581b7c:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || R0 = [FP + 0x8] || NOP;
8d581b80:	b8 a0 00 00 
8d581b84:	26 18       	IF CC JUMP 0x0x8d581bd0;
8d581b86:	ff e3 7d 71 	CALL 0x0x8d56fe80;
8d581b8a:	00 0c       	CC = R0 == 0x0;
8d581b8c:	22 10       	IF !CC JUMP 0x0x8d581bd0;
8d581b8e:	28 95       	R0 = W[P5] (Z);
8d581b90:	20 09       	CC = R0 <= R4;
8d581b92:	1f 10       	IF !CC JUMP 0x0x8d581bd0;
8d581b94:	29 e5 80 00 	P1 = [P5 + 0x200];
8d581b98:	4d 5e       	P1 = P5 + (P1 << 0x2);
8d581b9a:	41 32       	P0 = P1;
8d581b9c:	e1 6f       	P1 += -0x4;		/* ( -4) */
8d581b9e:	08 95       	R0 = W[P1] (Z);
8d581ba0:	84 08       	CC = R4 < R0;
8d581ba2:	0b 10       	IF !CC JUMP 0x0x8d581bb8;
8d581ba4:	c0 6f       	P0 += -0x8;		/* ( -8) */
8d581ba6:	48 32       	P1 = P0;
8d581ba8:	e0 6b       	P0 = -0x4 (X);		/*		P0=0x0(  0) */
8d581baa:	c0 e0 04 00 	LSETUP_IMM(bottom=0x8d581bb2) LC0 count_fields=0x0/0x0;
8d581bae:	01 86       	R0 = W[P1 ++ P0] (Z);
8d581bb0:	84 08       	CC = R4 < R0;
8d581bb2:	02 10       	IF !CC JUMP 0x0x8d581bb6;
8d581bb4:	fb 2f       	JUMP.S 0x0x8d581baa;
8d581bb6:	21 6c       	P1 += 0x4;		/* (  4) */
8d581bb8:	03 c8 00 18 	MNOP || R0 = [P4 + 0x10] || R7 = W[P1 + 0x2] (X);
8d581bbc:	20 a1 4f a8 
8d581bc0:	27 b1       	[P4 + 0x10] = R7;
8d581bc2:	c6 6c       	SP += 0x18;		/* ( 24) */
8d581bc4:	07 08       	CC = R7 == R0;
8d581bc6:	a3 05       	(R7:4, P5:3) = [SP++];
8d581bc8:	01 e8 00 00 	UNLINK;
8d581bcc:	10 02       	ILLEGAL;
8d581bce:	10 00       	RTS;
8d581bd0:	20 a1       	R0 = [P4 + 0x10];
8d581bd2:	27 b1       	[P4 + 0x10] = R7;
8d581bd4:	c6 6c       	SP += 0x18;		/* ( 24) */
8d581bd6:	07 08       	CC = R7 == R0;
8d581bd8:	a3 05       	(R7:4, P5:3) = [SP++];
8d581bda:	01 e8 00 00 	UNLINK;
8d581bde:	10 02       	ILLEGAL;
8d581be0:	10 00       	RTS;
8d581be2:	00 00       	NOP;
8d581be4:	00 00       	NOP;
8d581be6:	00 00       	NOP;
8d581be8:	03 c8 00 18 	MNOP || R7 = [P4 + 0x8] || R0 = [P4 + 0x10];
8d581bec:	a7 a0 20 a1 
8d581bf0:	27 b1       	[P4 + 0x10] = R7;
8d581bf2:	c6 6c       	SP += 0x18;		/* ( 24) */
8d581bf4:	38 08       	CC = R0 == R7;
8d581bf6:	a3 05       	(R7:4, P5:3) = [SP++];
8d581bf8:	01 e8 00 00 	UNLINK;
8d581bfc:	10 02       	ILLEGAL;
8d581bfe:	10 00       	RTS;
8d581c00:	03 c8 00 18 	MNOP || R0 = [FP + 0x1c] || R3 = [FP + 0xc];
8d581c04:	f8 a1 fb a0 
8d581c08:	00 0c       	CC = R0 == 0x0;
8d581c0a:	fd 63       	R5 = -0x1 (X);		/*		R5=0x0(  0) */
8d581c0c:	1d 06       	IF !CC R3 = R5;
8d581c0e:	03 c8 00 18 	MNOP || R6 = [P4 + 0x8] || [SP + 0xc] = R4;
8d581c12:	a6 a0 f4 b0 
8d581c16:	03 c8 00 18 	MNOP || [SP + 0x14] = R3 || R1 = [FP + 0x8];
8d581c1a:	73 b1 b9 a0 
8d581c1e:	03 c8 00 18 	MNOP || [SP + 0x10] = R6 || R0 = [FP + 0x10];
8d581c22:	36 b1 38 a1 
8d581c26:	55 30       	R2 = P5;
8d581c28:	ff e3 14 ff 	CALL 0x0x8d581a50;
8d581c2c:	a2 2f       	JUMP.S 0x0x8d581b70;
8d581c2e:	00 00       	NOP;
8d581c30:	1f e4 7f 24 	R7 = [P3 + 0x91fc];
8d581c34:	bb 09       	CC = R3 < R7 (IU);
8d581c36:	19 e4 80 24 	R1 = [P3 + 0x9200];
8d581c3a:	86 03       	AQ = CC;
8d581c3c:	0a 08       	CC = R2 == R1;
8d581c3e:	c6 03       	AQ &= CC;
8d581c40:	8a 09       	CC = R2 < R1 (IU);
8d581c42:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d581c44:	26 03       	CC |= AQ;
8d581c46:	70 b3       	[SP + 0x34] = R0;
8d581c48:	05 10       	IF !CC JUMP 0x0x8d581c52;
8d581c4a:	1f 52       	R0 = R7 - R3;
8d581c4c:	19 c4       	ILLEGAL;
8d581c4e:	0a 42       	DIVQ (R2, R1);
8d581c50:	71 b3       	[SP + 0x34] = R1;
8d581c52:	22 e1 e8 03 	R2 = 0x3e8 (X);		/*		R2=0x3e8(1000) */
8d581c56:	03 60       	R3 = 0x0 (X);		/*		R3=0x0(  0) */
8d581c58:	71 a3       	R1 = [SP + 0x34];
8d581c5a:	00 de 02 04 	CALL.A 0x04020c02;
8d581c5e:	02 0c 00 00 
8d581c62:	22 e1 4d 01 	R2 = 0x14d (X);		/*		R2=0x14d(333) */
8d581c66:	90 09       	CC = R0 < R2 (IU);
8d581c68:	86 03       	AQ = CC;
8d581c6a:	29 08       	CC = R1 == R5;
8d581c6c:	c6 03       	AQ &= CC;
8d581c6e:	a9 09       	CC = R1 < R5 (IU);
8d581c70:	26 03       	CC |= AQ;
8d581c72:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8d581c74:	44 1b       	IF CC JUMP 0x0x8d581afc;
8d581c76:	04 ce 37 8e 	R7 = PACK (R7.H, R6.L) || [P4] = R5 || NOP;
8d581c7a:	25 93 00 00 
8d581c7e:	65 b0       	[P4 + 0x4] = R5;
8d581c80:	3e 2f       	JUMP.S 0x0x8d581afc;
8d581c82:	00 00       	NOP;
8d581c84:	00 00       	NOP;
8d581c86:	00 00       	NOP;
8d581c88:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d581c8c:	fc 05       	[--SP] = (R7:7, P5:4);
8d581c8e:	20 32       	P4 = R0;
8d581c90:	a6 6f       	SP += -0xc;		/* (-12) */
8d581c92:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d581c94:	20 e4 20 00 	R0 = [P4 + 0x80];
8d581c98:	00 0c       	CC = R0 == 0x0;
8d581c9a:	08 32       	P1 = R0;
8d581c9c:	2f 18       	IF CC JUMP 0x0x8d581cfa;
8d581c9e:	4c 5e       	P1 = P4 + (P1 << 0x2);
8d581ca0:	4c 08       	CC = P4 == P1;
8d581ca2:	2c 18       	IF CC JUMP 0x0x8d581cfa;
8d581ca4:	6c 32       	P5 = P4;
8d581ca6:	68 a8       	R0 = W[P5 + 0x2] (X);
8d581ca8:	07 08       	CC = R7 == R0;
8d581caa:	38 10       	IF !CC JUMP 0x0x8d581d1a;
8d581cac:	6c 0a       	CC = P4 <= P5 (IU);
8d581cae:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d581cb0:	06 10       	IF !CC JUMP 0x0x8d581cbc;
8d581cb2:	21 e5 20 00 	P1 = [P4 + 0x80];
8d581cb6:	4c 5e       	P1 = P4 + (P1 << 0x2);
8d581cb8:	cd 09       	CC = P5 < P1 (IU);
8d581cba:	00 02       	R0 = CC;
8d581cbc:	00 0c       	CC = R0 == 0x0;
8d581cbe:	25 18       	IF CC JUMP 0x0x8d581d08;
8d581cc0:	21 e5 20 00 	P1 = [P4 + 0x80];
8d581cc4:	4c 5e       	P1 = P4 + (P1 << 0x2);
8d581cc6:	e1 6f       	P1 += -0x4;		/* ( -4) */
8d581cc8:	cd 09       	CC = P5 < P1 (IU);
8d581cca:	0f 10       	IF !CC JUMP 0x0x8d581ce8;
8d581ccc:	4d 32       	P1 = P5;
8d581cce:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d581ce4) LC0 count_fields=0x0/0x0;
8d581cd2:	48 a0       	R0 = [P1 + 0x4];
8d581cd4:	08 96       	W[P1++] = R0;
8d581cd6:	88 a4       	R0 = W[P1 + 0x4] (Z);
8d581cd8:	08 96       	W[P1++] = R0;
8d581cda:	20 e5 20 00 	P0 = [P4 + 0x80];
8d581cde:	04 5e       	P0 = P4 + (P0 << 0x2);
8d581ce0:	e0 6f       	P0 += -0x4;		/* ( -4) */
8d581ce2:	c1 09       	CC = P1 < P0 (IU);
8d581ce4:	02 10       	IF !CC JUMP 0x0x8d581ce8;
8d581ce6:	f4 2f       	JUMP.S 0x0x8d581cce;
8d581ce8:	20 e4 20 00 	R0 = [P4 + 0x80];
8d581cec:	f8 67       	R0 += -0x1;		/* ( -1) */
8d581cee:	08 32       	P1 = R0;
8d581cf0:	20 e6 20 00 	[P4 + 0x80] = R0;
8d581cf4:	4c 5e       	P1 = P4 + (P1 << 0x2);
8d581cf6:	4d 08       	CC = P5 == P1;
8d581cf8:	d7 17       	IF !CC JUMP 0x0x8d581ca6 (BP);
8d581cfa:	66 6c       	SP += 0xc;		/* ( 12) */
