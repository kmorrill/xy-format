
os.ldr@0x8d581c88:     file format binary


Disassembly of section .data:

8d581c88 <.data>:
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
8d581cfc:	bc 05       	(R7:7, P5:4) = [SP++];
8d581cfe:	01 e8 00 00 	UNLINK;
8d581d02:	10 00       	RTS;
8d581d04:	00 00       	NOP;
8d581d06:	00 00       	NOP;
8d581d08:	00 da 09 84 	R0=-2079726736;
8d581d0c:	70 e3 00 00 
8d581d10:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d581d14:	a4 05 00 00 
8d581d18:	d4 2f       	JUMP.S 0x0x8d581cc0;
8d581d1a:	25 6c       	P5 += 0x4;		/* (  4) */
8d581d1c:	38 30       	R7 = R0;
8d581d1e:	21 e5 20 00 	P1 = [P4 + 0x80];
8d581d22:	e9 2f       	JUMP.S 0x0x8d581cf4;
8d581d24:	00 00       	NOP;
8d581d26:	00 00       	NOP;
8d581d28:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d581d2c:	f3 05       	[--SP] = (R7:6, P5:3);
8d581d2e:	18 32       	P3 = R0;
8d581d30:	a6 6f       	SP += -0xc;		/* (-12) */
8d581d32:	38 30       	R7 = R0;
8d581d34:	32 30       	R6 = R2;
8d581d36:	24 68       	P4 = 0x4 (X);		/*		P4=0x0(  0) */
8d581d38:	18 e4 20 00 	R0 = [P3 + 0x80];
8d581d3c:	00 0c       	CC = R0 == 0x0;
8d581d3e:	10 32       	P2 = R0;
8d581d40:	5f 18       	IF CC JUMP 0x0x8d581dfe;
8d581d42:	8e 08       	CC = R6 < R1;
8d581d44:	5d 18       	IF CC JUMP 0x0x8d581dfe;
8d581d46:	50 44       	P0 = P2 << 0x2;
8d581d48:	48 32       	P1 = P0;
8d581d4a:	f8 6f       	P0 += -0x1;		/* ( -1) */
8d581d4c:	c5 44       	P5 = P0 >> 0x2;
8d581d4e:	61 08       	CC = P1 == P4;
8d581d50:	4b 32       	P1 = P3;
8d581d52:	08 18       	IF CC JUMP 0x0x8d581d62;
8d581d54:	43 32       	P0 = P3;
8d581d56:	a2 e0 04 50 	LSETUP(0x8d581d5a, 0x8d581d5e) LC0 = P5;
8d581d5a:	20 86       	R0 = W[P0 ++ P4] (Z);
8d581d5c:	88 08       	CC = R0 < R1;
8d581d5e:	5d 10       	IF !CC JUMP 0x0x8d581e18;
8d581d60:	48 32       	P1 = P0;
8d581d62:	08 95       	R0 = W[P1] (Z);
8d581d64:	88 08       	CC = R0 < R1;
8d581d66:	41 32       	P0 = P1;
8d581d68:	21 6c       	P1 += 0x4;		/* (  4) */
8d581d6a:	02 18       	IF CC JUMP 0x0x8d581d6e;
8d581d6c:	48 32       	P1 = P0;
8d581d6e:	28 e1 80 ff 	P0 = -0x80 (X);		/*		P0=0xffffff80(-128) */
8d581d72:	18 44       	P0 -= P3;
8d581d74:	61 32       	P4 = P1;
8d581d76:	60 5b       	P5 = P0 + P4;
8d581d78:	19 44       	P1 -= P3;
8d581d7a:	04 cc 00 40 	R0 = R0 - R0 (NS) || [SP + 0x28] = P5 || NOP;
8d581d7e:	b5 be 00 00 
8d581d82:	4b 5b       	P5 = P3 + P1;
8d581d84:	b1 ae       	P1 = [SP + 0x28];
8d581d86:	00 68       	P0 = 0x0 (X);		/*		P0=0xffffff80(-128) */
8d581d88:	08 44       	P0 -= P1;
8d581d8a:	f0 be       	[SP + 0x2c] = P0;
8d581d8c:	53 5e       	P1 = P3 + (P2 << 0x2);
8d581d8e:	f0 ae       	P0 = [SP + 0x2c];
8d581d90:	4c 08       	CC = P4 == P1;
8d581d92:	34 18       	IF CC JUMP 0x0x8d581dfa;
8d581d94:	45 86       	R1 = W[P5 ++ P0] (Z);
8d581d96:	8e 08       	CC = R6 < R1;
8d581d98:	31 18       	IF CC JUMP 0x0x8d581dfa;
8d581d9a:	63 0a       	CC = P3 <= P4 (IU);
8d581d9c:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d581d9e:	03 10       	IF !CC JUMP 0x0x8d581da4;
8d581da0:	cc 09       	CC = P4 < P1 (IU);
8d581da2:	00 02       	R0 = CC;
8d581da4:	00 0c       	CC = R0 == 0x0;
8d581da6:	21 18       	IF CC JUMP 0x0x8d581de8;
8d581da8:	69 91       	P1 = [P5];
8d581daa:	4b 5e       	P1 = P3 + (P1 << 0x2);
8d581dac:	e1 6f       	P1 += -0x4;		/* ( -4) */
8d581dae:	cc 09       	CC = P4 < P1 (IU);
8d581db0:	10 10       	IF !CC JUMP 0x0x8d581dd0;
8d581db2:	4c 32       	P1 = P4;
8d581db4:	c0 e0 0b 00 	LSETUP_IMM(bottom=0x8d581dca) LC0 count_fields=0x0/0x0;
8d581db8:	48 a0       	R0 = [P1 + 0x4];
8d581dba:	08 96       	W[P1++] = R0;
8d581dbc:	88 a4       	R0 = W[P1 + 0x4] (Z);
8d581dbe:	08 96       	W[P1++] = R0;
8d581dc0:	18 e5 20 00 	P0 = [P3 + 0x80];
8d581dc4:	03 5e       	P0 = P3 + (P0 << 0x2);
8d581dc6:	e0 6f       	P0 += -0x4;		/* ( -4) */
8d581dc8:	c1 09       	CC = P1 < P0 (IU);
8d581dca:	03 10       	IF !CC JUMP 0x0x8d581dd0;
8d581dcc:	f4 2f       	JUMP.S 0x0x8d581db4;
8d581dce:	00 00       	NOP;
8d581dd0:	03 c8 00 18 	MNOP || P1 = [SP + 0x28] || R1 = [P5];
8d581dd4:	b1 ae 29 91 
8d581dd8:	f9 67       	R1 += -0x1;		/* ( -1) */
8d581dda:	11 32       	P2 = R1;
8d581ddc:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d581dde:	4d 88       	[P5 ++ P1] = R1;
8d581de0:	d6 2f       	JUMP.S 0x0x8d581d8c;
8d581de2:	00 00       	NOP;
8d581de4:	00 00       	NOP;
8d581de6:	00 00       	NOP;
8d581de8:	00 da 09 84 	R0=-2079726736;
8d581dec:	70 e3 00 00 
8d581df0:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d581df4:	a4 05 00 00 
8d581df8:	d8 2f       	JUMP.S 0x0x8d581da8;
8d581dfa:	00 0c       	CC = R0 == 0x0;
8d581dfc:	06 10       	IF !CC JUMP 0x0x8d581e08;
8d581dfe:	66 6c       	SP += 0xc;		/* ( 12) */
8d581e00:	b3 05       	(R7:6, P5:3) = [SP++];
8d581e02:	01 e8 00 00 	UNLINK;
8d581e06:	10 00       	RTS;
