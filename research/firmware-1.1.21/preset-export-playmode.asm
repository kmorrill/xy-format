
os.ldr@0x8d4dec2a:     file format binary


Disassembly of section .data:

8d4dec2a <.data>:
8d4dec2a:	08 32       	P1 = R0;
8d4dec2c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4dec30:	00 da 03 84 	R0=-2080152560;
8d4dec34:	10 64 00 00 
8d4dec38:	09 91       	R1 = [P1];
8d4dec3a:	41 4d       	R1 >>>= 0x8;
8d4dec3c:	82 c6 11 84 	R2 = R1 << 0x2;
8d4dec40:	4a 52       	R1 = R2 - R1;
8d4dec42:	b9 4d       	R1 >>>= 0x17;
8d4dec44:	01 0c       	CC = R1 == 0x0;
8d4dec46:	0e 18       	IF CC JUMP 0x0x8d4dec62;
8d4dec48:	09 0c       	CC = R1 == 0x1;
8d4dec4a:	0b 18       	IF CC JUMP 0x0x8d4dec60;
8d4dec4c:	01 e8 00 00 	UNLINK;
8d4dec50:	11 0c       	CC = R1 == 0x2;
8d4dec52:	80 64       	R0 += 0x10;		/* ( 16) */
8d4dec54:	01 da 03 84 	R1=-2080152560;
8d4dec58:	10 64 00 00 
8d4dec5c:	01 06       	IF !CC R0 = R1;
8d4dec5e:	10 00       	RTS;
8d4dec60:	40 64       	R0 += 0x8;		/* (  8) */
8d4dec62:	01 e8 00 00 	UNLINK;
8d4dec66:	10 00       	RTS;
8d4dec68:	00 00       	NOP;
8d4dec6a:	00 00       	NOP;
