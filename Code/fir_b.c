#include "LP_coeff_firpm_TP.h"
#include "LP_coeff_firpm_HP.h"
...
Uint32 FIR_accu32_TP;
Uint32 FIR_accu32_HP;
short int i, delays_TP[N], delays_HP[N];
...
interrupt void intser_McBSP1() 
{
	AIC23_data.both = MCBSP_read(DSK6713_AIC23_DATAHANDLE); //input data

	for (i = N-1 ; i > 0 ; i --){
		delays_TP[i] = delays_TP[i-1];
		delays_HP[i] = delays_HP[i-1];
	}

	delays_TP[0] = AIC23_data.channel[LEFT];
	delays_HP[0] = AIC23_data.channel[RIGHT];
	FIR_accu32_TP = 0;
	FIR_accu32_HP = 0;

	for (i = 0 ; i <= N-1 ; i ++){
		FIR_accu32_TP += delays_TP[i] * h_TP[i];
		FIR_accu32_HP += delays_HP[i] * h_HP[i];
	}

	AIC23_data.channel[LEFT] = (short)(FIR_accu32_TP>>15);
	AIC23_data.channel[RIGHT] = (short)(FIR_accu32_HP>>15);
	MCBSP_write(DSK6713_AIC23_DATAHANDLE, AIC23_data.both );   //output 32 bit data, LEFT and RIGHT

	return;
}