function [k,b] = calibration_time(marker,behInfo)
%wwj
    TimeStamp_sec=marker;pulse_time=behInfo.trigger;
    if size(pulse_time,1)==2
        pulse_time=pulse_time(2,:);
    end
    changdu=min(length(TimeStamp_sec),length(pulse_time));
%   figure (i)
%   plot(1:changdu-1,diff(TimeStamp_sec(1:changdu)));hold on;plot(1:changdu-1,diff(pulse_time(1,1:changdu)));
    [c,d]=robustfit(pulse_time(1,1:changdu-10),TimeStamp_sec(1:changdu-10));  
    k=c(2);b=c(1);
end

