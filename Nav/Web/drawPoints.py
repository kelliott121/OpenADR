from PIL import Image, ImageDraw
import math
import time
import random
import serial
import json

# The scaling of the image is 1cm:1px

# JSON file to output to
jsonFile = "data.json"

# The graphical center of the robot in the image
centerPoint = (415, 415)

# Width of the robot in cm/px
robotWidth = 30

# Radius of the wheels on the robot
wheelRadius = 12.8

# Minimum sensing distance
minSenseDistance = 2

# Maximum sensing distance
maxSenseDistance = 400

# The distance from the robot to display the turn vector at
turnVectorDistance = 5

# Initialize global data variables
points = {}
velocityVector = [0, 0]

# Serial port to use
serialPort = "/dev/ttyACM0"

robotData = {}

ser = serial.Serial(serialPort, 115200)

# Parses a serial line from the robot and extracts the
# relevant information
def parseLine(line):
        status = line.split('=')
        statusType = status[0]

        # Parse the obstacle location
        if statusType == "point":
                coordinates = status[1].split(',')
                points[int(coordinates[0])] = int(coordinates[1])
        # Parse the velocity of the robot (x, y)
        elif statusType == "velocity":
                velocities = status[1].split(',')
                velocityVector[0] = int(velocities[0])
                velocityVector[1] = int(velocities[1])
        
def main():
        # Three possible test print files to simulate the serial link
        # to the robot
        #testPrint = open("TEST_straight.txt")
        #testPrint = open("TEST_tightTurn.txt")
        #testPrint = open("TEST_looseTurn.txt")

        time.sleep(1)

        ser.write('1');


        #for line in testPrint:
        while True:
                # Flush the input so we get the latest data and don't fall behind
                #ser.flushInput()
                line = ser.readline()

                parseLine(line.strip())

                robotData["points"] = points
                robotData["velocities"] = velocityVector

                #print json.dumps(robotData)
                jsonFilePointer = open(jsonFile, 'w')
                jsonFilePointer.write(json.dumps(robotData))
                jsonFilePointer.close()

                #print points

if __name__ == '__main__':
        try:
                main()
        except KeyboardInterrupt:
                print "Quitting"
                ser.write('0');
