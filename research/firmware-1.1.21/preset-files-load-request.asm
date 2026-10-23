
os.ldr@0x8d4d7900:     file format binary


Disassembly of section .data:

8d4d7900 <.data>:
8d4d7900:	e5 05       	[--SP] = (R7:4, P5:5);
8d4d7902:	28 32       	P5 = R0;
8d4d7904:	86 6f       	SP += -0x10;		/* (-16) */
8d4d7906:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R6 = [SP + 0x3c] || NOP;
8d4d790a:	f6 a3 00 00 
8d4d790e:	fb 63       	R3 = -0x1 (X);		/*		R3=0x0(  0) */
8d4d7910:	81 68       	P1 = 0x10 (X);		/*		P1=0x0(  0) */
8d4d7912:	00 da 03 84 	R0=-2080154324;
8d4d7916:	2c 5d 00 00 
8d4d791a:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [P5 + 0x4] = R3 || NOP;
8d4d791e:	6b b0 00 00 
8d4d7922:	82 ce 02 c6 	R3 = ROT R2 BY 0x0 || [P5 ++ P1] = R0 || NOP;
8d4d7926:	0d 88 00 00 
8d4d792a:	7c 60       	R4 = 0xf (X);		/*		R4=0x0(  0) */
8d4d792c:	29 e6 fe ff 	[P5 + -0x8] = R1;
8d4d7930:	82 ce 03 c2 	R1 = ROT R3 BY 0x0 || [P5 + 0x14] = R5 || NOP;
8d4d7934:	6d b1 00 00 
8d4d7938:	ad e6 04 00 	B[P5 + 0x4] = R5;
8d4d793c:	04 cc 12 44 	R2 = R2 - R2 (NS) || [P5 + 0x18] = R4 || NOP;
8d4d7940:	ac b1 00 00 
8d4d7944:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0004;
8d4d7948:	b8 00 04 00 
8d4d794c:	f4 b0       	[SP + 0xc] = R4;
8d4d794e:	45 30       	R0 = P5;
8d4d7950:	00 de 03 8c 	CALL.A 0x8c03e970;
8d4d7954:	70 e9 00 00 
8d4d7958:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R3 = [SP + 0x38] || NOP;
8d4d795c:	b3 a3 00 00 
8d4d7960:	ad e6 1c 00 	B[P5 + 0x1c] = R5;
8d4d7964:	ae e6 1d 00 	B[P5 + 0x1d] = R6;
8d4d7968:	ab e6 1e 00 	B[P5 + 0x1e] = R3;
8d4d796c:	80 65       	R0 += 0x30;		/* ( 48) */
8d4d796e:	00 e3 5f 1f 	CALL 0x0x8d4db82c;
8d4d7972:	29 e5 fe ff 	P1 = [P5 + -0x8];
8d4d7976:	08 da 03 84 	P0=-2080154504;
8d4d797a:	78 5c 00 00 
8d4d797e:	48 5e       	P1 = P0 + (P1 << 0x2);
8d4d7980:	08 91       	R0 = [P1];
8d4d7982:	08 64       	R0 += 0x1;		/* (  1) */
8d4d7984:	08 93       	[P1] = R0;
8d4d7986:	28 e6 ff ff 	[P5 + -0x4] = R0;
8d4d798a:	86 6c       	SP += 0x10;		/* ( 16) */
8d4d798c:	a5 05       	(R7:4, P5:5) = [SP++];
8d4d798e:	01 e8 00 00 	UNLINK;
8d4d7992:	10 00       	RTS;
8d4d7994:	00 00       	NOP;
8d4d7996:	00 00       	NOP;
8d4d7998:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d4d799c:	e5 05       	[--SP] = (R7:4, P5:5);
8d4d799e:	20 30       	R4 = R0;
8d4d79a0:	2c 32       	P5 = R4;
8d4d79a2:	66 6f       	SP += -0x14;		/* (-20) */
8d4d79a4:	09 da 03 84 	P1=-2080154504;
8d4d79a8:	78 5c 00 00 
8d4d79ac:	7f 30       	R7 = FP;
8d4d79ae:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
8d4d79b0:	04 cc 36 4c 	R6 = R6 - R6 (NS) || P0 = [P5 + 0x8] || R0 = [P5 + 0xc];
8d4d79b4:	a8 ac e8 a0 
8d4d79b8:	a7 67       	R7 += -0xc;		/* (-12) */
8d4d79ba:	41 5e       	P1 = P1 + (P0 << 0x2);
8d4d79bc:	09 91       	R1 = [P1];
8d4d79be:	08 08       	CC = R0 == R1;
8d4d79c0:	0b 18       	IF CC JUMP 0x0x8d4d79d6;
8d4d79c2:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4d79c4:	00 d8 29 84 	LdStAbs addr=0x84298552 control=0x0a00;
8d4d79c8:	52 85 00 0a 
8d4d79cc:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4d79ce:	a5 05       	(R7:4, P5:5) = [SP++];
8d4d79d0:	01 e8 00 00 	UNLINK;
8d4d79d4:	10 00       	RTS;
8d4d79d6:	07 30       	R0 = R7;
8d4d79d8:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4d79da:	00 de 05 8c 	CALL.A 0x8c053038;
8d4d79de:	38 30 00 00 
8d4d79e2:	82 ce 04 c4 	R2 = ROT R4 BY 0x0 || R0 = [P5 + 0x28] || R1 = [P5 + 0x8];
8d4d79e6:	a8 a2 a9 a0 
8d4d79ea:	05 0a       	CC = R5 <= R0 (IU);
8d4d79ec:	a2 64       	R2 += 0x14;		/* ( 20) */
8d4d79ee:	03 10       	IF !CC JUMP 0x0x8d4d79f4;
8d4d79f0:	0a 32       	P1 = R2;
8d4d79f2:	0a 91       	R2 = [P1];
8d4d79f4:	04 30       	R0 = R4;
8d4d79f6:	80 65       	R0 += 0x30;		/* ( 48) */
8d4d79f8:	00 e3 72 38 	CALL 0x0x8d4deadc;
8d4d79fc:	00 0c       	CC = R0 == 0x0;
8d4d79fe:	2d 10       	IF !CC JUMP 0x0x8d4d7a58;
8d4d7a00:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4d7a04:	fc 1e 00 00 
8d4d7a08:	88 0c       	CC = R0 < 0x1;
8d4d7a0a:	0f 10       	IF !CC JUMP 0x0x8d4d7a28;
8d4d7a0c:	00 d8 29 84 	LdStAbs addr=0x84298552 control=0x0a06;
8d4d7a10:	52 85 06 0a 
8d4d7a14:	07 30       	R0 = R7;
8d4d7a16:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4d7a1a:	38 1a 00 00 
8d4d7a1e:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4d7a20:	a5 05       	(R7:4, P5:5) = [SP++];
8d4d7a22:	01 e8 00 00 	UNLINK;
8d4d7a26:	10 00       	RTS;
8d4d7a28:	a8 a2       	R0 = [P5 + 0x28];
8d4d7a2a:	05 0a       	CC = R5 <= R0 (IU);
8d4d7a2c:	a5 6c       	P5 += 0x14;		/* ( 20) */
8d4d7a2e:	02 10       	IF !CC JUMP 0x0x8d4d7a32;
8d4d7a30:	6d 91       	P5 = [P5];
8d4d7a32:	35 bd       	[SP + 0x10] = P5;
8d4d7a34:	09 da 03 84 	P1=-2080154616;
8d4d7a38:	08 5c 00 00 
8d4d7a3c:	f1 bc       	[SP + 0xc] = P1;
8d4d7a3e:	22 e1 3e 01 	R2 = 0x13e (X);		/*		R2=0x13e(318) */
8d4d7a42:	01 da 03 84 	R1=-2080154644;
8d4d7a46:	ec 5b 00 00 
8d4d7a4a:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4d7a4c:	00 de 04 8c 	CALL.A 0x8c040574;
8d4d7a50:	74 05 00 00 
8d4d7a54:	dc 2f       	JUMP.S 0x0x8d4d7a0c;
8d4d7a56:	00 00       	NOP;
8d4d7a58:	00 d8 29 84 	LdStAbs addr=0x84298552 control=0x0a06;
8d4d7a5c:	52 85 06 0a 
8d4d7a60:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d4d7a62:	a9 e6 2c 00 	B[P5 + 0x2c] = R1;
8d4d7a66:	07 30       	R0 = R7;
8d4d7a68:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4d7a6c:	38 1a 00 00 
8d4d7a70:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4d7a72:	a5 05       	(R7:4, P5:5) = [SP++];
8d4d7a74:	01 e8 00 00 	UNLINK;
8d4d7a78:	10 00       	RTS;
8d4d7a7a:	00 00       	NOP;
8d4d7a7c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4d7a80:	fd 05       	[--SP] = (R7:7, P5:5);
8d4d7a82:	38 30       	R7 = R0;
8d4d7a84:	2f 32       	P5 = R7;
8d4d7a86:	a6 6f       	SP += -0xc;		/* (-12) */
8d4d7a88:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4d7a8a:	04 e3 b9 9c 	CALL 0x0x8d56b3fc;
8d4d7a8e:	07 30       	R0 = R7;
8d4d7a90:	80 65       	R0 += 0x30;		/* ( 48) */
8d4d7a92:	a9 e4 2e 00 	R1 = B[P5 + 0x2e] (Z);
8d4d7a96:	00 e3 21 2a 	CALL 0x0x8d4dced8;
8d4d7a9a:	a8 e4 2d 00 	R0 = B[P5 + 0x2d] (Z);
8d4d7a9e:	00 0c       	CC = R0 == 0x0;
8d4d7aa0:	09 10       	IF !CC JUMP 0x0x8d4d7ab2;
8d4d7aa2:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4d7aa4:	04 e3 ac 9c 	CALL 0x0x8d56b3fc;
8d4d7aa8:	66 6c       	SP += 0xc;		/* ( 12) */
8d4d7aaa:	bd 05       	(R7:7, P5:5) = [SP++];
8d4d7aac:	01 e8 00 00 	UNLINK;
8d4d7ab0:	10 00       	RTS;
8d4d7ab2:	a8 a0       	R0 = [P5 + 0x8];
8d4d7ab4:	04 e3 66 db 	CALL 0x0x8d573180;
8d4d7ab8:	f5 2f       	JUMP.S 0x0x8d4d7aa2;
8d4d7aba:	00 00       	NOP;
8d4d7abc:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4d7ac0:	fd 05       	[--SP] = (R7:7, P5:5);
8d4d7ac2:	28 32       	P5 = R0;
8d4d7ac4:	a6 6f       	SP += -0xc;		/* (-12) */
8d4d7ac6:	01 da 03 84 	R1=-2080154324;
8d4d7aca:	2c 5d 00 00 
8d4d7ace:	81 68       	P1 = 0x10 (X);		/*		P1=0x0(  0) */
8d4d7ad0:	80 65       	R0 += 0x30;		/* ( 48) */
8d4d7ad2:	4d 88       	[P5 ++ P1] = R1;
8d4d7ad4:	00 de 0b 8c 	CALL.A 0x8c0b0b00;
8d4d7ad8:	00 0b 00 00 
8d4d7adc:	a8 a1       	R0 = [P5 + 0x18];
8d4d7ade:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4d7ae0:	07 0a       	CC = R7 <= R0 (IU);
8d4d7ae2:	12 18       	IF CC JUMP 0x0x8d4d7b06;
8d4d7ae4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4d7ae6:	68 b1       	[P5 + 0x14] = R0;
8d4d7ae8:	a8 e6 04 00 	B[P5 + 0x4] = R0;
8d4d7aec:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d4d7aee:	a8 b1       	[P5 + 0x18] = R0;
8d4d7af0:	00 da 03 84 	R0=-2080155092;
8d4d7af4:	2c 5a 00 00 
8d4d7af8:	28 e6 fc ff 	[P5 + -0x10] = R0;
8d4d7afc:	66 6c       	SP += 0xc;		/* ( 12) */
8d4d7afe:	bd 05       	(R7:7, P5:5) = [SP++];
8d4d7b00:	01 e8 00 00 	UNLINK;
8d4d7b04:	10 00       	RTS;
8d4d7b06:	68 a0       	R0 = [P5 + 0x4];
8d4d7b08:	ff e3 6e b4 	CALL 0x0x8d4ce3e4;
8d4d7b0c:	ec 2f       	JUMP.S 0x0x8d4d7ae4;
8d4d7b0e:	00 00       	NOP;
8d4d7b10:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4d7b14:	f5 05       	[--SP] = (R7:6, P5:5);
8d4d7b16:	28 32       	P5 = R0;
8d4d7b18:	a6 6f       	SP += -0xc;		/* (-12) */
8d4d7b1a:	01 da 03 84 	R1=-2080154324;
8d4d7b1e:	2c 5d 00 00 
8d4d7b22:	81 68       	P1 = 0x10 (X);		/*		P1=0x0(  0) */
8d4d7b24:	38 30       	R7 = R0;
8d4d7b26:	4d 88       	[P5 ++ P1] = R1;
8d4d7b28:	80 65       	R0 += 0x30;		/* ( 48) */
8d4d7b2a:	00 de 0b 8c 	CALL.A 0x8c0b0b00;
8d4d7b2e:	00 0b 00 00 
8d4d7b32:	a8 a1       	R0 = [P5 + 0x18];
8d4d7b34:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d4d7b36:	06 0a       	CC = R6 <= R0 (IU);
8d4d7b38:	17 18       	IF CC JUMP 0x0x8d4d7b66;
8d4d7b3a:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4d7b3c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [P5 + 0x14] = R1 || NOP;
8d4d7b40:	69 b1 00 00 
8d4d7b44:	a9 e6 04 00 	B[P5 + 0x4] = R1;
