//CPP:mands/e.cpp
#if !defined e_h
#define e_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class e: public Simulator { 
// Declare the state,
// output variables
// and parameters

double sigma;
double z;

double y;

double l_ref;
public:
	e(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
