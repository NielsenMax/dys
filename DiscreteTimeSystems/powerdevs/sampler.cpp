#include "sampler.h"
void sampler::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type
T = va_arg(parameters, double);

z = 0;
sigma = T;

}
double sampler::ta(double t) {
//This function returns a double.
return sigma;
}
void sampler::dint(double t) {
sigma = T;

}
void sampler::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition

z = x.getDouble();
sigma -= e;

}
Event sampler::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

y = z;

return Event(&y, 0);
}
void sampler::exit() {
//Code executed at the end of the simulation.

}
