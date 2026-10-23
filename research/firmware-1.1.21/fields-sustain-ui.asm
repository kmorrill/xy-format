
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d549ad0 <.data+0x7dab0>:
8d549ad0:	be 2e       	JUMP.S 0x0x8d54984c;
8d549ad2:	e4 6f       	P4 += -0x4;		/* ( -4) */
8d549ad4:	a5 2e       	JUMP.S 0x0x8d54981e;
8d549ad6:	00 00       	NOP;
8d549ad8:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d549adc:	e4 05       	[--SP] = (R7:4, P5:4);
8d549ade:	46 6f       	SP += -0x18;		/* (-24) */
8d549ae0:	29 e1 00 20 	P1 = 0x2000 (X);		/*		P1=0x2000(8192) */
8d549ae4:	77 30       	R6 = FP;
8d549ae6:	82 ce 01 c8 	R4 = ROT R1 BY 0x0 || [SP + 0x10] = P1 || NOP;
8d549aea:	31 bd 00 00 
8d549aee:	46 64       	R6 += 0x8;		/* (  8) */
8d549af0:	00 d8 ea 84 	LdStAbs addr=0x84eae6f4 control=0x0005;
8d549af4:	f4 e6 05 00 
8d549af8:	22 e1 04 4d 	R2 = 0x4d04 (X);		/*		R2=0x4d04(19716) */
8d549afc:	29 e1 00 e0 	P1 = -0x2000 (X);		/*		P1=0xffffe000(-8192) */
8d549b00:	04 cc 0a 04 	R2 = R1 + R2 (NS) || [SP + 0xc] = P1 || NOP;
8d549b04:	f1 bc 00 00 
8d549b08:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0x14] = R6 || NOP;
8d549b0c:	76 b1 00 00 
8d549b10:	b5 b3       	[SP + 0x38] = R5;
8d549b12:	ff e3 c2 fc 	CALL 0x0x8d549496;
8d549b16:	04 68       	P4 = 0x0 (X);		/*		P4=0x0(  0) */
8d549b18:	2d e1 ff 00 	P5 = 0xff (X);		/*		P5=0xff(255) */
8d549b1c:	22 e1 08 4f 	R2 = 0x4f08 (X);		/*		R2=0x4f08(20232) */
8d549b20:	04 cc 22 04 	R2 = R4 + R2 (NS) || [SP + 0x14] = R6 || NOP;
8d549b24:	76 b1 00 00 
8d549b28:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0x38] = R5 || NOP;
8d549b2c:	b5 b3 00 00 
8d549b30:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0xc] = P4 || NOP;
8d549b34:	f4 bc 00 00 
8d549b38:	35 bd       	[SP + 0x10] = P5;
8d549b3a:	ff e3 ae fc 	CALL 0x0x8d549496;
8d549b3e:	22 e1 10 53 	R2 = 0x5310 (X);		/*		R2=0x5310(21264) */
8d549b42:	04 cc 22 04 	R2 = R4 + R2 (NS) || [SP + 0x14] = R6 || NOP;
8d549b46:	76 b1 00 00 
8d549b4a:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0x38] = R5 || NOP;
8d549b4e:	b5 b3 00 00 
8d549b52:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0xc] = P4 || NOP;
8d549b56:	f4 bc 00 00 
8d549b5a:	35 bd       	[SP + 0x10] = P5;
8d549b5c:	ff e3 2d fe 	CALL 0x0x8d5497b6;
8d549b60:	22 e1 0c 51 	R2 = 0x510c (X);		/*		R2=0x510c(20748) */
8d549b64:	04 cc 22 04 	R2 = R4 + R2 (NS) || [SP + 0x14] = R6 || NOP;
8d549b68:	76 b1 00 00 
8d549b6c:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || [SP + 0x10] = P5 || NOP;
8d549b70:	35 bd 00 00 
8d549b74:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = P4 || NOP;
8d549b78:	f4 bc 00 00 
8d549b7c:	b5 b3       	[SP + 0x38] = R5;
8d549b7e:	ff e3 8c fc 	CALL 0x0x8d549496;
8d549b82:	c6 6c       	SP += 0x18;		/* ( 24) */
8d549b84:	a4 05       	(R7:4, P5:4) = [SP++];
8d549b86:	01 e8 00 00 	UNLINK;
