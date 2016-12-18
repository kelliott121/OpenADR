#include <HCSR04.h>

HCSR04 DistanceSensor(0, 4);

void setup()
{
  // put your setup code here, to run once:

}

void loop()
{
  uint16_t distance = 0;
  // put your main code here, to run repeatedly:
  distance = DistanceSensor.getDistance(CM, 5);

  Serial.println(distance);
}
