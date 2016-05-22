from PIL import Image, ImageDraw
import math

centerPoint = (415, 415)
robotWidth = 30
minSenseDistance = 2
maxSenseDistance = 400
points = {0:10, 90:30, 180:50}

im = Image.new("RGB", (830, 830))

draw = ImageDraw.Draw(im)

minDistX = centerPoint[0] - (robotWidth / 2)
minDistY = centerPoint[1] - (robotWidth / 2)
maxDistX = centerPoint[0] + (robotWidth / 2)
maxDistY = centerPoint[1] + (robotWidth / 2)
draw.arc([(minDistX, minDistY), (maxDistX, maxDistY)], 0, 360, fill="yellow")

minDistSenseX_Inner = minDistX - minSenseDistance
minDistSenseY_Inner = minDistY - minSenseDistance
minDistSenseX_Outer = maxDistX + minSenseDistance
minDistSenseY_Outer = maxDistY + minSenseDistance
draw.arc([(minDistSenseX_Inner, minDistSenseY_Inner), (minDistSenseX_Outer, minDistSenseY_Outer)], 0, 360, fill="green")

maxDistSenseX_Inner = minDistX - maxSenseDistance
maxDistSenseY_Inner = minDistY - maxSenseDistance
maxDistSenseX_Outer = maxDistX + maxSenseDistance
maxDistSenseY_Outer = maxDistY + maxSenseDistance
draw.arc([(maxDistSenseX_Inner, maxDistSenseY_Inner), (maxDistSenseX_Outer, maxDistSenseY_Outer)], 0, 360, fill="orange")


for angle in points.keys():
    xDist = centerPoint[0] + int(round(((robotWidth / 2) + points[angle]) * math.cos(math.radians(angle))))
    yDist = centerPoint[1] - int(round(((robotWidth / 2) + points[angle]) * math.sin(math.radians(angle))))

    draw.rectangle([(xDist - 1, yDist - 1), (xDist + 1, yDist + 1)], fill="red", outline="red")

del draw

# write to stdout
im.save("points.png", "PNG")
#im.show()
