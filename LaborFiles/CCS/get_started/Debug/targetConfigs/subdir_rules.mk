################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Each subdirectory must supply rules for building sources it contributes
targetConfigs/DSK_vectors_AIC23.obj: ../targetConfigs/DSK_vectors_AIC23.ASM $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.21/bin/cl6x" -mv6710 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.21/include" --define=CHIP_6713 --display_error_number --diag_warning=225 --diag_wrap=off --mem_model:data=far --preproc_with_compile --preproc_dependency="targetConfigs/DSK_vectors_AIC23.pp" --obj_directory="targetConfigs" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '

targetConfigs/get_started.obj: ../targetConfigs/get_started.c $(GEN_OPTS) $(GEN_HDRS)
	@echo 'Building file: $<'
	@echo 'Invoking: C6000 Compiler'
	"C:/ti/ccsv5/tools/compiler/c6000_7.4.21/bin/cl6x" -mv6710 --abi=coffabi -g --include_path="C:/ti/ccsv5/tools/compiler/c6000_7.4.21/include" --define=CHIP_6713 --display_error_number --diag_warning=225 --diag_wrap=off --mem_model:data=far --preproc_with_compile --preproc_dependency="targetConfigs/get_started.pp" --obj_directory="targetConfigs" $(GEN_OPTS__FLAG) "$<"
	@echo 'Finished building: $<'
	@echo ' '


