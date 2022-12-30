
;CodeVisionAVR C Compiler V2.05.3 Standard
;(C) Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega32A
;Program type             : Application
;Clock frequency          : 8.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 512 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;Global 'const' stored in FLASH     : No
;Enhanced function parameter passing: Yes
;Enhanced core instructions         : On
;Smart register allocation          : On
;Automatic register allocation      : On

	#pragma AVRPART ADMIN PART_NAME ATmega32A
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2143
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

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
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

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

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x085F
	.EQU __DSTACK_SIZE=0x0200
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
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
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

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

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
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

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
	.ORG 0x260

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.3 Standard
;Automatic Program Generator
;© Copyright 1998-2011 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 2/26/2014
;Author  : WWW.PARANDCO.COM
;Company : PARAND
;Comments:
;
;
;Chip type               : ATmega32A
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 512
;*****************************************************/
;
;#include <mega32a.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;
;#include <delay.h>
;
;#define ADC_VREF_TYPE 0x40
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0000 0020 {

	.CSEG
_read_adc:
; 0000 0021 ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	ORI  R30,0x40
	OUT  0x7,R30
; 0000 0022 // Delay needed for the stabilization of the ADC input voltage
; 0000 0023 delay_us(10);
	__DELAY_USB 27
; 0000 0024 // Start the AD conversion
; 0000 0025 ADCSRA|=0x40;
	SBI  0x6,6
; 0000 0026 // Wait for the AD conversion to complete
; 0000 0027 while ((ADCSRA & 0x10)==0);
_0x3:
	SBIS 0x6,4
	RJMP _0x3
; 0000 0028 ADCSRA|=0x10;
	SBI  0x6,4
; 0000 0029 return ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	ADIW R28,1
	RET
; 0000 002A }
;
;// Declare your global variables here
;
;void main(void)
; 0000 002F { int m  ;
_main:
; 0000 0030 int l ;
; 0000 0031 int n;
; 0000 0032 // Declare your local variables here
; 0000 0033 
; 0000 0034 // Input/Output Ports initialization
; 0000 0035 // Port A initialization
; 0000 0036 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0037 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0038 PORTA=0x00;
;	m -> R16,R17
;	l -> R18,R19
;	n -> R20,R21
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 0039 DDRA=0x00;
	OUT  0x1A,R30
; 0000 003A 
; 0000 003B // Port B initialization
; 0000 003C // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=Out Func1=Out Func0=Out
; 0000 003D // State7=T State6=T State5=T State4=T State3=T State2=0 State1=0 State0=0
; 0000 003E PORTB=0x00;
	OUT  0x18,R30
; 0000 003F DDRB=0x07;
	LDI  R30,LOW(7)
	OUT  0x17,R30
; 0000 0040 
; 0000 0041 // Port C initialization
; 0000 0042 // Func7=In Func6=In Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 0043 // State7=T State6=T State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 0044 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0045 DDRC=0x3F;
	LDI  R30,LOW(63)
	OUT  0x14,R30
; 0000 0046 
; 0000 0047 // Port D initialization
; 0000 0048 // Func7=In Func6=In Func5=Out Func4=Out Func3=Out Func2=Out Func1=Out Func0=Out
; 0000 0049 // State7=T State6=T State5=0 State4=0 State3=0 State2=0 State1=0 State0=0
; 0000 004A PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 004B DDRD=0x3F;
	LDI  R30,LOW(63)
	OUT  0x11,R30
; 0000 004C 
; 0000 004D // Timer/Counter 0 initialization
; 0000 004E // Clock source: System Clock
; 0000 004F // Clock value: Timer 0 Stopped
; 0000 0050 // Mode: Normal top=0xFF
; 0000 0051 // OC0 output: Disconnected
; 0000 0052 TCCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 0053 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0054 OCR0=0x00;
	OUT  0x3C,R30
; 0000 0055 
; 0000 0056 // Timer/Counter 1 initialization
; 0000 0057 // Clock source: System Clock
; 0000 0058 // Clock value: Timer1 Stopped
; 0000 0059 // Mode: Normal top=0xFFFF
; 0000 005A // OC1A output: Discon.
; 0000 005B // OC1B output: Discon.
; 0000 005C // Noise Canceler: Off
; 0000 005D // Input Capture on Falling Edge
; 0000 005E // Timer1 Overflow Interrupt: Off
; 0000 005F // Input Capture Interrupt: Off
; 0000 0060 // Compare A Match Interrupt: Off
; 0000 0061 // Compare B Match Interrupt: Off
; 0000 0062 TCCR1A=0x00;
	OUT  0x2F,R30
; 0000 0063 TCCR1B=0x00;
	OUT  0x2E,R30
; 0000 0064 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0065 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0066 ICR1H=0x00;
	OUT  0x27,R30
; 0000 0067 ICR1L=0x00;
	OUT  0x26,R30
; 0000 0068 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 0069 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 006A OCR1BH=0x00;
	OUT  0x29,R30
; 0000 006B OCR1BL=0x00;
	OUT  0x28,R30
; 0000 006C 
; 0000 006D // Timer/Counter 2 initialization
; 0000 006E // Clock source: System Clock
; 0000 006F // Clock value: Timer2 Stopped
; 0000 0070 // Mode: Normal top=0xFF
; 0000 0071 // OC2 output: Disconnected
; 0000 0072 ASSR=0x00;
	OUT  0x22,R30
; 0000 0073 TCCR2=0x00;
	OUT  0x25,R30
; 0000 0074 TCNT2=0x00;
	OUT  0x24,R30
; 0000 0075 OCR2=0x00;
	OUT  0x23,R30
; 0000 0076 
; 0000 0077 // External Interrupt(s) initialization
; 0000 0078 // INT0: Off
; 0000 0079 // INT1: Off
; 0000 007A // INT2: Off
; 0000 007B MCUCR=0x00;
	OUT  0x35,R30
; 0000 007C MCUCSR=0x00;
	OUT  0x34,R30
; 0000 007D 
; 0000 007E // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 007F TIMSK=0x00;
	OUT  0x39,R30
; 0000 0080 
; 0000 0081 // USART initialization
; 0000 0082 // USART disabled
; 0000 0083 UCSRB=0x00;
	OUT  0xA,R30
; 0000 0084 
; 0000 0085 // Analog Comparator initialization
; 0000 0086 // Analog Comparator: Off
; 0000 0087 // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 0088 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 0089 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 008A 
; 0000 008B // ADC initialization
; 0000 008C // ADC Clock frequency: 1000.000 kHz
; 0000 008D // ADC Voltage Reference: AVCC pin
; 0000 008E ADMUX=ADC_VREF_TYPE & 0xff;
	LDI  R30,LOW(64)
	OUT  0x7,R30
; 0000 008F ADCSRA=0x83;
	LDI  R30,LOW(131)
	OUT  0x6,R30
; 0000 0090 
; 0000 0091 // SPI initialization
; 0000 0092 // SPI disabled
; 0000 0093 SPCR=0x00;
	LDI  R30,LOW(0)
	OUT  0xD,R30
; 0000 0094 
; 0000 0095 // TWI initialization
; 0000 0096 // TWI disabled
; 0000 0097 TWCR=0x00;
	OUT  0x36,R30
; 0000 0098 
; 0000 0099 while (1)
_0x6:
; 0000 009A       {
; 0000 009B       // Place your code here
; 0000 009C        m=read_adc(0);
	RCALL SUBOPT_0x0
; 0000 009D l=read_adc(2);
; 0000 009E n=read_adc(3);
; 0000 009F PORTD.1=1  ;
; 0000 00A0 PORTD.4=1 ;
; 0000 00A1 PORTC.1=1;
; 0000 00A2 PORTC.4=1;
; 0000 00A3 if (n>500)
	BRLT _0x11
; 0000 00A4 {PORTC.2=0;
	RCALL SUBOPT_0x1
; 0000 00A5 PORTC.0=1;
; 0000 00A6 PORTC.3=0;
; 0000 00A7 PORTC.5=1;};
_0x11:
; 0000 00A8 if (n<500)
	__CPWRN 20,21,500
	BRGE _0x1A
; 0000 00A9 {
; 0000 00AA PORTC.2=1;
	RCALL SUBOPT_0x2
; 0000 00AB PORTC.0=0;
; 0000 00AC PORTC.3=0;
; 0000 00AD PORTC.5=1;};
_0x1A:
; 0000 00AE if(l>500)
	__CPWRN 18,19,501
	BRLT _0x23
; 0000 00AF {PORTC.2=0;
	RCALL SUBOPT_0x3
; 0000 00B0 PORTC.0=0;
; 0000 00B1 PORTC.3=0;
; 0000 00B2 PORTC.5=0;
; 0000 00B3 PORTD.0=0 ;
; 0000 00B4 PORTD.2=1;
; 0000 00B5 delay_ms(3000);
; 0000 00B6 PORTD.0=1 ;
; 0000 00B7 PORTD.2=0;
; 0000 00B8 delay_ms(3000);
; 0000 00B9 PORTD.0=0;
; 0000 00BA PORTD.2=0 ;
; 0000 00BB PORTC.2=1;
; 0000 00BC PORTC.0=0;
; 0000 00BD PORTC.3=0;
; 0000 00BE PORTC.5=1;
; 0000 00BF };
_0x23:
; 0000 00C0 if (n>500)
	__CPWRN 20,21,501
	BRLT _0x40
; 0000 00C1 {PORTC.2=0;
	RCALL SUBOPT_0x3
; 0000 00C2 PORTC.0=0;
; 0000 00C3 PORTC.3=0;
; 0000 00C4 PORTC.5=0;
; 0000 00C5 PORTD.0=0 ;
; 0000 00C6 PORTD.2=1;
; 0000 00C7 delay_ms(3000);
; 0000 00C8 PORTD.0=1 ;
; 0000 00C9 PORTD.2=0;
; 0000 00CA delay_ms(3000);
; 0000 00CB PORTD.0=0;
; 0000 00CC PORTD.2=0 ;
; 0000 00CD PORTC.2=1;
; 0000 00CE PORTC.0=0;
; 0000 00CF PORTC.3=0;
; 0000 00D0 PORTC.5=1;
; 0000 00D1 };m=read_adc(0);
_0x40:
	RCALL SUBOPT_0x0
; 0000 00D2 l=read_adc(2);
; 0000 00D3 n=read_adc(3);
; 0000 00D4 PORTD.1=1  ;
; 0000 00D5 PORTD.4=1 ;
; 0000 00D6 PORTC.1=1;
; 0000 00D7 PORTC.4=1;
; 0000 00D8 if (n>500)
	BRLT _0x65
; 0000 00D9 {PORTC.2=0;
	RCALL SUBOPT_0x1
; 0000 00DA PORTC.0=1;
; 0000 00DB PORTC.3=0;
; 0000 00DC PORTC.5=1;};
_0x65:
; 0000 00DD if (n<500)
	__CPWRN 20,21,500
	BRGE _0x6E
; 0000 00DE {
; 0000 00DF PORTC.2=1;
	RCALL SUBOPT_0x2
; 0000 00E0 PORTC.0=0;
; 0000 00E1 PORTC.3=0;
; 0000 00E2 PORTC.5=1;};
_0x6E:
; 0000 00E3 if(l>500)
	__CPWRN 18,19,501
	BRLT _0x77
; 0000 00E4 {PORTC.2=0;
	RCALL SUBOPT_0x3
; 0000 00E5 PORTC.0=0;
; 0000 00E6 PORTC.3=0;
; 0000 00E7 PORTC.5=0;
; 0000 00E8 PORTD.0=0 ;
; 0000 00E9 PORTD.2=1;
; 0000 00EA delay_ms(3000);
; 0000 00EB PORTD.0=1 ;
; 0000 00EC PORTD.2=0;
; 0000 00ED delay_ms(3000);
; 0000 00EE PORTD.0=0;
; 0000 00EF PORTD.2=0 ;
; 0000 00F0 PORTC.2=1;
; 0000 00F1 PORTC.0=0;
; 0000 00F2 PORTC.3=0;
; 0000 00F3 PORTC.5=1;
; 0000 00F4 };
_0x77:
; 0000 00F5 if (n>500)
	__CPWRN 20,21,501
	BRLT _0x94
; 0000 00F6 {PORTC.2=0;
	RCALL SUBOPT_0x3
; 0000 00F7 PORTC.0=0;
; 0000 00F8 PORTC.3=0;
; 0000 00F9 PORTC.5=0;
; 0000 00FA PORTD.0=0 ;
; 0000 00FB PORTD.2=1;
; 0000 00FC delay_ms(3000);
; 0000 00FD PORTD.0=1 ;
; 0000 00FE PORTD.2=0;
; 0000 00FF delay_ms(3000);
; 0000 0100 PORTD.0=0;
; 0000 0101 PORTD.2=0 ;
; 0000 0102 PORTC.2=1;
; 0000 0103 PORTC.0=0;
; 0000 0104 PORTC.3=0;
; 0000 0105 PORTC.5=1;
; 0000 0106 };m=read_adc(0);
_0x94:
	RCALL SUBOPT_0x0
; 0000 0107 l=read_adc(2);
; 0000 0108 n=read_adc(3);
; 0000 0109 PORTD.1=1  ;
; 0000 010A PORTD.4=1 ;
; 0000 010B PORTC.1=1;
; 0000 010C PORTC.4=1;
; 0000 010D if (n>500)
	BRLT _0xB9
; 0000 010E {PORTC.2=0;
	RCALL SUBOPT_0x1
; 0000 010F PORTC.0=1;
; 0000 0110 PORTC.3=0;
; 0000 0111 PORTC.5=1;};
_0xB9:
; 0000 0112 if (n<500)
	__CPWRN 20,21,500
	BRGE _0xC2
; 0000 0113 {
; 0000 0114 PORTC.2=1;
	RCALL SUBOPT_0x2
; 0000 0115 PORTC.0=0;
; 0000 0116 PORTC.3=0;
; 0000 0117 PORTC.5=1;};
_0xC2:
; 0000 0118 if(l>500)
	__CPWRN 18,19,501
	BRLT _0xCB
; 0000 0119 {PORTC.2=0;
	RCALL SUBOPT_0x3
; 0000 011A PORTC.0=0;
; 0000 011B PORTC.3=0;
; 0000 011C PORTC.5=0;
; 0000 011D PORTD.0=0 ;
; 0000 011E PORTD.2=1;
; 0000 011F delay_ms(3000);
; 0000 0120 PORTD.0=1 ;
; 0000 0121 PORTD.2=0;
; 0000 0122 delay_ms(3000);
; 0000 0123 PORTD.0=0;
; 0000 0124 PORTD.2=0 ;
; 0000 0125 PORTC.2=1;
; 0000 0126 PORTC.0=0;
; 0000 0127 PORTC.3=0;
; 0000 0128 PORTC.5=1;
; 0000 0129 };
_0xCB:
; 0000 012A if (n>500)
	__CPWRN 20,21,501
	BRLT _0xE8
; 0000 012B {PORTC.2=0;
	RCALL SUBOPT_0x3
; 0000 012C PORTC.0=0;
; 0000 012D PORTC.3=0;
; 0000 012E PORTC.5=0;
; 0000 012F PORTD.0=0 ;
; 0000 0130 PORTD.2=1;
; 0000 0131 delay_ms(3000);
; 0000 0132 PORTD.0=1 ;
; 0000 0133 PORTD.2=0;
; 0000 0134 delay_ms(3000);
; 0000 0135 PORTD.0=0;
; 0000 0136 PORTD.2=0 ;
; 0000 0137 PORTC.2=1;
; 0000 0138 PORTC.0=0;
; 0000 0139 PORTC.3=0;
; 0000 013A PORTC.5=1;
; 0000 013B };
_0xE8:
; 0000 013C       }
	RJMP _0x6
; 0000 013D }
_0x105:
	RJMP _0x105

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:31 WORDS
SUBOPT_0x0:
	LDI  R26,LOW(0)
	RCALL _read_adc
	MOVW R16,R30
	LDI  R26,LOW(2)
	RCALL _read_adc
	MOVW R18,R30
	LDI  R26,LOW(3)
	RCALL _read_adc
	MOVW R20,R30
	SBI  0x12,1
	SBI  0x12,4
	SBI  0x15,1
	SBI  0x15,4
	__CPWRN 20,21,501
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	CBI  0x15,2
	SBI  0x15,0
	CBI  0x15,3
	SBI  0x15,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x2:
	SBI  0x15,2
	CBI  0x15,0
	CBI  0x15,3
	SBI  0x15,5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:87 WORDS
SUBOPT_0x3:
	CBI  0x15,2
	CBI  0x15,0
	CBI  0x15,3
	CBI  0x15,5
	CBI  0x12,0
	SBI  0x12,2
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	CALL _delay_ms
	SBI  0x12,0
	CBI  0x12,2
	LDI  R26,LOW(3000)
	LDI  R27,HIGH(3000)
	CALL _delay_ms
	CBI  0x12,0
	CBI  0x12,2
	RJMP SUBOPT_0x2


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
