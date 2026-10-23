
os.ldr@0x8d4e7c00:     file format binary


Disassembly of section .data:

8d4e7c00 <.data>:
8d4e7c00:	00 00       	NOP;
8d4e7c02:	00 0c       	CC = R0 == 0x0;
8d4e7c04:	0d 10       	IF !CC JUMP 0x0x8d4e7c1e;
8d4e7c06:	03 c8 00 18 	MNOP || P1 = [FP + 0xc] || R1 = [FP + 0x10];
8d4e7c0a:	f9 ac 39 a1 
8d4e7c0e:	6f 30       	R5 = FP;
8d4e7c10:	02 da 03 84 	R2=-2080149216;
8d4e7c14:	20 71 00 00 
8d4e7c18:	48 a1       	R0 = [P1 + 0x14];
8d4e7c1a:	00 0c       	CC = R0 == 0x0;
8d4e7c1c:	79 10       	IF !CC JUMP 0x0x8d4e7d0e;
8d4e7c1e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e7c22:	b8 00 03 00 
8d4e7c26:	46 30       	R0 = SP;
8d4e7c28:	25 e1 5c 00 	R5 = 0x5c (X);		/*		R5=0x5c( 92) */
8d4e7c2c:	04 cc 05 00 	R0 = R0 + R5 (NS) || [SP + 0xc] = R3 || R1 = [FP + 0x10];
8d4e7c30:	f3 b0 39 a1 
8d4e7c34:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d4e7c36:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e7c3a:	70 e9 00 00 
8d4e7c3e:	fa ac       	P2 = [FP + 0xc];
8d4e7c40:	25 e1 5c 00 	R5 = 0x5c (X);		/*		R5=0x5c( 92) */
8d4e7c44:	03 c8 00 18 	MNOP || P5 = [P2 + 0x2c] || R1 = [P2 + 0x28];
8d4e7c48:	d5 ae 91 a2 
8d4e7c4c:	94 ae       	P4 = [P2 + 0x28];
8d4e7c4e:	45 30       	R0 = P5;
8d4e7c50:	01 08       	CC = R1 == R0;
8d4e7c52:	17 18       	IF CC JUMP 0x0x8d4e7c80;
8d4e7c54:	a0 e4 20 00 	R0 = B[P4 + 0x20] (Z);
8d4e7c58:	30 b1       	[SP + 0x10] = R0;
8d4e7c5a:	03 c8 00 18 	MNOP || R1 = [P4 + 0x1c] || [SP + 0x14] = P3;
8d4e7c5e:	e1 a1 73 bd 
8d4e7c62:	54 30       	R2 = P4;
8d4e7c64:	24 6d       	P4 += 0x24;		/* ( 36) */
8d4e7c66:	46 30       	R0 = SP;
8d4e7c68:	04 cc 05 02 	R1 = R0 + R5 (NS) || [SP + 0xc] = R1 || NOP;
8d4e7c6c:	f1 b0 00 00 
8d4e7c70:	00 da 29 84 	R0=-2077631748;
8d4e7c74:	fc da 00 00 
8d4e7c78:	06 e3 6c 01 	CALL 0x0x8d5a7f50;
8d4e7c7c:	65 08       	CC = P5 == P4;
8d4e7c7e:	eb 17       	IF !CC JUMP 0x0x8d4e7c54 (BP);
8d4e7c80:	10 b9       	R0 = [FP -0x3c];
8d4e7c82:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e7c84:	01 0a       	CC = R1 <= R0 (IU);
8d4e7c86:	40 18       	IF CC JUMP 0x0x8d4e7d06;
8d4e7c88:	03 c8 00 18 	MNOP || P0 = [FP + 0xc] || [FP -0x3c] = R7;
8d4e7c8c:	f8 ac 17 bb 
8d4e7c90:	03 c8 00 18 	MNOP || P2 = [SP + 0x3c] || [FP -0x40] = R6;
8d4e7c94:	f2 af 06 bb 
8d4e7c98:	29 e1 48 00 	P1 = 0x48 (X);		/*		P1=0x48( 72) */
8d4e7c9c:	b6 e6 60 00 	B[SP + 0x60] = R6;
8d4e7ca0:	48 5a       	P1 = P0 + P1;
8d4e7ca2:	4a 08       	CC = P2 == P1;
8d4e7ca4:	f9 bc       	[FP + 0xc] = P1;
8d4e7ca6:	9c 17       	IF !CC JUMP 0x0x8d4e7bde (BP);
8d4e7ca8:	03 c8 00 18 	MNOP || R1 = [FP + 0x10] || R5 = [FP + 0x10];
8d4e7cac:	39 a1 3d a1 
8d4e7cb0:	00 da 29 84 	R0=-2077631748;
8d4e7cb4:	fc da 00 00 
8d4e7cb8:	06 e3 44 01 	CALL 0x0x8d5a7f40;
8d4e7cbc:	85 65       	R5 += 0x30;		/* ( 48) */
8d4e7cbe:	03 c8 00 18 	MNOP || R2 = [SP + 0x34] || [FP + 0x10] = R5;
8d4e7cc2:	72 a3 3d b1 
8d4e7cc6:	2a 08       	CC = R2 == R5;
8d4e7cc8:	b1 af       	P1 = [SP + 0x38];
8d4e7cca:	7a 17       	IF !CC JUMP 0x0x8d4e7bbe (BP);
8d4e7ccc:	00 da 29 84 	R0=-2077631748;
8d4e7cd0:	fc da 00 00 
8d4e7cd4:	05 e3 a4 e9 	CALL 0x0x8d5a501c;
8d4e7cd8:	00 da 29 84 	R0=-2077631728;
8d4e7cdc:	10 db 00 00 
8d4e7ce0:	05 e3 9e e9 	CALL 0x0x8d5a501c;
8d4e7ce4:	09 da 29 84 	P1=-2077631748;
8d4e7ce8:	fc da 00 00 
8d4e7cec:	08 da 29 84 	P0=-2077631728;
8d4e7cf0:	10 db 00 00 
8d4e7cf4:	8e e6 10 00 	B[P1 + 0x10] = R6;
8d4e7cf8:	86 e6 10 00 	B[P0 + 0x10] = R6;
8d4e7cfc:	c6 6c       	SP += 0x18;		/* ( 24) */
8d4e7cfe:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e7d00:	01 e8 00 00 	UNLINK;
8d4e7d04:	10 00       	RTS;
8d4e7d06:	c0 b8       	R0 = [FP -0x50];
8d4e7d08:	ff e3 6e 33 	CALL 0x0x8d4ce3e4;
8d4e7d0c:	be 2f       	JUMP.S 0x0x8d4e7c88;
8d4e7d0e:	25 67       	R5 += -0x1c;		/* (-28) */
8d4e7d10:	05 30       	R0 = R5;
8d4e7d12:	00 de 03 8c 	CALL.A 0x8c03f194;
8d4e7d16:	94 f1 00 00 
8d4e7d1a:	05 30       	R0 = R5;
8d4e7d1c:	0d 30       	R1 = R5;
8d4e7d1e:	14 30       	R2 = R4;
8d4e7d20:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e7d22:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d4e7d26:	e4 f0 00 00 
8d4e7d2a:	4f 30       	R1 = FP;
8d4e7d2c:	41 66       	R1 += -0x38;		/* (-56) */
8d4e7d2e:	01 30       	R0 = R1;
8d4e7d30:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d4e7d34:	b8 00 03 00 
8d4e7d38:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d4e7d3c:	f3 b0 00 00 
8d4e7d40:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e7d42:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e7d46:	70 e9 00 00 
8d4e7d4a:	85 60       	R5 = 0x10 (X);		/*		R5=0x5c( 92) */
8d4e7d4c:	80 b9       	R0 = [FP -0x20];
8d4e7d4e:	05 0a       	CC = R5 <= R0 (IU);
8d4e7d50:	17 18       	IF CC JUMP 0x0x8d4e7d7e;
8d4e7d52:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || [FP -0x24] = R6;
8d4e7d56:	f0 b9 76 bb 
8d4e7d5a:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e7d5c:	01 0a       	CC = R1 <= R0 (IU);
8d4e7d5e:	b6 e6 7c 00 	B[SP + 0x7c] = R6;
8d4e7d62:	03 c8 00 18 	MNOP || [FP -0x20] = R7 || R0 = [FP -0x18];
8d4e7d66:	87 bb a0 b9 
8d4e7d6a:	07 18       	IF CC JUMP 0x0x8d4e7d78;
8d4e7d6c:	f7 bb       	[FP -0x4] = R7;
8d4e7d6e:	e6 bb       	[FP -0x8] = R6;
8d4e7d70:	b6 e6 98 00 	B[SP + 0x98] = R6;
8d4e7d74:	65 2f       	JUMP.S 0x0x8d4e7c3e;
8d4e7d76:	00 00       	NOP;
8d4e7d78:	ff e3 36 33 	CALL 0x0x8d4ce3e4;
8d4e7d7c:	f8 2f       	JUMP.S 0x0x8d4e7d6c;
8d4e7d7e:	30 b9       	R0 = [FP -0x34];
8d4e7d80:	ff e3 32 33 	CALL 0x0x8d4ce3e4;
8d4e7d84:	e7 2f       	JUMP.S 0x0x8d4e7d52;
8d4e7d86:	00 00       	NOP;
8d4e7d88:	00 da 03 84 	R0=-2080148656;
8d4e7d8c:	50 73 00 00 
8d4e7d90:	00 de 03 8c 	CALL.A 0x8c03e06c;
8d4e7d94:	6c e0 00 00 
8d4e7d98:	02 2f       	JUMP.S 0x0x8d4e7b9c;
8d4e7d9a:	50 b8       	R0 = [FP -0x6c];
8d4e7d9c:	ff e3 24 33 	CALL 0x0x8d4ce3e4;
8d4e7da0:	ef 2e       	JUMP.S 0x0x8d4e7b7e;
8d4e7da2:	50 b8       	R0 = [FP -0x6c];
8d4e7da4:	ff e3 20 33 	CALL 0x0x8d4ce3e4;
8d4e7da8:	c1 2e       	JUMP.S 0x0x8d4e7b2a;
8d4e7daa:	00 00       	NOP;
8d4e7dac:	00 00       	NOP;
8d4e7dae:	00 00       	NOP;
8d4e7db0:	00 e8 1c 00 	LINK 0x70;		/* (112) */
8d4e7db4:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e7db6:	66 6f       	SP += -0x14;		/* (-20) */
8d4e7db8:	43 61       	R3 = 0x28 (X);		/*		R3=0x0(  0) */
8d4e7dba:	56 30       	R2 = SP;
8d4e7dbc:	04 cc 13 08 	R4 = R2 + R3 (NS) || [FP + 0x8] = R1 || NOP;
8d4e7dc0:	b9 b0 00 00 
8d4e7dc4:	28 32       	P5 = R0;
8d4e7dc6:	30 30       	R6 = R0;
8d4e7dc8:	28 30       	R5 = R0;
8d4e7dca:	04 30       	R0 = R4;
8d4e7dcc:	ff e3 ae ef 	CALL 0x0x8d4e5d28;
8d4e7dd0:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R7 = [SP + 0x3c] || NOP;
8d4e7dd4:	f7 a3 00 00 
8d4e7dd8:	07 0c       	CC = R7 == 0x0;
8d4e7dda:	41 10       	IF !CC JUMP 0x0x8d4e7e5c;
8d4e7ddc:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e7de0:	fc 1e 00 00 
8d4e7de4:	98 0c       	CC = R0 < 0x3;
8d4e7de6:	29 10       	IF !CC JUMP 0x0x8d4e7e38;
8d4e7de8:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [P5 + 0x14] = R7 || NOP;
8d4e7dec:	6f b1 00 00 
8d4e7df0:	af e6 04 00 	B[P5 + 0x4] = R7;
8d4e7df4:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8d4e7df6:	a9 b1       	[P5 + 0x18] = R1;
8d4e7df8:	01 da 03 84 	R1=-2080149172;
8d4e7dfc:	4c 71 00 00 
8d4e7e00:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e7e04:	76 a3 00 00 
8d4e7e08:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8d4e7e0a:	a1 b8       	R1 = [FP -0x58];
8d4e7e0c:	08 0a       	CC = R0 <= R1 (IU);
8d4e7e0e:	09 18       	IF CC JUMP 0x0x8d4e7e20;
8d4e7e10:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e7e12:	b0 e6 2c 00 	B[SP + 0x2c] = R0;
8d4e7e16:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e7e18:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e7e1a:	01 e8 00 00 	UNLINK;
8d4e7e1e:	10 00       	RTS;
8d4e7e20:	f0 a2       	R0 = [SP + 0x2c];
8d4e7e22:	ff e3 e1 32 	CALL 0x0x8d4ce3e4;
8d4e7e26:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e7e28:	b0 e6 2c 00 	B[SP + 0x2c] = R0;
8d4e7e2c:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e7e2e:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e7e30:	01 e8 00 00 	UNLINK;
8d4e7e34:	10 00       	RTS;
8d4e7e36:	00 00       	NOP;
8d4e7e38:	09 da 03 84 	P1=-2080148632;
8d4e7e3c:	68 73 00 00 
8d4e7e40:	f1 bc       	[SP + 0xc] = P1;
8d4e7e42:	22 e1 94 02 	R2 = 0x294 (X);		/*		R2=0x294(660) */
8d4e7e46:	01 da 03 84 	R1=-2080148832;
8d4e7e4a:	a0 72 00 00 
8d4e7e4e:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d4e7e50:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e7e54:	74 05 00 00 
8d4e7e58:	c8 2f       	JUMP.S 0x0x8d4e7de8;
8d4e7e5a:	00 00       	NOP;
8d4e7e5c:	ff e3 dc c9 	CALL 0x0x8d4e1214;
8d4e7e60:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || P0 = [SP + 0x2c] || R3 = [FP -0x58];
8d4e7e64:	f0 ae a3 b8 
8d4e7e68:	06 0c       	CC = R6 == 0x0;
8d4e7e6a:	3f 18       	IF CC JUMP 0x0x8d4e7ee8;
8d4e7e6c:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e7e70:	fc 1e 00 00 
8d4e7e74:	98 0c       	CC = R0 < 0x3;
8d4e7e76:	21 10       	IF !CC JUMP 0x0x8d4e7eb8;
8d4e7e78:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4e7e7a:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [P5 + 0x14] = R1 || NOP;
8d4e7e7e:	69 b1 00 00 
8d4e7e82:	a9 e6 04 00 	B[P5 + 0x4] = R1;
8d4e7e86:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8d4e7e88:	a9 b1       	[P5 + 0x18] = R1;
8d4e7e8a:	01 da 03 84 	R1=-2080149172;
8d4e7e8e:	4c 71 00 00 
8d4e7e92:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e7e96:	76 a3 00 00 
8d4e7e9a:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8d4e7e9c:	a1 b8       	R1 = [FP -0x58];
8d4e7e9e:	08 0a       	CC = R0 <= R1 (IU);
8d4e7ea0:	b8 17       	IF !CC JUMP 0x0x8d4e7e10 (BP);
8d4e7ea2:	f0 a2       	R0 = [SP + 0x2c];
8d4e7ea4:	ff e3 a0 32 	CALL 0x0x8d4ce3e4;
8d4e7ea8:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e7eaa:	b0 e6 2c 00 	B[SP + 0x2c] = R0;
8d4e7eae:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e7eb0:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e7eb2:	01 e8 00 00 	UNLINK;
8d4e7eb6:	10 00       	RTS;
8d4e7eb8:	09 da 03 84 	P1=-2080148600;
8d4e7ebc:	88 73 00 00 
8d4e7ec0:	f1 bc       	[SP + 0xc] = P1;
8d4e7ec2:	22 e1 98 02 	R2 = 0x298 (X);		/*		R2=0x298(664) */
8d4e7ec6:	01 da 03 84 	R1=-2080148832;
8d4e7eca:	a0 72 00 00 
8d4e7ece:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d4e7ed0:	61 69       	P1 = 0x2c (X);		/*		P1=0x48( 72) */
8d4e7ed2:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e7ed4:	1f 0a       	CC = R7 <= R3 (IU);
8d4e7ed6:	4e 5a       	P1 = SP + P1;
8d4e7ed8:	c8 07       	IF CC P1 = P0;
8d4e7eda:	31 bd       	[SP + 0x10] = P1;
8d4e7edc:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e7ee0:	74 05 00 00 
8d4e7ee4:	ca 2f       	JUMP.S 0x0x8d4e7e78;
8d4e7ee6:	00 00       	NOP;
8d4e7ee8:	b6 e6 48 00 	B[SP + 0x48] = R6;
8d4e7eec:	b6 e6 64 00 	B[SP + 0x64] = R6;
8d4e7ef0:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8d4e7ef2:	87 bb       	[FP -0x20] = R7;
8d4e7ef4:	46 30       	R0 = SP;
8d4e7ef6:	21 e1 44 00 	R1 = 0x44 (X);		/*		R1=0x44( 68) */
8d4e7efa:	04 cc 01 00 	R0 = R0 + R1 (NS) || [FP -0x40] = R6 || NOP;
8d4e7efe:	06 bb 00 00 
8d4e7f02:	82 ce 00 c4 	R2 = ROT R0 BY 0x0 || [FP -0x24] = R6 || NOP;
8d4e7f06:	76 bb 00 00 
8d4e7f0a:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e7f0c:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [FP -0x3c] = R7 || NOP;
8d4e7f10:	17 bb 00 00 
8d4e7f14:	40 66       	R0 += -0x38;		/* (-56) */
8d4e7f16:	ff e3 a5 dd 	CALL 0x0x8d4e3a60;
8d4e7f1a:	00 0c       	CC = R0 == 0x0;
8d4e7f1c:	5d 10       	IF !CC JUMP 0x0x8d4e7fd6;
8d4e7f1e:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e7f22:	fc 1e 00 00 
8d4e7f26:	98 0c       	CC = R0 < 0x3;
8d4e7f28:	3c 10       	IF !CC JUMP 0x0x8d4e7fa0;
8d4e7f2a:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [P5 + 0x18] = R7 || NOP;
8d4e7f2e:	af b1 00 00 
8d4e7f32:	6e b1       	[P5 + 0x14] = R6;
8d4e7f34:	ae e6 04 00 	B[P5 + 0x4] = R6;
8d4e7f38:	01 da 03 84 	R1=-2080149172;
8d4e7f3c:	4c 71 00 00 
8d4e7f40:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e7f44:	76 a3 00 00 
8d4e7f48:	85 60       	R5 = 0x10 (X);		/*		R5=0x5c( 92) */
8d4e7f4a:	80 b9       	R0 = [FP -0x20];
8d4e7f4c:	05 0a       	CC = R5 <= R0 (IU);
8d4e7f4e:	22 18       	IF CC JUMP 0x0x8d4e7f92;
8d4e7f50:	76 bb       	[FP -0x24] = R6;
8d4e7f52:	b6 e6 64 00 	B[SP + 0x64] = R6;
8d4e7f56:	03 c8 00 18 	MNOP || R0 = [FP -0x3c] || [FP -0x20] = R7;
8d4e7f5a:	10 b9 87 bb 
8d4e7f5e:	05 0a       	CC = R5 <= R0 (IU);
8d4e7f60:	15 18       	IF CC JUMP 0x0x8d4e7f8a;
8d4e7f62:	03 c8 00 18 	MNOP || R0 = [FP -0x58] || [FP -0x3c] = R7;
8d4e7f66:	a0 b8 17 bb 
8d4e7f6a:	05 0a       	CC = R5 <= R0 (IU);
8d4e7f6c:	06 bb       	[FP -0x40] = R6;
8d4e7f6e:	b6 e6 48 00 	B[SP + 0x48] = R6;
8d4e7f72:	4f 17       	IF !CC JUMP 0x0x8d4e7e10 (BP);
8d4e7f74:	f0 a2       	R0 = [SP + 0x2c];
8d4e7f76:	ff e3 37 32 	CALL 0x0x8d4ce3e4;
8d4e7f7a:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e7f7c:	b0 e6 2c 00 	B[SP + 0x2c] = R0;
8d4e7f80:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e7f82:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e7f84:	01 e8 00 00 	UNLINK;
8d4e7f88:	10 00       	RTS;
8d4e7f8a:	c0 b8       	R0 = [FP -0x50];
8d4e7f8c:	ff e3 2c 32 	CALL 0x0x8d4ce3e4;
8d4e7f90:	e9 2f       	JUMP.S 0x0x8d4e7f62;
8d4e7f92:	30 b9       	R0 = [FP -0x34];
8d4e7f94:	ff e3 28 32 	CALL 0x0x8d4ce3e4;
8d4e7f98:	dc 2f       	JUMP.S 0x0x8d4e7f50;
8d4e7f9a:	00 00       	NOP;
8d4e7f9c:	00 00       	NOP;
8d4e7f9e:	00 00       	NOP;
8d4e7fa0:	09 da 03 84 	P1=-2080148560;
8d4e7fa4:	b0 73 00 00 
8d4e7fa8:	f1 bc       	[SP + 0xc] = P1;
8d4e7faa:	22 e1 9f 02 	R2 = 0x29f (X);		/*		R2=0x29f(671) */
8d4e7fae:	01 da 03 84 	R1=-2080148832;
8d4e7fb2:	a0 72 00 00 
8d4e7fb6:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d4e7fb8:	03 c8 00 18 	MNOP || P0 = [SP + 0x2c] || R3 = [FP -0x58];
8d4e7fbc:	f0 ae a3 b8 
8d4e7fc0:	61 69       	P1 = 0x2c (X);		/*		P1=0x48( 72) */
8d4e7fc2:	84 60       	R4 = 0x10 (X);		/*		R4=0x0(  0) */
8d4e7fc4:	1c 0a       	CC = R4 <= R3 (IU);
8d4e7fc6:	4e 5a       	P1 = SP + P1;
8d4e7fc8:	c8 07       	IF CC P1 = P0;
8d4e7fca:	31 bd       	[SP + 0x10] = P1;
8d4e7fcc:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e7fd0:	74 05 00 00 
8d4e7fd4:	ab 2f       	JUMP.S 0x0x8d4e7f2a;
8d4e7fd6:	04 30       	R0 = R4;
8d4e7fd8:	ff e3 f6 ee 	CALL 0x0x8d4e5dc4;
8d4e7fdc:	00 0c       	CC = R0 == 0x0;
8d4e7fde:	46 30       	R0 = SP;
8d4e7fe0:	64 18       	IF CC JUMP 0x0x8d4e80a8;
8d4e7fe2:	20 e1 54 00 	R0 = 0x54 (X);		/*		R0=0x54( 84) */
8d4e7fe6:	04 50       	R0 = R4 + R0;
8d4e7fe8:	0c 30       	R1 = R4;
8d4e7fea:	05 e3 27 e3 	CALL 0x0x8d5a4638;
8d4e7fee:	47 30       	R0 = FP;
8d4e7ff0:	40 67       	R0 += -0x18;		/* (-24) */
8d4e7ff2:	84 60       	R4 = 0x10 (X);		/*		R4=0x0(  0) */
8d4e7ff4:	03 c8 00 18 	MNOP || R1 = [FP -0x4] || R2 = [FP -0x18];
8d4e7ff8:	f1 b9 a2 b9 
8d4e7ffc:	0c 0a       	CC = R4 <= R1 (IU);
8d4e7ffe:	02 07       	IF CC R0 = R2;
8d4e8000:	00 de 03 8c 	CALL.A 0x8c03e268;
8d4e8004:	68 e2 00 00 
8d4e8008:	f0 b9       	R0 = [FP -0x4];
8d4e800a:	04 0a       	CC = R4 <= R0 (IU);
8d4e800c:	49 18       	IF CC JUMP 0x0x8d4e809e;
8d4e800e:	f7 bb       	[FP -0x4] = R7;
8d4e8010:	e6 bb       	[FP -0x8] = R6;
8d4e8012:	b6 e6 80 00 	B[SP + 0x80] = R6;
8d4e8016:	b8 a0       	R0 = [FP + 0x8];
8d4e8018:	ff e3 76 f0 	CALL 0x0x8d4e6104;
8d4e801c:	00 0c       	CC = R0 == 0x0;
8d4e801e:	3d 18       	IF CC JUMP 0x0x8d4e8098;
8d4e8020:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [P5 + 0x18] = R7 || NOP;
8d4e8024:	af b1 00 00 
8d4e8028:	6e b1       	[P5 + 0x14] = R6;
8d4e802a:	ae e6 04 00 	B[P5 + 0x4] = R6;
8d4e802e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d4e8032:	b8 00 01 00 
8d4e8036:	f1 b0       	[SP + 0xc] = R1;
8d4e8038:	4f 30       	R1 = FP;
8d4e803a:	41 66       	R1 += -0x38;		/* (-56) */
8d4e803c:	02 60       	R2 = 0x0 (X);		/*		R2=0x29f(671) */
8d4e803e:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4e8042:	70 e9 00 00 
8d4e8046:	85 60       	R5 = 0x10 (X);		/*		R5=0x5c( 92) */
8d4e8048:	80 b9       	R0 = [FP -0x20];
8d4e804a:	05 0a       	CC = R5 <= R0 (IU);
8d4e804c:	22 18       	IF CC JUMP 0x0x8d4e8090;
8d4e804e:	76 bb       	[FP -0x24] = R6;
8d4e8050:	b6 e6 64 00 	B[SP + 0x64] = R6;
8d4e8054:	03 c8 00 18 	MNOP || R0 = [FP -0x3c] || [FP -0x20] = R7;
8d4e8058:	10 b9 87 bb 
8d4e805c:	05 0a       	CC = R5 <= R0 (IU);
8d4e805e:	15 18       	IF CC JUMP 0x0x8d4e8088;
8d4e8060:	03 c8 00 18 	MNOP || R0 = [FP -0x58] || [FP -0x3c] = R7;
8d4e8064:	a0 b8 17 bb 
8d4e8068:	05 0a       	CC = R5 <= R0 (IU);
8d4e806a:	06 bb       	[FP -0x40] = R6;
8d4e806c:	b6 e6 48 00 	B[SP + 0x48] = R6;
8d4e8070:	d0 16       	IF !CC JUMP 0x0x8d4e7e10 (BP);
8d4e8072:	f0 a2       	R0 = [SP + 0x2c];
8d4e8074:	ff e3 b8 31 	CALL 0x0x8d4ce3e4;
8d4e8078:	00 60       	R0 = 0x0 (X);		/*		R0=0x54( 84) */
8d4e807a:	b0 e6 2c 00 	B[SP + 0x2c] = R0;
8d4e807e:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4e8080:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e8082:	01 e8 00 00 	UNLINK;
8d4e8086:	10 00       	RTS;
8d4e8088:	c0 b8       	R0 = [FP -0x50];
8d4e808a:	ff e3 ad 31 	CALL 0x0x8d4ce3e4;
8d4e808e:	e9 2f       	JUMP.S 0x0x8d4e8060;
8d4e8090:	30 b9       	R0 = [FP -0x34];
8d4e8092:	ff e3 a9 31 	CALL 0x0x8d4ce3e4;
8d4e8096:	dc 2f       	JUMP.S 0x0x8d4e804e;
8d4e8098:	ff e3 c0 fc 	CALL 0x0x8d4e7a18;
8d4e809c:	c2 2f       	JUMP.S 0x0x8d4e8020;
8d4e809e:	a0 b9       	R0 = [FP -0x18];
8d4e80a0:	ff e3 a2 31 	CALL 0x0x8d4ce3e4;
8d4e80a4:	b5 2f       	JUMP.S 0x0x8d4e800e;
8d4e80a6:	00 00       	NOP;
8d4e80a8:	61 61       	R1 = 0x2c (X);		/*		R1=0x44( 68) */
8d4e80aa:	08 50       	R0 = R0 + R1;
8d4e80ac:	81 60       	R1 = 0x10 (X);		/*		R1=0x44( 68) */
8d4e80ae:	03 c8 00 18 	MNOP || R2 = [FP -0x58] || R3 = [SP + 0x2c];
8d4e80b2:	a2 b8 f3 a2 
8d4e80b6:	11 0a       	CC = R1 <= R2 (IU);
8d4e80b8:	03 07       	IF CC R0 = R3;
8d4e80ba:	00 de 03 8c 	CALL.A 0x8c03e040;
8d4e80be:	40 e0 00 00 
8d4e80c2:	aa 2f       	JUMP.S 0x0x8d4e8016;
