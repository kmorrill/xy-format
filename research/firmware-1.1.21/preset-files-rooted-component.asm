
os.ldr@0x8c03ee82:     file format binary


Disassembly of section .data:

8c03ee82 <.data>:
8c03ee82:	01 32       	P0 = R1;
8c03ee84:	00 e8 09 00 	LINK 0x24;		/* (36) */
8c03ee88:	e3 05       	[--SP] = (R7:4, P5:3);
8c03ee8a:	86 6f       	SP += -0x10;		/* (-16) */
8c03ee8c:	f0 b2       	[SP + 0x2c] = R0;
8c03ee8e:	03 c8 00 18 	MNOP || R2 = [P0 + 0x14] || [SP + 0x30] = R0;
8c03ee92:	42 a1 30 b3 
8c03ee96:	02 0c       	CC = R2 == 0x0;
8c03ee98:	01 da 90 11 	R1=294680288;
8c03ee9c:	e0 76 00 00 
8c03eea0:	ba 18       	IF CC JUMP 0x0x8c03f014;
8c03eea2:	03 c8 00 18 	MNOP || R2 = [P0 + 0x18] || [FP + 0x8] = P0;
8c03eea6:	82 a1 b8 bc 
8c03eeaa:	20 6c       	P0 += 0x4;		/* (  4) */
8c03eeac:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8c03eeae:	38 bd       	[FP + 0x10] = P0;
8c03eeb0:	17 0a       	CC = R7 <= R2 (IU);
8c03eeb2:	39 ad       	P1 = [FP + 0x10];
8c03eeb4:	02 10       	IF !CC JUMP 0x0x8c03eeb8;
8c03eeb6:	49 91       	P1 = [P1];
8c03eeb8:	4a 99       	R2 = B[P1] (X);
8c03eeba:	7b 61       	R3 = 0x2f (X);		/*		R3=0x0(  0) */
8c03eebc:	1a 08       	CC = R2 == R3;
8c03eebe:	a3 10       	IF !CC JUMP 0x0x8c03f004;
8c03eec0:	57 30       	R2 = FP;
8c03eec2:	22 67       	R2 += -0x1c;		/* (-28) */
8c03eec4:	fa b0       	[FP + 0xc] = R2;
8c03eec6:	e1 67       	R1 += -0x4;		/* ( -4) */
8c03eec8:	0d 68       	P5 = 0x1 (X);		/*		P5=0x0(  0) */
8c03eeca:	f8 a0       	R0 = [FP + 0xc];
8c03eecc:	ff e3 9a ff 	CALL 0x0x8c03ee00;
8c03eed0:	b9 ac       	P1 = [FP + 0x8];
8c03eed2:	45 30       	R0 = P5;
8c03eed4:	55 32       	P2 = P5;
8c03eed6:	0d 6c       	P5 += 0x1;		/* (  1) */
8c03eed8:	49 a1       	R1 = [P1 + 0x14];
8c03eeda:	88 09       	CC = R0 < R1 (IU);
8c03eedc:	5b 10       	IF !CC JUMP 0x0x8c03ef92;
8c03eede:	03 c8 00 18 	MNOP || P1 = [FP + 0x10] || R0 = [P1 + 0x18];
8c03eee2:	39 ad 88 a1 
8c03eee6:	07 0a       	CC = R7 <= R0 (IU);
8c03eee8:	03 10       	IF !CC JUMP 0x0x8c03eeee;
8c03eeea:	b9 ac       	P1 = [FP + 0x8];
8c03eeec:	49 ac       	P1 = [P1 + 0x4];
8c03eeee:	03 c8 00 18 	MNOP || P3 = [SP + 0x38] || R1 = [FP -0x4];
8c03eef2:	b3 af f1 b9 
8c03eef6:	47 32       	P0 = FP;
8c03eef8:	0f 0a       	CC = R7 <= R1 (IU);
8c03eefa:	40 6f       	P0 += -0x18;		/* (-24) */
8c03eefc:	c3 07       	IF CC P0 = P3;
8c03eefe:	03 c8 00 18 	MNOP || P4 = [FP -0x8] || R0 = [FP -0x8];
8c03ef02:	ec b9 e0 b9 
8c03ef06:	03 68       	P3 = 0x0 (X);		/*		P3=0x0(  0) */
8c03ef08:	51 5a       	P1 = P1 + P2;
8c03ef0a:	4d 99       	R5 = B[P1] (X);
8c03ef0c:	20 5a       	P0 = P0 + P4;
8c03ef0e:	40 0c       	CC = P0 == 0x0;
8c03ef10:	dc 06       	IF !CC P3 = P4;
8c03ef12:	73 30       	R6 = P3;
8c03ef14:	b0 09       	CC = R0 < R6 (IU);
8c03ef16:	70 18       	IF CC JUMP 0x0x8c03eff6;
8c03ef18:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8c03ef1c:	b8 00 01 00 
8c03ef20:	01 52       	R0 = R1 - R0;
8c03ef22:	08 0e       	CC = R0 <= 0x1 (IU);
8c03ef24:	63 18       	IF CC JUMP 0x0x8c03efea;
8c03ef26:	04 cc 12 44 	R2 = R2 - R2 (NS) || R4 = [FP -0x8] || R0 = [FP + 0xc];
8c03ef2a:	e4 b9 f8 a0 
8c03ef2e:	0c 64       	R4 += 0x1;		/* (  1) */
8c03ef30:	0c 30       	R1 = R4;
8c03ef32:	ff e3 07 fc 	CALL 0x0x8c03e740;
8c03ef36:	00 0c       	CC = R0 == 0x0;
8c03ef38:	2a 18       	IF CC JUMP 0x0x8c03ef8c;
8c03ef3a:	03 c8 00 18 	MNOP || P0 = [SP + 0x38] || R0 = [FP -0x4];
8c03ef3e:	b0 af f0 b9 
8c03ef42:	4f 32       	P1 = FP;
8c03ef44:	07 0a       	CC = R7 <= R0 (IU);
8c03ef46:	41 6f       	P1 += -0x18;		/* (-24) */
8c03ef48:	c8 07       	IF CC P1 = P0;
8c03ef4a:	e1 b9       	R1 = [FP -0x8];
8c03ef4c:	b1 52       	R2 = R1 - R6;
8c03ef4e:	67 32       	P4 = FP;
8c03ef50:	44 6f       	P4 += -0x18;		/* (-24) */
8c03ef52:	19 5a       	P0 = P1 + P3;
8c03ef54:	99 5a       	P2 = P1 + P3;
8c03ef56:	08 6c       	P0 += 0x1;		/* (  1) */
8c03ef58:	4a 30       	R1 = P2;
8c03ef5a:	40 30       	R0 = P0;
8c03ef5c:	00 de 02 04 	CALL.A 0x04020218;
8c03ef60:	18 02 00 00 
8c03ef64:	04 cc 09 42 	R1 = R1 - R1 (NS) || P2 = [SP + 0x38] || R0 = [FP -0x4];
8c03ef68:	b2 af f0 b9 
8c03ef6c:	07 0a       	CC = R7 <= R0 (IU);
8c03ef6e:	4f 32       	P1 = FP;
8c03ef70:	41 6f       	P1 += -0x18;		/* (-24) */
8c03ef72:	e2 07       	IF CC P4 = P2;
8c03ef74:	04 32       	P0 = R4;
8c03ef76:	9c 5a       	P2 = P4 + P3;
8c03ef78:	15 9b       	B[P2] = R5;
8c03ef7a:	03 c8 00 18 	MNOP || P2 = [SP + 0x38] || R0 = [FP -0x4];
8c03ef7e:	b2 af f0 b9 
8c03ef82:	07 0a       	CC = R7 <= R0 (IU);
8c03ef84:	e4 bb       	[FP -0x8] = R4;
8c03ef86:	ca 07       	IF CC P1 = P2;
8c03ef88:	41 5a       	P1 = P1 + P0;
8c03ef8a:	09 9b       	B[P1] = R1;
8c03ef8c:	78 61       	R0 = 0x2f (X);		/*		R0=0x0(  0) */
8c03ef8e:	05 08       	CC = R5 == R0;
8c03ef90:	a0 17       	IF !CC JUMP 0x0x8c03eed0 (BP);
8c03ef92:	04 cc 12 44 	R2 = R2 - R2 (NS) || P0 = [SP + 0x30] || R1 = [FP + 0xc];
8c03ef96:	30 af f9 a0 
8c03ef9a:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R0 = [SP + 0x2c] || NOP;
8c03ef9e:	f0 a2 00 00 
8c03efa2:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8c03efa4:	42 b1       	[P0 + 0x14] = R2;
8c03efa6:	86 e6 04 00 	B[P0 + 0x4] = R6;
8c03efaa:	83 b1       	[P0 + 0x18] = R3;
8c03efac:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8c03efb0:	b8 00 03 00 
8c03efb4:	f3 b0       	[SP + 0xc] = R3;
8c03efb6:	ff e3 dd fc 	CALL 0x0x8c03e970;
8c03efba:	f0 b9       	R0 = [FP -0x4];
8c03efbc:	07 0a       	CC = R7 <= R0 (IU);
8c03efbe:	09 18       	IF CC JUMP 0x0x8c03efd0;
8c03efc0:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c03efc2:	b0 e6 38 00 	B[SP + 0x38] = R0;
8c03efc6:	86 6c       	SP += 0x10;		/* ( 16) */
8c03efc8:	a3 05       	(R7:4, P5:3) = [SP++];
8c03efca:	01 e8 00 00 	UNLINK;
8c03efce:	10 00       	RTS;
8c03efd0:	b0 a3       	R0 = [SP + 0x38];
8c03efd2:	00 de 4c 8d 	CALL.A 0x8d4ce3e4;
8c03efd6:	e4 e3 00 00 
8c03efda:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c03efdc:	b0 e6 38 00 	B[SP + 0x38] = R0;
8c03efe0:	86 6c       	SP += 0x10;		/* ( 16) */
8c03efe2:	a3 05       	(R7:4, P5:3) = [SP++];
8c03efe4:	01 e8 00 00 	UNLINK;
8c03efe8:	10 00       	RTS;
8c03efea:	f8 a0       	R0 = [FP + 0xc];
8c03efec:	00 de ed 8f 	CALL.A 0x8fed519c;
8c03eff0:	9c 51 00 00 
8c03eff4:	99 2f       	JUMP.S 0x0x8c03ef26;
8c03eff6:	f8 a0       	R0 = [FP + 0xc];
8c03eff8:	00 de ed 8f 	CALL.A 0x8fed51a2;
8c03effc:	a2 51 00 00 
8c03f000:	e0 b9       	R0 = [FP -0x8];
8c03f002:	8b 2f       	JUMP.S 0x0x8c03ef18;
8c03f004:	ff e3 fe fe 	CALL 0x0x8c03ee00;
8c03f008:	86 6c       	SP += 0x10;		/* ( 16) */
8c03f00a:	a3 05       	(R7:4, P5:3) = [SP++];
8c03f00c:	01 e8 00 00 	UNLINK;
8c03f010:	10 00       	RTS;
8c03f012:	00 00       	NOP;
8c03f014:	ff e3 f6 fe 	CALL 0x0x8c03ee00;
8c03f018:	86 6c       	SP += 0x10;		/* ( 16) */
8c03f01a:	a3 05       	(R7:4, P5:3) = [SP++];
8c03f01c:	01 e8 00 00 	UNLINK;
8c03f020:	10 00       	RTS;
8c03f022:	00 00       	NOP;
