#include "Arduino.h"
#include "L9110.h"



L9110::L9110(uint8_t A_IA, uint8_t A_IB, uint8_t B_IA, uint8_t B_IB)
{
	_currentSpeedLeft = 0;
	_currentSpeedRight = 0;

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
	//motorAForward(speed);
	//motorBForward(speed);
	setSpeed((uint16_t)speed, (uint16_t)speed);
}


void L9110::backward(uint8_t speed)
{
	//motorABackward(speed);
	//motorBBackward(speed);
	setSpeed(-((uint16_t)speed), -((uint16_t)speed));
}


void L9110::turnLeft(uint8_t speed)
{
	//motorABackward(speed);
	//motorBForward(speed);
	setSpeed(-((uint16_t)speed), (uint16_t)speed);
}


void L9110::turnRight(uint8_t speed)
{
	//motorAForward(speed);
	//motorBBackward(speed);
	setSpeed((uint16_t)speed, -((uint16_t)speed));
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


void L9110::setSpeed(int16_t speedLeft, int16_t speedRight)
{
	int16_t speedChangeLeft;
	int16_t speedChangeRight;
	int8_t incrementLeft;
	int8_t incrementRight;

	speedChangeLeft = speedLeft - _currentSpeedLeft;
	speedChangeRight = speedRight - _currentSpeedRight;

	if (speedChangeLeft > 0)
	{
		// The for loop will be iterating in the
		// positive direction (acceleration).
		incrementLeft = 1;
	}
	else if (speedChangeLeft < 0)
	{
		// The for loop will be iterating in the
		// negative direction (deceleration).
		incrementLeft = -1;
	}

	if (speedChangeRight > 0)
	{
		// The for loop will be iterating in the
		// positive direction (acceleration).
		incrementRight = 1;
	}
	else if (speedChangeRight < 0)
	{
		// The for loop will be iterating in the
		// negative direction (deceleration).
		incrementRight = -1;
	}

	while (_currentSpeedLeft != speedLeft || _currentSpeedRight != speedRight)
	{
		if (_currentSpeedLeft != speedLeft)
		{
			_currentSpeedLeft += incrementLeft;
		}

		if (_currentSpeedRight != speedRight)
		{
			_currentSpeedRight += incrementRight;
		}
		
		updateSpeed();
		
		delay(1);
	}
}


void L9110::updateSpeed(void)
{
	if (_currentSpeedLeft < 0)
	{
		motorABackward(abs(_currentSpeedLeft));
	}
	else
	{
		motorAForward(abs(_currentSpeedLeft));
	}
	
	if (_currentSpeedRight < 0)
	{
		motorBBackward(abs(_currentSpeedRight));
	}
	else
	{
		motorBForward(abs(_currentSpeedRight));
	}
}


