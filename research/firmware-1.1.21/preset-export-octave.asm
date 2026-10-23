
os.ldr@0x8d56fcf0:     file format binary


Disassembly of section .data:

8d56fcf0 <.data>:
8d56fcf0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d56fcf4:	00 d8 09 84 	LdStAbs addr=0x8409adec control=0x0001;
8d56fcf8:	ec ad 01 00 
8d56fcfc:	22 e1 40 00 	R2 = 0x40 (X);		/*		R2=0x40( 64) */
8d56fd00:	51 50       	R1 = R1 + R2;
8d56fd02:	01 50       	R0 = R1 + R0;
8d56fd04:	08 32       	P1 = R0;
8d56fd06:	48 99       	R0 = B[P1] (X);
8d56fd08:	01 e8 00 00 	UNLINK;
8d56fd0c:	10 00       	RTS;
8d56fd0e:	00 00       	NOP;
8d56fd10:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d56fd14:	00 d8 09 84 	LdStAbs addr=0x8409adec control=0x0001;
8d56fd18:	ec ad 01 00 
8d56fd1c:	71 64       	R1 += 0xe;		/* ( 14) */
8d56fd1e:	01 50       	R0 = R1 + R0;
8d56fd20:	08 32       	P1 = R0;
8d56fd22:	08 99       	R0 = B[P1] (Z);
8d56fd24:	01 e8 00 00 	UNLINK;
8d56fd28:	10 00       	RTS;
8d56fd2a:	00 00       	NOP;
8d56fd2c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d56fd30:	00 d8 09 84 	LdStAbs addr=0x8409adec control=0x0041;
8d56fd34:	ec ad 41 00 
8d56fd38:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d56fd3a:	81 40       	R1 <<= R0;
8d56fd3c:	0a 60       	R2 = 0x1 (X);		/*		R2=0x40( 64) */
8d56fd3e:	88 a5       	R0 = W[P1 + 0xc] (Z);
8d56fd40:	01 e8 00 00 	UNLINK;
8d56fd44:	08 54       	R0 = R0 & R1;
8d56fd46:	00 0c       	CC = R0 == 0x0;
8d56fd48:	02 06       	IF !CC R0 = R2;
8d56fd4a:	10 00       	RTS;
8d56fd4c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d56fd50:	00 d8 09 84 	LdStAbs addr=0x8409adec control=0x0001;
8d56fd54:	ec ad 01 00 
8d56fd58:	81 65       	R1 += 0x30;		/* ( 48) */
8d56fd5a:	01 50       	R0 = R1 + R0;
8d56fd5c:	08 32       	P1 = R0;
8d56fd5e:	08 99       	R0 = B[P1] (Z);
8d56fd60:	01 e8 00 00 	UNLINK;
8d56fd64:	10 00       	RTS;
8d56fd66:	00 00       	NOP;
8d56fd68:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d56fd6c:	00 d8 09 84 	LdStAbs addr=0x8409adec control=0x0001;
8d56fd70:	ec ad 01 00 
8d56fd74:	01 65       	R1 += 0x20;		/* ( 32) */
8d56fd76:	01 50       	R0 = R1 + R0;
8d56fd78:	08 32       	P1 = R0;
8d56fd7a:	08 99       	R0 = B[P1] (Z);
8d56fd7c:	01 e8 00 00 	UNLINK;
8d56fd80:	10 00       	RTS;
8d56fd82:	00 00       	NOP;
8d56fd84:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d56fd88:	00 d8 09 84 	LdStAbs addr=0x8409adec control=0x0041;
8d56fd8c:	ec ad 41 00 
8d56fd90:	88 e4 03 00 	R0 = B[P1 + 0x3] (Z);
8d56fd94:	01 e8 00 00 	UNLINK;
8d56fd98:	10 00       	RTS;
8d56fd9a:	00 00       	NOP;
8d56fd9c:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d56fda0:	00 d8 09 84 	LdStAbs addr=0x8409adec control=0x0041;
8d56fda4:	ec ad 41 00 
8d56fda8:	88 e5 02 00 	R0 = B[P1 + 0x2] (X);
8d56fdac:	01 e8 00 00 	UNLINK;
