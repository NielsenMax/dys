//CPP:mands/filter.cpp
#if !defined filter_h
#define filter_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class filter: public Simulator { 
// Declare the state,
// output variables
// and parameters

// State
double p;
double w;
double sigma;

// Output
double y;
public:
	filter(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
