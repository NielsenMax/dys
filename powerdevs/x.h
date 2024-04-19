//CPP:mands/x.cpp
#if !defined x_h
#define x_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class x: public Simulator { 
// Declare the state,
// output variables
// and parameters

double sigma,z;

double y;
public:
	x(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
