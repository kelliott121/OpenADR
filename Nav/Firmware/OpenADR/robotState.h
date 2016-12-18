class Acceleration
{
	public:
	Acceleration(uint16_t x, uint16_t y, uint16_t z);
	
	uint16_t x;
	uint16_t y;
	uint16_t z;
}

class RobotState
{
	public:
	RobotState();
	void setAcceleration(Acceleration accel);
	void setDirection(uint16_t heading);
	void setTiming(uint8_t timeSlice, uint32_t time); 
	
	private:
	Acceleration acceleration;
	uint16_t heading;
	uint32_t timing[100];
}