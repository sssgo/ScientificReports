% wwj 2019-5-2
% 

%%
clear all;

logFileName = {'sub1','sub2','sub3','sub4','sub5',...
               'sub6','sub7','sub8','sub9','sub10',...
               'sub11','sub12','sub13','sub14','sub15',...
               'sub16','sub17','sub18','sub19','sub20',...
               'sub21','sub22','sub23','sub24','sub25',...
               'sub26','sub27','sub28','sub29','sub30',...
               'sub31','sub32','sub33'};
% s=0:49;f=@(x)2*10^(0.0383*x);F=arrayfun(f,s);shuffletime=1;

% bandname={'lowtheta','theta','alpha','beta','lowgamma','highgamma'};
% lowtheta=[1:3];
% theta=[4:8];
% alpha=[9:12];
% beta=[13:18];
% lowgamma=[19:24];
% highgamma=[25:33];

fileName = ['L:\eledata\eleinformation.mat'];
load(fileName);  
fileName = ['L:\eledata\ele_interest_region.mat'];
load(fileName);  

%condition={'boundary','middle','center'};
condition={'goodobjfar','goodobjmid','goodobjnear'};% near是最中心的，far是边界的

%condition={'allobj-grabfar','allobj-grabmid','allobj-grabnear'};
name=[3 4 7 13 15 17 22 24 33 ];

shuffletime=2;count=0;
for i=1:length(name)
    folderPathName{name(i)} 
    ele=ele_interest_region{2,name(i)};
    
