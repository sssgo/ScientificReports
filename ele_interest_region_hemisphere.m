%% ele_interest_region£¬
clear all;
%% load
 
fileName = ['D:\eledata\ele_interest_region.mat'];
load(fileName);  


%%  ele_interest_region_hemisphere
for i=1:size(ele_interest_region,1)
    for j=1:size(ele_interest_region,2)    
      eleset=ele_interest_region{i,j};  
      if ~isempty(eleset)
              leftset=eleset(find(eleset(:,5)<0),:); % left hemisphere
              rightset=eleset(find(eleset(:,5)>=0),:);% right hemisphere
              if ~isempty(leftset)
                  ele_interest_region_hemisphere{i,j}=leftset;
              end
              if ~isempty(rightset)
                  ele_interest_region_hemisphere{i+8,j}=leftset;% line 8-16 for right hemisphere
              end    
      end
    end
end

filename = ['D:\eledata\ele_interest_region_hemisphere.mat'];
save(filename,'ele_interest_region_hemisphere')



