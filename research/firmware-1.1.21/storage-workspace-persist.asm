
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d4cc020.bin:     file format binary


Disassembly of section .data:

8d584248 <.data+0xb8228>:
8d584248:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d58424c:	ff e3 6e ff 	CALL 0x0x8d584128;
8d584250:	00 da 0a 84 	R0=-2079711604;
8d584254:	8c 1e 00 00 
8d584258:	ff e3 ae 6b 	CALL 0x0x8d5719b4;
8d58425c:	01 e8 00 00 	UNLINK;
8d584260:	10 00       	RTS;
8d584262:	00 00       	NOP;
8d584264:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d584268:	70 05       	[--SP] = (R7:6);
8d58426a:	30 30       	R6 = R0;
8d58426c:	01 30       	R0 = R1;
8d58426e:	39 30       	R7 = R1;
8d584270:	a6 6f       	SP += -0xc;		/* (-12) */
8d584272:	09 60       	R1 = 0x1 (X);		/*		R1=0x0(  0) */
8d584274:	ff e3 62 84 	CALL 0x0x8d574b38;
8d584278:	00 0c       	CC = R0 == 0x0;
8d58427a:	06 10       	IF !CC JUMP 0x0x8d584286;
8d58427c:	66 6c       	SP += 0xc;		/* ( 12) */
8d58427e:	30 05       	(R7:6) = [SP++];
8d584280:	01 e8 00 00 	UNLINK;
8d584284:	10 00       	RTS;
8d584286:	0f 30       	R1 = R7;
8d584288:	06 30       	R0 = R6;
8d58428a:	ff e3 df ff 	CALL 0x0x8d584248;
8d58428e:	66 6c       	SP += 0xc;		/* ( 12) */
8d584290:	30 05       	(R7:6) = [SP++];
8d584292:	01 e8 00 00 	UNLINK;
8d584296:	08 60       	R0 = 0x1 (X);		/*		R0=0x0(  0) */
8d584298:	10 00       	RTS;
8d58429a:	00 00       	NOP;
8d58429c:	00 e8 04 00 	LINK 0x10;		/* (16) */
8d5842a0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0xc] = R7 || NOP;
8d5842a4:	f7 b0 00 00 
8d5842a8:	01 da 0a 84 	R1=-2079711604;
8d5842ac:	8c 1e 00 00 
8d5842b0:	ff e3 da ff 	CALL 0x0x8d584264;
8d5842b4:	00 0c       	CC = R0 == 0x0;
8d5842b6:	05 18       	IF CC JUMP 0x0x8d5842c0;
8d5842b8:	f7 a0       	R7 = [SP + 0xc];
8d5842ba:	01 e8 00 00 	UNLINK;
8d5842be:	10 00       	RTS;
8d5842c0:	ff e3 ba 7c 	CALL 0x0x8d573c34;
8d5842c4:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5842c6:	fe e3 b1 e3 	CALL 0x0x8d560a28;
8d5842ca:	ff e3 99 6a 	CALL 0x0x8d5717fc;
8d5842ce:	07 30       	R0 = R7;
8d5842d0:	ff e3 2c ff 	CALL 0x0x8d584128;
8d5842d4:	f7 a0       	R7 = [SP + 0xc];
8d5842d6:	01 e8 00 00 	UNLINK;
8d5842da:	10 00       	RTS;
