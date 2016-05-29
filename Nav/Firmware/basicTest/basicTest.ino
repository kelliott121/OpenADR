#include <L9110.h>
#include <HCSR04.h>



#define HALF_SPEED 127
#define FULL_SPEED 255

#define NUM_DISTANCE_SENSORS 5
#define DEG_180 0
#define DEG_135 1
#define DEG_90 2
#define DEG_45 3
#define DEG_0 4



uint16_t AngleMap[] = {180, 135, 90, 45, 0};

HCSR04* DistanceSensors[] = {new HCSR04(23, 22), new HCSR04(29, 28), new HCSR04(35, 34), new HCSR04(41, 40), new HCSR04(47, 46)};
uint16_t Distances[NUM_DISTANCE_SENSORS];

L9110 motors(9, 8, 3, 2);

void setup()
{
  Serial.begin(9600);
  pinMode(29, OUTPUT);
  pinMode(28, OUTPUT);

}

void loop()
{
  updateSensors();

  motors.forward(FULL_SPEED);
  delay(1000);
  motors.backward(FULL_SPEED);
  delay(1000);
  motors.turnLeft(FULL_SPEED);
  delay(1000);
  motors.turnRight(FULL_SPEED);
  delay(1000);
  motors.forward(0);
  delay(6000);
}


void updateSensors()
{
  for (uint8_t i = 0; i < NUM_DISTANCE_SENSORS; i++)
  {
    Distances[i] = DistanceSensors[i]->getDistance(CM, 5);
    Serial.print(AngleMap[i]);
    Serial.print(":");
    Serial.println(Distances[i]);
  }
}

