//CPP:mands/queue.cpp
#if !defined queue_h
#define queue_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"

#include "queue"


class queue: public Simulator { 
// Declare the state,
// output variables
// and parameters

//States
bool busy;
std::queue<double> q;
double sigma;

//Outputs
double y;
public:
	queue(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
