//-----------------------------------------------------------
// Digital Signal Processing  Lab
// Testprogram read/write
//
// AIC23 version
//
// Filename : get_started.c
//
// Author Svg 8-Jan-07
//
// version 1 : modified 27-Nov-08, Kup
// version 2 : 31-Jan-10, JR


//#define SIMULATOR

// for usage of input MIC_IN and output HEADPHONE with DC coupling: 
//#define MIC_IN

#include "c6713dskinit.h"		//codec-DSK support file
#include "dsk6713.h"
#include <math.h>				//math library

#define LEFT 1
#define RIGHT 0
#define BUFLEN 1000

//  external beim DSK-Board, hier zu deklarieren f�r Simulator:
#ifdef SIMULATOR
	MCBSP_Handle DSK6713_AIC23_DATAHANDLE;
#else
	extern MCBSP_Handle DSK6713_AIC23_DATAHANDLE;
#endif

	static Uint32 CODECEventId;
	Uint32 fs=DSK6713_AIC23_FREQ_8KHZ;     //for sampling frequency
	//Uint32 fs;            			     //for sampling frequency

// two buffers for input and output samples with two counters
	short int inBuf_L[BUFLEN];
	short int inBuf_R[BUFLEN];
	short int count_INT=0;

	union {
		Uint32 both; 
		short channel[2];
	} AIC23_data;


interrupt void intser_McBSP1() 
{
	AIC23_data.both = MCBSP_read(DSK6713_AIC23_DATAHANDLE); //input data

// buffer monitoring input signal, reset count if BUFLEN is reached, 
// then input buffer is full
	inBuf_L[count_INT] = AIC23_data.channel[LEFT];
	inBuf_R[count_INT] = AIC23_data.channel[RIGHT];

// buffer full ??
	count_INT++;
    if (count_INT >= BUFLEN) 
    	count_INT = 0;

	MCBSP_write(DSK6713_AIC23_DATAHANDLE, AIC23_data.both);   //output 32 bit data, LEFT and RIGHT 

	return;
}
///////////////////////////////////////////////////////////////////

void main()
{
	IRQ_globalDisable();           		//disable interrupts

#ifndef SIMULATOR
	DSK6713_init();                   	//call BSL to init DSK-EMIF,PLL)
#ifdef MIC_IN
	config.regs[4] = 0x14;
	config.regs[5] = 0x1;
#endif

	hAIC23_handle=DSK6713_AIC23_openCodec(0, &config);//handle(pointer) to codec
	DSK6713_AIC23_setFreq(hAIC23_handle, fs);  //set sample rate

#else	// Nur f�r Simulator:
    DSK6713_AIC23_DATAHANDLE= MCBSP_open(MCBSP_DEV1, MCBSP_OPEN_RESET);
#endif

	MCBSP_config(DSK6713_AIC23_DATAHANDLE,&AIC23CfgData);//interface 32 bits toAIC23

	MCBSP_start(DSK6713_AIC23_DATAHANDLE, MCBSP_XMIT_START | MCBSP_RCV_START |
		MCBSP_SRGR_START | MCBSP_SRGR_FRAMESYNC, 220);//start data channel again

	CODECEventId= MCBSP_getXmtEventId(DSK6713_AIC23_DATAHANDLE);//McBSP1 Xmit


	IRQ_map(CODECEventId, 5);			//map McBSP1 Xmit to INT5
	IRQ_reset(CODECEventId);    		//reset codec INT5
	IRQ_globalEnable();       			//globally enable interrupts
	IRQ_nmiEnable();          			//enable NMI interrupt
	IRQ_enable(CODECEventId);			//enable CODEC eventXmit INT5
	IRQ_set(CODECEventId);              //manually start the first interrupt


    while(1);                	        //infinite loop
}
 