%                  for ii=1:length(bandname)
%                    %  allobj-grabinnertheta=[allobj-grabinnertheta; mean( Gridreallobj-grabinnersentation.beta(1:3,:))];
%                      eval(['allobj-grabinner' bandname{ii} '=[];']);
%                      eval(['allobj-grabinner' bandname{ii} '=[];']);
%                  end
                 far_mid=[];
                 mid_near=[];

    for k=1:size(ele,1)
   %   %------------far mid near 要比较两次，far和mid比一次，mid和near比一次 
     for ii=1:2
         cond1=condition{ii};
         cond2=condition{ii+1};
         
         fileName1 = ['J:\Goal_ec_retrieval\renew\boundary_center_gdbaobj_5std\epochdata\' cond1 'epochdata_' num2str(name(i)) '_' num2str(ele(k,1)) '.mat'];
         fileName2 = ['J:\Goal_ec_retrieval\renew\boundary_center_gdbaobj_5std\epochdata\' cond2 'epochdata_' num2str(name(i)) '_' num2str(ele(k,1)) '.mat'];
         if exist(fileName1)==2 && exist(fileName2)==2
             load(fileName1);
             load(fileName2);
             eval(['epochdata1=' cond1 'epochdata;']);
             eval(['epochdata2=' cond2 'epochdata;']);
%              [behevepoch1] = epochindex(epochdata1);
%              [behevepoch2] = epochindex(epochdata2);
%              
             if ii==1
                Gridrepresentation_far_mid= GLM_parametric_2parts(epochdata1,epochdata2);
                far_mid=[far_mid; Gridrepresentation_far_mid.beta];
             else
                Gridrepresentation_mid_near= GLM_parametric_2parts(epochdata1,epochdata2);
                mid_near=[mid_near; Gridrepresentation_mid_near.beta];
             end
% 
%                  fileName = ['F:\Goaldata_sixrotation\visunvis\'];
%                  matrixname=['HilbertGrid_vis_' num2str(name(i)) '_' num2str(ele(k)) '.mat'];
%                  save([fileName, matrixname],'Gridrepresentation');
         end
     end
    end
 %%  
    %
%     figure(1)
%         subplot(3,4,1)
%     b=bar(mean(allobj-grabinnerlowtheta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnerlowtheta,1)>1
%         stdbar=std(allobj-grabinnerlowtheta,1)/sqrt(size(allobj-grabinnerlowtheta,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnerlowtheta,2));
%     end
%        errorbar(mean(allobj-grabinnerlowtheta,1),stdbar);
%        xlim([0,6]);ylim([-0.03,0.03]);
%    set(gca,'xticklabel',{'4','5','6','7','8'});
%     ylabel('Beta')
%     title('lowTheta-allobj-grabinner')
%     
%     %---
%         subplot(3,4,2)
%     b=bar(mean(allobj-grabinnerlowtheta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnertheta,1)>1
%         stdbar=std(allobj-grabinnerlowtheta,1)/sqrt(size(allobj-grabinnerlowtheta,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnerlowtheta,2));
%     end
%        errorbar(mean(allobj-grabinnerlowtheta,1),stdbar);
%        xlim([0,6]);ylim([-0.03,0.03]);
%     set(gca,'xticklabel',{'4','5','6','7','8'});
%    % ylabel('Beta')
%     title('lowTheta-allobj-grabinner')
%     %------------------------------------
%     subplot(3,4,3)
%     b=bar(mean(allobj-grabinnertheta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnertheta,1)>1
%         stdbar=std(allobj-grabinnertheta,1)/sqrt(size(allobj-grabinnertheta,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnertheta,2));
%     end
%        errorbar(mean(allobj-grabinnertheta,1),stdbar);
%    set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('Theta-allobj-grabinner')
%     
%     %---
%         subplot(3,4,4)
%     b=bar(mean(allobj-grabinnertheta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnertheta,1)>1
%         stdbar=std(allobj-grabinnertheta,1)/sqrt(size(allobj-grabinnertheta,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnertheta,2));
%     end
%        errorbar(mean(allobj-grabinnertheta,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('Theta-allobj-grabinner')
%     %------------------------------------
%         subplot(3,4,5)
%     b=bar(mean(allobj-grabinneralpha,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinneralpha,1)>1
%         stdbar=std(allobj-grabinneralpha,1)/sqrt(size(allobj-grabinneralpha,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinneralpha,2));
%     end
%        errorbar(mean(allobj-grabinnertheta,1),stdbar);
%    set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%     ylabel('Beta')
%     title('Alpha-allobj-grabinner')
%     
%     %---
%         subplot(3,4,6)
%     b=bar(mean(allobj-grabinneralpha,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinneralpha,1)>1
%         stdbar=std(allobj-grabinneralpha,1)/sqrt(size(allobj-grabinneralpha,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinneralpha,2));
%     end
%        errorbar(mean(allobj-grabinneralpha,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('Alpha-allobj-grabinner')
%     %------------------------------------
%          subplot(3,4,7)
%     b=bar(mean(allobj-grabinnerbeta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnerbeta,1)>1
%         stdbar=std(allobj-grabinnerbeta,1)/sqrt(size(allobj-grabinnerbeta,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnerbeta,2));
%     end
%        errorbar(mean(allobj-grabinnerbeta,1),stdbar);
%    set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%    % ylabel('Beta')
%     title('Beta-allobj-grabinner')
%     
%     %---
%         subplot(3,4,8)
%     b=bar(mean(allobj-grabinnerbeta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnerbeta,1)>1
%         stdbar=std(allobj-grabinnerbeta,1)/sqrt(size(allobj-grabinnerbeta,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnerbeta,2));
%     end
%        errorbar(mean(allobj-grabinnerbeta,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%  %   ylabel('Beta')
%     title('Beta-allobj-grabinner')
%     %---------------
%           subplot(3,4,9)
%     b=bar(mean(allobj-grabinnerlowgamma,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnerlowgamma,1)>1
%         stdbar=std(allobj-grabinnerlowgamma,1)/sqrt(size(allobj-grabinnerlowgamma,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnerlowgamma,2));
%     end
%        errorbar(mean(allobj-grabinnerlowgamma,1),stdbar);
%        xlim([0,6]);ylim([-0.03,0.03]);
%    set(gca,'xticklabel',{'4','5','6','7','8'});
%     ylabel('Beta')
%     title('lg-allobj-grabinner')
%     
%     %---
%         subplot(3,4,10)
%     b=bar(mean(allobj-grabinnerlowgamma,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnerlowgamma,1)>1
%         stdbar=std(allobj-grabinnerlowgamma,1)/sqrt(size(allobj-grabinnerlowgamma,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnerlowgamma,2));
%     end
%        errorbar(mean(allobj-grabinnerlowgamma,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('lg-allobj-grabinner')
%     %------------------------
%            subplot(3,4,11)
%     b=bar(mean(allobj-grabinnerhighgamma,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnerhighgamma,1)>1
%         stdbar=std(allobj-grabinnerhighgamma,1)/sqrt(size(allobj-grabinnerhighgamma,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnerhighgamma,2));
%     end
%        errorbar(mean(allobj-grabinnerhighgamma,1),stdbar);
%    set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%  %   ylabel('Beta')
%     title('hg-allobj-grabinner')
%     
%     %---
%         subplot(3,4,12)
%     b=bar(mean(allobj-grabinnerhighgamma,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(allobj-grabinnerhighgamma,1)>1
%         stdbar=std(allobj-grabinnerhighgamma,1)/sqrt(size(allobj-grabinnerhighgamma,2));
%     else
%         stdbar=zeros(1,size(allobj-grabinnerhighgamma,2));
%     end
%        errorbar(mean(allobj-grabinnerhighgamma,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('hg-allobj-grabinner')
%    suptitle(['Sub'  num2str(name(i))])
%   
%   figname=['F:\Goaldata_sixrotation\allobj-grabinnerallobj-grabinner\Sub'  num2str(name(i)) '_band6fold_Beta.png'];
%   print(gcf,'-dpng','-r800',figname) 
%   close(figure(1)) 
    
%   submean{i}=[mean(allobj-grabinnerlowtheta,1);mean(allobj-grabinnerlowtheta,1);......
%       mean(allobj-grabinnertheta,1);mean(allobj-grabinnertheta,1)...
%       ;mean(allobj-grabinneralpha,1);mean(allobj-grabinneralpha,1);...
%       mean(allobj-grabinnerbeta,1);mean(allobj-grabinnerbeta,1);...
%       mean(allobj-grabinnerlowgamma,1);mean(allobj-grabinnerlowgamma,1);...
%       mean(allobj-grabinnerhighgamma,1);mean(allobj-grabinnerhighgamma,1)];
 %% %
       figure(1)
    subplot(1,2,1)
    b=bar(mean(far_mid,1));
    set(b,'facecolor',[70/256 150/256 150/256]);
    hold on
    if size(far_mid,1)>1
        stdbar=std(far_mid,1)/sqrt(size(far_mid,1));
    else
        stdbar=zeros(1,size(far_mid,2));
    end
       errorbar(mean(far_mid,1),stdbar);
       xlim([0,6]);ylim([-0.2,0.2]);
   set(gca,'xticklabel',{'4fold','5fold','6fold','7fold','8fold'});
    ylabel('Hexadirectional Modulation')
    title('Theta-goodobj-Boundary')
    
          subplot(1,2,2)
    b=bar(mean(mid_near,1));
    set(b,'facecolor',[70/256 170/256 155/256]);
    hold on
    if size(mid_near,1)>1
        stdbar=std(mid_near,1)/sqrt(size(mid_near,1));
    else
        stdbar=zeros(1,size(mid_near,2));
    end
       errorbar(mean(mid_near,1),stdbar);
    set(gca,'xticklabel',{'4fold','5fold','6fold','7fold','8fold'});xlim([0,6]);ylim([-0.2,0.2]);
    ylabel('Hexadirectional Modulation')
    title('Theta-goodobj-Center')
  suptitle(['Sub'  num2str(name(i))])

      figname=['J:\Goal_ec_retrieval\renew\boundary_center_gdbaobj_5std\1100-2200\Sub'  num2str(name(i)) '_boundarycenter_goodobj.png'];
  print(gcf,'-dpng','-r800',figname) 
  close(figure(1)) 
  
   submean_far_mid(i,:)=mean(far_mid,1);
  submean_mid_near(i,:)=mean(mid_near,1);
    %%
end
       figure(2)
        subplot(1,2,1)
    b=bar(mean(submean_far_mid,1));
    set(b,'facecolor',[100/256 120/256 120/256]);
    hold on
    if size(submean_far_mid,1)>1
        stdbar1=std(submean_far_mid,1)/sqrt(size(submean_far_mid,1));
    else
        stdbar1=zeros(1,size(submean_far_mid,2));
    end
       errorbar(mean(submean_far_mid,1),stdbar1);
       xlim([0,6]);ylim([-0.15,0.3]);
           
     %---  
     hold on
     for ss=1:5
         scatter(ss*ones(size(submean_far_mid,1),1),submean_far_mid(:,ss),10,[0.5 0.5 0.5],'filled')
         hold on
         [~,p1] =ttest(submean_far_mid(:,ss));
         text(ss-0.15,mean(submean_far_mid(:,ss))+0.01,num2str(p1,2),'FontSize',6);
         hold on
     end   
     %----
   set(gca,'xticklabel',{'4fold','5fold','6fold','7fold','8fold'});
    ylabel('Hexadirectional Modulation')
    [~,p]=ttest(submean_far_mid(:,3));
    title(['AllSub-goodobj\_Boundary\_6fold-p' num2str(p,3)])
    
          subplot(1,2,2)
    b=bar(mean(submean_mid_near,1));
    set(b,'facecolor',[50/256 190/256 205/256]);
    hold on
    if size(submean_mid_near,1)>1
        stdbar2=std(submean_mid_near,1)/sqrt(size(submean_mid_near,1));
    else
        stdbar2=zeros(1,size(submean_mid_near,2));
    end
       errorbar(mean(submean_mid_near,1),stdbar2);
       
    %--- 
     hold on
     for ss=1:5
         scatter(ss*ones(size(submean_mid_near,1),1),submean_mid_near(:,ss),10,[0.5 0.5 0.5],'filled')
         hold on
         [~,p1] =ttest(submean_mid_near(:,ss));
         text(ss-0.15,mean(submean_mid_near(:,ss))+0.01,num2str(p1,2),'FontSize',6);
         hold on
     end   
     %----
    set(gca,'xticklabel',{'4fold','5fold','6fold','7fold','8fold'});xlim([0,6]);ylim([-0.15,0.3]);
    ylabel('Hexadirectional Modulation')
    [~,p]=ttest(submean_mid_near(:,3));
    title(['AllSub-goodobj\_Inner\_6fold-p' num2str(p,3)])

      figname=['J:\Goal_ec_retrieval\renew\boundary_center_gdbaobj_5std\1100-2200\AllSub_boundarycenter_theta_goodobj.png'];
  print(gcf,'-dpng','-r800',figname) 
  
 
     filename=['J:\Goal_ec_retrieval\renew\boundary_center_gdbaobj_5std\1100-2200\AllSub_goodobj_Boundary.mat'];
     save(filename,'submean_far_mid')
     filename=['J:\Goal_ec_retrieval\renew\boundary_center_gdbaobj_5std\1100-2200\AllSub_goodobj_Center.mat'];
     save(filename,'submean_mid_near')
     
     figure(3)
     boundary=submean_far_mid(:,3);
     inner=submean_mid_near(:,3);
     [~,p1]= ttest(boundary,inner);
     bar([mean(boundary),mean(inner)]);
     hold on
     errorbar([mean(boundary),mean(inner)],[stdbar1(:,3),stdbar2(:,3)]);
     set(gca,'xticklabel',{'Boundary','Center'});
     ylim([-0.15,0.3]);
     ylabel('Hexadirectional Modulation')
     title(['Boundary\_Center pvalue:' num2str(p1)])
     figname=['J:\Goal_ec_retrieval\renew\boundary_center_gdbaobj_5std\1100-2200\AllSub_boundarycenter_goodobj_6fold.png'];
     print(gcf,'-dpng','-r800',figname) 
     
% [h,p] =ttest(submean_allobj-grabinner(:,3),submean_allobj-grabinner(:,3))
% plot(submean_allobj-grabinner(:,3))
% hold on
% plot(submean_allobj-grabinner(:,3))
% 
% 
% bar([mean(submean_allobj-grabinner(:,3)),mean(submean_allobj-grabinner(:,3))])


