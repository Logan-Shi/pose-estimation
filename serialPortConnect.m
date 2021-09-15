clear all;
close all;
portName = 4;
serialOK = 0;
while (~serialOK)
    instrreset;
    disp('connecting...please check light status...')
    try
        serialOK = 1;
        s = serial(['com' num2str(portName)],'baudrate',115200);
%         s = serialport(['COM' num2str(portName)],115200);
        pause(5) % wait for system setup
        fopen(s);
    catch E
        switch E.identifier
            case 'serialport:serialport:ConnectionFailed'
                disp('Connecting to COM failed. Trying again after 10s... Please check device connection...')
                serialOK = 0;
                pause(10)
            case 'MATLAB:serial:fopen:opfailed'
                disp('Opening COM failed. Trying again after 10s... May need to restart device manually...')
                serialOK = 0;
                pause(10)
            otherwise
                disp(E.identifier)
                serialOK = 0;
                pause(10)
        end
    end
end
disp('Boot successfull!')
