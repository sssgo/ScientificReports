function [goal] = Extract_goalevent_EC_retrieval_C4B4(behInfo,slope,intercept,percent)
% wwj 2020
       %%

    objloc=behInfo.objLoc;
    for ii=1:8
        objdis(1,ii)=ii;
        objdis(2,ii)=sqrt(objloc(ii,1)^2+objloc(ii,2)^2);
    end
    meandis=mean(objdis(2,:));
    C4=objdis(1,find(objdis(2,:)<meandis));%
    B4=objdis(1,find(objdis(2,:)>meandis));%

    dropphase=behInfo.dropphase;
    for ii=1:8
        objerror(ii,1)=ii;
        objerror(ii,2)=mean(dropphase{ii}(3,:));
    end
    objsort=sortrows(objerror,2);
    good_id=objsort(1:4,1);
    %good_id=objsort(1:8,1);
    bad_id=objsort(5:8,1);
    %----------------------------------------------------
 %   samplerate=round(behaviorsamplerate/0.01);
    behaviorsamplerate=0.01;
    samplerate=1;
    move=behInfo.moveinformation;
    moveinformation=move([2:4 7],:);%
    angle=moveinformation(4,:)+180;
    angle(find(angle==360))=0;
    moveinformation(4,:)=angle;
    
    movespan=moveinformation(:,1:samplerate:end);%
    movespan(1,:)= movespan(1,:)*slope+intercept;
    distance=sqrt(sum(diff(movespan(2:3,:)').^2,2));
    time=diff(movespan(1,:));
    time(find(time<=behaviorsamplerate))=behaviorsamplerate;%
    
    speed=distance./time';
   % envelope_of_signal=abs(hilbert(speed));
    speed(speed>=900)=900;
    speed=smooth(speed,10);
    cutoffspeed=floor(prctile(speed(find(speed>0)),percent));
    %slowmove=ceil(prctile(speed(find(speed>0)),percent2));
    
    speed=[0;speed];%
    movespan(5,:)=speed;
    goalevent=movespan(:,find(movespan(5,:)>=cutoffspeed));
    station=movespan(:,find(movespan(5,:)==0));
    
    gridevent=behInfo.gridevent;
    gridevent(:,3:4)=([slope*gridevent(:,3)+intercept,slope*gridevent(:,4)+intercept]);% 
    gridevent(:,2)=gridevent(:,2)+180;
    gridevent(gridevent(:,2)==360)=0;
  %% 
   for i=1:size(goalevent,2) 
       timepoint=goalevent(1,i);%     
     if timepoint<=gridevent(end,4)
      
       ind=find(gridevent(:,4)>=timepoint);
               if isempty(ind)==0
                  ind=ind(1);
               else
                  ind=0;
               end
      
       ind=ind(1);
       if isnan(gridevent(ind,8))==0
           goalevent(6:10,i)=gridevent(ind,8:12)';
           goal_dis=sqrt((goalevent(2,i)-objloc(goalevent(6,i),1))^2+(goalevent(3,i)-objloc(goalevent(6,i),2))^2);
           center_dis=sqrt((goalevent(2,i))^2+(goalevent(3,i))^2);
   
           goalevent(11,i)=goal_dis;
           goalevent(14,i)=center_dis;
           for j=1:8
               obj_dis(j)=sqrt((goalevent(2,i)-objloc(j,1))^2+(goalevent(3,i)-objloc(j,2))^2);
           end
           min_8goal_dis=min(obj_dis);
           clear obj_dis
           goalevent(12,i)=min_8goal_dis;
       else
           goalevent(11,i)=NaN;
           goalevent(12,i)=NaN;
       end
       
  
        if ismember(goalevent(6,i),C4)
            goalevent(15,i)=1;%
        else
            goalevent(15,i)=2;%
        end
        
     end
   end 
 
 %% 
   cutdis1=prctile(goalevent(14,:),66);
   cutdis2=prctile(goalevent(14,:),33);
   
   boundary=goalevent(:,find(goalevent(14,:)>=cutdis1));
   middle=goalevent(:,find(goalevent(14,:)<cutdis1 & goalevent(14,:)>cutdis2));
   center=goalevent(:,find(goalevent(14,:)<=cutdis2));
   %% 
   cutdis1=prctile(goalevent(11,:),66);
   cutdis2=prctile(goalevent(11,:),33);
   
   fardis=goalevent(:,find(goalevent(11,:)>=cutdis1));
   middis=goalevent(:,find(goalevent(11,:)<cutdis1 & goalevent(11,:)>cutdis2));
   neardis=goalevent(:,find(goalevent(11,:)<=cutdis2));
   
   drop=goalevent(:,find(goalevent(7,:)==2)); 
   grab=goalevent(:,find(goalevent(7,:)==4));

   ct1=prctile(drop(11,:),51);
   ct2=prctile(drop(11,:),50);
   fargoal_drop=drop(:,find(drop(11,:)>=ct1));
   neargoal_drop=drop(:,find(drop(11,:)<=ct2));
   
   ct1=prctile(grab(11,:),51);
   ct2=prctile(grab(11,:),50);
   fargoal_grab=grab(:,find(grab(11,:)>=ct1));
   neargoal_grab=grab(:,find(grab(11,:)<=ct2));
   
   %% 
   vis=goalevent(:,find(goalevent(7,:)==4));
   unvis=goalevent(:,find(goalevent(7,:)==2));     
   %% 
   goodobj=goalevent(:,find(ismember(goalevent(6,:),good_id) & goalevent(9,:)>0));
   badobj=goalevent(:,find(ismember(goalevent(6,:),bad_id) & goalevent(9,:)>0));

   center_cut1=2200;
   center_cut2=1100;
   
   
   goodobjnear=goodobj(:,find(goodobj(14,:)<=center_cut2));
   goodobjmid=goodobj(:,find(goodobj(14,:)<center_cut1 & goodobj(14,:)>center_cut2));
   goodobjfar=goodobj(:,find(goodobj(14,:)>center_cut1));
   
   badobjnear=badobj(:,find(badobj(14,:)<=center_cut2));
   badobjmid=badobj(:,find(badobj(14,:)<center_cut1 & badobj(14,:)>center_cut2));
   badobjfar=badobj(:,find(badobj(14,:)>center_cut1));
   
   %---
   center_cut1=prctile(badobj(14,:),66);
   center_cut2=prctile(badobj(14,:),33);
   badobj_boundary=badobj(:,find(badobj(14,:)>center_cut1));
   badobj_center=badobj(:,find(badobj(14,:)<=center_cut2));
   %% 
   C_full=goalevent(:,find(goalevent(15,:)==1));
   B_full=goalevent(:,find(goalevent(15,:)==2));
   
   
   % 
   goodobj_C=goodobj(:,find(goodobj(15,:)==1));
   goodobj_B=goodobj(:,find(goodobj(15,:)==2));
   badobj_C=badobj(:,find(badobj(15,:)==1));
   badobj_B=badobj(:,find(badobj(15,:)==2));
   %---
   cutdis1=prctile(goodobj_C(11,:),66);
   cutdis2=prctile(goodobj_C(11,:),33);
   
   goodobj_C_far=goodobj_C(:,find(goodobj_C(11,:)>=cutdis1));
   goodobj_C_near=goodobj_C(:,find(goodobj_C(11,:)<=cutdis2));

  
 
   %% 
   cutdis8=prctile(goalevent(12,:),50);
   in8=goalevent(:,find(goalevent(12,:)<=cutdis8));
   out8=goalevent(:,find(goalevent(12,:)>cutdis8));
   
   %% 
   goal.boundary=boundary;
   goal.middle=middle;
   goal.center=center;
   goal.vis=vis;
   goal.unvis=unvis;
   goal.goodobj=goodobj(:,find(goodobj(7,:)==2));
   goal.badobj=badobj(:,find(badobj(7,:)==2));
   goal.in8=in8(:,find(in8(7,:)==2));
   goal.out8=out8(:,find(out8(7,:)==2));
    goal.goalevent=goalevent;

 %% ----  
   goal.goodobjnear=goodobjnear(:,find(goodobjnear(7,:)==2));
   goal.goodobjmid=goodobjmid(:,find(goodobjmid(7,:)==2));
   goal.goodobjfar=goodobjfar(:,find(goodobjfar(7,:)==2));
   goal.badobjnear=badobjnear(:,find(badobjnear(7,:)==2));
   goal.badobjmid=badobjmid(:,find(badobjmid(7,:)==2));
   goal.badobjfar=badobjfar(:,find(badobjfar(7,:)==2));
   

   
 %%  

   goal.goodobj_C=goodobj_C(:,find(goodobj_C(7,:)==2));
   goal.goodobj_B=goodobj_B(:,find(goodobj_B(7,:)==2));
   goal.badobj_C=badobj_C(:,find(badobj_C(7,:)==2));
   goal.badobj_B=badobj_B(:,find(badobj_B(7,:)==2));
   
  % goal.station=station;
  goal.fastspeed_drop=goalevent(:,find(goalevent(7,:)==2));
  goal.fastspeed_grab=goalevent(:,find(goalevent(7,:)==4));
  goal.boundary_drop=boundary(:,find(boundary(7,:)==2));
  goal.middle_drop=boundary(:,find(middle(7,:)==2));
  goal.center_drop=center(:,find(center(7,:)==2));
  goal.boundary_grab=boundary(:,find(boundary(7,:)==4));
  goal.middle_grab=boundary(:,find(middle(7,:)==4));
  goal.center_grab=center(:,find(center(7,:)==4));
  
  goal.fargoal_drop=fargoal_drop;
  goal.neargoal_drop=neargoal_drop;
  goal.fargoal_grab=fargoal_grab;
  goal.neargoal_grab=neargoal_grab;

  %-------
   goal.goodobj_C_far_drop=goodobj_C_far(:,find(goodobj_C_far(7,:)==2));
   goal.goodobj_C_near_drop=goodobj_C_near(:,find(goodobj_C_near(7,:)==2));
   
   goal.badobj_boundary_drop=badobj_boundary(:,find(badobj_boundary(7,:)==2));
   goal.badobj_center_drop=badobj_center(:,find(badobj_center(7,:)==2));

   goal.C_grab=C_full(:,find(C_full(7,:)==4));
   goal.B_grab=B_full(:,find(B_full(7,:)==4));
  
end