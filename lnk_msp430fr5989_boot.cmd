/* LINKER COMMAND FILE FOR USER CODE APPLICATION USING msp430fr5989  */

/* SPECIFY THE SYSTEM MEMORY MAP                                  */

/* The following definitions can be changed to customize the
 * memory map for a different device or other adjustments.
 * Note that the changes should match the definitions used in
 * MEMORY and SECTIONS.
 */

/* RAM Memory Addresses */
__RAM_Start             = 0x1C00;   /* RAM Start */
__RAM_End               = 0x23FF;   /* RAM End */


/* RAM shared between App and Bootloader, must be reserved */
PassWd                  = 0x1C00;   /* Password sent by App to force boot  mode */
StatCtrl                = 0x1C02;   /* Status and Control  byte used by Comm */
CI_State_Machine        = 0x1C03;   /* State machine variable used by Comm */
CI_Callback_ptr         = 0x1C04;   /* Pointer to Comm callback structure */


/* Unreserved RAM used for Bootloader or App purposes */
_NonReserved_RAM_Start  = 0x1C08;   /* Non-reserved RAM */


/* Flash memory addresses */
/* App area     : 4400-EFFF & 10000-149FF*/
/* Download area: 14A00-23FFF*/
/* Boot area    : F000-FFFF*/
__Flash_Start               = 0x4400;                   /* Start of Application area */


/* Reserved Flash locations for Bootloader Area */
__Boot_Start                = 0xF000;                   /* Boot flash */
__Boot_Reset                = 0xFFFE;                   /* Boot reset vector */
__Boot_VectorTable          = 0xFF90;                   /* Boot vector table */
__Boot_SharedCallbacks_Len  = 6;                        /* Length of shared callbacks (2 calls =4B(msp430) or 8B(msp430x) */
__Boot_SharedCallbacks      = 0xFF7A;                   /* Start of Shared callbacks */
_BOOT_APPVECTOR             = __Boot_SharedCallbacks;   /* Definition for application table             */
_Appl_Vector_Start          = 0xEF90;                   /* Interrupt table */
/* Reserved Flash locations for Application Area */


