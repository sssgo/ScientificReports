function [path]=add_power(goalset,power,behaviorsamplerate,second_clea)
%   2019 wwj
orient_matrix=[];%
power_set=[];
for j=1:size(goalset,2)
     if goalset(1,j)*2000 <= size(power,2) && ismember(ceil(goalset(1,j)),second_clea)==1
         orient_matrix=[orient_matrix goalset(1:12,j)];
         index=floor((goalset(1,j)-behaviorsamplerate)*2000):floor(goalset(1,j)*2000);
         power_set= [power_set mean(power(:,index),2)];
     end
end

%%


path.behave=orient_matrix;
path.ieeg=power_set;
end

