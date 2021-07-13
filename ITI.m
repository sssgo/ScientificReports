function [second_of_iti] = ITI(behInfo,k,b)
%wwj 2019
%
 %
    second_of_iti=[];
    iti_start=behInfo.ITIstart;iti_start=k*iti_start+b;
    iti_end=behInfo.ITIend;iti_end=k*iti_end+b;
    for j=1:min(length(iti_start),length(iti_end))
       second_of_iti=[second_of_iti ceil(iti_start(1,j)):ceil(iti_end(1,j)+2)];
    end
    second_of_iti=unique(second_of_iti);
end

