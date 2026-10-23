
os.ldr@0x8d4dae0c:     file format binary


Disassembly of section .data:

8d4dae0c <.data>:
8d4dae0c:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4dae10:	60 05       	[--SP] = (R7:4);
8d4dae12:	38 30       	R7 = R0;
8d4dae14:	66 6f       	SP += -0x14;		/* (-20) */
8d4dae16:	00 da 29 84 	R0=-2077632172;
8d4dae1a:	54 d9 00 00 
8d4dae1e:	29 30       	R5 = R1;
8d4dae20:	32 30       	R6 = R2;
8d4dae22:	06 e3 04 6c 	CALL 0x0x8d5a862a;
8d4dae26:	07 30       	R0 = R7;
8d4dae28:	ff e3 a6 f4 	CALL 0x0x8d4d9774;
8d4dae2c:	0d 30       	R1 = R5;
8d4dae2e:	20 30       	R4 = R0;
8d4dae30:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4dae34:	c0 27 00 00 
8d4dae38:	38 30       	R7 = R0;
8d4dae3a:	07 0c       	CC = R7 == 0x0;
8d4dae3c:	72 18       	IF CC JUMP 0x0x8d4daf20;
8d4dae3e:	0d 30       	R1 = R5;
8d4dae40:	04 30       	R0 = R4;
8d4dae42:	00 de 05 8c 	CALL.A 0x8c053314;
8d4dae46:	14 33 00 00 
8d4dae4a:	28 30       	R5 = R0;
8d4dae4c:	00 de 05 8c 	CALL.A 0x8c050fe0;
8d4dae50:	e0 0f 00 00 
8d4dae54:	00 0c       	CC = R0 == 0x0;
8d4dae56:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4dae58:	56 18       	IF CC JUMP 0x0x8d4daf04;
8d4dae5a:	7f 30       	R7 = FP;
8d4dae5c:	47 64       	R7 += 0x8;		/* (  8) */
8d4dae5e:	0d 30       	R1 = R5;
8d4dae60:	07 30       	R0 = R7;
8d4dae62:	00 de 05 8c 	CALL.A 0x8c052e56;
8d4dae66:	56 2e 00 00 
8d4dae6a:	67 30       	R4 = FP;
8d4dae6c:	84 67       	R4 += -0x10;		/* (-16) */
8d4dae6e:	0d 30       	R1 = R5;
8d4dae70:	04 30       	R0 = R4;
8d4dae72:	00 de 05 8c 	CALL.A 0x8c052e96;
8d4dae76:	96 2e 00 00 
8d4dae7a:	0c 30       	R1 = R4;
8d4dae7c:	07 30       	R0 = R7;
8d4dae7e:	00 de 05 8c 	CALL.A 0x8c052df6;
8d4dae82:	f6 2d 00 00 
8d4dae86:	00 0c       	CC = R0 == 0x0;
8d4dae88:	4a 10       	IF !CC JUMP 0x0x8d4daf1c;
8d4dae8a:	07 30       	R0 = R7;
8d4dae8c:	00 de 05 8c 	CALL.A 0x8c052d6a;
8d4dae90:	6a 2d 00 00 
8d4dae94:	01 da 03 84 	R1=-2080153768;
8d4dae98:	58 5f 00 00 
8d4dae9c:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4daea0:	c0 27 00 00 
8d4daea4:	00 0c       	CC = R0 == 0x0;
8d4daea6:	0e 10       	IF !CC JUMP 0x0x8d4daec2;
8d4daea8:	47 30       	R0 = FP;
8d4daeaa:	c0 67       	R0 += -0x8;		/* ( -8) */
8d4daeac:	0f 30       	R1 = R7;
8d4daeae:	00 de 05 8c 	CALL.A 0x8c052e34;
8d4daeb2:	34 2e 00 00 
8d4daeb6:	07 30       	R0 = R7;
8d4daeb8:	00 de 05 8c 	CALL.A 0x8c052d7c;
8d4daebc:	7c 2d 00 00 
8d4daec0:	d5 2f       	JUMP.S 0x0x8d4dae6a;
8d4daec2:	07 30       	R0 = R7;
8d4daec4:	00 de 05 8c 	CALL.A 0x8c052d6a;
8d4daec8:	6a 2d 00 00 
8d4daecc:	01 da 03 84 	R1=-2080153768;
8d4daed0:	58 5f 00 00 
8d4daed4:	00 de 05 8c 	CALL.A 0x8c053314;
8d4daed8:	14 33 00 00 
8d4daedc:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4daee0:	88 1d 00 00 
8d4daee4:	06 08       	CC = R6 == R0;
8d4daee6:	e1 17       	IF !CC JUMP 0x0x8d4daea8 (BP);
8d4daee8:	07 30       	R0 = R7;
8d4daeea:	00 de 05 8c 	CALL.A 0x8c052d6a;
8d4daeee:	6a 2d 00 00 
8d4daef2:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || R0 = [FP + 0x14] || NOP;
8d4daef6:	78 a1 00 00 
8d4daefa:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4daefe:	10 1b 00 00 
8d4daf02:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8d4daf04:	00 da 29 84 	R0=-2077632172;
8d4daf08:	54 d9 00 00 
8d4daf0c:	06 e3 9b 6b 	CALL 0x0x8d5a8642;
8d4daf10:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4daf12:	07 30       	R0 = R7;
8d4daf14:	20 05       	(R7:4) = [SP++];
8d4daf16:	01 e8 00 00 	UNLINK;
8d4daf1a:	10 00       	RTS;
8d4daf1c:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4daf1e:	f3 2f       	JUMP.S 0x0x8d4daf04;
8d4daf20:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4daf24:	fc 1e 00 00 
8d4daf28:	88 0c       	CC = R0 < 0x1;
8d4daf2a:	ed 1f       	IF CC JUMP 0x0x8d4daf04 (BP);
8d4daf2c:	35 b1       	[SP + 0x10] = R5;
8d4daf2e:	09 da 03 84 	P1=-2080153044;
8d4daf32:	2c 62 00 00 
8d4daf36:	f1 bc       	[SP + 0xc] = P1;
8d4daf38:	22 e1 92 01 	R2 = 0x192 (X);		/*		R2=0x192(402) */
8d4daf3c:	01 da 03 84 	R1=-2080153496;
8d4daf40:	68 60 00 00 
8d4daf44:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d4daf46:	00 de 04 8c 	CALL.A 0x8c040574;
8d4daf4a:	74 05 00 00 
8d4daf4e:	db 2f       	JUMP.S 0x0x8d4daf04;
8d4daf50:	00 00       	NOP;
8d4daf52:	00 00       	NOP;
8d4daf54:	00 e8 0d 00 	LINK 0x34;		/* (52) */
8d4daf58:	e5 05       	[--SP] = (R7:4, P5:5);
8d4daf5a:	66 6f       	SP += -0x14;		/* (-20) */
8d4daf5c:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0x28] = R2 || NOP;
8d4daf60:	b2 b2 00 00 
8d4daf64:	00 da 29 84 	R0=-2077632172;
8d4daf68:	54 d9 00 00 
8d4daf6c:	82 ce 01 ca 	R5 = ROT R1 BY 0x0 || P5 = [SP + 0x28] || NOP;
8d4daf70:	b5 ae 00 00 
8d4daf74:	31 30       	R6 = R1;
8d4daf76:	06 e3 5a 6b 	CALL 0x0x8d5a862a;
8d4daf7a:	07 30       	R0 = R7;
8d4daf7c:	ff e3 fc f3 	CALL 0x0x8d4d9774;
8d4daf80:	0d 30       	R1 = R5;
8d4daf82:	28 30       	R5 = R0;
8d4daf84:	00 de 05 8c 	CALL.A 0x8c0527c0;
8d4daf88:	c0 27 00 00 
