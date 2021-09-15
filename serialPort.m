clear all;
close all;
portName = 4;
plotSize = 20;
frequency = 200;
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
disp('Boot successfull! Press Ctrl+C to stop collecting data!')
t = 0;
cnt = 1;
aa = [0 0 0];
ww = [0 0 0];
AA = [0 0 0];
tt = 0;
a= [0 0 0]';
w= [0 0 0]';
A= [0 0 0]';
while(1)
    Head = fread(s, 2, 'uint8');
    if (Head(1) ~= uint8(85))
        continue;
    end
    switch(Head(2))
        case 81 
            a = fread(s,3,'int16')/32768*16 ;     
            End = fread(s,3,'uint8');
        case 82 
            w = fread(s,3,'int16')/32768*2000 ;    
            End = fread(s,3,'uint8');
        case 83 
            A = fread(s,3,'int16')/32768*180;
            aa = [aa;a'];
            ww = [ww;w'];
            AA = [AA;A'];
            tt = [tt;t];
            if (cnt > plotSize) % Plot in low frequce, 
                subplot(3,1,1);plot(tt,aa);title(['Acceleration = ' num2str(a') 'm2/s']);ylabel('m2/s');
                subplot(3,1,2);plot(tt,ww);title(['Gyro = ' num2str(w') '°/s']);ylabel('°/s');
                subplot(3,1,3);plot(tt,AA);title(['Angle = ' num2str(A') '°']);ylabel('°');              
                cnt = 0;
                drawnow;
                if (size(aa,1) > plotSize) % clear history data
                    aa = aa(end-plotSize:end,:);
                    ww = ww(end-plotSize:end,:);
                    AA = AA(end-plotSize:end,:);
                    tt = tt(end-plotSize:end,:);
                end
            end
            cnt = cnt + 1;
            t = t + 1/frequency;
            End = fread(s,3,'uint8');
    end
end