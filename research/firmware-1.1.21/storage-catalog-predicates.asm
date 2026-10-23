
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d4fd02e <.data+0x3100e>:
8d4fd02e:	80 0c       	CC = R0 < 0x0;
8d4fd030:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4fd034:	04 18       	IF CC JUMP 0x0x8d4fd03c;
8d4fd036:	91 60       	R1 = 0x12 (X);		/*		R1=0x0(  0) */
8d4fd038:	88 08       	CC = R0 < R1;
8d4fd03a:	05 18       	IF CC JUMP 0x0x8d4fd044;
8d4fd03c:	01 e8 00 00 	UNLINK;
8d4fd040:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4fd042:	10 00       	RTS;
8d4fd044:	81 61       	R1 = 0x30 (X);		/*		R1=0x0(  0) */
8d4fd046:	02 da 6d 84 	R2=-2073166720;
8d4fd04a:	80 fc 00 00 
8d4fd04e:	c8 40       	R0 *= R1;
8d4fd050:	02 50       	R0 = R2 + R0;
8d4fd052:	08 32       	P1 = R0;
8d4fd054:	88 e5 10 00 	R0 = B[P1 + 0x10] (X);
8d4fd058:	00 0c       	CC = R0 == 0x0;
8d4fd05a:	f1 1b       	IF CC JUMP 0x0x8d4fd03c;
8d4fd05c:	01 e8 00 00 	UNLINK;
8d4fd060:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4fd062:	10 00       	RTS;
8d4fd064:	80 0c       	CC = R0 < 0x0;
8d4fd066:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4fd06a:	04 18       	IF CC JUMP 0x0x8d4fd072;
8d4fd06c:	91 60       	R1 = 0x12 (X);		/*		R1=0x0(  0) */
8d4fd06e:	88 08       	CC = R0 < R1;
8d4fd070:	05 18       	IF CC JUMP 0x0x8d4fd07a;
8d4fd072:	01 e8 00 00 	UNLINK;
8d4fd076:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4fd078:	10 00       	RTS;
8d4fd07a:	81 61       	R1 = 0x30 (X);		/*		R1=0x0(  0) */
8d4fd07c:	02 da 6d 84 	R2=-2073169168;
8d4fd080:	f0 f2 00 00 
8d4fd084:	c8 40       	R0 *= R1;
8d4fd086:	02 50       	R0 = R2 + R0;
8d4fd088:	08 32       	P1 = R0;
8d4fd08a:	88 e5 10 00 	R0 = B[P1 + 0x10] (X);
8d4fd08e:	00 0c       	CC = R0 == 0x0;
8d4fd090:	f1 1b       	IF CC JUMP 0x0x8d4fd072;
8d4fd092:	01 e8 00 00 	UNLINK;
8d4fd096:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4fd098:	10 00       	RTS;
8d4fd09a:	00 00       	NOP;
8d4fd09c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4fd0a0:	01 e8 00 00 	UNLINK;
8d4fd0a4:	81 61       	R1 = 0x30 (X);		/*		R1=0x0(  0) */
8d4fd0a6:	02 da 6d 84 	R2=-2073168304;
8d4fd0aa:	50 f6 00 00 
8d4fd0ae:	c8 40       	R0 *= R1;
8d4fd0b0:	02 50       	R0 = R2 + R0;
8d4fd0b2:	80 64       	R0 += 0x10;		/* ( 16) */
8d4fd0b4:	10 00       	RTS;
8d4fd0b6:	80 0c       	CC = R0 < 0x0;
8d4fd0b8:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4fd0bc:	04 18       	IF CC JUMP 0x0x8d4fd0c4;
8d4fd0be:	09 61       	R1 = 0x21 (X);		/*		R1=0x0(  0) */
8d4fd0c0:	88 08       	CC = R0 < R1;
8d4fd0c2:	05 18       	IF CC JUMP 0x0x8d4fd0cc;
8d4fd0c4:	01 e8 00 00 	UNLINK;
8d4fd0c8:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4fd0ca:	10 00       	RTS;
8d4fd0cc:	81 61       	R1 = 0x30 (X);		/*		R1=0x0(  0) */
8d4fd0ce:	02 da 6d 84 	R2=-2073168304;
8d4fd0d2:	50 f6 00 00 
8d4fd0d6:	c8 40       	R0 *= R1;
8d4fd0d8:	02 50       	R0 = R2 + R0;
8d4fd0da:	08 32       	P1 = R0;
8d4fd0dc:	88 e5 10 00 	R0 = B[P1 + 0x10] (X);
8d4fd0e0:	00 0c       	CC = R0 == 0x0;
8d4fd0e2:	f1 1b       	IF CC JUMP 0x0x8d4fd0c4;
8d4fd0e4:	01 e8 00 00 	UNLINK;
8d4fd0e8:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4fd0ea:	10 00       	RTS;
