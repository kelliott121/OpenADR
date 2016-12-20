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
uint8_t DistanceSensorIndex = 0;



Adafruit_HMC5883_Unified mag = Adafruit_HMC5883_Unified(12345);
HCSR04* DistanceSensors[] = {
  new HCSR04(23, 22, 882), new HCSR04(29, 28, 882), new HCSR04(35, 34, 882),
  new HCSR04(41, 40, 882), new HCSR04(47, 46, 882)
};
L9110S motors(9, 8, 3, 2);
MMA8452Q accel;



uint16_t Heading = 0;

uint16_t TimeSlice = 0;
uint16_t TimeSlicePrevious = (uint16_t) - 1;



void setup()
{
  //initAccelerometer();
  //initCompass();
  initDistanceSensors();
  Serial.begin(115200);
  Serial.println("Starting");
}

void loop()
{
  uint32_t startTime = micros();
  TimeSlicePrevious = TimeSlice;
  TimeSlice = millis() % 1000;

  if (millis() > 1000)
  {
    motors.forward(0);
    motors.update();
    return;
  }

  // Don't execute on the same timeslice twice
  if (TimeSlice == TimeSlicePrevious)
  {
    return;
  }

  // 1Hz operations
  if (((TimeSlice + 0) % 1000) == 0)
  {
    //collectData();
    //readCommands();
  }

  // 10Hz operations
  if (((TimeSlice - 1) % 100) == 0)
  {
    planRoute();
    Serial.println(motors._motionState);
    printDataChunk();
  }

  // 100Hz operations
  if (((TimeSlice - 2) % 10) == 0)
  {

    //readAccelerometer();
    //readColorSensor();
    //readCompass();
    readDistanceSensors();
    //readTemperatureSensor();
  }

  // 1kHz operations
  if (((TimeSlice + 0) % 1) == 0)
  {
    //Serial.println("Motor Update");
    motors.update();
    //advanceMotors();
    //readEncoders();

    uint32_t endTime = micros();
    uint32_t time = endTime - startTime;
    //logTiming(TimeSlice, time);
    Serial.print(TimeSlice);
    Serial.print(" : ");
    Serial.println(time);
  }
}

void planRoute()
{
  if ((Distances[DEG_90] < 10) ||
      (Distances[DEG_45] < 8) || (Distances[DEG_135] < 8))
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
  /*
    for (uint8_t i = 0; i < NUM_DISTANCE_SENSORS; i++)
    {
    Distances_Previous[i] = Distances[i];
    Distances[i] = DistanceSensors[i]->getDistance(CM, 1);
    delayMicroseconds(10);
    }
  */
  Distances_Previous[DistanceSensorIndex] = Distances[DistanceSensorIndex];
  Distances[DistanceSensorIndex] = DistanceSensors[DistanceSensorIndex]->getDistance(CM, 1);
  DistanceSensorIndex = (DistanceSensorIndex + 1) % NUM_DISTANCE_SENSORS;
  //Serial.print("Distance Sensor Index : ");
  //Serial.println(DistanceSensorIndex);
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

  for (uint8_t i = 0; i < NUM_DISTANCE_SENSORS; i++)
  {
    Serial.print("point=");
    Serial.print(AngleMap[i]);
    Serial.print(",");
    Serial.println(Distances[i]);
  }
  Serial.println("==================================================");
}

