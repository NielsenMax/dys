#include "filter.h"
void filter::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type

sigma = 100000000;
p = 0;
w = 0;
}
double filter::ta(double t) {
//This function returns a double.
return sigma;
}
void filter::dint(double t) {
sigma  = 1000000000;

}
void filter::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition
printLog("%d\n", x.getDouble());
if (x.port == 0){
	w = x.getDouble();
	sigma = 0;
	return;
} else {
	p = x.getDouble();
	sigma = 100000000;
}


}
Event filter::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)
int port = 1;
y = w;
if (p < (1.0*rand()/RAND_MAX)){
	port = 0;
}

return Event(&y, port);
}
void filter::exit() {
//Code executed at the end of the simulation.

}
