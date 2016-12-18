#include <L9110S.h>
#include <HCSR04.h>
#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_HMC5883_U.h>
#include <SparkFun_MMA8452Q.h>



#define NUM_DISTANCE_SENSORS 5
#define DEG_180 0
#define DEG_135 1
#define DEG_90 2
#define DEG_45 3
#define DEG_0 4
// Mapping of All of the distance sensor angles
uint16_t AngleMap[] = {
  180, 135, 90, 45, 0
};
uint16_t Distances[NUM_DISTANCE_SENSORS];
uint16_t Distances_Previous[NUM_DISTANCE_SENSORS];



Adafruit_HMC5883_Unified mag = Adafruit_HMC5883_Unified(12345);
HCSR04* DistanceSensors[] = {
  new HCSR04(23, 22), new HCSR04(29, 28), new HCSR04(35, 34),
  new HCSR04(41, 40), new HCSR04(47, 46)
};
L9110S motors(9, 8, 3, 2);
MMA8452Q accel;



uint16_t Heading = 0;



void setup()
{
  initAccelerometer();
  initCompass();
  initDistanceSensors();
  Serial.begin(115200);
}

void loop()
{
  uint32_t startTime = micros();
  uint32_t timeSlice = millis() % 1000;

  if (millis() > 60000)
  {
    motors.forward(0);
    motors.update();
    return;
  }

  // 1Hz operations
  if (((timeSlice + 0) % 1000) == 0)
  {
    //collectData();
    //readCommands();
  }

  // 10Hz operations
  if (((timeSlice - 1) % 100) == 0)
  {
    planRoute();
    Serial.println(motors._motionState);
    printDataChunk();
  }

  // 100Hz operations
  if (((timeSlice - 2) % 10) == 0)
  {

    //readAccelerometer();
    //readColorSensor();
    //readCompass();
    readDistanceSensors();
    //readTemperatureSensor();
  }

  // 1kHz operations
  if (((timeSlice + 0) % 1) == 0)
  {
	Serial.println("Motor Update");
    motors.update();
    //advanceMotors();
    //readEncoders();
  }

  uint32_t endTime = micros();
  uint32_t time = endTime - startTime;
  //logTiming(timeSlice, time);
  Serial.print(timeSlice);
  Serial.print(" : ");
  Serial.println(time);
}

void planRoute()
{
  if ((Distances[DEG_90] < 15) ||
	  (Distances[DEG_45] < 11) || (Distances[DEG_135] < 11))
  {
    Serial.println("TURNING LEFT");
    motors.turnLeft(FULL_SPEED);
  }
  else
  {
    motors.forward(FULL_SPEED);
  }
}

void initDistanceSensors()
{
  // Initialize all distances to 0
  for (uint8_t i = 0; i < NUM_DISTANCE_SENSORS; i++)
  {
    Distances[i] = 0;
    Distances_Previous[i] = 0;
  }
}

void readDistanceSensors()
{
  for (uint8_t i = 0; i < NUM_DISTANCE_SENSORS; i++)
  {
    Distances_Previous[i] = Distances[i];
    Distances[i] = DistanceSensors[i]->getDistance(CM, 5);
    delayMicroseconds(10);
  }
}

void initAccelerometer()
{
  accel.init(SCALE_2G, ODR_200);
}

void readAccelerometer()
{
  if (accel.available())
  {
    accel.read();
  }
}

void initCompass()
{
  if (!mag.begin())
  {
    /* There was a problem detecting the HMC5883 ... check your connections */
    Serial.println("HMC5883 initialization failed!");
    while (1);
  }
}

void readCompass()
{
  sensors_event_t event;
  mag.getEvent(&event);

  float heading = atan2(event.magnetic.y, event.magnetic.x);
  // Once you have your heading, you must then add your 'Declination Angle', which is the 'Error' of the magnetic field in your location.
  // Find yours here: http://www.magnetic-declination.com/
  // Mine is: -13* 2' W, which is ~13 Degrees, or (which we need) 0.22 radians
  // If you cannot find your Declination, comment out these two lines, your compass will be slightly off.
  float declinationAngle = 0.16;
  heading += declinationAngle;

  // Correct for when signs are reversed.
  if (heading < 0)
    heading += 2 * PI;

  // Check for wrap due to addition of declination.
  if (heading > 2 * PI)
    heading -= 2 * PI;

  // Convert radians to degrees for readability.
  Heading = round(heading * 180 / M_PI);
}


void printDataChunk()
{
  /*
  Serial.print("comp=");
  Serial.println(Heading);

  Serial.print("accelX=");
  Serial.println(accel.x);
  Serial.print("accelY=");
  Serial.println(accel.y);
  Serial.print("accelZ=");
  Serial.println(accel.z);
*/
/*
  for (uint8_t i = 0; i < NUM_DISTANCE_SENSORS; i++)
  {
    Serial.print("point=");
    Serial.print(AngleMap[i]);
    Serial.print(",");
    Serial.println(Distances[i]);
  }*/
  Serial.println("==================================================");
}

