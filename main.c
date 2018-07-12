/**
*    @author Michal Wolowik
*    @date Warsaw 12/VII/2018
*
*    @brief
*        UART0 simple example application
*
*    @file
*        main.c
*
*    @short
*       Main destiny of current code is to check if UART0 works
*       correctly in native and bootloader mode
*
*    @version V1.0a
*
*    @preconditions
*        None
*
*    @remark
*        Compiler: TI v18.1.2.LTS
*
*    @remark
*        GUI: Code Composer Studio Version: 8.0.0.00016
*
*    @note
*       None
*
*    @copyright
*        This library is free software; you can redistribute it and/or
*        modify it under the terms of the GNU Lesser General Public
*        License as published by the Free Software Foundation; either
*        version 2.1 of the License, or (at your option) any later version.
*    @copyright
*        This library is distributed in the hope that it will be useful,
*        but WITHOUT ANY WARRANTY; without even the implied warranty of
*        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
*        Lesser General Public License for more details.
*
*    @note
*        None currently
*/


#include <msp430.h>
#include <stdint.h>


/*!
@brief      Function initialize minimal hardware configuration, like
            system clock, GPIO, watchdog etc.
@return     None
@note       Testing result  :   Testing NA
@note       Conditions      :   NA
@note       Macro valid     :   NA
@note       Optimization    :   Level 4 - whole program optimization
@version    V1_0a
@author     M.Wolowik
@date       02.VII.2018
@bug        None
*/
static void min_hw_init(void);


/*!
@brief      Function initialize UART 1 (9600, 8bit, 1stp, no parity)
@return     None
@note       Testing result  :   Testing NA
@note       Conditions      :   NA
@note       Macro valid     :   NA
@note       Optimization    :   Level 4 - whole program optimization
@version    V1_0a
@author     M.Wolowik
@date       02.VII.2018
@bug        None
*/
static void UART_init(void);


/*!
@brief      Function send character via UART
@param      outchar         :   is an uint8_t type, provide byte to send
@return     None
@note       Testing result  :   Testing NA
@note       Conditions      :   NA
@note       Macro valid     :   NA
@note       Optimization    :   Level 4 - whole program optimization
@version    V1_0a
@author     M.Wolowik
@date       02.VII.2018
@bug        None
*/
static void UART_putchar(uint8_t outchar);


/*!
@brief      Function receive character acquired from UART if available
@return     uint8t          :   Return received byte from UART
@note       Testing result  :   Testing NA
@note       Conditions      :   NA
@note       Macro valid     :   NA
@note       Optimization    :   Level 4 - whole program optimization
@version    V1_0a
@author     M.Wolowik
@date       02.VII.2018
@bug        None
*/
static char UART_getchar(void);


/*!
@brief      Function send via UART string
@param      buf             :   is an char pointer type,
                                provide buffer with string content
@return     None
@note       Testing result  :   Testing NA
@note       Conditions      :   NA
@note       Macro valid     :   NA
@note       Optimization    :   Level 4 - whole program optimization
@version    V1_0a
@author     M.Wolowik
@date       02.VII.2018
@bug        None
*/
static void send_string_uart(char *buf);


/**
 * main.c
 */
int main(void)
{
    min_hw_init();

    UART_init();

    send_string_uart((char*)"START APPLICATION\xd\xa");

    __bis_SR_register(LPM3_bits+GIE);
	
	return 0;
}


