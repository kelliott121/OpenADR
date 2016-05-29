#ifndef HCSR04_H
#define HCSR04_H

#include "Arduino.h"

#define CM 1
#define INCH 0

class HCSR04
{
  public:
	HCSR04(uint8_t triggerPin, uint8_t echoPin);
	HCSR04(uint8_t triggerPin, uint8_t echoPin, uint32_t timeout);
    uint32_t timing();
    uint16_t getDistance(uint8_t units, uint8_t samples);

  private:
    uint8_t _triggerPin;
    uint8_t _echoPin;
	uint32_t _timeout;
};

#endif
