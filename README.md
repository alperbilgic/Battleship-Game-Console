# Battleship-Game-Console

It is an implementation of the famous Battleship game where one player places the ships and the other one tries to bomb them. The game play steps are given below:
  - Start  button is pressed by the first player(P1).
  - P1 places the ships with a botton for battleships and another one for citizenships
  - When the placement is done the screen is locked.
  - P2 needs to hit the start button to have the placement of those ships for 0.5 seconds.
  - After that 0.5 second of view, P2 has 20 seconds to place bombs. 
  - P2 needs to hit all battleships without hitting any of those citizenships
  - The winner is determined.
  
## PROCESSOR AND HARDWARE COMPONENTS

TIVA TM4C123GH6PM launchpad is used as the micropcocessor and NOKIA 5110 LCD screen is used for display issues. NOKIA LCD and TIVA card has SPI communication. The ADC feature of TIVA launchpad is used with two pots(one for vertical, one for horizontal movement) for cursor mobility. 
  
  ## HOW TO RUN THE CODE
  
  This project was written in Assembly Language in KEIL Embedded Developement Tools. One needs to create a new project and add the whole ".s" files to this project. By building and loading the code to TIVA card the the game may be started. 
  
  ## PIN CONNECTIONS FOR NOKIA 5110 LCD
  
   - NOKIA_VCC : TIVA_3V_OUT
   - NOKIA_GND : TIVA_GND
   - NOKIA_SCE : TIVA_PA3
   - NOKIA_RESET : May be left empty (No configuraiton had been done for this pin. One should add it to code if required)
   - NOKIA_D/C   : TIVA_PA6
   - NOKIA_SDIN  : TIVA_PA5
   - NOKIA_SCLK  : TIVA_PA2
   - NOKIA_LED   : Any GND or VCC
