
os.ldr@0x8d4fe8d0:     file format binary


Disassembly of section .data:

8d4fe8d0 <.data>:
8d4fe8d0:	09 10       	IF !CC JUMP 0x0x8d4fe8e2;
8d4fe8d2:	f7 a0       	R7 = [SP + 0xc];
8d4fe8d4:	01 e8 00 00 	UNLINK;
8d4fe8d8:	00 da 04 84 	R0=-2080097240;
8d4fe8dc:	28 3c 00 00 
8d4fe8e0:	10 00       	RTS;
8d4fe8e2:	80 61       	R0 = 0x30 (X);		/*		R0=0x0(  0) */
8d4fe8e4:	01 da 6d 84 	R1=-2073169168;
8d4fe8e8:	f0 f2 00 00 
8d4fe8ec:	f8 40       	R0 *= R7;
8d4fe8ee:	01 50       	R0 = R1 + R0;
8d4fe8f0:	08 32       	P1 = R0;
8d4fe8f2:	03 30       	R0 = R3;
8d4fe8f4:	49 ac       	P1 = [P1 + 0x4];
8d4fe8f6:	61 00       	CALL (P1);
8d4fe8f8:	f7 a0       	R7 = [SP + 0xc];
8d4fe8fa:	01 e8 00 00 	UNLINK;
8d4fe8fe:	10 00       	RTS;
8d4fe900:	00 00       	NOP;
8d4fe902:	00 00       	NOP;
8d4fe904:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4fe908:	f3 05       	[--SP] = (R7:6, P5:3);
8d4fe90a:	66 6f       	SP += -0x14;		/* (-20) */
8d4fe90c:	0b da 6d 84 	P3=-2073169180;
8d4fe910:	e4 f2 00 00 
8d4fe914:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P5 = [P3 + 0x4] || NOP;
8d4fe918:	5d ac 00 00 
8d4fe91c:	06 da 6d 84 	R6=-2073169180;
8d4fe920:	e4 f2 00 00 
8d4fe924:	6c ac       	P4 = [P5 + 0x4];
8d4fe926:	a0 e5 2d 00 	R0 = B[P4 + 0x2d] (X);
8d4fe92a:	00 0c       	CC = R0 == 0x0;
8d4fe92c:	13 10       	IF !CC JUMP 0x0x8d4fe952;
8d4fe92e:	4c 30       	R1 = P4;
8d4fe930:	17 30       	R2 = R7;
8d4fe932:	06 30       	R0 = R6;
8d4fe934:	61 64       	R1 += 0xc;		/* ( 12) */
8d4fe936:	fe e3 51 ea 	CALL 0x0x8d4dbdd8;
8d4fe93a:	4c 32       	P1 = P4;
8d4fe93c:	00 0c       	CC = R0 == 0x0;
8d4fe93e:	44 6c       	P4 += 0x8;		/* (  8) */
8d4fe940:	41 32       	P0 = P1;
8d4fe942:	c4 06       	IF !CC P0 = P4;
8d4fe944:	cd 06       	IF !CC P1 = P5;
8d4fe946:	44 91       	P4 = [P0];
8d4fe948:	69 32       	P5 = P1;
8d4fe94a:	a0 e5 2d 00 	R0 = B[P4 + 0x2d] (X);
8d4fe94e:	00 0c       	CC = R0 == 0x0;
8d4fe950:	ef 1f       	IF CC JUMP 0x0x8d4fe92e (BP);
8d4fe952:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [P3 + 0x4] || NOP;
8d4fe956:	58 a0 00 00 
8d4fe95a:	55 30       	R2 = P5;
8d4fe95c:	10 08       	CC = R0 == R2;
8d4fe95e:	07 18       	IF CC JUMP 0x0x8d4fe96c;
8d4fe960:	62 64       	R2 += 0xc;		/* ( 12) */
8d4fe962:	06 30       	R0 = R6;
8d4fe964:	fe e3 3a ea 	CALL 0x0x8d4dbdd8;
8d4fe968:	00 0c       	CC = R0 == 0x0;
8d4fe96a:	02 18       	IF CC JUMP 0x0x8d4fe96e;
8d4fe96c:	5d ac       	P5 = [P3 + 0x4];
8d4fe96e:	59 a0       	R1 = [P3 + 0x4];
8d4fe970:	45 30       	R0 = P5;
8d4fe972:	01 08       	CC = R1 == R0;
8d4fe974:	0a 18       	IF CC JUMP 0x0x8d4fe988;
8d4fe976:	a8 a2       	R0 = [P5 + 0x28];
8d4fe978:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4fe97a:	b3 05       	(R7:6, P5:3) = [SP++];
8d4fe97c:	01 e8 00 00 	UNLINK;
8d4fe980:	10 00       	RTS;
8d4fe982:	00 00       	NOP;
8d4fe984:	00 00       	NOP;
8d4fe986:	00 00       	NOP;
8d4fe988:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4fe98c:	fc 1e 00 00 
8d4fe990:	98 0c       	CC = R0 < 0x3;
8d4fe992:	07 10       	IF !CC JUMP 0x0x8d4fe9a0;
8d4fe994:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4fe996:	b3 05       	(R7:6, P5:3) = [SP++];
8d4fe998:	01 e8 00 00 	UNLINK;
8d4fe99c:	08 61       	R0 = 0x21 (X);		/*		R0=0x0(  0) */
8d4fe99e:	10 00       	RTS;
8d4fe9a0:	0f 32       	P1 = R7;
8d4fe9a2:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8d4fe9a4:	27 64       	R7 += 0x4;		/* (  4) */
8d4fe9a6:	22 e1 14 01 	R2 = 0x114 (X);		/*		R2=0x114(276) */
8d4fe9aa:	89 a1       	R1 = [P1 + 0x18];
8d4fe9ac:	0f 32       	P1 = R7;
8d4fe9ae:	08 0a       	CC = R0 <= R1 (IU);
8d4fe9b0:	02 10       	IF !CC JUMP 0x0x8d4fe9b4;
8d4fe9b2:	0f 91       	R7 = [P1];
8d4fe9b4:	09 da 04 84 	P1=-2080096564;
8d4fe9b8:	cc 3e 00 00 
8d4fe9bc:	37 b1       	[SP + 0x10] = R7;
8d4fe9be:	f1 bc       	[SP + 0xc] = P1;
8d4fe9c0:	01 da 04 84 	R1=-2080096596;
8d4fe9c4:	ac 3e 00 00 
8d4fe9c8:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d4fe9ca:	00 de 04 8c 	CALL.A 0x8c040574;
8d4fe9ce:	74 05 00 00 
8d4fe9d2:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4fe9d4:	b3 05       	(R7:6, P5:3) = [SP++];
8d4fe9d6:	01 e8 00 00 	UNLINK;
8d4fe9da:	08 61       	R0 = 0x21 (X);		/*		R0=0x0(  0) */
8d4fe9dc:	10 00       	RTS;
8d4fe9de:	00 00       	NOP;
8d4fe9e0:	00 00       	NOP;
8d4fe9e2:	00 00       	NOP;
8d4fe9e4:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4fe9e8:	f3 05       	[--SP] = (R7:6, P5:3);
8d4fe9ea:	66 6f       	SP += -0x14;		/* (-20) */
8d4fe9ec:	0b da 6d 84 	P3=-2073169204;
8d4fe9f0:	cc f2 00 00 
8d4fe9f4:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || P5 = [P3 + 0x4] || NOP;
8d4fe9f8:	5d ac 00 00 
8d4fe9fc:	06 da 6d 84 	R6=-2073169204;
8d4fea00:	cc f2 00 00 
8d4fea04:	6c ac       	P4 = [P5 + 0x4];
8d4fea06:	a0 e5 2d 00 	R0 = B[P4 + 0x2d] (X);
8d4fea0a:	00 0c       	CC = R0 == 0x0;
8d4fea0c:	13 10       	IF !CC JUMP 0x0x8d4fea32;
8d4fea0e:	4c 30       	R1 = P4;
8d4fea10:	17 30       	R2 = R7;
8d4fea12:	06 30       	R0 = R6;
8d4fea14:	61 64       	R1 += 0xc;		/* ( 12) */
8d4fea16:	fe e3 e1 e9 	CALL 0x0x8d4dbdd8;
8d4fea1a:	4c 32       	P1 = P4;
8d4fea1c:	00 0c       	CC = R0 == 0x0;
8d4fea1e:	44 6c       	P4 += 0x8;		/* (  8) */
8d4fea20:	41 32       	P0 = P1;
8d4fea22:	c4 06       	IF !CC P0 = P4;
8d4fea24:	cd 06       	IF !CC P1 = P5;
8d4fea26:	44 91       	P4 = [P0];
8d4fea28:	69 32       	P5 = P1;
8d4fea2a:	a0 e5 2d 00 	R0 = B[P4 + 0x2d] (X);
8d4fea2e:	00 0c       	CC = R0 == 0x0;
8d4fea30:	ef 1f       	IF CC JUMP 0x0x8d4fea0e (BP);
8d4fea32:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || R0 = [P3 + 0x4] || NOP;
8d4fea36:	58 a0 00 00 
8d4fea3a:	55 30       	R2 = P5;
8d4fea3c:	10 08       	CC = R0 == R2;
8d4fea3e:	07 18       	IF CC JUMP 0x0x8d4fea4c;
8d4fea40:	62 64       	R2 += 0xc;		/* ( 12) */
8d4fea42:	06 30       	R0 = R6;
8d4fea44:	fe e3 ca e9 	CALL 0x0x8d4dbdd8;
8d4fea48:	00 0c       	CC = R0 == 0x0;
8d4fea4a:	02 18       	IF CC JUMP 0x0x8d4fea4e;
8d4fea4c:	5d ac       	P5 = [P3 + 0x4];
8d4fea4e:	59 a0       	R1 = [P3 + 0x4];
8d4fea50:	45 30       	R0 = P5;
8d4fea52:	01 08       	CC = R1 == R0;
8d4fea54:	0a 18       	IF CC JUMP 0x0x8d4fea68;
8d4fea56:	a8 a2       	R0 = [P5 + 0x28];
8d4fea58:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4fea5a:	b3 05       	(R7:6, P5:3) = [SP++];
8d4fea5c:	01 e8 00 00 	UNLINK;
8d4fea60:	10 00       	RTS;
8d4fea62:	00 00       	NOP;
8d4fea64:	00 00       	NOP;
8d4fea66:	00 00       	NOP;
8d4fea68:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4fea6c:	fc 1e 00 00 
8d4fea70:	98 0c       	CC = R0 < 0x3;
8d4fea72:	07 10       	IF !CC JUMP 0x0x8d4fea80;
8d4fea74:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4fea76:	b3 05       	(R7:6, P5:3) = [SP++];
8d4fea78:	01 e8 00 00 	UNLINK;
8d4fea7c:	90 60       	R0 = 0x12 (X);		/*		R0=0x0(  0) */
8d4fea7e:	10 00       	RTS;
8d4fea80:	0f 32       	P1 = R7;
8d4fea82:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8d4fea84:	27 64       	R7 += 0x4;		/* (  4) */
8d4fea86:	22 e1 1d 01 	R2 = 0x11d (X);		/*		R2=0x11d(285) */
8d4fea8a:	89 a1       	R1 = [P1 + 0x18];
8d4fea8c:	0f 32       	P1 = R7;
8d4fea8e:	08 0a       	CC = R0 <= R1 (IU);
8d4fea90:	02 10       	IF !CC JUMP 0x0x8d4fea94;
8d4fea92:	0f 91       	R7 = [P1];
8d4fea94:	09 da 04 84 	P1=-2080096532;
8d4fea98:	ec 3e 00 00 
8d4fea9c:	37 b1       	[SP + 0x10] = R7;
8d4fea9e:	f1 bc       	[SP + 0xc] = P1;
8d4feaa0:	01 da 04 84 	R1=-2080096596;
8d4feaa4:	ac 3e 00 00 
8d4feaa8:	18 60       	R0 = 0x3 (X);		/*		R0=0x0(  0) */
8d4feaaa:	00 de 04 8c 	CALL.A 0x8c040574;
8d4feaae:	74 05 00 00 
8d4feab2:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4feab4:	b3 05       	(R7:6, P5:3) = [SP++];
8d4feab6:	01 e8 00 00 	UNLINK;
8d4feaba:	90 60       	R0 = 0x12 (X);		/*		R0=0x0(  0) */
8d4feabc:	10 00       	RTS;
8d4feabe:	00 00       	NOP;
8d4feac0:	00 00       	NOP;
8d4feac2:	83 61       	R3 = 0x30 (X);		/*		R3=0x0(  0) */
8d4feac4:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d4feac8:	c3 40       	R3 *= R0;
8d4feaca:	0b 32       	P1 = R3;
8d4feacc:	fd 05       	[--SP] = (R7:7, P5:5);
8d4feace:	08 da 6d 84 	P0=-2073168304;
8d4fead2:	50 f6 00 00 
8d4fead6:	66 6f       	SP += -0x14;		/* (-20) */
8d4fead8:	82 ce 01 c6 	R3 = ROT R1 BY 0x0 || R1 = [SP + 0x30] || NOP;
8d4feadc:	31 a3 00 00 
8d4feae0:	48 5a       	P1 = P0 + P1;
8d4feae2:	2b 32       	P5 = R3;
8d4feae4:	0f 91       	R7 = [P1];
8d4feae6:	0f 32       	P1 = R7;
8d4feae8:	07 0c       	CC = R7 == 0x0;
8d4feaea:	0b 18       	IF CC JUMP 0x0x8d4feb00;
8d4feaec:	02 30       	R0 = R2;
8d4feaee:	61 00       	CALL (P1);
8d4feaf0:	0f 60       	R7 = 0x1 (X);		/*		R7=0x0(  0) */
8d4feaf2:	28 93       	[P5] = R0;
8d4feaf4:	a6 6c       	SP += 0x14;		/* ( 20) */
8d4feaf6:	07 30       	R0 = R7;
8d4feaf8:	bd 05       	(R7:7, P5:5) = [SP++];
8d4feafa:	01 e8 00 00 	UNLINK;
8d4feafe:	10 00       	RTS;
8d4feb00:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0001;
8d4feb04:	fc 1e 01 00 
8d4feb08:	99 0c       	CC = R1 < 0x3;
8d4feb0a:	f5 1f       	IF CC JUMP 0x0x8d4feaf4 (BP);
8d4feb0c:	09 da 04 84 	P1=-2080096504;
8d4feb10:	08 3f 00 00 
8d4feb14:	30 b1       	[SP + 0x10] = R0;
8d4feb16:	f1 bc       	[SP + 0xc] = P1;
8d4feb18:	22 e1 2f 01 	R2 = 0x12f (X);		/*		R2=0x12f(303) */
8d4feb1c:	Address 0x8d4feb20 is out of bounds.

