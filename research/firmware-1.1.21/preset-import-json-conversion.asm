
os.ldr@0x8c051c90:     file format binary


Disassembly of section .data:

8c051c90 <.data>:
8c051c90:	00 e8 04 00 	LINK 0x10;		/* (16) */
8c051c94:	f5 bc       	[SP + 0xc] = P5;
8c051c96:	28 32       	P5 = R0;
8c051c98:	20 60       	R0 = 0x4 (X);		/*		R0=0x0(  0) */
8c051c9a:	a9 e4 04 00 	R1 = B[P5 + 0x4] (Z);
8c051c9e:	01 08       	CC = R1 == R0;
8c051ca0:	08 10       	IF !CC JUMP 0x0x8c051cb0;
8c051ca2:	03 c8 00 18 	MNOP || P5 = [SP + 0xc] || R0 = [P5];
8c051ca6:	f5 ac 28 91 
8c051caa:	01 e8 00 00 	UNLINK;
8c051cae:	10 00       	RTS;
8c051cb0:	00 da 80 11 	R0=293610268;
8c051cb4:	1c 23 00 00 
8c051cb8:	ff e3 76 74 	CALL 0x0x8c0405a4;
8c051cbc:	03 c8 00 18 	MNOP || P5 = [SP + 0xc] || R0 = [P5];
8c051cc0:	f5 ac 28 91 
8c051cc4:	01 e8 00 00 	UNLINK;
8c051cc8:	10 00       	RTS;
8c051cca:	01 32       	P0 = R1;
8c051ccc:	00 e8 05 00 	LINK 0x14;		/* (20) */
8c051cd0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0x10] = R7 || NOP;
8c051cd4:	37 b1 00 00 
8c051cd8:	43 60       	R3 = 0x8 (X);		/*		R3=0x0(  0) */
8c051cda:	01 da 80 11 	R1=293609836;
8c051cde:	6c 21 00 00 
8c051ce2:	82 e4 04 00 	R2 = B[P0 + 0x4] (Z);
8c051ce6:	9a 09       	CC = R2 < R3 (IU);
8c051ce8:	0a 32       	P1 = R2;
8c051cea:	15 10       	IF !CC JUMP 0x0x8c051d14;
8c051cec:	0a da 80 11 	P2=293610504;
8c051cf0:	08 24 00 00 
8c051cf4:	4a 5e       	P1 = P2 + (P1 << 0x2);
8c051cf6:	49 91       	P1 = [P1];
8c051cf8:	51 00       	JUMP (P1);
8c051cfa:	00 00       	NOP;
8c051cfc:	ff e3 82 68 	CALL 0x0x8c03ee00;
8c051d00:	37 a1       	R7 = [SP + 0x10];
8c051d02:	01 e8 00 00 	UNLINK;
8c051d06:	10 00       	RTS;
8c051d08:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c051d0c:	fc 1e 00 00 
8c051d10:	88 0c       	CC = R0 < 0x1;
8c051d12:	13 10       	IF !CC JUMP 0x0x8c051d38;
8c051d14:	00 da 80 11 	R0=293610440;
8c051d18:	c8 23 00 00 
8c051d1c:	ff e3 44 74 	CALL 0x0x8c0405a4;
8c051d20:	07 30       	R0 = R7;
8c051d22:	01 da 80 11 	R1=293609836;
8c051d26:	6c 21 00 00 
8c051d2a:	ff e3 6b 68 	CALL 0x0x8c03ee00;
8c051d2e:	37 a1       	R7 = [SP + 0x10];
8c051d30:	01 e8 00 00 	UNLINK;
8c051d34:	10 00       	RTS;
8c051d36:	00 00       	NOP;
8c051d38:	09 da 80 11 	P1=293610404;
8c051d3c:	a4 23 00 00 
8c051d40:	f1 bc       	[SP + 0xc] = P1;
8c051d42:	22 e1 c3 02 	R2 = 0x2c3 (X);		/*		R2=0x2c3(707) */
8c051d46:	01 da 80 11 	R1=293610348;
8c051d4a:	6c 23 00 00 
8c051d4e:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c051d50:	ff e3 12 74 	CALL 0x0x8c040574;
8c051d54:	e0 2f       	JUMP.S 0x0x8c051d14;
8c051d56:	02 91       	R2 = [P0];
8c051d58:	02 0c       	CC = R2 == 0x0;
8c051d5a:	0a 06       	IF !CC R1 = R2;
8c051d5c:	ff e3 52 68 	CALL 0x0x8c03ee00;
8c051d60:	37 a1       	R7 = [SP + 0x10];
8c051d62:	01 e8 00 00 	UNLINK;
8c051d66:	10 00       	RTS;
8c051d68:	02 99       	R2 = B[P0] (Z);
8c051d6a:	02 0c       	CC = R2 == 0x0;
8c051d6c:	02 da 80 11 	R2=293609836;
8c051d70:	6c 21 00 00 
8c051d74:	61 64       	R1 += 0xc;		/* ( 12) */
8c051d76:	22 64       	R2 += 0x4;		/* (  4) */
8c051d78:	0a 06       	IF !CC R1 = R2;
8c051d7a:	ff e3 43 68 	CALL 0x0x8c03ee00;
8c051d7e:	37 a1       	R7 = [SP + 0x10];
8c051d80:	01 e8 00 00 	UNLINK;
8c051d84:	10 00       	RTS;
8c051d86:	00 00       	NOP;
8c051d88:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c051d8c:	f5 05       	[--SP] = (R7:6, P5:5);
8c051d8e:	28 32       	P5 = R0;
8c051d90:	86 6f       	SP += -0x10;		/* (-16) */
8c051d92:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8c051d94:	08 da 80 11 	P0=293610704;
8c051d98:	d0 24 00 00 
8c051d9c:	02 da ff 7f 	R2=2147483647;
8c051da0:	ff ff 00 00 
8c051da4:	a8 e4 04 00 	R0 = B[P5 + 0x4] (Z);
8c051da8:	88 09       	CC = R0 < R1 (IU);
8c051daa:	08 32       	P1 = R0;
8c051dac:	78 10       	IF !CC JUMP 0x0x8c051e9c;
8c051dae:	01 da 80 11 	R1=293610348;
8c051db2:	6c 23 00 00 
8c051db6:	48 5e       	P1 = P0 + (P1 << 0x2);
8c051db8:	49 91       	P1 = [P1];
8c051dba:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c051dbe:	fc 1e 00 00 
8c051dc2:	51 00       	JUMP (P1);
8c051dc4:	86 6c       	SP += 0x10;		/* ( 16) */
8c051dc6:	b5 05       	(R7:6, P5:5) = [SP++];
8c051dc8:	01 e8 00 00 	UNLINK;
8c051dcc:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c051dce:	10 00       	RTS;
8c051dd0:	28 91       	R0 = [P5];
8c051dd2:	86 6c       	SP += 0x10;		/* ( 16) */
8c051dd4:	b5 05       	(R7:6, P5:5) = [SP++];
8c051dd6:	01 e8 00 00 	UNLINK;
8c051dda:	10 00       	RTS;
8c051ddc:	28 91       	R0 = [P5];
8c051dde:	90 09       	CC = R0 < R2 (IU);
8c051de0:	07 18       	IF CC JUMP 0x0x8c051dee;
8c051de2:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0002;
8c051de6:	fc 1e 02 00 
8c051dea:	8a 0c       	CC = R2 < 0x1;
8c051dec:	06 10       	IF !CC JUMP 0x0x8c051df8;
8c051dee:	86 6c       	SP += 0x10;		/* ( 16) */
8c051df0:	b5 05       	(R7:6, P5:5) = [SP++];
8c051df2:	01 e8 00 00 	UNLINK;
8c051df6:	10 00       	RTS;
8c051df8:	09 da 80 11 	P1=293610536;
8c051dfc:	28 24 00 00 
8c051e00:	f1 bc       	[SP + 0xc] = P1;
8c051e02:	22 e1 dc 02 	R2 = 0x2dc (X);		/*		R2=0x2dc(732) */
8c051e06:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c051e08:	ff e3 b6 73 	CALL 0x0x8c040574;
8c051e0c:	28 91       	R0 = [P5];
8c051e0e:	86 6c       	SP += 0x10;		/* ( 16) */
8c051e10:	b5 05       	(R7:6, P5:5) = [SP++];
8c051e12:	01 e8 00 00 	UNLINK;
8c051e16:	10 00       	RTS;
8c051e18:	28 91       	R0 = [P5];
8c051e1a:	82 c6 08 c4 	R2 = ROT R0 BY 0x1;
8c051e1e:	82 c6 fa 87 	R3 = R2 >> 0x1;
8c051e22:	9f 43       	R7 = -R3;
8c051e24:	13 30       	R2 = R3;
8c051e26:	1f 07       	IF CC R3 = R7;
8c051e28:	07 da 00 b1 	R7=-1325400064;
8c051e2c:	00 00 00 00 
8c051e30:	1f 09       	CC = R7 <= R3;
8c051e32:	07 da 80 7f 	R7=2139095041;
8c051e36:	01 00 00 00 
8c051e3a:	ba 52       	R2 = R2 - R7;
8c051e3c:	41 03       	CC &= AN;
8c051e3e:	10 10       	IF !CC JUMP 0x0x8c051e5e;
8c051e40:	82 c6 08 c4 	R2 = ROT R0 BY 0x1;
8c051e44:	82 c6 fa 87 	R3 = R2 >> 0x1;
8c051e48:	9e 43       	R6 = -R3;
8c051e4a:	13 30       	R2 = R3;
8c051e4c:	16 07       	IF CC R2 = R6;
8c051e4e:	06 da 00 4f 	R6=1325400064;
8c051e52:	00 00 00 00 
8c051e56:	32 09       	CC = R2 <= R6;
8c051e58:	bb 52       	R2 = R3 - R7;
8c051e5a:	41 03       	CC &= AN;
8c051e5c:	07 18       	IF CC JUMP 0x0x8c051e6a;
8c051e5e:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0002;
8c051e62:	fc 1e 02 00 
8c051e66:	8a 0c       	CC = R2 < 0x1;
8c051e68:	0c 10       	IF !CC JUMP 0x0x8c051e80;
8c051e6a:	00 de 02 04 	CALL.A 0x04020fd8;
8c051e6e:	d8 0f 00 00 
8c051e72:	86 6c       	SP += 0x10;		/* ( 16) */
8c051e74:	b5 05       	(R7:6, P5:5) = [SP++];
8c051e76:	01 e8 00 00 	UNLINK;
8c051e7a:	10 00       	RTS;
8c051e7c:	00 00       	NOP;
8c051e7e:	00 00       	NOP;
8c051e80:	09 da 80 11 	P1=293610572;
8c051e84:	4c 24 00 00 
8c051e88:	f1 bc       	[SP + 0xc] = P1;
8c051e8a:	22 e1 df 02 	R2 = 0x2df (X);		/*		R2=0x2df(735) */
8c051e8e:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c051e90:	ff e3 72 73 	CALL 0x0x8c040574;
8c051e94:	28 91       	R0 = [P5];
8c051e96:	ea 2f       	JUMP.S 0x0x8c051e6a;
8c051e98:	88 0c       	CC = R0 < 0x1;
8c051e9a:	0f 10       	IF !CC JUMP 0x0x8c051eb8;
8c051e9c:	00 da 80 11 	R0=293610640;
8c051ea0:	90 24 00 00 
8c051ea4:	ff e3 80 73 	CALL 0x0x8c0405a4;
8c051ea8:	86 6c       	SP += 0x10;		/* ( 16) */
8c051eaa:	b5 05       	(R7:6, P5:5) = [SP++];
8c051eac:	01 e8 00 00 	UNLINK;
8c051eb0:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c051eb2:	10 00       	RTS;
8c051eb4:	00 00       	NOP;
8c051eb6:	00 00       	NOP;
8c051eb8:	09 da 80 11 	P1=293610608;
8c051ebc:	70 24 00 00 
8c051ec0:	f1 bc       	[SP + 0xc] = P1;
8c051ec2:	22 e1 e6 02 	R2 = 0x2e6 (X);		/*		R2=0x2e6(742) */
8c051ec6:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c051ec8:	ff e3 56 73 	CALL 0x0x8c040574;
8c051ecc:	e8 2f       	JUMP.S 0x0x8c051e9c;
8c051ece:	28 99       	R0 = B[P5] (Z);
8c051ed0:	86 6c       	SP += 0x10;		/* ( 16) */
8c051ed2:	b5 05       	(R7:6, P5:5) = [SP++];
8c051ed4:	01 e8 00 00 	UNLINK;
8c051ed8:	00 0c       	CC = R0 == 0x0;
8c051eda:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8c051edc:	01 06       	IF !CC R0 = R1;
8c051ede:	10 00       	RTS;
8c051ee0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c051ee4:	fd 05       	[--SP] = (R7:7, P5:5);
8c051ee6:	28 32       	P5 = R0;
8c051ee8:	86 6f       	SP += -0x10;		/* (-16) */
8c051eea:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8c051eec:	08 da 80 11 	P0=293610928;
8c051ef0:	b0 25 00 00 
8c051ef4:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0002;
8c051ef8:	fc 1e 02 00 
8c051efc:	a8 e4 04 00 	R0 = B[P5 + 0x4] (Z);
8c051f00:	88 09       	CC = R0 < R1 (IU);
8c051f02:	08 32       	P1 = R0;
8c051f04:	78 10       	IF !CC JUMP 0x0x8c051ff4;
8c051f06:	01 da 80 11 	R1=293610348;
8c051f0a:	6c 23 00 00 
8c051f0e:	48 5e       	P1 = P0 + (P1 << 0x2);
8c051f10:	49 91       	P1 = [P1];
8c051f12:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c051f16:	fc 1e 00 00 
8c051f1a:	03 da 80 7f 	R3=2139095040;
8c051f1e:	00 00 00 00 
8c051f22:	51 00       	JUMP (P1);
8c051f24:	86 6c       	SP += 0x10;		/* ( 16) */
8c051f26:	bd 05       	(R7:7, P5:5) = [SP++];
8c051f28:	01 e8 00 00 	UNLINK;
8c051f2c:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c051f2e:	10 00       	RTS;
8c051f30:	28 91       	R0 = [P5];
8c051f32:	80 0c       	CC = R0 < 0x0;
8c051f34:	03 10       	IF !CC JUMP 0x0x8c051f3a;
8c051f36:	8a 0c       	CC = R2 < 0x1;
8c051f38:	08 10       	IF !CC JUMP 0x0x8c051f48;
8c051f3a:	86 6c       	SP += 0x10;		/* ( 16) */
8c051f3c:	bd 05       	(R7:7, P5:5) = [SP++];
8c051f3e:	01 e8 00 00 	UNLINK;
8c051f42:	10 00       	RTS;
8c051f44:	00 00       	NOP;
8c051f46:	00 00       	NOP;
8c051f48:	09 da 80 11 	P1=293610736;
8c051f4c:	f0 24 00 00 
8c051f50:	f1 bc       	[SP + 0xc] = P1;
8c051f52:	22 e1 f5 02 	R2 = 0x2f5 (X);		/*		R2=0x2f5(757) */
8c051f56:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c051f58:	ff e3 0e 73 	CALL 0x0x8c040574;
8c051f5c:	28 91       	R0 = [P5];
8c051f5e:	86 6c       	SP += 0x10;		/* ( 16) */
8c051f60:	bd 05       	(R7:7, P5:5) = [SP++];
8c051f62:	01 e8 00 00 	UNLINK;
8c051f66:	10 00       	RTS;
8c051f68:	28 91       	R0 = [P5];
8c051f6a:	86 6c       	SP += 0x10;		/* ( 16) */
8c051f6c:	bd 05       	(R7:7, P5:5) = [SP++];
8c051f6e:	01 e8 00 00 	UNLINK;
8c051f72:	10 00       	RTS;
8c051f74:	28 91       	R0 = [P5];
8c051f76:	f8 48       	CC = !BITTST (R0, 0x1f);		/* bit 31 */
8c051f78:	02 02       	R2 = CC;
8c051f7a:	18 09       	CC = R0 <= R3;
8c051f7c:	03 60       	R3 = 0x0 (X);		/*		R3=0x0(  0) */
8c051f7e:	13 06       	IF !CC R2 = R3;
8c051f80:	03 da 00 80 	R3=-2147483648;
8c051f84:	00 00 00 00 
8c051f88:	18 08       	CC = R0 == R3;
8c051f8a:	0b 60       	R3 = 0x1 (X);		/*		R3=0x0(  0) */
8c051f8c:	13 07       	IF CC R2 = R3;
8c051f8e:	02 0c       	CC = R2 == 0x0;
8c051f90:	1c 10       	IF !CC JUMP 0x0x8c051fc8;
8c051f92:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0002;
8c051f96:	fc 1e 02 00 
8c051f9a:	8a 0c       	CC = R2 < 0x1;
8c051f9c:	0a 10       	IF !CC JUMP 0x0x8c051fb0;
8c051f9e:	00 de 02 04 	CALL.A 0x0402101c;
8c051fa2:	1c 10 00 00 
8c051fa6:	86 6c       	SP += 0x10;		/* ( 16) */
8c051fa8:	bd 05       	(R7:7, P5:5) = [SP++];
8c051faa:	01 e8 00 00 	UNLINK;
8c051fae:	10 00       	RTS;
8c051fb0:	09 da 80 11 	P1=293610796;
8c051fb4:	2c 25 00 00 
8c051fb8:	f1 bc       	[SP + 0xc] = P1;
8c051fba:	22 e1 fa 02 	R2 = 0x2fa (X);		/*		R2=0x2fa(762) */
8c051fbe:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c051fc0:	ff e3 da 72 	CALL 0x0x8c040574;
8c051fc4:	28 91       	R0 = [P5];
8c051fc6:	ec 2f       	JUMP.S 0x0x8c051f9e;
8c051fc8:	82 c6 08 c4 	R2 = ROT R0 BY 0x1;
8c051fcc:	82 c6 fa 87 	R3 = R2 >> 0x1;
8c051fd0:	9f 43       	R7 = -R3;
8c051fd2:	13 30       	R2 = R3;
8c051fd4:	1f 07       	IF CC R3 = R7;
8c051fd6:	07 da 80 4f 	R7=1333788672;
8c051fda:	00 00 00 00 
8c051fde:	3b 09       	CC = R3 <= R7;
8c051fe0:	03 da 80 7f 	R3=2139095041;
8c051fe4:	01 00 00 00 
8c051fe8:	9a 52       	R2 = R2 - R3;
8c051fea:	41 03       	CC &= AN;
8c051fec:	d9 1b       	IF CC JUMP 0x0x8c051f9e;
8c051fee:	d2 2f       	JUMP.S 0x0x8c051f92;
8c051ff0:	88 0c       	CC = R0 < 0x1;
8c051ff2:	0f 10       	IF !CC JUMP 0x0x8c052010;
8c051ff4:	00 da 80 11 	R0=293610864;
8c051ff8:	70 25 00 00 
8c051ffc:	ff e3 d4 72 	CALL 0x0x8c0405a4;
8c052000:	86 6c       	SP += 0x10;		/* ( 16) */
8c052002:	bd 05       	(R7:7, P5:5) = [SP++];
8c052004:	01 e8 00 00 	UNLINK;
8c052008:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c05200a:	10 00       	RTS;
8c05200c:	00 00       	NOP;
8c05200e:	00 00       	NOP;
8c052010:	09 da 80 11 	P1=293610832;
8c052014:	50 25 00 00 
8c052018:	f1 bc       	[SP + 0xc] = P1;
8c05201a:	22 e1 01 03 	R2 = 0x301 (X);		/*		R2=0x301(769) */
8c05201e:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c052020:	ff e3 aa 72 	CALL 0x0x8c040574;
8c052024:	e8 2f       	JUMP.S 0x0x8c051ff4;
8c052026:	28 99       	R0 = B[P5] (Z);
8c052028:	86 6c       	SP += 0x10;		/* ( 16) */
8c05202a:	bd 05       	(R7:7, P5:5) = [SP++];
8c05202c:	01 e8 00 00 	UNLINK;
8c052030:	00 0c       	CC = R0 == 0x0;
8c052032:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8c052034:	01 06       	IF !CC R0 = R1;
8c052036:	10 00       	RTS;
8c052038:	00 32       	P0 = R0;
8c05203a:	00 e8 04 00 	LINK 0x10;		/* (16) */
8c05203e:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8c052040:	0a da 80 11 	P2=293611060;
8c052044:	34 26 00 00 
8c052048:	80 e4 04 00 	R0 = B[P0 + 0x4] (Z);
8c05204c:	88 09       	CC = R0 < R1 (IU);
8c05204e:	08 32       	P1 = R0;
8c052050:	26 10       	IF !CC JUMP 0x0x8c05209c;
8c052052:	4a 5e       	P1 = P2 + (P1 << 0x2);
8c052054:	49 91       	P1 = [P1];
8c052056:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8c05205a:	fc 1e 00 00 
8c05205e:	01 da 80 3f 	R1=1065353216;
8c052062:	00 00 00 00 
8c052066:	51 00       	JUMP (P1);
8c052068:	01 e8 00 00 	UNLINK;
8c05206c:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c05206e:	10 00       	RTS;
8c052070:	00 91       	R0 = [P0];
8c052072:	00 de 02 04 	CALL.A 0x04021854;
8c052076:	54 18 00 00 
8c05207a:	01 e8 00 00 	UNLINK;
8c05207e:	10 00       	RTS;
8c052080:	00 91       	R0 = [P0];
8c052082:	00 de 02 04 	CALL.A 0x040218a0;
8c052086:	a0 18 00 00 
8c05208a:	01 e8 00 00 	UNLINK;
8c05208e:	10 00       	RTS;
8c052090:	00 91       	R0 = [P0];
8c052092:	01 e8 00 00 	UNLINK;
8c052096:	10 00       	RTS;
8c052098:	88 0c       	CC = R0 < 0x1;
8c05209a:	0b 10       	IF !CC JUMP 0x0x8c0520b0;
8c05209c:	00 da 80 11 	R0=293610996;
8c0520a0:	f4 25 00 00 
8c0520a4:	ff e3 80 72 	CALL 0x0x8c0405a4;
8c0520a8:	01 e8 00 00 	UNLINK;
8c0520ac:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c0520ae:	10 00       	RTS;
8c0520b0:	09 da 80 11 	P1=293610960;
8c0520b4:	d0 25 00 00 
8c0520b8:	f1 bc       	[SP + 0xc] = P1;
8c0520ba:	22 e1 1a 03 	R2 = 0x31a (X);		/*		R2=0x31a(794) */
8c0520be:	01 da 80 11 	R1=293610348;
8c0520c2:	6c 23 00 00 
8c0520c6:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c0520c8:	ff e3 56 72 	CALL 0x0x8c040574;
8c0520cc:	e8 2f       	JUMP.S 0x0x8c05209c;
8c0520ce:	00 99       	R0 = B[P0] (Z);
8c0520d0:	01 e8 00 00 	UNLINK;
8c0520d4:	00 0c       	CC = R0 == 0x0;
8c0520d6:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c0520d8:	01 06       	IF !CC R0 = R1;
8c0520da:	10 00       	RTS;
8c0520dc:	00 32       	P0 = R0;
8c0520de:	00 e8 03 00 	LINK 0xc;		/* (12) */
8c0520e2:	41 60       	R1 = 0x8 (X);		/*		R1=0x0(  0) */
8c0520e4:	0a da 80 11 	P2=293611156;
8c0520e8:	94 26 00 00 
8c0520ec:	80 e4 04 00 	R0 = B[P0 + 0x4] (Z);
8c0520f0:	88 09       	CC = R0 < R1 (IU);
8c0520f2:	08 32       	P1 = R0;
8c0520f4:	0a 10       	IF !CC JUMP 0x0x8c052108;
8c0520f6:	4a 5e       	P1 = P2 + (P1 << 0x2);
8c0520f8:	04 cc 00 40 	R0 = R0 - R0 (NS) || P1 = [P1] || NOP;
8c0520fc:	49 91 00 00 
8c052100:	51 00       	JUMP (P1);
8c052102:	00 00       	NOP;
8c052104:	00 00       	NOP;
8c052106:	00 00       	NOP;
8c052108:	00 da 80 11 	R0=293611092;
8c05210c:	54 26 00 00 
8c052110:	ff e3 4a 72 	CALL 0x0x8c0405a4;
8c052114:	01 e8 00 00 	UNLINK;
8c052118:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c05211a:	10 00       	RTS;
8c05211c:	01 e8 00 00 	UNLINK;
8c052120:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8c052122:	10 00       	RTS;
8c052124:	00 91       	R0 = [P0];
8c052126:	01 e8 00 00 	UNLINK;
8c05212a:	00 0c       	CC = R0 == 0x0;
8c05212c:	10 02       	ILLEGAL;
8c05212e:	10 00       	RTS;
8c052130:	00 91       	R0 = [P0];
8c052132:	01 e8 00 00 	UNLINK;
8c052136:	f8 4c       	BITCLR (R0, 0x1f);		/* bit 31 */
8c052138:	00 0c       	CC = R0 == 0x0;
8c05213a:	10 02       	ILLEGAL;
8c05213c:	10 00       	RTS;
8c05213e:	01 91       	R1 = [P0];
8c052140:	09 32       	P1 = R1;
8c052142:	01 0c       	CC = R1 == 0x0;
8c052144:	04 18       	IF CC JUMP 0x0x8c05214c;
8c052146:	48 99       	R0 = B[P1] (X);
8c052148:	00 0c       	CC = R0 == 0x0;
8c05214a:	10 02       	ILLEGAL;
8c05214c:	01 e8 00 00 	UNLINK;
8c052150:	10 00       	RTS;
8c052152:	00 99       	R0 = B[P0] (Z);
8c052154:	01 e8 00 00 	UNLINK;
8c052158:	10 00       	RTS;
8c05215a:	41 91       	P1 = [P0];
8c05215c:	88 a0       	R0 = [P1 + 0x8];
8c05215e:	01 e8 00 00 	UNLINK;
8c052162:	00 0c       	CC = R0 == 0x0;
8c052164:	10 02       	ILLEGAL;
8c052166:	10 00       	RTS;
8c052168:	00 00       	NOP;
8c05216a:	00 32       	P0 = R0;
8c05216c:	00 e8 04 00 	LINK 0x10;		/* (16) */
8c052170:	f7 b0       	[SP + 0xc] = R7;
8c052172:	42 60       	R2 = 0x8 (X);		/*		R2=0x31a(794) */
8c052174:	0a da 80 11 	P2=293611252;
8c052178:	f4 26 00 00 
8c05217c:	80 e4 04 00 	R0 = B[P0 + 0x4] (Z);
8c052180:	90 09       	CC = R0 < R2 (IU);
8c052182:	08 32       	P1 = R0;
8c052184:	0a 10       	IF !CC JUMP 0x0x8c052198;
8c052186:	4a 5e       	P1 = P2 + (P1 << 0x2);
8c052188:	03 c8 00 18 	MNOP || P1 = [P1] || R7 = [SP + 0xc];
8c05218c:	49 91 f7 a0 
8c052190:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c052192:	01 0c       	CC = R1 == 0x0;
8c052194:	51 00       	JUMP (P1);
8c052196:	00 00       	NOP;
8c052198:	00 da 80 11 	R0=293611188;
8c05219c:	b4 26 00 00 
8c0521a0:	ff e3 02 72 	CALL 0x0x8c0405a4;
8c0521a4:	04 cc 00 40 	R0 = R0 - R0 (NS) || R7 = [SP + 0xc] || NOP;
8c0521a8:	f7 a0 00 00 
8c0521ac:	01 e8 00 00 	UNLINK;
8c0521b0:	10 00       	RTS;
8c0521b2:	00 00       	NOP;
8c0521b4:	01 e8 00 00 	UNLINK;
8c0521b8:	10 00       	RTS;
8c0521ba:	01 0c       	CC = R1 == 0x0;
8c0521bc:	05 10       	IF !CC JUMP 0x0x8c0521c6;
8c0521be:	00 91       	R0 = [P0];
8c0521c0:	00 0c       	CC = R0 == 0x0;
8c0521c2:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c0521c4:	11 18       	IF CC JUMP 0x0x8c0521e6;
8c0521c6:	09 0c       	CC = R1 == 0x1;
8c0521c8:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c0521ca:	0e 18       	IF CC JUMP 0x0x8c0521e6;
8c0521cc:	11 0c       	CC = R1 == 0x2;
8c0521ce:	04 10       	IF !CC JUMP 0x0x8c0521d6;
8c0521d0:	02 91       	R2 = [P0];
8c0521d2:	82 0c       	CC = R2 < 0x0;
8c0521d4:	09 10       	IF !CC JUMP 0x0x8c0521e6;
8c0521d6:	19 0c       	CC = R1 == 0x3;
8c0521d8:	07 18       	IF CC JUMP 0x0x8c0521e6;
8c0521da:	22 60       	R2 = 0x4 (X);		/*		R2=0x31a(794) */
8c0521dc:	11 08       	CC = R1 == R2;
8c0521de:	04 18       	IF CC JUMP 0x0x8c0521e6;
8c0521e0:	28 60       	R0 = 0x5 (X);		/*		R0=0x0(  0) */
8c0521e2:	01 08       	CC = R1 == R0;
8c0521e4:	00 02       	R0 = CC;
8c0521e6:	f7 a0       	R7 = [SP + 0xc];
8c0521e8:	01 e8 00 00 	UNLINK;
8c0521ec:	10 00       	RTS;
8c0521ee:	01 0c       	CC = R1 == 0x0;
8c0521f0:	05 10       	IF !CC JUMP 0x0x8c0521fa;
8c0521f2:	00 91       	R0 = [P0];
8c0521f4:	00 0c       	CC = R0 == 0x0;
8c0521f6:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c0521f8:	16 18       	IF CC JUMP 0x0x8c052224;
8c0521fa:	09 0c       	CC = R1 == 0x1;
8c0521fc:	09 10       	IF !CC JUMP 0x0x8c05220e;
8c0521fe:	00 91       	R0 = [P0];
8c052200:	02 da ff 7f 	R2=2147483647;
8c052204:	ff ff 00 00 
8c052208:	10 0a       	CC = R0 <= R2 (IU);
8c05220a:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c05220c:	0c 18       	IF CC JUMP 0x0x8c052224;
8c05220e:	11 0c       	CC = R1 == 0x2;
8c052210:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8c052212:	09 18       	IF CC JUMP 0x0x8c052224;
8c052214:	19 0c       	CC = R1 == 0x3;
8c052216:	07 18       	IF CC JUMP 0x0x8c052224;
8c052218:	22 60       	R2 = 0x4 (X);		/*		R2=0x31a(794) */
8c05221a:	11 08       	CC = R1 == R2;
8c05221c:	04 18       	IF CC JUMP 0x0x8c052224;
8c05221e:	28 60       	R0 = 0x5 (X);		/*		R0=0x0(  0) */
