% wwj 2021
%%
clear all;
folderPathName = {'1_lvjutao_yuquan','2_guyitao_304','3_yinjin_301','4_liuzhiming_yuquan','5_heqiang_304',...
    '6_fanjiang_301','7_changdanyuan_yuquan','8_xiezhidong_301','9_zhanghaibin_yuquan','10_gaozhibo_yuquan',...
    '11_zhangqiaofeng_yuquan','12_guobin_yuquan','13_peijian_304','14_dinglanlan_304','15_dongfenlian_yuquan',...
    '16_yuyanan_304','17_duruijiao_yuquan','18_Bielefeld_170417_problem','19_Bielefeld_180617_problem','20_Freiburg_070817b_problem',...
    '21_Freiburg_190517', '22_Freiburg_190717','23_Freiburg_210617','24_wangyanbin_304','25_lixiangju_yuquan',...
    '26_Bielefeld_030317_problem','27_Bielefeld_08122017_empty','28_Bielefeld_10092017_problem','29_Bielefeld_24112017_problem', '30_Bielefeld_26102017',...
    '31_Freiburg_181017','32_wangcheng_xuanwu','33_Freiburg_070817a'};
Name = {'1_lvjutao_yuquan','2_guyitao_304','3_yinjin_301','4_liuzhiming_yuquan','5_heqiang_304',...
    '6_fanjiang_301','7_changdanyuan_yuquan','8_xiezhidong_301','9_zhanghaibin_yuquan','10_gaozhibo_yuquan',...
    '11_zhangqiaofeng_yuquan','12_guobin_yuquan','13_peijian_304','14_dinglanlan_304','15_dongfenlian_yuquan',...
    '16_yuyanan_304','17_duruijiao_yuquan','18_Bielefeld_170417_problem','19_Bielefeld_180617_problem','20_Freiburg_070817b_problem',...
    '21_Freiburg_190517', '22_Freiburg_190717','23_Freiburg_210617','24_wangyanbin_304','25_lixiangju_yuquan',...
    '26_Bielefeld_030317_problem','27_Bielefeld_08122017_empty','28_Bielefeld_10092017_problem','29_Bielefeld_24112017_problem', '30_Bielefeld_26102017',...
    '31_Freiburg_181017','32_wangcheng_xuanwu','33_Freiburg_070817a'};
logFileName = {'sub1','sub2','sub3','sub4','sub5',...
               'sub6','sub7','sub8','sub9','sub10',...
               'sub11','sub12','sub13','sub14','sub15',...
               'sub16','sub17','sub18','sub19','sub20',...
               'sub21','sub22','sub23','sub24','sub25',...
               'sub26','sub27','sub28','sub29','sub30',...
               'sub31','sub32','sub33'};


fileName = ['D:\eledata\eleinformation.mat'];
load(fileName);  
fileName = ['D:\eledata\ele_interest_region.mat'];
load(fileName);  

name=[3 4 7 13 15 17 22 24 33 ];

   sub_goodobj_data=[];
    sub_badobj_data=[];
