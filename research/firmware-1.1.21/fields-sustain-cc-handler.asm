
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d579d80 <.data+0xadd60>:
8d579d80:	10 30       	R2 = R0;
8d579d82:	02 32       	P0 = R2;
8d579d84:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d579d88:	ff e3 ab fe 	CALL 0x0x8d579ade;
8d579d8c:	f9 61       	R1 = 0x3f (X);		/*		R1=0x0(  0) */
8d579d8e:	22 64       	R2 += 0x4;		/* (  4) */
8d579d90:	83 e4 02 00 	R3 = B[P0 + 0x2] (Z);
8d579d94:	99 08       	CC = R1 < R3;
8d579d96:	f2 b0       	[SP + 0xc] = R2;
8d579d98:	41 43       	R1 = R0.B (Z);
8d579d9a:	02 02       	R2 = CC;
8d579d9c:	00 da 0c 86 	R0=-2046028680;
8d579da0:	78 14 00 00 
8d579da4:	00 e3 e0 48 	CALL 0x0x8d582f64;
8d579da8:	01 e8 00 00 	UNLINK;
8d579dac:	10 00       	RTS;
