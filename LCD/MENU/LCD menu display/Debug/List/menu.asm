
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega128
;Program type           : Application
;Clock frequency        : 8,000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega128
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _menu=R4
	.DEF _menu_msb=R5
	.DEF _t=R6
	.DEF _t_msb=R7
	.DEF _t3=R8
	.DEF _t3_msb=R9
	.DEF _i=R11
	.DEF _a=R10
	.DEF __lcd_x=R13
	.DEF __lcd_y=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G102:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G102:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x1,0x0,0x14,0x0
	.DB  0xC8,0x0

_0x3:
	.DB  0x48,0x45,0x4C,0x4C,0x4F,0x20,0x57,0x4F
	.DB  0x52,0x4C,0x44,0x20,0x20,0x20,0x20
_0x0:
	.DB  0x3E,0x54,0x72,0x61,0x69,0x20,0x73,0x61
	.DB  0x6E,0x67,0x20,0x70,0x68,0x61,0x69,0x0
	.DB  0x20,0x50,0x68,0x61,0x69,0x20,0x73,0x61
	.DB  0x6E,0x67,0x20,0x74,0x72,0x61,0x69,0x0
	.DB  0x20,0x54,0x72,0x61,0x69,0x20,0x73,0x61
	.DB  0x6E,0x67,0x20,0x70,0x68,0x61,0x69,0x0
	.DB  0x3E,0x50,0x68,0x61,0x69,0x20,0x73,0x61
	.DB  0x6E,0x67,0x20,0x74,0x72,0x61,0x69,0x0
	.DB  0x3E,0x53,0x63,0x72,0x6F,0x6C,0x6C,0x20
	.DB  0x74,0x65,0x78,0x74,0x20,0x20,0x20,0x0
	.DB  0x20,0x43,0x61,0x6E,0x20,0x67,0x69,0x75
	.DB  0x61,0x20,0x20,0x20,0x20,0x20,0x20,0x0
	.DB  0x20,0x53,0x63,0x72,0x6F,0x6C,0x6C,0x20
	.DB  0x74,0x65,0x78,0x74,0x20,0x20,0x20,0x0
	.DB  0x3E,0x43,0x61,0x6E,0x20,0x67,0x69,0x75
	.DB  0x61,0x20,0x20,0x20,0x20,0x20,0x20,0x0
	.DB  0x48,0x45,0x4C,0x4C,0x4F,0x20,0x57,0x4F
	.DB  0x52,0x4C,0x44,0x20,0x20,0x20,0x20,0x0
	.DB  0x20,0x20,0x48,0x45,0x4C,0x4C,0x4F,0x20
	.DB  0x57,0x4F,0x52,0x4C,0x44,0x20,0x20,0x0
_0x2000003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x06
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x0F
	.DW  _chuoi
	.DW  _0x3*2

	.DW  0x02
	.DW  __base_y_G100
	.DW  _0x2000003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;/*
; * lcd.c
; *
; * Created: 25/09/2019 9:02:47 SA
; * Author: quang van
; */
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <alcd.h>
;#include <io.h>
;#include <delay.h>
;#include <string.h>
;#include <stdio.h>
;int menu=1;
;int t=20;
;int t3=200;
;unsigned char i,a,chuoi[16];
;char chuoi[16] ="HELLO WORLD    ";

	.DSEG
