#include "Arduino.h"
#include "L9110.h"



L9110::L9110(uint8_t A_IA, uint8_t A_IB, uint8_t B_IA, uint8_t B_IB)
{
	_A_IA = A_IA;
	_A_IB = A_IB;
	_B_IA = B_IA;
	_B_IB = B_IB;
	
	pinMode(_A_IA, OUTPUT);
	pinMode(_A_IB, OUTPUT);
	pinMode(_B_IA, OUTPUT);
	pinMode(_B_IB, OUTPUT);
}


void L9110::forward(uint8_t speed)
{
	motorAForward(speed);
	motorBForward(speed);
}


void L9110::backward(uint8_t speed)
{
	motorABackward(speed);
	motorBBackward(speed);
}


void L9110::turnLeft(uint8_t speed)
{
	motorABackward(speed);
	motorBForward(speed);
}


void L9110::turnRight(uint8_t speed)
{
	motorAForward(speed);
	motorBBackward(speed);
}


void L9110::motorAForward(uint8_t speed)
{
	digitalWrite(_A_IA, LOW);
    analogWrite(_A_IB, speed);
}


void L9110::motorABackward(uint8_t speed)
{
	digitalWrite(_A_IB, LOW);
    analogWrite(_A_IA, speed);
}


void L9110::motorBForward(uint8_t speed)
{
	digitalWrite(_B_IA, LOW);
    analogWrite(_B_IB, speed);	
}


void L9110::motorBBackward(uint8_t speed)
{
	digitalWrite(_B_IB, LOW);
    analogWrite(_B_IA, speed);	
}
