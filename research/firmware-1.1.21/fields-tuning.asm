
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d4dff40 <.data+0x13f20>:
8d4dff40:	29 e1 94 53 	P1 = 0x5394 (X);		/*		P1=0x5394(21396) */
8d4dff44:	4c 5b       	P5 = P4 + P1;
8d4dff46:	4d 32       	P1 = P5;
8d4dff48:	c0 e0 04 30 	LSETUP_IMM(bottom=0x8d4dff50) LC0 count_fields=0x0/0xc;
8d4dff4c:	08 90       	R0 = [P1++];
8d4dff4e:	00 0c       	CC = R0 == 0x0;
8d4dff50:	65 10       	IF !CC JUMP 0x0x8d4e001a;
8d4dff52:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
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
8d4dff86:	31 60       	R1 = 0x6 (X);		/*		R1=0x0(  0) */
8d4dff88:	00 de 05 8c 	CALL.A 0x8c053038;
8d4dff8c:	38 30 00 00 
8d4dff90:	05 30       	R0 = R5;
8d4dff92:	0f 30       	R1 = R7;
8d4dff94:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4dff98:	10 1b 00 00 
8d4dff9c:	07 30       	R0 = R7;
8d4dff9e:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4dffa2:	38 1a 00 00 
8d4dffa6:	04 60       	R4 = 0x0 (X);		/*		R4=0x0(  0) */
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
8d4e0000:	60 60       	R0 = 0xc (X);		/*		R0=0x0(  0) */
8d4e0002:	84 08       	CC = R4 < R0;
8d4e0004:	d2 1f       	IF CC JUMP 0x0x8d4dffa8 (BP);
8d4e0006:	40 b8       	R0 = [FP -0x70];
8d4e0008:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e000c:	38 1a 00 00 
8d4e0010:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e0012:	a3 05       	(R7:4, P5:3) = [SP++];
8d4e0014:	01 e8 00 00 	UNLINK;
8d4e0018:	10 00       	RTS;
8d4e001a:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4e001c:	9c 2f       	JUMP.S 0x0x8d4dff54;

