
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d574aac <.data+0xa8a8c>:
8d574aac:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d574ab0:	60 05       	[--SP] = (R7:4);
8d574ab2:	21 e1 7c 0d 	R1 = 0xd7c (X);		/*		R1=0xd7c(3452) */
8d574ab6:	48 50       	R1 = R0 + R1;
8d574ab8:	66 6f       	SP += -0x14;		/* (-20) */
8d574aba:	04 da 05 00 	R4=343876;
8d574abe:	44 3f 00 00 
8d574ac2:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d574ac4:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8d574ac6:	87 08       	CC = R7 < R0;
8d574ac8:	37 30       	R6 = R7;
8d574aca:	61 51       	R5 = R1 + R4;
8d574acc:	0f 64       	R7 += 0x1;		/* (  1) */
8d574ace:	2c 10       	IF !CC JUMP 0x0x8d574b26;
8d574ad0:	06 30       	R0 = R6;
8d574ad2:	ff e3 72 ff 	CALL 0x0x8d5749b6;
8d574ad6:	00 0c       	CC = R0 == 0x0;
8d574ad8:	0d 30       	R1 = R5;
8d574ada:	f5 17       	IF !CC JUMP 0x0x8d574ac4 (BP);
8d574adc:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d574ae0:	fc 1e 00 00 
8d574ae4:	88 0c       	CC = R0 < 0x1;
8d574ae6:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d574ae8:	08 10       	IF !CC JUMP 0x0x8d574af8;
8d574aea:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574aec:	20 05       	(R7:4) = [SP++];
8d574aee:	01 e8 00 00 	UNLINK;
8d574af2:	10 00       	RTS;
8d574af4:	00 00       	NOP;
8d574af6:	00 00       	NOP;
8d574af8:	09 da 09 84 	P1=-2079736616;
8d574afc:	d8 bc 00 00 
8d574b00:	36 b1       	[SP + 0x10] = R6;
8d574b02:	f1 bc       	[SP + 0xc] = P1;
8d574b04:	22 e1 2d 05 	R2 = 0x52d (X);		/*		R2=0x52d(1325) */
8d574b08:	01 da 09 84 	R1=-2079737212;
8d574b0c:	84 ba 00 00 
8d574b10:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d574b12:	00 de 04 8c 	CALL.A 0x8c040574;
8d574b16:	74 05 00 00 
8d574b1a:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574b1c:	20 05       	(R7:4) = [SP++];
8d574b1e:	01 e8 00 00 	UNLINK;
8d574b22:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d574b24:	10 00       	RTS;
8d574b26:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574b28:	20 05       	(R7:4) = [SP++];
8d574b2a:	01 e8 00 00 	UNLINK;
8d574b2e:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d574b30:	10 00       	RTS;
8d574b32:	00 00       	NOP;
8d574b34:	00 00       	NOP;
8d574b36:	00 00       	NOP;
8d574b38:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d574b3c:	ed 05       	[--SP] = (R7:5, P5:5);
8d574b3e:	66 6f       	SP += -0x14;		/* (-20) */
8d574b40:	0d da 09 84 	P5=-2079740432;
8d574b44:	f0 ad 00 00 
8d574b48:	82 ce 00 cc 	R6 = ROT R0 BY 0x0 || R0 = [P5] || NOP;
8d574b4c:	28 91 00 00 
8d574b50:	00 0c       	CC = R0 == 0x0;
8d574b52:	29 30       	R5 = R1;
8d574b54:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d574b58:	fc 1e 00 00 
8d574b5c:	25 18       	IF CC JUMP 0x0x8d574ba6;
8d574b5e:	88 0c       	CC = R0 < 0x1;
8d574b60:	0c 10       	IF !CC JUMP 0x0x8d574b78;
8d574b62:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574b64:	ad 05       	(R7:5, P5:5) = [SP++];
8d574b66:	01 e8 00 00 	UNLINK;
8d574b6a:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d574b6c:	10 00       	RTS;
8d574b6e:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574b70:	ad 05       	(R7:5, P5:5) = [SP++];
8d574b72:	01 e8 00 00 	UNLINK;
8d574b76:	10 00       	RTS;
8d574b78:	09 da 09 84 	P1=-2079736572;
8d574b7c:	04 bd 00 00 
8d574b80:	36 b1       	[SP + 0x10] = R6;
8d574b82:	f1 bc       	[SP + 0xc] = P1;
8d574b84:	22 e1 34 03 	R2 = 0x334 (X);		/*		R2=0x334(820) */
8d574b88:	01 da 09 84 	R1=-2079737212;
8d574b8c:	84 ba 00 00 
8d574b90:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d574b92:	00 de 04 8c 	CALL.A 0x8c040574;
8d574b96:	74 05 00 00 
8d574b9a:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574b9c:	ad 05       	(R7:5, P5:5) = [SP++];
8d574b9e:	01 e8 00 00 	UNLINK;
8d574ba2:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d574ba4:	10 00       	RTS;
8d574ba6:	98 0c       	CC = R0 < 0x3;
8d574ba8:	66 10       	IF !CC JUMP 0x0x8d574c74;
8d574baa:	28 e4 ff ff 	R0 = [P5 + -0x4];
8d574bae:	07 da 0f 85 	R7=-2062582520;
8d574bb2:	08 7d 00 00 
8d574bb6:	38 08       	CC = R0 == R7;
8d574bb8:	00 da 63 85 	R0=-2057075596;
8d574bbc:	74 84 00 00 
8d574bc0:	38 07       	IF CC R7 = R0;
8d574bc2:	0e 30       	R1 = R6;
8d574bc4:	07 30       	R0 = R7;
8d574bc6:	00 e3 2d 83 	CALL 0x0x8d585220;
8d574bca:	00 0c       	CC = R0 == 0x0;
8d574bcc:	1f 10       	IF !CC JUMP 0x0x8d574c0a;
8d574bce:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d574bd2:	fc 1e 00 00 
8d574bd6:	88 0c       	CC = R0 < 0x1;
8d574bd8:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d574bda:	ca 1f       	IF CC JUMP 0x0x8d574b6e (BP);
8d574bdc:	09 da 09 84 	P1=-2079736492;
8d574be0:	54 bd 00 00 
8d574be4:	36 b1       	[SP + 0x10] = R6;
8d574be6:	f1 bc       	[SP + 0xc] = P1;
8d574be8:	22 e1 3e 03 	R2 = 0x33e (X);		/*		R2=0x33e(830) */
8d574bec:	01 da 09 84 	R1=-2079737212;
8d574bf0:	84 ba 00 00 
8d574bf4:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d574bf6:	00 de 04 8c 	CALL.A 0x8c040574;
8d574bfa:	74 05 00 00 
8d574bfe:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574c00:	ad 05       	(R7:5, P5:5) = [SP++];
8d574c02:	01 e8 00 00 	UNLINK;
8d574c06:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d574c08:	10 00       	RTS;
8d574c0a:	07 30       	R0 = R7;
8d574c0c:	ff e3 50 ff 	CALL 0x0x8d574aac;
8d574c10:	00 0c       	CC = R0 == 0x0;
8d574c12:	1f 10       	IF !CC JUMP 0x0x8d574c50;
8d574c14:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d574c18:	fc 1e 00 00 
8d574c1c:	88 0c       	CC = R0 < 0x1;
8d574c1e:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d574c20:	a7 1f       	IF CC JUMP 0x0x8d574b6e (BP);
8d574c22:	09 da 09 84 	P1=-2079736448;
8d574c26:	80 bd 00 00 
8d574c2a:	36 b1       	[SP + 0x10] = R6;
8d574c2c:	f1 bc       	[SP + 0xc] = P1;
8d574c2e:	22 e1 43 03 	R2 = 0x343 (X);		/*		R2=0x343(835) */
8d574c32:	01 da 09 84 	R1=-2079737212;
8d574c36:	84 ba 00 00 
8d574c3a:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d574c3c:	00 de 04 8c 	CALL.A 0x8c040574;
8d574c40:	74 05 00 00 
8d574c44:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574c46:	ad 05       	(R7:5, P5:5) = [SP++];
8d574c48:	01 e8 00 00 	UNLINK;
8d574c4c:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d574c4e:	10 00       	RTS;
8d574c50:	2f b0       	[P5 + 0x0] = R7;
8d574c52:	05 0c       	CC = R5 == 0x0;
8d574c54:	08 10       	IF !CC JUMP 0x0x8d574c64;
8d574c56:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574c58:	ad 05       	(R7:5, P5:5) = [SP++];
8d574c5a:	01 e8 00 00 	UNLINK;
8d574c5e:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d574c60:	10 00       	RTS;
8d574c62:	00 00       	NOP;
8d574c64:	ff e3 cc e5 	CALL 0x0x8d5717fc;
8d574c68:	a6 6c       	SP += 0x14;		/* ( 20) */
8d574c6a:	ad 05       	(R7:5, P5:5) = [SP++];
8d574c6c:	01 e8 00 00 	UNLINK;
8d574c70:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d574c72:	10 00       	RTS;
8d574c74:	36 b1       	[SP + 0x10] = R6;
8d574c76:	09 da 09 84 	P1=-2079736512;
8d574c7a:	40 bd 00 00 
8d574c7e:	f1 bc       	[SP + 0xc] = P1;
8d574c80:	22 e1 38 03 	R2 = 0x338 (X);		/*		R2=0x338(824) */
8d574c84:	01 da 09 84 	R1=-2079737212;
8d574c88:	84 ba 00 00 
8d574c8c:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d574c8e:	00 de 04 8c 	CALL.A 0x8c040574;
8d574c92:	74 05 00 00 
8d574c96:	8a 2f       	JUMP.S 0x0x8d574baa;