static void min_hw_init(void)
{
    WDTCTL = WDTPW | WDTHOLD;   /* Stop watchdog timer */

    /*  Use external 32KHz crystal
        MClock and SMClock from DCO 4MHz */

    /* Using LFXTCLK */
    PJSEL0 |=  BIT4 + BIT5;

    /* Write in the password for system clock setting */
    CSCTL0 = 0XA500;

    /* 4MHz for DCO */
    CSCTL1 = 0x0006;

    /*  ACLK from LFXTCLK(SELA), SMCLK(SELS) and MCLK from DCO(SELM)
        For more details refer to SLAU367O chapter 3.3.3
        CSCTL2 Register */
    CSCTL2 = 0x0033;

    /* ACLK div by 1, SMCLK div by 1, MCLK div by 1 */
    CSCTL3 = 0x0000;

    /* HFXTOFF, LFXTDRIVE = 1, VLO off, SMCLK on */
    CSCTL4 = 0x0148;

    do{
        /* Clear XT1 fault flag */
        CSCTL5 &= ~LFXTOFFG;
        SFRIFG1 &= ~OFIFG;
    }while (SFRIFG1&OFIFG); /* Test oscillator fault flag */


    /*  This is to set the I/O port in the initialization.
        The power consumption will be 0.8uA in LPM4 after setting   */
    P1DIR=0xFF;
    P1OUT=0;
    P2DIR=0xFF;
    P2OUT=0;
    P3DIR=0xFF;
    P3OUT=0;
    P4DIR=0xFF;
    P4OUT=0;
    P5DIR=0xFF;
    P5OUT=0;
    P6DIR=0xFF;
    P6OUT=0;
    P7DIR=0xFF;
    P7OUT=0;
    P8DIR=0xFF;
    P8OUT=0;
    P9DIR=0x00;
    P9OUT=0;
    P10DIR=0xFF;
    P10OUT=0;
    PJDIR=0xFF;
    PJOUT=0;

    /*  Configure GPIO P2.5 as output
        for LED diode for testing purposes
        HW_DD_CFG_1 - refers to HW-DD document */
    /*  Configure port as output */
    P2DIR |= BIT5;
    /*  Set default state after reset on low level logic */
    P2OUT &= ~BIT5;


    CECTL3 = 0xFF00;

    /* Disable the GPIO power-on default high-impedance mode to activate
       previously configured port settings */
    PM5CTL0 &= ~LOCKLPM5;

    PMMCTL0_H = 0xA5;
    PMMCTL0_L &= ~SVSHE;
    PMMCTL0_H = 0xEE;
}


static void UART_init(void)
{
    /* Step 1. First configure GPIO to switch them
     * to USCI_A0 UART purpose
     */
    P4SEL0 |= BIT2 | BIT3;
    P4SEL1 &= ~(BIT2 | BIT3);


    /* Step 2. Disable the GPIO power-on default
     * high-impedance mode to activate
     * previously configured port settings
     */
    PM5CTL0 &= ~LOCKLPM5;

    /* Step 3. Configure USCI_A0 for UART mode */
    UCA0CTLW0 = UCSWRST;    /* Put eUSCI in reset */
    UCA0CTLW0 |= UCSSEL__SMCLK; /* CLK = SMCLK */

    /* Baud Rate calculation
     * 4000000/(16*9600) = 26.041
     * Fractional portion = 0.083
     * User's Guide Table 21-4: UCBRSx = 0x04
     * UCBRFx = int ( (26.041-26)*16) = 1
     */
    /* 9600 Baudrate */
    UCA0BR0 = 26;   /* 4000000/16/9600 */
    UCA0BR1 = 0x00;
    UCA0MCTLW |= UCOS16 | UCBRF_1 | 0xB600;
    /* 115200 Baudrate */
//    UCA0BR0 = 0x02;   /* 4000000/16/115200 */
//    UCA0BR1 = 0x00;
//    UCA0MCTLW |= UCOS16 | UCBRF_2 | 0xBB00;

    UCA0CTLW0 &= ~UCSWRST;  /* Initialize eUSCI */

    UCA0IE |= UCRXIE;   /* Enable USCI_A0 RX interrupt */
}


static void UART_putchar(uint8_t outchar)
{
    while(!(UCA0IFG&UCTXIFG));
    UCA0TXBUF = outchar;
    __no_operation();
}


static char UART_getchar(void)
{
    int8_t dt;

    while(!(UCA0IFG&UCRXIFG));
    dt = UCA0RXBUF;

    return(dt);
}


static void send_string_uart(char *buf)
{
    uint8_t i = 0x00;
    do{
        if(buf[i] != '\0'){
            UART_putchar(buf[i]);
        }
    }while(buf[i++] != '\0');
}


#pragma vector=USCI_A0_VECTOR
__interrupt void USCI_A0_ISR(void)
{
    uint8_t dt;
    switch(__even_in_range(UCA0IV, USCI_UART_UCTXCPTIFG))
    {
        case USCI_NONE:
            break;
        case USCI_UART_UCRXIFG:
            dt = UCA0RXBUF;
            UCA0TXBUF = dt;
            while(!(UCA0IFG&UCTXIFG));
            break;
        case USCI_UART_UCTXIFG:
            break;
        case USCI_UART_UCSTTIFG:
            break;
        case USCI_UART_UCTXCPTIFG:
            break;
    }
}
