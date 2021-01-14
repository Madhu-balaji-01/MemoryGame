# Memory Game 
### This game is built using the Lucid Hardware Development Language for the Alchitry Au FPGA. 

## Game logic
1. Press the start button to begin the game
2. Sequence of LEDs will flash. 
3. Remember the sequence and press the corresponding buttons to win the level.
4. If you win the level,“PASS” will appear on the seven segment display. Press the next button to continue.
5. If you lose, “FAIL” will appear and you lose a life and you repeat the same level.
6. With progressig levels, the length of the LED sequence increases.
6. Complete all the levels before lives run out to win the game. 

## Code Structure
**au_top.luc** connects with external input and output components - LEDs, seven-segment displays, and buttons.
**gameplay.luc** is a Finite State Machine that acts as a control unit to implement the logic of the game.

A Pseudo-random generator is used to generate the sequence of lights.
A 16-bit Arithmetic Logic Unit is used to perform mathematical and logic computations.
