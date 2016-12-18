#ifndef L9110S_H
#define L9110S_H



#include "Arduino.h"



#define FULL_SPEED 255
#define SPEED_INC 15
#define STOP_DELAY 100



enum MotionState {STOPPED, ACCELERATING, MOVING, STOPPING};



class L9110S
{
  public:
	L9110S(uint8_t A_IA, uint8_t A_IB, uint8_t B_IA, uint8_t B_IB);
	void forward(uint8_t speed);
	void backward(uint8_t speed);
	void turnLeft(uint8_t speed);
	void turnRight(uint8_t speed);
	void update();
	void setMotionTime(uint16_t time);
	MotionState _motionState;

  private:
	int16_t _currentSpeedLeft;
	int16_t _currentSpeedRight;
	int16_t _targetSpeedLeft;
	int16_t _targetSpeedRight;
	uint8_t _A_IA;
	uint8_t _A_IB;
	uint8_t _B_IA;
	uint8_t _B_IB;
	uint16_t _stopDelay;

	void setSpeed(int16_t speedLeft, int16_t speedRight);
	void setTargetSpeed(int16_t speedLeft, int16_t speedRight);
	void motorAForward(uint8_t speed);
	void motorABackward(uint8_t speed);
	void motorBForward(uint8_t speed);
	void motorBBackward(uint8_t speed);
};

#endif
