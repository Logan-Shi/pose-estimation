# pose estimation

estimate object pose with laser sensor and IMU.

## system usage

* connect IMU with bluetooth (wit-motion [BWT901CL](https://github.com/WITMOTION/BWT901CL))

> 1. turn on IMU power.  
> 2. connect to bluetooth device HC-06 with password 1234.  
> 3. run serialPortConnect.m to connect device.  
> 4. run streaming.m to plot live data.(hit ctrl+c to interrupt process)  
> 5. run closePort.m to release memory. Shut down power manully.  

## TODO

1. set up orientation filter  