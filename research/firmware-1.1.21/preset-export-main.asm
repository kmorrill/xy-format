
os.ldr@0x8d4dec6c:     file format binary


Disassembly of section .data:

8d4dec6c <.data>:
8d4dec6c:	00 e8 27 00 	LINK 0x9c;		/* (156) */
8d4dec70:	e3 05       	[--SP] = (R7:4, P5:3);
8d4dec72:	57 30       	R2 = FP;
8d4dec74:	86 6f       	SP += -0x10;		/* (-16) */
8d4dec76:	22 66       	R2 += -0x3c;		/* (-60) */
8d4dec78:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || [FP -0x70] = R2 || NOP;
8d4dec7c:	42 ba 00 00 
8d4dec80:	30 30       	R6 = R0;
8d4dec82:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4dec84:	d4 61       	R4 = 0x3a (X);		/*		R4=0x0(  0) */
8d4dec86:	40 b8       	R0 = [FP -0x70];
8d4dec88:	00 de 05 8c 	CALL.A 0x8c053038;
8d4dec8c:	38 30 00 00 
8d4dec90:	07 30       	R0 = R7;
8d4dec92:	04 e3 4d 97 	CALL 0x0x8d571b2c;
8d4dec96:	a0 ba       	[FP -0x58] = R0;
8d4dec98:	ac b8       	P4 = [FP -0x58];
8d4dec9a:	29 e1 64 38 	P1 = 0x3864 (X);		/*		P1=0x3864(14436) */
8d4dec9e:	7a 43       	R2 = R7.B (Z);
8d4deca0:	d2 ba       	[FP -0x4c] = R2;
8d4deca2:	4c 5b       	P5 = P4 + P1;
8d4deca4:	6d 30       	R5 = P5;
8d4deca6:	28 90       	R0 = [P5++];
8d4deca8:	80 0c       	CC = R0 < 0x0;
8d4decaa:	03 14       	IF !CC JUMP 0x0x8d4decb0 (BP);
8d4decac:	00 e2 2e 0d 	JUMP.L 0x0x8d4e0708;
8d4decb0:	fc 67       	R4 += -0x1;		/* ( -1) */
8d4decb2:	04 0c       	CC = R4 == 0x0;
8d4decb4:	f9 17       	IF !CC JUMP 0x0x8d4deca6 (BP);
8d4decb6:	02 da 03 84 	R2=-2080152904;
8d4decba:	b8 62 00 00 
8d4decbe:	46 64       	R6 += 0x8;		/* (  8) */
8d4decc0:	42 64       	R2 += 0x8;		/* (  8) */
8d4decc2:	be b0       	[FP + 0x8] = R6;
8d4decc4:	72 ba       	[FP -0x64] = R2;
8d4decc6:	24 e1 84 01 	R4 = 0x184 (X);		/*		R4=0x184(388) */
8d4decca:	b8 a0       	R0 = [FP + 0x8];
8d4deccc:	71 b8       	R1 = [FP -0x64];
8d4decce:	00 de 05 8c 	CALL.A 0x8c053314;
8d4decd2:	14 33 00 00 
8d4decd6:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [P4 + 0x18] || NOP;
8d4decda:	a0 a1 00 00 
8d4decde:	06 e3 a1 1a 	CALL 0x0x8d5a2220;
8d4dece2:	56 30       	R2 = SP;
8d4dece4:	23 e1 80 00 	R3 = 0x80 (X);		/*		R3=0x80(128) */
8d4dece8:	9a 51       	R6 = R2 + R3;
8d4decea:	08 30       	R1 = R0;
8d4decec:	06 30       	R0 = R6;
8d4decee:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4decf2:	a8 19 00 00 
8d4decf6:	07 30       	R0 = R7;
8d4decf8:	0e 30       	R1 = R6;
8d4decfa:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4decfe:	10 1b 00 00 
8d4ded02:	06 30       	R0 = R6;
8d4ded04:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4ded08:	38 1a 00 00 
8d4ded0c:	02 da 03 84 	R2=-2080152904;
8d4ded10:	b8 62 00 00 
8d4ded14:	04 cc 14 02 	R1 = R2 + R4 (NS) || R0 = [FP + 0x8] || NOP;
8d4ded18:	b8 a0 00 00 
8d4ded1c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ded20:	14 33 00 00 
8d4ded24:	38 30       	R7 = R0;
8d4ded26:	06 30       	R0 = R6;
8d4ded28:	21 60       	R1 = 0x4 (X);		/*		R1=0x0(  0) */
8d4ded2a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4ded2e:	96 10 00 00 
8d4ded32:	07 30       	R0 = R7;
8d4ded34:	0e 30       	R1 = R6;
8d4ded36:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4ded3a:	10 1b 00 00 
8d4ded3e:	06 30       	R0 = R6;
8d4ded40:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4ded44:	38 1a 00 00 
8d4ded48:	04 da 03 84 	R4=-2080152904;
8d4ded4c:	b8 62 00 00 
8d4ded50:	22 e1 70 01 	R2 = 0x170 (X);		/*		R2=0x170(368) */
8d4ded54:	04 cc 22 02 	R1 = R4 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4ded58:	b8 a0 00 00 
8d4ded5c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4ded60:	14 33 00 00 
8d4ded64:	23 e1 7c 01 	R3 = 0x17c (X);		/*		R3=0x17c(380) */
8d4ded68:	02 da 03 84 	R2=-2080152904;
8d4ded6c:	b8 62 00 00 
8d4ded70:	38 30       	R7 = R0;
8d4ded72:	5a 50       	R1 = R2 + R3;
8d4ded74:	06 30       	R0 = R6;
8d4ded76:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4ded7a:	a8 19 00 00 
8d4ded7e:	07 30       	R0 = R7;
8d4ded80:	0e 30       	R1 = R6;
8d4ded82:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4ded86:	10 1b 00 00 
8d4ded8a:	06 30       	R0 = R6;
8d4ded8c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4ded90:	38 1a 00 00 
8d4ded94:	04 cc 24 48 	R4 = R4 - R4 (NS) || R0 = [FP + 0x8] || NOP;
8d4ded98:	b8 a0 00 00 
8d4ded9c:	01 da 03 84 	R1=-2080152904;
8d4deda0:	b8 62 00 00 
8d4deda4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4deda8:	14 33 00 00 
8d4dedac:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [FP -0x4c] || NOP;
8d4dedb0:	d0 b8 00 00 
8d4dedb4:	04 e3 9e 87 	CALL 0x0x8d56fcf0;
8d4dedb8:	08 30       	R1 = R0;
8d4dedba:	06 30       	R0 = R6;
8d4dedbc:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dedc0:	96 10 00 00 
8d4dedc4:	07 30       	R0 = R7;
8d4dedc6:	0e 30       	R1 = R6;
8d4dedc8:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dedcc:	10 1b 00 00 
8d4dedd0:	06 30       	R0 = R6;
8d4dedd2:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dedd6:	38 1a 00 00 
8d4dedda:	22 e1 48 01 	R2 = 0x148 (X);		/*		R2=0x148(328) */
8d4dedde:	03 da 03 84 	R3=-2080152904;
8d4dede2:	b8 62 00 00 
8d4dede6:	04 cc 1a 04 	R2 = R3 + R2 (NS) || R0 = [FP + 0x8] || NOP;
8d4dedea:	b8 a0 00 00 
8d4dedee:	d2 ba       	[FP -0x4c] = R2;
8d4dedf0:	d1 b8       	R1 = [FP -0x4c];
8d4dedf2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dedf6:	14 33 00 00 
8d4dedfa:	38 30       	R7 = R0;
8d4dedfc:	06 30       	R0 = R6;
8d4dedfe:	39 60       	R1 = 0x7 (X);		/*		R1=0x0(  0) */
8d4dee00:	00 de 05 8c 	CALL.A 0x8c053038;
8d4dee04:	38 30 00 00 
8d4dee08:	07 30       	R0 = R7;
8d4dee0a:	0e 30       	R1 = R6;
8d4dee0c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dee10:	10 1b 00 00 
8d4dee14:	06 30       	R0 = R6;
8d4dee16:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dee1a:	38 1a 00 00 
8d4dee1e:	22 e1 8c 01 	R2 = 0x18c (X);		/*		R2=0x18c(396) */
8d4dee22:	03 da 03 84 	R3=-2080152904;
8d4dee26:	b8 62 00 00 
8d4dee2a:	93 50       	R2 = R3 + R2;
8d4dee2c:	82 ba       	[FP -0x60] = R2;
8d4dee2e:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dee32:	d1 b8 b8 a0 
8d4dee36:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dee3a:	14 33 00 00 
8d4dee3e:	81 b8       	R1 = [FP -0x60];
8d4dee40:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dee44:	14 33 00 00 
8d4dee48:	0c 30       	R1 = R4;
8d4dee4a:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4dee4e:	e4 30 00 00 
8d4dee52:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP + 0xc] = R0 || NOP;
8d4dee56:	f8 b0 00 00 
8d4dee5a:	7f 30       	R7 = FP;
8d4dee5c:	ff e3 95 f6 	CALL 0x0x8d4ddb86;
8d4dee60:	87 66       	R7 += -0x30;		/* (-48) */
8d4dee62:	08 30       	R1 = R0;
8d4dee64:	07 30       	R0 = R7;
8d4dee66:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dee6a:	96 10 00 00 
8d4dee6e:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4dee72:	f8 a0 00 00 
8d4dee76:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dee7a:	10 1b 00 00 
8d4dee7e:	07 30       	R0 = R7;
8d4dee80:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dee84:	38 1a 00 00 
8d4dee88:	0c 64       	R4 += 0x1;		/* (  1) */
8d4dee8a:	42 60       	R2 = 0x8 (X);		/*		R2=0x18c(396) */
8d4dee8c:	94 08       	CC = R4 < R2;
8d4dee8e:	25 64       	R5 += 0x4;		/* (  4) */
8d4dee90:	cf 1f       	IF CC JUMP 0x0x8d4dee2e (BP);
8d4dee92:	22 e1 34 02 	R2 = 0x234 (X);		/*		R2=0x234(564) */
8d4dee96:	07 da 03 84 	R7=-2080152904;
8d4dee9a:	b8 62 00 00 
8d4dee9e:	04 cc 3a 04 	R2 = R7 + R2 (NS) || R7 = [FP -0x58] || NOP;
8d4deea2:	a7 b8 00 00 
8d4deea6:	20 e1 24 02 	R0 = 0x224 (X);		/*		R0=0x224(548) */
8d4deeaa:	04 da 03 84 	R4=-2080152904;
8d4deeae:	b8 62 00 00 
8d4deeb2:	23 e1 84 38 	R3 = 0x3884 (X);		/*		R3=0x3884(14468) */
8d4deeb6:	04 cc 20 08 	R4 = R4 + R0 (NS) || [FP + 0xc] = R2 || NOP;
8d4deeba:	fa b0 00 00 
8d4deebe:	df 51       	R7 = R7 + R3;
8d4deec0:	20 e1 3c 02 	R0 = 0x23c (X);		/*		R0=0x23c(572) */
8d4deec4:	03 da 03 84 	R3=-2080152904;
8d4deec8:	b8 62 00 00 
8d4deecc:	03 50       	R0 = R3 + R0;
8d4deece:	21 e1 30 02 	R1 = 0x230 (X);		/*		R1=0x230(560) */
8d4deed2:	05 da 03 84 	R5=-2080152904;
8d4deed6:	b8 62 00 00 
8d4deeda:	04 cc 29 0a 	R5 = R5 + R1 (NS) || [FP -0x50] = R0 || NOP;
8d4deede:	c0 ba 00 00 
8d4deee2:	00 da 03 84 	R0=-2080152904;
8d4deee6:	b8 62 00 00 
8d4deeea:	21 e1 44 02 	R1 = 0x244 (X);		/*		R1=0x244(580) */
8d4deeee:	04 cc 01 02 	R1 = R0 + R1 (NS) || R0 = [FP + 0x8] || NOP;
8d4deef2:	b8 a0 00 00 
8d4deef6:	b1 ba       	[FP -0x54] = R1;
8d4deef8:	22 e1 4c 02 	R2 = 0x24c (X);		/*		R2=0x24c(588) */
8d4deefc:	01 da 03 84 	R1=-2080152904;
8d4def00:	b8 62 00 00 
8d4def04:	91 50       	R2 = R1 + R2;
8d4def06:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [FP -0x68] = R2 || NOP;
8d4def0a:	62 ba 00 00 
8d4def0e:	23 e1 54 02 	R3 = 0x254 (X);		/*		R3=0x254(596) */
8d4def12:	02 da 03 84 	R2=-2080152904;
8d4def16:	b8 62 00 00 
8d4def1a:	da 50       	R3 = R2 + R3;
8d4def1c:	93 ba       	[FP -0x5c] = R3;
8d4def1e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4def22:	14 33 00 00 
8d4def26:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x6c] = R0 || NOP;
8d4def2a:	50 ba 00 00 
8d4def2e:	39 60       	R1 = 0x7 (X);		/*		R1=0x244(580) */
8d4def30:	00 de 05 8c 	CALL.A 0x8c053038;
8d4def34:	38 30 00 00 
8d4def38:	0e 30       	R1 = R6;
8d4def3a:	50 b8       	R0 = [FP -0x6c];
8d4def3c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4def40:	10 1b 00 00 
8d4def44:	06 30       	R0 = R6;
8d4def46:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4def4a:	38 1a 00 00 
8d4def4e:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4def52:	b8 a0 00 00 
8d4def56:	00 de 05 8c 	CALL.A 0x8c053314;
8d4def5a:	14 33 00 00 
8d4def5e:	0d 30       	R1 = R5;
8d4def60:	00 de 05 8c 	CALL.A 0x8c053314;
8d4def64:	14 33 00 00 
8d4def68:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x6c] = R0 || NOP;
8d4def6c:	50 ba 00 00 
8d4def70:	39 60       	R1 = 0x7 (X);		/*		R1=0x244(580) */
8d4def72:	00 de 05 8c 	CALL.A 0x8c053038;
8d4def76:	38 30 00 00 
8d4def7a:	0e 30       	R1 = R6;
8d4def7c:	50 b8       	R0 = [FP -0x6c];
8d4def7e:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4def82:	10 1b 00 00 
8d4def86:	06 30       	R0 = R6;
8d4def88:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4def8c:	38 1a 00 00 
8d4def90:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4def94:	b8 a0 00 00 
8d4def98:	00 de 05 8c 	CALL.A 0x8c053314;
8d4def9c:	14 33 00 00 
8d4defa0:	0d 30       	R1 = R5;
8d4defa2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4defa6:	14 33 00 00 
8d4defaa:	f9 a0       	R1 = [FP + 0xc];
8d4defac:	00 de 05 8c 	CALL.A 0x8c053314;
8d4defb0:	14 33 00 00 
8d4defb4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP -0x6c] = R0 || NOP;
8d4defb8:	50 ba 00 00 
8d4defbc:	ff e3 e5 f5 	CALL 0x0x8d4ddb86;
8d4defc0:	08 30       	R1 = R0;
8d4defc2:	06 30       	R0 = R6;
8d4defc4:	00 de 05 8c 	CALL.A 0x8c051096;
8d4defc8:	96 10 00 00 
8d4defcc:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP -0x6c] || NOP;
8d4defd0:	50 b8 00 00 
8d4defd4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4defd8:	10 1b 00 00 
8d4defdc:	06 30       	R0 = R6;
8d4defde:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4defe2:	38 1a 00 00 
8d4defe6:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4defea:	b8 a0 00 00 
8d4defee:	00 de 05 8c 	CALL.A 0x8c053314;
8d4deff2:	14 33 00 00 
8d4deff6:	0d 30       	R1 = R5;
8d4deff8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4deffc:	14 33 00 00 
8d4df000:	c1 b8       	R1 = [FP -0x50];
8d4df002:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df006:	14 33 00 00 
8d4df00a:	22 e1 88 38 	R2 = 0x3888 (X);		/*		R2=0x3888(14472) */
8d4df00e:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP -0x6c] = R0;
8d4df012:	a3 b8 50 ba 
8d4df016:	13 50       	R0 = R3 + R2;
8d4df018:	ff e3 b7 f5 	CALL 0x0x8d4ddb86;
8d4df01c:	08 30       	R1 = R0;
8d4df01e:	06 30       	R0 = R6;
8d4df020:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df024:	96 10 00 00 
8d4df028:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP -0x6c] || NOP;
8d4df02c:	50 b8 00 00 
8d4df030:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df034:	10 1b 00 00 
8d4df038:	06 30       	R0 = R6;
8d4df03a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df03e:	38 1a 00 00 
8d4df042:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df046:	b8 a0 00 00 
8d4df04a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df04e:	14 33 00 00 
8d4df052:	0d 30       	R1 = R5;
8d4df054:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df058:	14 33 00 00 
8d4df05c:	b1 b8       	R1 = [FP -0x54];
8d4df05e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df062:	14 33 00 00 
8d4df066:	22 e1 8c 38 	R2 = 0x388c (X);		/*		R2=0x388c(14476) */
8d4df06a:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP -0x6c] = R0;
8d4df06e:	a3 b8 50 ba 
8d4df072:	13 50       	R0 = R3 + R2;
8d4df074:	ff e3 89 f5 	CALL 0x0x8d4ddb86;
8d4df078:	08 30       	R1 = R0;
8d4df07a:	06 30       	R0 = R6;
8d4df07c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df080:	96 10 00 00 
8d4df084:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP -0x6c] || NOP;
8d4df088:	50 b8 00 00 
8d4df08c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df090:	10 1b 00 00 
8d4df094:	06 30       	R0 = R6;
8d4df096:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df09a:	38 1a 00 00 
8d4df09e:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df0a2:	b8 a0 00 00 
8d4df0a6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df0aa:	14 33 00 00 
8d4df0ae:	0d 30       	R1 = R5;
8d4df0b0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df0b4:	14 33 00 00 
8d4df0b8:	61 b8       	R1 = [FP -0x68];
8d4df0ba:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df0be:	14 33 00 00 
8d4df0c2:	22 e1 90 38 	R2 = 0x3890 (X);		/*		R2=0x3890(14480) */
8d4df0c6:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df0ca:	a3 b8 00 00 
8d4df0ce:	13 50       	R0 = R3 + R2;
8d4df0d0:	ff e3 5b f5 	CALL 0x0x8d4ddb86;
8d4df0d4:	08 30       	R1 = R0;
8d4df0d6:	06 30       	R0 = R6;
8d4df0d8:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df0dc:	96 10 00 00 
8d4df0e0:	05 30       	R0 = R5;
8d4df0e2:	0e 30       	R1 = R6;
8d4df0e4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df0e8:	10 1b 00 00 
8d4df0ec:	06 30       	R0 = R6;
8d4df0ee:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df0f2:	38 1a 00 00 
8d4df0f6:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df0fa:	b8 a0 00 00 
8d4df0fe:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df102:	14 33 00 00 
8d4df106:	91 b8       	R1 = [FP -0x5c];
8d4df108:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df10c:	14 33 00 00 
8d4df110:	28 30       	R5 = R0;
8d4df112:	06 30       	R0 = R6;
8d4df114:	39 60       	R1 = 0x7 (X);		/*		R1=0x244(580) */
8d4df116:	00 de 05 8c 	CALL.A 0x8c053038;
8d4df11a:	38 30 00 00 
8d4df11e:	05 30       	R0 = R5;
8d4df120:	0e 30       	R1 = R6;
8d4df122:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df126:	10 1b 00 00 
8d4df12a:	06 30       	R0 = R6;
8d4df12c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df130:	38 1a 00 00 
8d4df134:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df138:	b8 a0 00 00 
8d4df13c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df140:	14 33 00 00 
8d4df144:	91 b8       	R1 = [FP -0x5c];
8d4df146:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df14a:	14 33 00 00 
8d4df14e:	f9 a0       	R1 = [FP + 0xc];
8d4df150:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df154:	14 33 00 00 
8d4df158:	22 e1 e4 38 	R2 = 0x38e4 (X);		/*		R2=0x38e4(14564) */
8d4df15c:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df160:	a3 b8 00 00 
8d4df164:	13 50       	R0 = R3 + R2;
8d4df166:	ff e3 10 f5 	CALL 0x0x8d4ddb86;
8d4df16a:	08 30       	R1 = R0;
8d4df16c:	06 30       	R0 = R6;
8d4df16e:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df172:	96 10 00 00 
8d4df176:	05 30       	R0 = R5;
8d4df178:	0e 30       	R1 = R6;
8d4df17a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df17e:	10 1b 00 00 
8d4df182:	06 30       	R0 = R6;
8d4df184:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df188:	38 1a 00 00 
8d4df18c:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df190:	b8 a0 00 00 
8d4df194:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df198:	14 33 00 00 
8d4df19c:	91 b8       	R1 = [FP -0x5c];
8d4df19e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df1a2:	14 33 00 00 
8d4df1a6:	c1 b8       	R1 = [FP -0x50];
8d4df1a8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df1ac:	14 33 00 00 
8d4df1b0:	22 e1 e8 38 	R2 = 0x38e8 (X);		/*		R2=0x38e8(14568) */
8d4df1b4:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df1b8:	a3 b8 00 00 
8d4df1bc:	13 50       	R0 = R3 + R2;
8d4df1be:	ff e3 e4 f4 	CALL 0x0x8d4ddb86;
8d4df1c2:	08 30       	R1 = R0;
8d4df1c4:	06 30       	R0 = R6;
8d4df1c6:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df1ca:	96 10 00 00 
8d4df1ce:	05 30       	R0 = R5;
8d4df1d0:	0e 30       	R1 = R6;
8d4df1d2:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df1d6:	10 1b 00 00 
8d4df1da:	06 30       	R0 = R6;
8d4df1dc:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df1e0:	38 1a 00 00 
8d4df1e4:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4df1e8:	b8 a0 00 00 
8d4df1ec:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df1f0:	14 33 00 00 
8d4df1f4:	91 b8       	R1 = [FP -0x5c];
8d4df1f6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df1fa:	14 33 00 00 
8d4df1fe:	b1 b8       	R1 = [FP -0x54];
8d4df200:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df204:	14 33 00 00 
8d4df208:	22 e1 ec 38 	R2 = 0x38ec (X);		/*		R2=0x38ec(14572) */
8d4df20c:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df210:	a3 b8 00 00 
8d4df214:	13 50       	R0 = R3 + R2;
8d4df216:	ff e3 b8 f4 	CALL 0x0x8d4ddb86;
8d4df21a:	08 30       	R1 = R0;
8d4df21c:	06 30       	R0 = R6;
8d4df21e:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df222:	96 10 00 00 
8d4df226:	05 30       	R0 = R5;
8d4df228:	0e 30       	R1 = R6;
8d4df22a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df22e:	10 1b 00 00 
8d4df232:	06 30       	R0 = R6;
8d4df234:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df238:	38 1a 00 00 
8d4df23c:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0x8] || R4 = [FP -0x58];
8d4df240:	b8 a0 a4 b8 
8d4df244:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df248:	14 33 00 00 
8d4df24c:	91 b8       	R1 = [FP -0x5c];
8d4df24e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df252:	14 33 00 00 
8d4df256:	61 b8       	R1 = [FP -0x68];
8d4df258:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df25c:	14 33 00 00 
8d4df260:	22 e1 f0 38 	R2 = 0x38f0 (X);		/*		R2=0x38f0(14576) */
8d4df264:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4df268:	a3 b8 00 00 
8d4df26c:	13 50       	R0 = R3 + R2;
8d4df26e:	ff e3 8c f4 	CALL 0x0x8d4ddb86;
8d4df272:	08 30       	R1 = R0;
8d4df274:	06 30       	R0 = R6;
8d4df276:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df27a:	96 10 00 00 
8d4df27e:	05 30       	R0 = R5;
8d4df280:	0e 30       	R1 = R6;
8d4df282:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df286:	10 1b 00 00 
8d4df28a:	06 30       	R0 = R6;
8d4df28c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df290:	38 1a 00 00 
8d4df294:	a0 a1       	R0 = [P4 + 0x18];
8d4df296:	e9 60       	R1 = 0x1d (X);		/*		R1=0x244(580) */
8d4df298:	08 08       	CC = R0 == R1;
8d4df29a:	03 1c       	IF CC JUMP 0x0x8d4df2a0 (BP);
8d4df29c:	00 e2 8a 09 	JUMP.L 0x0x8d4e05b0;
8d4df2a0:	20 e1 6c 02 	R0 = 0x26c (X);		/*		R0=0x26c(620) */
8d4df2a4:	02 da 03 84 	R2=-2080152904;
8d4df2a8:	b8 62 00 00 
8d4df2ac:	21 e1 70 02 	R1 = 0x270 (X);		/*		R1=0x270(624) */
8d4df2b0:	03 da 03 84 	R3=-2080152904;
8d4df2b4:	b8 62 00 00 
8d4df2b8:	02 50       	R0 = R2 + R0;
8d4df2ba:	04 cc 19 02 	R1 = R3 + R1 (NS) || [FP -0x5c] = R0 || NOP;
8d4df2be:	90 ba 00 00 
8d4df2c2:	f9 b0       	[FP + 0xc] = R1;
8d4df2c4:	05 60       	R5 = 0x0 (X);		/*		R5=0x0(  0) */
8d4df2c6:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df2ca:	d1 b8 b8 a0 
8d4df2ce:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df2d2:	14 33 00 00 
8d4df2d6:	91 b8       	R1 = [FP -0x5c];
8d4df2d8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df2dc:	14 33 00 00 
8d4df2e0:	0d 30       	R1 = R5;
8d4df2e2:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df2e6:	e4 30 00 00 
8d4df2ea:	f9 a0       	R1 = [FP + 0xc];
8d4df2ec:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df2f0:	14 33 00 00 
8d4df2f4:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP -0x50] = R0 || NOP;
8d4df2f8:	c0 ba 00 00 
8d4df2fc:	67 30       	R4 = FP;
8d4df2fe:	ff e3 9a f4 	CALL 0x0x8d4ddc32;
8d4df302:	84 66       	R4 += -0x30;		/* (-48) */
8d4df304:	08 30       	R1 = R0;
8d4df306:	04 30       	R0 = R4;
8d4df308:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df30c:	96 10 00 00 
8d4df310:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x50] || NOP;
8d4df314:	c0 b8 00 00 
8d4df318:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df31c:	10 1b 00 00 
8d4df320:	04 30       	R0 = R4;
8d4df322:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df326:	38 1a 00 00 
8d4df32a:	0d 64       	R5 += 0x1;		/* (  1) */
8d4df32c:	22 60       	R2 = 0x4 (X);		/*		R2=0x38f0(14576) */
8d4df32e:	95 08       	CC = R5 < R2;
8d4df330:	27 64       	R7 += 0x4;		/* (  4) */
8d4df332:	ca 1f       	IF CC JUMP 0x0x8d4df2c6 (BP);
8d4df334:	20 e1 a4 38 	R0 = 0x38a4 (X);		/*		R0=0x38a4(14500) */
8d4df338:	a1 b8       	R1 = [FP -0x58];
8d4df33a:	01 50       	R0 = R1 + R0;
8d4df33c:	c0 ba       	[FP -0x50] = R0;
8d4df33e:	27 60       	R7 = 0x4 (X);		/*		R7=0x0(  0) */
8d4df340:	25 60       	R5 = 0x4 (X);		/*		R5=0x0(  0) */
8d4df342:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df346:	d1 b8 b8 a0 
8d4df34a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df34e:	14 33 00 00 
8d4df352:	91 b8       	R1 = [FP -0x5c];
8d4df354:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df358:	14 33 00 00 
8d4df35c:	0d 30       	R1 = R5;
8d4df35e:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df362:	e4 30 00 00 
8d4df366:	f9 a0       	R1 = [FP + 0xc];
8d4df368:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df36c:	14 33 00 00 
8d4df370:	03 c8 00 18 	MNOP || [FP -0x54] = R0 || R0 = [FP -0x50];
8d4df374:	b0 ba c0 b8 
8d4df378:	67 30       	R4 = FP;
8d4df37a:	ff e3 5c f4 	CALL 0x0x8d4ddc32;
8d4df37e:	84 66       	R4 += -0x30;		/* (-48) */
8d4df380:	08 30       	R1 = R0;
8d4df382:	04 30       	R0 = R4;
8d4df384:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df388:	96 10 00 00 
8d4df38c:	0d 64       	R5 += 0x1;		/* (  1) */
8d4df38e:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x54] || [FP -0x68] = R5;
8d4df392:	b0 b8 65 ba 
8d4df396:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df39a:	10 1b 00 00 
8d4df39e:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R5 = [FP -0x50] || NOP;
8d4df3a2:	c5 b8 00 00 
8d4df3a6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df3aa:	38 1a 00 00 
8d4df3ae:	ff 67       	R7 += -0x1;		/* ( -1) */
8d4df3b0:	25 64       	R5 += 0x4;		/* (  4) */
8d4df3b2:	07 0c       	CC = R7 == 0x0;
8d4df3b4:	03 c8 00 18 	MNOP || [FP -0x50] = R5 || R5 = [FP -0x68];
8d4df3b8:	c5 ba 65 b8 
8d4df3bc:	c3 17       	IF !CC JUMP 0x0x8d4df342 (BP);
8d4df3be:	20 e1 94 38 	R0 = 0x3894 (X);		/*		R0=0x3894(14484) */
8d4df3c2:	a1 b8       	R1 = [FP -0x58];
8d4df3c4:	c1 51       	R7 = R1 + R0;
8d4df3c6:	05 60       	R5 = 0x0 (X);		/*		R5=0x0(  0) */
8d4df3c8:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df3cc:	d1 b8 b8 a0 
8d4df3d0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df3d4:	14 33 00 00 
8d4df3d8:	91 b8       	R1 = [FP -0x5c];
8d4df3da:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df3de:	14 33 00 00 
8d4df3e2:	0d 30       	R1 = R5;
8d4df3e4:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df3e8:	e4 30 00 00 
8d4df3ec:	91 b8       	R1 = [FP -0x5c];
8d4df3ee:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df3f2:	14 33 00 00 
8d4df3f6:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [FP + 0xc] = R0 || NOP;
8d4df3fa:	f8 b0 00 00 
8d4df3fe:	67 30       	R4 = FP;
8d4df400:	ff e3 d8 f3 	CALL 0x0x8d4ddbb0;
8d4df404:	84 66       	R4 += -0x30;		/* (-48) */
8d4df406:	08 30       	R1 = R0;
8d4df408:	04 30       	R0 = R4;
8d4df40a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df40e:	96 10 00 00 
8d4df412:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4df416:	f8 a0 00 00 
8d4df41a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df41e:	10 1b 00 00 
8d4df422:	04 30       	R0 = R4;
8d4df424:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df428:	38 1a 00 00 
8d4df42c:	0d 64       	R5 += 0x1;		/* (  1) */
8d4df42e:	22 60       	R2 = 0x4 (X);		/*		R2=0x38f0(14576) */
8d4df430:	95 08       	CC = R5 < R2;
8d4df432:	27 64       	R7 += 0x4;		/* (  4) */
8d4df434:	ca 1f       	IF CC JUMP 0x0x8d4df3c8 (BP);
8d4df436:	20 e1 b4 38 	R0 = 0x38b4 (X);		/*		R0=0x38b4(14516) */
8d4df43a:	a1 b8       	R1 = [FP -0x58];
8d4df43c:	01 50       	R0 = R1 + R0;
8d4df43e:	f8 b0       	[FP + 0xc] = R0;
8d4df440:	27 60       	R7 = 0x4 (X);		/*		R7=0x0(  0) */
8d4df442:	25 60       	R5 = 0x4 (X);		/*		R5=0x0(  0) */
8d4df444:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df448:	d1 b8 b8 a0 
8d4df44c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df450:	14 33 00 00 
8d4df454:	91 b8       	R1 = [FP -0x5c];
8d4df456:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df45a:	14 33 00 00 
8d4df45e:	0d 30       	R1 = R5;
8d4df460:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df464:	e4 30 00 00 
8d4df468:	91 b8       	R1 = [FP -0x5c];
8d4df46a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df46e:	14 33 00 00 
8d4df472:	03 c8 00 18 	MNOP || [FP -0x54] = R0 || R0 = [FP + 0xc];
8d4df476:	b0 ba f8 a0 
8d4df47a:	67 30       	R4 = FP;
8d4df47c:	ff e3 9a f3 	CALL 0x0x8d4ddbb0;
8d4df480:	84 66       	R4 += -0x30;		/* (-48) */
8d4df482:	08 30       	R1 = R0;
8d4df484:	04 30       	R0 = R4;
8d4df486:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df48a:	96 10 00 00 
8d4df48e:	0d 64       	R5 += 0x1;		/* (  1) */
8d4df490:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x54] || [FP -0x50] = R5;
8d4df494:	b0 b8 c5 ba 
8d4df498:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df49c:	10 1b 00 00 
8d4df4a0:	82 ce 04 c0 	R0 = ROT R4 BY 0x0 || R5 = [FP + 0xc] || NOP;
8d4df4a4:	fd a0 00 00 
8d4df4a8:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df4ac:	38 1a 00 00 
8d4df4b0:	ff 67       	R7 += -0x1;		/* ( -1) */
8d4df4b2:	25 64       	R5 += 0x4;		/* (  4) */
8d4df4b4:	07 0c       	CC = R7 == 0x0;
8d4df4b6:	03 c8 00 18 	MNOP || [FP + 0xc] = R5 || R5 = [FP -0x50];
8d4df4ba:	fd b0 c5 b8 
8d4df4be:	c3 17       	IF !CC JUMP 0x0x8d4df444 (BP);
8d4df4c0:	22 e1 5c 02 	R2 = 0x25c (X);		/*		R2=0x25c(604) */
8d4df4c4:	07 da 03 84 	R7=-2080152904;
8d4df4c8:	b8 62 00 00 
8d4df4cc:	04 cc 3a 04 	R2 = R7 + R2 (NS) || R7 = [FP -0x70] || NOP;
8d4df4d0:	47 b8 00 00 
8d4df4d4:	03 c8 00 18 	MNOP || [FP + 0xc] = R2 || R2 = [P4 + 0x28];
8d4df4d8:	fa b0 a2 a2 
8d4df4dc:	23 e1 60 02 	R3 = 0x260 (X);		/*		R3=0x260(608) */
8d4df4e0:	04 da 03 84 	R4=-2080152904;
8d4df4e4:	b8 62 00 00 
8d4df4e8:	01 da 03 84 	R1=-2080152904;
8d4df4ec:	b8 62 00 00 
8d4df4f0:	04 cc 23 06 	R3 = R4 + R3 (NS) || [SP + 0xc] = R7 || R4 = [FP -0x58];
8d4df4f4:	f7 b0 a4 b8 
8d4df4f8:	41 66       	R1 += -0x38;		/* (-56) */
8d4df4fa:	08 60       	R0 = 0x1 (X);		/*		R0=0x38b4(14516) */
8d4df4fc:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [FP -0x50] = R3 || NOP;
8d4df500:	c3 ba 00 00 
8d4df504:	ff e3 84 dc 	CALL 0x0x8d4dae0c;
8d4df508:	03 c8 00 18 	MNOP || R0 = [FP + 0x8] || R1 = [FP + 0xc];
8d4df50c:	b8 a0 f9 a0 
8d4df510:	25 e1 a4 38 	R5 = 0x38a4 (X);		/*		R5=0x38a4(14500) */
8d4df514:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df518:	14 33 00 00 
8d4df51c:	6c 51       	R5 = R4 + R5;
8d4df51e:	20 30       	R4 = R0;
8d4df520:	06 30       	R0 = R6;
8d4df522:	39 60       	R1 = 0x7 (X);		/*		R1=0x270(624) */
8d4df524:	00 de 05 8c 	CALL.A 0x8c053038;
8d4df528:	38 30 00 00 
8d4df52c:	04 30       	R0 = R4;
8d4df52e:	0e 30       	R1 = R6;
8d4df530:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df534:	10 1b 00 00 
8d4df538:	06 30       	R0 = R6;
8d4df53a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df53e:	38 1a 00 00 
8d4df542:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df546:	f9 a0 b8 a0 
8d4df54a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df54e:	14 33 00 00 
8d4df552:	71 b8       	R1 = [FP -0x64];
8d4df554:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df558:	14 33 00 00 
8d4df55c:	82 ce 00 c8 	R4 = ROT R0 BY 0x0 || R1 = [FP -0x64] || R0 = [FP -0x70];
8d4df560:	71 b8 40 b8 
8d4df564:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df568:	14 33 00 00 
8d4df56c:	08 30       	R1 = R0;
8d4df56e:	04 30       	R0 = R4;
8d4df570:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df574:	10 1b 00 00 
8d4df578:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df57c:	f9 a0 b8 a0 
8d4df580:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df584:	14 33 00 00 
8d4df588:	c1 b8       	R1 = [FP -0x50];
8d4df58a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df58e:	14 33 00 00 
8d4df592:	20 30       	R4 = R0;
8d4df594:	a1 e4 2c 00 	R1 = B[P4 + 0x2c] (Z);
8d4df598:	06 30       	R0 = R6;
8d4df59a:	00 de 05 8c 	CALL.A 0x8c051066;
8d4df59e:	66 10 00 00 
8d4df5a2:	04 30       	R0 = R4;
8d4df5a4:	0e 30       	R1 = R6;
8d4df5a6:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df5aa:	10 1b 00 00 
8d4df5ae:	06 30       	R0 = R6;
8d4df5b0:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df5b4:	38 1a 00 00 
8d4df5b8:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df5bc:	f9 a0 b8 a0 
8d4df5c0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df5c4:	14 33 00 00 
8d4df5c8:	81 b8       	R1 = [FP -0x60];
8d4df5ca:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df5ce:	14 33 00 00 
8d4df5d2:	0f 30       	R1 = R7;
8d4df5d4:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df5d8:	e4 30 00 00 
8d4df5dc:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP -0x54] = R0 || NOP;
8d4df5e0:	b0 ba 00 00 
8d4df5e4:	67 30       	R4 = FP;
8d4df5e6:	ff e3 d0 f2 	CALL 0x0x8d4ddb86;
8d4df5ea:	84 66       	R4 += -0x30;		/* (-48) */
8d4df5ec:	08 30       	R1 = R0;
8d4df5ee:	04 30       	R0 = R4;
8d4df5f0:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df5f4:	96 10 00 00 
8d4df5f8:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x54] || NOP;
8d4df5fc:	b0 b8 00 00 
8d4df600:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df604:	10 1b 00 00 
8d4df608:	04 30       	R0 = R4;
8d4df60a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df60e:	38 1a 00 00 
8d4df612:	0f 64       	R7 += 0x1;		/* (  1) */
8d4df614:	42 60       	R2 = 0x8 (X);		/*		R2=0x25c(604) */
8d4df616:	97 08       	CC = R7 < R2;
8d4df618:	25 64       	R5 += 0x4;		/* (  4) */
8d4df61a:	cf 1f       	IF CC JUMP 0x0x8d4df5b8 (BP);
8d4df61c:	23 e1 68 02 	R3 = 0x268 (X);		/*		R3=0x268(616) */
8d4df620:	04 da 03 84 	R4=-2080152904;
8d4df624:	b8 62 00 00 
8d4df628:	04 cc 23 06 	R3 = R4 + R3 (NS) || R4 = [FP -0x70] || R2 = [P4 + 0x20];
8d4df62c:	44 b8 22 a2 
8d4df630:	03 c8 00 18 	MNOP || [FP + 0xc] = R3 || R7 = [FP -0x58];
8d4df634:	fb b0 a7 b8 
8d4df638:	01 da 03 84 	R1=-2080152904;
8d4df63c:	b8 62 00 00 
8d4df640:	f4 b0       	[SP + 0xc] = R4;
8d4df642:	41 67       	R1 += -0x18;		/* (-24) */
8d4df644:	08 60       	R0 = 0x1 (X);		/*		R0=0x38b4(14516) */
8d4df646:	ff e3 e3 db 	CALL 0x0x8d4dae0c;
8d4df64a:	03 c8 00 18 	MNOP || R0 = [FP + 0x8] || R1 = [FP + 0xc];
8d4df64e:	b8 a0 f9 a0 
8d4df652:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df656:	14 33 00 00 
8d4df65a:	20 30       	R4 = R0;
8d4df65c:	06 30       	R0 = R6;
8d4df65e:	39 60       	R1 = 0x7 (X);		/*		R1=0x270(624) */
8d4df660:	00 de 05 8c 	CALL.A 0x8c053038;
8d4df664:	38 30 00 00 
8d4df668:	04 30       	R0 = R4;
8d4df66a:	0e 30       	R1 = R6;
8d4df66c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df670:	10 1b 00 00 
8d4df674:	06 30       	R0 = R6;
8d4df676:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df67a:	38 1a 00 00 
8d4df67e:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df682:	f9 a0 b8 a0 
8d4df686:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df68a:	14 33 00 00 
8d4df68e:	71 b8       	R1 = [FP -0x64];
8d4df690:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df694:	14 33 00 00 
8d4df698:	82 ce 00 c8 	R4 = ROT R0 BY 0x0 || R1 = [FP -0x64] || R0 = [FP -0x70];
8d4df69c:	71 b8 40 b8 
8d4df6a0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df6a4:	14 33 00 00 
8d4df6a8:	08 30       	R1 = R0;
8d4df6aa:	04 30       	R0 = R4;
8d4df6ac:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df6b0:	10 1b 00 00 
8d4df6b4:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df6b8:	f9 a0 b8 a0 
8d4df6bc:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df6c0:	14 33 00 00 
8d4df6c4:	c1 b8       	R1 = [FP -0x50];
8d4df6c6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df6ca:	14 33 00 00 
8d4df6ce:	20 30       	R4 = R0;
8d4df6d0:	a1 e4 24 00 	R1 = B[P4 + 0x24] (Z);
8d4df6d4:	06 30       	R0 = R6;
8d4df6d6:	00 de 05 8c 	CALL.A 0x8c051066;
8d4df6da:	66 10 00 00 
8d4df6de:	04 30       	R0 = R4;
8d4df6e0:	0e 30       	R1 = R6;
8d4df6e2:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df6e6:	10 1b 00 00 
8d4df6ea:	25 e1 c4 38 	R5 = 0x38c4 (X);		/*		R5=0x38c4(14532) */
8d4df6ee:	06 30       	R0 = R6;
8d4df6f0:	6f 51       	R5 = R7 + R5;
8d4df6f2:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df6f6:	38 1a 00 00 
8d4df6fa:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4df6fc:	03 c8 00 18 	MNOP || R1 = [FP + 0xc] || R0 = [FP + 0x8];
8d4df700:	f9 a0 b8 a0 
8d4df704:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df708:	14 33 00 00 
8d4df70c:	81 b8       	R1 = [FP -0x60];
8d4df70e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df712:	14 33 00 00 
8d4df716:	0f 30       	R1 = R7;
8d4df718:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4df71c:	e4 30 00 00 
8d4df720:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP -0x64] = R0 || NOP;
8d4df724:	70 ba 00 00 
8d4df728:	67 30       	R4 = FP;
8d4df72a:	ff e3 2e f2 	CALL 0x0x8d4ddb86;
8d4df72e:	84 66       	R4 += -0x30;		/* (-48) */
8d4df730:	08 30       	R1 = R0;
8d4df732:	04 30       	R0 = R4;
8d4df734:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df738:	96 10 00 00 
8d4df73c:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x64] || NOP;
8d4df740:	70 b8 00 00 
8d4df744:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df748:	10 1b 00 00 
8d4df74c:	04 30       	R0 = R4;
8d4df74e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df752:	38 1a 00 00 
8d4df756:	0f 64       	R7 += 0x1;		/* (  1) */
8d4df758:	42 60       	R2 = 0x8 (X);		/*		R2=0x25c(604) */
8d4df75a:	97 08       	CC = R7 < R2;
8d4df75c:	25 64       	R5 += 0x4;		/* (  4) */
8d4df75e:	cf 1f       	IF CC JUMP 0x0x8d4df6fc (BP);
8d4df760:	07 da 03 84 	R7=-2080152904;
8d4df764:	b8 62 00 00 
8d4df768:	21 e1 e4 01 	R1 = 0x1e4 (X);		/*		R1=0x1e4(484) */
8d4df76c:	20 e1 d8 01 	R0 = 0x1d8 (X);		/*		R0=0x1d8(472) */
8d4df770:	04 da 03 84 	R4=-2080152904;
8d4df774:	b8 62 00 00 
8d4df778:	23 e1 f8 01 	R3 = 0x1f8 (X);		/*		R3=0x1f8(504) */
8d4df77c:	4f 50       	R1 = R7 + R1;
8d4df77e:	04 cc 20 08 	R4 = R4 + R0 (NS) || [FP + 0xc] = R1 || NOP;
8d4df782:	f9 b0 00 00 
8d4df786:	df 51       	R7 = R7 + R3;
8d4df788:	20 e1 00 02 	R0 = 0x200 (X);		/*		R0=0x200(512) */
8d4df78c:	03 da 03 84 	R3=-2080152904;
8d4df790:	b8 62 00 00 
8d4df794:	03 50       	R0 = R3 + R0;
8d4df796:	c0 ba       	[FP -0x50] = R0;
8d4df798:	00 da 03 84 	R0=-2080152904;
8d4df79c:	b8 62 00 00 
8d4df7a0:	21 e1 0c 02 	R1 = 0x20c (X);		/*		R1=0x20c(524) */
8d4df7a4:	48 50       	R1 = R0 + R1;
8d4df7a6:	22 e1 f0 01 	R2 = 0x1f0 (X);		/*		R2=0x1f0(496) */
8d4df7aa:	05 da 03 84 	R5=-2080152904;
8d4df7ae:	b8 62 00 00 
8d4df7b2:	04 cc 2a 0a 	R5 = R5 + R2 (NS) || [FP -0x54] = R1 || NOP;
8d4df7b6:	b1 ba 00 00 
8d4df7ba:	01 da 03 84 	R1=-2080152904;
8d4df7be:	b8 62 00 00 
8d4df7c2:	22 e1 18 02 	R2 = 0x218 (X);		/*		R2=0x218(536) */
8d4df7c6:	04 cc 0a 04 	R2 = R1 + R2 (NS) || R1 = [FP -0x4c] || NOP;
8d4df7ca:	d1 b8 00 00 
8d4df7ce:	23 e1 24 01 	R3 = 0x124 (X);		/*		R3=0x124(292) */
8d4df7d2:	04 cc 03 06 	R3 = R0 + R3 (NS) || [FP -0x68] = R2 || NOP;
8d4df7d6:	62 ba 00 00 
8d4df7da:	02 da 03 84 	R2=-2080152904;
8d4df7de:	b8 62 00 00 
8d4df7e2:	20 e1 78 00 	R0 = 0x78 (X);		/*		R0=0x78(120) */
8d4df7e6:	04 cc 10 04 	R2 = R2 + R0 (NS) || R0 = [FP + 0x8] || [FP -0x64] = R3;
8d4df7ea:	b8 a0 73 ba 
8d4df7ee:	82 ba       	[FP -0x60] = R2;
8d4df7f0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df7f4:	14 33 00 00 
8d4df7f8:	0c 30       	R1 = R4;
8d4df7fa:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df7fe:	14 33 00 00 
8d4df802:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x5c] = R0 || NOP;
8d4df806:	90 ba 00 00 
8d4df80a:	39 60       	R1 = 0x7 (X);		/*		R1=0x20c(524) */
8d4df80c:	00 de 05 8c 	CALL.A 0x8c053038;
8d4df810:	38 30 00 00 
8d4df814:	0e 30       	R1 = R6;
8d4df816:	90 b8       	R0 = [FP -0x5c];
8d4df818:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df81c:	10 1b 00 00 
8d4df820:	06 30       	R0 = R6;
8d4df822:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df826:	38 1a 00 00 
8d4df82a:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df82e:	d1 b8 b8 a0 
8d4df832:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df836:	14 33 00 00 
8d4df83a:	0c 30       	R1 = R4;
8d4df83c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df840:	14 33 00 00 
8d4df844:	f9 a0       	R1 = [FP + 0xc];
8d4df846:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df84a:	14 33 00 00 
8d4df84e:	0d 30       	R1 = R5;
8d4df850:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df854:	14 33 00 00 
8d4df858:	22 e1 0c 39 	R2 = 0x390c (X);		/*		R2=0x390c(14604) */
8d4df85c:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP -0x5c] = R0;
8d4df860:	a3 b8 90 ba 
8d4df864:	13 50       	R0 = R3 + R2;
8d4df866:	ff e3 90 f1 	CALL 0x0x8d4ddb86;
8d4df86a:	08 30       	R1 = R0;
8d4df86c:	06 30       	R0 = R6;
8d4df86e:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df872:	96 10 00 00 
8d4df876:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP -0x5c] || NOP;
8d4df87a:	90 b8 00 00 
8d4df87e:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df882:	10 1b 00 00 
8d4df886:	06 30       	R0 = R6;
8d4df888:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df88c:	38 1a 00 00 
8d4df890:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df894:	d1 b8 b8 a0 
8d4df898:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df89c:	14 33 00 00 
8d4df8a0:	0c 30       	R1 = R4;
8d4df8a2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df8a6:	14 33 00 00 
8d4df8aa:	f9 a0       	R1 = [FP + 0xc];
8d4df8ac:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df8b0:	14 33 00 00 
8d4df8b4:	0f 30       	R1 = R7;
8d4df8b6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df8ba:	14 33 00 00 
8d4df8be:	22 e1 10 39 	R2 = 0x3910 (X);		/*		R2=0x3910(14608) */
8d4df8c2:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4df8c6:	a3 b8 f8 b0 
8d4df8ca:	13 50       	R0 = R3 + R2;
8d4df8cc:	ff e3 5d f1 	CALL 0x0x8d4ddb86;
8d4df8d0:	08 30       	R1 = R0;
8d4df8d2:	06 30       	R0 = R6;
8d4df8d4:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df8d8:	96 10 00 00 
8d4df8dc:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4df8e0:	f8 a0 00 00 
8d4df8e4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df8e8:	10 1b 00 00 
8d4df8ec:	06 30       	R0 = R6;
8d4df8ee:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df8f2:	38 1a 00 00 
8d4df8f6:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df8fa:	d1 b8 b8 a0 
8d4df8fe:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df902:	14 33 00 00 
8d4df906:	0c 30       	R1 = R4;
8d4df908:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df90c:	14 33 00 00 
8d4df910:	c1 b8       	R1 = [FP -0x50];
8d4df912:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df916:	14 33 00 00 
8d4df91a:	0d 30       	R1 = R5;
8d4df91c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df920:	14 33 00 00 
8d4df924:	22 e1 14 39 	R2 = 0x3914 (X);		/*		R2=0x3914(14612) */
8d4df928:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4df92c:	a3 b8 f8 b0 
8d4df930:	13 50       	R0 = R3 + R2;
8d4df932:	ff e3 2a f1 	CALL 0x0x8d4ddb86;
8d4df936:	08 30       	R1 = R0;
8d4df938:	06 30       	R0 = R6;
8d4df93a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df93e:	96 10 00 00 
8d4df942:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4df946:	f8 a0 00 00 
8d4df94a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df94e:	10 1b 00 00 
8d4df952:	06 30       	R0 = R6;
8d4df954:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df958:	38 1a 00 00 
8d4df95c:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df960:	d1 b8 b8 a0 
8d4df964:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df968:	14 33 00 00 
8d4df96c:	0c 30       	R1 = R4;
8d4df96e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df972:	14 33 00 00 
8d4df976:	c1 b8       	R1 = [FP -0x50];
8d4df978:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df97c:	14 33 00 00 
8d4df980:	0f 30       	R1 = R7;
8d4df982:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df986:	14 33 00 00 
8d4df98a:	22 e1 18 39 	R2 = 0x3918 (X);		/*		R2=0x3918(14616) */
8d4df98e:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4df992:	a3 b8 f8 b0 
8d4df996:	13 50       	R0 = R3 + R2;
8d4df998:	ff e3 f7 f0 	CALL 0x0x8d4ddb86;
8d4df99c:	08 30       	R1 = R0;
8d4df99e:	06 30       	R0 = R6;
8d4df9a0:	00 de 05 8c 	CALL.A 0x8c051096;
8d4df9a4:	96 10 00 00 
8d4df9a8:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4df9ac:	f8 a0 00 00 
8d4df9b0:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4df9b4:	10 1b 00 00 
8d4df9b8:	06 30       	R0 = R6;
8d4df9ba:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4df9be:	38 1a 00 00 
8d4df9c2:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4df9c6:	d1 b8 b8 a0 
8d4df9ca:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df9ce:	14 33 00 00 
8d4df9d2:	0c 30       	R1 = R4;
8d4df9d4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df9d8:	14 33 00 00 
8d4df9dc:	b1 b8       	R1 = [FP -0x54];
8d4df9de:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df9e2:	14 33 00 00 
8d4df9e6:	0d 30       	R1 = R5;
8d4df9e8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4df9ec:	14 33 00 00 
8d4df9f0:	22 e1 1c 39 	R2 = 0x391c (X);		/*		R2=0x391c(14620) */
8d4df9f4:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4df9f8:	a3 b8 f8 b0 
8d4df9fc:	13 50       	R0 = R3 + R2;
8d4df9fe:	ff e3 c4 f0 	CALL 0x0x8d4ddb86;
8d4dfa02:	08 30       	R1 = R0;
8d4dfa04:	06 30       	R0 = R6;
8d4dfa06:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfa0a:	96 10 00 00 
8d4dfa0e:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4dfa12:	f8 a0 00 00 
8d4dfa16:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfa1a:	10 1b 00 00 
8d4dfa1e:	06 30       	R0 = R6;
8d4dfa20:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfa24:	38 1a 00 00 
8d4dfa28:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfa2c:	d1 b8 b8 a0 
8d4dfa30:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa34:	14 33 00 00 
8d4dfa38:	0c 30       	R1 = R4;
8d4dfa3a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa3e:	14 33 00 00 
8d4dfa42:	b1 b8       	R1 = [FP -0x54];
8d4dfa44:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa48:	14 33 00 00 
8d4dfa4c:	0f 30       	R1 = R7;
8d4dfa4e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa52:	14 33 00 00 
8d4dfa56:	22 e1 20 39 	R2 = 0x3920 (X);		/*		R2=0x3920(14624) */
8d4dfa5a:	03 c8 00 18 	MNOP || R3 = [FP -0x58] || [FP + 0xc] = R0;
8d4dfa5e:	a3 b8 f8 b0 
8d4dfa62:	13 50       	R0 = R3 + R2;
8d4dfa64:	ff e3 91 f0 	CALL 0x0x8d4ddb86;
8d4dfa68:	08 30       	R1 = R0;
8d4dfa6a:	06 30       	R0 = R6;
8d4dfa6c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfa70:	96 10 00 00 
8d4dfa74:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0xc] || NOP;
8d4dfa78:	f8 a0 00 00 
8d4dfa7c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfa80:	10 1b 00 00 
8d4dfa84:	06 30       	R0 = R6;
8d4dfa86:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfa8a:	38 1a 00 00 
8d4dfa8e:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfa92:	d1 b8 b8 a0 
8d4dfa96:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfa9a:	14 33 00 00 
8d4dfa9e:	0c 30       	R1 = R4;
8d4dfaa0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfaa4:	14 33 00 00 
8d4dfaa8:	61 b8       	R1 = [FP -0x68];
8d4dfaaa:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfaae:	14 33 00 00 
8d4dfab2:	0d 30       	R1 = R5;
8d4dfab4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfab8:	14 33 00 00 
8d4dfabc:	22 e1 40 39 	R2 = 0x3940 (X);		/*		R2=0x3940(14656) */
8d4dfac0:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfac4:	a3 b8 00 00 
8d4dfac8:	13 50       	R0 = R3 + R2;
8d4dfaca:	ff e3 5e f0 	CALL 0x0x8d4ddb86;
8d4dface:	08 30       	R1 = R0;
8d4dfad0:	06 30       	R0 = R6;
8d4dfad2:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfad6:	96 10 00 00 
8d4dfada:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || R5 = [FP -0x58] || NOP;
8d4dfade:	a5 b8 00 00 
8d4dfae2:	0e 30       	R1 = R6;
8d4dfae4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfae8:	10 1b 00 00 
8d4dfaec:	06 30       	R0 = R6;
8d4dfaee:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfaf2:	38 1a 00 00 
8d4dfaf6:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfafa:	d1 b8 b8 a0 
8d4dfafe:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb02:	14 33 00 00 
8d4dfb06:	0c 30       	R1 = R4;
8d4dfb08:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb0c:	14 33 00 00 
8d4dfb10:	61 b8       	R1 = [FP -0x68];
8d4dfb12:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb16:	14 33 00 00 
8d4dfb1a:	0f 30       	R1 = R7;
8d4dfb1c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb20:	14 33 00 00 
8d4dfb24:	22 e1 44 39 	R2 = 0x3944 (X);		/*		R2=0x3944(14660) */
8d4dfb28:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfb2c:	a3 b8 00 00 
8d4dfb30:	13 50       	R0 = R3 + R2;
8d4dfb32:	ff e3 2a f0 	CALL 0x0x8d4ddb86;
8d4dfb36:	08 30       	R1 = R0;
8d4dfb38:	06 30       	R0 = R6;
8d4dfb3a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfb3e:	96 10 00 00 
8d4dfb42:	07 30       	R0 = R7;
8d4dfb44:	0e 30       	R1 = R6;
8d4dfb46:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfb4a:	10 1b 00 00 
8d4dfb4e:	06 30       	R0 = R6;
8d4dfb50:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfb54:	38 1a 00 00 
8d4dfb58:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfb5c:	d1 b8 b8 a0 
8d4dfb60:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb64:	14 33 00 00 
8d4dfb68:	01 da 03 84 	R1=-2080151952;
8d4dfb6c:	70 66 00 00 
8d4dfb70:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfb74:	14 33 00 00 
8d4dfb78:	22 e1 24 39 	R2 = 0x3924 (X);		/*		R2=0x3924(14628) */
8d4dfb7c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfb80:	a3 b8 00 00 
8d4dfb84:	13 50       	R0 = R3 + R2;
8d4dfb86:	ff e3 00 f0 	CALL 0x0x8d4ddb86;
8d4dfb8a:	08 30       	R1 = R0;
8d4dfb8c:	06 30       	R0 = R6;
8d4dfb8e:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfb92:	96 10 00 00 
8d4dfb96:	07 30       	R0 = R7;
8d4dfb98:	0e 30       	R1 = R6;
8d4dfb9a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfb9e:	10 1b 00 00 
8d4dfba2:	06 30       	R0 = R6;
8d4dfba4:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfba8:	38 1a 00 00 
8d4dfbac:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfbb0:	d1 b8 b8 a0 
8d4dfbb4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfbb8:	14 33 00 00 
8d4dfbbc:	01 da 03 84 	R1=-2080151928;
8d4dfbc0:	88 66 00 00 
8d4dfbc4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfbc8:	14 33 00 00 
8d4dfbcc:	22 e1 28 39 	R2 = 0x3928 (X);		/*		R2=0x3928(14632) */
8d4dfbd0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfbd4:	a3 b8 00 00 
8d4dfbd8:	13 50       	R0 = R3 + R2;
8d4dfbda:	ff e3 d6 ef 	CALL 0x0x8d4ddb86;
8d4dfbde:	08 30       	R1 = R0;
8d4dfbe0:	06 30       	R0 = R6;
8d4dfbe2:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfbe6:	96 10 00 00 
8d4dfbea:	07 30       	R0 = R7;
8d4dfbec:	0e 30       	R1 = R6;
8d4dfbee:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfbf2:	10 1b 00 00 
8d4dfbf6:	06 30       	R0 = R6;
8d4dfbf8:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfbfc:	38 1a 00 00 
8d4dfc00:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfc04:	d1 b8 b8 a0 
8d4dfc08:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfc0c:	14 33 00 00 
8d4dfc10:	07 da 03 84 	R7=-2080152904;
8d4dfc14:	b8 62 00 00 
8d4dfc18:	22 e1 b0 01 	R2 = 0x1b0 (X);		/*		R2=0x1b0(432) */
8d4dfc1c:	57 50       	R1 = R7 + R2;
8d4dfc1e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfc22:	14 33 00 00 
8d4dfc26:	23 e1 2c 39 	R3 = 0x392c (X);		/*		R3=0x392c(14636) */
8d4dfc2a:	38 30       	R7 = R0;
8d4dfc2c:	1d 50       	R0 = R5 + R3;
8d4dfc2e:	ff e3 ac ef 	CALL 0x0x8d4ddb86;
8d4dfc32:	08 30       	R1 = R0;
8d4dfc34:	06 30       	R0 = R6;
8d4dfc36:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfc3a:	96 10 00 00 
8d4dfc3e:	07 30       	R0 = R7;
8d4dfc40:	0e 30       	R1 = R6;
8d4dfc42:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfc46:	10 1b 00 00 
8d4dfc4a:	06 30       	R0 = R6;
8d4dfc4c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfc50:	38 1a 00 00 
8d4dfc54:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfc58:	d1 b8 b8 a0 
8d4dfc5c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfc60:	14 33 00 00 
8d4dfc64:	07 da 03 84 	R7=-2080152904;
8d4dfc68:	b8 62 00 00 
8d4dfc6c:	22 e1 a8 01 	R2 = 0x1a8 (X);		/*		R2=0x1a8(424) */
8d4dfc70:	57 50       	R1 = R7 + R2;
8d4dfc72:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfc76:	14 33 00 00 
8d4dfc7a:	23 e1 30 39 	R3 = 0x3930 (X);		/*		R3=0x3930(14640) */
8d4dfc7e:	38 30       	R7 = R0;
8d4dfc80:	1d 50       	R0 = R5 + R3;
8d4dfc82:	ff e3 82 ef 	CALL 0x0x8d4ddb86;
8d4dfc86:	08 30       	R1 = R0;
8d4dfc88:	06 30       	R0 = R6;
8d4dfc8a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfc8e:	96 10 00 00 
8d4dfc92:	07 30       	R0 = R7;
8d4dfc94:	0e 30       	R1 = R6;
8d4dfc96:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfc9a:	10 1b 00 00 
8d4dfc9e:	06 30       	R0 = R6;
8d4dfca0:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfca4:	38 1a 00 00 
8d4dfca8:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfcac:	d1 b8 b8 a0 
8d4dfcb0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfcb4:	14 33 00 00 
8d4dfcb8:	71 b8       	R1 = [FP -0x64];
8d4dfcba:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfcbe:	14 33 00 00 
8d4dfcc2:	22 e1 34 39 	R2 = 0x3934 (X);		/*		R2=0x3934(14644) */
8d4dfcc6:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R3 = [FP -0x58] || NOP;
8d4dfcca:	a3 b8 00 00 
8d4dfcce:	13 50       	R0 = R3 + R2;
8d4dfcd0:	ff e3 63 ef 	CALL 0x0x8d4ddb96;
8d4dfcd4:	08 30       	R1 = R0;
8d4dfcd6:	06 30       	R0 = R6;
8d4dfcd8:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfcdc:	96 10 00 00 
8d4dfce0:	07 30       	R0 = R7;
8d4dfce2:	0e 30       	R1 = R6;
8d4dfce4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfce8:	10 1b 00 00 
8d4dfcec:	06 30       	R0 = R6;
8d4dfcee:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfcf2:	38 1a 00 00 
8d4dfcf6:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfcfa:	d1 b8 b8 a0 
8d4dfcfe:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfd02:	14 33 00 00 
8d4dfd06:	07 da 03 84 	R7=-2080152904;
8d4dfd0a:	b8 62 00 00 
8d4dfd0e:	22 e1 c0 01 	R2 = 0x1c0 (X);		/*		R2=0x1c0(448) */
8d4dfd12:	57 50       	R1 = R7 + R2;
8d4dfd14:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfd18:	14 33 00 00 
8d4dfd1c:	23 e1 38 39 	R3 = 0x3938 (X);		/*		R3=0x3938(14648) */
8d4dfd20:	38 30       	R7 = R0;
8d4dfd22:	1d 50       	R0 = R5 + R3;
8d4dfd24:	ff e3 31 ef 	CALL 0x0x8d4ddb86;
8d4dfd28:	08 30       	R1 = R0;
8d4dfd2a:	06 30       	R0 = R6;
8d4dfd2c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfd30:	96 10 00 00 
8d4dfd34:	07 30       	R0 = R7;
8d4dfd36:	0e 30       	R1 = R6;
8d4dfd38:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfd3c:	10 1b 00 00 
8d4dfd40:	06 30       	R0 = R6;
8d4dfd42:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfd46:	38 1a 00 00 
8d4dfd4a:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dfd4e:	d1 b8 b8 a0 
8d4dfd52:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfd56:	14 33 00 00 
8d4dfd5a:	07 da 03 84 	R7=-2080152904;
8d4dfd5e:	b8 62 00 00 
8d4dfd62:	22 e1 cc 01 	R2 = 0x1cc (X);		/*		R2=0x1cc(460) */
8d4dfd66:	57 50       	R1 = R7 + R2;
8d4dfd68:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfd6c:	14 33 00 00 
8d4dfd70:	23 e1 3c 39 	R3 = 0x393c (X);		/*		R3=0x393c(14652) */
8d4dfd74:	38 30       	R7 = R0;
8d4dfd76:	1d 50       	R0 = R5 + R3;
8d4dfd78:	ff e3 07 ef 	CALL 0x0x8d4ddb86;
8d4dfd7c:	08 30       	R1 = R0;
8d4dfd7e:	06 30       	R0 = R6;
8d4dfd80:	00 de 05 8c 	CALL.A 0x8c051096;
8d4dfd84:	96 10 00 00 
8d4dfd88:	07 30       	R0 = R7;
8d4dfd8a:	0e 30       	R1 = R6;
8d4dfd8c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfd90:	10 1b 00 00 
8d4dfd94:	06 30       	R0 = R6;
8d4dfd96:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfd9a:	38 1a 00 00 
8d4dfd9e:	03 c8 00 18 	MNOP || R0 = [FP + 0x8] || R1 = [FP -0x60];
8d4dfda2:	b8 a0 81 b8 
8d4dfda6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dfdaa:	14 33 00 00 
8d4dfdae:	38 30       	R7 = R0;
8d4dfdb0:	06 30       	R0 = R6;
8d4dfdb2:	31 60       	R1 = 0x6 (X);		/*		R1=0x20c(524) */
8d4dfdb4:	00 de 05 8c 	CALL.A 0x8c053038;
8d4dfdb8:	38 30 00 00 
8d4dfdbc:	07 30       	R0 = R7;
8d4dfdbe:	0e 30       	R1 = R6;
8d4dfdc0:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfdc4:	10 1b 00 00 
8d4dfdc8:	06 30       	R0 = R6;
8d4dfdca:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfdce:	38 1a 00 00 
8d4dfdd2:	a0 a1       	R0 = [P4 + 0x18];
8d4dfdd4:	18 0c       	CC = R0 == 0x3;
8d4dfdd6:	03 1c       	IF CC JUMP 0x0x8d4dfddc (BP);
8d4dfdd8:	e2 23       	JUMP.S 0x0x8d4e059c;
8d4dfdda:	00 00       	NOP;
8d4dfddc:	20 e1 01 07 	R0 = 0x701 (X);		/*		R0=0x701(1793) */
8d4dfde0:	22 e1 10 01 	R2 = 0x110 (X);		/*		R2=0x110(272) */
8d4dfde4:	07 da 03 84 	R7=-2080152904;
8d4dfde8:	b8 62 00 00 
8d4dfdec:	97 50       	R2 = R7 + R2;
8d4dfdee:	70 e6 38 00 	W[SP + 0x70] = R0;
8d4dfdf2:	06 da 03 84 	R6=-2080152904;
8d4dfdf6:	b8 62 00 00 
8d4dfdfa:	23 e1 80 00 	R3 = 0x80 (X);		/*		R3=0x80(128) */
8d4dfdfe:	05 da 03 84 	R5=-2080152904;
8d4dfe02:	b8 62 00 00 
8d4dfe06:	20 e1 94 00 	R0 = 0x94 (X);		/*		R0=0x94(148) */
8d4dfe0a:	04 cc 33 06 	R3 = R6 + R3 (NS) || [FP + 0xc] = R2 || NOP;
8d4dfe0e:	fa b0 00 00 
8d4dfe12:	04 cc 28 00 	R0 = R5 + R0 (NS) || [FP -0x50] = R3 || NOP;
8d4dfe16:	c3 ba 00 00 
8d4dfe1a:	22 e1 30 01 	R2 = 0x130 (X);		/*		R2=0x130(304) */
8d4dfe1e:	21 e1 01 06 	R1 = 0x601 (X);		/*		R1=0x601(1537) */
8d4dfe22:	04 cc 32 04 	R2 = R6 + R2 (NS) || [FP -0x54] = R0 || NOP;
8d4dfe26:	b0 ba 00 00 
8d4dfe2a:	23 e1 34 01 	R3 = 0x134 (X);		/*		R3=0x134(308) */
8d4dfe2e:	00 da 03 84 	R0=-2080152904;
8d4dfe32:	b8 62 00 00 
8d4dfe36:	71 e6 39 00 	W[SP + 0x72] = R1;
8d4dfe3a:	04 da 03 84 	R4=-2080152904;
8d4dfe3e:	b8 62 00 00 
8d4dfe42:	21 e1 18 01 	R1 = 0x118 (X);		/*		R1=0x118(280) */
8d4dfe46:	04 cc 03 00 	R0 = R0 + R3 (NS) || [FP -0x5c] = R2 || NOP;
8d4dfe4a:	92 ba 00 00 
8d4dfe4e:	26 e1 f8 00 	R6 = 0xf8 (X);		/*		R6=0xf8(248) */
8d4dfe52:	02 da 03 84 	R2=-2080152904;
8d4dfe56:	b8 62 00 00 
8d4dfe5a:	04 cc 21 02 	R1 = R4 + R1 (NS) || [FP -0x6c] = R0 || NOP;
8d4dfe5e:	50 ba 00 00 
8d4dfe62:	04 cc 16 04 	R2 = R2 + R6 (NS) || [FP -0x68] = R1 || NOP;
8d4dfe66:	61 ba 00 00 
8d4dfe6a:	27 e1 3c 01 	R7 = 0x13c (X);		/*		R7=0x13c(316) */
8d4dfe6e:	25 e1 04 01 	R5 = 0x104 (X);		/*		R5=0x104(260) */
8d4dfe72:	00 da 03 84 	R0=-2080152904;
8d4dfe76:	b8 62 00 00 
8d4dfe7a:	7c 50       	R1 = R4 + R7;
8d4dfe7c:	32 e6 12 00 	[SP + 0x48] = R2;
8d4dfe80:	04 cc 05 00 	R0 = R0 + R5 (NS) || [SP + 0x3c] = R1 || NOP;
8d4dfe84:	f1 b3 00 00 
8d4dfe88:	23 e1 b8 00 	R3 = 0xb8 (X);		/*		R3=0xb8(184) */
8d4dfe8c:	27 e1 c8 00 	R7 = 0xc8 (X);		/*		R7=0xc8(200) */
8d4dfe90:	02 da 03 84 	R2=-2080152904;
8d4dfe94:	b8 62 00 00 
8d4dfe98:	5c 50       	R1 = R4 + R3;
8d4dfe9a:	04 cc 17 04 	R2 = R2 + R7 (NS) || [FP -0x7c] = R1 || NOP;
8d4dfe9e:	11 ba 00 00 
8d4dfea2:	30 e6 11 00 	[SP + 0x44] = R0;
8d4dfea6:	26 e1 d8 00 	R6 = 0xd8 (X);		/*		R6=0xd8(216) */
8d4dfeaa:	25 e1 8c 00 	R5 = 0x8c (X);		/*		R5=0x8c(140) */
8d4dfeae:	00 da 03 84 	R0=-2080152904;
8d4dfeb2:	b8 62 00 00 
8d4dfeb6:	32 e6 10 00 	[SP + 0x40] = R2;
8d4dfeba:	6c 50       	R1 = R4 + R5;
8d4dfebc:	04 cc 06 00 	R0 = R0 + R6 (NS) || [FP -0x78] = R1 || NOP;
8d4dfec0:	21 ba 00 00 
8d4dfec4:	23 e1 9c 00 	R3 = 0x9c (X);		/*		R3=0x9c(156) */
8d4dfec8:	02 da 03 84 	R2=-2080152904;
8d4dfecc:	b8 62 00 00 
8d4dfed0:	04 cc 13 04 	R2 = R2 + R3 (NS) || [SP + 0x2c] = R0 || NOP;
8d4dfed4:	f0 b2 00 00 
8d4dfed8:	27 e1 ac 00 	R7 = 0xac (X);		/*		R7=0xac(172) */
8d4dfedc:	24 e1 f0 00 	R4 = 0xf0 (X);		/*		R4=0xf0(240) */
8d4dfee0:	26 e1 e8 00 	R6 = 0xe8 (X);		/*		R6=0xe8(232) */
8d4dfee4:	01 da 03 84 	R1=-2080152904;
8d4dfee8:	b8 62 00 00 
8d4dfeec:	03 da 03 84 	R3=-2080152904;
8d4dfef0:	b8 62 00 00 
8d4dfef4:	00 da 03 84 	R0=-2080152904;
8d4dfef8:	b8 62 00 00 
8d4dfefc:	04 cc 0e 02 	R1 = R1 + R6 (NS) || [SP + 0x30] = R2 || NOP;
8d4dff00:	32 b3 00 00 
8d4dff04:	04 cc 07 00 	R0 = R0 + R7 (NS) || [SP + 0x34] = R1 || NOP;
8d4dff08:	71 b3 00 00 
8d4dff0c:	04 cc 1c 04 	R2 = R3 + R4 (NS) || [SP + 0x38] = R0 || NOP;
8d4dff10:	b0 b3 00 00 
8d4dff14:	29 e1 6c 39 	P1 = 0x396c (X);		/*		P1=0x396c(14700) */
8d4dff18:	32 ba       	[FP -0x74] = R2;
8d4dff1a:	cc 5a       	P3 = P4 + P1;
8d4dff1c:	2d e1 80 00 	P5 = 0x80 (X);		/*		P5=0x80(128) */
8d4dff20:	c5 60       	R5 = 0x18 (X);		/*		R5=0x8c(140) */
8d4dff22:	4b 32       	P1 = P3;
8d4dff24:	04 cc 09 42 	R1 = R1 - R1 (NS) || R0 = B[P1++] (Z) || NOP;
8d4dff28:	08 98 00 00 
8d4dff2c:	00 0c       	CC = R0 == 0x0;
8d4dff2e:	fb 17       	IF !CC JUMP 0x0x8d4dff24 (BP);
8d4dff30:	19 44       	P1 -= P3;
8d4dff32:	f9 6f       	P1 += -0x1;		/* ( -1) */
8d4dff34:	41 0c       	CC = P1 == 0x0;
8d4dff36:	74 10       	IF !CC JUMP 0x0x8d4e001e;
8d4dff38:	fd 67       	R5 += -0x1;		/* ( -1) */
8d4dff3a:	05 0c       	CC = R5 == 0x0;
8d4dff3c:	eb 5a       	P3 = P3 + P5;
8d4dff3e:	f2 17       	IF !CC JUMP 0x0x8d4dff22 (BP);
8d4dff40:	29 e1 94 53 	P1 = 0x5394 (X);		/*		P1=0x5394(21396) */
8d4dff44:	4c 5b       	P5 = P4 + P1;
8d4dff46:	4d 32       	P1 = P5;
8d4dff48:	c0 e0 04 30 	LSETUP_IMM(bottom=0x8d4dff50) LC0 count_fields=0x0/0xc;
8d4dff4c:	08 90       	R0 = [P1++];
8d4dff4e:	00 0c       	CC = R0 == 0x0;
8d4dff50:	65 10       	IF !CC JUMP 0x0x8d4e001a;
8d4dff52:	00 60       	R0 = 0x0 (X);		/*		R0=0x94(148) */
8d4dff54:	00 0c       	CC = R0 == 0x0;
8d4dff56:	58 18       	IF CC JUMP 0x0x8d4e0006;
8d4dff58:	22 e1 50 01 	R2 = 0x150 (X);		/*		R2=0x150(336) */
8d4dff5c:	03 da 03 84 	R3=-2080152904;
8d4dff60:	b8 62 00 00 
8d4dff64:	04 cc 1a 0c 	R6 = R3 + R2 (NS) || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dff68:	d1 b8 b8 a0 
8d4dff6c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dff70:	14 33 00 00 
8d4dff74:	0e 30       	R1 = R6;
8d4dff76:	7f 30       	R7 = FP;
8d4dff78:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dff7c:	14 33 00 00 
8d4dff80:	87 66       	R7 += -0x30;		/* (-48) */
8d4dff82:	28 30       	R5 = R0;
8d4dff84:	07 30       	R0 = R7;
8d4dff86:	31 60       	R1 = 0x6 (X);		/*		R1=0x118(280) */
8d4dff88:	00 de 05 8c 	CALL.A 0x8c053038;
8d4dff8c:	38 30 00 00 
8d4dff90:	05 30       	R0 = R5;
8d4dff92:	0f 30       	R1 = R7;
8d4dff94:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dff98:	10 1b 00 00 
8d4dff9c:	07 30       	R0 = R7;
8d4dff9e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dffa2:	38 1a 00 00 
8d4dffa6:	04 60       	R4 = 0x0 (X);		/*		R4=0xf0(240) */
8d4dffa8:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4dffac:	d1 b8 b8 a0 
8d4dffb0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dffb4:	14 33 00 00 
8d4dffb8:	0e 30       	R1 = R6;
8d4dffba:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dffbe:	14 33 00 00 
8d4dffc2:	0c 30       	R1 = R4;
8d4dffc4:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4dffc8:	e4 30 00 00 
8d4dffcc:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || R0 = [P5++] || NOP;
8d4dffd0:	28 90 00 00 
8d4dffd4:	7f 30       	R7 = FP;
8d4dffd6:	06 e3 33 48 	CALL 0x0x8d5a903c;
8d4dffda:	e7 66       	R7 += -0x24;		/* (-36) */
8d4dffdc:	08 30       	R1 = R0;
8d4dffde:	07 30       	R0 = R7;
8d4dffe0:	00 de 05 8c 	CALL.A 0x8c0518f4;
8d4dffe4:	f4 18 00 00 
8d4dffe8:	05 30       	R0 = R5;
8d4dffea:	0f 30       	R1 = R7;
8d4dffec:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dfff0:	10 1b 00 00 
8d4dfff4:	07 30       	R0 = R7;
8d4dfff6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dfffa:	38 1a 00 00 
8d4dfffe:	0c 64       	R4 += 0x1;		/* (  1) */
8d4e0000:	60 60       	R0 = 0xc (X);		/*		R0=0x94(148) */
8d4e0002:	84 08       	CC = R4 < R0;
8d4e0004:	d2 1f       	IF CC JUMP 0x0x8d4dffa8 (BP);
8d4e0006:	40 b8       	R0 = [FP -0x70];
8d4e0008:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e000c:	38 1a 00 00 
8d4e0010:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e0012:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e0014:	01 e8 00 00 	UNLINK;
8d4e0018:	10 00       	RTS;
8d4e001a:	08 60       	R0 = 0x1 (X);		/*		R0=0x94(148) */
8d4e001c:	9c 2f       	JUMP.S 0x0x8d4dff54;
8d4e001e:	7f 30       	R7 = FP;
8d4e0020:	e7 66       	R7 += -0x24;		/* (-36) */
8d4e0022:	07 30       	R0 = R7;
8d4e0024:	00 de 05 8c 	CALL.A 0x8c053038;
8d4e0028:	38 30 00 00 
8d4e002c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0xc] || NOP;
8d4e0030:	f9 a0 00 00 
8d4e0034:	67 30       	R4 = FP;
8d4e0036:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e003a:	14 33 00 00 
8d4e003e:	84 66       	R4 += -0x30;		/* (-48) */
8d4e0040:	30 30       	R6 = R0;
8d4e0042:	4b 30       	R1 = P3;
8d4e0044:	04 30       	R0 = R4;
8d4e0046:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4e004a:	a8 19 00 00 
8d4e004e:	06 30       	R0 = R6;
8d4e0050:	0c 30       	R1 = R4;
8d4e0052:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0056:	10 1b 00 00 
8d4e005a:	04 30       	R0 = R4;
8d4e005c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0060:	38 1a 00 00 
8d4e0064:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x50] || NOP;
8d4e0068:	c1 b8 00 00 
8d4e006c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0070:	14 33 00 00 
8d4e0074:	30 30       	R6 = R0;
8d4e0076:	19 e4 f8 ff 	R1 = [P3 + -0x20];
8d4e007a:	04 30       	R0 = R4;
8d4e007c:	00 de 05 8c 	CALL.A 0x8c05107e;
8d4e0080:	7e 10 00 00 
8d4e0084:	06 30       	R0 = R6;
8d4e0086:	0c 30       	R1 = R4;
8d4e0088:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e008c:	10 1b 00 00 
8d4e0090:	04 30       	R0 = R4;
8d4e0092:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0096:	38 1a 00 00 
8d4e009a:	a0 a1       	R0 = [P4 + 0x18];
8d4e009c:	18 0c       	CC = R0 == 0x3;
8d4e009e:	9d 11       	IF !CC JUMP 0x0x8d4e03d8;
8d4e00a0:	07 30       	R0 = R7;
8d4e00a2:	01 da 03 84 	R1=-2080152104;
8d4e00a6:	d8 65 00 00 
8d4e00aa:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e00ae:	14 33 00 00 
8d4e00b2:	38 b1       	[FP + 0x10] = R0;
8d4e00b4:	77 30       	R6 = FP;
8d4e00b6:	46 67       	R6 += -0x18;		/* (-24) */
8d4e00b8:	06 30       	R0 = R6;
8d4e00ba:	e1 61       	R1 = 0x3c (X);		/*		R1=0x118(280) */
8d4e00bc:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e00c0:	96 10 00 00 
8d4e00c4:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e00c8:	38 a1 00 00 
8d4e00cc:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e00d0:	10 1b 00 00 
8d4e00d4:	06 30       	R0 = R6;
8d4e00d6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e00da:	38 1a 00 00 
8d4e00de:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x64] || NOP;
8d4e00e2:	71 b8 00 00 
8d4e00e6:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e00ea:	14 33 00 00 
8d4e00ee:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e00f2:	38 b1 00 00 
8d4e00f6:	99 e4 f8 ff 	R1 = B[P3 + -0x8] (Z);
8d4e00fa:	21 66       	R1 += -0x3c;		/* (-60) */
8d4e00fc:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0100:	96 10 00 00 
8d4e0104:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0108:	38 a1 00 00 
8d4e010c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0110:	10 1b 00 00 
8d4e0114:	06 30       	R0 = R6;
8d4e0116:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e011a:	38 1a 00 00 
8d4e011e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x54] || NOP;
8d4e0122:	b1 b8 00 00 
8d4e0126:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e012a:	14 33 00 00 
8d4e012e:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e0132:	38 b1 00 00 
8d4e0136:	99 e5 fc ff 	R1 = B[P3 + -0x4] (X);
8d4e013a:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e013e:	96 10 00 00 
8d4e0142:	0e 30       	R1 = R6;
8d4e0144:	38 a1       	R0 = [FP + 0x10];
8d4e0146:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e014a:	10 1b 00 00 
8d4e014e:	06 30       	R0 = R6;
8d4e0150:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0154:	38 1a 00 00 
8d4e0158:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x68] || NOP;
8d4e015c:	61 b8 00 00 
8d4e0160:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0164:	14 33 00 00 
8d4e0168:	99 e4 fb ff 	R1 = B[P3 + -0x5] (Z);
8d4e016c:	fa 61       	R2 = 0x3f (X);		/*		R2=0x150(336) */
8d4e016e:	38 b1       	[FP + 0x10] = R0;
8d4e0170:	11 54       	R0 = R1 & R2;
8d4e0172:	ff e3 f2 da 	CALL 0x0x8d4db756;
8d4e0176:	08 30       	R1 = R0;
8d4e0178:	06 30       	R0 = R6;
8d4e017a:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4e017e:	a8 19 00 00 
8d4e0182:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0186:	38 a1 00 00 
8d4e018a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e018e:	10 1b 00 00 
8d4e0192:	06 30       	R0 = R6;
8d4e0194:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0198:	38 1a 00 00 
8d4e019c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x5c] || NOP;
8d4e01a0:	91 b8 00 00 
8d4e01a4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e01a8:	14 33 00 00 
8d4e01ac:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e01b0:	38 b1 00 00 
8d4e01b4:	99 e5 fe ff 	R1 = B[P3 + -0x2] (X);
8d4e01b8:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e01bc:	96 10 00 00 
8d4e01c0:	0e 30       	R1 = R6;
8d4e01c2:	38 a1       	R0 = [FP + 0x10];
8d4e01c4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e01c8:	10 1b 00 00 
8d4e01cc:	06 30       	R0 = R6;
8d4e01ce:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e01d2:	38 1a 00 00 
8d4e01d6:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x6c] || NOP;
8d4e01da:	51 b8 00 00 
8d4e01de:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e01e2:	14 33 00 00 
8d4e01e6:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP + 0x10] = R0 || R0 = [FP -0x58];
8d4e01ea:	38 b1 a0 b8 
8d4e01ee:	9a e4 fb ff 	R2 = B[P3 + -0x5] (Z);
8d4e01f2:	0a c6 02 00 	R0 = EXTRACT (R2, R0.L) (Z);
8d4e01f6:	00 0c       	CC = R0 == 0x0;
8d4e01f8:	03 10       	IF !CC JUMP 0x0x8d4e01fe;
8d4e01fa:	19 e4 fd ff 	R1 = [P3 + -0xc];
8d4e01fe:	06 30       	R0 = R6;
8d4e0200:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0204:	96 10 00 00 
8d4e0208:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e020c:	38 a1 00 00 
8d4e0210:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0214:	10 1b 00 00 
8d4e0218:	06 30       	R0 = R6;
8d4e021a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e021e:	38 1a 00 00 
8d4e0222:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x3c] || NOP;
8d4e0226:	f1 a3 00 00 
8d4e022a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e022e:	14 33 00 00 
8d4e0232:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP + 0x10] = R0 || R0 = [FP -0x58];
8d4e0236:	38 b1 a0 b8 
8d4e023a:	9a e4 fb ff 	R2 = B[P3 + -0x5] (Z);
8d4e023e:	0a c6 02 00 	R0 = EXTRACT (R2, R0.L) (Z);
8d4e0242:	00 0c       	CC = R0 == 0x0;
8d4e0244:	03 18       	IF CC JUMP 0x0x8d4e024a;
8d4e0246:	19 e4 fd ff 	R1 = [P3 + -0xc];
8d4e024a:	06 30       	R0 = R6;
8d4e024c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0250:	96 10 00 00 
8d4e0254:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0258:	38 a1 00 00 
8d4e025c:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0260:	10 1b 00 00 
8d4e0264:	06 30       	R0 = R6;
8d4e0266:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e026a:	38 1a 00 00 
8d4e026e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x78] || NOP;
8d4e0272:	21 b8 00 00 
8d4e0276:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e027a:	14 33 00 00 
8d4e027e:	30 30       	R6 = R0;
8d4e0280:	99 e4 fa ff 	R1 = B[P3 + -0x6] (Z);
8d4e0284:	04 30       	R0 = R4;
8d4e0286:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e028a:	96 10 00 00 
8d4e028e:	06 30       	R0 = R6;
8d4e0290:	0c 30       	R1 = R4;
8d4e0292:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0296:	10 1b 00 00 
8d4e029a:	04 30       	R0 = R4;
8d4e029c:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e02a0:	38 1a 00 00 
8d4e02a4:	18 e4 f9 ff 	R0 = [P3 + -0x1c];
8d4e02a8:	00 0c       	CC = R0 == 0x0;
8d4e02aa:	77 10       	IF !CC JUMP 0x0x8d4e0398;
8d4e02ac:	18 e4 fa ff 	R0 = [P3 + -0x18];
8d4e02b0:	38 0c       	CC = R0 == -0x1;
8d4e02b2:	53 10       	IF !CC JUMP 0x0x8d4e0358;
8d4e02b4:	98 e5 fd ff 	R0 = B[P3 + -0x3] (X);
8d4e02b8:	00 0c       	CC = R0 == 0x0;
8d4e02ba:	2f 10       	IF !CC JUMP 0x0x8d4e0318;
8d4e02bc:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x74] || NOP;
8d4e02c0:	31 b8 00 00 
8d4e02c4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e02c8:	14 33 00 00 
8d4e02cc:	30 30       	R6 = R0;
8d4e02ce:	99 e4 ff ff 	R1 = B[P3 + -0x1] (Z);
8d4e02d2:	04 30       	R0 = R4;
8d4e02d4:	00 de 05 8c 	CALL.A 0x8c051066;
8d4e02d8:	66 10 00 00 
8d4e02dc:	06 30       	R0 = R6;
8d4e02de:	0c 30       	R1 = R4;
8d4e02e0:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e02e4:	10 1b 00 00 
8d4e02e8:	04 30       	R0 = R4;
8d4e02ea:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e02ee:	38 1a 00 00 
8d4e02f2:	03 c8 00 18 	MNOP || R1 = [FP -0x60] || R0 = [FP + 0x8];
8d4e02f6:	81 b8 b8 a0 
8d4e02fa:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e02fe:	14 33 00 00 
8d4e0302:	0f 30       	R1 = R7;
8d4e0304:	00 de 05 8c 	CALL.A 0x8c0531e4;
8d4e0308:	e4 31 00 00 
8d4e030c:	07 30       	R0 = R7;
8d4e030e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0312:	38 1a 00 00 
8d4e0316:	11 2e       	JUMP.S 0x0x8d4dff38;
8d4e0318:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x34] || NOP;
8d4e031c:	71 a3 00 00 
8d4e0320:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0324:	14 33 00 00 
8d4e0328:	38 b1       	[FP + 0x10] = R0;
8d4e032a:	77 30       	R6 = FP;
8d4e032c:	46 67       	R6 += -0x18;		/* (-24) */
8d4e032e:	99 e5 fd ff 	R1 = B[P3 + -0x3] (X);
8d4e0332:	06 30       	R0 = R6;
8d4e0334:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0338:	96 10 00 00 
8d4e033c:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0340:	38 a1 00 00 
8d4e0344:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0348:	10 1b 00 00 
8d4e034c:	06 30       	R0 = R6;
8d4e034e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0352:	38 1a 00 00 
8d4e0356:	b3 2f       	JUMP.S 0x0x8d4e02bc;
8d4e0358:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x38] || NOP;
8d4e035c:	b1 a3 00 00 
8d4e0360:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0364:	14 33 00 00 
8d4e0368:	38 b1       	[FP + 0x10] = R0;
8d4e036a:	77 30       	R6 = FP;
8d4e036c:	46 67       	R6 += -0x18;		/* (-24) */
8d4e036e:	19 e4 fa ff 	R1 = [P3 + -0x18];
8d4e0372:	06 30       	R0 = R6;
8d4e0374:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0378:	96 10 00 00 
8d4e037c:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0380:	38 a1 00 00 
8d4e0384:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0388:	10 1b 00 00 
8d4e038c:	06 30       	R0 = R6;
8d4e038e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0392:	38 1a 00 00 
8d4e0396:	8f 2f       	JUMP.S 0x0x8d4e02b4;
8d4e0398:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [SP + 0x30] || NOP;
8d4e039c:	31 a3 00 00 
8d4e03a0:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e03a4:	14 33 00 00 
8d4e03a8:	38 b1       	[FP + 0x10] = R0;
8d4e03aa:	77 30       	R6 = FP;
8d4e03ac:	46 67       	R6 += -0x18;		/* (-24) */
8d4e03ae:	19 e4 f9 ff 	R1 = [P3 + -0x1c];
8d4e03b2:	06 30       	R0 = R6;
8d4e03b4:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e03b8:	96 10 00 00 
8d4e03bc:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e03c0:	38 a1 00 00 
8d4e03c4:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e03c8:	10 1b 00 00 
8d4e03cc:	06 30       	R0 = R6;
8d4e03ce:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e03d2:	38 1a 00 00 
8d4e03d6:	6b 2f       	JUMP.S 0x0x8d4e02ac;
8d4e03d8:	07 30       	R0 = R7;
8d4e03da:	01 da 03 84 	R1=-2080152104;
8d4e03de:	d8 65 00 00 
8d4e03e2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e03e6:	14 33 00 00 
8d4e03ea:	38 b1       	[FP + 0x10] = R0;
8d4e03ec:	77 30       	R6 = FP;
8d4e03ee:	46 67       	R6 += -0x18;		/* (-24) */
8d4e03f0:	99 e4 f8 ff 	R1 = B[P3 + -0x8] (Z);
8d4e03f4:	06 30       	R0 = R6;
8d4e03f6:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e03fa:	96 10 00 00 
8d4e03fe:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0402:	38 a1 00 00 
8d4e0406:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e040a:	10 1b 00 00 
8d4e040e:	06 30       	R0 = R6;
8d4e0410:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0414:	38 1a 00 00 
8d4e0418:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x54] || NOP;
8d4e041c:	b1 b8 00 00 
8d4e0420:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0424:	14 33 00 00 
8d4e0428:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e042c:	38 b1 00 00 
8d4e0430:	99 e5 fc ff 	R1 = B[P3 + -0x4] (X);
8d4e0434:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0438:	96 10 00 00 
8d4e043c:	0e 30       	R1 = R6;
8d4e043e:	38 a1       	R0 = [FP + 0x10];
8d4e0440:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0444:	10 1b 00 00 
8d4e0448:	06 30       	R0 = R6;
8d4e044a:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e044e:	38 1a 00 00 
8d4e0452:	07 30       	R0 = R7;
8d4e0454:	31 e4 12 00 	R1 = [SP + 0x48];
8d4e0458:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e045c:	14 33 00 00 
8d4e0460:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e0464:	38 b1 00 00 
8d4e0468:	19 e4 fb ff 	R1 = [P3 + -0x14];
8d4e046c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0470:	96 10 00 00 
8d4e0474:	0e 30       	R1 = R6;
8d4e0476:	38 a1       	R0 = [FP + 0x10];
8d4e0478:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e047c:	10 1b 00 00 
8d4e0480:	06 30       	R0 = R6;
8d4e0482:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0486:	38 1a 00 00 
8d4e048a:	07 30       	R0 = R7;
8d4e048c:	31 e4 11 00 	R1 = [SP + 0x44];
8d4e0490:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0494:	14 33 00 00 
8d4e0498:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e049c:	38 b1 00 00 
8d4e04a0:	19 e4 fc ff 	R1 = [P3 + -0x10];
8d4e04a4:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e04a8:	96 10 00 00 
8d4e04ac:	0e 30       	R1 = R6;
8d4e04ae:	38 a1       	R0 = [FP + 0x10];
8d4e04b0:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e04b4:	10 1b 00 00 
8d4e04b8:	06 30       	R0 = R6;
8d4e04ba:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e04be:	38 1a 00 00 
8d4e04c2:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x7c] || NOP;
8d4e04c6:	11 b8 00 00 
8d4e04ca:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e04ce:	14 33 00 00 
8d4e04d2:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP + 0x10] = R0 || NOP;
8d4e04d6:	38 b1 00 00 
8d4e04da:	1a e4 fd ff 	R2 = [P3 + -0xc];
8d4e04de:	1b e4 f8 ff 	R3 = [P3 + -0x20];
8d4e04e2:	31 c2 53 20 	R1 = R2 * R3 (T);
8d4e04e6:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e04ea:	96 10 00 00 
8d4e04ee:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e04f2:	38 a1 00 00 
8d4e04f6:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e04fa:	10 1b 00 00 
8d4e04fe:	06 30       	R0 = R6;
8d4e0500:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0504:	38 1a 00 00 
8d4e0508:	07 30       	R0 = R7;
8d4e050a:	31 e4 10 00 	R1 = [SP + 0x40];
8d4e050e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0512:	14 33 00 00 
8d4e0516:	99 e4 fb ff 	R1 = B[P3 + -0x5] (Z);
8d4e051a:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || R2 = [FP -0x58] || [FP + 0x10] = R0;
8d4e051e:	a2 b8 38 b1 
8d4e0522:	0a c6 11 02 	R1 = EXTRACT (R1, R2.L) (Z);
8d4e0526:	01 0c       	CC = R1 == 0x0;
8d4e0528:	11 02       	ILLEGAL;
8d4e052a:	00 de 05 8c 	CALL.A 0x8c051066;
8d4e052e:	66 10 00 00 
8d4e0532:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0536:	38 a1 00 00 
8d4e053a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e053e:	10 1b 00 00 
8d4e0542:	06 30       	R0 = R6;
8d4e0544:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0548:	38 1a 00 00 
8d4e054c:	98 e4 fb ff 	R0 = B[P3 + -0x5] (Z);
8d4e0550:	72 e4 39 00 	R2 = W[SP + 0x72] (Z);
8d4e0554:	0a ce 10 00 	R0 = EXTRACT (R0, R2.L) (Z) || R1 = [SP + 0x2c] || NOP;
8d4e0558:	f1 a2 00 00 
8d4e055c:	00 0c       	CC = R0 == 0x0;
8d4e055e:	88 1e       	IF CC JUMP 0x0x8d4e026e (BP);
8d4e0560:	07 30       	R0 = R7;
8d4e0562:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0566:	14 33 00 00 
8d4e056a:	04 cc 09 42 	R1 = R1 - R1 (NS) || [FP + 0x10] = R0 || NOP;
8d4e056e:	38 b1 00 00 
8d4e0572:	77 30       	R6 = FP;
8d4e0574:	a6 67       	R6 += -0xc;		/* (-12) */
8d4e0576:	06 30       	R0 = R6;
8d4e0578:	00 de 05 8c 	CALL.A 0x8c051066;
8d4e057c:	66 10 00 00 
8d4e0580:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x10] || NOP;
8d4e0584:	38 a1 00 00 
8d4e0588:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e058c:	10 1b 00 00 
8d4e0590:	06 30       	R0 = R6;
8d4e0592:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0596:	38 1a 00 00 
8d4e059a:	6a 2e       	JUMP.S 0x0x8d4e026e;
8d4e059c:	10 0c       	CC = R0 == 0x2;
8d4e059e:	02 10       	IF !CC JUMP 0x0x8d4e05a2;
8d4e05a0:	1e 2c       	JUMP.S 0x0x8d4dfddc;
8d4e05a2:	f1 60       	R1 = 0x1e (X);		/*		R1=0x118(280) */
8d4e05a4:	08 08       	CC = R0 == R1;
8d4e05a6:	02 10       	IF !CC JUMP 0x0x8d4e05aa;
8d4e05a8:	1a 2c       	JUMP.S 0x0x8d4dfddc;
8d4e05aa:	cb 2c       	JUMP.S 0x0x8d4dff40;
8d4e05ac:	00 00       	NOP;
8d4e05ae:	00 00       	NOP;
8d4e05b0:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4e05b4:	d1 b8 b8 a0 
8d4e05b8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e05bc:	14 33 00 00 
8d4e05c0:	05 da 03 84 	R5=-2080152904;
8d4e05c4:	b8 62 00 00 
8d4e05c8:	22 e1 18 01 	R2 = 0x118 (X);		/*		R2=0x118(280) */
8d4e05cc:	55 50       	R1 = R5 + R2;
8d4e05ce:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e05d2:	14 33 00 00 
8d4e05d6:	23 e1 94 38 	R3 = 0x3894 (X);		/*		R3=0x3894(14484) */
8d4e05da:	28 30       	R5 = R0;
8d4e05dc:	1c 50       	R0 = R4 + R3;
8d4e05de:	7f 30       	R7 = FP;
8d4e05e0:	ff e3 25 f3 	CALL 0x0x8d4dec2a;
8d4e05e4:	87 66       	R7 += -0x30;		/* (-48) */
8d4e05e6:	08 30       	R1 = R0;
8d4e05e8:	07 30       	R0 = R7;
8d4e05ea:	00 de 05 8c 	CALL.A 0x8c0519a8;
8d4e05ee:	a8 19 00 00 
8d4e05f2:	05 30       	R0 = R5;
8d4e05f4:	0f 30       	R1 = R7;
8d4e05f6:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e05fa:	10 1b 00 00 
8d4e05fe:	07 30       	R0 = R7;
8d4e0600:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0604:	38 1a 00 00 
8d4e0608:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4e060c:	d1 b8 b8 a0 
8d4e0610:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0614:	14 33 00 00 
8d4e0618:	01 da 03 84 	R1=-2080151972;
8d4e061c:	5c 66 00 00 
8d4e0620:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0624:	14 33 00 00 
8d4e0628:	22 e1 98 38 	R2 = 0x3898 (X);		/*		R2=0x3898(14488) */
8d4e062c:	28 30       	R5 = R0;
8d4e062e:	14 50       	R0 = R4 + R2;
8d4e0630:	ff e3 ab ea 	CALL 0x0x8d4ddb86;
8d4e0634:	08 30       	R1 = R0;
8d4e0636:	07 30       	R0 = R7;
8d4e0638:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e063c:	96 10 00 00 
8d4e0640:	05 30       	R0 = R5;
8d4e0642:	0f 30       	R1 = R7;
8d4e0644:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0648:	10 1b 00 00 
8d4e064c:	07 30       	R0 = R7;
8d4e064e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0652:	38 1a 00 00 
8d4e0656:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4e065a:	d1 b8 b8 a0 
8d4e065e:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0662:	14 33 00 00 
8d4e0666:	05 da 03 84 	R5=-2080152904;
8d4e066a:	b8 62 00 00 
8d4e066e:	22 e1 94 01 	R2 = 0x194 (X);		/*		R2=0x194(404) */
8d4e0672:	55 50       	R1 = R5 + R2;
8d4e0674:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0678:	14 33 00 00 
8d4e067c:	23 e1 9c 38 	R3 = 0x389c (X);		/*		R3=0x389c(14492) */
8d4e0680:	28 30       	R5 = R0;
8d4e0682:	1c 50       	R0 = R4 + R3;
8d4e0684:	ff e3 81 ea 	CALL 0x0x8d4ddb86;
8d4e0688:	08 30       	R1 = R0;
8d4e068a:	07 30       	R0 = R7;
8d4e068c:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e0690:	96 10 00 00 
8d4e0694:	05 30       	R0 = R5;
8d4e0696:	0f 30       	R1 = R7;
8d4e0698:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e069c:	10 1b 00 00 
8d4e06a0:	07 30       	R0 = R7;
8d4e06a2:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e06a6:	38 1a 00 00 
8d4e06aa:	03 c8 00 18 	MNOP || R1 = [FP -0x4c] || R0 = [FP + 0x8];
8d4e06ae:	d1 b8 b8 a0 
8d4e06b2:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e06b6:	14 33 00 00 
8d4e06ba:	05 da 03 84 	R5=-2080152904;
8d4e06be:	b8 62 00 00 
8d4e06c2:	22 e1 a0 01 	R2 = 0x1a0 (X);		/*		R2=0x1a0(416) */
8d4e06c6:	55 50       	R1 = R5 + R2;
8d4e06c8:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e06cc:	14 33 00 00 
8d4e06d0:	23 e1 a0 38 	R3 = 0x38a0 (X);		/*		R3=0x38a0(14496) */
8d4e06d4:	28 30       	R5 = R0;
8d4e06d6:	1c 50       	R0 = R4 + R3;
8d4e06d8:	ff e3 57 ea 	CALL 0x0x8d4ddb86;
8d4e06dc:	08 30       	R1 = R0;
8d4e06de:	07 30       	R0 = R7;
8d4e06e0:	00 de 05 8c 	CALL.A 0x8c051096;
8d4e06e4:	96 10 00 00 
8d4e06e8:	05 30       	R0 = R5;
8d4e06ea:	0f 30       	R1 = R7;
8d4e06ec:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e06f0:	10 1b 00 00 
8d4e06f4:	07 30       	R0 = R7;
8d4e06f6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e06fa:	38 1a 00 00 
8d4e06fe:	ff e2 e1 f6 	JUMP.L 0x0x8d4df4c0;
8d4e0702:	00 00       	NOP;
8d4e0704:	00 00       	NOP;
8d4e0706:	00 00       	NOP;
8d4e0708:	00 da 03 84 	R0=-2080151768;
8d4e070c:	28 67 00 00 
8d4e0710:	00 de 04 8c 	CALL.A 0x8c0405a4;
8d4e0714:	a4 05 00 00 
8d4e0718:	ff e2 cc f2 	JUMP.L 0x0x8d4decb0;
8d4e071c:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d4e0720:	68 05       	[--SP] = (R7:5);
8d4e0722:	38 30       	R7 = R0;
8d4e0724:	47 30       	R0 = FP;
8d4e0726:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e0728:	40 66       	R0 += -0x38;		/* (-56) */
8d4e072a:	77 30       	R6 = FP;
8d4e072c:	29 30       	R5 = R1;
8d4e072e:	06 e3 85 1f 	CALL 0x0x8d5a4638;
8d4e0732:	26 67       	R6 += -0x1c;		/* (-28) */
8d4e0734:	0d 30       	R1 = R5;
8d4e0736:	06 30       	R0 = R6;
8d4e0738:	06 e3 be 1f 	CALL 0x0x8d5a46b4;
8d4e073c:	0e 30       	R1 = R6;
8d4e073e:	07 30       	R0 = R7;
8d4e0740:	16 30       	R2 = R6;
8d4e0742:	21 67       	R1 += -0x1c;		/* (-28) */
8d4e0744:	06 e3 b1 20 	CALL 0x0x8d5a48a6;
8d4e0748:	87 60       	R7 = 0x10 (X);		/*		R7=0xac(172) */
8d4e074a:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R0 = [FP -0x4] || NOP;
8d4e074e:	f0 b9 00 00 
8d4e0752:	07 0a       	CC = R7 <= R0 (IU);
8d4e0754:	1a 18       	IF CC JUMP 0x0x8d4e0788;
8d4e0756:	78 60       	R0 = 0xf (X);		/*		R0=0x94(148) */
8d4e0758:	f0 bb       	[FP -0x4] = R0;
8d4e075a:	30 a3       	R0 = [SP + 0x30];
8d4e075c:	07 0a       	CC = R7 <= R0 (IU);
8d4e075e:	e6 bb       	[FP -0x8] = R6;
8d4e0760:	b6 e6 38 00 	B[SP + 0x38] = R6;
8d4e0764:	08 18       	IF CC JUMP 0x0x8d4e0774;
8d4e0766:	b6 e6 1c 00 	B[SP + 0x1c] = R6;
8d4e076a:	66 6c       	SP += 0xc;		/* ( 12) */
