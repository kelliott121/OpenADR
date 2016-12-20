#include "Arduino.h"
#include "HCSR04.h"


HCSR04::HCSR04(uint8_t triggerPin, uint8_t echoPin)
{
	pinMode(triggerPin, OUTPUT);
	pinMode(echoPin, INPUT);
	_triggerPin = triggerPin;
	_echoPin = echoPin;
	_timeout = 23510;
}

HCSR04::HCSR04(uint8_t triggerPin, uint8_t echoPin, uint32_t timeout)
{
	pinMode(triggerPin, OUTPUT);
	pinMode(echoPin, INPUT);
	_triggerPin = triggerPin;
	_echoPin = echoPin;
	_timeout = timeout;
}

uint32_t HCSR04::timing()
{
	uint32_t duration = 0;
	
	digitalWrite(_triggerPin, LOW);
	delayMicroseconds(2);
	digitalWrite(_triggerPin, HIGH);
	delayMicroseconds(10);
	digitalWrite(_triggerPin, LOW);
	duration = pulseIn(_echoPin, HIGH, _timeout);
	
	if (duration == 0)
	{
		duration = _timeout;
	}
	
  return duration;
}

uint16_t HCSR04::getDistance(uint8_t units, uint8_t samples)
{
	uint32_t duration = 0;
	uint16_t distance;
	
	for (uint8_t i = 0; i < samples; i++)
	{
		duration += timing();
	}
	
	duration /= samples;
	
	if (units == CM)
	{
		distance = duration / 29 / 2 ;
	}
	else if (units == INCH)
	{
		distance = duration / 74 / 2;
	}
	
	return distance;
}
