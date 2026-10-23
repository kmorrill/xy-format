
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d591de0.bin:     file format binary


Disassembly of section .data:

8d594f78 <.data+0x3198>:
8d594f78:	4f 30       	R1 = FP;
8d594f7a:	41 64       	R1 += 0x8;		/* (  8) */
8d594f7c:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || R0 = [FP + 0xc] || NOP;
8d594f80:	f8 a0 00 00 
8d594f84:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d594f86:	ff e3 43 3b 	CALL 0x0x8d57c60c;
8d594f8a:	fe 63       	R6 = -0x1 (X);		/*		R6=0x0(  0) */
8d594f8c:	29 e1 82 f8 	P1 = -0x77e (X);		/*		P1=0xfffff882(-1918) */
8d594f90:	67 e6 7e 26 	W[P4 + 0x4cfc] = R7;
8d594f94:	67 e6 81 26 	W[P4 + 0x4d02] = R7;
8d594f98:	66 e6 7f 26 	W[P4 + 0x4cfe] = R6;
8d594f9c:	66 e6 80 26 	W[P4 + 0x4d00] = R6;
8d594fa0:	4d 5a       	P1 = P5 + P1;
8d594fa2:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d594fa4:	80 68       	P0 = 0x10 (X);		/*		P0=0x0(  0) */
8d594fa6:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d594fa8:	c1 e0 02 d8 	LSETUP_IMM(bottom=0x8d594fac) LC0 count_fields=0x1/0x36;
8d594fac:	04 cc 01 00 	R0 = R0 + R1 (NS) || W[P1 ++ P0] = R0.L || NOP;
8d594fb0:	01 8a 00 00 
8d594fb4:	01 8a       	W[P1 ++ P0] = R0.L;
8d594fb6:	0e b4       	W[P1 + 0x0] = R6;
8d594fb8:	b0 e4 44 00 	R0 = B[SP + 0x44] (Z);
8d594fbc:	00 0d       	CC = R0 <= 0x0;
8d594fbe:	55 18       	IF CC JUMP 0x0x8d595068;
8d594fc0:	4d 32       	P1 = P5;
8d594fc2:	15 6c       	P5 += 0x2;		/* (  2) */
8d594fc4:	28 e1 80 f8 	P0 = -0x780 (X);		/*		P0=0xfffff880(-1920) */
8d594fc8:	b5 be       	[SP + 0x28] = P5;
8d594fca:	41 5b       	P5 = P1 + P0;
8d594fcc:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d594fce:	67 30       	R4 = FP;
8d594fd0:	a4 67       	R4 += -0xc;		/* (-12) */
8d594fd2:	b5 e6 38 00 	B[SP + 0x38] = R5;
8d594fd6:	b5 e6 39 00 	B[SP + 0x39] = R5;
8d594fda:	b5 e6 3a 00 	B[SP + 0x3a] = R5;
8d594fde:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || [SP + 0x30] = R5 || R1 = [FP + 0xc];
8d594fe2:	35 b3 f9 a0 
8d594fe6:	75 b3       	[SP + 0x34] = R5;
8d594fe8:	ff e3 53 fe 	CALL 0x0x8d594c8e;
8d594fec:	3d bd       	[FP + 0x10] = P5;
8d594fee:	61 e5 81 26 	R1 = W[P4 + 0x4d02] (X);
8d594ff2:	22 e1 78 00 	R2 = 0x78 (X);		/*		R2=0x78(120) */
8d594ff6:	91 08       	CC = R1 < R2;
8d594ff8:	8c 10       	IF !CC JUMP 0x0x8d595110;
8d594ffa:	60 e5 7e 26 	R0 = W[P4 + 0x4cfc] (X);
8d594ffe:	82 ce 20 80 	R0 = R0 << 0x4 || R3 = [FP + 0x10] || NOP;
8d595002:	3b a1 00 00 
8d595006:	03 50       	R0 = R3 + R0;
8d595008:	0c 30       	R1 = R4;
8d59500a:	20 64       	R0 += 0x4;		/* (  4) */
8d59500c:	5a 60       	R2 = 0xb (X);		/*		R2=0x78(120) */
8d59500e:	00 de 02 04 	CALL.A 0x040230c4;
8d595012:	c4 30 00 00 
8d595016:	64 e5 7e 26 	R4 = W[P4 + 0x4cfc] (X);
8d59501a:	82 c6 24 80 	R0 = R4 << 0x4;
8d59501e:	08 32       	P1 = R0;
8d595020:	61 e5 81 26 	R1 = W[P4 + 0x4d02] (X);
8d595024:	22 e1 78 00 	R2 = 0x78 (X);		/*		R2=0x78(120) */
8d595028:	09 64       	R1 += 0x1;		/* (  1) */
8d59502a:	61 e6 81 26 	W[P4 + 0x4d02] = R1;
8d59502e:	cd 5a       	P3 = P5 + P1;
8d595030:	58 a8       	R0 = W[P3 + 0x2] (X);
8d595032:	90 08       	CC = R0 < R2;
8d595034:	60 e6 7e 26 	W[P4 + 0x4cfc] = R0;
8d595038:	60 10       	IF !CC JUMP 0x0x8d5950f8;
8d59503a:	61 e5 80 26 	R1 = W[P4 + 0x4d00] (X);
8d59503e:	82 ce 21 80 	R0 = R1 << 0x4 || P0 = [SP + 0x28] || W[P3 + 0x2] = R6;
8d595042:	b0 ae 5e b4 
8d595046:	08 32       	P1 = R0;
8d595048:	39 0c       	CC = R1 == -0x1;
8d59504a:	5b 8a       	W[P3] = R1.L;
8d59504c:	0f 64       	R7 += 0x1;		/* (  1) */
8d59504e:	4d 5a       	P1 = P5 + P1;
8d595050:	11 6c       	P1 += 0x2;		/* (  2) */
8d595052:	c8 07       	IF CC P1 = P0;
8d595054:	09 8b       	W[P1] = R4.L;
8d595056:	58 a8       	R0 = W[P3 + 0x2] (X);
8d595058:	04 08       	CC = R4 == R0;
8d59505a:	64 e6 80 26 	W[P4 + 0x4d00] = R4;
8d59505e:	41 18       	IF CC JUMP 0x0x8d5950e0;
8d595060:	b0 e4 44 00 	R0 = B[SP + 0x44] (Z);
8d595064:	87 08       	CC = R7 < R0;
8d595066:	b4 1f       	IF CC JUMP 0x0x8d594fce (BP);
8d595068:	03 c8 00 18 	MNOP || R7 = [SP + 0x2c] || R1 = [FP + 0xc];
8d59506c:	f7 a2 f9 a0 
8d595070:	22 e1 04 4d 	R2 = 0x4d04 (X);		/*		R2=0x4d04(19716) */
8d595074:	04 cc 3a 00 	R0 = R7 + R2 (NS) || R6 = [SP + 0x2c] || NOP;
8d595078:	f6 a2 00 00 
8d59507c:	ff e3 14 fe 	CALL 0x0x8d594ca4;
8d595080:	23 e1 08 4f 	R3 = 0x4f08 (X);		/*		R3=0x4f08(20232) */
8d595084:	04 cc 3b 00 	R0 = R7 + R3 (NS) || R1 = [FP + 0xc] || NOP;
8d595088:	f9 a0 00 00 
8d59508c:	ff e3 0c fe 	CALL 0x0x8d594ca4;
8d595090:	22 e1 0c 51 	R2 = 0x510c (X);		/*		R2=0x510c(20748) */
8d595094:	04 cc 3a 00 	R0 = R7 + R2 (NS) || R1 = [FP + 0xc] || NOP;
8d595098:	f9 a0 00 00 
8d59509c:	ff e3 04 fe 	CALL 0x0x8d594ca4;
8d5950a0:	23 e1 10 53 	R3 = 0x5310 (X);		/*		R3=0x5310(21264) */
8d5950a4:	04 cc 33 00 	R0 = R6 + R3 (NS) || R1 = [FP + 0xc] || NOP;
8d5950a8:	f9 a0 00 00 
8d5950ac:	ff e3 48 fe 	CALL 0x0x8d594d3c;
8d5950b0:	27 e1 94 53 	R7 = 0x5394 (X);		/*		R7=0x5394(21396) */
8d5950b4:	04 cc 37 02 	R1 = R6 + R7 (NS) || R0 = [FP + 0xc] || NOP;
8d5950b8:	f8 a0 00 00 
8d5950bc:	82 61       	R2 = 0x30 (X);		/*		R2=0x510c(20748) */
8d5950be:	ff e3 a7 3a 	CALL 0x0x8d57c60c;
8d5950c2:	23 e1 c4 53 	R3 = 0x53c4 (X);		/*		R3=0x53c4(21444) */
8d5950c6:	04 cc 33 02 	R1 = R6 + R3 (NS) || R0 = [FP + 0xc] || NOP;
8d5950ca:	f8 a0 00 00 
8d5950ce:	82 61       	R2 = 0x30 (X);		/*		R2=0x510c(20748) */
8d5950d0:	ff e3 9e 3a 	CALL 0x0x8d57c60c;
8d5950d4:	66 6c       	SP += 0xc;		/* ( 12) */
8d5950d6:	a3 05       	(R7:4, P5:3) = [SP++];
8d5950d8:	01 e8 00 00 	UNLINK;
8d5950dc:	10 00       	RTS;
8d5950de:	00 00       	NOP;
8d5950e0:	00 da 09 84 	R0=-2079742444;
8d5950e4:	14 a6 00 00 
8d5950e8:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d5950ec:	a4 05 00 00 
8d5950f0:	b8 2f       	JUMP.S 0x0x8d595060;
8d5950f2:	00 00       	NOP;
8d5950f4:	00 00       	NOP;
8d5950f6:	00 00       	NOP;
8d5950f8:	00 da 09 84 	R0=-2079742496;
8d5950fc:	e0 a5 00 00 
8d595100:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d595104:	d4 34 00 00 
8d595108:	99 2f       	JUMP.S 0x0x8d59503a;
8d59510a:	00 00       	NOP;
8d59510c:	00 00       	NOP;
8d59510e:	00 00       	NOP;
8d595110:	00 da 09 84 	R0=-2079742548;
8d595114:	ac a5 00 00 
8d595118:	00 de ed 8f 	CALL.A 0x8fed34d4;
8d59511c:	d4 34 00 00 
8d595120:	6d 2f       	JUMP.S 0x0x8d594ffa;
8d595122:	00 00       	NOP;
8d595124:	00 00       	NOP;
	...