/* MEMORY definition, adjust based on definitions above */
MEMORY
{
    SFR                     : origin = 0x0000, length = 0x0010
    PERIPHERALS_8BIT        : origin = 0x0010, length = 0x00F0
    PERIPHERALS_16BIT       : origin = 0x0100, length = 0x0100
    /* RAM from _NonReserved_RAM_Start - __RAM_End */
    RAM                     : origin = 0x1C08, length = 0x7F8
    /* Flash from _App_Start -> (APP_VECTORS-1) */
    FRAM                    : origin = 0x4403, length = 0xAB8D
    FRAM2                   : origin = 0x10000,length = 0x4A00
    /* Interrupt table from  _App_Vector_Start->(RESET-1) */
    INT00                   : origin = 0xEF90, length = 0x0002
    INT01                   : origin = 0xEF92, length = 0x0002
    INT02                   : origin = 0xEF94, length = 0x0002
    INT03                   : origin = 0xEF96, length = 0x0002
    INT04                   : origin = 0xEF98, length = 0x0002
    INT05                   : origin = 0xEF9A, length = 0x0002
    INT06                   : origin = 0xEF9C, length = 0x0002
    INT07                   : origin = 0xEF9E, length = 0x0002
    INT08                   : origin = 0xEFA0, length = 0x0002
    INT09                   : origin = 0xEFA2, length = 0x0002
    INT10                   : origin = 0xEFA4, length = 0x0002
    INT11                   : origin = 0xEFA6, length = 0x0002
    INT12                   : origin = 0xEFA8, length = 0x0002
    INT13                   : origin = 0xEFAA, length = 0x0002
    INT14                   : origin = 0xEFAC, length = 0x0002
    INT15                   : origin = 0xEFAE, length = 0x0002
    INT16                   : origin = 0xEFB0, length = 0x0002
    INT17                   : origin = 0xEFB2, length = 0x0002
    INT18                   : origin = 0xEFB4, length = 0x0002
    INT19                   : origin = 0xEFB6, length = 0x0002
    INT20                   : origin = 0xEFB8, length = 0x0002
    INT21                   : origin = 0xEFBA, length = 0x0002
    INT22                   : origin = 0xEFBC, length = 0x0002
    INT23                   : origin = 0xEFBE, length = 0x0002
    INT24                   : origin = 0xEFC0, length = 0x0002
    INT25                   : origin = 0xEFC2, length = 0x0002
    INT26                   : origin = 0xEFC4, length = 0x0002
    INT27                   : origin = 0xEFC6, length = 0x0002
    INT28                   : origin = 0xEFC8, length = 0x0002
    INT29                   : origin = 0xEFCA, length = 0x0002
    INT30                   : origin = 0xEFCC, length = 0x0002
    INT31                   : origin = 0xEFCE, length = 0x0002
    INT32                   : origin = 0xEFD0, length = 0x0002
    INT33                   : origin = 0xEFD2, length = 0x0002
    INT34                   : origin = 0xEFD4, length = 0x0002
    INT35                   : origin = 0xEFD6, length = 0x0002
    INT36                   : origin = 0xEFD8, length = 0x0002
    INT37                   : origin = 0xEFDA, length = 0x0002
    INT38                   : origin = 0xEFDC, length = 0x0002
    INT39                   : origin = 0xEFDE, length = 0x0002
    INT40                   : origin = 0xEFE0, length = 0x0002
    INT41                   : origin = 0xEFE2, length = 0x0002
    INT42                   : origin = 0xEFE4, length = 0x0002
    INT43                   : origin = 0xEFE6, length = 0x0002
    INT44                   : origin = 0xEFE8, length = 0x0002
    INT45                   : origin = 0xEFEA, length = 0x0002
    INT46                   : origin = 0xEFEC, length = 0x0002
    INT47                   : origin = 0xEFEE, length = 0x0002
    INT48                   : origin = 0xEFF0, length = 0x0002
    INT49                   : origin = 0xEFF2, length = 0x0002
    INT50                   : origin = 0xEFF4, length = 0x0002
    INT51                   : origin = 0xEFF6, length = 0x0002
    INT52                   : origin = 0xEFF8, length = 0x0002
    INT53                   : origin = 0xEFFA, length = 0x0002
    INT54                   : origin = 0xEFFC, length = 0x0002

    /* App reset from _App_Reset_Vector */
    RESET                   : origin = 0xEFFE, length = 0x0002
}


/* SPECIFY THE SECTIONS ALLOCATION INTO MEMORY                                  */

