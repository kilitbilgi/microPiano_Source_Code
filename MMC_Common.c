/*
 * Project name:
     Mmc_Test (MMC Library Example)
 * Copyright:
     (c) MikroElektronika, 2009.
 * Revision History:
     20091030:
       - initial release;
 * Description:
     MMC library test. Upon flashing, insert a MMC/SD card into the
     module, when you should receive the "Init-OK" message.
     Then, you can experiment with MMC read and write functions,
     and observe the results through the Usart Terminal.
 * Test configuration:
     MCU:             dsPIC30F4013
                      http://ww1.microchip.com/downloads/en/DeviceDoc/70138F.pdf
     Dev.Board:       EasydsPIC6
                      http://www.mikroe.com/eng/products/view/434/easydspic6-development-system/
     Oscillator:      XT-PLL 8x, 10.00000 MHz
     Ext. Modules:    ac:MMC module on PORTF
     SW:              mikroC PRO for dsPIC30/33 and PIC24
                      http://www.mikroe.com/eng/products/view/231/mikroc-pro-for-dspic30-33-and-pic24/
 * NOTES:
     - Connect RS232 cable and turn on RS232 jumpers J8 and J9 (RC13 & RC14). (board specific)
     - Turn on dsPIC switches on MMC board and connect it to PORTF
     - This is NOT an example for working with FILES on a MMC/SD memory module.
     - This example should work both for MMC and SD media types.
 */

// MMC module connections
sbit Mmc_Chip_Select           at LATG0_bit;  // for writing to output pin always use latch
sbit Mmc_Chip_Select_Direction at TRISG0_bit;
// eof MMC module connections

// Variables for MMC routines
unsigned char SectorData[512];        // Buffer for MMC sector reading/writing
unsigned char data_for_registers[16]; // buffer for CID and CSD registers

// UART1 write text and new line (carriage return + line feed)
void UART1_Write_Line(char *uart_text) {
  UART1_Write_Text(uart_text);
  UART1_Write(13);
  UART1_Write(10);
}

// Display byte in hex
void PrintHex(unsigned char i) {
  unsigned char hi,lo;

  hi = i & 0xF0;               // High nibble
  hi = hi >> 4;
  hi = hi + '0';
  if (hi>'9') hi=hi+7;
  lo = (i & 0x0F) + '0';       // Low nibble
  if (lo>'9') lo=lo+7;

  UART1_Write(hi);
  UART1_Write(lo);
}

  const char   FILL_CHAR = 'm';
  unsigned int i, SectorNo;
  char         mmc_error;
  bit          data_ok;