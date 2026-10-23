
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d57e900 <.data+0xb28e0>:
8d57e900:	03 c8 00 18 	MNOP || R0 = [FP -0x78] || R5 = [SP + 0x3c];
8d57e904:	20 b8 f5 a3 
8d57e908:	ff e3 18 de 	CALL 0x0x8d57a538;
8d57e90c:	b0 a3       	R0 = [SP + 0x38];
8d57e90e:	ff e3 0f 99 	CALL 0x0x8d571b2c;
8d57e912:	71 a3       	R1 = [SP + 0x34];
8d57e914:	01 0c       	CC = R1 == 0x0;
8d57e916:	fd 67       	R5 += -0x1;		/* ( -1) */
8d57e918:	3d 06       	IF !CC R7 = R5;
8d57e91a:	24 e1 62 30 	R4 = 0x3062 (X);		/*		R4=0x3062(12386) */
8d57e91e:	20 51       	R4 = R0 + R4;
8d57e920:	82 ce 27 86 	R3 = R7 << 0x4 || [SP + 0x38] = R4 || NOP;
8d57e924:	b4 b3 00 00 
8d57e928:	dc 50       	R3 = R4 + R3;
8d57e92a:	1b 32       	P3 = R3;
8d57e92c:	22 e1 68 00 	R2 = 0x68 (X);		/*		R2=0x68(104) */
8d57e930:	4e 30       	R1 = SP;
8d57e932:	51 50       	R1 = R1 + R2;
8d57e934:	24 e1 58 2c 	R4 = 0x2c58 (X);		/*		R4=0x2c58(11352) */
8d57e938:	4b 32       	P1 = P3;
8d57e93a:	28 e1 58 00 	P0 = 0x58 (X);		/*		P0=0x58( 88) */
8d57e93e:	04 cc 04 08 	R4 = R0 + R4 (NS) || [SP + 0x3c] = R1 || R1 = W[P1++] (X);
8d57e942:	f1 b3 49 94 
8d57e946:	06 5a       	P0 = SP + P0;
8d57e948:	82 ce 1f 86 	R3 = R7 << 0x3 || W[P0++] = R1 || NOP;
8d57e94c:	01 96 00 00 
8d57e950:	34 e6 10 00 	[SP + 0x40] = R4;
8d57e954:	04 cc 23 08 	R4 = R4 + R3 (NS) || R3 = W[P1++] (X) || NOP;
8d57e958:	4b 94 00 00 
8d57e95c:	21 e1 58 02 	R1 = 0x258 (X);		/*		R1=0x258(600) */
8d57e960:	04 cc 01 00 	R0 = R0 + R1 (NS) || W[P0++] = R3 || R1 = W[P1++] (X);
8d57e964:	03 96 49 94 
8d57e968:	14 ba       	[FP -0x7c] = R4;
8d57e96a:	30 e6 12 00 	[SP + 0x48] = R0;
8d57e96e:	03 c8 00 18 	MNOP || W[P0++] = R1 || R0 = W[P1++] (X);
8d57e972:	01 96 48 94 
8d57e976:	03 c8 00 18 	MNOP || P2 = [FP -0x7c] || W[P0++] = R0;
8d57e97a:	1a b8 00 96 
8d57e97e:	03 c8 00 18 	MNOP || R3 = W[P1++] (X) || R0 = [SP + 0x3c];
8d57e982:	4b 94 f0 a3 
8d57e986:	03 c8 00 18 	MNOP || W[P0++] = R3 || R1 = W[P1++] (X);
8d57e98a:	03 96 49 94 
8d57e98e:	03 c8 00 18 	MNOP || W[P0++] = R1 || R3 = W[P1++] (X);
8d57e992:	01 96 4b 94 
8d57e996:	03 c8 00 18 	MNOP || W[P0] = R3.L || R3 = [P2];
8d57e99a:	c0 8a 13 91 
8d57e99e:	03 c8 00 18 	MNOP || [SP + 0x34] = R3 || R1 = W[P1] (X);
8d57e9a2:	73 b3 49 95 
8d57e9a6:	53 a0       	R3 = [P2 + 0x4];
8d57e9a8:	24 e1 54 00 	R4 = 0x54 (X);		/*		R4=0x54( 84) */
8d57e9ac:	33 e6 11 00 	[SP + 0x44] = R3;
8d57e9b0:	71 e6 33 00 	W[SP + 0x66] = R1;
8d57e9b4:	71 c2 7c 20 	R1 = R7 * R4 (IS,NS);
8d57e9b8:	33 e4 12 00 	R3 = [SP + 0x48];
8d57e9bc:	4b 50       	R1 = R3 + R1;
8d57e9be:	fb 63       	R3 = -0x1 (X);		/*		R3=0x0(  0) */
8d57e9c0:	33 06       	IF !CC R6 = R3;
8d57e9c2:	21 ba       	[FP -0x78] = R1;
8d57e9c4:	22 e1 54 00 	R2 = 0x54 (X);		/*		R2=0x54( 84) */
8d57e9c8:	00 de 02 04 	CALL.A 0x040201c4;
8d57e9cc:	c4 01 00 00 
8d57e9d0:	71 ca f5 20 	R3 = R6 * R5 (IS,NS) || P4 = [FP -0x78] || NOP;
8d57e9d4:	2c b8 00 00 
8d57e9d8:	03 0c       	CC = R3 == 0x0;
8d57e9da:	5f 51       	R5 = R7 + R3;
8d57e9dc:	7e 18       	IF CC JUMP 0x0x8d57ead8;
8d57e9de:	16 32       	P2 = R6;
