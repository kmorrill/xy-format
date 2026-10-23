
os.ldr@0x8d4dcca0:     file format binary


Disassembly of section .data:

8d4dcca0 <.data>:
8d4dcca0:	00 e8 03 00 	LINK 0xc;		/* (12) */
8d4dcca4:	79 61       	R1 = 0x2f (X);		/*		R1=0x0(  0) */
8d4dcca6:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d4dccaa:	b8 00 02 00 
8d4dccae:	ff e3 bb d4 	CALL 0x0x8d4d7624;
8d4dccb2:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d4dccb6:	b8 00 01 00 
8d4dccba:	01 e8 00 00 	UNLINK;
8d4dccbe:	08 08       	CC = R0 == R1;
8d4dccc0:	00 02       	R0 = CC;
8d4dccc2:	10 00       	RTS;
