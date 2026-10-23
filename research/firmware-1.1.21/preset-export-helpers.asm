
os.ldr@0x8d4ddb86:     file format binary


Disassembly of section .data:

8d4ddb86 <.data>:
8d4ddb86:	08 32       	P1 = R0;
8d4ddb88:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4ddb8c:	08 91       	R0 = [P1];
8d4ddb8e:	01 e8 00 00 	UNLINK;
8d4ddb92:	80 4d       	R0 >>>= 0x10;
8d4ddb94:	10 00       	RTS;
8d4ddb96:	08 32       	P1 = R0;
8d4ddb98:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4ddb9c:	20 e1 49 00 	R0 = 0x49 (X);		/*		R0=0x49( 73) */
8d4ddba0:	09 91       	R1 = [P1];
8d4ddba2:	01 e8 00 00 	UNLINK;
8d4ddba6:	41 4d       	R1 >>>= 0x8;
8d4ddba8:	c8 40       	R0 *= R1;
8d4ddbaa:	b8 4d       	R0 >>>= 0x17;
8d4ddbac:	e0 66       	R0 += -0x24;		/* (-36) */
8d4ddbae:	10 00       	RTS;
8d4ddbb0:	08 32       	P1 = R0;
8d4ddbb2:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4ddbb6:	20 e1 81 00 	R0 = 0x81 (X);		/*		R0=0x81(129) */
8d4ddbba:	09 91       	R1 = [P1];
8d4ddbbc:	01 e8 00 00 	UNLINK;
8d4ddbc0:	41 4d       	R1 >>>= 0x8;
8d4ddbc2:	c8 40       	R0 *= R1;
8d4ddbc4:	b8 4d       	R0 >>>= 0x17;
8d4ddbc6:	f8 67       	R0 += -0x1;		/* ( -1) */
8d4ddbc8:	10 00       	RTS;
8d4ddbca:	00 00       	NOP;
8d4ddbcc:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4ddbd0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d4ddbd4:	f7 b0 00 00 
8d4ddbd8:	00 de 05 8c 	CALL.A 0x8c05101a;
8d4ddbdc:	1a 10 00 00 
8d4ddbe0:	00 0c       	CC = R0 == 0x0;
8d4ddbe2:	0d 10       	IF !CC JUMP 0x0x8d4ddbfc;
8d4ddbe4:	07 30       	R0 = R7;
8d4ddbe6:	00 de 05 8c 	CALL.A 0x8c051042;
8d4ddbea:	42 10 00 00 
8d4ddbee:	00 0c       	CC = R0 == 0x0;
8d4ddbf0:	00 60       	R0 = 0x0 (X);		/*		R0=0x81(129) */
8d4ddbf2:	05 10       	IF !CC JUMP 0x0x8d4ddbfc;
8d4ddbf4:	f7 a0       	R7 = [SP + 0xc];
8d4ddbf6:	01 e8 00 00 	UNLINK;
8d4ddbfa:	10 00       	RTS;
8d4ddbfc:	07 30       	R0 = R7;
8d4ddbfe:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4ddc02:	88 1d 00 00 
8d4ddc06:	38 0c       	CC = R0 == -0x1;
8d4ddc08:	04 cc 09 42 	R1 = R1 - R1 (NS) || R7 = [SP + 0xc] || NOP;
8d4ddc0c:	f7 a0 00 00 
8d4ddc10:	0d 18       	IF CC JUMP 0x0x8d4ddc2a;
8d4ddc12:	08 64       	R0 += 0x1;		/* (  1) */
8d4ddc14:	01 da fe 00 	R1=16647160;
8d4ddc18:	f8 03 00 00 
8d4ddc1c:	c8 40       	R0 *= R1;
8d4ddc1e:	01 da 7f 00 	R1=8323580;
8d4ddc22:	fc 01 00 00 
8d4ddc26:	04 c4 01 22 	R1 = R0 + R1 (S);
8d4ddc2a:	01 30       	R0 = R1;
8d4ddc2c:	01 e8 00 00 	UNLINK;
8d4ddc30:	10 00       	RTS;
8d4ddc32:	08 32       	P1 = R0;
8d4ddc34:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4ddc38:	20 e1 09 10 	R0 = 0x1009 (X);		/*		R0=0x1009(4105) */
8d4ddc3c:	09 91       	R1 = [P1];
8d4ddc3e:	01 e8 00 00 	UNLINK;
8d4ddc42:	41 4d       	R1 >>>= 0x8;
8d4ddc44:	0a c6 01 40 	R0 = EXTRACT (R1, R0.L) (X);
8d4ddc48:	10 00       	RTS;
8d4ddc4a:	00 00       	NOP;
8d4ddc4c:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d4ddc50:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d4ddc54:	f7 b0 00 00 
8d4ddc58:	00 de 05 8c 	CALL.A 0x8c05101a;
8d4ddc5c:	1a 10 00 00 
8d4ddc60:	00 0c       	CC = R0 == 0x0;
8d4ddc62:	0d 10       	IF !CC JUMP 0x0x8d4ddc7c;
8d4ddc64:	07 30       	R0 = R7;
8d4ddc66:	00 de 05 8c 	CALL.A 0x8c051042;
8d4ddc6a:	42 10 00 00 
8d4ddc6e:	00 0c       	CC = R0 == 0x0;
8d4ddc70:	00 60       	R0 = 0x0 (X);		/*		R0=0x1009(4105) */
8d4ddc72:	05 10       	IF !CC JUMP 0x0x8d4ddc7c;
8d4ddc74:	f7 a0       	R7 = [SP + 0xc];
8d4ddc76:	01 e8 00 00 	UNLINK;
8d4ddc7a:	10 00       	RTS;
8d4ddc7c:	07 30       	R0 = R7;
8d4ddc7e:	00 de 05 8c 	CALL.A 0x8c051d88;
8d4ddc82:	88 1d 00 00 
8d4ddc86:	f7 a0       	R7 = [SP + 0xc];
8d4ddc88:	01 e8 00 00 	UNLINK;
8d4ddc8c:	01 da ff 00 	R1=16777215;
8d4ddc90:	ff ff 00 00 
8d4ddc94:	c8 40       	R0 *= R1;
8d4ddc96:	01 da 7f 00 	R1=8388607;
8d4ddc9a:	ff ff 00 00 
8d4ddc9e:	04 c4 01 20 	R0 = R0 + R1 (S);
8d4ddca2:	10 00       	RTS;
