
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d55fdb4 <.data+0x93d94>:
8d55fdb4:	00 e8 02 00 	LINK 0x8;		/* (8) */
8d55fdb8:	70 05       	[--SP] = (R7:6);
8d55fdba:	86 6f       	SP += -0x10;		/* (-16) */
8d55fdbc:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R1 || NOP;
8d55fdc0:	f1 b0 00 00 
8d55fdc4:	46 30       	R0 = SP;
8d55fdc6:	c2 60       	R2 = 0x18 (X);		/*		R2=0x0(  0) */
8d55fdc8:	90 51       	R6 = R0 + R2;
8d55fdca:	06 30       	R0 = R6;
8d55fdcc:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8d55fdce:	02 da 06 84 	R2=-2079940832;
8d55fdd2:	20 9f 00 00 
8d55fdd6:	00 de 04 8c 	CALL.A 0x8c0499a8;
8d55fdda:	a8 99 00 00 
8d55fdde:	0e 30       	R1 = R6;
8d55fde0:	07 30       	R0 = R7;
8d55fde2:	00 de 03 8c 	CALL.A 0x8c03ee00;
8d55fde6:	00 ee 00 00 
8d55fdea:	86 6c       	SP += 0x10;		/* ( 16) */
8d55fdec:	30 05       	(R7:6) = [SP++];
8d55fdee:	01 e8 00 00 	UNLINK;
8d55fdf2:	10 00       	RTS;
