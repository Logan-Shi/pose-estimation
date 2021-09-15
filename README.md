# pose estimation

estimate object pose with laser sensor and IMU.

## system setup

* connect IMU with bluetooth (wit-motion [BWT901CL](https://github.com/WITMOTION/BWT901CL))

> 1. turn on IMU power.  
> 2. connect to bluetooth device HC-06 with password 1234.  
> 3. run udpPort.m.  
> 4. blue light remains on meaning successfull connection. Should blinking occur, restart IMU and try running udpPort.m again.   
> 5. do remember to run fclose(s) after use to release COM port which should put blue light to blinking agian.  