for i=1:length(name)

    %% 
    folderPathName{name(i)} 
    ele=ele_interest_region{2,name(i)};
     k=1;
   %   %------------
         fileName = ['F:\Goal_ec_epoch\epochdata5std\goodobjepochdata_' num2str(name(i)) '_' num2str(ele(k,1)) '.mat'];
        if exist(fileName)==0
            k=2;
            fileName = ['F:\Goal_ec_epoch\epochdata5std\goodobjepochdata_' num2str(name(i)) '_' num2str(ele(k,1)) '.mat'];
        end
             load(fileName);
           %
             trialnum1=unique(goodobjepochdata.behave(9,:));
             clear objnum1
             for ii=1:length(trialnum1)
                 ind=find(goodobjepochdata.behave(9,:)==trialnum1(ii));            
                 objnum1(ii)=goodobjepochdata.behave(6,ind(1));
                % objdistance1(ii)=objdis(2,objnum1(ii));
             end
             
             goodobjnum=unique(objnum1);
         
       %------------  
       fileName = ['F:\Goal_ec_epoch\epochdata5std\badobjepochdata_' num2str(name(i)) '_' num2str(ele(k,1)) '.mat'];
        
             load(fileName);
             trialnum2=unique(badobjepochdata.behave(9,:));
             clear objnum2
             for ii=1:length(trialnum2)
                 ind=find(badobjepochdata.behave(9,:)==trialnum2(ii));            
                 objnum2(ii)=badobjepochdata.behave(6,ind(1));
                % objdistance2(ii)=objdis(2,objnum2(ii));
             end
             
             badobjnum=unique(objnum2);
    
    
    %%     
    fileName = ['D:\dollermaze_navigation_data\' folderPathName{name(i)} '\beh_info.mat'];
    load(fileName);

    dropphase=behInfo.dropphase;
    moveinformation=behInfo.moveinformation;
    c1=0;
    c2=0;
    for m=1:8
        dp=dropphase{m};
        if ismember(m,goodobjnum)
        for n=1:size(dp,2)
            cuetime=dp(1,n);%drop time
            droptime=dp(2,n);%drop time
            cue_ind=find(abs(moveinformation(2,:)-cuetime)<=0.02);
            drop_ind=find(abs(moveinformation(2,:)-droptime)<=0.02);
            traj_loc=moveinformation(3:4,cue_ind(1):drop_ind(1));
%             scatter(moveinformation(3,cue_ind(1):drop_ind(1)),moveinformation(4,cue_ind(1):drop_ind(1)),3,'filled')
%             scatter(moveinformation(3,:),moveinformation(4,:),3,'filled')
%             scatter(traj_loc(2,:),traj_loc(1,:),3,'filled')
            traj_bound_dis=4500-sqrt(traj_loc(1,:).^2+traj_loc(2,:).^2);
%             obj_bound_dis=4500-objdis(2,m);
%             drop_error=dp(3,n);
         c1=c1+1;
         goodobj_traj{c1}=traj_bound_dis;
        end
        elseif ismember(m,badobjnum)
        for n=1:size(dp,2)
            cuetime=dp(1,n);%drop time
            droptime=dp(2,n);%drop time
            cue_ind=find(abs(moveinformation(2,:)-cuetime)<=0.02);
            drop_ind=find(abs(moveinformation(2,:)-droptime)<=0.02);
            traj_loc=moveinformation(3:4,cue_ind(1):drop_ind(1));
            traj_bound_dis=4500-sqrt(traj_loc(1,:).^2+traj_loc(2,:).^2);
%             obj_bound_dis=4500-objdis(2,m);
%             drop_error=dp(3,n);
         c2=c2+1;
         badobj_traj{c2}=traj_bound_dis;
        end
        end
        
    end

  %%  
        figure(10+i)
    subplot(2,2,1)
    data1_mat=[];
    for jj=1:length(goodobj_traj)
        data1=goodobj_traj{jj};
        data1=data1(100:end);%
        for kk=1:100
            step=length(data1)/100;
            winstart=1+round((kk-1)*step);
            winend=1+round(kk*step);
            if winend>length(data1)
                winend=length(data1);
            end
            data1_resample(kk)=nanmean(data1(winstart:winend));
        end           
        plot(data1_resample)
        hold on
        data1_mat=[data1_mat;data1_resample];
    end
    title('goodobj')
   
    subplot(2,2,2)
    data2_mat=[];    
    for jj=1:length(badobj_traj)
        data2=badobj_traj{jj};
        data2=data2(100:end);%
        for kk=1:100
            step=length(data2)/100;
            winstart=1+round((kk-1)*step);
            winend=1+round(kk*step);
            if winend>length(data2)
                winend=length(data2);
            end
            data2_resample(kk)=nanmean(data2(winstart:winend));
        end           
        plot(data2_resample)
        hold on
        data2_mat=[data2_mat;data2_resample];
    end
    title('badobj')
    
    subplot(2,2,[3 4])

                  y = (nanmean(data1_mat,1))';
                  e = (nanstd(data1_mat,1)/sqrt(size(data1_mat,1)))';
                  x = (1:length(y))';
                  h = area(x,[y - e, 2 * e],'FaceAlpha',0.6);
                  hold on;

                  set(h(1),'Visible','off');
                  set(h(2),'EdgeColor','white','FaceColor',[0.75,0.75,1]);
                  h1=plot(x,y,'-b','LineWidth',2);
                
                  
                  hold on
                  y = (nanmean(data2_mat,1))';
                  e = (nanstd(data2_mat,1)/sqrt(size(data2_mat,1)))';
                  x = (1:length(y))';
                  h = area(x,[y - e, 2 * e],'FaceAlpha',0.6);
                  hold on;

                  set(h(1),'Visible','off');
                  set(h(2),'EdgeColor','white','FaceColor',[1,0.75,0.75]);
                  h2=plot(x,y,'-r','LineWidth',2);  
                  if i<4
                  ylim([1600,3300])
                  else
                 ylim([1800,2800]) 
                  end
                 xlabel('Time of trial (cue to response)')
                 ylabel('Distance from boundary')
                 suptitle(['Sub\_',num2str(name(i)),' dis from boundary in trial time'])
                  legend([h1,h2],'goodobj','badobj')
%%    
    sub_goodobj_data=[sub_goodobj_data;mean(data1_mat,1)];
    sub_badobj_data=[sub_badobj_data;mean(data2_mat,1)];
end

figure(30)
                  y = (nanmean(sub_goodobj_data,1))';
                  e = (nanstd(sub_goodobj_data,1)/sqrt(size(sub_goodobj_data,1)))';
                  x = (1:length(y))';
                  h = area(x,[y - e, 2 * e],'FaceAlpha',0.6);
                  hold on;

                  set(h(1),'Visible','off');
                  set(h(2),'EdgeColor','white','FaceColor',[0.75,0.75,1]);
                  h1=plot(x,y,'-b','LineWidth',2);
                
                  
                  hold on
                  y = (nanmean(sub_badobj_data,1))';
                  e = (nanstd(sub_badobj_data,1)/sqrt(size(sub_badobj_data,1)))';
                  x = (1:length(y))';
                  h = area(x,[y - e, 2 * e],'FaceAlpha',0.6);
                  hold on;

                  set(h(1),'Visible','off');
                  set(h(2),'EdgeColor','white','FaceColor',[1,0.75,0.75]);
                  h2=plot(x,y,'-r','LineWidth',2);
    
                 ylim([2000,2750])           
                % xlim([0,90])   
               xlabel('Time of trial (cue to response)')
               ylabel('Distance from boundary')
               title(['All\_sub dis from boundary in trial time'])
               
    
    hold on
    %%
    for k=1:100
        [~,p]=ttest(sub_goodobj_data(:,k),sub_badobj_data(:,k));
        if p<=0.05
          signif(k)=1;
        else 
           signif(k)=0;
        end
    end
    sigx=find(signif==1);
    h3=scatter(sigx,2730*ones(1,length(sigx)),50,[0.5,0.5,0.5],'filled')
  legend([h1,h2,h3],'goodobj','badobj','significant')
  
  %% 
  figure(35)
  subplot(1,2,1)
   % 
   goodstart=nanmean(sub_goodobj_data(10:39),1);
   badstart=nanmean(sub_badobj_data(10:39),1);
   bar([mean(goodstart),mean(badstart)])
   hold on
   errorbar([mean(goodstart),mean(badstart)],[std(goodstart),std(badstart)]/sqrt(length(goodstart)))
   [~,p]=ttest2(goodstart,badstart);
   title(['Starting positon to the boundary: p=',num2str(p,2)])
   ylim([2000,2200])    
   ylabel('Distance of starting positions to the boundary')
   set(gca, 'XTickLabel' ,{'goodobj','badobj'}) ;
   
   subplot(1,2,2)
   % 
   goodtime=nanmean(sub_goodobj_data,1);
   badtime=nanmean(sub_badobj_data,1);
   bar([nanmean(goodtime),nanmean(badtime)])
   hold on
   errorbar([nanmean(goodtime),nanmean(badtime)],[nanstd(goodtime),nanstd(badtime)]/sqrt(length(goodtime)))
   [~,p]=ttest2(goodtime,badtime);
   title(['All self-paced positon to the boundary: p=',num2str(p,2)])
   ylim([2300,2500])   
   ylabel('Distance of all positions to the boundary')
   set(gca, 'XTickLabel' ,{'goodobj','badobj'}) ; 
    
    
    
    
    
    
    
    
