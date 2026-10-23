
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d579ed0 <.data+0xadeb0>:
8d579ed0:	00 c2 f1 b0 	R3.L = R6.L * R1.L;
8d579ed4:	00 00       	NOP;
8d579ed6:	00 da bc 86 	R0=-2034451996;
8d579eda:	e4 b9 00 00 
8d579ede:	00 e3 f1 ed 	CALL 0x0x8d597ac0;
8d579ee2:	01 e8 00 00 	UNLINK;
8d579ee6:	10 00       	RTS;
8d579ee8:	08 32       	P1 = R0;
8d579eea:	00 e8 06 00 	LINK 0x18;		/* (24) */
8d579eee:	f5 05       	[--SP] = (R7:6, P5:5);
8d579ef0:	86 6f       	SP += -0x10;		/* (-16) */
8d579ef2:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
8d579ef4:	09 98       	R1 = B[P1++] (Z);
8d579ef6:	d1 54       	R3 = R1 & R2;
8d579ef8:	89 98       	R1 = B[P1--] (Z);
8d579efa:	09 0c       	CC = R1 == 0x1;
8d579efc:	8f e4 02 00 	R7 = B[P1 + 0x2] (Z);
8d579f00:	8c 18       	IF CC JUMP 0x0x8d57a018;
8d579f02:	26 e1 40 00 	R6 = 0x40 (X);		/*		R6=0x40( 64) */
8d579f06:	31 08       	CC = R1 == R6;
8d579f08:	80 18       	IF CC JUMP 0x0x8d57a008;
8d579f0a:	60 60       	R0 = 0xc (X);		/*		R0=0x0(  0) */
8d579f0c:	08 09       	CC = R0 <= R1;
8d579f0e:	04 10       	IF !CC JUMP 0x0x8d579f16;
8d579f10:	78 61       	R0 = 0x2f (X);		/*		R0=0x0(  0) */
8d579f12:	01 09       	CC = R1 <= R0;
8d579f14:	70 18       	IF CC JUMP 0x0x8d579ff4;
8d579f16:	4e 60       	R6 = 0x9 (X);		/*		R6=0x40( 64) */
8d579f18:	b1 09       	CC = R1 < R6 (IU);
8d579f1a:	00 da bc 86 	R0=-2034451996;
8d579f1e:	e4 b9 00 00 
8d579f22:	4f 18       	IF CC JUMP 0x0x8d579fc0;
8d579f24:	31 08       	CC = R1 == R6;
8d579f26:	3c 18       	IF CC JUMP 0x0x8d579f9e;
8d579f28:	56 60       	R6 = 0xa (X);		/*		R6=0x40( 64) */
8d579f2a:	31 08       	CC = R1 == R6;
8d579f2c:	22 18       	IF CC JUMP 0x0x8d579f70;
8d579f2e:	20 e1 b0 ff 	R0 = -0x50 (X);		/*		R0=0xffffffb0(-80) */
8d579f32:	01 50       	R0 = R1 + R0;
8d579f34:	e1 60       	R1 = 0x1c (X);		/*		R1=0x0(  0) */
8d579f36:	88 09       	CC = R0 < R1 (IU);
8d579f38:	2e 10       	IF !CC JUMP 0x0x8d579f94;
8d579f3a:	08 32       	P1 = R0;
8d579f3c:	0a da 09 84 	P2=-2079728780;
8d579f40:	74 db 00 00 
8d579f44:	08 da 09 84 	P0=-2079728868;
8d579f48:	1c db 00 00 
8d579f4c:	0d da 00 84 	P5=-2080330340;
8d579f50:	9c ad 00 00 
8d579f54:	82 c6 0f 80 	R0 = R7 << 0x1;
8d579f58:	4a 5e       	P1 = P2 + (P1 << 0x2);
8d579f5a:	49 91       	P1 = [P1];
8d579f5c:	21 e1 dc 00 	R1 = 0xdc (X);		/*		R1=0xdc(220) */
8d579f60:	0a da 09 84 	P2=-2079728796;
8d579f64:	64 db 00 00 
8d579f68:	03 0c       	CC = R3 == 0x0;
8d579f6a:	51 00       	JUMP (P1);
8d579f6c:	00 00       	NOP;
8d579f6e:	00 00       	NOP;
8d579f70:	01 da 02 01 	R1=16909320;
8d579f74:	08 04 00 00 
8d579f78:	f9 40       	R1 *= R7;
8d579f7a:	82 c6 e7 05 	R2 = R7 >>> 0x4;
8d579f7e:	51 50       	R1 = R1 + R2;
8d579f80:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d579f82:	07 c4 0a 02 	R1 = MAX (R1, R2);
8d579f86:	82 ce 03 c2 	R1 = ROT R3 BY 0x0 || [SP + 0xc] = R1 || NOP;
8d579f8a:	f1 b0 00 00 
8d579f8e:	42 61       	R2 = 0x28 (X);		/*		R2=0x0(  0) */
8d579f90:	00 e3 98 ed 	CALL 0x0x8d597ac0;
8d579f94:	86 6c       	SP += 0x10;		/* ( 16) */
8d579f96:	b5 05       	(R7:6, P5:5) = [SP++];
8d579f98:	01 e8 00 00 	UNLINK;
8d579f9c:	10 00       	RTS;
8d579f9e:	07 0d       	CC = R7 <= 0x0;
8d579fa0:	18 02       	CC = !CC;
8d579fa2:	00 02       	R0 = CC;
8d579fa4:	82 c6 08 84 	R2 = R0 << 0x1;
8d579fa8:	0b 30       	R1 = R3;
8d579faa:	00 da 0c 86 	R0=-2046028680;
8d579fae:	78 14 00 00 
8d579fb2:	00 e3 21 26 	CALL 0x0x8d57ebf4;
8d579fb6:	86 6c       	SP += 0x10;		/* ( 16) */
8d579fb8:	b5 05       	(R7:6, P5:5) = [SP++];
8d579fba:	01 e8 00 00 	UNLINK;
8d579fbe:	10 00       	RTS;
8d579fc0:	3a 60       	R2 = 0x7 (X);		/*		R2=0x0(  0) */
8d579fc2:	11 08       	CC = R1 == R2;
8d579fc4:	e8 17       	IF !CC JUMP 0x0x8d579f94 (BP);
8d579fc6:	01 da 02 01 	R1=16909320;
8d579fca:	08 04 00 00 
8d579fce:	f9 40       	R1 *= R7;
8d579fd0:	82 c6 e7 05 	R2 = R7 >>> 0x4;
8d579fd4:	51 50       	R1 = R1 + R2;
8d579fd6:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d579fd8:	07 c4 0a 02 	R1 = MAX (R1, R2);
8d579fdc:	82 ce 03 c2 	R1 = ROT R3 BY 0x0 || [SP + 0xc] = R1 || NOP;
8d579fe0:	f1 b0 00 00 
8d579fe4:	4a 61       	R2 = 0x29 (X);		/*		R2=0x0(  0) */
8d579fe6:	00 e3 6d ed 	CALL 0x0x8d597ac0;
8d579fea:	86 6c       	SP += 0x10;		/* ( 16) */
8d579fec:	b5 05       	(R7:6, P5:5) = [SP++];
8d579fee:	01 e8 00 00 	UNLINK;
8d579ff2:	10 00       	RTS;
8d579ff4:	17 30       	R2 = R7;
8d579ff6:	03 30       	R0 = R3;
8d579ff8:	ff e3 db fe 	CALL 0x0x8d579dae;
8d579ffc:	86 6c       	SP += 0x10;		/* ( 16) */
8d579ffe:	b5 05       	(R7:6, P5:5) = [SP++];
8d57a000:	01 e8 00 00 	UNLINK;
8d57a004:	10 00       	RTS;
8d57a006:	00 00       	NOP;
8d57a008:	ff e3 bc fe 	CALL 0x0x8d579d80;
8d57a00c:	86 6c       	SP += 0x10;		/* ( 16) */
8d57a00e:	b5 05       	(R7:6, P5:5) = [SP++];
8d57a010:	01 e8 00 00 	UNLINK;
8d57a014:	10 00       	RTS;
8d57a016:	00 00       	NOP;
8d57a018:	ff e3   	CALL 0x0x8d579d50;
