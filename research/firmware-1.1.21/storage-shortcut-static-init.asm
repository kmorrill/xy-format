
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d591de0.bin:     file format binary


Disassembly of section .data:

8d5a3f2a <.data+0x1214a>:
8d5a3f2a:	00 da 0a 84 	R0=-2079689732;
8d5a3f2e:	fc 73 00 00 
8d5a3f32:	80 65       	R0 += 0x30;		/* ( 48) */
8d5a3f34:	01 da 0a 84 	R1=-2079689732;
8d5a3f38:	fc 73 00 00 
8d5a3f3c:	01 08       	CC = R1 == R0;
8d5a3f3e:	0d da 0a 84 	P5=-2079689732;
8d5a3f42:	fc 73 00 00 
8d5a3f46:	29 18       	IF CC JUMP 0x0x8d5a3f98;
8d5a3f48:	26 e1 5c 00 	R6 = 0x5c (X);		/*		R6=0x5c( 92) */
8d5a3f4c:	37 60       	R7 = 0x6 (X);		/*		R7=0x0(  0) */
8d5a3f4e:	66 30       	R4 = SP;
8d5a3f50:	46 30       	R0 = SP;
8d5a3f52:	70 51       	R5 = R0 + R6;
8d5a3f54:	05 30       	R0 = R5;
8d5a3f56:	ff e3 b0 fb 	CALL 0x0x8d5a36b6;
8d5a3f5a:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || R1 = [P5++] || NOP;
8d5a3f5e:	29 90 00 00 
8d5a3f62:	00 de 09 8c 	CALL.A 0x8c09a376;
8d5a3f66:	76 a3 00 00 
8d5a3f6a:	22 e1 78 00 	R2 = 0x78 (X);		/*		R2=0x78(120) */
8d5a3f6e:	04 cc 22 00 	R0 = R4 + R2 (NS) || R1 = [P5++] || NOP;
8d5a3f72:	29 90 00 00 
8d5a3f76:	00 de 09 8c 	CALL.A 0x8c09a376;
8d5a3f7a:	76 a3 00 00 
8d5a3f7e:	0d 30       	R1 = R5;
8d5a3f80:	00 da bd 86 	R0=-2034409228;
8d5a3f84:	f4 60 00 00 
8d5a3f88:	ff e3 78 fd 	CALL 0x0x8d5a3a78;
8d5a3f8c:	05 30       	R0 = R5;
8d5a3f8e:	ff e3 dd fb 	CALL 0x0x8d5a3748;
8d5a3f92:	ff 67       	R7 += -0x1;		/* ( -1) */
8d5a3f94:	07 0c       	CC = R7 == 0x0;
8d5a3f96:	dd 17       	IF !CC JUMP 0x0x8d5a3f50 (BP);
