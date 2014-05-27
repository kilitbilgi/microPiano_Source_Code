#line 1 "C:/Users/burakc/Desktop/com320Project/MMC_Common.c"
#line 31 "C:/Users/burakc/Desktop/com320Project/MMC_Common.c"
sbit Mmc_Chip_Select at LATG0_bit;
sbit Mmc_Chip_Select_Direction at TRISG0_bit;



unsigned char SectorData[512];
unsigned char data_for_registers[16];


void UART1_Write_Line(char *uart_text) {
 UART1_Write_Text(uart_text);
 UART1_Write(13);
 UART1_Write(10);
}


void PrintHex(unsigned char i) {
 unsigned char hi,lo;

 hi = i & 0xF0;
 hi = hi >> 4;
 hi = hi + '0';
 if (hi>'9') hi=hi+7;
 lo = (i & 0x0F) + '0';
 if (lo>'9') lo=lo+7;

 UART1_Write(hi);
 UART1_Write(lo);
}

 const char FILL_CHAR = 'm';
 unsigned int i, SectorNo;
 char mmc_error;
 bit data_ok;
