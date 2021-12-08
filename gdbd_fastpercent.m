%%
clear all;


logFileName = {'sub1','sub2','sub3','sub4','sub5',...
               'sub6','sub7','sub8','sub9','sub10',...
               'sub11','sub12','sub13','sub14','sub15',...
               'sub16','sub17','sub18','sub19','sub20',...
               'sub21','sub22','sub23','sub24','sub25',...
               'sub26','sub27','sub28','sub29','sub30',...
               'sub31','sub32','sub33'};

s=0:49;f=@(x)2*10^(0.0383*x);F=arrayfun(f,s);
fileName = ['L:\eledata\eleinformation.mat'];
load(fileName);  
fileName = ['L:\eledata\ele_interest_region.mat'];
load(fileName);  
brainregion={'hippocampus','entorhinal','amygdata','middtemporal','superparietal','acc','middleprefrontal','middleofc'};
%savepath = ['J:\Goal_ec_retrieval\test\'];
savepath = ['J:\Goal_ec_retrieval\renew\epochdata5std\nikolai0705\'];
condition={'goodobj_C','goodobj_B','badobj_C','badobj_B','fastspeed_drop'};%
behaviorsamplerate=0.01;
sigma=5;

%%  

name=[3 4 7 13 15 17 24 22 33];
percent=67;
for i=1:length(name)
%for i=1
    folderPathName{name(i)}
    fileName = ['L:\dollermaze_navigation_data\' folderPathName{name(i)} '\markertime.mat'];
    load(fileName);
    fileName = ['L:\dollermaze_navigation_data\' folderPathName{name(i)} '\beh_info.mat'];
    load(fileName);
    fileName = ['L:\dollermaze_navigation_data\'  folderPathName{name(i)} '\artifact_matrix.mat'];
    load(fileName);
%
    [slope,intercept]=calibration_time(marker,behInfo);
    
%
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
    goalevent=movespan;%

    %% 
        gridevent=behInfo.gridevent;
    gridevent(:,3:4)=([slope*gridevent(:,3)+intercept,slope*gridevent(:,4)+intercept]);% 
   
    gridevent(:,2)=gridevent(:,2)+180;
    gridevent(gridevent(:,2)==360)=0;
    
    for ii=1:size(goalevent,2) 
       timepoint=goalevent(1,ii);%    
     if timepoint<=gridevent(end,4)

       %----
       ind=find(gridevent(:,4)>=timepoint);
               if isempty(ind)==0
                  ind=ind(1);
               else
                  ind=0;
               end

       ind=ind(1);
       if isnan(gridevent(ind,8))==0
           goalevent(6:10,ii)=gridevent(ind,8:12)';
       end
     end
    end

    

    dropphase=behInfo.dropphase;
    for ii=1:8
        objerror(ii,1)=ii;
        objerror(ii,2)=mean(dropphase{ii}(3,:));
    end
    objsort=sortrows(objerror,2);
    good_id=objsort(1:4,1);
    bad_id=objsort(5:8,1);
    
   goodobj=goalevent(:,find(ismember(goalevent(6,:),good_id) & goalevent(9,:)>0));
   badobj=goalevent(:,find(ismember(goalevent(6,:),bad_id) & goalevent(9,:)>0));
    
   

goodobj_fastpercent(i)=length(find(goodobj(5,:)>=cutoffspeed))/length(goodobj);
badobj_fastpercent(i)=length(find(badobj(5,:)>=cutoffspeed))/length(badobj);


end

figure(1)= figure('Color',[1 1 1]);

b=bar([mean(goodobj_fastpercent),mean(badobj_fastpercent)]);
set(b,'facecolor',[70/256 150/256 150/256]);
hold on
errorbar([mean(goodobj_fastpercent),mean(badobj_fastpercent)],[std(goodobj_fastpercent),std(badobj_fastpercent)]);
   set(gca,'xticklabel',{'goodobj','badobj'});
    ylabel('Fastspeed percentage %')
    [~,p2] =ttest2(goodobj_fastpercent,badobj_fastpercent);
    title(['fastspeed percentage contrast p:' num2str(p2,2)])
    
    
