sampleTime = 2;
frequency = 200;
plotFreq = 5;

plotSize = sampleTime*frequency;
plotInterval = frequency/plotFreq;
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
            a = fread(s,3,'int16')/32768*16;
            End = fread(s,3,'uint8');
        case 82 
            w = fread(s,3,'int16')/32768*2000;
            End = fread(s,3,'uint8');
        case 83 
            A = fread(s,3,'int16')/32768*180;
            aa = [aa;a'];
            ww = [ww;w'];
            AA = [AA;A'];
            tt = [tt;t];
            if (cnt > plotInterval) % Plot in low frequce, 
%                 subplot(3,1,1);plot(tt,aa);title(['Acceleration = ' num2str(a') 'm/s2']);ylabel('m/s2');ylim([-5,15]);
%                 subplot(3,1,2);plot(tt,ww);title(['Gyro = ' num2str(w') '°/s']);ylabel('°/s');ylim([-500,500]);
%                 subplot(3,1,3);plot(tt,AA);title(['Angle = ' num2str(A') '°']);ylabel('°'); ylim([-180,180]);
                
                subplot(2,1,1);plot(tt,ww);title(['Gyro = ' num2str(w') '°/s']);ylabel('°/s');ylim([-500,500]);
                subplot(2,1,2);plot(tt,AA);title(['Angle = ' num2str(A') '°']);ylabel('°'); ylim([-180,180]);
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