
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d591de0.bin:     file format binary


Disassembly of section .data:

8d5a21a8 <.data+0x103c8>:
8d5a21a8:	98 0d       	CC = R0 < 0x3 (IU);
8d5a21aa:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a21ae:	0f 18       	IF CC JUMP 0x0x8d5a21cc;
8d5a21b0:	18 0c       	CC = R0 == 0x3;
8d5a21b2:	09 18       	IF CC JUMP 0x0x8d5a21c4;
8d5a21b4:	f1 60       	R1 = 0x1e (X);		/*		R1=0x0(  0) */
8d5a21b6:	08 08       	CC = R0 == R1;
8d5a21b8:	06 18       	IF CC JUMP 0x0x8d5a21c4;
8d5a21ba:	01 e8 00 00 	UNLINK;
8d5a21be:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a21c0:	10 00       	RTS;
8d5a21c2:	00 00       	NOP;
8d5a21c4:	01 e8 00 00 	UNLINK;
8d5a21c8:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d5a21ca:	10 00       	RTS;
8d5a21cc:	10 0c       	CC = R0 == 0x2;
8d5a21ce:	f6 13       	IF !CC JUMP 0x0x8d5a21ba;
8d5a21d0:	01 e8 00 00 	UNLINK;
8d5a21d4:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d5a21d6:	10 00       	RTS;
