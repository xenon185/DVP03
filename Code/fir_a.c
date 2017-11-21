#include "LP_coeff_firpm.h"
...
Uint32 FIR_accu32_TP;
short int i, delays[N];
...
interrupt void intser_McBSP1() 
{

	AIC23_data.both = MCBSP_read(DSK6713_AIC23_DATAHANDLE); //input data

	for (i = N-1 ; i > 0 ; i --){
		delays[i] = delays[i-1];
	}

	delays[0] = AIC23_data.channel[LEFT];
	FIR_accu32_TP = 0;

	for (i = 0 ; i <= N-1 ; i ++){
		FIR_accu32_TP += delays[i] * h_TP[i];
	}

	AIC23_data.channel[LEFT] = (short)(FIR_accu32_TP>>15);

	MCBSP_write(DSK6713_AIC23_DATAHANDLE, AIC23_data.both );   //output 32 bit data, LEFT and RIGHT

	return;
}