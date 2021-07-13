function [B] = divide_algin_misalgin(angle,fold)
%wwj
A = [0:359];
if ismember(fold,[4 5 6 9 10])
    aa=round(360/2/fold/2);
    angle=round(angle);
    b=find(A==angle);
    if angle>=aa
         a=[A(b-aa:end) A(1:b-aa-1)];
    else
         a=[A(end-(aa-b):end) A(1:end-(aa-b)-1)];
    end
    B = reshape(a,[],2*fold);
end

