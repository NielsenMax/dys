#include "source.h"
void source::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type
j_min = va_arg(parameters, double);
j_max = va_arg(parameters, double);
t_max = va_arg(parameters, double);

z = 1.0*rand()/RAND_MAX*(j_max - j_min)+j_min;
sigma = 1.0*rand()/RAND_MAX * t_max;
}
double source::ta(double t) {
//This function returns a double.
return sigma;
}
void source::dint(double t) {
z = 1.0*rand()/RAND_MAX*(j_max - j_min)+j_min;
sigma = 1.0*rand()/RAND_MAX * t_max;

}
void source::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition

}
Event source::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)
y = z;

return Event(&y, 0);
}
void source::exit() {
//Code executed at the end of the simulation.

}
