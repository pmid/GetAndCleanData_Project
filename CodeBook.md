# GetAndCleanData_Project

Coursera Data Science Specialization - Getting and Cleaning Data - Project

==================================================================

Meaning of the variables in the output file _TidyData.txt_ :

Variable | Meaning | Values
------------ | -------------| -------------
_subject_ | The subject wearing the smartphone and collecting the movement data | 1..30
_activity_ | The activity type | one of (LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)

The data column names are composed as:

domain + acceleration component + pippo_sensor + jerk ? + magnitude ? + mean ? + stddev ? + XYZaxis ?  (each component of the name is separated by "_")

(e.g. "frequency_body_accelerator_Jerk_mean_Yaxis" means frequency domain, Jerk body acceleration, mean value, along Y axis)

where

component | meaning
------------ | -------------
domain | time or frequency(FFT)
acceleration component | body (due to body motion) or gravity (due to gravitation)
sensor | accelerator or gyroscope
jerk ? | if "jerk" is present measurement is time rate of change of acceleration (acceleration of acceleration) otherwise it's simple acceleration
magnitude ? | if "magnitude" is magnitude of the three-dimensional signal
mean ? if "mean" the value is the mean ot the measurements
stddev ? if "stddev" the value is the standard deviation ot the measurements
[XYZ]axis ? ? | if [XYZ]axis the measurement is along the specified axis


Measurement type | measure unit
------------ | -------------
accelerator | g
accelerator, Jerk | g/s
gyroscope | radians/sec
gyroscope, Jerk | radians/(sec^2)
