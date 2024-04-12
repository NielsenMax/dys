//CPP:/home/tc13/mands/powerdevs/source.cpp
#if !defined source_h
#define source_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class source: public Simulator { 
// Declare the state,
// output variables
// and parameters

// state
double z, sigma;

// output
double y;

// params
double j_min, j_max, t_max;

public:
	source(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
