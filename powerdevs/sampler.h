//CPP:mands/sampler.cpp
#if !defined sampler_h
#define sampler_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class sampler: public Simulator { 
// Declare the state,
// output variables
// and parameters

//State

double z;
double sigma;

//output

double y;


//parameters
double T;
public:
	sampler(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
