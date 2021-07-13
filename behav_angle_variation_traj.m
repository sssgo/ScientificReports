% wwj 2019-11-18

%%
%%
clear all;close all
folderPathName = {'1_lvjutao_yuquan','2_guyitao_304','3_yinjin_301','4_liuzhiming_yuquan','5_heqiang_304',...
    '6_fanjiang_301','7_changdanyuan_yuquan','8_xiezhidong_301','9_zhanghaibin_yuquan','10_gaozhibo_yuquan',...
    '11_zhangqiaofeng_yuquan','12_guobin_yuquan','13_peijian_304','14_dinglanlan_304','15_dongfenlian_yuquan',...
    '16_yuyanan_304','17_duruijiao_yuquan','18_Bielefeld_170417_problem','19_Bielefeld_180617_problem','20_Freiburg_070817b_problem',...
    '21_Freiburg_190517', '22_Freiburg_190717','23_Freiburg_210617','24_wangyanbin_304','25_lixiangju_yuquan',...
    '26_Bielefeld_030317_problem','27_Bielefeld_08122017_empty','28_Bielefeld_10092017_problem','29_Bielefeld_24112017_problem', '30_Bielefeld_26102017',...
    '31_Freiburg_181017','32_wangcheng_xuanwu','33_Freiburg_070817a','34_Freiburg_081217b','35_dudan_304',...
    '36_wuwenting_304','37_wuwenting2_304','38_chengtangjian_304','39_Freiburg_081217a','40_xialinglinga_yuquan',...
    '41_yefeng_304'};
Name = {'1_lvjutao_yuquan','2_guyitao_304','3_yinjin_301','4_liuzhiming_yuquan','5_heqiang_304',...
    '6_fanjiang_301','7_changdanyuan_yuquan','8_xiezhidong_301','9_zhanghaibin_yuquan','10_gaozhibo_yuquan',...
    '11_zhangqiaofeng_yuquan','12_guobin_yuquan','13_peijian_304','14_dinglanlan_304','15_dongfenlian_yuquan',...
    '16_yuyanan_304','17_duruijiao_yuquan','18_Bielefeld_170417_problem','19_Bielefeld_180617_problem','20_Freiburg_070817b_problem',...
    '21_Freiburg_190517', '22_Freiburg_190717','23_Freiburg_210617','24_wangyanbin_304','25_lixiangju_yuquan',...
    '26_Bielefeld_030317_problem','27_Bielefeld_08122017_empty','28_Bielefeld_10092017_problem','29_Bielefeld_24112017_problem', '30_Bielefeld_26102017',...
    '31_Freiburg_181017','32_wangcheng_xuanwu','33_Freiburg_070817a','34_Freiburg_081217b','35_dudan_304',...
    '36_wuwenting_304','37_wuwenting2_304','38_chengtangjian_304','39_Freiburg_081217a','40_xialinglinga_yuquan',...
    '41_yefeng_304'};
logFileName = {'sub1','sub2','sub3','sub4','sub5',...
               'sub6','sub7','sub8','sub9','sub10',...
               'sub11','sub12','sub13','sub14','sub15',...
               'sub16','sub17','sub18','sub19','sub20',...
               'sub21','sub22','sub23','sub24','sub25',...
               'sub26','sub27','sub28','sub29','sub30',...
               'sub31','sub32','sub33','sub34','sub35',...
               'sub36','sub37','sub38','sub39','sub40',...
               'sub41'};

fileName = ['D:\eledata\eleinformation.mat'];
load(fileName);  
fileName = ['D:\eledata\ele_interest_region.mat'];
load(fileName);  

name=[3 4 7 13 15 17 22 24 33 ];
sigma=9;
size_h=[35 35];%16
h=fspecial('gaussian',size_h,sigma);


