        #include <nxp\iolpc2148.h>
        
        #define DEL_Value  0X5ffff  // This value can be changed a/c to speed requirement.
        
        
        NAME     DHANANJAY          // Any name  
        PUBLIC   __iar_program_start
        SECTION .intvec : CODE (2)
        CODE32 
         
__iar_program_start

       B  main
       SECTION .text : CODE (2)
       CODE32
 
DELAY:                         
        LDR R0,=DEL_Value    // 32 Bit delay
        LOOP: 
            SUBS R0,R0,#1
        BNE LOOP
        MOV PC,LR   // return statement         
        
main:  NOP                           //To Select the p1.16-p1.23 as gpio lines
       LDR R0,=PINSEL2
       MOV R1,#0X00000000       
       STR R1,[R0]

//To Set the p1.16-p1.23 as output
       LDR R0,=IO1DIR
       MOV R1,#0Xff000000
       STR R1,[R0]

led_glow:   
     //To Set high on port lines p1.16-p1.23     
       LDR R0,=IO1PIN
       MOV R1,#0Xff000000     
       STR R1,[R0]   
       BL DELAY
        
     //To Set low on port lines p1.16-p1.23            
       LDR R0,=IO1PIN
       MOV R1,#0X00000000     
       STR R1,[R0]
       BL DELAY
       B led_glow 
       
stop   B stop      // Infinite loop
 
       END  
 
