function [behevepoch] = epochindex( fastepochdata )
%wwj 2020
orient_matrix=fastepochdata.behave;
%orient_matrix=fastepochdata;
behevepoch=zeros(1,size(orient_matrix,2));
epochindex=find(diff(orient_matrix(1,:))>=0.04)+1;
if epochindex(1)~=1
    epochindex=[1 epochindex ];
end
if epochindex(end)~=size(orient_matrix,2)
    epochindex=[epochindex size(orient_matrix,2)];
end
for i=1:length(epochindex)-1
    epochstart=epochindex(i);epochend=epochindex(i+1)-1;
    behevepoch(1,epochstart:epochend)=i*ones(1,epochend-epochstart+1);
end
behevepoch(end)=behevepoch(end-1);

end


