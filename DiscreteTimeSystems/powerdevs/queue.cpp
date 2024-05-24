#include "queue.h"
void queue::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type

busy = false;
sigma = 10000000;
}
double queue::ta(double t) {
//This function returns a double.
return sigma;
}
void queue::dint(double t) {
busy = true;
q.pop();
sigma=10000000;
}
void queue::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition

if (x.port == 1){
	if (q.empty()){
		busy = false;
		sigma = 10000000;
		return;
	}
	busy = false;
	sigma = 0;
	return;
}

q.push(x.getDouble());

if (busy){
	sigma = 10000000;
	return;
}

sigma = 0;



}
Event queue::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

y = q.front();
return Event(&y, 0);
}
void queue::exit() {
//Code executed at the end of the simulation.

}
