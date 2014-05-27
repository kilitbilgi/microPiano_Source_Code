// Glcd module connections
sbit GLCD_D7 at RD7_bit;
sbit GLCD_D6 at RD6_bit;
sbit GLCD_D5 at RD5_bit;
sbit GLCD_D4 at RD4_bit;
sbit GLCD_D3 at RD3_bit;
sbit GLCD_D2 at RD2_bit;
sbit GLCD_D1 at RD1_bit;
sbit GLCD_D0 at RD0_bit;
sbit GLCD_D7_Direction at TRISD7_bit;
sbit GLCD_D6_Direction at TRISD6_bit;
sbit GLCD_D5_Direction at TRISD5_bit;
sbit GLCD_D4_Direction at TRISD4_bit;
sbit GLCD_D3_Direction at TRISD3_bit;
sbit GLCD_D2_Direction at TRISD2_bit;
sbit GLCD_D1_Direction at TRISD1_bit;
sbit GLCD_D0_Direction at TRISD0_bit;

sbit GLCD_CS1 at LATB0_bit;
sbit GLCD_CS2 at LATB1_bit;
sbit GLCD_RS  at LATB2_bit;
sbit GLCD_RW  at LATB3_bit;
sbit GLCD_EN  at LATB5_bit;
sbit GLCD_RST at LATB4_bit;
sbit GLCD_CS1_Direction at TRISB0_bit;
sbit GLCD_CS2_Direction at TRISB1_bit;
sbit GLCD_RS_Direction  at TRISB2_bit;
sbit GLCD_RW_Direction  at TRISB3_bit;
sbit GLCD_EN_Direction  at TRISB5_bit;
sbit GLCD_RST_Direction at TRISB4_bit;
// End Glcd module connections

const LINE_LEN = 43;
//char err_txt[20] = "FAT16 not found";
//char file_contents[LINE_LEN] = "XX MMC/SD FAT16 library by Anton Rieckert\n";
char           filename[14] = "notes.txt";          // File names
unsigned short loop, loop2;
unsigned long  k,size;
char           Buffer[512];

//5 seconds delay function
void delay(){
  Delay_ms(5000);
}

//15 seconds delay function
void delay1(){
  Delay_ms(15000);
}

//Function for clear the screen
void clrscr(){
     Glcd_Fill(0x00);
}

char *notes;
void M_Open_File_Read() {
   //filename[7] = 'B';
//  Mmc_Fat_Assign(&filename, 0);
  Mmc_Fat_Reset(&size);                 // To read file, procedure returns size of file
  for (k = 1; k <= size; k++) {
    Mmc_Fat_Read(&notes);
    Glcd_Write_Text(notes,2,2,2);
}
}

//Function for Writing Song to GLCD
void GLCDFirstSong(){
   char *song_name , *note1 , *note2 , *note3 , *note4;
   clrscr();
   song_name = "Artik Sevmeyecegim";
   note1 = "mi-fa-sol-fa-mi-re-mi";
   note2 = "mi-fa-sol-la-si-do-si";
   note3 = "la-si-do-re-do-si-la";
   note4 = "sol-la-si-do-si-la";

   //Write Song Name on GLCD
   Glcd_Write_Text(song_name,2,0,2);

   //Write Song Notes to GLCD
   Glcd_Write_Text(note1,2,2,2);
   Glcd_Write_Text(note2,2,3,2);
   Glcd_Write_Text(note3,2,4,2);
   Glcd_Write_Text(note4,2,5,2);
}

//Function for Writing Song to GLCD
void GLCDSecondSong(){
   char *song_name , *note1 , *note2 , *note3 , *note4;
   song_name = "Neseli Ol Ki Genc Kalasin";
   note1 = "Do-do-re-mi-mi-re-re";
   note2 = "do-re-mi-do-mi-mi-fa";
   note3 = "sol-sol-fa-mi-fa-sol";
   note4 = "sol-do-do-re-mi-mi";

   //Write Song Name to GLCD
   Glcd_Write_Text(song_name,2,0,2);

   //Write Song Notes to GLCD
   Glcd_Write_Text(note1,2,2,2);
   Glcd_Write_Text(note2,2,3,2);
   Glcd_Write_Text(note3,2,4,2);
   Glcd_Write_Text(note4,2,5,2);
}

//function for starting piano
void startPiano(){
     while(1){
     //4.Oktav Do
     if(Button(&PORTF,7,1,1))
     Sound_Play(261.6, 300);
     while(PORTF.F7);

     //4.Oktav Re
     if(Button(&PORTF,6,1,1))
     Sound_Play(293.6, 300);
     while(PORTF.F6);

     //4.Oktav Mi
      if(Button(&PORTF,5,1,1))
      Sound_Play(329.6, 300);
      while(PORTF.F5);

      //4.Oktav Fa
      if(Button(&PORTF,4,1,1))
      Sound_Play(349.28, 300);
      while(PORTF.F4);

      //4.Oktav Sol
      if(Button(&PORTF,3,1,1))
      Sound_Play(392.28, 300);
      while(PORTF.F3);

      //4.Oktav La
      if(Button(&PORTF,2,1,1))
      Sound_Play(440.00, 300);
      while(PORTF.F2);

      //4.Oktav Si
      if(Button(&PORTF,1,1,1))
      Sound_Play(493.00, 300);
      while(PORTF.F1);

      //5.Oktav Do
      if(Button(&PORTF,0,1,1))
      Sound_Play(523.00, 300);
      while(PORTF.F0);

      //5.Oktav Re
      if(Button(&PORTF,8,1,1))
      Sound_Play(587.20, 300);
      while(PORTF.F8);

    }
}

void GLCDWelcome(){
   char *welcome;
   welcome = "Welcome to MicroPiano";
   clrscr();
   //Write Welcome Message to GLCD
   Glcd_Write_Text(welcome,2,1,2);

   //Write Song Loading Message to GLCD
   welcome = "Song is loading";
   Glcd_Write_Text(welcome,2,3,2);

   //Write Copyright Text to GLCD
   welcome = "Project by Burak&Mali";
   Glcd_Write_Text(welcome,2,4,2);

   //Delay for some seconds
   delay1();

   //Clear the screen for writing song to GLCD
   clrscr();
}

void main() {
  ADPCFG = 0xFFFF;      // Configure AN pins as digital
  TRISG = 0xffff;
  Glcd_init();

  clrscr();
  //Display welcome screen
  GLCDWelcome();

  //Song is loading
  GLCDFirstSong();

  PORTC = 0xAA;
  Sound_Init(&PORTC, 1);

  //Start main piano function
  startPiano();
}