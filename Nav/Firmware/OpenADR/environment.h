#define NUM_POINTS

struct CartesianCoordinate
{
	CartesianCoordinate(uint16_t angle, uint16_t distance);
	
	uint16_t x;
	uint16_t y;	
}

struct Color
{
	Color(uint8_t red, uint8_t green, uint8_t blue);
	
	uint8_t red;
	uint8_t green;
	uint8_t blue;
}

struct PolarCoordinate
{
	PolarCoordinate(uint16_t angle, uint16_t distance);
	
	uint16_t angle;
	uint16_t distance;	
}

class Environment
{
	public:
	Environment();
	void setDistance(PolarCoordinate distance);
	void setFloor(Color color, uint8_t intensity);
	void setTemperature(uint8_t temperature);
	void setHumidity(uint8_t humidity);
	
	PolarCoordinate distances[NUM_POINTS];
	CartesianCoordinate obstacles[NUM_POINTS];
	
	Color floorColor;
	uint8_t floorReflectance;
	
	uint8_t temperature;
	uint8_t humidity;
	
	private:
	calculateObstacle(PolarCoordinate distance);
}