        #include <nxp\iolpc2148.h>

        NAME     LED_SWITCH          // Any name  
        PUBLIC   __iar_program_start
        SECTION .intvec : CODE (2)
        CODE32 
         
__iar_program_start

       B  main
       SECTION .text : CODE (2)
       CODE32

//----------- Delay Subroutine -------------------
delay:      
        LDR R0,=0Xf   // delay value
        LOOP: 
            SUBS R0,R0,#1
        BNE LOOP
        MOV PC,LR   // return statement     
   
//----------- Main function starts here  -------------------

main:  NOP 
       LDR R0,=PINSEL1
       MOV R1,#0X00000000   // Configure the port as GPIO.    
       STR R1,[R0]
                          
       LDR R0,=PINSEL2
       MOV R1,#0X00000000   // Configure the port as GPIO .    
       STR R1,[R0]

        
       LDR R0,=IO1DIR
       MOV R1,#0Xff000000  //To Set the p0.24-p0.31 as output ( LED )
       STR R1,[R0]
       
       
       LDR R0,=IO0DIR     
       MOV R1,#0X00000000  //To Set the p0.16-p1.23 as input ( SWITCH )
       STR R1,[R0]
       
       
GLOW_LED 

      LDR R0,=IO0PIN      // READ the SWITCHs address  in R0
      LDR R1,[R0]         // Move the read value from R0 to R1 
      LSL R1,R1,#8        // Shift the value 8-bit left
      MOV R2,#0XFF000000  
      AND R2,R2,R1        // Make unused bits = 0 
      LDR R0,=IO1PIN      // STORE LEDs address to R0
      STR R2,[R0]         // Store the switches value at LED address
      
      BL delay            // After some delay     
      B GLOW_LED          // Repeat the same forever 
       
stop   B stop              // Halt
 
       END  
 
