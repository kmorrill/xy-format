
os.ldr@0x8c0b0b00:     file format binary


Disassembly of section .data:

8c0b0b00 <.data>:
8c0b0b00:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c0b0b04:	e5 05       	[--SP] = (R7:4, P5:5);
8c0b0b06:	28 30       	R5 = R0;
8c0b0b08:	2d 32       	P5 = R5;
8c0b0b0a:	a6 6f       	SP += -0xc;		/* (-12) */
8c0b0b0c:	84 60       	R4 = 0x10 (X);		/*		R4=0x0(  0) */
8c0b0b0e:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8c0b0b10:	7e 60       	R6 = 0xf (X);		/*		R6=0x0(  0) */
8c0b0b12:	28 e4 5f 00 	R0 = [P5 + 0x17c];
8c0b0b16:	04 0a       	CC = R4 <= R0 (IU);
8c0b0b18:	44 18       	IF CC JUMP 0x0x8c0b0ba0;
8c0b0b1a:	2f e6 5e 00 	[P5 + 0x178] = R7;
8c0b0b1e:	af e6 68 01 	B[P5 + 0x168] = R7;
8c0b0b22:	28 e4 58 00 	R0 = [P5 + 0x160];
8c0b0b26:	04 0a       	CC = R4 <= R0 (IU);
8c0b0b28:	2e e6 5f 00 	[P5 + 0x17c] = R6;
8c0b0b2c:	32 18       	IF CC JUMP 0x0x8c0b0b90;
8c0b0b2e:	2e e6 58 00 	[P5 + 0x160] = R6;
8c0b0b32:	2f e6 57 00 	[P5 + 0x15c] = R7;
8c0b0b36:	af e6 4c 01 	B[P5 + 0x14c] = R7;
8c0b0b3a:	28 e4 51 00 	R0 = [P5 + 0x144];
8c0b0b3e:	04 0a       	CC = R4 <= R0 (IU);
8c0b0b40:	20 18       	IF CC JUMP 0x0x8c0b0b80;
8c0b0b42:	2e e6 51 00 	[P5 + 0x144] = R6;
8c0b0b46:	2f e6 50 00 	[P5 + 0x140] = R7;
8c0b0b4a:	af e6 30 01 	B[P5 + 0x130] = R7;
8c0b0b4e:	e8 a2       	R0 = [P5 + 0x2c];
8c0b0b50:	04 0a       	CC = R4 <= R0 (IU);
8c0b0b52:	10 18       	IF CC JUMP 0x0x8c0b0b72;
8c0b0b54:	45 64       	R5 += 0x8;		/* (  8) */
8c0b0b56:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [P5 + 0x2c] = R6 || NOP;
8c0b0b5a:	ee b2 00 00 
8c0b0b5e:	af b2       	[P5 + 0x28] = R7;
8c0b0b60:	af e6 18 00 	B[P5 + 0x18] = R7;
8c0b0b64:	fd e3 6a 07 	CALL 0x0x8c051a38;
8c0b0b68:	66 6c       	SP += 0xc;		/* ( 12) */
8c0b0b6a:	a5 05       	(R7:4, P5:5) = [SP++];
8c0b0b6c:	01 e8 00 00 	UNLINK;
8c0b0b70:	10 00       	RTS;
8c0b0b72:	a8 a1       	R0 = [P5 + 0x18];
8c0b0b74:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b0b78:	e4 e3 00 00 
8c0b0b7c:	ec 2f       	JUMP.S 0x0x8c0b0b54;
8c0b0b7e:	00 00       	NOP;
8c0b0b80:	28 e4 4c 00 	R0 = [P5 + 0x130];
8c0b0b84:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b0b88:	e4 e3 00 00 
8c0b0b8c:	db 2f       	JUMP.S 0x0x8c0b0b42;
8c0b0b8e:	00 00       	NOP;
8c0b0b90:	28 e4 53 00 	R0 = [P5 + 0x14c];
8c0b0b94:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b0b98:	e4 e3 00 00 
8c0b0b9c:	c9 2f       	JUMP.S 0x0x8c0b0b2e;
8c0b0b9e:	00 00       	NOP;
8c0b0ba0:	28 e4 5a 00 	R0 = [P5 + 0x168];
8c0b0ba4:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b0ba8:	e4 e3 00 00 
8c0b0bac:	b7 2f       	JUMP.S 0x0x8c0b0b1a;
8c0b0bae:	00 00       	NOP;
8c0b0bb0:	00 e8 0b 00 	LINK 0x2c;		/* (44) */
8c0b0bb4:	e4 05       	[--SP] = (R7:4, P5:4);
8c0b0bb6:	46 6f       	SP += -0x18;		/* (-24) */
8c0b0bb8:	28 32       	P5 = R0;
8c0b0bba:	04 cc 36 4c 	R6 = R6 - R6 (NS) || [FP + 0x8] = R0 || NOP;
8c0b0bbe:	b8 b0 00 00 
8c0b0bc2:	00 de 5a 8d 	CALL.A 0x8d5a880c;
8c0b0bc6:	0c 88 00 00 
8c0b0bca:	08 32       	P1 = R0;
8c0b0bcc:	20 e1 6c 07 	R0 = 0x76c (X);		/*		R0=0x76c(1900) */
8c0b0bd0:	7f 30       	R7 = FP;
8c0b0bd2:	a7 66       	R7 += -0x2c;		/* (-44) */
8c0b0bd4:	02 da 00 84 	R2=-2080331312;
8c0b0bd8:	d0 a9 00 00 
8c0b0bdc:	03 c8 00 18 	MNOP || R3 = [P1 + 0x14] || R4 = [P1 + 0x10];
8c0b0be0:	4b a1 0c a1 
8c0b0be4:	04 cc 18 00 	R0 = R3 + R0 (NS) || R3 = [P1 + 0xc] || NOP;
8c0b0be8:	cb a0 00 00 
8c0b0bec:	0c 64       	R4 += 0x1;		/* (  1) */
8c0b0bee:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R0 || NOP;
8c0b0bf2:	f0 b0 00 00 
8c0b0bf6:	34 b1       	[SP + 0x10] = R4;
8c0b0bf8:	73 b1       	[SP + 0x14] = R3;
8c0b0bfa:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8c0b0bfc:	fc e3 d6 c6 	CALL 0x0x8c0499a8;
8c0b0c00:	0c da 00 84 	P4=-2080331312;
8c0b0c04:	d0 a9 00 00 
8c0b0c08:	78 60       	R0 = 0xf (X);		/*		R0=0x76c(1900) */
8c0b0c0a:	6e b1       	[P5 + 0x14] = R6;
8c0b0c0c:	ae e6 04 00 	B[P5 + 0x4] = R6;
8c0b0c10:	a8 b1       	[P5 + 0x18] = R0;
8c0b0c12:	84 6c       	P4 += 0x10;		/* ( 16) */
8c0b0c14:	0d 60       	R5 = 0x1 (X);		/*		R5=0x0(  0) */
8c0b0c16:	24 e1 63 00 	R4 = 0x63 (X);		/*		R4=0x63( 99) */
8c0b0c1a:	35 b1       	[SP + 0x10] = R5;
8c0b0c1c:	f7 b0       	[SP + 0xc] = R7;
8c0b0c1e:	82 ce 05 cc 	R6 = ROT R5 BY 0x0 || [SP + 0x14] = P4 || NOP;
8c0b0c22:	74 bd 00 00 
8c0b0c26:	0d 64       	R5 += 0x1;		/* (  1) */
8c0b0c28:	02 da 00 84 	R2=-2080331240;
8c0b0c2c:	18 aa 00 00 
8c0b0c30:	21 e1 00 01 	R1 = 0x100 (X);		/*		R1=0x100(256) */
8c0b0c34:	00 da 01 08 	R0=134336064;
8c0b0c38:	40 ce 00 00 
8c0b0c3c:	fc e3 b6 c6 	CALL 0x0x8c0499a8;
8c0b0c40:	00 da 01 08 	R0=134336064;
8c0b0c44:	40 ce 00 00 
8c0b0c48:	fc e3 70 6b 	CALL 0x0x8c03e328;
8c0b0c4c:	00 0c       	CC = R0 == 0x0;
8c0b0c4e:	24 18       	IF CC JUMP 0x0x8c0b0c96;
8c0b0c50:	26 08       	CC = R6 == R4;
8c0b0c52:	e4 17       	IF !CC JUMP 0x0x8c0b0c1a (BP);
8c0b0c54:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c0b0c58:	fc 1e 00 00 
8c0b0c5c:	88 0c       	CC = R0 < 0x1;
8c0b0c5e:	09 10       	IF !CC JUMP 0x0x8c0b0c70;
8c0b0c60:	c6 6c       	SP += 0x18;		/* ( 24) */
8c0b0c62:	a4 05       	(R7:4, P5:4) = [SP++];
8c0b0c64:	01 e8 00 00 	UNLINK;
8c0b0c68:	10 00       	RTS;
8c0b0c6a:	00 00       	NOP;
8c0b0c6c:	00 00       	NOP;
8c0b0c6e:	00 00       	NOP;
8c0b0c70:	09 da 00 84 	P1=-2080331164;
8c0b0c74:	64 aa 00 00 
8c0b0c78:	f1 bc       	[SP + 0xc] = P1;
8c0b0c7a:	22 e1 46 00 	R2 = 0x46 (X);		/*		R2=0x46( 70) */
8c0b0c7e:	01 da 00 84 	R1=-2080331204;
8c0b0c82:	3c aa 00 00 
8c0b0c86:	08 60       	R0 = 0x1 (X);		/*		R0=0x76c(1900) */
8c0b0c88:	fc e3 76 7c 	CALL 0x0x8c040574;
8c0b0c8c:	c6 6c       	SP += 0x18;		/* ( 24) */
8c0b0c8e:	a4 05       	(R7:4, P5:4) = [SP++];
8c0b0c90:	01 e8 00 00 	UNLINK;
8c0b0c94:	10 00       	RTS;
8c0b0c96:	b8 a0       	R0 = [FP + 0x8];
8c0b0c98:	01 da 01 08 	R1=134336064;
8c0b0c9c:	40 ce 00 00 
8c0b0ca0:	ff e3 6b 4b 	CALL 0x0x8c09a376;
8c0b0ca4:	c6 6c       	SP += 0x18;		/* ( 24) */
8c0b0ca6:	a4 05       	(R7:4, P5:4) = [SP++];
8c0b0ca8:	01 e8 00 00 	UNLINK;
8c0b0cac:	10 00       	RTS;
8c0b0cae:	00 00       	NOP;
8c0b0cb0:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8c0b0cb4:	e5 05       	[--SP] = (R7:4, P5:5);
8c0b0cb6:	28 32       	P5 = R0;
8c0b0cb8:	38 30       	R7 = R0;
8c0b0cba:	86 6f       	SP += -0x10;		/* (-16) */
8c0b0cbc:	01 30       	R0 = R1;
8c0b0cbe:	00 de 57 8d 	CALL.A 0x8d5733a0;
8c0b0cc2:	a0 33 00 00 
8c0b0cc6:	00 0c       	CC = R0 == 0x0;
8c0b0cc8:	08 32       	P1 = R0;
8c0b0cca:	04 18       	IF CC JUMP 0x0x8c0b0cd2;
8c0b0ccc:	49 99       	R1 = B[P1] (X);
8c0b0cce:	01 0c       	CC = R1 == 0x0;
8c0b0cd0:	16 10       	IF !CC JUMP 0x0x8c0b0cfc;
8c0b0cd2:	00 60       	R0 = 0x0 (X);		/*		R0=0x76c(1900) */
8c0b0cd4:	68 b1       	[P5 + 0x14] = R0;
8c0b0cd6:	a8 e6 04 00 	B[P5 + 0x4] = R0;
8c0b0cda:	78 60       	R0 = 0xf (X);		/*		R0=0x76c(1900) */
8c0b0cdc:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P5 + 0x18] = R0 || NOP;
8c0b0ce0:	a8 b1 00 00 
8c0b0ce4:	01 da 00 84 	R1=-2080331288;
8c0b0ce8:	e8 a9 00 00 
8c0b0cec:	ff e3 45 4b 	CALL 0x0x8c09a376;
8c0b0cf0:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b0cf2:	a5 05       	(R7:4, P5:5) = [SP++];
8c0b0cf4:	01 e8 00 00 	UNLINK;
8c0b0cf8:	10 00       	RTS;
8c0b0cfa:	00 00       	NOP;
8c0b0cfc:	00 de 4e 8d 	CALL.A 0x8d4e112a;
8c0b0d00:	2a 11 00 00 
8c0b0d04:	08 30       	R1 = R0;
8c0b0d06:	77 30       	R6 = FP;
8c0b0d08:	26 67       	R6 += -0x1c;		/* (-28) */
8c0b0d0a:	06 30       	R0 = R6;
8c0b0d0c:	00 de 4e 8d 	CALL.A 0x8d4e5d28;
8c0b0d10:	28 5d 00 00 
8c0b0d14:	03 c8 00 18 	MNOP || R4 = [SP + 0x38] || R3 = [SP + 0x3c];
8c0b0d18:	b4 a3 f3 a3 
8c0b0d1c:	04 0c       	CC = R4 == 0x0;
8c0b0d1e:	21 18       	IF CC JUMP 0x0x8c0b0d60;
8c0b0d20:	42 60       	R2 = 0x8 (X);		/*		R2=0x46( 70) */
8c0b0d22:	94 09       	CC = R4 < R2 (IU);
8c0b0d24:	45 60       	R5 = 0x8 (X);		/*		R5=0x0(  0) */
8c0b0d26:	2c 07       	IF CC R5 = R4;
8c0b0d28:	84 60       	R4 = 0x10 (X);		/*		R4=0x63( 99) */
8c0b0d2a:	47 30       	R0 = FP;
8c0b0d2c:	1c 0a       	CC = R4 <= R3 (IU);
8c0b0d2e:	40 67       	R0 += -0x18;		/* (-24) */
8c0b0d30:	b3 a2       	R3 = [SP + 0x28];
8c0b0d32:	03 07       	IF CC R0 = R3;
8c0b0d34:	95 09       	CC = R5 < R2 (IU);
8c0b0d36:	01 da 00 84 	R1=-2080331288;
8c0b0d3a:	e8 a9 00 00 
8c0b0d3e:	15 07       	IF CC R2 = R5;
8c0b0d40:	21 64       	R1 += 0x4;		/* (  4) */
8c0b0d42:	00 de 02 04 	CALL.A 0x04023068;
8c0b0d46:	68 30 00 00 
8c0b0d4a:	00 0c       	CC = R0 == 0x0;
8c0b0d4c:	08 10       	IF !CC JUMP 0x0x8c0b0d5c;
8c0b0d4e:	41 60       	R1 = 0x8 (X);		/*		R1=0x100(256) */
8c0b0d50:	8d 09       	CC = R5 < R1 (IU);
8c0b0d52:	f8 63       	R0 = -0x1 (X);		/*		R0=0x76c(1900) */
8c0b0d54:	04 18       	IF CC JUMP 0x0x8c0b0d5c;
8c0b0d56:	40 60       	R0 = 0x8 (X);		/*		R0=0x76c(1900) */
8c0b0d58:	28 08       	CC = R0 == R5;
8c0b0d5a:	10 02       	ILLEGAL;
8c0b0d5c:	00 0c       	CC = R0 == 0x0;
8c0b0d5e:	29 10       	IF !CC JUMP 0x0x8c0b0db0;
8c0b0d60:	06 60       	R6 = 0x0 (X);		/*		R6=0x0(  0) */
8c0b0d62:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P5 + 0x14] = R6 || NOP;
8c0b0d66:	6e b1 00 00 
8c0b0d6a:	ae e6 04 00 	B[P5 + 0x4] = R6;
8c0b0d6e:	79 60       	R1 = 0xf (X);		/*		R1=0x100(256) */
8c0b0d70:	a9 b1       	[P5 + 0x18] = R1;
8c0b0d72:	01 da 00 84 	R1=-2080331288;
8c0b0d76:	e8 a9 00 00 
8c0b0d7a:	ff e3 fe 4a 	CALL 0x0x8c09a376;
8c0b0d7e:	80 60       	R0 = 0x10 (X);		/*		R0=0x76c(1900) */
8c0b0d80:	f1 a3       	R1 = [SP + 0x3c];
8c0b0d82:	08 0a       	CC = R0 <= R1 (IU);
8c0b0d84:	08 18       	IF CC JUMP 0x0x8c0b0d94;
8c0b0d86:	b6 e6 28 00 	B[SP + 0x28] = R6;
8c0b0d8a:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b0d8c:	a5 05       	(R7:4, P5:5) = [SP++];
8c0b0d8e:	01 e8 00 00 	UNLINK;
8c0b0d92:	10 00       	RTS;
8c0b0d94:	b0 a2       	R0 = [SP + 0x28];
8c0b0d96:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b0d9a:	e4 e3 00 00 
8c0b0d9e:	b6 e6 28 00 	B[SP + 0x28] = R6;
8c0b0da2:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b0da4:	a5 05       	(R7:4, P5:5) = [SP++];
8c0b0da6:	01 e8 00 00 	UNLINK;
8c0b0daa:	10 00       	RTS;
8c0b0dac:	00 00       	NOP;
8c0b0dae:	00 00       	NOP;
8c0b0db0:	03 c8 00 18 	MNOP || R2 = [SP + 0x3c] || R3 = [SP + 0x28];
8c0b0db4:	f2 a3 b3 a2 
8c0b0db8:	47 30       	R0 = FP;
8c0b0dba:	14 0a       	CC = R4 <= R2 (IU);
8c0b0dbc:	40 67       	R0 += -0x18;		/* (-24) */
8c0b0dbe:	01 da 00 84 	R1=-2080331288;
8c0b0dc2:	e8 a9 00 00 
8c0b0dc6:	03 07       	IF CC R0 = R3;
8c0b0dc8:	81 64       	R1 += 0x10;		/* ( 16) */
8c0b0dca:	00 de 5a 8d 	CALL.A 0x8d5aea90;
8c0b0dce:	90 ea 00 00 
8c0b0dd2:	00 0c       	CC = R0 == 0x0;
8c0b0dd4:	0f 18       	IF CC JUMP 0x0x8c0b0df2;
8c0b0dd6:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8c0b0dda:	b8 00 02 00 
8c0b0dde:	03 c8 00 18 	MNOP || R1 = [SP + 0x38] || R0 = [SP + 0x38];
8c0b0de2:	b1 a3 b0 a3 
8c0b0de6:	a9 67       	R1 += -0xb;		/* (-11) */
8c0b0de8:	01 0a       	CC = R1 <= R0 (IU);
8c0b0dea:	30 10       	IF !CC JUMP 0x0x8c0b0e4a;
8c0b0dec:	06 30       	R0 = R6;
8c0b0dee:	fc e3 37 6c 	CALL 0x0x8c03e65c;
8c0b0df2:	05 60       	R5 = 0x0 (X);		/*		R5=0x0(  0) */
8c0b0df4:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [P5 + 0x14] = R5 || NOP;
8c0b0df8:	6d b1 00 00 
8c0b0dfc:	ad e6 04 00 	B[P5 + 0x4] = R5;
8c0b0e00:	78 60       	R0 = 0xf (X);		/*		R0=0x76c(1900) */
8c0b0e02:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P5 + 0x18] = R0 || NOP;
8c0b0e06:	a8 b1 00 00 
8c0b0e0a:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8c0b0e0e:	b8 00 02 00 
8c0b0e12:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R2 || NOP;
8c0b0e16:	f2 b0 00 00 
8c0b0e1a:	fc e3 ab 6d 	CALL 0x0x8c03e970;
8c0b0e1e:	f0 a3       	R0 = [SP + 0x3c];
8c0b0e20:	04 0a       	CC = R4 <= R0 (IU);
8c0b0e22:	08 18       	IF CC JUMP 0x0x8c0b0e32;
8c0b0e24:	b5 e6 28 00 	B[SP + 0x28] = R5;
8c0b0e28:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b0e2a:	a5 05       	(R7:4, P5:5) = [SP++];
8c0b0e2c:	01 e8 00 00 	UNLINK;
8c0b0e30:	10 00       	RTS;
8c0b0e32:	b0 a2       	R0 = [SP + 0x28];
8c0b0e34:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b0e38:	e4 e3 00 00 
8c0b0e3c:	b5 e6 28 00 	B[SP + 0x28] = R5;
8c0b0e40:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b0e42:	a5 05       	(R7:4, P5:5) = [SP++];
8c0b0e44:	01 e8 00 00 	UNLINK;
8c0b0e48:	10 00       	RTS;
8c0b0e4a:	02 52       	R0 = R2 - R0;
8c0b0e4c:	a9 63       	R1 = -0xb (X);		/*		R1=0x100(256) */
8c0b0e4e:	08 0a       	CC = R0 <= R1 (IU);
8c0b0e50:	29 18       	IF CC JUMP 0x0x8c0b0ea2;
8c0b0e52:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R5 = [SP + 0x38] || NOP;
8c0b0e56:	b5 a3 00 00 
8c0b0e5a:	ad 67       	R5 += -0xb;		/* (-11) */
8c0b0e5c:	0d 30       	R1 = R5;
8c0b0e5e:	02 60       	R2 = 0x0 (X);		/*		R2=0x46( 70) */
8c0b0e60:	fc e3 70 6c 	CALL 0x0x8c03e740;
8c0b0e64:	00 0c       	CC = R0 == 0x0;
8c0b0e66:	c6 1f       	IF CC JUMP 0x0x8c0b0df2 (BP);
8c0b0e68:	03 c8 00 18 	MNOP || R2 = [SP + 0x3c] || R3 = [SP + 0x28];
8c0b0e6c:	f2 a3 b3 a2 
8c0b0e70:	47 30       	R0 = FP;
8c0b0e72:	14 0a       	CC = R4 <= R2 (IU);
8c0b0e74:	40 67       	R0 += -0x18;		/* (-24) */
8c0b0e76:	b1 a3       	R1 = [SP + 0x38];
8c0b0e78:	03 07       	IF CC R0 = R3;
8c0b0e7a:	08 50       	R0 = R0 + R1;
8c0b0e7c:	aa 63       	R2 = -0xb (X);		/*		R2=0x46( 70) */
8c0b0e7e:	01 60       	R1 = 0x0 (X);		/*		R1=0x100(256) */
8c0b0e80:	00 de 02 04 	CALL.A 0x04022ea8;
8c0b0e84:	a8 2e 00 00 
8c0b0e88:	04 cc 09 42 	R1 = R1 - R1 (NS) || P2 = [SP + 0x28] || R0 = [SP + 0x3c];
8c0b0e8c:	b2 ae f0 a3 
8c0b0e90:	4f 32       	P1 = FP;
8c0b0e92:	04 0a       	CC = R4 <= R0 (IU);
8c0b0e94:	41 6f       	P1 += -0x18;		/* (-24) */
8c0b0e96:	ca 07       	IF CC P1 = P2;
8c0b0e98:	05 32       	P0 = R5;
8c0b0e9a:	b5 b3       	[SP + 0x38] = R5;
8c0b0e9c:	41 5a       	P1 = P1 + P0;
8c0b0e9e:	09 9b       	B[P1] = R1;
8c0b0ea0:	a9 2f       	JUMP.S 0x0x8c0b0df2;
8c0b0ea2:	06 30       	R0 = R6;
8c0b0ea4:	00 de ed 8f 	CALL.A 0x8fed519c;
8c0b0ea8:	9c 51 00 00 
8c0b0eac:	d3 2f       	JUMP.S 0x0x8c0b0e52;
8c0b0eae:	00 00       	NOP;
8c0b0eb0:	00 e8 a1 00 	LINK 0x284;		/* (644) */
8c0b0eb4:	e3 05       	[--SP] = (R7:4, P5:3);
8c0b0eb6:	86 6f       	SP += -0x10;		/* (-16) */
8c0b0eb8:	00 de 4d 8d 	CALL.A 0x8d4db53c;
8c0b0ebc:	3c b5 00 00 
8c0b0ec0:	20 30       	R4 = R0;
8c0b0ec2:	04 0c       	CC = R4 == 0x0;
8c0b0ec4:	02 1c       	IF CC JUMP 0x0x8c0b0ec8 (BP);
8c0b0ec6:	5d 22       	JUMP.S 0x0x8c0b1380;
8c0b0ec8:	b4 e6 68 00 	B[SP + 0x68] = R4;
8c0b0ecc:	34 e6 1e 00 	[SP + 0x78] = R4;
8c0b0ed0:	7d 60       	R5 = 0xf (X);		/*		R5=0x0(  0) */
8c0b0ed2:	35 e6 1f 00 	[SP + 0x7c] = R5;
8c0b0ed6:	0b da 00 84 	P3=-2080331384;
8c0b0eda:	88 a9 00 00 
8c0b0ede:	18 99       	R0 = B[P3] (Z);
8c0b0ee0:	00 0c       	CC = R0 == 0x0;
8c0b0ee2:	03 1c       	IF CC JUMP 0x0x8c0b0ee8 (BP);
8c0b0ee4:	0a 22       	JUMP.S 0x0x8c0b12f8;
8c0b0ee6:	00 00       	NOP;
8c0b0ee8:	00 da 00 84 	R0=-2080331112;
8c0b0eec:	98 aa 00 00 
8c0b0ef0:	fc e3 1c 6a 	CALL 0x0x8c03e328;
8c0b0ef4:	00 0c       	CC = R0 == 0x0;
8c0b0ef6:	02 14       	IF !CC JUMP 0x0x8c0b0efa (BP);
8c0b0ef8:	f8 21       	JUMP.S 0x0x8c0b12e8;
8c0b0efa:	7f 30       	R7 = FP;
8c0b0efc:	27 66       	R7 += -0x3c;		/* (-60) */
8c0b0efe:	07 30       	R0 = R7;
8c0b0f00:	ff e3 58 fe 	CALL 0x0x8c0b0bb0;
8c0b0f04:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8c0b0f08:	b8 00 00 00 
8c0b0f0c:	21 e1 f0 fd 	R1 = -0x210 (X);		/*		R1=0xfffffdf0(-528) */
8c0b0f10:	04 cc 39 00 	R0 = R7 + R1 (NS) || [SP + 0xc] = R0 || NOP;
8c0b0f14:	f0 b0 00 00 
8c0b0f18:	0f 30       	R1 = R7;
8c0b0f1a:	02 60       	R2 = 0x0 (X);		/*		R2=0x46( 70) */
8c0b0f1c:	fc e3 2a 6d 	CALL 0x0x8c03e970;
8c0b0f20:	80 60       	R0 = 0x10 (X);		/*		R0=0x76c(1900) */
8c0b0f22:	71 b9       	R1 = [FP -0x24];
8c0b0f24:	08 0a       	CC = R0 <= R1 (IU);
8c0b0f26:	da 19       	IF CC JUMP 0x0x8c0b12da;
8c0b0f28:	75 bb       	[FP -0x24] = R5;
8c0b0f2a:	64 bb       	[FP -0x28] = R4;
8c0b0f2c:	b4 e6 78 02 	B[SP + 0x278] = R4;
8c0b0f30:	00 de 53 8d 	CALL.A 0x8d5381d4;
8c0b0f34:	d4 81 00 00 
8c0b0f38:	46 30       	R0 = SP;
8c0b0f3a:	23 e1 80 00 	R3 = 0x80 (X);		/*		R3=0x80(128) */
8c0b0f3e:	98 51       	R6 = R0 + R3;
8c0b0f40:	06 30       	R0 = R6;
8c0b0f42:	00 de 4d 8d 	CALL.A 0x8d4db82c;
8c0b0f46:	2c b8 00 00 
8c0b0f4a:	19 e4 ff ff 	R1 = [P3 + -0x4];
8c0b0f4e:	06 30       	R0 = R6;
8c0b0f50:	00 de 4d 8d 	CALL.A 0x8d4dec6c;
8c0b0f54:	6c ec 00 00 
8c0b0f58:	27 e1 64 00 	R7 = 0x64 (X);		/*		R7=0x64(100) */
8c0b0f5c:	56 30       	R2 = SP;
8c0b0f5e:	7a 50       	R1 = R2 + R7;
8c0b0f60:	39 30       	R7 = R1;
8c0b0f62:	e7 64       	R7 += 0x1c;		/* ( 28) */
8c0b0f64:	07 30       	R0 = R7;
8c0b0f66:	00 de 4e 8d 	CALL.A 0x8d4e0a40;
8c0b0f6a:	40 0a 00 00 
8c0b0f6e:	18 99       	R0 = B[P3] (Z);
8c0b0f70:	00 0c       	CC = R0 == 0x0;
8c0b0f72:	a9 11       	IF !CC JUMP 0x0x8c0b12c4;
8c0b0f74:	00 0c       	CC = R0 == 0x0;
8c0b0f76:	9e 19       	IF CC JUMP 0x0x8c0b12b2;
8c0b0f78:	35 e6 87 00 	[SP + 0x21c] = R5;
8c0b0f7c:	34 e6 86 00 	[SP + 0x218] = R4;
8c0b0f80:	b4 e6 08 02 	B[SP + 0x208] = R4;
8c0b0f84:	b4 e6 24 02 	B[SP + 0x224] = R4;
8c0b0f88:	07 da 00 84 	R7=-2080331296;
8c0b0f8c:	e0 a9 00 00 
8c0b0f90:	27 65       	R7 += 0x24;		/* ( 36) */
8c0b0f92:	46 30       	R0 = SP;
8c0b0f94:	21 e1 20 02 	R1 = 0x220 (X);		/*		R1=0x220(544) */
8c0b0f98:	04 cc 01 04 	R2 = R0 + R1 (NS) || [FP -0x78] = R5 || NOP;
8c0b0f9c:	25 ba 00 00 
8c0b0fa0:	82 ce 02 c2 	R1 = ROT R2 BY 0x0 || [FP -0x7c] = R4 || NOP;
8c0b0fa4:	14 ba 00 00 
8c0b0fa8:	21 67       	R1 += -0x1c;		/* (-28) */
8c0b0faa:	20 e1 60 fe 	R0 = -0x1a0 (X);		/*		R0=0xfffffe60(-416) */
8c0b0fae:	01 50       	R0 = R1 + R0;
8c0b0fb0:	00 de 4e 8d 	CALL.A 0x8d4e3a60;
8c0b0fb4:	60 3a 00 00 
8c0b0fb8:	00 de 53 8d 	CALL.A 0x8d5381b4;
8c0b0fbc:	b4 81 00 00 
8c0b0fc0:	03 c8 00 18 	MNOP || R0 = B[P3] (Z) || [FP -0x5c] = R5;
8c0b0fc4:	18 99 95 ba 
8c0b0fc8:	00 0c       	CC = R0 == 0x0;
8c0b0fca:	b4 e6 40 02 	B[SP + 0x240] = R4;
8c0b0fce:	01 da 00 84 	R1=-2080331296;
8c0b0fd2:	e0 a9 00 00 
8c0b0fd6:	81 65       	R1 += 0x30;		/* ( 48) */
8c0b0fd8:	0f 06       	IF !CC R1 = R7;
8c0b0fda:	46 30       	R0 = SP;
8c0b0fdc:	22 e1 3c 02 	R2 = 0x23c (X);		/*		R2=0x23c(572) */
8c0b0fe0:	04 cc 02 00 	R0 = R0 + R2 (NS) || [FP -0x60] = R4 || NOP;
8c0b0fe4:	84 ba 00 00 
8c0b0fe8:	ff e3 c7 49 	CALL 0x0x8c09a376;
8c0b0fec:	46 30       	R0 = SP;
8c0b0fee:	21 e1 04 02 	R1 = 0x204 (X);		/*		R1=0x204(516) */
8c0b0ff2:	48 50       	R1 = R0 + R1;
8c0b0ff4:	20 e1 44 fe 	R0 = -0x1bc (X);		/*		R0=0xfffffe44(-444) */
8c0b0ff8:	01 50       	R0 = R1 + R0;
8c0b0ffa:	00 de 5a 8d 	CALL.A 0x8d5a4798;
8c0b0ffe:	98 47 00 00 
8c0b1002:	21 e1 48 00 	R1 = 0x48 (X);		/*		R1=0x48( 72) */
8c0b1006:	46 30       	R0 = SP;
8c0b1008:	88 50       	R2 = R0 + R1;
8c0b100a:	20 e1 d8 01 	R0 = 0x1d8 (X);		/*		R0=0x1d8(472) */
8c0b100e:	42 50       	R1 = R2 + R0;
8c0b1010:	20 e1 0c fe 	R0 = -0x1f4 (X);		/*		R0=0xfffffe0c(-500) */
8c0b1014:	01 50       	R0 = R1 + R0;
8c0b1016:	00 de 5a 8d 	CALL.A 0x8d5a48a6;
8c0b101a:	a6 48 00 00 
8c0b101e:	61 61       	R1 = 0x2c (X);		/*		R1=0x48( 72) */
8c0b1020:	46 30       	R0 = SP;
8c0b1022:	48 50       	R1 = R0 + R1;
8c0b1024:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8c0b1028:	b8 00 00 00 
8c0b102c:	22 e1 10 02 	R2 = 0x210 (X);		/*		R2=0x210(528) */
8c0b1030:	04 cc 0a 00 	R0 = R1 + R2 (NS) || [SP + 0xc] = R0 || NOP;
8c0b1034:	f0 b0 00 00 
8c0b1038:	02 60       	R2 = 0x0 (X);		/*		R2=0x210(528) */
8c0b103a:	fc e3 2f 6c 	CALL 0x0x8c03e898;
8c0b103e:	87 60       	R7 = 0x10 (X);		/*		R7=0x64(100) */
8c0b1040:	30 e4 11 00 	R0 = [SP + 0x44];
8c0b1044:	07 0a       	CC = R7 <= R0 (IU);
8c0b1046:	30 19       	IF CC JUMP 0x0x8c0b12a6;
8c0b1048:	35 e6 11 00 	[SP + 0x44] = R5;
8c0b104c:	34 e6 10 00 	[SP + 0x40] = R4;
8c0b1050:	b4 e6 30 00 	B[SP + 0x30] = R4;
8c0b1054:	30 e4 18 00 	R0 = [SP + 0x60];
8c0b1058:	07 0a       	CC = R7 <= R0 (IU);
8c0b105a:	1f 19       	IF CC JUMP 0x0x8c0b1298;
8c0b105c:	46 30       	R0 = SP;
8c0b105e:	23 e1 40 02 	R3 = 0x240 (X);		/*		R3=0x240(576) */
8c0b1062:	04 cc 03 00 	R0 = R0 + R3 (NS) || R3 = [FP -0x5c] || [FP + 0x8] = FP;
8c0b1066:	93 b8 bf bc 
8c0b106a:	1f 0a       	CC = R7 <= R3 (IU);
8c0b106c:	43 b8       	R3 = [FP -0x70];
8c0b106e:	03 07       	IF CC R0 = R3;
8c0b1070:	35 e6 18 00 	[SP + 0x60] = R5;
8c0b1074:	34 e6 17 00 	[SP + 0x5c] = R4;
8c0b1078:	b4 e6 4c 00 	B[SP + 0x4c] = R4;
8c0b107c:	02 60       	R2 = 0x0 (X);		/*		R2=0x210(528) */
8c0b107e:	01 60       	R1 = 0x0 (X);		/*		R1=0x48( 72) */
8c0b1080:	00 de 53 8d 	CALL.A 0x8d53707e;
8c0b1084:	7e 70 00 00 
8c0b1088:	b4 e6 5c 02 	B[SP + 0x25c] = R4;
8c0b108c:	21 e1 b4 fd 	R1 = -0x24c (X);		/*		R1=0xfffffdb4(-588) */
8c0b1090:	03 c8 00 18 	MNOP || R2 = [FP + 0x8] || [FP -0x40] = R5;
8c0b1094:	ba a0 05 bb 
8c0b1098:	04 cc 11 02 	R1 = R2 + R1 (NS) || [FP -0x44] = R4 || NOP;
8c0b109c:	f4 ba 00 00 
8c0b10a0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c0b10a4:	b8 00 03 00 
8c0b10a8:	20 e1 f4 01 	R0 = 0x1f4 (X);		/*		R0=0x1f4(500) */
8c0b10ac:	04 cc 08 00 	R0 = R1 + R0 (NS) || [SP + 0xc] = R3 || NOP;
8c0b10b0:	f3 b0 00 00 
8c0b10b4:	02 60       	R2 = 0x0 (X);		/*		R2=0x210(528) */
8c0b10b6:	fc e3 5d 6c 	CALL 0x0x8c03e970;
8c0b10ba:	20 e1 ac ff 	R0 = -0x54 (X);		/*		R0=0xffffffac(-84) */
8c0b10be:	03 c8 00 18 	MNOP || R3 = [FP + 0x8] || R2 = [FP -0x54];
8c0b10c2:	bb a0 b2 b8 
8c0b10c6:	04 cc 18 00 	R0 = R3 + R0 (NS) || R3 = [FP -0x40] || NOP;
8c0b10ca:	03 b9 00 00 
8c0b10ce:	1f 0a       	CC = R7 <= R3 (IU);
8c0b10d0:	02 07       	IF CC R0 = R2;
8c0b10d2:	01 da 00 84 	R1=-2080331296;
8c0b10d6:	e0 a9 00 00 
8c0b10da:	00 de 5a 8d 	CALL.A 0x8d5aea90;
8c0b10de:	90 ea 00 00 
8c0b10e2:	00 0c       	CC = R0 == 0x0;
8c0b10e4:	2d 18       	IF CC JUMP 0x0x8c0b113e;
8c0b10e6:	03 c8 00 18 	MNOP || P0 = [FP -0x54] || R3 = [FP -0x40];
8c0b10ea:	b8 b8 03 b9 
8c0b10ee:	2c e1 5c 02 	P4 = 0x25c (X);		/*		P4=0x25c(604) */
8c0b10f2:	1f 0a       	CC = R7 <= R3 (IU);
8c0b10f4:	66 5a       	P1 = SP + P4;
8c0b10f6:	c8 07       	IF CC P1 = P0;
8c0b10f8:	f8 b8       	P0 = [FP -0x44];
8c0b10fa:	0d da 00 84 	P5=-2080331296;
8c0b10fe:	e0 a9 00 00 
8c0b1102:	c5 6c       	P5 += 0x18;		/* ( 24) */
8c0b1104:	00 60       	R0 = 0x0 (X);		/*		R0=0xffffffac(-84) */
8c0b1106:	cd 09       	CC = P5 < P1 (IU);
8c0b1108:	04 18       	IF CC JUMP 0x0x8c0b1110;
8c0b110a:	41 5a       	P1 = P1 + P0;
8c0b110c:	69 0a       	CC = P1 <= P5 (IU);
8c0b110e:	10 02       	ILLEGAL;
8c0b1110:	00 0c       	CC = R0 == 0x0;
8c0b1112:	ae 10       	IF !CC JUMP 0x0x8c0b126e;
8c0b1114:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8c0b1118:	b8 00 00 00 
8c0b111c:	f3 b8       	R3 = [FP -0x44];
8c0b111e:	18 52       	R0 = R0 - R3;
8c0b1120:	59 60       	R1 = 0xb (X);		/*		R1=0xfffffdb4(-588) */
8c0b1122:	08 0a       	CC = R0 <= R1 (IU);
8c0b1124:	9b 18       	IF CC JUMP 0x0x8c0b125a;
8c0b1126:	5b 64       	R3 += 0xb;		/* ( 11) */
8c0b1128:	bb b0       	[FP + 0x8] = R3;
8c0b112a:	46 30       	R0 = SP;
8c0b112c:	22 e1 58 02 	R2 = 0x258 (X);		/*		R2=0x258(600) */
8c0b1130:	10 50       	R0 = R0 + R2;
8c0b1132:	02 60       	R2 = 0x0 (X);		/*		R2=0x258(600) */
8c0b1134:	b9 a0       	R1 = [FP + 0x8];
8c0b1136:	fc e3 05 6b 	CALL 0x0x8c03e740;
8c0b113a:	00 0c       	CC = R0 == 0x0;
8c0b113c:	72 10       	IF !CC JUMP 0x0x8c0b1220;
8c0b113e:	18 e4 ff ff 	R0 = [P3 + -0x4];
8c0b1142:	01 68       	P1 = 0x0 (X);		/*		P1=0x0(  0) */
8c0b1144:	4e 30       	R1 = SP;
8c0b1146:	22 e1 58 02 	R2 = 0x258 (X);		/*		R2=0x258(600) */
8c0b114a:	04 cc 0a 02 	R1 = R1 + R2 (NS) || [SP + 0xc] = P1 || NOP;
8c0b114e:	f1 bc 00 00 
8c0b1152:	02 60       	R2 = 0x0 (X);		/*		R2=0x258(600) */
8c0b1154:	00 de 4d 8d 	CALL.A 0x8d4d8f70;
8c0b1158:	70 8f 00 00 
8c0b115c:	ff e3 bc c5 	CALL 0x0x8c0a9cd4;
8c0b1160:	ff e3 88 99 	CALL 0x0x8c0a4470;
8c0b1164:	00 b9       	R0 = [FP -0x40];
8c0b1166:	07 0a       	CC = R7 <= R0 (IU);
8c0b1168:	53 18       	IF CC JUMP 0x0x8c0b120e;
8c0b116a:	f4 ba       	[FP -0x44] = R4;
8c0b116c:	b4 e6 5c 02 	B[SP + 0x25c] = R4;
8c0b1170:	03 c8 00 18 	MNOP || R0 = [FP -0x5c] || [FP -0x40] = R5;
8c0b1174:	90 b8 05 bb 
8c0b1178:	07 0a       	CC = R7 <= R0 (IU);
8c0b117a:	44 18       	IF CC JUMP 0x0x8c0b1202;
8c0b117c:	84 ba       	[FP -0x60] = R4;
8c0b117e:	b4 e6 40 02 	B[SP + 0x240] = R4;
8c0b1182:	03 c8 00 18 	MNOP || R0 = [FP -0x78] || [FP -0x5c] = R5;
8c0b1186:	20 b8 95 ba 
8c0b118a:	07 0a       	CC = R7 <= R0 (IU);
8c0b118c:	34 18       	IF CC JUMP 0x0x8c0b11f4;
8c0b118e:	25 ba       	[FP -0x78] = R5;
8c0b1190:	14 ba       	[FP -0x7c] = R4;
8c0b1192:	b4 e6 24 02 	B[SP + 0x224] = R4;
8c0b1196:	30 e4 87 00 	R0 = [SP + 0x21c];
8c0b119a:	07 0a       	CC = R7 <= R0 (IU);
8c0b119c:	24 18       	IF CC JUMP 0x0x8c0b11e4;
8c0b119e:	35 e6 87 00 	[SP + 0x21c] = R5;
8c0b11a2:	34 e6 86 00 	[SP + 0x218] = R4;
8c0b11a6:	b4 e6 08 02 	B[SP + 0x208] = R4;
8c0b11aa:	06 30       	R0 = R6;
8c0b11ac:	ff e3 aa fc 	CALL 0x0x8c0b0b00;
8c0b11b0:	30 e4 1f 00 	R0 = [SP + 0x7c];
8c0b11b4:	07 0a       	CC = R7 <= R0 (IU);
8c0b11b6:	09 18       	IF CC JUMP 0x0x8c0b11c8;
8c0b11b8:	b4 e6 68 00 	B[SP + 0x68] = R4;
8c0b11bc:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b11be:	a3 05       	(R7:4, P5:3) = [SP++];
8c0b11c0:	01 e8 00 00 	UNLINK;
8c0b11c4:	10 00       	RTS;
8c0b11c6:	00 00       	NOP;
8c0b11c8:	30 e4 1a 00 	R0 = [SP + 0x68];
8c0b11cc:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b11d0:	e4 e3 00 00 
8c0b11d4:	b4 e6 68 00 	B[SP + 0x68] = R4;
8c0b11d8:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b11da:	a3 05       	(R7:4, P5:3) = [SP++];
8c0b11dc:	01 e8 00 00 	UNLINK;
8c0b11e0:	10 00       	RTS;
8c0b11e2:	00 00       	NOP;
8c0b11e4:	30 e4 82 00 	R0 = [SP + 0x208];
8c0b11e8:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b11ec:	e4 e3 00 00 
8c0b11f0:	d7 2f       	JUMP.S 0x0x8c0b119e;
8c0b11f2:	00 00       	NOP;
8c0b11f4:	30 e4 89 00 	R0 = [SP + 0x224];
8c0b11f8:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b11fc:	e4 e3 00 00 
8c0b1200:	c7 2f       	JUMP.S 0x0x8c0b118e;
8c0b1202:	40 b8       	R0 = [FP -0x70];
8c0b1204:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b1208:	e4 e3 00 00 
8c0b120c:	b8 2f       	JUMP.S 0x0x8c0b117c;
8c0b120e:	b0 b8       	R0 = [FP -0x54];
8c0b1210:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b1214:	e4 e3 00 00 
8c0b1218:	a9 2f       	JUMP.S 0x0x8c0b116a;
8c0b121a:	00 00       	NOP;
8c0b121c:	00 00       	NOP;
8c0b121e:	00 00       	NOP;
8c0b1220:	03 c8 00 18 	MNOP || P2 = [FP -0x54] || R0 = [FP -0x40];
8c0b1224:	ba b8 00 b9 
8c0b1228:	07 0a       	CC = R7 <= R0 (IU);
8c0b122a:	66 5a       	P1 = SP + P4;
8c0b122c:	f8 b8       	P0 = [FP -0x44];
8c0b122e:	ca 07       	IF CC P1 = P2;
8c0b1230:	4d 30       	R1 = P5;
8c0b1232:	bd ac       	P5 = [FP + 0x8];
8c0b1234:	5a 60       	R2 = 0xb (X);		/*		R2=0x258(600) */
8c0b1236:	26 5b       	P4 = SP + P4;
8c0b1238:	41 5a       	P1 = P1 + P0;
8c0b123a:	41 30       	R0 = P1;
8c0b123c:	00 de 02 04 	CALL.A 0x040201c4;
8c0b1240:	c4 01 00 00 
8c0b1244:	03 c8 00 18 	MNOP || P1 = [FP -0x54] || R0 = [FP -0x40];
8c0b1248:	b9 b8 00 b9 
8c0b124c:	07 0a       	CC = R7 <= R0 (IU);
8c0b124e:	bb a0       	R3 = [FP + 0x8];
8c0b1250:	f3 ba       	[FP -0x44] = R3;
8c0b1252:	e1 07       	IF CC P4 = P1;
8c0b1254:	6c 5a       	P1 = P4 + P5;
8c0b1256:	0c 9b       	B[P1] = R4;
8c0b1258:	73 2f       	JUMP.S 0x0x8c0b113e;
8c0b125a:	46 30       	R0 = SP;
8c0b125c:	21 e1 58 02 	R1 = 0x258 (X);		/*		R1=0x258(600) */
8c0b1260:	08 50       	R0 = R0 + R1;
8c0b1262:	00 de ed 8f 	CALL.A 0x8fed519c;
8c0b1266:	9c 51 00 00 
8c0b126a:	f3 b8       	R3 = [FP -0x44];
8c0b126c:	5d 2f       	JUMP.S 0x0x8c0b1126;
8c0b126e:	56 30       	R2 = SP;
8c0b1270:	20 e1 5c 02 	R0 = 0x25c (X);		/*		R0=0x25c(604) */
8c0b1274:	1f 0a       	CC = R7 <= R3 (IU);
8c0b1276:	04 cc 10 04 	R2 = R2 + R0 (NS) || R3 = [FP -0x54] || NOP;
8c0b127a:	b3 b8 00 00 
8c0b127e:	58 60       	R0 = 0xb (X);		/*		R0=0x25c(604) */
8c0b1280:	13 07       	IF CC R2 = R3;
8c0b1282:	f0 b0       	[SP + 0xc] = R0;
8c0b1284:	23 e1 58 02 	R3 = 0x258 (X);		/*		R3=0x258(600) */
8c0b1288:	46 30       	R0 = SP;
8c0b128a:	4d 30       	R1 = P5;
8c0b128c:	18 50       	R0 = R0 + R3;
8c0b128e:	91 52       	R2 = R1 - R2;
8c0b1290:	08 30       	R1 = R0;
8c0b1292:	fc e3 03 6b 	CALL 0x0x8c03e898;
8c0b1296:	54 2f       	JUMP.S 0x0x8c0b113e;
8c0b1298:	30 e4 13 00 	R0 = [SP + 0x4c];
8c0b129c:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b12a0:	e4 e3 00 00 
8c0b12a4:	dc 2e       	JUMP.S 0x0x8c0b105c;
8c0b12a6:	30 a3       	R0 = [SP + 0x30];
8c0b12a8:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b12ac:	e4 e3 00 00 
8c0b12b0:	cc 2e       	JUMP.S 0x0x8c0b1048;
8c0b12b2:	46 30       	R0 = SP;
8c0b12b4:	21 e1 64 00 	R1 = 0x64 (X);		/*		R1=0x64(100) */
8c0b12b8:	08 50       	R0 = R0 + R1;
8c0b12ba:	00 de 4e 8d 	CALL.A 0x8d4e8220;
8c0b12be:	20 82 00 00 
8c0b12c2:	5b 2e       	JUMP.S 0x0x8c0b0f78;
8c0b12c4:	4e 30       	R1 = SP;
8c0b12c6:	22 e1 64 00 	R2 = 0x64 (X);		/*		R2=0x64(100) */
8c0b12ca:	51 50       	R1 = R1 + R2;
8c0b12cc:	07 30       	R0 = R7;
8c0b12ce:	00 de 4e 8d 	CALL.A 0x8d4e0868;
8c0b12d2:	68 08 00 00 
8c0b12d6:	18 99       	R0 = B[P3] (Z);
8c0b12d8:	4e 2e       	JUMP.S 0x0x8c0b0f74;
8c0b12da:	20 b9       	R0 = [FP -0x38];
8c0b12dc:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b12e0:	e4 e3 00 00 
8c0b12e4:	22 2e       	JUMP.S 0x0x8c0b0f28;
8c0b12e6:	00 00       	NOP;
8c0b12e8:	00 da 00 84 	R0=-2080331112;
8c0b12ec:	98 aa 00 00 
8c0b12f0:	fc e3 be 66 	CALL 0x0x8c03e06c;
8c0b12f4:	03 2e       	JUMP.S 0x0x8c0b0efa;
8c0b12f6:	00 00       	NOP;
8c0b12f8:	19 e4 ff ff 	R1 = [P3 + -0x4];
8c0b12fc:	7f 30       	R7 = FP;
8c0b12fe:	27 66       	R7 += -0x3c;		/* (-60) */
8c0b1300:	07 30       	R0 = R7;
8c0b1302:	ff e3 d7 fc 	CALL 0x0x8c0b0cb0;
8c0b1306:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8c0b130a:	b8 00 00 00 
8c0b130e:	21 e1 f0 fd 	R1 = -0x210 (X);		/*		R1=0xfffffdf0(-528) */
8c0b1312:	04 cc 39 00 	R0 = R7 + R1 (NS) || [SP + 0xc] = R0 || NOP;
8c0b1316:	f0 b0 00 00 
8c0b131a:	0f 30       	R1 = R7;
8c0b131c:	02 60       	R2 = 0x0 (X);		/*		R2=0x64(100) */
8c0b131e:	fc e3 29 6b 	CALL 0x0x8c03e970;
8c0b1322:	87 60       	R7 = 0x10 (X);		/*		R7=0x64(100) */
8c0b1324:	70 b9       	R0 = [FP -0x24];
8c0b1326:	07 0a       	CC = R7 <= R0 (IU);
8c0b1328:	23 18       	IF CC JUMP 0x0x8c0b136e;
8c0b132a:	75 bb       	[FP -0x24] = R5;
8c0b132c:	64 bb       	[FP -0x28] = R4;
8c0b132e:	b4 e6 78 02 	B[SP + 0x278] = R4;
8c0b1332:	30 e4 1e 00 	R0 = [SP + 0x78];
8c0b1336:	00 0c       	CC = R0 == 0x0;
8c0b1338:	02 1c       	IF CC JUMP 0x0x8c0b133c (BP);
8c0b133a:	fb 2d       	JUMP.S 0x0x8c0b0f30;
8c0b133c:	30 e4 1f 00 	R0 = [SP + 0x7c];
8c0b1340:	07 0a       	CC = R7 <= R0 (IU);
8c0b1342:	09 18       	IF CC JUMP 0x0x8c0b1354;
8c0b1344:	b4 e6 68 00 	B[SP + 0x68] = R4;
8c0b1348:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b134a:	a3 05       	(R7:4, P5:3) = [SP++];
8c0b134c:	01 e8 00 00 	UNLINK;
8c0b1350:	10 00       	RTS;
8c0b1352:	00 00       	NOP;
8c0b1354:	30 e4 1a 00 	R0 = [SP + 0x68];
8c0b1358:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b135c:	e4 e3 00 00 
8c0b1360:	b4 e6 68 00 	B[SP + 0x68] = R4;
8c0b1364:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b1366:	a3 05       	(R7:4, P5:3) = [SP++];
8c0b1368:	01 e8 00 00 	UNLINK;
8c0b136c:	10 00       	RTS;
8c0b136e:	20 b9       	R0 = [FP -0x38];
8c0b1370:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c0b1374:	e4 e3 00 00 
8c0b1378:	d9 2f       	JUMP.S 0x0x8c0b132a;
8c0b137a:	00 00       	NOP;
8c0b137c:	00 00       	NOP;
8c0b137e:	00 00       	NOP;
8c0b1380:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c0b1384:	fc 1e 00 00 
8c0b1388:	98 0c       	CC = R0 < 0x3;
8c0b138a:	0b 10       	IF !CC JUMP 0x0x8c0b13a0;
8c0b138c:	00 de 53 8d 	CALL.A 0x8d535950;
8c0b1390:	50 59 00 00 
8c0b1394:	86 6c       	SP += 0x10;		/* ( 16) */
8c0b1396:	a3 05       	(R7:4, P5:3) = [SP++];
8c0b1398:	01 e8 00 00 	UNLINK;
8c0b139c:	10 00       	RTS;
8c0b139e:	00 00       	NOP;
