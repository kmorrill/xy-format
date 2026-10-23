
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d5717fc <.data+0xa57dc>:
8d5717fc:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d571800:	08 da 09 84 	P0=-2079740432;
8d571804:	f0 ad 00 00 
8d571808:	04 cc 09 42 	R1 = R1 - R1 (NS) || R0 = [P0] || NOP;
8d57180c:	00 91 00 00 
8d571810:	00 0c       	CC = R0 == 0x0;
8d571812:	09 18       	IF CC JUMP 0x0x8d571824;
8d571814:	00 e6 ff ff 	[P0 + -0x4] = R0;
8d571818:	ff e3 18 f1 	CALL 0x0x8d56fa48;
8d57181c:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d57181e:	01 93       	[P0] = R1;
8d571820:	80 e6 05 00 	B[P0 + 0x5] = R0;
8d571824:	01 e8 00 00 	UNLINK;
8d571828:	10 00       	RTS;
8d57182a:	08 32       	P1 = R0;
8d57182c:	00 e8 01 00 	LINK 0x4;		/* (4) */
8d571830:	e3 05       	[--SP] = (R7:4, P5:3);
8d571832:	2a e1 e8 46 	P2 = 0x46e8 (X);		/*		P2=0x46e8(18152) */
8d571836:	2d e1 c8 46 	P5 = 0x46c8 (X);		/*		P5=0x46c8(18120) */
8d57183a:	91 5a       	P2 = P1 + P2;
8d57183c:	69 5b       	P5 = P1 + P5;
8d57183e:	08 da 05 00 	P0=329172;
8d571842:	d4 05 00 00 
8d571846:	25 e1 7c 0d 	R5 = 0xd7c (X);		/*		R5=0xd7c(3452) */
8d57184a:	04 cc 05 00 	R0 = R0 + R5 (NS) || [SP + 0x1c] = P5 || NOP;
8d57184e:	f5 bd 00 00 
8d571852:	02 5a       	P0 = P2 + P0;
8d571854:	23 e1 a8 1a 	R3 = 0x1aa8 (X);		/*		R3=0x1aa8(6824) */
8d571858:	02 da 05 00 	R2=343876;
8d57185c:	44 3f 00 00 
8d571860:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d571862:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d571864:	26 e1 f4 53 	R6 = 0x53f4 (X);		/*		R6=0x53f4(21492) */
8d571868:	30 bf       	[SP + 0x30] = P0;
8d57186a:	31 af       	P1 = [SP + 0x30];
8d57186c:	0a da fa ff 	P2=-329172;
8d571870:	2c fa 00 00 
8d571874:	11 81       	R4 = [P1 ++ P2];
8d571876:	71 ca 26 21 	R4 = R4 * R6 (IS,NS) || [SP + 0x30] = P1 || NOP;
8d57187a:	31 bf 00 00 
8d57187e:	04 cc 04 08 	R4 = R0 + R4 (NS) || P2 = [SP + 0x1c] || NOP;
8d571882:	f2 ad 00 00 
8d571886:	20 08       	CC = R0 == R4;
8d571888:	7a 18       	IF CC JUMP 0x0x8d57197c;
8d57188a:	f1 be       	[SP + 0x2c] = P1;
8d57188c:	b2 be       	[SP + 0x28] = P2;
8d57188e:	f1 ae       	P1 = [SP + 0x2c];
8d571890:	d0 e0 22 60 	LSETUP_IMM(bottom=0x8d5718d4) LC1 count_fields=0x0/0x18;
8d571894:	51 32       	P2 = P1;
8d571896:	15 98       	R5 = B[P2++] (Z);
8d571898:	05 0c       	CC = R5 == 0x0;
8d57189a:	fe 17       	IF !CC JUMP 0x0x8d571896 (BP);
8d57189c:	0a 44       	P2 -= P1;
8d57189e:	fa 6f       	P2 += -0x1;		/* ( -1) */
8d5718a0:	2d e1 60 00 	P5 = 0x60 (X);		/*		P5=0x60( 96) */
8d5718a4:	ea 08       	CC = P2 < P5;
8d5718a6:	15 10       	IF !CC JUMP 0x0x8d5718d0;
8d5718a8:	51 5b       	P5 = P1 + P2;
8d5718aa:	2c e1 60 00 	P4 = 0x60 (X);		/*		P4=0x60( 96) */
8d5718ae:	14 44       	P4 -= P2;
8d5718b0:	4c 0c       	CC = P4 == 0x1;
8d5718b2:	7e 18       	IF CC JUMP 0x0x8d5719ae;
8d5718b4:	22 45       	P2 = P4 >> 0x1;
8d5718b6:	4a 0c       	CC = P2 == 0x1;
8d5718b8:	08 18       	IF CC JUMP 0x0x8d5718c8;
8d5718ba:	13 45       	P3 = P2 >> 0x1;
8d5718bc:	a2 e0 02 30 	LSETUP(0x8d5718c0, 0x8d5718c0) LC0 = P3;
8d5718c0:	2f 92       	[P5++] = R7;
8d5718c2:	6a 30       	R5 = P2;
8d5718c4:	05 49       	CC = BITTST (R5, 0x0);		/* bit  0 */
8d5718c6:	02 10       	IF !CC JUMP 0x0x8d5718ca;
8d5718c8:	2f 96       	W[P5++] = R7;
8d5718ca:	6c 30       	R5 = P4;
8d5718cc:	05 49       	CC = BITTST (R5, 0x0);		/* bit  0 */
8d5718ce:	70 18       	IF CC JUMP 0x0x8d5719ae;
8d5718d0:	2a e1 80 00 	P2 = 0x80 (X);		/*		P2=0x80(128) */
8d5718d4:	51 5a       	P1 = P1 + P2;
8d5718d6:	b2 ae       	P2 = [SP + 0x28];
8d5718d8:	29 e1 00 0c 	P1 = 0xc00 (X);		/*		P1=0xc00(3072) */
8d5718dc:	8a 5a       	P2 = P2 + P1;
8d5718de:	4a 32       	P1 = P2;
8d5718e0:	0d 98       	R5 = B[P1++] (Z);
8d5718e2:	05 0c       	CC = R5 == 0x0;
8d5718e4:	fe 17       	IF !CC JUMP 0x0x8d5718e0 (BP);
8d5718e6:	11 44       	P1 -= P2;
8d5718e8:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d5718ea:	85 69       	P5 = 0x30 (X);		/*		P5=0x60( 96) */
8d5718ec:	e9 08       	CC = P1 < P5;
8d5718ee:	13 10       	IF !CC JUMP 0x0x8d571914;
8d5718f0:	8a 5a       	P2 = P2 + P1;
8d5718f2:	0d 44       	P5 -= P1;
8d5718f4:	4d 0c       	CC = P5 == 0x1;
8d5718f6:	5a 18       	IF CC JUMP 0x0x8d5719aa;
8d5718f8:	29 45       	P1 = P5 >> 0x1;
8d5718fa:	49 0c       	CC = P1 == 0x1;
8d5718fc:	08 18       	IF CC JUMP 0x0x8d57190c;
8d5718fe:	0c 45       	P4 = P1 >> 0x1;
8d571900:	b2 e0 02 40 	LSETUP(0x8d571904, 0x8d571904) LC1 = P4;
8d571904:	17 92       	[P2++] = R7;
8d571906:	69 30       	R5 = P1;
8d571908:	05 49       	CC = BITTST (R5, 0x0);		/* bit  0 */
8d57190a:	02 10       	IF !CC JUMP 0x0x8d57190e;
8d57190c:	17 96       	W[P2++] = R7;
8d57190e:	6d 30       	R5 = P5;
8d571910:	05 49       	CC = BITTST (R5, 0x0);		/* bit  0 */
8d571912:	4c 18       	IF CC JUMP 0x0x8d5719aa;
8d571914:	b2 ae       	P2 = [SP + 0x28];
8d571916:	29 e1 78 1a 	P1 = 0x1a78 (X);		/*		P1=0x1a78(6776) */
8d57191a:	8a 5a       	P2 = P2 + P1;
8d57191c:	4a 32       	P1 = P2;
8d57191e:	0d 98       	R5 = B[P1++] (Z);
8d571920:	05 0c       	CC = R5 == 0x0;
8d571922:	fe 17       	IF !CC JUMP 0x0x8d57191e (BP);
8d571924:	11 44       	P1 -= P2;
8d571926:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d571928:	85 69       	P5 = 0x30 (X);		/*		P5=0x60( 96) */
8d57192a:	e9 08       	CC = P1 < P5;
8d57192c:	14 10       	IF !CC JUMP 0x0x8d571954;
8d57192e:	8a 5a       	P2 = P2 + P1;
8d571930:	0d 44       	P5 -= P1;
8d571932:	4d 0c       	CC = P5 == 0x1;
8d571934:	0f 18       	IF CC JUMP 0x0x8d571952;
8d571936:	29 45       	P1 = P5 >> 0x1;
8d571938:	49 0c       	CC = P1 == 0x1;
8d57193a:	08 18       	IF CC JUMP 0x0x8d57194a;
8d57193c:	0c 45       	P4 = P1 >> 0x1;
8d57193e:	b2 e0 02 40 	LSETUP(0x8d571942, 0x8d571942) LC1 = P4;
8d571942:	17 92       	[P2++] = R7;
8d571944:	69 30       	R5 = P1;
8d571946:	05 49       	CC = BITTST (R5, 0x0);		/* bit  0 */
8d571948:	02 10       	IF !CC JUMP 0x0x8d57194c;
8d57194a:	17 96       	W[P2++] = R7;
8d57194c:	6d 30       	R5 = P5;
8d57194e:	05 49       	CC = BITTST (R5, 0x0);		/* bit  0 */
8d571950:	02 10       	IF !CC JUMP 0x0x8d571954;
8d571952:	17 9b       	B[P2] = R7;
8d571954:	03 c8 00 18 	MNOP || P4 = [SP + 0x2c] || R5 = [P0];
8d571958:	f4 ae 05 91 
8d57195c:	71 ca 6e 21 	R5 = R5 * R6 (IS,NS) || P5 = [SP + 0x28] || R4 = [SP + 0x28];
8d571960:	b5 ae b4 a2 
8d571964:	29 e1 f4 53 	P1 = 0x53f4 (X);		/*		P1=0x53f4(21492) */
8d571968:	2a e1 f4 53 	P2 = 0x53f4 (X);		/*		P2=0x53f4(21492) */
8d57196c:	1c 51       	R4 = R4 + R3;
8d57196e:	68 51       	R5 = R0 + R5;
8d571970:	4c 5a       	P1 = P4 + P1;
8d571972:	95 5a       	P2 = P5 + P2;
8d571974:	2c 08       	CC = R4 == R5;
8d571976:	f1 be       	[SP + 0x2c] = P1;
8d571978:	b2 be       	[SP + 0x28] = P2;
8d57197a:	8a 17       	IF !CC JUMP 0x0x8d57188e (BP);
8d57197c:	04 cc 02 00 	R0 = R0 + R2 (NS) || P5 = [SP + 0x1c] || NOP;
8d571980:	f5 ad 00 00 
8d571984:	32 af       	P2 = [SP + 0x30];
8d571986:	09 da 05 00 	P1=343876;
8d57198a:	44 3f 00 00 
8d57198e:	f9 67       	R1 += -0x1;		/* ( -1) */
8d571990:	4d 5a       	P1 = P5 + P1;
8d571992:	08 da 0a 00 	P0=673048;
8d571996:	18 45 00 00 
8d57199a:	01 0c       	CC = R1 == 0x0;
8d57199c:	f1 bd       	[SP + 0x1c] = P1;
8d57199e:	02 5a       	P0 = P2 + P0;
8d5719a0:	64 17       	IF !CC JUMP 0x0x8d571868 (BP);
8d5719a2:	a3 05       	(R7:4, P5:3) = [SP++];
8d5719a4:	01 e8 00 00 	UNLINK;
8d5719a8:	10 00       	RTS;
8d5719aa:	17 9b       	B[P2] = R7;
8d5719ac:	b4 2f       	JUMP.S 0x0x8d571914;
8d5719ae:	2f 9b       	B[P5] = R7;
8d5719b0:	90 2f       	JUMP.S 0x0x8d5718d0;
8d5719b2:	00 00       	NOP;
8d5719b4:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d5719b8:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d5719bc:	f7 b0 00 00 
8d5719c0:	02 da 54 00 	R2=5506924;
8d5719c4:	6c 07 00 00 
8d5719c8:	00 da b7 85 	R0=-2051568672;
8d5719cc:	e0 8b 00 00 
8d5719d0:	00 d8 09 84 	LdStAbs addr=0x8409adec control=0x0001;
8d5719d4:	ec ad 01 00 
8d5719d8:	00 de 02 04 	CALL.A 0x040201c4;
8d5719dc:	c4 01 00 00 
8d5719e0:	00 da b7 85 	R0=-2051568672;
8d5719e4:	e0 8b 00 00 
8d5719e8:	ff e3 21 ff 	CALL 0x0x8d57182a;
8d5719ec:	0f 30       	R1 = R7;
8d5719ee:	00 da b7 85 	R0=-2051568672;
8d5719f2:	e0 8b 00 00 
8d5719f6:	00 e3 ef 96 	CALL 0x0x8d5847d4;
8d5719fa:	f7 a0       	R7 = [SP + 0xc];
8d5719fc:	01 e8 00 00 	UNLINK;
8d571a00:	10 00       	RTS;
	...
