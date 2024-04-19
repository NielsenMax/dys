#include "e.h"
void e::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type
sigma = 1000000;
l_ref = va_arg(parameters, double);
}
double e::ta(double t) {
//This function returns a double.
return sigma;
}
void e::dint(double t) {
sigma = 100000;
}
void e::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition
sigma = 0;
z = l_ref - x.getDouble();

}
Event e::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

y = z;
return Event(&y, 0);
}
void e::exit() {
//Code executed at the end of the simulation.

}
