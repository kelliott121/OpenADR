#ifndef L9110_H
#define L9110_H

#include "Arduino.h"

class L9110
{
  public:
	L9110(uint8_t A_IA, uint8_t A_IB, uint8_t B_IA, uint8_t B_IB);
	void forward(uint8_t speed);
	void backward(uint8_t speed);
	void turnLeft(uint8_t speed);
	void turnRight(uint8_t speed);

  private:
    uint8_t _A_IA;
    uint8_t _A_IB;
    uint8_t _B_IA;
    uint8_t _B_IB;
	
	void motorAForward(uint8_t speed);
	void motorABackward(uint8_t speed);
	void motorBForward(uint8_t speed);
	void motorBBackward(uint8_t speed);
};

#endif
