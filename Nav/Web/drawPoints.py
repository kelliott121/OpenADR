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

# Calculate the turn radius of the robot from the two velocities
def calculateTurnRadius():
        print "Velocity:\t" + str(velocityVector)
        slope = ((velocityVector[1] - velocityVector[0]) / 10.0) / (2.0 * wheelRadius)
        yOffset = ((max(velocityVector) + min(velocityVector)) / 10.0) / 2.0
        xOffset = 0
        if slope != 0:
                xOffset = int((-yOffset) / slope)

        return abs(xOffset)

# Calculate the angle required to display a turn vector with
# a length that matched the magnitude of the motion
def calculateTurnLength(turnRadius, vectorMagnitude):
        circumference = 2 * math.pi * turnRadius
        return int(round(abs((vectorMagnitude / circumference) * 360)))

        
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
        '''
                im = Image.new("RGB", (830, 450))

                draw = ImageDraw.Draw(im)

                # Draw the robot
                minDistX = centerPoint[0] - (robotWidth / 2)
                minDistY = centerPoint[1] - (robotWidth / 2)
                maxDistX = centerPoint[0] + (robotWidth / 2)
                maxDistY = centerPoint[1] + (robotWidth / 2)
                draw.arc([(minDistX, minDistY), (maxDistX, maxDistY)], 0, 360, fill="yellow")

                # Draw the robot's minimum sensing distance as a circle
                minDistSenseX_Inner = minDistX - minSenseDistance
                minDistSenseY_Inner = minDistY - minSenseDistance
                minDistSenseX_Outer = maxDistX + minSenseDistance
                minDistSenseY_Outer = maxDistY + minSenseDistance
                draw.arc([(minDistSenseX_Inner, minDistSenseY_Inner), (minDistSenseX_Outer, minDistSenseY_Outer)], 0, 360, fill="green")

                # Draw the robot's maximum sensing distance as a circle
                maxDistSenseX_Inner = minDistX - maxSenseDistance
                maxDistSenseY_Inner = minDistY - maxSenseDistance
                maxDistSenseX_Outer = maxDistX + maxSenseDistance
                maxDistSenseY_Outer = maxDistY + maxSenseDistance
                draw.arc([(maxDistSenseX_Inner, maxDistSenseY_Inner), (maxDistSenseX_Outer, maxDistSenseY_Outer)], 0, 360, fill="orange")

                vectorMagnitude = (((velocityVector[0] + velocityVector[1]) / 2.0) / 2.5)
                if (velocityVector[0] == velocityVector[1]):
                        vectorEndY = centerPoint[1] - vectorMagnitude
                        draw.line([centerPoint[0], centerPoint[1], centerPoint[0], vectorEndY], fill="purple", width=1)
                else:
                        turnRadius = calculateTurnRadius()

                        if turnRadius == 0:
                                turnVectorX_Inner = minDistX - turnVectorDistance
                                turnVectorY_Inner = minDistY - turnVectorDistance
                                turnVectorX_Outer = maxDistX + turnVectorDistance
                                turnVectorY_Outer = maxDistY + turnVectorDistance

                                outsideRadius = turnVectorDistance + (robotWidth / 2.0)
                                rotationMagnitude = (((abs(velocityVector[0]) + abs(velocityVector[1])) / 2.0) / 2.5)
                                turnAngle = calculateTurnLength(outsideRadius, rotationMagnitude)

                                if velocityVector[0] < velocityVector[1]:
                                        draw.arc([(turnVectorX_Inner,turnVectorY_Inner), (turnVectorX_Outer,turnVectorY_Outer)], 270 - turnAngle, 270, fill="purple")
                                if velocityVector[0] > velocityVector[1]:
                                        draw.arc([(turnVectorX_Inner,turnVectorY_Inner), (turnVectorX_Outer,turnVectorY_Outer)], 270, 270 + turnAngle, fill="purple")
                        else:
                                turnAngle = 0
                                if vectorMagnitude != 0:
                                        turnAngle = calculateTurnLength(turnRadius, vectorMagnitude)

                                # Turning forward and left
                                if (velocityVector[0] < velocityVector[1]) and (velocityVector[0] + velocityVector[1] > 0):
                                        turnVectorX_Inner = centerPoint[0] - (turnRadius * 2)
                                        turnVectorY_Inner = centerPoint[1] - turnRadius
                                        turnVectorX_Outer = centerPoint[0]
                                        turnVectorY_Outer = centerPoint[1] + turnRadius
                                        draw.arc([(turnVectorX_Inner,turnVectorY_Inner), (turnVectorX_Outer,turnVectorY_Outer)], -turnAngle, 0, fill="purple")
                                # Turning backwards and left
                                elif (velocityVector[0] > velocityVector[1]) and (velocityVector[0] + velocityVector[1] < 0):
                                        turnVectorX_Inner = centerPoint[0] - (turnRadius * 2)
                                        turnVectorY_Inner = centerPoint[1] - turnRadius
                                        turnVectorX_Outer = centerPoint[0]
                                        turnVectorY_Outer = centerPoint[1] + turnRadius
                                        draw.arc([(turnVectorX_Inner,turnVectorY_Inner), (turnVectorX_Outer,turnVectorY_Outer)], 0, turnAngle, fill="purple")
                                # Turning forwards and right
                                elif (velocityVector[0] > velocityVector[1]) and (velocityVector[0] + velocityVector[1] > 0):
                                        turnVectorX_Inner = centerPoint[0]
                                        turnVectorY_Inner = centerPoint[1] - turnRadius
                                        turnVectorX_Outer = centerPoint[0] + (turnRadius * 2)
                                        turnVectorY_Outer = centerPoint[1] + turnRadius
                                        draw.arc([(turnVectorX_Inner,turnVectorY_Inner), (turnVectorX_Outer,turnVectorY_Outer)], 180, 180 + turnAngle, fill="purple")
                                # Turning backwards and right
                                elif (velocityVector[0] < velocityVector[1]) and (velocityVector[0] + velocityVector[1] < 0):
                                        turnVectorX_Inner = centerPoint[0]
                                        turnVectorY_Inner = centerPoint[1] - turnRadius
                                        turnVectorX_Outer = centerPoint[0] + (turnRadius * 2)
                                        turnVectorY_Outer = centerPoint[1] + turnRadius
                                        draw.arc([(turnVectorX_Inner,turnVectorY_Inner), (turnVectorX_Outer,turnVectorY_Outer)], 180 - turnAngle, 180, fill="purple")

                for angle in points.keys():
                        xDist = centerPoint[0] + int(round(((robotWidth / 2) + points[angle]) * math.cos(math.radians(angle))))
                        yDist = centerPoint[1] - int(round(((robotWidth / 2) + points[angle]) * math.sin(math.radians(angle))))
                        draw.rectangle([(xDist - 1, yDist - 1), (xDist + 1, yDist + 1)], fill="red", outline="red")

                del draw

                # write out the new file
                im.save("points.png", "PNG")
                #time.sleep(.1)
        '''

if __name__ == '__main__':
        try:
                main()
        except KeyboardInterrupt:
                print "Quitting"
                ser.write('0');