SECTIONS
{
    .bss            : {} > RAM                  /* GLOBAL & STATIC VARS             */
    .data           : {} > RAM                  /* GLOBAL & STATIC VARS             */
    .sysmem         : {} > RAM                  /* DYNAMIC MEMORY ALLOCATION AREA   */
    .stack          : {} > RAM (HIGH)           /* SOFTWARE SYSTEM STACK            */

    .text:_isr      : {} > FRAM                 /* Code ISRs                        */

    GROUP(RW_IPE)
    {
        GROUP(READ_WRITE_MEMORY){
            .TI.persistent  : {}
            .TI.noinit      : {}
        } PALIGN(0x0400), RUN_START(fram_rw_start)
    } > FRAM

    #ifndef __LARGE_DATA_MODEL__
        .text       : {} >> FRAM                /* CODE                             */
    #else
        .text       : {} >> FRAM | FRAM         /* CODE                             */
    #endif

    .cinit          : {} > FRAM                 /* INITIALIZATION TABLES            */

    #ifndef __LARGE_DATA_MODEL__
        .const      : {} >> FRAM                /* CONSTANT DATA                    */
    #else
        .const      : {} >> FRAM2 | FRAM        /* CONSTANT DATA                    */
    #endif

    .cio            : {} > RAM                  /* C I/O BUFFER                     */


    /* MSP430 INTERRUPT VECTORS                                                     */
    .int00       : {}               > INT00
    .int01       : {}               > INT01
    .int02       : {}               > INT02
    .int03       : {}               > INT03
    .int04       : {}               > INT04
    .int05       : {}               > INT05
    .int06       : {}               > INT06
    .int07       : {}               > INT07
    .int08       : {}               > INT08
    .int09       : {}               > INT09
    .int10       : {}               > INT10
    .int11       : {}               > INT11
    .int12       : {}               > INT12
    .int13       : {}               > INT13
    .int14       : {}               > INT14
    .int15       : {}               > INT15
    .int16       : {}               > INT16
    .int17       : {}               > INT17
    .int18       : {}               > INT18
    .int19       : {}               > INT19
    .int20       : {}               > INT20
    .int21       : {}               > INT21
    .int22       : {}               > INT22
    .int23       : {}               > INT23
    .int24       : {}               > INT24
    .int25       : {}               > INT25
    .int26       : {}               > INT26
    AES256       : { * ( .int27 ) } > INT27 type = VECT_INIT
    RTC          : { * ( .int28 ) } > INT28 type = VECT_INIT
    .init29      : { * ( .int29 ) } > INT29 type = VECT_INIT
    PORT4        : { * ( .int30 ) } > INT30 type = VECT_INIT
    PORT3        : { * ( .int31 ) } > INT31 type = VECT_INIT
    TIMER3_A1    : { * ( .int32 ) } > INT32 type = VECT_INIT
    TIMER3_A0    : { * ( .int33 ) } > INT33 type = VECT_INIT
    PORT2        : { * ( .int34 ) } > INT34 type = VECT_INIT
    TIMER2_A1    : { * ( .int35 ) } > INT35 type = VECT_INIT
    TIMER2_A0    : { * ( .int36 ) } > INT36 type = VECT_INIT
    PORT1        : { * ( .int37 ) } > INT37 type = VECT_INIT
    TIMER1_A1    : { * ( .int38 ) } > INT38 type = VECT_INIT
    TIMER1_A0    : { * ( .int39 ) } > INT39 type = VECT_INIT
    DMA          : { * ( .int40 ) } > INT40 type = VECT_INIT
    USCI_B1      : { * ( .int41 ) } > INT41 type = VECT_INIT
    USCI_A1      : { * ( .int42 ) } > INT42 type = VECT_INIT
    TIMER0_A1    : { * ( .int43 ) } > INT43 type = VECT_INIT
    TIMER0_A0    : { * ( .int44 ) } > INT44 type = VECT_INIT
    ADC12        : { * ( .int45 ) } > INT45 type = VECT_INIT
    USCI_B0      : { * ( .int46 ) } > INT46 type = VECT_INIT
    USCI_A0      : { * ( .int47 ) } > INT47 type = VECT_INIT
    ESCAN_IF     : { * ( .int48 ) } > INT48 type = VECT_INIT
    WDT          : { * ( .int49 ) } > INT49 type = VECT_INIT
    TIMER0_B1    : { * ( .int50 ) } > INT50 type = VECT_INIT
    TIMER0_B0    : { * ( .int51 ) } > INT51 type = VECT_INIT
    COMP_E       : { * ( .int52 ) } > INT52 type = VECT_INIT
    UNMI         : { * ( .int53 ) } > INT53 type = VECT_INIT
    SYSNMI       : { * ( .int54 ) } > INT54 type = VECT_INIT

    /* MSP430 RESET VECTOR                                                  */
    .reset       : {}               > RESET
}


/* INCLUDE PERIPHERALS MEMORY MAP                                           */

-l msp430fr5989.cmd
