
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d582ed4 <.data+0xb6eb4>:
8d582ed4:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d582ed8:	e4 05       	[--SP] = (R7:4, P5:4);
8d582eda:	28 32       	P5 = R0;
8d582edc:	30 30       	R6 = R0;
8d582ede:	02 30       	R0 = R2;
8d582ee0:	20 32       	P4 = R0;
8d582ee2:	46 6f       	SP += -0x18;		/* (-24) */
8d582ee4:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || R4 = [FP + 0x18] || R5 = [FP + 0x20];
8d582ee8:	bc a1 3d a2 
8d582eec:	01 e3 4a 2d 	CALL 0x0x8d5a8980;
8d582ef0:	f9 a1       	R1 = [FP + 0x1c];
8d582ef2:	a1 b0       	[P4 + 0x8] = R1;
8d582ef4:	21 b1       	[P4 + 0x10] = R1;
8d582ef6:	a8 e4 30 3e 	R0 = B[P5 + 0x3e30] (Z);
8d582efa:	00 0c       	CC = R0 == 0x0;
8d582efc:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d582efe:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d582f00:	05 10       	IF !CC JUMP 0x0x8d582f0a;
8d582f02:	a8 e4 2f 3e 	R0 = B[P5 + 0x3e2f] (Z);
8d582f06:	00 0c       	CC = R0 == 0x0;
8d582f08:	10 02       	ILLEGAL;
8d582f0a:	00 0c       	CC = R0 == 0x0;
8d582f0c:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d582f0e:	0c 18       	IF CC JUMP 0x0x8d582f26;
8d582f10:	a8 e4 2d 3e 	R0 = B[P5 + 0x3e2d] (Z);
8d582f14:	00 0c       	CC = R0 == 0x0;
8d582f16:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d582f18:	05 10       	IF !CC JUMP 0x0x8d582f22;
8d582f1a:	a8 e4 2e 3e 	R0 = B[P5 + 0x3e2e] (Z);
8d582f1e:	00 0c       	CC = R0 == 0x0;
8d582f20:	10 02       	ILLEGAL;
8d582f22:	00 0c       	CC = R0 == 0x0;
8d582f24:	10 02       	ILLEGAL;
8d582f26:	00 0c       	CC = R0 == 0x0;
8d582f28:	0e 10       	IF !CC JUMP 0x0x8d582f44;
8d582f2a:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = R5 || NOP;
8d582f2e:	f5 b0 00 00 
8d582f32:	06 30       	R0 = R6;
8d582f34:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d582f36:	ff e3 15 fe 	CALL 0x0x8d582b60;
8d582f3a:	c6 6c       	SP += 0x18;		/* ( 24) */
8d582f3c:	a4 05       	(R7:4, P5:4) = [SP++];
8d582f3e:	01 e8 00 00 	UNLINK;
8d582f42:	10 00       	RTS;
8d582f44:	a2 e6 18 00 	B[P4 + 0x18] = R2;
8d582f48:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [P4 + 0x14] || [SP + 0x10] = R1;
8d582f4c:	60 a1 31 b1 
8d582f50:	70 b1       	[SP + 0x14] = R0;
8d582f52:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [SP + 0xc] = R4 || R2 = [FP + 0x14];
8d582f56:	f4 b0 7a a1 
8d582f5a:	ff e3 0f f9 	CALL 0x0x8d582178;
8d582f5e:	64 b1       	[P4 + 0x14] = R4;
8d582f60:	e5 2f       	JUMP.S 0x0x8d582f2a;
8d582f62:	00 00       	NOP;
8d582f64:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d582f68:	e5 05       	[--SP] = (R7:4, P5:5);
8d582f6a:	30 30       	R6 = R0;
8d582f6c:	02 0c       	CC = R2 == 0x0;
8d582f6e:	2a 30       	R5 = R2;
8d582f70:	23 e1 ff 00 	R3 = 0xff (X);		/*		R3=0xff(255) */
8d582f74:	26 6f       	SP += -0x1c;		/* (-28) */
8d582f76:	01 30       	R0 = R1;
8d582f78:	39 30       	R7 = R1;
8d582f7a:	2b 06       	IF !CC R5 = R3;
8d582f7c:	22 30       	R4 = R2;
8d582f7e:	ff e3 d7 75 	CALL 0x0x8d571b2c;
8d582f82:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0x38] = R0 || NOP;
8d582f86:	b0 b3 00 00 
8d582f8a:	06 30       	R0 = R6;
8d582f8c:	ff e3 7c d9 	CALL 0x0x8d57e284;
8d582f90:	e2 60       	R2 = 0x1c (X);		/*		R2=0x0(  0) */
8d582f92:	03 c8 00 18 	MNOP || [SP + 0x10] = R0 || R1 = [SP + 0x38];
8d582f96:	30 b1 b1 a3 
8d582f9a:	20 e1 10 53 	R0 = 0x5310 (X);		/*		R0=0x5310(21264) */
8d582f9e:	23 e1 f8 43 	R3 = 0x43f8 (X);		/*		R3=0x43f8(17400) */
8d582fa2:	04 cc 08 02 	R1 = R1 + R0 (NS) || [SP + 0x14] = R5 || R5 = [FP + 0x14];
8d582fa6:	75 b1 7d a1 
8d582faa:	04 cc 33 06 	R3 = R6 + R3 (NS) || [SP + 0xc] = R1 || NOP;
8d582fae:	f1 b0 00 00 
8d582fb2:	08 cb ba 20 	R2 = R7.L * R2.L (IS) || [SP + 0x18] = R5 || NOP;
8d582fb6:	b5 b1 00 00 
8d582fba:	93 50       	R2 = R3 + R2;
8d582fbc:	06 30       	R0 = R6;
8d582fbe:	0f 30       	R1 = R7;
8d582fc0:	ff e3 8a ff 	CALL 0x0x8d582ed4;
8d582fc4:	07 30       	R0 = R7;
8d582fc6:	ff e3 51 76 	CALL 0x0x8d571c68;
8d582fca:	00 0c       	CC = R0 == 0x0;
8d582fcc:	0d 18       	IF CC JUMP 0x0x8d582fe6;
8d582fce:	04 0c       	CC = R4 == 0x0;
8d582fd0:	21 10       	IF !CC JUMP 0x0x8d583012;
8d582fd2:	20 e1 b8 45 	R0 = 0x45b8 (X);		/*		R0=0x45b8(17848) */
8d582fd6:	06 50       	R0 = R6 + R0;
8d582fd8:	38 50       	R0 = R0 + R7;
8d582fda:	28 32       	P5 = R0;
8d582fdc:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d582fde:	19 60       	R1 = 0x3 (X);		/*		R1=0x0(  0) */
8d582fe0:	28 99       	R0 = B[P5] (Z);
8d582fe2:	00 0c       	CC = R0 == 0x0;
8d582fe4:	11 10       	IF !CC JUMP 0x0x8d583006;
8d582fe6:	04 0c       	CC = R4 == 0x0;
8d582fe8:	06 18       	IF CC JUMP 0x0x8d582ff4;
8d582fea:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d582fec:	a5 05       	(R7:4, P5:5) = [SP++];
8d582fee:	01 e8 00 00 	UNLINK;
8d582ff2:	10 00       	RTS;
8d582ff4:	0f 30       	R1 = R7;
8d582ff6:	06 30       	R0 = R6;
8d582ff8:	ff e3 90 e9 	CALL 0x0x8d580318;
8d582ffc:	e6 6c       	SP += 0x1c;		/* ( 28) */
8d582ffe:	a5 05       	(R7:4, P5:5) = [SP++];
8d583000:	01 e8 00 00 	UNLINK;
8d583004:	10 00       	RTS;
8d583006:	07 30       	R0 = R7;
8d583008:	ff e3 c2 77 	CALL 0x0x8d571f8c;
8d58300c:	00 60       	R0 = 0x0 (X);		/*		R0=0x45b8(17848) */
8d58300e:	28 9b       	B[P5] = R0;
8d583010:	eb 2f       	JUMP.S 0x0x8d582fe6;
8d583012:	07 30       	R0 = R7;
8d583014:	ff e3 92 44 	CALL 0x0x8d56b938;
8d583018:	00 0c       	CC = R0 == 0x0;
8d58301a:	e6 17       	IF !CC JUMP 0x0x8d582fe6 (BP);
8d58301c:	20 e1 b8 45 	R0 = 0x45b8 (X);		/*		R0=0x45b8(17848) */
8d583020:	06 50       	R0 = R6 + R0;
8d583022:	38 50       	R0 = R0 + R7;
8d583024:	28 32       	P5 = R0;
8d583026:	07 30       	R0 = R7;
8d583028:	02 da ff 7f 	R2=2147483647;
8d58302c:	ff ff 00 00 
8d583030:	19 60       	R1 = 0x3 (X);		/*		R1=0x0(  0) */
8d583032:	ff e3 ad 77 	CALL 0x0x8d571f8c;
8d583036:	08 60       	R0 = 0x1 (X);		/*		R0=0x45b8(17848) */
8d583038:	28 9b       	B[P5] = R0;
8d58303a:	d6 2f       	JUMP.S 0x0x8d582fe6;
