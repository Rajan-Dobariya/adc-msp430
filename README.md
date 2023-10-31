# adc-msp430

Title: **Using the ADC System**

Objective:

To control the LED brightness using potentiometer (To control toggle speed from external potentiometer) as Analog input using the **MSP-EXP430FR2355** microcontroller.


## Pseudocode for adc-msp430

### Steps:

**Step 1**: Set Output port for external LED and input port for Potentiometer.\
**Step 2**: Set input as an Analog input by setting SEL0 and SEL1.\
**Step 3**: Configure ADC0 control register: Set ADC ON, set sample and hold to 16 ADC cycles, but disable conversion.\
**Step 4**: Similarly configure control register for ADC1, ADC2 and ADCCM.\
**Step 5**: Enable ADC conversion and start conversion for ADC0 by setting ADCCTL0 value as 0213h.\
**Step 6**: Once the conversion is complete, move the converted bit value stored in MEMO register to output port (External LED).


## Output

[Video link](https://usfedu-my.sharepoint.com/:v:/g/personal/dobariya_usf_edu/ES-ZxiOSB9NAsteHnuGtM_AB3A5seUWE31s3w8pt5vh57w)