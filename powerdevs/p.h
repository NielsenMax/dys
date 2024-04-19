//CPP:mands/p.cpp
#if !defined p_h
#define p_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class p: public Simulator { 
// Declare the state,
// output variables
// and parameters


double ve, vx;
bool busy;

double sigma, z;

double y;

double k1,k2;
public:
	p(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
