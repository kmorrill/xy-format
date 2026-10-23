
/Users/kevinmorrill/Documents/OP-XY Backups/2026-10-23/analysis/segment-8d591de0.bin:     file format binary


Disassembly of section .data:

8d5a4638 <.data+0x12858>:
8d5a4638:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a463c:	70 05       	[--SP] = (R7:6);
8d5a463e:	86 6f       	SP += -0x10;		/* (-16) */
8d5a4640:	38 30       	R7 = R0;
8d5a4642:	01 30       	R0 = R1;
8d5a4644:	31 30       	R6 = R1;
8d5a4646:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d5a464a:	b8 00 02 00 
8d5a464e:	79 61       	R1 = 0x2f (X);		/*		R1=0x0(  0) */
8d5a4650:	ff e3 ac ff 	CALL 0x0x8d5a45a8;
8d5a4654:	00 0c       	CC = R0 == 0x0;
8d5a4656:	01 da 0a 84 	R1=-2079689392;
8d5a465a:	50 75 00 00 
8d5a465e:	20 18       	IF CC JUMP 0x0x8d5a469e;
8d5a4660:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d5a4664:	b8 00 02 00 
8d5a4668:	10 08       	CC = R0 == R2;
8d5a466a:	0b 10       	IF !CC JUMP 0x0x8d5a4680;
8d5a466c:	07 30       	R0 = R7;
8d5a466e:	00 de 03 8c 	CALL.A 0x8c03ee00;
8d5a4672:	00 ee 00 00 
8d5a4676:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a4678:	30 05       	(R7:6) = [SP++];
8d5a467a:	01 e8 00 00 	UNLINK;
8d5a467e:	10 00       	RTS;
8d5a4680:	82 ce 06 c2 	R1 = ROT R6 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d5a4684:	f0 b0 00 00 
8d5a4688:	07 30       	R0 = R7;
8d5a468a:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a468c:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d5a4690:	a6 ec 00 00 
8d5a4694:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a4696:	30 05       	(R7:6) = [SP++];
8d5a4698:	01 e8 00 00 	UNLINK;
8d5a469c:	10 00       	RTS;
8d5a469e:	07 30       	R0 = R7;
8d5a46a0:	e1 67       	R1 += -0x4;		/* ( -4) */
8d5a46a2:	00 de 03 8c 	CALL.A 0x8c03ee00;
8d5a46a6:	00 ee 00 00 
8d5a46aa:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a46ac:	30 05       	(R7:6) = [SP++];
8d5a46ae:	01 e8 00 00 	UNLINK;
8d5a46b2:	10 00       	RTS;
8d5a46b4:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d5a46b8:	ed 05       	[--SP] = (R7:5, P5:5);
8d5a46ba:	86 6f       	SP += -0x10;		/* (-16) */
8d5a46bc:	28 32       	P5 = R0;
8d5a46be:	30 30       	R6 = R0;
8d5a46c0:	01 30       	R0 = R1;
8d5a46c2:	39 30       	R7 = R1;
8d5a46c4:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d5a46c8:	b8 00 02 00 
8d5a46cc:	79 61       	R1 = 0x2f (X);		/*		R1=0x0(  0) */
8d5a46ce:	ff e3 6d ff 	CALL 0x0x8d5a45a8;
8d5a46d2:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d5a46d6:	b8 00 01 00 
8d5a46da:	08 08       	CC = R0 == R1;
8d5a46dc:	1a 10       	IF !CC JUMP 0x0x8d5a4710;
8d5a46de:	05 60       	R5 = 0x0 (X);		/*		R5=0x0(  0) */
8d5a46e0:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [P5 + 0x14] = R5 || NOP;
8d5a46e4:	6d b1 00 00 
8d5a46e8:	ad e6 04 00 	B[P5 + 0x4] = R5;
8d5a46ec:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d5a46ee:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [P5 + 0x18] = R0 || NOP;
8d5a46f2:	a8 b1 00 00 
8d5a46f6:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d5a46fa:	b8 00 02 00 
8d5a46fe:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R2 || NOP;
8d5a4702:	f2 b0 00 00 
8d5a4706:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a470a:	70 e9 00 00 
8d5a470e:	24 20       	JUMP.S 0x0x8d5a4756;
8d5a4710:	08 64       	R0 += 0x1;		/* (  1) */
8d5a4712:	82 ce 00 c4 	R2 = ROT R0 BY 0x0 || [SP + 0xc] = R1 || NOP;
8d5a4716:	f1 b0 00 00 
8d5a471a:	0f 30       	R1 = R7;
8d5a471c:	7f 30       	R7 = FP;
8d5a471e:	27 67       	R7 += -0x1c;		/* (-28) */
8d5a4720:	07 30       	R0 = R7;
8d5a4722:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d5a4726:	a6 ec 00 00 
8d5a472a:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a472c:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [P5 + 0x14] = R2 || NOP;
8d5a4730:	6a b1 00 00 
8d5a4734:	aa e6 04 00 	B[P5 + 0x4] = R2;
8d5a4738:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d5a473a:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [P5 + 0x18] = R0 || NOP;
8d5a473e:	a8 b1 00 00 
8d5a4742:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a4746:	b8 00 03 00 
8d5a474a:	f3 b0       	[SP + 0xc] = R3;
8d5a474c:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a4750:	70 e9 00 00 
8d5a4754:	0d 60       	R5 = 0x1 (X);		/*		R5=0x0(  0) */
8d5a4756:	05 0c       	CC = R5 == 0x0;
8d5a4758:	0d 18       	IF CC JUMP 0x0x8d5a4772;
8d5a475a:	b0 a3       	R0 = [SP + 0x38];
8d5a475c:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d5a475e:	01 0a       	CC = R1 <= R0 (IU);
8d5a4760:	0e 18       	IF CC JUMP 0x0x8d5a477c;
8d5a4762:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a4764:	b0 e6 24 00 	B[SP + 0x24] = R0;
8d5a4768:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a476a:	ad 05       	(R7:5, P5:5) = [SP++];
8d5a476c:	01 e8 00 00 	UNLINK;
8d5a4770:	10 00       	RTS;
8d5a4772:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a4774:	ad 05       	(R7:5, P5:5) = [SP++];
8d5a4776:	01 e8 00 00 	UNLINK;
8d5a477a:	10 00       	RTS;
8d5a477c:	70 a2       	R0 = [SP + 0x24];
8d5a477e:	f9 e3 33 4e 	CALL 0x0x8d4ce3e4;
8d5a4782:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a4784:	b0 e6 24 00 	B[SP + 0x24] = R0;
8d5a4788:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a478a:	ad 05       	(R7:5, P5:5) = [SP++];
8d5a478c:	01 e8 00 00 	UNLINK;
8d5a4790:	10 00       	RTS;
8d5a4792:	00 00       	NOP;
8d5a4794:	00 00       	NOP;
8d5a4796:	00 00       	NOP;
8d5a4798:	00 e8 07 00 	LINK 0x1c;		/* (28) */
8d5a479c:	f5 05       	[--SP] = (R7:6, P5:5);
8d5a479e:	7f 30       	R7 = FP;
8d5a47a0:	27 67       	R7 += -0x1c;		/* (-28) */
8d5a47a2:	28 32       	P5 = R0;
8d5a47a4:	30 30       	R6 = R0;
8d5a47a6:	86 6f       	SP += -0x10;		/* (-16) */
8d5a47a8:	07 30       	R0 = R7;
8d5a47aa:	ff e3 85 ff 	CALL 0x0x8d5a46b4;
8d5a47ae:	07 30       	R0 = R7;
8d5a47b0:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d5a47b4:	b8 00 02 00 
8d5a47b8:	71 61       	R1 = 0x2e (X);		/*		R1=0x0(  0) */
8d5a47ba:	ff e3 f7 fe 	CALL 0x0x8d5a45a8;
8d5a47be:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d5a47c2:	b8 00 01 00 
8d5a47c6:	08 08       	CC = R0 == R1;
8d5a47c8:	18 10       	IF !CC JUMP 0x0x8d5a47f8;
8d5a47ca:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a47cc:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [P5 + 0x14] = R2 || NOP;
8d5a47d0:	6a b1 00 00 
8d5a47d4:	aa e6 04 00 	B[P5 + 0x4] = R2;
8d5a47d8:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d5a47da:	82 ce 06 c0 	R0 = ROT R6 BY 0x0 || [P5 + 0x18] = R0 || NOP;
8d5a47de:	a8 b1 00 00 
8d5a47e2:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a47e6:	b8 00 03 00 
8d5a47ea:	f3 b0       	[SP + 0xc] = R3;
8d5a47ec:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a47f0:	70 e9 00 00 
8d5a47f4:	0c 20       	JUMP.S 0x0x8d5a480c;
8d5a47f6:	00 00       	NOP;
8d5a47f8:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d5a47fc:	f0 b0 00 00 
8d5a4800:	06 30       	R0 = R6;
8d5a4802:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a4804:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d5a4808:	a6 ec 00 00 
8d5a480c:	70 a3       	R0 = [SP + 0x34];
8d5a480e:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d5a4810:	01 0a       	CC = R1 <= R0 (IU);
8d5a4812:	09 18       	IF CC JUMP 0x0x8d5a4824;
8d5a4814:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a4816:	b0 e6 20 00 	B[SP + 0x20] = R0;
8d5a481a:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a481c:	b5 05       	(R7:6, P5:5) = [SP++];
8d5a481e:	01 e8 00 00 	UNLINK;
8d5a4822:	10 00       	RTS;
8d5a4824:	30 a2       	R0 = [SP + 0x20];
8d5a4826:	f9 e3 df 4d 	CALL 0x0x8d4ce3e4;
8d5a482a:	00 60       	R0 = 0x0 (X);		/*		R0=0x0(  0) */
8d5a482c:	b0 e6 20 00 	B[SP + 0x20] = R0;
8d5a4830:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a4832:	b5 05       	(R7:6, P5:5) = [SP++];
8d5a4834:	01 e8 00 00 	UNLINK;
8d5a4838:	10 00       	RTS;
8d5a483a:	00 00       	NOP;
8d5a483c:	00 00       	NOP;
8d5a483e:	00 00       	NOP;
8d5a4840:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a4844:	70 05       	[--SP] = (R7:6);
8d5a4846:	86 6f       	SP += -0x10;		/* (-16) */
8d5a4848:	38 30       	R7 = R0;
8d5a484a:	01 30       	R0 = R1;
8d5a484c:	31 30       	R6 = R1;
8d5a484e:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0002;
8d5a4852:	b8 00 02 00 
8d5a4856:	71 61       	R1 = 0x2e (X);		/*		R1=0x0(  0) */
8d5a4858:	ff e3 a8 fe 	CALL 0x0x8d5a45a8;
8d5a485c:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0001;
8d5a4860:	b8 00 01 00 
8d5a4864:	08 08       	CC = R0 == R1;
8d5a4866:	11 10       	IF !CC JUMP 0x0x8d5a4888;
8d5a4868:	07 30       	R0 = R7;
8d5a486a:	01 da 0a 84 	R1=-2079689392;
8d5a486e:	50 75 00 00 
8d5a4872:	00 de 03 8c 	CALL.A 0x8c03ee00;
8d5a4876:	00 ee 00 00 
8d5a487a:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a487c:	30 05       	(R7:6) = [SP++];
8d5a487e:	01 e8 00 00 	UNLINK;
8d5a4882:	10 00       	RTS;
8d5a4884:	00 00       	NOP;
8d5a4886:	00 00       	NOP;
8d5a4888:	82 ce 00 c4 	R2 = ROT R0 BY 0x0 || [SP + 0xc] = R1 || NOP;
8d5a488c:	f1 b0 00 00 
8d5a4890:	0e 30       	R1 = R6;
8d5a4892:	07 30       	R0 = R7;
8d5a4894:	00 de 03 8c 	CALL.A 0x8c03eca6;
8d5a4898:	a6 ec 00 00 
8d5a489c:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a489e:	30 05       	(R7:6) = [SP++];
8d5a48a0:	01 e8 00 00 	UNLINK;
8d5a48a4:	10 00       	RTS;
8d5a48a6:	09 32       	P1 = R1;
8d5a48a8:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d5a48ac:	e5 05       	[--SP] = (R7:4, P5:5);
8d5a48ae:	86 6f       	SP += -0x10;		/* (-16) */
8d5a48b0:	82 ce 00 ca 	R5 = ROT R0 BY 0x0 || [FP + 0x8] = R2 || NOP;
8d5a48b4:	ba b0 00 00 
8d5a48b8:	4b a1       	R3 = [P1 + 0x14];
8d5a48ba:	03 0c       	CC = R3 == 0x0;
8d5a48bc:	00 32       	P0 = R0;
8d5a48be:	a6 18       	IF CC JUMP 0x0x8d5a4a0a;
8d5a48c0:	03 32       	P0 = R3;
8d5a48c2:	8f a1       	R7 = [P1 + 0x18];
8d5a48c4:	86 60       	R6 = 0x10 (X);		/*		R6=0x0(  0) */
8d5a48c6:	3e 0a       	CC = R6 <= R7 (IU);
8d5a48c8:	21 6c       	P1 += 0x4;		/* (  4) */
8d5a48ca:	f8 6f       	P0 += -0x1;		/* ( -1) */
8d5a48cc:	02 10       	IF !CC JUMP 0x0x8d5a48d0;
8d5a48ce:	49 91       	P1 = [P1];
8d5a48d0:	41 5a       	P1 = P1 + P0;
8d5a48d2:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R3 = B[P1] (X) || NOP;
8d5a48d6:	4b 99 00 00 
8d5a48da:	7f 61       	R7 = 0x2f (X);		/*		R7=0x0(  0) */
8d5a48dc:	3b 08       	CC = R3 == R7;
8d5a48de:	0b 10       	IF !CC JUMP 0x0x8d5a48f4;
8d5a48e0:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d5a48e4:	e4 f0 00 00 
8d5a48e8:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a48ea:	a5 05       	(R7:4, P5:5) = [SP++];
8d5a48ec:	01 e8 00 00 	UNLINK;
8d5a48f0:	10 00       	RTS;
8d5a48f2:	00 00       	NOP;
8d5a48f4:	b6 e6 44 00 	B[SP + 0x44] = R6;
8d5a48f8:	7f 30       	R7 = FP;
8d5a48fa:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d5a48fe:	b8 00 00 00 
8d5a4902:	27 67       	R7 += -0x1c;		/* (-28) */
8d5a4904:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d5a4906:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0xc] = R0 || NOP;
8d5a490a:	f0 b0 00 00 
8d5a490e:	04 cc 12 44 	R2 = R2 - R2 (NS) || [FP -0x8] = R6 || NOP;
8d5a4912:	e6 bb 00 00 
8d5a4916:	f3 bb       	[FP -0x4] = R3;
8d5a4918:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a491c:	70 e9 00 00 
8d5a4920:	e4 b9       	R4 = [FP -0x8];
8d5a4922:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0000;
8d5a4926:	b8 00 00 00 
8d5a492a:	20 52       	R0 = R0 - R4;
8d5a492c:	08 0e       	CC = R0 <= 0x1 (IU);
8d5a492e:	67 18       	IF CC JUMP 0x0x8d5a49fc;
8d5a4930:	0c 64       	R4 += 0x1;		/* (  1) */
8d5a4932:	07 30       	R0 = R7;
8d5a4934:	0c 30       	R1 = R4;
8d5a4936:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a4938:	00 de 03 8c 	CALL.A 0x8c03e740;
8d5a493c:	40 e7 00 00 
8d5a4940:	00 0c       	CC = R0 == 0x0;
8d5a4942:	1a 18       	IF CC JUMP 0x0x8d5a4976;
8d5a4944:	03 c8 00 18 	MNOP || P2 = [FP -0x18] || R0 = [FP -0x4];
8d5a4948:	aa b9 f0 b9 
8d5a494c:	81 60       	R1 = 0x10 (X);		/*		R1=0x0(  0) */
8d5a494e:	4f 32       	P1 = FP;
8d5a4950:	01 0a       	CC = R1 <= R0 (IU);
8d5a4952:	41 6f       	P1 += -0x18;		/* (-24) */
8d5a4954:	ca 07       	IF CC P1 = P2;
8d5a4956:	ed b9       	P5 = [FP -0x8];
8d5a4958:	78 61       	R0 = 0x2f (X);		/*		R0=0x0(  0) */
8d5a495a:	47 32       	P0 = FP;
8d5a495c:	40 6f       	P0 += -0x18;		/* (-24) */
8d5a495e:	69 5a       	P1 = P1 + P5;
8d5a4960:	08 9b       	B[P1] = R0;
8d5a4962:	03 c8 00 18 	MNOP || P1 = [FP -0x18] || R0 = [FP -0x4];
8d5a4966:	a9 b9 f0 b9 
8d5a496a:	01 0a       	CC = R1 <= R0 (IU);
8d5a496c:	14 32       	P2 = R4;
8d5a496e:	e4 bb       	[FP -0x8] = R4;
8d5a4970:	c1 07       	IF CC P0 = P1;
8d5a4972:	50 5a       	P1 = P0 + P2;
8d5a4974:	0e 9b       	B[P1] = R6;
8d5a4976:	b6 e6 28 00 	B[SP + 0x28] = R6;
8d5a497a:	82 ce 07 c2 	R1 = ROT R7 BY 0x0 || [SP + 0x38] = R6 || NOP;
8d5a497e:	b6 b3 00 00 
8d5a4982:	27 67       	R7 += -0x1c;		/* (-28) */
8d5a4984:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a4988:	b8 00 03 00 
8d5a498c:	7c 60       	R4 = 0xf (X);		/*		R4=0x0(  0) */
8d5a498e:	82 ce 07 c0 	R0 = ROT R7 BY 0x0 || [SP + 0x3c] = R4 || NOP;
8d5a4992:	f4 b3 00 00 
8d5a4996:	04 cc 12 44 	R2 = R2 - R2 (NS) || [SP + 0xc] = R3 || NOP;
8d5a499a:	f3 b0 00 00 
8d5a499e:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a49a2:	70 e9 00 00 
8d5a49a6:	84 60       	R4 = 0x10 (X);		/*		R4=0x0(  0) */
8d5a49a8:	f0 b9       	R0 = [FP -0x4];
8d5a49aa:	04 0a       	CC = R4 <= R0 (IU);
8d5a49ac:	24 18       	IF CC JUMP 0x0x8d5a49f4;
8d5a49ae:	7b 60       	R3 = 0xf (X);		/*		R3=0x0(  0) */
8d5a49b0:	4f 30       	R1 = FP;
8d5a49b2:	82 ce 05 c0 	R0 = ROT R5 BY 0x0 || [FP -0x8] = R6 || R2 = [FP + 0x8];
8d5a49b6:	e6 bb ba a0 
8d5a49ba:	b6 e6 44 00 	B[SP + 0x44] = R6;
8d5a49be:	f3 bb       	[FP -0x4] = R3;
8d5a49c0:	41 66       	R1 += -0x38;		/* (-56) */
8d5a49c2:	00 de 03 8c 	CALL.A 0x8c03f0e4;
8d5a49c6:	e4 f0 00 00 
8d5a49ca:	f0 a3       	R0 = [SP + 0x3c];
8d5a49cc:	83 60       	R3 = 0x10 (X);		/*		R3=0x0(  0) */
8d5a49ce:	03 0a       	CC = R3 <= R0 (IU);
8d5a49d0:	08 18       	IF CC JUMP 0x0x8d5a49e0;
8d5a49d2:	b6 e6 28 00 	B[SP + 0x28] = R6;
8d5a49d6:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a49d8:	a5 05       	(R7:4, P5:5) = [SP++];
8d5a49da:	01 e8 00 00 	UNLINK;
8d5a49de:	10 00       	RTS;
8d5a49e0:	b0 a2       	R0 = [SP + 0x28];
8d5a49e2:	f9 e3 01 4d 	CALL 0x0x8d4ce3e4;
8d5a49e6:	b6 e6 28 00 	B[SP + 0x28] = R6;
8d5a49ea:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a49ec:	a5 05       	(R7:4, P5:5) = [SP++];
8d5a49ee:	01 e8 00 00 	UNLINK;
8d5a49f2:	10 00       	RTS;
8d5a49f4:	a0 b9       	R0 = [FP -0x18];
8d5a49f6:	f9 e3 f7 4c 	CALL 0x0x8d4ce3e4;
8d5a49fa:	da 2f       	JUMP.S 0x0x8d5a49ae;
8d5a49fc:	07 30       	R0 = R7;
8d5a49fe:	00 de ed 8f 	CALL.A 0x8fed519c;
8d5a4a02:	9c 51 00 00 
8d5a4a06:	e4 b9       	R4 = [FP -0x8];
8d5a4a08:	94 2f       	JUMP.S 0x0x8d5a4930;
8d5a4a0a:	7f 60       	R7 = 0xf (X);		/*		R7=0x0(  0) */
8d5a4a0c:	82 ce 02 c2 	R1 = ROT R2 BY 0x0 || [P0 + 0x18] = R7 || NOP;
8d5a4a10:	87 b1 00 00 
8d5a4a14:	43 b1       	[P0 + 0x14] = R3;
8d5a4a16:	83 e6 04 00 	B[P0 + 0x4] = R3;
8d5a4a1a:	00 d8 0c 84 	LdStAbs addr=0x840c00b8 control=0x0003;
8d5a4a1e:	b8 00 03 00 
8d5a4a22:	f3 b0       	[SP + 0xc] = R3;
8d5a4a24:	02 60       	R2 = 0x0 (X);		/*		R2=0x0(  0) */
8d5a4a26:	00 de 03 8c 	CALL.A 0x8c03e970;
8d5a4a2a:	70 e9 00 00 
8d5a4a2e:	86 6c       	SP += 0x10;		/* ( 16) */
8d5a4a30:	a5 05       	(R7:4, P5:5) = [SP++];
8d5a4a32:	01 e8 00 00 	UNLINK;
8d5a4a36:	10 00       	RTS;
8d5a4a38:	00 e8 0e 00 	LINK 0x38;		/* (56) */
8d5a4a3c:	68 05       	[--SP] = (R7:5);
8d5a4a3e:	38 30       	R7 = R0;
8d5a4a40:	47 30       	R0 = FP;
8d5a4a42:	a6 6f       	SP += -0xc;		/* (-12) */
8d5a4a44:	40 66       	R0 += -0x38;		/* (-56) */
8d5a4a46:	77 30       	R6 = FP;
8d5a4a48:	29 30       	R5 = R1;
8d5a4a4a:	ff e3 f7 fd 	CALL 0x0x8d5a4638;
8d5a4a4e:	26 67       	R6 += -0x1c;		/* (-28) */
8d5a4a50:	0d 30       	R1 = R5;
8d5a4a52:	06 30       	R0 = R6;
8d5a4a54:	ff e3 30 fe 	CALL 0x0x8d5a46b4;
8d5a4a58:	0e 30       	R1 = R6;
8d5a4a5a:	07 30       	R0 = R7;
8d5a4a5c:	16 30       	R2 = R6;
8d5a4a5e:	21 67       	R1 += -0x1c;		/* (-28) */
8d5a4a60:	00 de 08 8c 	CALL.A 0x8c084b78;
8d5a4a64:	78 4b 00 00 
8d5a4a68:	87 60       	R7 = 0x10 (X);		/*		R7=0x0(  0) */
8d5a4a6a:	04 cc 36 4c 	R6 = R6 - R6 (NS) || R0 = [FP -0x4] || NOP;
8d5a4a6e:	f0 b9 00 00 
8d5a4a72:	07 0a       	CC = R7 <= R0 (IU);
8d5a4a74:	1a 18       	IF CC JUMP 0x0x8d5a4aa8;
8d5a4a76:	78 60       	R0 = 0xf (X);		/*		R0=0x0(  0) */
8d5a4a78:	f0 bb       	[FP -0x4] = R0;
8d5a4a7a:	30 a3       	R0 = [SP + 0x30];
8d5a4a7c:	07 0a       	CC = R7 <= R0 (IU);
8d5a4a7e:	e6 bb       	[FP -0x8] = R6;
8d5a4a80:	b6 e6 38 00 	B[SP + 0x38] = R6;
8d5a4a84:	08 18       	IF CC JUMP 0x0x8d5a4a94;
8d5a4a86:	b6 e6 1c 00 	B[SP + 0x1c] = R6;
8d5a4a8a:	66 6c       	SP += 0xc;		/* ( 12) */
8d5a4a8c:	28 05       	(R7:5) = [SP++];
8d5a4a8e:	01 e8 00 00 	UNLINK;
8d5a4a92:	10 00       	RTS;
8d5a4a94:	f0 a1       	R0 = [SP + 0x1c];
8d5a4a96:	f9 e3 a7 4c 	CALL 0x0x8d4ce3e4;
8d5a4a9a:	b6 e6 1c 00 	B[SP + 0x1c] = R6;
8d5a4a9e:	66 6c       	SP += 0xc;		/* ( 12) */
8d5a4aa0:	28 05       	(R7:5) = [SP++];
8d5a4aa2:	01 e8 00 00 	UNLINK;
8d5a4aa6:	10 00       	RTS;
8d5a4aa8:	b0 a3       	R0 = [SP + 0x38];
8d5a4aaa:	f9 e3 9d 4c 	CALL 0x0x8d4ce3e4;
8d5a4aae:	e4 2f       	JUMP.S 0x0x8d5a4a76;
8d5a4ab0:	00 e8 00 00 	LINK 0x0;		/* (0) */
8d5a4ab4:	e3 05       	[--SP] = (R7:4, P5:3);
8d5a4ab6:	28 32       	P5 = R0;
8d5a4ab8:	21 32       	P4 = R1;
8d5a4aba:	a6 6f       	SP += -0xc;		/* (-12) */
8d5a4abc:	7a 60       	R2 = 0xf (X);		/*		R2=0x0(  0) */
8d5a4abe:	04 cc 1b 46 	R3 = R3 - R3 (NS) || [SP + 0x34] = R0 || NOP;
8d5a4ac2:	70 b3 00 00 
8d5a4ac6:	04 cc 3f 4e 	R7 = R7 - R7 (NS) || [P5 + 0x14] = R3 || NOP;
8d5a4aca:	6b b1 00 00 
8d5a4ace:	aa b1       	[P5 + 0x18] = R2;
8d5a4ad0:	af e6 04 00 	B[P5 + 0x4] = R7;
8d5a4ad4:	61 a1       	R1 = [P4 + 0x14];
8d5a4ad6:	11 08       	CC = R1 == R2;
8d5a4ad8:	09 32       	P1 = R1;
8d5a4ada:	87 10       	IF !CC JUMP 0x0x8d5a4be8;
8d5a4adc:	24 6c       	P4 += 0x4;		/* (  4) */
8d5a4ade:	60 a1       	R0 = [P4 + 0x14];
8d5a4ae0:	85 60       	R5 = 0x10 (X);		/*		R5=0x0(  0) */
