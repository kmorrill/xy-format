
os.ldr@0x8c0518f4:     file format binary


Disassembly of section .data:

8c0518f4 <.data>:
8c0518f4:	00 e8 00 00 	LINK 0x0;		/* (0) */
8c0518f8:	ed 05       	[--SP] = (R7:5, P5:5);
8c0518fa:	28 32       	P5 = R0;
8c0518fc:	31 30       	R6 = R1;
8c0518fe:	82 c6 0e c0 	R0 = ROT R6 BY 0x1;
8c051902:	a6 6f       	SP += -0xc;		/* (-12) */
8c051904:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8c051906:	1b 60       	R3 = 0x3 (X);		/*		R3=0x0(  0) */
8c051908:	82 ce f8 85 	R2 = R0 >> 0x1 || [P5 + 0x8] = R1 || NOP;
8c05190c:	a9 b0 00 00 
8c051910:	ab e6 04 00 	B[P5 + 0x4] = R3;
8c051914:	93 43       	R3 = -R2;
8c051916:	00 d8 02 04 	LdStAbs addr=0x04023fbc control=0x0000;
8c05191a:	bc 3f 00 00 
8c05191e:	0a 30       	R1 = R2;
8c051920:	13 07       	IF CC R2 = R3;
8c051922:	82 c6 08 c6 	R3 = ROT R0 BY 0x1;
8c051926:	0b 4e       	R3 >>= 0x1;
8c051928:	07 c4 0b 0a 	R5 = MAX (R1, R3);
8c05192c:	99 43       	R1 = -R3;
8c05192e:	19 07       	IF CC R3 = R1;
8c051930:	9a 08       	CC = R2 < R3;
8c051932:	07 da 80 7f 	R7=2139095041;
8c051936:	01 00 00 00 
8c05193a:	7d 52       	R1 = R5 - R7;
