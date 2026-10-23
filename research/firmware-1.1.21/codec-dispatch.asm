
os.ldr@0x8d584a40:     file format binary


Disassembly of section .data:

8d584a40 <.data>:
8d584a40:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d584a44:	82 c6 41 86 	R3 = R1 << 0x8;
8d584a48:	e3 05       	[--SP] = (R7:4, P5:3);
8d584a4a:	9a 57       	R6 = R2 | R3;
8d584a4c:	f3 42       	R3 = R6.L (Z);
8d584a4e:	27 e1 01 08 	R7 = 0x801 (X);		/*		R7=0x801(2049) */
8d584a52:	bb 09       	CC = R3 < R7 (IU);
8d584a54:	46 6f       	SP += -0x18;		/* (-24) */
8d584a56:	0d da 0c 86 	P5=-2045991292;
8d584a5a:	84 a6 00 00 
8d584a5e:	bb 18       	IF CC JUMP 0x0x8d584bd4;
8d584a60:	3b 08       	CC = R3 == R7;
8d584a62:	13 18       	IF CC JUMP 0x0x8d584a88;
8d584a64:	25 e1 00 f7 	R5 = -0x900 (X);		/*		R5=0xfffff700(-2304) */
8d584a68:	eb 50       	R3 = R3 + R5;
8d584a6a:	a5 60       	R5 = 0x14 (X);		/*		R5=0xfffff700(-2304) */
8d584a6c:	0b 32       	P1 = R3;
8d584a6e:	ab 09       	CC = R3 < R5 (IU);
8d584a70:	b6 10       	IF !CC JUMP 0x0x8d584bdc;
8d584a72:	08 da 0a 84 	P0=-2079710588;
8d584a76:	84 22 00 00 
8d584a7a:	48 5e       	P1 = P0 + (P1 << 0x2);
8d584a7c:	49 91       	P1 = [P1];
8d584a7e:	4d 30       	R1 = P5;
8d584a80:	51 00       	JUMP (P1);
8d584a82:	00 00       	NOP;
8d584a84:	00 00       	NOP;
8d584a86:	00 00       	NOP;
8d584a88:	01 da 0c 86 	R1=-2045991292;
8d584a8c:	84 a6 00 00 
8d584a90:	00 e3 1c 0c 	CALL 0x0x8d5862c8;
8d584a94:	09 da 64 86 	P1=-2040221924;
8d584a98:	1c af 00 00 
8d584a9c:	24 e1 00 08 	R4 = 0x800 (X);		/*		R4=0x800(2048) */
8d584aa0:	0b da 0a 84 	P3=-2079710668;
8d584aa4:	34 22 00 00 
8d584aa8:	25 e1 13 09 	R5 = 0x913 (X);		/*		R5=0x913(2323) */
8d584aac:	61 32       	P4 = P1;
8d584aae:	f0 42       	R0 = R6.L (Z);
8d584ab0:	b8 09       	CC = R0 < R7 (IU);
8d584ab2:	70 18       	IF CC JUMP 0x0x8d584b92;
8d584ab4:	38 08       	CC = R0 == R7;
8d584ab6:	39 18       	IF CC JUMP 0x0x8d584b28;
8d584ab8:	21 e1 00 f7 	R1 = -0x900 (X);		/*		R1=0xfffff700(-2304) */
8d584abc:	08 50       	R0 = R0 + R1;
8d584abe:	a2 60       	R2 = 0x14 (X);		/*		R2=0x0(  0) */
8d584ac0:	08 32       	P1 = R0;
8d584ac2:	90 09       	CC = R0 < R2 (IU);
8d584ac4:	0e 10       	IF !CC JUMP 0x0x8d584ae0;
8d584ac6:	4b 5e       	P1 = P3 + (P1 << 0x2);
8d584ac8:	49 91       	P1 = [P1];
8d584aca:	22 e1 2a 01 	R2 = 0x12a (X);		/*		R2=0x12a(298) */
8d584ace:	01 da 0a 84 	R1=-2079711276;
8d584ad2:	d4 1f 00 00 
8d584ad6:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584ada:	fc 1e 00 00 
8d584ade:	51 00       	JUMP (P1);
8d584ae0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584ae4:	fc 1e 00 00 
8d584ae8:	88 0c       	CC = R0 < 0x1;
8d584aea:	07 10       	IF !CC JUMP 0x0x8d584af8;
8d584aec:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584aee:	a3 05       	(R7:4, P5:3) = [SP++];
8d584af0:	01 e8 00 00 	UNLINK;
8d584af4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d584af6:	10 00       	RTS;
8d584af8:	f0 42       	R0 = R6.L (Z);
8d584afa:	09 da 0a 84 	P1=-2079710712;
8d584afe:	08 22 00 00 
8d584b02:	30 b1       	[SP + 0x10] = R0;
8d584b04:	f1 bc       	[SP + 0xc] = P1;
8d584b06:	22 e1 8b 01 	R2 = 0x18b (X);		/*		R2=0x18b(395) */
8d584b0a:	01 da 0a 84 	R1=-2079711276;
8d584b0e:	d4 1f 00 00 
8d584b12:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d584b14:	00 de 04 8c 	CALL.A 0x8c040574;
8d584b18:	74 05 00 00 
8d584b1c:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584b1e:	a3 05       	(R7:4, P5:3) = [SP++];
8d584b20:	01 e8 00 00 	UNLINK;
8d584b24:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d584b26:	10 00       	RTS;
8d584b28:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584b2c:	fc 1e 00 00 
8d584b30:	98 0c       	CC = R0 < 0x3;
8d584b32:	1f 10       	IF !CC JUMP 0x0x8d584b70;
8d584b34:	4c 30       	R1 = P4;
8d584b36:	45 30       	R0 = P5;
8d584b38:	00 e3 e4 50 	CALL 0x0x8d58ed00;
8d584b3c:	26 e1 00 09 	R6 = 0x900 (X);		/*		R6=0x900(2304) */
8d584b40:	f0 42       	R0 = R6.L (Z);
8d584b42:	28 08       	CC = R0 == R5;
8d584b44:	4d 32       	P1 = P5;
8d584b46:	6c 32       	P5 = P4;
8d584b48:	b2 17       	IF !CC JUMP 0x0x8d584aac (BP);
8d584b4a:	79 ad       	P1 = [FP + 0x14];
8d584b4c:	4c 30       	R1 = P4;
8d584b4e:	02 da 54 00 	R2=5506924;
8d584b52:	6c 07 00 00 
8d584b56:	41 30       	R0 = P1;
8d584b58:	00 de 02 04 	CALL.A 0x040201c4;
8d584b5c:	c4 01 00 00 
8d584b60:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584b62:	a3 05       	(R7:4, P5:3) = [SP++];
8d584b64:	01 e8 00 00 	UNLINK;
8d584b68:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d584b6a:	10 00       	RTS;
8d584b6c:	00 00       	NOP;
8d584b6e:	00 00       	NOP;
8d584b70:	09 da 0a 84 	P1=-2079711112;
8d584b74:	78 20 00 00 
8d584b78:	f1 bc       	[SP + 0xc] = P1;
8d584b7a:	22 e1 25 01 	R2 = 0x125 (X);		/*		R2=0x125(293) */
8d584b7e:	01 da 0a 84 	R1=-2079711276;
8d584b82:	d4 1f 00 00 
8d584b86:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584b88:	00 de 04 8c 	CALL.A 0x8c040574;
8d584b8c:	74 05 00 00 
8d584b90:	d2 2f       	JUMP.S 0x0x8d584b34;
8d584b92:	20 08       	CC = R0 == R4;
8d584b94:	a6 13       	IF !CC JUMP 0x0x8d584ae0;
8d584b96:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584b9a:	fc 1e 00 00 
8d584b9e:	98 0c       	CC = R0 < 0x3;
8d584ba0:	08 10       	IF !CC JUMP 0x0x8d584bb0;
8d584ba2:	4c 30       	R1 = P4;
8d584ba4:	45 30       	R0 = P5;
8d584ba6:	00 e3 9d 46 	CALL 0x0x8d58d8e0;
8d584baa:	26 e1 01 08 	R6 = 0x801 (X);		/*		R6=0x801(2049) */
8d584bae:	c9 2f       	JUMP.S 0x0x8d584b40;
8d584bb0:	09 da 0a 84 	P1=-2079711132;
8d584bb4:	64 20 00 00 
8d584bb8:	f1 bc       	[SP + 0xc] = P1;
8d584bba:	22 e1 20 01 	R2 = 0x120 (X);		/*		R2=0x120(288) */
8d584bbe:	01 da 0a 84 	R1=-2079711276;
8d584bc2:	d4 1f 00 00 
8d584bc6:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584bc8:	00 de 04 8c 	CALL.A 0x8c040574;
8d584bcc:	74 05 00 00 
8d584bd0:	e9 2f       	JUMP.S 0x0x8d584ba2;
8d584bd2:	00 00       	NOP;
8d584bd4:	25 e1 00 08 	R5 = 0x800 (X);		/*		R5=0x800(2048) */
8d584bd8:	2b 08       	CC = R3 == R5;
8d584bda:	27 18       	IF CC JUMP 0x0x8d584c28;
8d584bdc:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584be0:	fc 1e 00 00 
8d584be4:	88 0c       	CC = R0 < 0x1;
8d584be6:	09 10       	IF !CC JUMP 0x0x8d584bf8;
8d584be8:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584bea:	a3 05       	(R7:4, P5:3) = [SP++];
8d584bec:	01 e8 00 00 	UNLINK;
8d584bf0:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d584bf2:	10 00       	RTS;
8d584bf4:	00 00       	NOP;
8d584bf6:	00 00       	NOP;
8d584bf8:	09 da 0a 84 	P1=-2079711168;
8d584bfc:	40 20 00 00 
8d584c00:	72 b1       	[SP + 0x14] = R2;
8d584c02:	31 b1       	[SP + 0x10] = R1;
8d584c04:	f1 bc       	[SP + 0xc] = P1;
8d584c06:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d584c08:	22 e1 19 01 	R2 = 0x119 (X);		/*		R2=0x119(281) */
8d584c0c:	01 da 0a 84 	R1=-2079711276;
8d584c10:	d4 1f 00 00 
8d584c14:	00 de 04 8c 	CALL.A 0x8c040574;
8d584c18:	74 05 00 00 
8d584c1c:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584c1e:	a3 05       	(R7:4, P5:3) = [SP++];
8d584c20:	01 e8 00 00 	UNLINK;
8d584c24:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d584c26:	10 00       	RTS;
8d584c28:	01 da 0c 86 	R1=-2045991292;
8d584c2c:	84 a6 00 00 
8d584c30:	00 e3 8c 07 	CALL 0x0x8d585b48;
8d584c34:	30 2f       	JUMP.S 0x0x8d584a94;
8d584c36:	00 00       	NOP;
8d584c38:	00 e3 04 0f 	CALL 0x0x8d586a40;
8d584c3c:	2c 2f       	JUMP.S 0x0x8d584a94;
8d584c3e:	4d 30       	R1 = P5;
8d584c40:	00 e3 bc 12 	CALL 0x0x8d5871b8;
8d584c44:	28 2f       	JUMP.S 0x0x8d584a94;
8d584c46:	4d 30       	R1 = P5;
8d584c48:	00 e3 f8 35 	CALL 0x0x8d58b838;
8d584c4c:	24 2f       	JUMP.S 0x0x8d584a94;
8d584c4e:	4d 30       	R1 = P5;
8d584c50:	00 e3 a8 39 	CALL 0x0x8d58bfa0;
8d584c54:	20 2f       	JUMP.S 0x0x8d584a94;
8d584c56:	4d 30       	R1 = P5;
8d584c58:	00 e3 6c 3d 	CALL 0x0x8d58c730;
8d584c5c:	1c 2f       	JUMP.S 0x0x8d584a94;
8d584c5e:	4d 30       	R1 = P5;
8d584c60:	00 e3 30 41 	CALL 0x0x8d58cec0;
8d584c64:	18 2f       	JUMP.S 0x0x8d584a94;
8d584c66:	4d 30       	R1 = P5;
8d584c68:	00 e3 94 45 	CALL 0x0x8d58d790;
8d584c6c:	14 2f       	JUMP.S 0x0x8d584a94;
8d584c6e:	4d 30       	R1 = P5;
8d584c70:	00 e3 f4 16 	CALL 0x0x8d587a58;
8d584c74:	10 2f       	JUMP.S 0x0x8d584a94;
8d584c76:	4d 30       	R1 = P5;
8d584c78:	00 e3 f0 16 	CALL 0x0x8d587a58;
8d584c7c:	0c 2f       	JUMP.S 0x0x8d584a94;
8d584c7e:	4d 30       	R1 = P5;
8d584c80:	00 e3 ec 16 	CALL 0x0x8d587a58;
8d584c84:	08 2f       	JUMP.S 0x0x8d584a94;
8d584c86:	4d 30       	R1 = P5;
8d584c88:	00 e3 e8 16 	CALL 0x0x8d587a58;
8d584c8c:	04 2f       	JUMP.S 0x0x8d584a94;
8d584c8e:	4d 30       	R1 = P5;
8d584c90:	00 e3 e4 16 	CALL 0x0x8d587a58;
8d584c94:	00 2f       	JUMP.S 0x0x8d584a94;
8d584c96:	4d 30       	R1 = P5;
8d584c98:	00 e3 20 1b 	CALL 0x0x8d5882d8;
8d584c9c:	fc 2e       	JUMP.S 0x0x8d584a94;
8d584c9e:	4d 30       	R1 = P5;
8d584ca0:	00 e3 98 1f 	CALL 0x0x8d588bd0;
8d584ca4:	f8 2e       	JUMP.S 0x0x8d584a94;
8d584ca6:	4d 30       	R1 = P5;
8d584ca8:	00 e3 18 24 	CALL 0x0x8d5894d8;
8d584cac:	f4 2e       	JUMP.S 0x0x8d584a94;
8d584cae:	4d 30       	R1 = P5;
8d584cb0:	00 e3 14 24 	CALL 0x0x8d5894d8;
8d584cb4:	f0 2e       	JUMP.S 0x0x8d584a94;
8d584cb6:	4d 30       	R1 = P5;
8d584cb8:	00 e3 92 28 	CALL 0x0x8d589ddc;
8d584cbc:	ec 2e       	JUMP.S 0x0x8d584a94;
8d584cbe:	4d 30       	R1 = P5;
8d584cc0:	00 e3 2e 2d 	CALL 0x0x8d58a71c;
8d584cc4:	e8 2e       	JUMP.S 0x0x8d584a94;
8d584cc6:	4d 30       	R1 = P5;
8d584cc8:	00 e3 ca 31 	CALL 0x0x8d58b05c;
8d584ccc:	e4 2e       	JUMP.S 0x0x8d584a94;
8d584cce:	79 ad       	P1 = [FP + 0x14];
8d584cd0:	49 30       	R1 = P1;
8d584cd2:	00 e3 a1 83 	CALL 0x0x8d595414;
8d584cd6:	c6 6c       	SP += 0x18;		/* ( 24) */
8d584cd8:	a3 05       	(R7:4, P5:3) = [SP++];
8d584cda:	01 e8 00 00 	UNLINK;
8d584cde:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d584ce0:	10 00       	RTS;
8d584ce2:	00 00       	NOP;
8d584ce4:	00 00       	NOP;
8d584ce6:	00 00       	NOP;
8d584ce8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584cec:	fc 1e 00 00 
8d584cf0:	98 0c       	CC = R0 < 0x3;
8d584cf2:	0b 10       	IF !CC JUMP 0x0x8d584d08;
8d584cf4:	4c 30       	R1 = P4;
8d584cf6:	45 30       	R0 = P5;
8d584cf8:	00 e3 52 52 	CALL 0x0x8d58f19c;
8d584cfc:	26 e1 01 09 	R6 = 0x901 (X);		/*		R6=0x901(2305) */
8d584d00:	20 2f       	JUMP.S 0x0x8d584b40;
8d584d02:	00 00       	NOP;
8d584d04:	00 00       	NOP;
8d584d06:	00 00       	NOP;
8d584d08:	09 da 0a 84 	P1=-2079711092;
8d584d0c:	8c 20 00 00 
8d584d10:	f1 bc       	[SP + 0xc] = P1;
8d584d12:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584d14:	00 de 04 8c 	CALL.A 0x8c040574;
8d584d18:	74 05 00 00 
8d584d1c:	ec 2f       	JUMP.S 0x0x8d584cf4;
8d584d1e:	00 00       	NOP;
8d584d20:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584d24:	fc 1e 00 00 
8d584d28:	98 0c       	CC = R0 < 0x3;
8d584d2a:	0b 10       	IF !CC JUMP 0x0x8d584d40;
8d584d2c:	4c 30       	R1 = P4;
8d584d2e:	45 30       	R0 = P5;
8d584d30:	00 e3 da 54 	CALL 0x0x8d58f6e4;
8d584d34:	26 e1 02 09 	R6 = 0x902 (X);		/*		R6=0x902(2306) */
8d584d38:	04 2f       	JUMP.S 0x0x8d584b40;
8d584d3a:	00 00       	NOP;
8d584d3c:	00 00       	NOP;
8d584d3e:	00 00       	NOP;
8d584d40:	09 da 0a 84 	P1=-2079711072;
8d584d44:	a0 20 00 00 
8d584d48:	f1 bc       	[SP + 0xc] = P1;
8d584d4a:	22 e1 2f 01 	R2 = 0x12f (X);		/*		R2=0x12f(303) */
8d584d4e:	01 da 0a 84 	R1=-2079711276;
8d584d52:	d4 1f 00 00 
8d584d56:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584d58:	00 de 04 8c 	CALL.A 0x8c040574;
8d584d5c:	74 05 00 00 
8d584d60:	e6 2f       	JUMP.S 0x0x8d584d2c;
8d584d62:	00 00       	NOP;
8d584d64:	00 00       	NOP;
8d584d66:	00 00       	NOP;
8d584d68:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584d6c:	fc 1e 00 00 
8d584d70:	98 0c       	CC = R0 < 0x3;
8d584d72:	0b 10       	IF !CC JUMP 0x0x8d584d88;
8d584d74:	4c 30       	R1 = P4;
8d584d76:	45 30       	R0 = P5;
8d584d78:	00 e3 c6 57 	CALL 0x0x8d58fd04;
8d584d7c:	26 e1 03 09 	R6 = 0x903 (X);		/*		R6=0x903(2307) */
8d584d80:	e0 2e       	JUMP.S 0x0x8d584b40;
8d584d82:	00 00       	NOP;
8d584d84:	00 00       	NOP;
8d584d86:	00 00       	NOP;
8d584d88:	09 da 0a 84 	P1=-2079711052;
8d584d8c:	b4 20 00 00 
8d584d90:	f1 bc       	[SP + 0xc] = P1;
8d584d92:	22 e1 34 01 	R2 = 0x134 (X);		/*		R2=0x134(308) */
8d584d96:	01 da 0a 84 	R1=-2079711276;
8d584d9a:	d4 1f 00 00 
8d584d9e:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584da0:	00 de 04 8c 	CALL.A 0x8c040574;
8d584da4:	74 05 00 00 
8d584da8:	e6 2f       	JUMP.S 0x0x8d584d74;
8d584daa:	00 00       	NOP;
8d584dac:	00 00       	NOP;
8d584dae:	00 00       	NOP;
8d584db0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584db4:	fc 1e 00 00 
8d584db8:	98 0c       	CC = R0 < 0x3;
8d584dba:	0b 10       	IF !CC JUMP 0x0x8d584dd0;
8d584dbc:	4c 30       	R1 = P4;
8d584dbe:	45 30       	R0 = P5;
8d584dc0:	00 e3 26 5a 	CALL 0x0x8d59020c;
8d584dc4:	26 e1 04 09 	R6 = 0x904 (X);		/*		R6=0x904(2308) */
8d584dc8:	bc 2e       	JUMP.S 0x0x8d584b40;
8d584dca:	00 00       	NOP;
8d584dcc:	00 00       	NOP;
8d584dce:	00 00       	NOP;
8d584dd0:	09 da 0a 84 	P1=-2079711032;
8d584dd4:	c8 20 00 00 
8d584dd8:	f1 bc       	[SP + 0xc] = P1;
8d584dda:	22 e1 39 01 	R2 = 0x139 (X);		/*		R2=0x139(313) */
8d584dde:	01 da 0a 84 	R1=-2079711276;
8d584de2:	d4 1f 00 00 
8d584de6:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584de8:	00 de 04 8c 	CALL.A 0x8c040574;
8d584dec:	74 05 00 00 
8d584df0:	e6 2f       	JUMP.S 0x0x8d584dbc;
8d584df2:	00 00       	NOP;
8d584df4:	00 00       	NOP;
8d584df6:	00 00       	NOP;
8d584df8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584dfc:	fc 1e 00 00 
8d584e00:	98 0c       	CC = R0 < 0x3;
8d584e02:	0b 10       	IF !CC JUMP 0x0x8d584e18;
8d584e04:	4c 30       	R1 = P4;
8d584e06:	45 30       	R0 = P5;
8d584e08:	00 e3 22 5c 	CALL 0x0x8d59064c;
8d584e0c:	26 e1 05 09 	R6 = 0x905 (X);		/*		R6=0x905(2309) */
8d584e10:	98 2e       	JUMP.S 0x0x8d584b40;
8d584e12:	00 00       	NOP;
8d584e14:	00 00       	NOP;
8d584e16:	00 00       	NOP;
8d584e18:	09 da 0a 84 	P1=-2079711012;
8d584e1c:	dc 20 00 00 
8d584e20:	f1 bc       	[SP + 0xc] = P1;
8d584e22:	22 e1 3e 01 	R2 = 0x13e (X);		/*		R2=0x13e(318) */
8d584e26:	01 da 0a 84 	R1=-2079711276;
8d584e2a:	d4 1f 00 00 
8d584e2e:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584e30:	00 de 04 8c 	CALL.A 0x8c040574;
8d584e34:	74 05 00 00 
8d584e38:	e6 2f       	JUMP.S 0x0x8d584e04;
8d584e3a:	00 00       	NOP;
8d584e3c:	00 00       	NOP;
8d584e3e:	00 00       	NOP;
8d584e40:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584e44:	fc 1e 00 00 
8d584e48:	98 0c       	CC = R0 < 0x3;
8d584e4a:	0b 10       	IF !CC JUMP 0x0x8d584e60;
8d584e4c:	4c 30       	R1 = P4;
8d584e4e:	45 30       	R0 = P5;
8d584e50:	00 e3 5a 5e 	CALL 0x0x8d590b04;
8d584e54:	26 e1 06 09 	R6 = 0x906 (X);		/*		R6=0x906(2310) */
8d584e58:	74 2e       	JUMP.S 0x0x8d584b40;
8d584e5a:	00 00       	NOP;
8d584e5c:	00 00       	NOP;
8d584e5e:	00 00       	NOP;
8d584e60:	09 da 0a 84 	P1=-2079710992;
8d584e64:	f0 20 00 00 
8d584e68:	f1 bc       	[SP + 0xc] = P1;
8d584e6a:	22 e1 43 01 	R2 = 0x143 (X);		/*		R2=0x143(323) */
8d584e6e:	01 da 0a 84 	R1=-2079711276;
8d584e72:	d4 1f 00 00 
8d584e76:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584e78:	00 de 04 8c 	CALL.A 0x8c040574;
8d584e7c:	74 05 00 00 
8d584e80:	e6 2f       	JUMP.S 0x0x8d584e4c;
8d584e82:	00 00       	NOP;
8d584e84:	00 00       	NOP;
8d584e86:	00 00       	NOP;
8d584e88:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584e8c:	fc 1e 00 00 
8d584e90:	98 0c       	CC = R0 < 0x3;
8d584e92:	0b 10       	IF !CC JUMP 0x0x8d584ea8;
8d584e94:	4c 30       	R1 = P4;
8d584e96:	45 30       	R0 = P5;
8d584e98:	00 e3 48 61 	CALL 0x0x8d591128;
8d584e9c:	26 e1 07 09 	R6 = 0x907 (X);		/*		R6=0x907(2311) */
8d584ea0:	50 2e       	JUMP.S 0x0x8d584b40;
8d584ea2:	00 00       	NOP;
8d584ea4:	00 00       	NOP;
8d584ea6:	00 00       	NOP;
8d584ea8:	09 da 0a 84 	P1=-2079710972;
8d584eac:	04 21 00 00 
8d584eb0:	f1 bc       	[SP + 0xc] = P1;
8d584eb2:	22 e1 48 01 	R2 = 0x148 (X);		/*		R2=0x148(328) */
8d584eb6:	01 da 0a 84 	R1=-2079711276;
8d584eba:	d4 1f 00 00 
8d584ebe:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584ec0:	00 de 04 8c 	CALL.A 0x8c040574;
8d584ec4:	74 05 00 00 
8d584ec8:	e6 2f       	JUMP.S 0x0x8d584e94;
8d584eca:	00 00       	NOP;
8d584ecc:	00 00       	NOP;
8d584ece:	00 00       	NOP;
8d584ed0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584ed4:	fc 1e 00 00 
8d584ed8:	98 0c       	CC = R0 < 0x3;
8d584eda:	0b 10       	IF !CC JUMP 0x0x8d584ef0;
8d584edc:	4c 30       	R1 = P4;
8d584ede:	45 30       	R0 = P5;
8d584ee0:	00 e3 4c 64 	CALL 0x0x8d591778;
8d584ee4:	26 e1 08 09 	R6 = 0x908 (X);		/*		R6=0x908(2312) */
8d584ee8:	2c 2e       	JUMP.S 0x0x8d584b40;
8d584eea:	00 00       	NOP;
8d584eec:	00 00       	NOP;
8d584eee:	00 00       	NOP;
8d584ef0:	09 da 0a 84 	P1=-2079710952;
8d584ef4:	18 21 00 00 
8d584ef8:	f1 bc       	[SP + 0xc] = P1;
8d584efa:	22 e1 4d 01 	R2 = 0x14d (X);		/*		R2=0x14d(333) */
8d584efe:	01 da 0a 84 	R1=-2079711276;
8d584f02:	d4 1f 00 00 
8d584f06:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584f08:	00 de 04 8c 	CALL.A 0x8c040574;
8d584f0c:	74 05 00 00 
8d584f10:	e6 2f       	JUMP.S 0x0x8d584edc;
8d584f12:	00 00       	NOP;
8d584f14:	00 00       	NOP;
8d584f16:	00 00       	NOP;
8d584f18:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584f1c:	fc 1e 00 00 
8d584f20:	98 0c       	CC = R0 < 0x3;
8d584f22:	0b 10       	IF !CC JUMP 0x0x8d584f38;
8d584f24:	4c 30       	R1 = P4;
8d584f26:	45 30       	R0 = P5;
8d584f28:	00 e3 8e 64 	CALL 0x0x8d591844;
8d584f2c:	26 e1 09 09 	R6 = 0x909 (X);		/*		R6=0x909(2313) */
8d584f30:	08 2e       	JUMP.S 0x0x8d584b40;
8d584f32:	00 00       	NOP;
8d584f34:	00 00       	NOP;
8d584f36:	00 00       	NOP;
8d584f38:	09 da 0a 84 	P1=-2079710932;
8d584f3c:	2c 21 00 00 
8d584f40:	f1 bc       	[SP + 0xc] = P1;
8d584f42:	22 e1 52 01 	R2 = 0x152 (X);		/*		R2=0x152(338) */
8d584f46:	01 da 0a 84 	R1=-2079711276;
8d584f4a:	d4 1f 00 00 
8d584f4e:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584f50:	00 de 04 8c 	CALL.A 0x8c040574;
8d584f54:	74 05 00 00 
8d584f58:	e6 2f       	JUMP.S 0x0x8d584f24;
8d584f5a:	00 00       	NOP;
8d584f5c:	00 00       	NOP;
8d584f5e:	00 00       	NOP;
8d584f60:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584f64:	fc 1e 00 00 
8d584f68:	98 0c       	CC = R0 < 0x3;
8d584f6a:	0b 10       	IF !CC JUMP 0x0x8d584f80;
8d584f6c:	4c 30       	R1 = P4;
8d584f6e:	45 30       	R0 = P5;
8d584f70:	00 e3 f8 64 	CALL 0x0x8d591960;
8d584f74:	26 e1 0a 09 	R6 = 0x90a (X);		/*		R6=0x90a(2314) */
8d584f78:	e4 2d       	JUMP.S 0x0x8d584b40;
8d584f7a:	00 00       	NOP;
8d584f7c:	00 00       	NOP;
8d584f7e:	00 00       	NOP;
8d584f80:	09 da 0a 84 	P1=-2079710912;
8d584f84:	40 21 00 00 
8d584f88:	f1 bc       	[SP + 0xc] = P1;
8d584f8a:	22 e1 57 01 	R2 = 0x157 (X);		/*		R2=0x157(343) */
8d584f8e:	01 da 0a 84 	R1=-2079711276;
8d584f92:	d4 1f 00 00 
8d584f96:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584f98:	00 de 04 8c 	CALL.A 0x8c040574;
8d584f9c:	74 05 00 00 
8d584fa0:	e6 2f       	JUMP.S 0x0x8d584f6c;
8d584fa2:	00 00       	NOP;
8d584fa4:	00 00       	NOP;
8d584fa6:	00 00       	NOP;
8d584fa8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584fac:	fc 1e 00 00 
8d584fb0:	98 0c       	CC = R0 < 0x3;
8d584fb2:	0b 10       	IF !CC JUMP 0x0x8d584fc8;
8d584fb4:	4c 30       	R1 = P4;
8d584fb6:	45 30       	R0 = P5;
8d584fb8:	00 e3 80 65 	CALL 0x0x8d591ab8;
8d584fbc:	26 e1 0b 09 	R6 = 0x90b (X);		/*		R6=0x90b(2315) */
8d584fc0:	c0 2d       	JUMP.S 0x0x8d584b40;
8d584fc2:	00 00       	NOP;
8d584fc4:	00 00       	NOP;
8d584fc6:	00 00       	NOP;
8d584fc8:	09 da 0a 84 	P1=-2079710892;
8d584fcc:	54 21 00 00 
8d584fd0:	f1 bc       	[SP + 0xc] = P1;
8d584fd2:	22 e1 5c 01 	R2 = 0x15c (X);		/*		R2=0x15c(348) */
8d584fd6:	01 da 0a 84 	R1=-2079711276;
8d584fda:	d4 1f 00 00 
8d584fde:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d584fe0:	00 de 04 8c 	CALL.A 0x8c040574;
8d584fe4:	74 05 00 00 
8d584fe8:	e6 2f       	JUMP.S 0x0x8d584fb4;
8d584fea:	00 00       	NOP;
8d584fec:	00 00       	NOP;
8d584fee:	00 00       	NOP;
8d584ff0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d584ff4:	fc 1e 00 00 
8d584ff8:	98 0c       	CC = R0 < 0x3;
8d584ffa:	0b 10       	IF !CC JUMP 0x0x8d585010;
8d584ffc:	4c 30       	R1 = P4;
8d584ffe:	45 30       	R0 = P5;
8d585000:	00 e3 a2 66 	CALL 0x0x8d591d44;
8d585004:	26 e1 0c 09 	R6 = 0x90c (X);		/*		R6=0x90c(2316) */
8d585008:	9c 2d       	JUMP.S 0x0x8d584b40;
8d58500a:	00 00       	NOP;
8d58500c:	00 00       	NOP;
8d58500e:	00 00       	NOP;
8d585010:	09 da 0a 84 	P1=-2079710872;
8d585014:	68 21 00 00 
8d585018:	f1 bc       	[SP + 0xc] = P1;
8d58501a:	22 e1 61 01 	R2 = 0x161 (X);		/*		R2=0x161(353) */
8d58501e:	01 da 0a 84 	R1=-2079711276;
8d585022:	d4 1f 00 00 
8d585026:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d585028:	00 de 04 8c 	CALL.A 0x8c040574;
8d58502c:	74 05 00 00 
8d585030:	e6 2f       	JUMP.S 0x0x8d584ffc;
8d585032:	00 00       	NOP;
8d585034:	00 00       	NOP;
8d585036:	00 00       	NOP;
8d585038:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d58503c:	fc 1e 00 00 
8d585040:	98 0c       	CC = R0 < 0x3;
8d585042:	0b 10       	IF !CC JUMP 0x0x8d585058;
8d585044:	4c 30       	R1 = P4;
8d585046:	45 30       	R0 = P5;
8d585048:	00 e3 86 69 	CALL 0x0x8d592354;
8d58504c:	26 e1 0d 09 	R6 = 0x90d (X);		/*		R6=0x90d(2317) */
8d585050:	78 2d       	JUMP.S 0x0x8d584b40;
8d585052:	00 00       	NOP;
8d585054:	00 00       	NOP;
8d585056:	00 00       	NOP;
8d585058:	09 da 0a 84 	P1=-2079710852;
8d58505c:	7c 21 00 00 
8d585060:	f1 bc       	[SP + 0xc] = P1;
8d585062:	22 e1 66 01 	R2 = 0x166 (X);		/*		R2=0x166(358) */
8d585066:	01 da 0a 84 	R1=-2079711276;
8d58506a:	d4 1f 00 00 
8d58506e:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d585070:	00 de 04 8c 	CALL.A 0x8c040574;
8d585074:	74 05 00 00 
8d585078:	e6 2f       	JUMP.S 0x0x8d585044;
8d58507a:	00 00       	NOP;
8d58507c:	00 00       	NOP;
8d58507e:	00 00       	NOP;
8d585080:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d585084:	fc 1e 00 00 
8d585088:	98 0c       	CC = R0 < 0x3;
8d58508a:	0b 10       	IF !CC JUMP 0x0x8d5850a0;
8d58508c:	4c 30       	R1 = P4;
8d58508e:	45 30       	R0 = P5;
8d585090:	00 e3 56 6c 	CALL 0x0x8d59293c;
8d585094:	26 e1 0e 09 	R6 = 0x90e (X);		/*		R6=0x90e(2318) */
8d585098:	54 2d       	JUMP.S 0x0x8d584b40;
8d58509a:	00 00       	NOP;
8d58509c:	00 00       	NOP;
8d58509e:	00 00       	NOP;
8d5850a0:	09 da 0a 84 	P1=-2079710832;
8d5850a4:	90 21 00 00 
8d5850a8:	f1 bc       	[SP + 0xc] = P1;
8d5850aa:	22 e1 6b 01 	R2 = 0x16b (X);		/*		R2=0x16b(363) */
8d5850ae:	01 da 0a 84 	R1=-2079711276;
8d5850b2:	d4 1f 00 00 
8d5850b6:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d5850b8:	00 de 04 8c 	CALL.A 0x8c040574;
8d5850bc:	74 05 00 00 
8d5850c0:	e6 2f       	JUMP.S 0x0x8d58508c;
8d5850c2:	00 00       	NOP;
8d5850c4:	00 00       	NOP;
8d5850c6:	00 00       	NOP;
8d5850c8:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5850cc:	fc 1e 00 00 
8d5850d0:	98 0c       	CC = R0 < 0x3;
8d5850d2:	0b 10       	IF !CC JUMP 0x0x8d5850e8;
8d5850d4:	4c 30       	R1 = P4;
8d5850d6:	45 30       	R0 = P5;
8d5850d8:	00 e3 fe 6f 	CALL 0x0x8d5930d4;
8d5850dc:	26 e1 0f 09 	R6 = 0x90f (X);		/*		R6=0x90f(2319) */
8d5850e0:	30 2d       	JUMP.S 0x0x8d584b40;
8d5850e2:	00 00       	NOP;
8d5850e4:	00 00       	NOP;
8d5850e6:	00 00       	NOP;
8d5850e8:	09 da 0a 84 	P1=-2079710812;
8d5850ec:	a4 21 00 00 
8d5850f0:	f1 bc       	[SP + 0xc] = P1;
8d5850f2:	22 e1 70 01 	R2 = 0x170 (X);		/*		R2=0x170(368) */
8d5850f6:	01 da 0a 84 	R1=-2079711276;
8d5850fa:	d4 1f 00 00 
8d5850fe:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d585100:	00 de 04 8c 	CALL.A 0x8c040574;
8d585104:	74 05 00 00 
8d585108:	e6 2f       	JUMP.S 0x0x8d5850d4;
8d58510a:	00 00       	NOP;
8d58510c:	00 00       	NOP;
8d58510e:	00 00       	NOP;
8d585110:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d585114:	fc 1e 00 00 
8d585118:	98 0c       	CC = R0 < 0x3;
8d58511a:	0b 10       	IF !CC JUMP 0x0x8d585130;
8d58511c:	4c 30       	R1 = P4;
8d58511e:	45 30       	R0 = P5;
8d585120:	00 e3 40 70 	CALL 0x0x8d5931a0;
8d585124:	26 e1 10 09 	R6 = 0x910 (X);		/*		R6=0x910(2320) */
8d585128:	0c 2d       	JUMP.S 0x0x8d584b40;
8d58512a:	00 00       	NOP;
8d58512c:	00 00       	NOP;
8d58512e:	00 00       	NOP;
8d585130:	09 da 0a 84 	P1=-2079710792;
8d585134:	b8 21 00 00 
8d585138:	f1 bc       	[SP + 0xc] = P1;
8d58513a:	22 e1 75 01 	R2 = 0x175 (X);		/*		R2=0x175(373) */
8d58513e:	01 da 0a 84 	R1=-2079711276;
8d585142:	d4 1f 00 00 
8d585146:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d585148:	00 de 04 8c 	CALL.A 0x8c040574;
8d58514c:	74 05 00 00 
8d585150:	e6 2f       	JUMP.S 0x0x8d58511c;
8d585152:	00 00       	NOP;
8d585154:	00 00       	NOP;
8d585156:	00 00       	NOP;
8d585158:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d58515c:	fc 1e 00 00 
8d585160:	98 0c       	CC = R0 < 0x3;
8d585162:	0b 10       	IF !CC JUMP 0x0x8d585178;
8d585164:	4c 30       	R1 = P4;
8d585166:	45 30       	R0 = P5;
8d585168:	00 e3 ae 73 	CALL 0x0x8d5938c4;
8d58516c:	26 e1 11 09 	R6 = 0x911 (X);		/*		R6=0x911(2321) */
8d585170:	e8 2c       	JUMP.S 0x0x8d584b40;
8d585172:	00 00       	NOP;
8d585174:	00 00       	NOP;
8d585176:	00 00       	NOP;
8d585178:	09 da 0a 84 	P1=-2079710772;
8d58517c:	cc 21 00 00 
8d585180:	f1 bc       	[SP + 0xc] = P1;
8d585182:	22 e1 7a 01 	R2 = 0x17a (X);		/*		R2=0x17a(378) */
8d585186:	01 da 0a 84 	R1=-2079711276;
8d58518a:	d4 1f 00 00 
8d58518e:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d585190:	00 de 04 8c 	CALL.A 0x8c040574;
8d585194:	74 05 00 00 
8d585198:	e6 2f       	JUMP.S 0x0x8d585164;
8d58519a:	00 00       	NOP;
8d58519c:	00 00       	NOP;
8d58519e:	00 00       	NOP;
8d5851a0:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d5851a4:	fc 1e 00 00 
8d5851a8:	98 0c       	CC = R0 < 0x3;
8d5851aa:	0b 10       	IF !CC JUMP 0x0x8d5851c0;
8d5851ac:	4c 30       	R1 = P4;
8d5851ae:	45 30       	R0 = P5;
8d5851b0:	00 e3 86 76 	CALL 0x0x8d593ebc;
8d5851b4:	26 e1 12 09 	R6 = 0x912 (X);		/*		R6=0x912(2322) */
8d5851b8:	c4 2c       	JUMP.S 0x0x8d584b40;
8d5851ba:	00 00       	NOP;
8d5851bc:	00 00       	NOP;
8d5851be:	00 00       	NOP;
8d5851c0:	09 da 0a 84 	P1=-2079710752;
8d5851c4:	e0 21 00 00 
8d5851c8:	f1 bc       	[SP + 0xc] = P1;
8d5851ca:	22 e1 7f 01 	R2 = 0x17f (X);		/*		R2=0x17f(383) */
8d5851ce:	01 da 0a 84 	R1=-2079711276;
8d5851d2:	d4 1f 00 00 
8d5851d6:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d5851d8:	00 de 04 8c 	CALL.A 0x8c040574;
8d5851dc:	74 05 00 00 
8d5851e0:	e6 2f       	JUMP.S 0x0x8d5851ac;
8d5851e2:	98 0c       	CC = R0 < 0x3;
8d5851e4:	0a 10       	IF !CC JUMP 0x0x8d5851f8;
8d5851e6:	4c 30       	R1 = P4;
8d5851e8:	45 30       	R0 = P5;
8d5851ea:	00 e3 fd 79 	CALL 0x0x8d5945e4;
8d5851ee:	35 30       	R6 = R5;
8d5851f0:	a8 2c       	JUMP.S 0x0x8d584b40;
8d5851f2:	00 00       	NOP;
8d5851f4:	00 00       	NOP;
8d5851f6:	00 00       	NOP;
8d5851f8:	09 da 0a 84 	P1=-2079710732;
8d5851fc:	f4 21 00 00 
8d585200:	f1 bc       	[SP + 0xc] = P1;
8d585202:	22 e1 84 01 	R2 = 0x184 (X);		/*		R2=0x184(388) */
8d585206:	01 da 0a 84 	R1=-2079711276;
8d58520a:	d4 1f 00 00 
8d58520e:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d585210:	00 de 04 8c 	CALL.A 0x8c040574;
8d585214:	74 05 00 00 
8d585218:	e7 2f       	JUMP.S 0x0x8d5851e6;
8d58521a:	00 00       	NOP;
8d58521c:	00 00       	NOP;
8d58521e:	00 00       	NOP;
