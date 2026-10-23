
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d4d65fa <.data+0xa5da>:
8d4d65fa:	01 32       	P0 = R1;
8d4d65fc:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8d4d65fe:	01 09       	CC = R1 <= R0;
8d4d6600:	00 e8 14 00 	LINK 0x50;		/* (80) */
8d4d6604:	26 18       	IF CC JUMP 0x0x8d4d6650;
8d4d6606:	b0 e6 1c 00 	B[SP + 0x1c] = R0;
8d4d660a:	4f 32       	P1 = FP;
8d4d660c:	69 6e       	P1 += -0x33;		/* (-51) */
8d4d660e:	00 90       	R0 = [P0++];
8d4d6610:	c0 e0 02 2c 	LSETUP_IMM(bottom=0x8d4d6614) LC0 count_fields=0x0/0xb;
8d4d6614:	03 c8 00 18 	MNOP || [P1++] = R0 || R0 = [P0++];
8d4d6618:	08 92 00 90 
8d4d661c:	08 93       	[P1] = R0;
8d4d661e:	29 e1 ff 00 	P1 = 0xff (X);		/*		P1=0xff(255) */
8d4d6622:	b1 bd       	[SP + 0x18] = P1;
8d4d6624:	71 bd       	[SP + 0x14] = P1;
8d4d6626:	57 30       	R2 = FP;
8d4d6628:	62 66       	R2 += -0x34;		/* (-52) */
8d4d662a:	01 68       	P1 = 0x0 (X);		/*		P1=0xff(255) */
8d4d662c:	31 bd       	[SP + 0x10] = P1;
8d4d662e:	89 69       	P1 = 0x31 (X);		/*		P1=0xff(255) */
8d4d6630:	f1 bc       	[SP + 0xc] = P1;
8d4d6632:	21 e1 c0 00 	R1 = 0xc0 (X);		/*		R1=0xc0(192) */
8d4d6636:	00 da 14 84 	R0=-2079062884;
8d4d663a:	9c 04 00 00 
8d4d663e:	00 de a0 11 	CALL.A 0x11a00ec8;
8d4d6642:	c8 0e 00 00 
8d4d6646:	01 e8 00 00 	UNLINK;
