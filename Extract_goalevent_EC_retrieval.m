function [goal] = Extract_goalevent_addprepost(behInfo,slope,intercept,percent)
% wwj 2019-5-1
%%
    objloc=behInfo.objLoc;
    dropphase=behInfo.dropphase;
    for ii=1:8
        objerror(ii,1)=ii;
        objerror(ii,2)=mean(dropphase{ii}(3,:));
    end
    objsort=sortrows(objerror,2);
    good_id=objsort(1:4,1);
    bad_id=objsort(5:8,1);
    %----------------------------------------------------

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

    
    gridevent=behInfo.gridevent;
    gridevent(:,3:4)=([slope*gridevent(:,3)+intercept,slope*gridevent(:,4)+intercept]);% 
   
    gridevent(:,2)=gridevent(:,2)+180;
    gridevent(gridevent(:,2)==360)=0;
  %% 
   for i=1:size(goalevent,2) 
       timepoint=goalevent(1,i);%每个采样点的时间
     if timepoint<=gridevent(end,4)
       ind= find(gridevent(:,3)<=timepoint & gridevent(:,4)>=timepoint);
       if isempty(ind)==1
           indset=find(abs(gridevent(:,4)-timepoint)<0.1);%
           if isempty(indset)
               indset=find(abs(gridevent(:,3)-timepoint)<0.1);
           end
           ind=indset(1);
       end

       ind=ind(1);
       if isnan(gridevent(ind,8))==0
           goalevent(6:10,i)=gridevent(ind,8:12)';
           goal_dis=sqrt((goalevent(2,i)-objloc(goalevent(6,i),1))^2+(goalevent(3,i)-objloc(goalevent(6,i),2))^2);

           goalevent(11,i)=goal_dis;
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
     end
   end 

   %%


cutdroperror1=prctile(unique(goalevent(10,:)),60);
cutdroperror2=prctile(unique(goalevent(10,:)),40);

PRE=goalevent(:,find(goalevent(10,:)>=cutdroperror1));
POST=goalevent(:,find(goalevent(10,:)<=cutdroperror2));
   %% 
   cutdis1=prctile(goalevent(11,:),67);
   cutdis2=prctile(goalevent(11,:),33);
   
   fardis=goalevent(:,find(goalevent(11,:)>=cutdis1));
   middis=goalevent(:,find(goalevent(11,:)<cutdis1 & goalevent(11,:)>cutdis2));
   neardis=goalevent(:,find(goalevent(11,:)<=cutdis2));
   
   %% 
   vis=goalevent(:,find(goalevent(7,:)==4));
   unvis=goalevent(:,find(goalevent(7,:)==2));     
   %% 
   goodobj=goalevent(:,find(ismember(goalevent(6,:),good_id)));
   badobj=goalevent(:,find(ismember(goalevent(6,:),bad_id)));
   
   %% 
   cutdis8=prctile(goalevent(12,:),50);
   in8=goalevent(:,find(goalevent(12,:)<=cutdis8));
   out8=goalevent(:,find(goalevent(12,:)>cutdis8));
   
   %% 
   goal.fardis=fardis(:,find(fardis(7,:)==2));
   goal.middis=middis(:,find(middis(7,:)==2));
   goal.neardis=neardis(:,find(neardis(7,:)==2));
   goal.vis=vis;
   goal.unvis=unvis;
   goal.goodobj=goodobj(:,find(goodobj(7,:)==2));
   goal.badobj=badobj(:,find(badobj(7,:)==2));
   goal.in8=in8(:,find(in8(7,:)==2));
   goal.out8=out8(:,find(out8(7,:)==2));
   goal.goalevent=goalevent(find(goalevent(7,:)==2));

      goal.PRE=PRE(:,find(PRE(7,:)==2));
   goal.POST=POST(:,find(POST(7,:)==2));
   
   
end