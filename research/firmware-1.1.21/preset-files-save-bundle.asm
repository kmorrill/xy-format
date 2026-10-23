
os.ldr@0x8d4e071c:     file format binary


Disassembly of section .data:

8d4e071c <.data>:
8d4e071c:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d4e0720:	68 05       	[--SP] = (R7:5);
8d4e0722:	38 30       	R7 = R0;
8d4e0724:	47 30       	R0 = FP;
8d4e0726:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e0728:	40 66       	R0 += -0x38;		/* (-56) */
8d4e072a:	77 30       	R6 = FP;
8d4e072c:	29 30       	R5 = R1;
8d4e072e:	06 e3 85 1f 	CALL 0x0x8d5a4638;
8d4e0732:	26 67       	R6 += -0x1c;		/* (-28) */
8d4e0734:	0d 30       	R1 = R5;
8d4e0736:	06 30       	R0 = R6;
8d4e0738:	06 e3 be 1f 	CALL 0x0x8d5a46b4;
8d4e073c:	0e 30       	R1 = R6;
8d4e073e:	07 30       	R0 = R7;
8d4e0740:	16 30       	R2 = R6;
8d4e0742:	21 67       	R1 += -0x1c;		/* (-28) */
8d4e0744:	06 e3 b1 20 	CALL 0x0x8d5a48a6;
8d4e0748:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e074a:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R0 = [FP -0x4] || NOP;
8d4e074e:	f0 b9 00 00 
8d4e0752:	07 0a       	CC = R7 <= R0 (IU);
8d4e0754:	1a 18       	IF CC JUMP 0x0x8d4e0788;
8d4e0756:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d4e0758:	f0 bb       	[FP -0x4] = R0;
8d4e075a:	30 a3       	R0 = [SP + 0x30];
8d4e075c:	07 0a       	CC = R7 <= R0 (IU);
8d4e075e:	e6 bb       	[FP -0x8] = R6;
8d4e0760:	b6 e6 38 00 	B[SP + 0x38] = R6;
8d4e0764:	08 18       	IF CC JUMP 0x0x8d4e0774;
8d4e0766:	b6 e6 1c 00 	B[SP + 0x1c] = R6;
8d4e076a:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e076c:	28 05       	(R7:5) = [SP++];
8d4e076e:	01 e8 00 00 	UNLINK;
8d4e0772:	10 00       	RTS;
8d4e0774:	f0 a1       	R0 = [SP + 0x1c];
8d4e0776:	ff e3 37 6e 	CALL 0x0x8d4ce3e4;
8d4e077a:	b6 e6 1c 00 	B[SP + 0x1c] = R6;
8d4e077e:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e0780:	28 05       	(R7:5) = [SP++];
8d4e0782:	01 e8 00 00 	UNLINK;
8d4e0786:	10 00       	RTS;
8d4e0788:	b0 a3       	R0 = [SP + 0x38];
8d4e078a:	ff e3 2d 6e 	CALL 0x0x8d4ce3e4;
8d4e078e:	e4 2f       	JUMP.S 0x0x8d4e0756;
8d4e0790:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d4e0794:	68 05       	[--SP] = (R7:5);
8d4e0796:	6f 30       	R5 = FP;
8d4e0798:	25 67       	R5 += -0x1c;		/* (-28) */
8d4e079a:	30 30       	R6 = R0;
8d4e079c:	39 30       	R7 = R1;
8d4e079e:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e07a0:	05 30       	R0 = R5;
8d4e07a2:	0a 30       	R1 = R2;
8d4e07a4:	06 e3 88 1f 	CALL 0x0x8d5a46b4;
8d4e07a8:	15 30       	R2 = R5;
8d4e07aa:	0f 30       	R1 = R7;
8d4e07ac:	06 30       	R0 = R6;
8d4e07ae:	06 e3 7c 20 	CALL 0x0x8d5a48a6;
8d4e07b2:	80 60       	R0 = 0x10 (X);		/*		R0=0x0(  0) */
8d4e07b4:	31 a3       	R1 = [SP + 0x30];
8d4e07b6:	08 0a       	CC = R0 <= R1 (IU);
8d4e07b8:	09 18       	IF CC JUMP 0x0x8d4e07ca;
8d4e07ba:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e07bc:	b0 e6 1c 00 	B[SP + 0x1c] = R0;
8d4e07c0:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e07c2:	28 05       	(R7:5) = [SP++];
8d4e07c4:	01 e8 00 00 	UNLINK;
8d4e07c8:	10 00       	RTS;
8d4e07ca:	f0 a1       	R0 = [SP + 0x1c];
8d4e07cc:	ff e3 0c 6e 	CALL 0x0x8d4ce3e4;
8d4e07d0:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e07d2:	b0 e6 1c 00 	B[SP + 0x1c] = R0;
8d4e07d6:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e07d8:	28 05       	(R7:5) = [SP++];
8d4e07da:	01 e8 00 00 	UNLINK;
8d4e07de:	10 00       	RTS;
8d4e07e0:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d4e07e4:	08 30       	R1 = R0;
8d4e07e6:	60 05       	[--SP] = (R7:4);
8d4e07e8:	47 30       	R0 = FP;
8d4e07ea:	a6 6f       	SP += -0xc;		/* (-12) */
8d4e07ec:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e07ee:	06 e3 61 1d 	CALL 0x0x8d5a42b0;
8d4e07f2:	03 c8 00 18 	MNOP || R7 = [SP + 0x30] || R3 = [SP + 0x34];
8d4e07f6:	37 a3 73 a3 
8d4e07fa:	65 60       	R5 = 0xc (X);		/*		R5=0x0(  0) */
8d4e07fc:	af 09       	CC = R7 < R5 (IU);
8d4e07fe:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d4e0800:	47 30       	R0 = FP;
8d4e0802:	2f 07       	IF CC R5 = R7;
8d4e0804:	1e 0a       	CC = R6 <= R3 (IU);
8d4e0806:	40 67       	R0 += -0x18;		/* (-24) */
8d4e0808:	34 a2       	R4 = [SP + 0x20];
8d4e080a:	62 60       	R2 = 0xc (X);		/*		R2=0x0(  0) */
8d4e080c:	04 07       	IF CC R0 = R4;
8d4e080e:	95 09       	CC = R5 < R2 (IU);
8d4e0810:	15 07       	IF CC R2 = R5;
8d4e0812:	01 da 03 84 	R1=-2080152276;
8d4e0816:	2c 65 00 00 
8d4e081a:	00 de 02 04 	CALL.A 0x04023068;
8d4e081e:	68 30 00 00 
8d4e0822:	38 30       	R7 = R0;
8d4e0824:	07 0c       	CC = R7 == 0x0;
8d4e0826:	07 10       	IF !CC JUMP 0x0x8d4e0834;
8d4e0828:	60 60       	R0 = 0xc (X);		/*		R0=0x0(  0) */
8d4e082a:	85 09       	CC = R5 < R0 (IU);
8d4e082c:	ff 63       	R7 = -0x1 (X);		/*		R7=0x0(  0) */
8d4e082e:	03 18       	IF CC JUMP 0x0x8d4e0834;
8d4e0830:	28 08       	CC = R0 == R5;
8d4e0832:	17 02       	ILLEGAL;
8d4e0834:	70 a3       	R0 = [SP + 0x34];
8d4e0836:	06 0a       	CC = R6 <= R0 (IU);
8d4e0838:	0b 18       	IF CC JUMP 0x0x8d4e084e;
8d4e083a:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e083c:	b0 e6 20 00 	B[SP + 0x20] = R0;
8d4e0840:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e0842:	07 0c       	CC = R7 == 0x0;
8d4e0844:	20 05       	(R7:4) = [SP++];
8d4e0846:	01 e8 00 00 	UNLINK;
8d4e084a:	00 02       	R0 = CC;
8d4e084c:	10 00       	RTS;
8d4e084e:	30 a2       	R0 = [SP + 0x20];
8d4e0850:	ff e3 ca 6d 	CALL 0x0x8d4ce3e4;
8d4e0854:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d4e0856:	b0 e6 20 00 	B[SP + 0x20] = R0;
8d4e085a:	66 6c       	SP += 0xc;		/* ( 12) */
8d4e085c:	07 0c       	CC = R7 == 0x0;
8d4e085e:	20 05       	(R7:4) = [SP++];
8d4e0860:	01 e8 00 00 	UNLINK;
8d4e0864:	00 02       	R0 = CC;
8d4e0866:	10 00       	RTS;
8d4e0868:	00 e8 23 00 	LINK 0x8c;		/* (140) */
8d4e086c:	60 05       	[--SP] = (R7:4);
8d4e086e:	86 6f       	SP += -0x10;		/* (-16) */
8d4e0870:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || [SP + 0x20] = R1 || NOP;
8d4e0874:	31 b2 00 00 
8d4e0878:	47 30       	R0 = FP;
8d4e087a:	48 64       	R0 += 0x9;		/* (  9) */
8d4e087c:	0a 60       	R2 = 0x1 (X);		/*		R2=0x0(  0) */
8d4e087e:	01 60       	R1 = 0x0 (X);		/*		R1=0x0(  0) */
8d4e0880:	00 de 02 04 	CALL.A 0x04022ea8;
8d4e0884:	a8 2e 00 00 
8d4e0888:	24 e1 40 00 	R4 = 0x40 (X);		/*		R4=0x40( 64) */
8d4e088c:	5e 30       	R3 = SP;
8d4e088e:	e3 50       	R3 = R3 + R4;
8d4e0890:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [FP + 0x10] = R3 || NOP;
8d4e0894:	3b b1 00 00 
8d4e0898:	57 30       	R2 = FP;
8d4e089a:	42 64       	R2 += 0x8;		/* (  8) */
8d4e089c:	0a 30       	R1 = R2;
8d4e089e:	09 64       	R1 += 0x1;		/* (  1) */
8d4e08a0:	38 a1       	R0 = [FP + 0x10];
8d4e08a2:	ff e3 51 e0 	CALL 0x0x8d4dc944;
8d4e08a6:	76 30       	R6 = SP;
8d4e08a8:	22 61       	R2 = 0x24 (X);		/*		R2=0x0(  0) */
8d4e08aa:	04 cc 32 0c 	R6 = R6 + R2 (NS) || [SP + 0x38] = R5 || NOP;
8d4e08ae:	b5 b3 00 00 
8d4e08b2:	04 da 03 84 	R4=-2080152784;
8d4e08b6:	30 63 00 00 
8d4e08ba:	23 e1 0c 02 	R3 = 0x20c (X);		/*		R3=0x20c(524) */
8d4e08be:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
8d4e08c0:	04 cc 23 02 	R1 = R4 + R3 (NS) || [SP + 0x3c] = R2 || NOP;
8d4e08c4:	f2 b3 00 00 
8d4e08c8:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4e08cc:	06 30       	R0 = R6;
8d4e08ce:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e08d2:	76 a3 00 00 
8d4e08d6:	06 30       	R0 = R6;
8d4e08d8:	0e 30       	R1 = R6;
8d4e08da:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e08dc:	ff e3 a4 df 	CALL 0x0x8d4dc824;
8d4e08e0:	f0 a3       	R0 = [SP + 0x3c];
8d4e08e2:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8d4e08e4:	02 0a       	CC = R2 <= R0 (IU);
8d4e08e6:	a8 18       	IF CC JUMP 0x0x8d4e0a36;
8d4e08e8:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0x38] = R5 || NOP;
8d4e08ec:	b5 b3 00 00 
8d4e08f0:	7b 60       	R3 = 0xf (X);		/*		R3=0x20c(524) */
8d4e08f2:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4e08f6:	f3 b3       	[SP + 0x3c] = R3;
8d4e08f8:	40 64       	R0 += 0x8;		/* (  8) */
8d4e08fa:	01 da 03 84 	R1=-2080152784;
8d4e08fe:	30 63 00 00 
8d4e0902:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0906:	14 33 00 00 
8d4e090a:	56 30       	R2 = SP;
8d4e090c:	23 e1 4c 00 	R3 = 0x4c (X);		/*		R3=0x4c( 76) */
8d4e0910:	9a 51       	R6 = R2 + R3;
8d4e0912:	08 30       	R1 = R0;
8d4e0914:	06 30       	R0 = R6;
8d4e0916:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4e091a:	f0 2b 00 00 
8d4e091e:	06 30       	R0 = R6;
8d4e0920:	00 de 05 8c 	CALL.A 0x8c052382;
8d4e0924:	82 23 00 00 
8d4e0928:	00 0d       	CC = R0 <= 0x0;
8d4e092a:	31 18       	IF CC JUMP 0x0x8d4e098c;
8d4e092c:	20 e1 98 00 	R0 = 0x98 (X);		/*		R0=0x98(152) */
8d4e0930:	04 50       	R0 = R4 + R0;
8d4e0932:	f8 b0       	[FP + 0xc] = R0;
8d4e0934:	07 60       	R7 = 0x0 (X);		/*		R7=0x0(  0) */
8d4e0936:	56 30       	R2 = SP;
8d4e0938:	23 e1 58 00 	R3 = 0x58 (X);		/*		R3=0x58( 88) */
8d4e093c:	0f 30       	R1 = R7;
8d4e093e:	06 30       	R0 = R6;
8d4e0940:	1a 51       	R4 = R2 + R3;
8d4e0942:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4e0946:	e4 30 00 00 
8d4e094a:	f9 a0       	R1 = [FP + 0xc];
8d4e094c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0950:	14 33 00 00 
8d4e0954:	08 30       	R1 = R0;
8d4e0956:	04 30       	R0 = R4;
8d4e0958:	00 de 05 8c 	CALL.A 0x8c051cca;
8d4e095c:	ca 1c 00 00 
8d4e0960:	00 b9       	R0 = [FP -0x40];
8d4e0962:	00 0c       	CC = R0 == 0x0;
8d4e0964:	33 10       	IF !CC JUMP 0x0x8d4e09ca;
8d4e0966:	10 b9       	R0 = [FP -0x3c];
8d4e0968:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e096a:	01 0a       	CC = R1 <= R0 (IU);
8d4e096c:	2b 18       	IF CC JUMP 0x0x8d4e09c2;
8d4e096e:	78 60       	R0 = 0xf (X);		/*		R0=0x98(152) */
8d4e0970:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [FP -0x3c] = R0 || NOP;
8d4e0974:	10 bb 00 00 
8d4e0978:	05 bb       	[FP -0x40] = R5;
8d4e097a:	b5 e6 5c 00 	B[SP + 0x5c] = R5;
8d4e097e:	0f 64       	R7 += 0x1;		/* (  1) */
8d4e0980:	00 de 05 8c 	CALL.A 0x8c052382;
8d4e0984:	82 23 00 00 
8d4e0988:	87 08       	CC = R7 < R0;
8d4e098a:	d6 1f       	IF CC JUMP 0x0x8d4e0936 (BP);
8d4e098c:	09 68       	P1 = 0x1 (X);		/*		P1=0x0(  0) */
8d4e098e:	03 c8 00 18 	MNOP || [SP + 0xc] = P1 || R0 = [FP + 0x10];
8d4e0992:	f1 bc 38 a1 
8d4e0996:	31 a2       	R1 = [SP + 0x20];
8d4e0998:	02 da 4d 8d 	R2=-1924281800;
8d4e099c:	38 ca 00 00 
8d4e09a0:	00 de 03 8c 	CALL.A 0x8c03ffac;
8d4e09a4:	ac ff 00 00 
8d4e09a8:	06 30       	R0 = R6;
8d4e09aa:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e09ae:	38 1a 00 00 
8d4e09b2:	38 a1       	R0 = [FP + 0x10];
8d4e09b4:	ff e3 24 e0 	CALL 0x0x8d4dc9fc;
8d4e09b8:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e09ba:	20 05       	(R7:4) = [SP++];
8d4e09bc:	01 e8 00 00 	UNLINK;
8d4e09c0:	10 00       	RTS;
8d4e09c2:	c0 b8       	R0 = [FP -0x50];
8d4e09c4:	ff e3 10 6d 	CALL 0x0x8d4ce3e4;
8d4e09c8:	d3 2f       	JUMP.S 0x0x8d4e096e;
8d4e09ca:	04 30       	R0 = R4;
8d4e09cc:	ff e3 0a ff 	CALL 0x0x8d4e07e0;
8d4e09d0:	00 0c       	CC = R0 == 0x0;
8d4e09d2:	ca 17       	IF !CC JUMP 0x0x8d4e0966 (BP);
8d4e09d4:	04 30       	R0 = R4;
8d4e09d6:	0c 30       	R1 = R4;
8d4e09d8:	c0 65       	R0 += 0x38;		/* ( 56) */
8d4e09da:	06 e3 6b 1c 	CALL 0x0x8d5a42b0;
8d4e09de:	47 30       	R0 = FP;
8d4e09e0:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e09e2:	08 30       	R1 = R0;
8d4e09e4:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e09e6:	06 e3 67 1e 	CALL 0x0x8d5a46b4;
8d4e09ea:	4f 30       	R1 = FP;
8d4e09ec:	41 66       	R1 += -0x38;		/* (-56) */
8d4e09ee:	01 30       	R0 = R1;
8d4e09f0:	60 66       	R0 += -0x34;		/* (-52) */
8d4e09f2:	ff e3 19 df 	CALL 0x0x8d4dc824;
8d4e09f6:	80 b9       	R0 = [FP -0x20];
8d4e09f8:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8d4e09fa:	02 0a       	CC = R2 <= R0 (IU);
8d4e09fc:	19 18       	IF CC JUMP 0x0x8d4e0a2e;
8d4e09fe:	03 c8 00 18 	MNOP || R0 = [FP -0x4] || [FP -0x24] = R5;
8d4e0a02:	f0 b9 75 bb 
8d4e0a06:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8d4e0a08:	79 60       	R1 = 0xf (X);		/*		R1=0x0(  0) */
8d4e0a0a:	02 0a       	CC = R2 <= R0 (IU);
8d4e0a0c:	b5 e6 78 00 	B[SP + 0x78] = R5;
8d4e0a10:	03 c8 00 18 	MNOP || [FP -0x20] = R1 || R0 = [FP -0x18];
8d4e0a14:	81 bb a0 b9 
8d4e0a18:	08 18       	IF CC JUMP 0x0x8d4e0a28;
8d4e0a1a:	78 60       	R0 = 0xf (X);		/*		R0=0x98(152) */
8d4e0a1c:	e5 bb       	[FP -0x8] = R5;
8d4e0a1e:	b5 e6 94 00 	B[SP + 0x94] = R5;
8d4e0a22:	f0 bb       	[FP -0x4] = R0;
8d4e0a24:	a1 2f       	JUMP.S 0x0x8d4e0966;
8d4e0a26:	00 00       	NOP;
8d4e0a28:	ff e3 de 6c 	CALL 0x0x8d4ce3e4;
8d4e0a2c:	f7 2f       	JUMP.S 0x0x8d4e0a1a;
8d4e0a2e:	30 b9       	R0 = [FP -0x34];
8d4e0a30:	ff e3 da 6c 	CALL 0x0x8d4ce3e4;
8d4e0a34:	e5 2f       	JUMP.S 0x0x8d4e09fe;
8d4e0a36:	b0 a2       	R0 = [SP + 0x28];
8d4e0a38:	ff e3 d6 6c 	CALL 0x0x8d4ce3e4;
8d4e0a3c:	56 2f       	JUMP.S 0x0x8d4e08e8;
8d4e0a3e:	00 00       	NOP;
8d4e0a40:	00 e8 59 00 	LINK 0x164;		/* (356) */
8d4e0a44:	e5 05       	[--SP] = (R7:4, P5:5);
8d4e0a46:	86 6f       	SP += -0x10;		/* (-16) */
8d4e0a48:	40 64       	R0 += 0x8;		/* (  8) */
8d4e0a4a:	82 ce 01 ce 	R7 = ROT R1 BY 0x0 || [FP -0x10] = R1 || NOP;
8d4e0a4e:	c1 bb 00 00 
8d4e0a52:	01 da 03 84 	R1=-2080152784;
8d4e0a56:	30 63 00 00 
8d4e0a5a:	d0 bb       	[FP -0xc] = R0;
8d4e0a5c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0a60:	14 33 00 00 
8d4e0a64:	26 e1 5c 00 	R6 = 0x5c (X);		/*		R6=0x5c( 92) */
8d4e0a68:	56 30       	R2 = SP;
8d4e0a6a:	b2 50       	R2 = R2 + R6;
8d4e0a6c:	82 ce 00 c2 	R1 = ROT R0 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d4e0a70:	ba b0 00 00 
8d4e0a74:	25 e1 68 00 	R5 = 0x68 (X);		/*		R5=0x68(104) */
8d4e0a78:	24 e1 74 00 	R4 = 0x74 (X);		/*		R4=0x74(116) */
8d4e0a7c:	26 e1 78 00 	R6 = 0x78 (X);		/*		R6=0x78(120) */
8d4e0a80:	b8 a0       	R0 = [FP + 0x8];
8d4e0a82:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4e0a86:	f0 2b 00 00 
8d4e0a8a:	5e 30       	R3 = SP;
8d4e0a8c:	eb 50       	R3 = R3 + R5;
8d4e0a8e:	04 cc 2d 4a 	R5 = R5 - R5 (NS) || [FP -0x8] = R3 || NOP;
8d4e0a92:	e3 bb 00 00 
8d4e0a96:	31 60       	R1 = 0x6 (X);		/*		R1=0x0(  0) */
8d4e0a98:	0d da 03 84 	P5=-2080151712;
8d4e0a9c:	60 67 00 00 
8d4e0aa0:	e0 b9       	R0 = [FP -0x8];
8d4e0aa2:	00 de 05 8c 	CALL.A 0x8c053038;
8d4e0aa6:	38 30 00 00 
8d4e0aaa:	56 30       	R2 = SP;
8d4e0aac:	22 50       	R0 = R2 + R4;
8d4e0aae:	0f 30       	R1 = R7;
8d4e0ab0:	ff e3 36 fe 	CALL 0x0x8d4e071c;
8d4e0ab4:	31 e4 23 00 	R1 = [SP + 0x8c];
8d4e0ab8:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d4e0aba:	5e 30       	R3 = SP;
8d4e0abc:	0f 0a       	CC = R7 <= R1 (IU);
8d4e0abe:	33 50       	R0 = R3 + R6;
8d4e0ac0:	32 e4 1e 00 	R2 = [SP + 0x78];
8d4e0ac4:	02 07       	IF CC R0 = R2;
8d4e0ac6:	00 de 03 8c 	CALL.A 0x8c03e328;
8d4e0aca:	28 e3 00 00 
8d4e0ace:	00 0c       	CC = R0 == 0x0;
8d4e0ad0:	38 30       	R7 = R0;
8d4e0ad2:	03 14       	IF !CC JUMP 0x0x8d4e0ad8 (BP);
8d4e0ad4:	32 22       	JUMP.S 0x0x8d4e0f38;
8d4e0ad6:	00 00       	NOP;
8d4e0ad8:	20 e1 98 00 	R0 = 0x98 (X);		/*		R0=0x98(152) */
8d4e0adc:	01 da 03 84 	R1=-2080152784;
8d4e0ae0:	30 63 00 00 
8d4e0ae4:	01 50       	R0 = R1 + R0;
8d4e0ae6:	38 b1       	[FP + 0x10] = R0;
8d4e0ae8:	06 60       	R6 = 0x0 (X);		/*		R6=0x78(120) */
8d4e0aea:	06 30       	R0 = R6;
8d4e0aec:	c1 60       	R1 = 0x18 (X);		/*		R1=0x0(  0) */
8d4e0aee:	08 64       	R0 += 0x1;		/* (  1) */
8d4e0af0:	8e 08       	CC = R6 < R1;
8d4e0af2:	03 c8 00 18 	MNOP || [FP + 0xc] = R0 || R0 = [FP + 0x8];
8d4e0af6:	f8 b0 b8 a0 
8d4e0afa:	92 11       	IF !CC JUMP 0x0x8d4e0e1e;
8d4e0afc:	00 de 05 8c 	CALL.A 0x8c052382;
8d4e0b00:	82 23 00 00 
8d4e0b04:	30 0a       	CC = R0 <= R6 (IU);
8d4e0b06:	8c 19       	IF CC JUMP 0x0x8d4e0e1e;
8d4e0b08:	56 30       	R2 = SP;
8d4e0b0a:	27 e1 c4 00 	R7 = 0xc4 (X);		/*		R7=0xc4(196) */
8d4e0b0e:	5e 30       	R3 = SP;
8d4e0b10:	24 e1 d0 00 	R4 = 0xd0 (X);		/*		R4=0xd0(208) */
8d4e0b14:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || R0 = [FP + 0x8] || NOP;
8d4e0b18:	b8 a0 00 00 
8d4e0b1c:	fa 51       	R7 = R2 + R7;
8d4e0b1e:	a3 51       	R6 = R3 + R4;
8d4e0b20:	00 de 05 8c 	CALL.A 0x8c0530e4;
8d4e0b24:	e4 30 00 00 
8d4e0b28:	08 30       	R1 = R0;
8d4e0b2a:	07 30       	R0 = R7;
8d4e0b2c:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4e0b30:	f0 2b 00 00 
8d4e0b34:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d4e0b38:	39 a1 00 00 
8d4e0b3c:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0b40:	14 33 00 00 
8d4e0b44:	08 30       	R1 = R0;
8d4e0b46:	06 30       	R0 = R6;
8d4e0b48:	00 de 05 8c 	CALL.A 0x8c051cca;
8d4e0b4c:	ca 1c 00 00 
8d4e0b50:	06 30       	R0 = R6;
8d4e0b52:	ff e3 47 fe 	CALL 0x0x8d4e07e0;
8d4e0b56:	00 0c       	CC = R0 == 0x0;
8d4e0b58:	79 18       	IF CC JUMP 0x0x8d4e0c4a;
8d4e0b5a:	56 30       	R2 = SP;
8d4e0b5c:	24 e1 24 01 	R4 = 0x124 (X);		/*		R4=0x124(292) */
8d4e0b60:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP + 0x10] || NOP;
8d4e0b64:	39 a1 00 00 
8d4e0b68:	22 51       	R4 = R2 + R4;
8d4e0b6a:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0b6e:	14 33 00 00 
8d4e0b72:	23 e1 7c 00 	R3 = 0x7c (X);		/*		R3=0x7c(124) */
8d4e0b76:	04 cc 33 00 	R0 = R6 + R3 (NS) || [FP -0x4] = R0 || NOP;
8d4e0b7a:	f0 bb 00 00 
8d4e0b7e:	0e 30       	R1 = R6;
8d4e0b80:	06 e3 98 1b 	CALL 0x0x8d5a42b0;
8d4e0b84:	4f 30       	R1 = FP;
8d4e0b86:	21 66       	R1 += -0x3c;		/* (-60) */
8d4e0b88:	01 30       	R0 = R1;
8d4e0b8a:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e0b8c:	06 e3 a2 1a 	CALL 0x0x8d5a40d0;
8d4e0b90:	56 30       	R2 = SP;
8d4e0b92:	23 e1 30 01 	R3 = 0x130 (X);		/*		R3=0x130(304) */
8d4e0b96:	5a 50       	R1 = R2 + R3;
8d4e0b98:	01 30       	R0 = R1;
8d4e0b9a:	a0 67       	R0 += -0xc;		/* (-12) */
8d4e0b9c:	00 de 05 8c 	CALL.A 0x8c0519e4;
8d4e0ba0:	e4 19 00 00 
8d4e0ba4:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x4] || NOP;
8d4e0ba8:	f0 b9 00 00 
8d4e0bac:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0bb0:	10 1b 00 00 
8d4e0bb4:	04 30       	R0 = R4;
8d4e0bb6:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0bba:	38 1a 00 00 
8d4e0bbe:	00 b9       	R0 = [FP -0x40];
8d4e0bc0:	82 60       	R2 = 0x10 (X);		/*		R2=0x0(  0) */
8d4e0bc2:	02 0a       	CC = R2 <= R0 (IU);
8d4e0bc4:	3f 18       	IF CC JUMP 0x0x8d4e0c42;
8d4e0bc6:	03 c8 00 18 	MNOP || R0 = [FP -0x24] || [FP -0x44] = R5;
8d4e0bca:	70 b9 f5 ba 
8d4e0bce:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0bd0:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
8d4e0bd2:	01 0a       	CC = R1 <= R0 (IU);
8d4e0bd4:	b5 e6 34 01 	B[SP + 0x134] = R5;
8d4e0bd8:	03 c8 00 18 	MNOP || [FP -0x40] = R2 || R0 = [FP -0x38];
8d4e0bdc:	02 bb 20 b9 
8d4e0be0:	2e 18       	IF CC JUMP 0x0x8d4e0c3c;
8d4e0be2:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
8d4e0be4:	20 e1 a4 ff 	R0 = -0x5c (X);		/*		R0=0xffffffa4(-92) */
8d4e0be8:	b5 e6 50 01 	B[SP + 0x150] = R5;
8d4e0bec:	04 cc 38 00 	R0 = R7 + R0 (NS) || [FP -0x28] = R5 || NOP;
8d4e0bf0:	65 bb 00 00 
8d4e0bf4:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [FP -0x24] = R2 || NOP;
8d4e0bf8:	72 bb 00 00 
8d4e0bfc:	00 de 05 8c 	CALL.A 0x8c0531e4;
8d4e0c00:	e4 31 00 00 
8d4e0c04:	30 e4 3a 00 	R0 = [SP + 0xe8];
8d4e0c08:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0c0a:	01 0a       	CC = R1 <= R0 (IU);
8d4e0c0c:	12 18       	IF CC JUMP 0x0x8d4e0c30;
8d4e0c0e:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0c10:	30 e6 3a 00 	[SP + 0xe8] = R0;
8d4e0c14:	35 e6 39 00 	[SP + 0xe4] = R5;
8d4e0c18:	b5 e6 d4 00 	B[SP + 0xd4] = R5;
8d4e0c1c:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R6 = [FP + 0xc] || NOP;
8d4e0c20:	fe a0 00 00 
8d4e0c24:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0c28:	38 1a 00 00 
8d4e0c2c:	5f 2f       	JUMP.S 0x0x8d4e0aea;
8d4e0c2e:	00 00       	NOP;
8d4e0c30:	30 e4 35 00 	R0 = [SP + 0xd4];
8d4e0c34:	ff e3 d8 6b 	CALL 0x0x8d4ce3e4;
8d4e0c38:	eb 2f       	JUMP.S 0x0x8d4e0c0e;
8d4e0c3a:	00 00       	NOP;
8d4e0c3c:	ff e3 d4 6b 	CALL 0x0x8d4ce3e4;
8d4e0c40:	d1 2f       	JUMP.S 0x0x8d4e0be2;
8d4e0c42:	b0 b8       	R0 = [FP -0x54];
8d4e0c44:	ff e3 d0 6b 	CALL 0x0x8d4ce3e4;
8d4e0c48:	bf 2f       	JUMP.S 0x0x8d4e0bc6;
8d4e0c4a:	06 30       	R0 = R6;
8d4e0c4c:	0e 30       	R1 = R6;
8d4e0c4e:	e0 64       	R0 += 0x1c;		/* ( 28) */
8d4e0c50:	06 e3 30 1b 	CALL 0x0x8d5a42b0;
8d4e0c54:	4e 30       	R1 = SP;
8d4e0c56:	22 e1 ec 00 	R2 = 0xec (X);		/*		R2=0xec(236) */
8d4e0c5a:	91 50       	R2 = R1 + R2;
8d4e0c5c:	24 e1 88 ff 	R4 = -0x78 (X);		/*		R4=0xffffff88(-120) */
8d4e0c60:	62 50       	R1 = R2 + R4;
8d4e0c62:	23 e1 94 00 	R3 = 0x94 (X);		/*		R3=0x94(148) */
8d4e0c66:	19 50       	R0 = R1 + R3;
8d4e0c68:	ff e3 94 fd 	CALL 0x0x8d4e0790;
8d4e0c6c:	03 c8 00 18 	MNOP || R2 = [FP -0x68] || R1 = [FP -0x7c];
8d4e0c70:	62 b8 11 b8 
8d4e0c74:	84 60       	R4 = 0x10 (X);		/*		R4=0xffffff88(-120) */
8d4e0c76:	5e 30       	R3 = SP;
8d4e0c78:	20 e1 0c 01 	R0 = 0x10c (X);		/*		R0=0x10c(268) */
8d4e0c7c:	14 0a       	CC = R4 <= R2 (IU);
8d4e0c7e:	03 50       	R0 = R3 + R0;
8d4e0c80:	01 07       	IF CC R0 = R1;
8d4e0c82:	00 de 03 8c 	CALL.A 0x8c03e29c;
8d4e0c86:	9c e2 00 00 
8d4e0c8a:	00 0c       	CC = R0 == 0x0;
8d4e0c8c:	5c 10       	IF !CC JUMP 0x0x8d4e0d44;
8d4e0c8e:	32 e4 41 00 	R2 = [SP + 0x104];
8d4e0c92:	83 60       	R3 = 0x10 (X);		/*		R3=0x94(148) */
8d4e0c94:	13 0a       	CC = R3 <= R2 (IU);
8d4e0c96:	4e 30       	R1 = SP;
8d4e0c98:	24 e1 0c 01 	R4 = 0x10c (X);		/*		R4=0x10c(268) */
8d4e0c9c:	46 30       	R0 = SP;
8d4e0c9e:	22 e1 f0 00 	R2 = 0xf0 (X);		/*		R2=0xf0(240) */
8d4e0ca2:	04 cc 0c 02 	R1 = R1 + R4 (NS) || R3 = [FP -0x68] || NOP;
8d4e0ca6:	63 b8 00 00 
8d4e0caa:	04 cc 02 00 	R0 = R0 + R2 (NS) || R2 = [FP -0x7c] || NOP;
8d4e0cae:	12 b8 00 00 
8d4e0cb2:	34 e4 3c 00 	R4 = [SP + 0xf0];
8d4e0cb6:	04 07       	IF CC R0 = R4;
8d4e0cb8:	84 60       	R4 = 0x10 (X);		/*		R4=0x10c(268) */
8d4e0cba:	1c 0a       	CC = R4 <= R3 (IU);
8d4e0cbc:	0a 07       	IF CC R1 = R2;
8d4e0cbe:	02 60       	R2 = 0x0 (X);		/*		R2=0xf0(240) */
8d4e0cc0:	00 de 03 8c 	CALL.A 0x8c03e0e4;
8d4e0cc4:	e4 e0 00 00 
8d4e0cc8:	00 0c       	CC = R0 == 0x0;
8d4e0cca:	3d 10       	IF !CC JUMP 0x0x8d4e0d44;
8d4e0ccc:	00 d8 b0 11 	LdStAbs addr=0x11b01efc control=0x0000;
8d4e0cd0:	fc 1e 00 00 
8d4e0cd4:	98 0c       	CC = R0 < 0x3;
8d4e0cd6:	2a 10       	IF !CC JUMP 0x0x8d4e0d2a;
8d4e0cd8:	60 b8       	R0 = [FP -0x68];
8d4e0cda:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0cdc:	01 0a       	CC = R1 <= R0 (IU);
8d4e0cde:	22 18       	IF CC JUMP 0x0x8d4e0d22;
8d4e0ce0:	78 60       	R0 = 0xf (X);		/*		R0=0x10c(268) */
8d4e0ce2:	60 ba       	[FP -0x68] = R0;
8d4e0ce4:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0ce6:	30 e4 41 00 	R0 = [SP + 0x104];
8d4e0cea:	01 0a       	CC = R1 <= R0 (IU);
8d4e0cec:	55 ba       	[FP -0x6c] = R5;
8d4e0cee:	b5 e6 0c 01 	B[SP + 0x10c] = R5;
8d4e0cf2:	13 18       	IF CC JUMP 0x0x8d4e0d18;
8d4e0cf4:	78 60       	R0 = 0xf (X);		/*		R0=0x10c(268) */
8d4e0cf6:	30 e6 41 00 	[SP + 0x104] = R0;
8d4e0cfa:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0cfc:	30 e4 3a 00 	R0 = [SP + 0xe8];
8d4e0d00:	01 0a       	CC = R1 <= R0 (IU);
8d4e0d02:	35 e6 40 00 	[SP + 0x100] = R5;
8d4e0d06:	b5 e6 f0 00 	B[SP + 0xf0] = R5;
8d4e0d0a:	82 17       	IF !CC JUMP 0x0x8d4e0c0e (BP);
8d4e0d0c:	30 e4 35 00 	R0 = [SP + 0xd4];
8d4e0d10:	ff e3 6a 6b 	CALL 0x0x8d4ce3e4;
8d4e0d14:	7d 2f       	JUMP.S 0x0x8d4e0c0e;
8d4e0d16:	00 00       	NOP;
8d4e0d18:	30 e4 3c 00 	R0 = [SP + 0xf0];
8d4e0d1c:	ff e3 64 6b 	CALL 0x0x8d4ce3e4;
8d4e0d20:	ea 2f       	JUMP.S 0x0x8d4e0cf4;
8d4e0d22:	10 b8       	R0 = [FP -0x7c];
8d4e0d24:	ff e3 60 6b 	CALL 0x0x8d4ce3e4;
8d4e0d28:	dc 2f       	JUMP.S 0x0x8d4e0ce0;
8d4e0d2a:	f5 bc       	[SP + 0xc] = P5;
8d4e0d2c:	22 e1 79 02 	R2 = 0x279 (X);		/*		R2=0x279(633) */
8d4e0d30:	01 da 03 84 	R1=-2080152232;
8d4e0d34:	58 65 00 00 
8d4e0d38:	18 60       	R0 = 0x3 (X);		/*		R0=0x10c(268) */
8d4e0d3a:	00 de 04 8c 	CALL.A 0x8c040574;
8d4e0d3e:	74 05 00 00 
8d4e0d42:	cb 2f       	JUMP.S 0x0x8d4e0cd8;
8d4e0d44:	46 30       	R0 = SP;
8d4e0d46:	22 e1 9c 00 	R2 = 0x9c (X);		/*		R2=0x9c(156) */
8d4e0d4a:	04 cc 02 08 	R4 = R0 + R2 (NS) || R1 = [FP + 0x10] || NOP;
8d4e0d4e:	39 a1 00 00 
8d4e0d52:	07 30       	R0 = R7;
8d4e0d54:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0d58:	14 33 00 00 
8d4e0d5c:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [FP -0x4] = R0 || NOP;
8d4e0d60:	f0 bb 00 00 
8d4e0d64:	c6 66       	R6 += -0x28;		/* (-40) */
8d4e0d66:	06 30       	R0 = R6;
8d4e0d68:	06 e3 a6 1c 	CALL 0x0x8d5a46b4;
8d4e0d6c:	56 30       	R2 = SP;
8d4e0d6e:	23 e1 a8 00 	R3 = 0xa8 (X);		/*		R3=0xa8(168) */
8d4e0d72:	5a 50       	R1 = R2 + R3;
8d4e0d74:	01 30       	R0 = R1;
8d4e0d76:	a0 67       	R0 += -0xc;		/* (-12) */
8d4e0d78:	00 de 05 8c 	CALL.A 0x8c0519e4;
8d4e0d7c:	e4 19 00 00 
8d4e0d80:	82 ce 04 c2 	R1 = ROT R4 BY 0x0 || R0 = [FP -0x4] || NOP;
8d4e0d84:	f0 b9 00 00 
8d4e0d88:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0d8c:	10 1b 00 00 
8d4e0d90:	04 30       	R0 = R4;
8d4e0d92:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0d96:	38 1a 00 00 
8d4e0d9a:	30 e4 30 00 	R0 = [SP + 0xc0];
8d4e0d9e:	82 60       	R2 = 0x10 (X);		/*		R2=0x9c(156) */
8d4e0da0:	02 0a       	CC = R2 <= R0 (IU);
8d4e0da2:	39 18       	IF CC JUMP 0x0x8d4e0e14;
8d4e0da4:	7a 60       	R2 = 0xf (X);		/*		R2=0x9c(156) */
8d4e0da6:	20 e1 a4 ff 	R0 = -0x5c (X);		/*		R0=0xffffffa4(-92) */
8d4e0daa:	35 e6 2f 00 	[SP + 0xbc] = R5;
8d4e0dae:	b5 e6 ac 00 	B[SP + 0xac] = R5;
8d4e0db2:	32 e6 30 00 	[SP + 0xc0] = R2;
8d4e0db6:	07 50       	R0 = R7 + R0;
8d4e0db8:	0f 30       	R1 = R7;
8d4e0dba:	00 de 05 8c 	CALL.A 0x8c0531e4;
8d4e0dbe:	e4 31 00 00 
8d4e0dc2:	60 b8       	R0 = [FP -0x68];
8d4e0dc4:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0dc6:	01 0a       	CC = R1 <= R0 (IU);
8d4e0dc8:	21 18       	IF CC JUMP 0x0x8d4e0e0a;
8d4e0dca:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0dcc:	60 ba       	[FP -0x68] = R0;
8d4e0dce:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0dd0:	30 e4 41 00 	R0 = [SP + 0x104];
8d4e0dd4:	01 0a       	CC = R1 <= R0 (IU);
8d4e0dd6:	55 ba       	[FP -0x6c] = R5;
8d4e0dd8:	b5 e6 0c 01 	B[SP + 0x10c] = R5;
8d4e0ddc:	12 18       	IF CC JUMP 0x0x8d4e0e00;
8d4e0dde:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0de0:	30 e6 41 00 	[SP + 0x104] = R0;
8d4e0de4:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0de6:	30 e4 3a 00 	R0 = [SP + 0xe8];
8d4e0dea:	01 0a       	CC = R1 <= R0 (IU);
8d4e0dec:	35 e6 40 00 	[SP + 0x100] = R5;
8d4e0df0:	b5 e6 f0 00 	B[SP + 0xf0] = R5;
8d4e0df4:	0d 17       	IF !CC JUMP 0x0x8d4e0c0e (BP);
8d4e0df6:	30 e4 35 00 	R0 = [SP + 0xd4];
8d4e0dfa:	ff e3 f5 6a 	CALL 0x0x8d4ce3e4;
8d4e0dfe:	08 2f       	JUMP.S 0x0x8d4e0c0e;
8d4e0e00:	30 e4 3c 00 	R0 = [SP + 0xf0];
8d4e0e04:	ff e3 f0 6a 	CALL 0x0x8d4ce3e4;
8d4e0e08:	eb 2f       	JUMP.S 0x0x8d4e0dde;
8d4e0e0a:	10 b8       	R0 = [FP -0x7c];
8d4e0e0c:	ff e3 ec 6a 	CALL 0x0x8d4ce3e4;
8d4e0e10:	dd 2f       	JUMP.S 0x0x8d4e0dca;
8d4e0e12:	00 00       	NOP;
8d4e0e14:	30 e4 2b 00 	R0 = [SP + 0xac];
8d4e0e18:	ff e3 e6 6a 	CALL 0x0x8d4ce3e4;
8d4e0e1c:	c4 2f       	JUMP.S 0x0x8d4e0da4;
8d4e0e1e:	46 30       	R0 = SP;
8d4e0e20:	22 e1 90 00 	R2 = 0x90 (X);		/*		R2=0x90(144) */
8d4e0e24:	04 cc 02 0c 	R6 = R0 + R2 (NS) || R1 = [FP -0xc] || NOP;
8d4e0e28:	d1 b9 00 00 
8d4e0e2c:	06 30       	R0 = R6;
8d4e0e2e:	00 de 05 8c 	CALL.A 0x8c052bf0;
8d4e0e32:	f0 2b 00 00 
8d4e0e36:	06 30       	R0 = R6;
8d4e0e38:	01 da 03 84 	R1=-2080152784;
8d4e0e3c:	30 63 00 00 
8d4e0e40:	00 de 05 8c 	CALL.A 0x8c053314;
8d4e0e44:	14 33 00 00 
8d4e0e48:	e1 b9       	R1 = [FP -0x8];
8d4e0e4a:	00 de 05 8c 	CALL.A 0x8c051b10;
8d4e0e4e:	10 1b 00 00 
8d4e0e52:	7c 60       	R4 = 0xf (X);		/*		R4=0x10c(268) */
8d4e0e54:	56 30       	R2 = SP;
8d4e0e56:	23 e1 40 00 	R3 = 0x40 (X);		/*		R3=0x40( 64) */
8d4e0e5a:	34 e6 16 00 	[SP + 0x58] = R4;
8d4e0e5e:	da 51       	R7 = R2 + R3;
8d4e0e60:	01 da 03 84 	R1=-2080152784;
8d4e0e64:	30 63 00 00 
8d4e0e68:	24 e1 0c 02 	R4 = 0x20c (X);		/*		R4=0x20c(524) */
8d4e0e6c:	35 e6 15 00 	[SP + 0x54] = R5;
8d4e0e70:	b5 e6 44 00 	B[SP + 0x44] = R5;
8d4e0e74:	61 50       	R1 = R1 + R4;
8d4e0e76:	07 30       	R0 = R7;
8d4e0e78:	00 de 09 8c 	CALL.A 0x8c09a376;
8d4e0e7c:	76 a3 00 00 
8d4e0e80:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || R1 = [FP -0x10] || NOP;
8d4e0e84:	c1 b9 00 00 
8d4e0e88:	17 30       	R2 = R7;
8d4e0e8a:	20 67       	R0 += -0x1c;		/* (-28) */
8d4e0e8c:	ff e3 82 fc 	CALL 0x0x8d4e0790;
8d4e0e90:	23 e1 94 ff 	R3 = -0x6c (X);		/*		R3=0xffffff94(-108) */
8d4e0e94:	1e 50       	R0 = R6 + R3;
8d4e0e96:	0e 30       	R1 = R6;
8d4e0e98:	00 de 03 8c 	CALL.A 0x8c03f624;
8d4e0e9c:	24 f6 00 00 
8d4e0ea0:	82 ce 00 ce 	R7 = ROT R0 BY 0x0 || R0 = [SP + 0x3c] || NOP;
8d4e0ea4:	f0 a3 00 00 
8d4e0ea8:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0eaa:	01 0a       	CC = R1 <= R0 (IU);
8d4e0eac:	41 18       	IF CC JUMP 0x0x8d4e0f2e;
8d4e0eae:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0eb0:	f0 b3       	[SP + 0x3c] = R0;
8d4e0eb2:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0eb4:	30 e4 16 00 	R0 = [SP + 0x58];
8d4e0eb8:	01 0a       	CC = R1 <= R0 (IU);
8d4e0eba:	b5 b3       	[SP + 0x38] = R5;
8d4e0ebc:	b5 e6 28 00 	B[SP + 0x28] = R5;
8d4e0ec0:	32 18       	IF CC JUMP 0x0x8d4e0f24;
8d4e0ec2:	78 60       	R0 = 0xf (X);		/*		R0=0xffffffa4(-92) */
8d4e0ec4:	30 e6 16 00 	[SP + 0x58] = R0;
8d4e0ec8:	35 e6 15 00 	[SP + 0x54] = R5;
8d4e0ecc:	b5 e6 44 00 	B[SP + 0x44] = R5;
8d4e0ed0:	06 30       	R0 = R6;
8d4e0ed2:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0ed6:	38 1a 00 00 
8d4e0eda:	30 e4 23 00 	R0 = [SP + 0x8c];
8d4e0ede:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d4e0ee0:	01 0a       	CC = R1 <= R0 (IU);
8d4e0ee2:	1b 18       	IF CC JUMP 0x0x8d4e0f18;
8d4e0ee4:	04 cc 09 42 	R1 = R1 - R1 (NS) || R0 = [FP -0x8] || NOP;
8d4e0ee8:	e0 b9 00 00 
8d4e0eec:	7a 60       	R2 = 0xf (X);		/*		R2=0x90(144) */
8d4e0eee:	31 e6 22 00 	[SP + 0x88] = R1;
8d4e0ef2:	b1 e6 78 00 	B[SP + 0x78] = R1;
8d4e0ef6:	32 e6 23 00 	[SP + 0x8c] = R2;
8d4e0efa:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0efe:	38 1a 00 00 
8d4e0f02:	b8 a0       	R0 = [FP + 0x8];
8d4e0f04:	00 de 05 8c 	CALL.A 0x8c051a38;
8d4e0f08:	38 1a 00 00 
8d4e0f0c:	86 6c       	SP += 0x10;		/* ( 16) */
8d4e0f0e:	07 30       	R0 = R7;
8d4e0f10:	a5 05       	(R7:4, P5:5) = [SP++];
8d4e0f12:	01 e8 00 00 	UNLINK;
8d4e0f16:	10 00       	RTS;
8d4e0f18:	30 e4 1e 00 	R0 = [SP + 0x78];
8d4e0f1c:	ff e3 64 6a 	CALL 0x0x8d4ce3e4;
8d4e0f20:	e2 2f       	JUMP.S 0x0x8d4e0ee4;
8d4e0f22:	00 00       	NOP;
8d4e0f24:	30 e4 11 00 	R0 = [SP + 0x44];
8d4e0f28:	ff e3 5e 6a 	CALL 0x0x8d4ce3e4;