;void updatemenu(){
; 0000 0012 void updatemenu(){

	.CSEG
_updatemenu:
; .FSTART _updatemenu
; 0000 0013      switch(menu)
	MOVW R30,R4
; 0000 0014     {
; 0000 0015         case 0:
	SBIW R30,0
	BRNE _0x7
; 0000 0016             menu=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP _0x53
; 0000 0017             break;
; 0000 0018         case 1:
_0x7:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x8
; 0000 0019             lcd_clear();
	CALL SUBOPT_0x0
; 0000 001A             lcd_gotoxy(0,0);
; 0000 001B             lcd_putsf(">Trai sang phai");
	__POINTW2FN _0x0,0
	CALL SUBOPT_0x1
; 0000 001C             lcd_gotoxy(0,1);
; 0000 001D             lcd_putsf(" Phai sang trai");
	__POINTW2FN _0x0,16
	RCALL _lcd_putsf
; 0000 001E             break;
	RJMP _0x6
; 0000 001F         case 2:
_0x8:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x9
; 0000 0020             lcd_clear();
	CALL SUBOPT_0x0
; 0000 0021             lcd_gotoxy(0,0);
; 0000 0022             lcd_putsf(" Trai sang phai");
	__POINTW2FN _0x0,32
	CALL SUBOPT_0x1
; 0000 0023             lcd_gotoxy(0,1);
; 0000 0024             lcd_putsf(">Phai sang trai");
	__POINTW2FN _0x0,48
	RCALL _lcd_putsf
; 0000 0025             break;
	RJMP _0x6
; 0000 0026         case 3:
_0x9:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0xA
; 0000 0027             lcd_clear();
	CALL SUBOPT_0x0
; 0000 0028             lcd_gotoxy(0,0);
; 0000 0029             lcd_putsf(">Scroll text   ");
	__POINTW2FN _0x0,64
	CALL SUBOPT_0x1
; 0000 002A             lcd_gotoxy(0,1);
; 0000 002B             lcd_putsf(" Can giua      ");
	__POINTW2FN _0x0,80
	RCALL _lcd_putsf
; 0000 002C             break;
	RJMP _0x6
; 0000 002D         case 4:
_0xA:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0xB
; 0000 002E             lcd_clear();
	CALL SUBOPT_0x0
; 0000 002F             lcd_gotoxy(0,0);
; 0000 0030             lcd_putsf(" Scroll text   ");
	__POINTW2FN _0x0,96
	CALL SUBOPT_0x1
; 0000 0031             lcd_gotoxy(0,1);
; 0000 0032             lcd_putsf(">Can giua      ");
	__POINTW2FN _0x0,112
	RCALL _lcd_putsf
; 0000 0033             break;
	RJMP _0x6
; 0000 0034         case 5:
_0xB:
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x6
; 0000 0035             menu=4;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
_0x53:
	MOVW R4,R30
; 0000 0036             break;
; 0000 0037     }
_0x6:
; 0000 0038 }
	RET
; .FEND
;void action1(){
; 0000 0039 void action1(){
_action1:
; .FSTART _action1
; 0000 003A     lcd_clear();
	RCALL _lcd_clear
; 0000 003B     while(1)
_0xD:
; 0000 003C         {
; 0000 003D             a=chuoi[14];
	__GETBRMN 10,_chuoi,14
; 0000 003E             for(i=14;i>=1;i--)
	LDI  R30,LOW(14)
	MOV  R11,R30
_0x11:
	LDI  R30,LOW(1)
	CP   R11,R30
	BRLO _0x12
; 0000 003F             {
; 0000 0040                 lcd_gotoxy(i,0);
	CALL SUBOPT_0x2
; 0000 0041                 lcd_putchar(chuoi[i]);
; 0000 0042                 chuoi[i]=chuoi[i-1];
	SBIW R30,1
	SUBI R30,LOW(-_chuoi)
	SBCI R31,HIGH(-_chuoi)
	LD   R30,Z
	ST   X,R30
; 0000 0043                 delay_ms(t);
	MOVW R26,R6
	CALL _delay_ms
; 0000 0044             }
	DEC  R11
	RJMP _0x11
_0x12:
; 0000 0045             chuoi[0]=a;
	STS  _chuoi,R10
; 0000 0046             if(!PIND.4)
	SBIC 0x10,4
	RJMP _0x13
; 0000 0047             {
; 0000 0048                 lcd_clear();
	RCALL _lcd_clear
; 0000 0049                 break;
	RJMP _0xF
; 0000 004A             }
; 0000 004B         }
_0x13:
	RJMP _0xD
_0xF:
; 0000 004C }
	RET
; .FEND
;void action2(){
; 0000 004D void action2(){
_action2:
; .FSTART _action2
; 0000 004E     lcd_clear();
	RCALL _lcd_clear
; 0000 004F     while(1)
_0x14:
; 0000 0050     {
; 0000 0051         a=chuoi[0];
	LDS  R10,_chuoi
; 0000 0052         for(i=0;i<15;i++)
	CLR  R11
_0x18:
	LDI  R30,LOW(15)
	CP   R11,R30
	BRSH _0x19
; 0000 0053         {
; 0000 0054             lcd_gotoxy(i,0);
	CALL SUBOPT_0x2
; 0000 0055             lcd_putchar(chuoi[i]);
; 0000 0056             chuoi[i]=chuoi[i+1];
	__ADDW1MN _chuoi,1
	LD   R30,Z
	ST   X,R30
; 0000 0057             delay_ms(t);
	MOVW R26,R6
	CALL _delay_ms
; 0000 0058         }
	INC  R11
	RJMP _0x18
_0x19:
; 0000 0059         chuoi[14]=a;
	__PUTBMRN _chuoi,14,10
; 0000 005A         if(!PIND.4)
	SBIS 0x10,4
; 0000 005B         {
; 0000 005C             break;
	RJMP _0x16
; 0000 005D         }
; 0000 005E     }
	RJMP _0x14
_0x16:
; 0000 005F }
	RET
; .FEND
;void action3(){
; 0000 0060 void action3(){
_action3:
; .FSTART _action3
; 0000 0061     int n=0;
; 0000 0062     lcd_clear();
	ST   -Y,R17
	ST   -Y,R16
;	n -> R16,R17
	__GETWRN 16,17,0
	RCALL _lcd_clear
; 0000 0063     do
_0x1C:
; 0000 0064     {
; 0000 0065     for(i=0;i<15;i++)
	CLR  R11
_0x1F:
	LDI  R30,LOW(15)
	CP   R11,R30
	BRSH _0x20
; 0000 0066     {
; 0000 0067         lcd_clear();
	CALL SUBOPT_0x3
; 0000 0068         lcd_gotoxy(i,0);
; 0000 0069         lcd_putsf("HELLO WORLD    ");
; 0000 006A         delay_ms(t3);
; 0000 006B         if(!PIND.4)
	SBIC 0x10,4
	RJMP _0x21
; 0000 006C         {
; 0000 006D             n++;
	__ADDWRN 16,17,1
; 0000 006E             break;
	RJMP _0x20
; 0000 006F         }
; 0000 0070     }
_0x21:
	INC  R11
	RJMP _0x1F
_0x20:
; 0000 0071     if(n==1)
	CALL SUBOPT_0x4
	BREQ _0x1D
; 0000 0072     {
; 0000 0073         break;
; 0000 0074     }
; 0000 0075     for(i=0;i<15;i++)
	CLR  R11
_0x24:
	LDI  R30,LOW(15)
	CP   R11,R30
	BRSH _0x25
; 0000 0076     {
; 0000 0077         lcd_clear();
	CALL SUBOPT_0x5
; 0000 0078         lcd_gotoxy(i,1);
; 0000 0079         lcd_putsf("HELLO WORLD    ");
; 0000 007A         delay_ms(t3);
; 0000 007B         if(!PIND.4)
	SBIC 0x10,4
	RJMP _0x26
; 0000 007C         {
; 0000 007D             n++;
	__ADDWRN 16,17,1
; 0000 007E             break;
	RJMP _0x25
; 0000 007F         }
; 0000 0080     }
_0x26:
	INC  R11
	RJMP _0x24
_0x25:
; 0000 0081     if(n==1)
	CALL SUBOPT_0x4
	BREQ _0x1D
; 0000 0082     {
; 0000 0083         break;
; 0000 0084     }
; 0000 0085     for(i=15;i>0;i--)
	LDI  R30,LOW(15)
	MOV  R11,R30
_0x29:
	LDI  R30,LOW(0)
	CP   R30,R11
	BRSH _0x2A
; 0000 0086     {
; 0000 0087         lcd_clear();
	CALL SUBOPT_0x5
; 0000 0088         lcd_gotoxy(i,1);
; 0000 0089         lcd_putsf("HELLO WORLD    ");
; 0000 008A         delay_ms(t3);
; 0000 008B         if(!PIND.4)
	SBIC 0x10,4
	RJMP _0x2B
; 0000 008C         {
; 0000 008D             n++;
	__ADDWRN 16,17,1
; 0000 008E             break;
	RJMP _0x2A
; 0000 008F         }
; 0000 0090     }
_0x2B:
	DEC  R11
	RJMP _0x29
_0x2A:
; 0000 0091     if(n==1)
	CALL SUBOPT_0x4
	BREQ _0x1D
; 0000 0092     {
; 0000 0093         break;
; 0000 0094     }
; 0000 0095     for(i=15;i>0;i--)
	LDI  R30,LOW(15)
	MOV  R11,R30
_0x2E:
	LDI  R30,LOW(0)
	CP   R30,R11
	BRSH _0x2F
; 0000 0096     {
; 0000 0097         lcd_clear();
	CALL SUBOPT_0x3
; 0000 0098         lcd_gotoxy(i,0);
; 0000 0099         lcd_putsf("HELLO WORLD    ");
; 0000 009A         delay_ms(t3);
; 0000 009B         if(!PIND.4)
	SBIC 0x10,4
	RJMP _0x30
; 0000 009C         {
; 0000 009D             n++;
	__ADDWRN 16,17,1
; 0000 009E             break;
	RJMP _0x2F
; 0000 009F         }
; 0000 00A0     }
_0x30:
	DEC  R11
	RJMP _0x2E
_0x2F:
; 0000 00A1     if(n==1)
	CALL SUBOPT_0x4
	BREQ _0x1D
; 0000 00A2     {
; 0000 00A3         break;
; 0000 00A4     }
; 0000 00A5     }
; 0000 00A6     while(PIND.4);
	SBIC 0x10,4
	RJMP _0x1C
_0x1D:
; 0000 00A7 }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;void action4(){
; 0000 00A8 void action4(){
_action4:
; .FSTART _action4
; 0000 00A9     lcd_clear();
	RCALL _lcd_clear
; 0000 00AA     do
_0x33:
; 0000 00AB     {
; 0000 00AC     lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _lcd_gotoxy
; 0000 00AD     lcd_putsf("  HELLO WORLD  ");
	__POINTW2FN _0x0,144
	RCALL _lcd_putsf
; 0000 00AE     }
; 0000 00AF     while(PIND.4);
	SBIC 0x10,4
	RJMP _0x33
; 0000 00B0 }
	RET
; .FEND
;void action(){
; 0000 00B1 void action(){
_action:
; .FSTART _action
; 0000 00B2      switch(menu)
	MOVW R30,R4
; 0000 00B3     {
; 0000 00B4         case 1:
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x38
; 0000 00B5             action1();
	RCALL _action1
; 0000 00B6             break;
	RJMP _0x37
; 0000 00B7         case 2:
_0x38:
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x39
; 0000 00B8             action2();
	RCALL _action2
; 0000 00B9             break;
	RJMP _0x37
; 0000 00BA         case 3:
_0x39:
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x3A
; 0000 00BB             action3();
	RCALL _action3
; 0000 00BC             break;
	RJMP _0x37
; 0000 00BD         case 4:
_0x3A:
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x37
; 0000 00BE             action4();
	RCALL _action4
; 0000 00BF             break;
; 0000 00C0     }
_0x37:
; 0000 00C1 }
	RET
; .FEND
;void main(void)
; 0000 00C3 {
_main:
; .FSTART _main
; 0000 00C4 lcd_init(16);
	LDI  R26,LOW(16)
	RCALL _lcd_init
; 0000 00C5 DDRD.2=0x00;
	CBI  0x11,2
; 0000 00C6 PORTD.2=0xff;
	SBI  0x12,2
; 0000 00C7 DDRD.3=0x00;
	CBI  0x11,3
; 0000 00C8 PORTD.3=0xff;
	SBI  0x12,3
; 0000 00C9 DDRD.4=0x00;
	CBI  0x11,4
; 0000 00CA PORTD.4=0xff;
	SBI  0x12,4
; 0000 00CB DDRD.5=0x00;
	CBI  0x11,5
; 0000 00CC PORTD.5=0xff;
	SBI  0x12,5
; 0000 00CD while(1)
_0x4C:
; 0000 00CE     {
; 0000 00CF     updatemenu();
	RCALL _updatemenu
; 0000 00D0     if(!PIND.5)
	SBIC 0x10,5
	RJMP _0x4F
; 0000 00D1     {
; 0000 00D2         menu++;
	MOVW R30,R4
	ADIW R30,1
	CALL SUBOPT_0x6
; 0000 00D3         updatemenu();
; 0000 00D4         delay_ms(100);
; 0000 00D5     }
; 0000 00D6     if(!PIND.3)
_0x4F:
	SBIC 0x10,3
	RJMP _0x50
; 0000 00D7     {
; 0000 00D8         menu--;
	MOVW R30,R4
	SBIW R30,1
	CALL SUBOPT_0x6
; 0000 00D9         updatemenu();
; 0000 00DA         delay_ms(100);
; 0000 00DB     }
; 0000 00DC     if(!PIND.2)
_0x50:
	SBIS 0x10,2
; 0000 00DD     {
; 0000 00DE         action();
	RCALL _action
; 0000 00DF     }
; 0000 00E0 }
	RJMP _0x4C
; 0000 00E1 }
_0x52:
	RJMP _0x52
; .FEND
;
;
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G100:
; .FSTART __lcd_write_nibble_G100
	ST   -Y,R26
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x2000004
	SBI  0x1B,3
	RJMP _0x2000005
_0x2000004:
	CBI  0x1B,3
_0x2000005:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x2000006
	SBI  0x1B,2
	RJMP _0x2000007
_0x2000006:
	CBI  0x1B,2
_0x2000007:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x2000008
	SBI  0x1B,1
	RJMP _0x2000009
_0x2000008:
	CBI  0x1B,1
_0x2000009:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x200000A
	SBI  0x1B,0
	RJMP _0x200000B
_0x200000A:
	CBI  0x1B,0
_0x200000B:
	__DELAY_USB 13
	SBI  0x1B,4
	__DELAY_USB 13
	CBI  0x1B,4
	__DELAY_USB 13
	RJMP _0x2080001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G100
	__DELAY_USB 133
	RJMP _0x2080001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G100)
	SBCI R31,HIGH(-__base_y_G100)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R13,Y+1
	LDD  R12,Y+0
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x7
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x7
	LDI  R30,LOW(0)
	MOV  R12,R30
	MOV  R13,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2000011
	LDS  R30,__lcd_maxx
	CP   R13,R30
	BRLO _0x2000010
_0x2000011:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R12
	MOV  R26,R12
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2000013
	RJMP _0x2080001
_0x2000013:
_0x2000010:
	INC  R13
	SBI  0x1B,6
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,6
	RJMP _0x2080001
; .FEND
_lcd_putsf:
; .FSTART _lcd_putsf
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2000017:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2000019
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2000017
_0x2000019:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	SBI  0x1A,3
	SBI  0x1A,2
	SBI  0x1A,1
	SBI  0x1A,0
	SBI  0x1A,4
	SBI  0x1A,6
	SBI  0x1A,5
	CBI  0x1B,4
	CBI  0x1B,6
	CBI  0x1B,5
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G100,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G100,3
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	CALL SUBOPT_0x8
	CALL SUBOPT_0x8
	CALL SUBOPT_0x8
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G100
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080001:
	ADIW R28,1
	RET
; .FEND

	.CSEG
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.DSEG
_chuoi:
	.BYTE 0x10
__base_y_G100:
	.BYTE 0x4
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x0:
	CALL _lcd_clear
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x1:
	CALL _lcd_putsf
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x2:
	ST   -Y,R11
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
	MOV  R30,R11
	LDI  R31,0
	SUBI R30,LOW(-_chuoi)
	SBCI R31,HIGH(-_chuoi)
	LD   R26,Z
	CALL _lcd_putchar
	MOV  R26,R11
	LDI  R27,0
	SUBI R26,LOW(-_chuoi)
	SBCI R27,HIGH(-_chuoi)
	MOV  R30,R11
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x3:
	CALL _lcd_clear
	ST   -Y,R11
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
	__POINTW2FN _0x0,128
	CALL _lcd_putsf
	MOVW R26,R8
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R16
	CPC  R31,R17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x5:
	CALL _lcd_clear
	ST   -Y,R11
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
	__POINTW2FN _0x0,128
	CALL _lcd_putsf
	MOVW R26,R8
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	MOVW R4,R30
	CALL _updatemenu
	LDI  R26,LOW(100)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x8:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G100
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