for i=6%1:length(name)

    folderPathName{name(i)} 
    filename = ['D:\dollermaze_navigation_data\' folderPathName{name(i)} '\movementinformation_detail.mat']; 
    load(filename)
        
     goodobj_data= moveinformation_detail(:,find(moveinformation_detail(13,:)==1));
     badobj_data= moveinformation_detail(:,find(moveinformation_detail(13,:)==2));
%% 
good_radius_traj=sqrt(goodobj_data(3,:).^2+goodobj_data(4,:).^2);
good_r=prctile(good_radius_traj,50);
bad_radius_traj=sqrt(badobj_data(3,:).^2+badobj_data(4,:).^2);
bad_r=prctile(bad_radius_traj,50);
%% 
     g_mat=zeros(900,900);    
     b_mat=zeros(900,900);   
     
     g_bound=zeros(900,900);
     g_center=zeros(900,900);
     b_bound=zeros(900,900);
     b_center=zeros(900,900);
     
     for ii=1:size(goodobj_data,2)-1
         if goodobj_data(11,ii+1)==goodobj_data(11,ii) % 在同一个trial里比较角度
            diff_ang=abs(goodobj_data(7,ii+1)-goodobj_data(7,ii));
            xi=round(goodobj_data(3,ii)/10)+450;
            yi=round(goodobj_data(4,ii)/10)+450;
             if xi>900 
                xi=900;
             end
            if xi<1 
                xi=1;
            end
            if yi<1
                yi=1;
            end
            if yi>900
                yi=900;
            end
            if ~isnan(g_mat(xi,yi))
                g_mat(xi,yi)=g_mat(xi,yi)+diff_ang;
            else
                g_mat(xi,yi)=diff_ang;
            end
            
            if sqrt((xi-450)^2+(yi-450)^2)>=(good_r/10)
               g_bound(xi,yi)=g_bound(xi,yi)+diff_ang;
            else
               g_center(xi,yi)=g_center(xi,yi)+diff_ang; 
            end
            
         end
     end
   
     g_not_zero=g_mat(find(g_mat~=0));
     g_bound_not_zero=g_bound(find(g_bound~=0));
     g_center_not_zero=g_center(find(g_center~=0));
     
     for ii=1:size(badobj_data,2)-1
         if badobj_data(11,ii+1)==badobj_data(11,ii) % 在同一个trial里比较角度
            diff_ang=abs(badobj_data(7,ii+1)-badobj_data(7,ii));
            xi=round(badobj_data(3,ii)/10)+450;
            yi=round(badobj_data(4,ii)/10)+450;
            if xi>900 
                xi=900;
            end
            if xi<1 
                xi=1;
            end
            if yi<1
                yi=1;
            end
            if yi>900
                yi=900;
            end
            
            if ~isnan(b_mat(xi,yi))
                b_mat(xi,yi)=b_mat(xi,yi)+diff_ang;
            else
                b_mat(xi,yi)=diff_ang;
            end

            if sqrt((xi-450)^2+(yi-450)^2)>=(bad_r/10)
               b_bound(xi,yi)=b_bound(xi,yi)+diff_ang;
            else
               b_center(xi,yi)=b_center(xi,yi)+diff_ang; 
            end
            
         end
     end     
     b_not_zero=b_mat(find(b_mat~=0));
     b_bound_not_zero=b_bound(find(b_bound~=0));
     b_center_not_zero=b_center(find(b_center~=0));
%%
goodobj_objnum=unique(goodobj_data(8,:));
badobj_objnum=unique(badobj_data(8,:));
    filename = ['D:\dollermaze_navigation_data\' folderPathName{name(i)} '\beh_info.mat']; 
    load(filename)
objloc=behInfo.objLoc;
goodobj_loc=objloc(goodobj_objnum,:);
badobj_loc=objloc(badobj_objnum,:);
 %%    
    handle_f= figure(i);
     subplot(2,4,1)% goodobj
     plot(goodobj_data(3,:),goodobj_data(4,:))
     ylim([-5000,5000])
      axis square
     hold on
     scatter(goodobj_loc(:,1),goodobj_loc(:,2),'r','filled')
     clear c_ang
     c_ang=0:2*pi/3600:2*pi;
     r=4500;
     Circle1=0+r*cos(c_ang);
     Circle2=0+r*sin(c_ang);
     plot(Circle1,Circle2,'k','Linewidth',1);
     axis square
     title(['Sub',num2str(name(i)),'-goodobj-traj'])
     
     subplot(2,4,2)% badobj
     plot(badobj_data(3,:),badobj_data(4,:))
      axis square
      hold on
     scatter(badobj_loc(:,1),badobj_loc(:,2),'r','filled')
     clear c_ang
     c_ang=0:2*pi/3600:2*pi;
     r=4500;
     Circle1=0+r*cos(c_ang);
     Circle2=0+r*sin(c_ang);
     plot(Circle1,Circle2,'k','Linewidth',1);
     axis square
     title(['Sub',num2str(name(i)),'-badobj-traj'])
     
     subplot(2,4,3)% goodobj-badobj
     bar([length(g_not_zero),length(b_not_zero)])
     title(['goodbad-data-size'])
     set(gca,'xticklabel',{'good','bad'});
     
     subplot(2,4,4)% goodobj-badobj
     bar([mean(g_not_zero),mean(b_not_zero)])
     hold on
     errorbar(1:2,[mean(g_not_zero),mean(b_not_zero)],[std(g_not_zero)/sqrt(length(g_not_zero)),std(b_not_zero)/sqrt(length(b_not_zero))])
     len=min(length(g_not_zero),length(b_not_zero));
     [~,p] =ttest2(g_not_zero(1:len),b_not_zero(1:len));
     set(gca,'xticklabel',{'good','bad'});
     ylabel('Moving angle chage')
     title(['goodbad-\Deltaangle-p',num2str(p,3)])
     
     
      subplot(2,4,5)% goodobj
      gmt=imfilter(g_mat,h,'conv','circular','same');
      imagesc(gmt')
    % imagesc(g_mat')
      axis xy
     axis square
     hold on
   %  colorbar
     c_ang=0:2*pi/3600:2*pi;
     r=450;
     Circle1=450+r*cos(c_ang);
     Circle2=450+r*sin(c_ang);
     plot(Circle1,Circle2,'g','Linewidth',1);
     axis square
     title(['goodobj-angle change'])
     
     subplot(2,4,6)% badobj
      bmt=imfilter(b_mat,h,'conv','circular','same');
      imagesc(bmt')
     %imagesc(b_mat')
      axis xy
     axis square
    % colorbar
    hold on
        c_ang=0:2*pi/3600:2*pi;
     r=450;
     Circle1=450+r*cos(c_ang);
     Circle2=450+r*sin(c_ang);
     plot(Circle1,Circle2,'g','Linewidth',1);
     axis square
      title(['badobj-angel change'])
   
     subplot(2,4,7)% goodobj-bound-center
     b1=bar([mean(g_bound_not_zero),mean(g_center_not_zero)]);
     set(b1,'FaceColor',[205/256, 92/256, 92/256]);
     hold on
     errorbar(1:2,[mean(g_bound_not_zero),mean(g_center_not_zero)],[std(g_bound_not_zero)/sqrt(length(g_bound_not_zero)),std(g_center_not_zero)/sqrt(length(g_center_not_zero))])
     len=min(length(g_bound_not_zero),length(g_center_not_zero));
     [~,p] =ttest2(g_bound_not_zero(1:len),g_center_not_zero(1:len));
     set(gca,'xticklabel',{'bound','center'});
     ylabel('Moving angle chage')
     title(['goodobj-\Deltaang-p',num2str(p,3)])
     good_bound(i)=mean(g_bound_not_zero);
     good_center(i)=mean(g_center_not_zero);
     
     subplot(2,4,8)% badobj-bound-center
     b2=bar([mean(b_bound_not_zero),mean(b_center_not_zero)]);
     set(b2,'FaceColor',[46/256, 139/256, 87/256]);
     hold on
     errorbar(1:2,[mean(b_bound_not_zero),mean(b_center_not_zero)],[std(b_bound_not_zero)/sqrt(length(b_bound_not_zero)),std(b_center_not_zero)/sqrt(length(b_center_not_zero))])
     len=min(length(b_bound_not_zero),length(b_center_not_zero));
     [~,p] =ttest2(b_bound_not_zero(1:len),b_center_not_zero(1:len));
     set(gca,'xticklabel',{'bound','center'});
     ylabel('Moving angle chage')
     title(['badobj-\Deltaang-p',num2str(p,3)])
     
     bad_bound(i)=mean(b_bound_not_zero);
     bad_center(i)=mean(b_center_not_zero);


end       

figure(20)% subject level statistic
subplot(1,2,1)
     b3=bar([mean(good_bound),mean(good_center)]);
     set(b3,'FaceColor',[47/256, 79/256, 79/256]);
     hold on
     errorbar(1:2,[mean(good_bound),mean(good_center)],[std(good_bound)/sqrt(length(good_bound)),std(good_center)/sqrt(length(good_center))],'Linestyle','None')
     [~,p] =ttest2(good_bound,good_center);
     set(gca,'xticklabel',{'bound','center'});
     ylabel('Moving angle chage')
     title(['Allsub\_goodobj-\Deltaang-p',num2str(p,3)])

 subplot(1,2,2)
     b3=bar([mean(bad_bound),mean(bad_center)]);
     set(b3,'FaceColor',[112/256, 128/256, 144/256]);
     hold on
     errorbar(1:2,[mean(bad_bound),mean(bad_center)],[std(bad_bound)/sqrt(length(bad_bound)),std(bad_center)/sqrt(length(bad_center))],'Linestyle','None')
     [~,p] =ttest2(bad_bound,bad_center);
     set(gca,'xticklabel',{'bound','center'});
     ylabel('Moving angle chage')
     title(['Allsub\_badobj-\Deltaang-p',num2str(p,3)])
     

    