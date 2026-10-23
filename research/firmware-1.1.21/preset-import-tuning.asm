
os.ldr@0x8d5a9ef0:     file format binary


Disassembly of section .data:

8d5a9ef0 <.data>:
8d5a9ef0:	f1 bc       	[SP + 0xc] = P1;
8d5a9ef2:	42 64       	R2 += 0x8;		/* (  8) */
8d5a9ef4:	81 61       	R1 = 0x30 (X);		/*		R1=0x0(  0) */
8d5a9ef6:	00 de 04 8c 	CALL.A 0x8c0499a8;
8d5a9efa:	a8 99 00 00 
8d5a9efe:	f0 b9       	R0 = [FP -0x4];
8d5a9f00:	07 0a       	CC = R7 <= R0 (IU);
8d5a9f02:	06 18       	IF CC JUMP 0x0x8d5a9f0e;
8d5a9f04:	f6 bb       	[FP -0x4] = R6;
8d5a9f06:	e5 bb       	[FP -0x8] = R5;
8d5a9f08:	b5 e6 40 00 	B[SP + 0x40] = R5;
8d5a9f0c:	b5 2f       	JUMP.S 0x0x8d5a9e76;
8d5a9f0e:	a0 b9       	R0 = [FP -0x18];
8d5a9f10:	f9 e3 6a 22 	CALL 0x0x8d4ce3e4;
8d5a9f14:	f8 2f       	JUMP.S 0x0x8d5a9f04;
8d5a9f16:	00 00       	NOP;
8d5a9f18:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a9f1c:	70 05       	[--SP] = (R7:6);
8d5a9f1e:	a6 6f       	SP += -0xc;		/* (-12) */
8d5a9f20:	38 30       	R7 = R0;
8d5a9f22:	00 de 01 04 	CALL.A 0x040175a4;
8d5a9f26:	a4 75 00 00 
8d5a9f2a:	00 de 02 04 	CALL.A 0x04020fd8;
8d5a9f2e:	d8 0f 00 00 
8d5a9f32:	86 42       	R6 = R0.L (X);
8d5a9f34:	06 30       	R0 = R6;
8d5a9f36:	00 de 02 04 	CALL.A 0x04021854;
8d5a9f3a:	54 18 00 00 
8d5a9f3e:	08 30       	R1 = R0;
8d5a9f40:	07 30       	R0 = R7;
8d5a9f42:	00 de 02 04 	CALL.A 0x040218e0;
8d5a9f46:	e0 18 00 00 
8d5a9f4a:	01 da a3 3b 	R1=1000593162;
8d5a9f4e:	0a d7 00 00 
8d5a9f52:	00 de 02 04 	CALL.A 0x040218e2;
8d5a9f56:	e2 18 00 00 
8d5a9f5a:	01 da c8 42 	R1=1120403456;
8d5a9f5e:	00 00 00 00 
8d5a9f62:	00 de 02 04 	CALL.A 0x04021ac0;
8d5a9f66:	c0 1a 00 00 
8d5a9f6a:	00 de 02 04 	CALL.A 0x04020fd8;
8d5a9f6e:	d8 0f 00 00 
8d5a9f72:	82 c6 86 8e 	R7 = R6 << 0x10;
8d5a9f76:	c0 42       	R0 = R0.L (Z);
8d5a9f78:	66 6c       	SP += 0xc;		/* ( 12) */
8d5a9f7a:	07 56       	R0 = R7 | R0;
8d5a9f7c:	30 05       	(R7:6) = [SP++];
8d5a9f7e:	01 e8 00 00 	UNLINK;
8d5a9f82:	10 00       	RTS;
8d5a9f84:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a9f88:	f5 05       	[--SP] = (R7:6, P5:5);
8d5a9f8a:	08 32       	P1 = R0;
8d5a9f8c:	86 6f       	SP += -0x10;		/* (-16) */
8d5a9f8e:	0d da 0a 84 	P5=-2079687736;
8d5a9f92:	c8 7b 00 00 
8d5a9f96:	06 61       	R6 = 0x20 (X);		/*		R6=0x0(  0) */
8d5a9f98:	48 60       	R0 = 0x9 (X);		/*		R0=0x0(  0) */
8d5a9f9a:	c0 e0 05 00 	LSETUP_IMM(bottom=0x8d5a9fa4) LC0 count_fields=0x0/0x0;
8d5a9f9e:	49 98       	R1 = B[P1++] (X);
8d5a9fa0:	31 08       	CC = R1 == R6;
8d5a9fa2:	03 10       	IF !CC JUMP 0x0x8d5a9fa8;
8d5a9fa4:	00 00       	NOP;
8d5a9fa6:	fa 2f       	JUMP.S 0x0x8d5a9f9a;
8d5a9fa8:	01 08       	CC = R1 == R0;
8d5a9faa:	fd 1f       	IF CC JUMP 0x0x8d5a9fa4 (BP);
8d5a9fac:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d5a9fae:	49 30       	R1 = P1;
8d5a9fb0:	7d 30       	R7 = P5;
8d5a9fb2:	07 30       	R0 = R7;
8d5a9fb4:	42 61       	R2 = 0x28 (X);		/*		R2=0x0(  0) */
8d5a9fb6:	00 de 02 04 	CALL.A 0x040232e4;
8d5a9fba:	e4 32 00 00 
8d5a9fbe:	4d 32       	P1 = P5;
8d5a9fc0:	08 98       	R0 = B[P1++] (Z);
8d5a9fc2:	00 0c       	CC = R0 == 0x0;
8d5a9fc4:	fe 17       	IF !CC JUMP 0x0x8d5a9fc0 (BP);
8d5a9fc6:	29 44       	P1 -= P5;
8d5a9fc8:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d5a9fca:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d5a9fcc:	4d 5a       	P1 = P5 + P1;
8d5a9fce:	48 99       	R0 = B[P1] (X);
8d5a9fd0:	30 08       	CC = R0 == R6;
8d5a9fd2:	1f 10       	IF !CC JUMP 0x0x8d5aa010;
8d5a9fd4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a9fd6:	c0 e0 1b 00 	LSETUP_IMM(bottom=0x8d5aa00c) LC0 count_fields=0x0/0x0;
8d5a9fda:	09 da 0a 84 	P1=-2079687736;
8d5a9fde:	c8 7b 00 00 
8d5a9fe2:	09 98       	R1 = B[P1++] (Z);
8d5a9fe4:	01 0c       	CC = R1 == 0x0;
8d5a9fe6:	fe 17       	IF !CC JUMP 0x0x8d5a9fe2 (BP);
8d5a9fe8:	29 44       	P1 -= P5;
8d5a9fea:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d5a9fec:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d5a9fee:	4d 5a       	P1 = P5 + P1;
8d5a9ff0:	08 9b       	B[P1] = R0;
8d5a9ff2:	09 da 0a 84 	P1=-2079687736;
8d5a9ff6:	c8 7b 00 00 
8d5a9ffa:	09 98       	R1 = B[P1++] (Z);
8d5a9ffc:	01 0c       	CC = R1 == 0x0;
8d5a9ffe:	fe 17       	IF !CC JUMP 0x0x8d5a9ffa (BP);
8d5aa000:	29 44       	P1 -= P5;
8d5aa002:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d5aa004:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d5aa006:	4d 5a       	P1 = P5 + P1;
8d5aa008:	49 99       	R1 = B[P1] (X);
8d5aa00a:	31 08       	CC = R1 == R6;
8d5aa00c:	02 10       	IF !CC JUMP 0x0x8d5aa010;
8d5aa00e:	e4 2f       	JUMP.S 0x0x8d5a9fd6;
8d5aa010:	69 99       	R1 = B[P5] (X);
8d5aa012:	00 da 0a 84 	R0=-2079687736;
8d5aa016:	c8 7b 00 00 
8d5aa01a:	6a 61       	R2 = 0x2d (X);		/*		R2=0x0(  0) */
8d5aa01c:	11 08       	CC = R1 == R2;
8d5aa01e:	08 64       	R0 += 0x1;		/* (  1) */
8d5aa020:	38 07       	IF CC R7 = R0;
8d5aa022:	07 30       	R0 = R7;
8d5aa024:	71 61       	R1 = 0x2e (X);		/*		R1=0x0(  0) */
8d5aa026:	06 02       	R6 = CC;
8d5aa028:	00 de 02 04 	CALL.A 0x0402319c;
8d5aa02c:	9c 31 00 00 
8d5aa030:	00 0c       	CC = R0 == 0x0;
8d5aa032:	1f 18       	IF CC JUMP 0x0x8d5aa070;
8d5aa034:	06 0c       	CC = R6 == 0x0;
8d5aa036:	0a 18       	IF CC JUMP 0x0x8d5aa04a;
8d5aa038:	07 30       	R0 = R7;
8d5aa03a:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5aa03c:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d5aa03e:	00 de ed 8f 	CALL.A 0x8fed3e04;
8d5aa042:	04 3e 00 00 
8d5aa046:	f8 4b       	BITTGL (R0, 0x1f);		/* bit 31 */
8d5aa048:	08 20       	JUMP.S 0x0x8d5aa058;
8d5aa04a:	07 30       	R0 = R7;
8d5aa04c:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5aa04e:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d5aa050:	00 de ed 8f 	CALL.A 0x8fed3e04;
8d5aa054:	04 3e 00 00 
8d5aa058:	ff e3 60 ff 	CALL 0x0x8d5a9f18;
8d5aa05c:	86 6c       	SP += 0x10;		/* ( 16) */
8d5aa05e:	b5 05       	(R7:6, P5:5) = [SP++];
8d5aa060:	01 e8 00 00 	UNLINK;
8d5aa064:	10 00       	RTS;
8d5aa066:	86 6c       	SP += 0x10;		/* ( 16) */
8d5aa068:	b5 05       	(R7:6, P5:5) = [SP++];
8d5aa06a:	01 e8 00 00 	UNLINK;
8d5aa06e:	10 00       	RTS;
8d5aa070:	06 0c       	CC = R6 == 0x0;
8d5aa072:	fa 17       	IF !CC JUMP 0x0x8d5aa066 (BP);
8d5aa074:	07 30       	R0 = R7;
8d5aa076:	79 61       	R1 = 0x2f (X);		/*		R1=0x0(  0) */
8d5aa078:	00 de 02 04 	CALL.A 0x0402319c;
8d5aa07c:	9c 31 00 00 
