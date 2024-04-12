//CPP:/home/tc13/mands/powerdevs/processor.cpp
#if !defined processor_h
#define processor_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class processor: public Simulator { 
// Declare the state,
// output variables
// and parameters

// State
bool busy;
double sigma;

// Output
double y;

public:
	processor(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
