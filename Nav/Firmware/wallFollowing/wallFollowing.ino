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

#define TARGET_DISTANCE 6
#define TOLERANCE 2



// Mapping of All of the distance sensor angles
uint16_t AngleMap[] = {180, 135, 90, 45, 0};

// Array of distance sensor objects
HCSR04* DistanceSensors[] = {new HCSR04(23, 22), new HCSR04(29, 28), new HCSR04(35, 34), new HCSR04(41, 40), new HCSR04(47, 46)};
uint16_t Distances[NUM_DISTANCE_SENSORS];
uint16_t Distances_Previous[NUM_DISTANCE_SENSORS];

L9110 motors(9, 8, 3, 2);

void setup()
{
  Serial.begin(9600);

  // Initialize all distances to 0
  for (uint8_t i = 0; i < NUM_DISTANCE_SENSORS; i++)
  {
    Distances[i] = 0;
    Distances_Previous[i] = 0;
  }
}

void loop()
{
  updateSensors();

  // If there's a wall ahead
  if (Distances[DEG_90] < 10)
  {
    uint8_t minDir;
    Serial.println("Case 1");

    // Reverse slightly
    motors.backward(FULL_SPEED);
    delay(100);

    // Turn left until the wall is on the right
    do
    {
      updateSensors();
      minDir = getClosestWall();
      motors.turnLeft(FULL_SPEED);
      delay(100);
    }
    while ((Distances[DEG_90] < 10) && (minDir != DEG_0));
  }
  // If the front right sensor is closer to the wall than the right sensor, the robot is angled toward the wall
  else if ((Distances[DEG_45] <= Distances[DEG_0]) && (Distances[DEG_0] < (TARGET_DISTANCE + TOLERANCE)))
  {
    Serial.println("Case 2");

    // Turn left to straighten out
    motors.turnLeft(FULL_SPEED);
    delay(100);
  }
  // If the robot is too close to the wall and isn't getting farther
  else if ((checkWallTolerance(Distances[DEG_0]) == -1) && (Distances[DEG_0] <= Distances_Previous[DEG_0]))
  {
    Serial.println("Case 3");

    motors.turnLeft(FULL_SPEED);
    delay(100);

    motors.forward(FULL_SPEED);
    delay(100);
  }
  // If the robot is too far from the wall and isn't getting closer
  else if ((checkWallTolerance(Distances[DEG_0]) == 1) && (Distances[DEG_0] >= Distances_Previous[DEG_0]))
  {
    Serial.println("Case 4");

    motors.turnRight(FULL_SPEED);
    delay(100);

    motors.forward(FULL_SPEED);
    delay(100);
  }
  // Otherwise keep going straight
  else
  {
    motors.forward(FULL_SPEED);
    delay(100);
  }
}


// A function to retrieve the distance from all sensors
void updateSensors()
{
  for (uint8_t i = 0; i < NUM_DISTANCE_SENSORS; i++)
  {
    Distances_Previous[i] = Distances[i];
    Distances[i] = DistanceSensors[i]->getDistance(CM, 5);

    Serial.print(AngleMap[i]);
    Serial.print(":");
    Serial.println(Distances[i]);

    delay(1);
  }
}

// Retrieve the angle of the closest wall
uint8_t getClosestWall()
{
  uint8_t tempMin = 255;
  uint16_t tempDist = 500;
  for (uint8_t i = 0; i < NUM_DISTANCE_SENSORS; i++)
  {
    if (min(tempDist, Distances[i]) == Distances[i])
    {
      tempDist = Distances[i];
      tempMin = i;
    }
  }

  return tempMin;
}


// Check if the robot is within the desired distance from the wall
int8_t checkWallTolerance(uint16_t measurement)
{
  if (measurement < (TARGET_DISTANCE - TOLERANCE))
  {
    return -1;
  }
  else if (measurement > (TARGET_DISTANCE + TOLERANCE))
  {
    return 1;
  }
  else
  {
    return 0;
  }
}

