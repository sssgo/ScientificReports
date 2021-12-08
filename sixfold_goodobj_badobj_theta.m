% wwj 2020

%%
clear all;

logFileName = {'sub1','sub2','sub3','sub4','sub5',...
               'sub6','sub7','sub8','sub9','sub10',...
               'sub11','sub12','sub13','sub14','sub15',...
               'sub16','sub17','sub18','sub19','sub20',...
               'sub21','sub22','sub23','sub24','sub25',...
               'sub26','sub27','sub28','sub29','sub30',...
               'sub31','sub32','sub33'};

fileName = ['E:\eledata\eleinformation.mat'];
load(fileName);  
fileName = ['E:\eledata\ele_interest_region.mat'];
load(fileName);  

name=[3 4 7 13 15 17 22 24 33 ];

shuffletime=2;count=0;
for i=1:length(name)
    folderPathName{name(i)} 
    ele=ele_interest_region{2,name(i)};
    
%                  end
                 goodobjtheta=[];
                 badobjtheta=[];

    for k=1:size(ele,1)
   %   %------------goodobj
         fileName = ['E:\epochdata5std\goodobjepochdata_' num2str(name(i)) '_' num2str(ele(k,1)) '.mat'];
         if exist(fileName)==2
             load(fileName);
           %  Gridlikeregoodobjntation=cell(1,1);
             if  length(goodobjepochdata.behave(4,:))>=1000;
                 [behevepoch] = epochindex(goodobjepochdata);
                 Gridregoodobjsentation= GLM_parametric(goodobjepochdata,behevepoch,shuffletime);

                 goodobjtheta=[goodobjtheta;  Gridregoodobjsentation.beta];

                 fileName = ['E:\goodobjbadobj\'];
                 matrixname=['HilbertGrid_goodobj_' num2str(name(i)) '_' num2str(ele(k)) '.mat'];
                 save([fileName, matrixname],'Gridregoodobjsentation');
             end
         end
       %------------badobj 
       fileName = ['E:\epochdata5std\badobjepochdata_' num2str(name(i)) '_' num2str(ele(k,1)) '.mat'];
         if exist(fileName)==2
             load(fileName);
             if  length(badobjepochdata.behave(4,:))>=1000;
                 [behevepoch] = epochindex(badobjepochdata);
                 Gridregoodobjsentation= GLM_parametric(badobjepochdata,behevepoch,shuffletime);
               
                 badobjtheta=[badobjtheta; Gridregoodobjsentation.beta];

                 fileName = ['E:\goodobjbadobj\'];
                 matrixname=['HilbertGrid_badobj_' num2str(name(i)) '_' num2str(ele(k)) '.mat'];
                 save([fileName, matrixname],'Gridregoodobjsentation');
             end
         end

    end
 %%  
    %------每个被试画一张goodobj badobj的beta对比图
%     figure(1)
%         subplot(3,4,1)
%     b=bar(mean(goodobjlowtheta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(goodobjlowtheta,1)>1
%         stdbar=std(goodobjlowtheta,1)/sqrt(size(goodobjlowtheta,2));
%     else
%         stdbar=zeros(1,size(goodobjlowtheta,2));
%     end
%        errorbar(mean(goodobjlowtheta,1),stdbar);
%        xlim([0,6]);ylim([-0.03,0.03]);
%    set(gca,'xticklabel',{'4','5','6','7','8'});
%     ylabel('Beta')
%     title('lowTheta-goodobj')
%     
%     %---
%         subplot(3,4,2)
%     b=bar(mean(badobjlowtheta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(badobjtheta,1)>1
%         stdbar=std(badobjlowtheta,1)/sqrt(size(badobjlowtheta,2));
%     else
%         stdbar=zeros(1,size(badobjlowtheta,2));
%     end
%        errorbar(mean(badobjlowtheta,1),stdbar);
%        xlim([0,6]);ylim([-0.03,0.03]);
%     set(gca,'xticklabel',{'4','5','6','7','8'});
%    % ylabel('Beta')
%     title('lowTheta-badobj')
%     %------------------------------------
%     subplot(3,4,3)
%     b=bar(mean(goodobjtheta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(goodobjtheta,1)>1
%         stdbar=std(goodobjtheta,1)/sqrt(size(goodobjtheta,2));
%     else
%         stdbar=zeros(1,size(goodobjtheta,2));
%     end
%        errorbar(mean(goodobjtheta,1),stdbar);
%    set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('Theta-goodobj')
%     
%     %---
%         subplot(3,4,4)
%     b=bar(mean(badobjtheta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(badobjtheta,1)>1
%         stdbar=std(badobjtheta,1)/sqrt(size(badobjtheta,2));
%     else
%         stdbar=zeros(1,size(badobjtheta,2));
%     end
%        errorbar(mean(badobjtheta,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('Theta-badobj')
%     %------------------------------------
%         subplot(3,4,5)
%     b=bar(mean(goodobjalpha,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(goodobjalpha,1)>1
%         stdbar=std(goodobjalpha,1)/sqrt(size(goodobjalpha,2));
%     else
%         stdbar=zeros(1,size(goodobjalpha,2));
%     end
%        errorbar(mean(goodobjtheta,1),stdbar);
%    set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%     ylabel('Beta')
%     title('Alpha-goodobj')
%     
%     %---
%         subplot(3,4,6)
%     b=bar(mean(badobjalpha,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(badobjalpha,1)>1
%         stdbar=std(badobjalpha,1)/sqrt(size(badobjalpha,2));
%     else
%         stdbar=zeros(1,size(badobjalpha,2));
%     end
%        errorbar(mean(badobjalpha,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('Alpha-badobj')
%     %------------------------------------
%          subplot(3,4,7)
%     b=bar(mean(goodobjbeta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(goodobjbeta,1)>1
%         stdbar=std(goodobjbeta,1)/sqrt(size(goodobjbeta,2));
%     else
%         stdbar=zeros(1,size(goodobjbeta,2));
%     end
%        errorbar(mean(goodobjbeta,1),stdbar);
%    set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%    % ylabel('Beta')
%     title('Beta-goodobj')
%     
%     %---
%         subplot(3,4,8)
%     b=bar(mean(badobjbeta,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(badobjbeta,1)>1
%         stdbar=std(badobjbeta,1)/sqrt(size(badobjbeta,2));
%     else
%         stdbar=zeros(1,size(badobjbeta,2));
%     end
%        errorbar(mean(badobjbeta,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%  %   ylabel('Beta')
%     title('Beta-badobj')
%     %---------------
%           subplot(3,4,9)
%     b=bar(mean(goodobjlowgamma,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(goodobjlowgamma,1)>1
%         stdbar=std(goodobjlowgamma,1)/sqrt(size(goodobjlowgamma,2));
%     else
%         stdbar=zeros(1,size(goodobjlowgamma,2));
%     end
%        errorbar(mean(goodobjlowgamma,1),stdbar);
%        xlim([0,6]);ylim([-0.03,0.03]);
%    set(gca,'xticklabel',{'4','5','6','7','8'});
%     ylabel('Beta')
%     title('lg-goodobj')
%     
%     %---
%         subplot(3,4,10)
%     b=bar(mean(badobjlowgamma,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(badobjlowgamma,1)>1
%         stdbar=std(badobjlowgamma,1)/sqrt(size(badobjlowgamma,2));
%     else
%         stdbar=zeros(1,size(badobjlowgamma,2));
%     end
%        errorbar(mean(badobjlowgamma,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('lg-badobj')
%     %------------------------
%            subplot(3,4,11)
%     b=bar(mean(goodobjhighgamma,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(goodobjhighgamma,1)>1
%         stdbar=std(goodobjhighgamma,1)/sqrt(size(goodobjhighgamma,2));
%     else
%         stdbar=zeros(1,size(goodobjhighgamma,2));
%     end
%        errorbar(mean(goodobjhighgamma,1),stdbar);
%    set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%  %   ylabel('Beta')
%     title('hg-goodobj')
%     
%     %---
%         subplot(3,4,12)
%     b=bar(mean(badobjhighgamma,1));
%     set(b,'facecolor',[70/256 170/256 155/256]);
%     hold on
%     if size(badobjhighgamma,1)>1
%         stdbar=std(badobjhighgamma,1)/sqrt(size(badobjhighgamma,2));
%     else
%         stdbar=zeros(1,size(badobjhighgamma,2));
%     end
%        errorbar(mean(badobjhighgamma,1),stdbar);
%     set(gca,'xticklabel',{'4','5','6','7','8'});xlim([0,6]);ylim([-0.03,0.03]);
%   %  ylabel('Beta')
%     title('hg-badobj')
%    suptitle(['Sub'  num2str(name(i))])
%   
%   figname=['F:\Goaldata_sixrotation\goodobjbadobj\Sub'  num2str(name(i)) '_band6fold_Beta.png'];
%   print(gcf,'-dpng','-r800',figname) 
%   close(figure(1)) 
    
%   submean{i}=[mean(goodobjlowtheta,1);mean(badobjlowtheta,1);......
%       mean(goodobjtheta,1);mean(badobjtheta,1)...
%       ;mean(goodobjalpha,1);mean(badobjalpha,1);...
%       mean(goodobjbeta,1);mean(badobjbeta,1);...
%       mean(goodobjlowgamma,1);mean(badobjlowgamma,1);...
%       mean(goodobjhighgamma,1);mean(badobjhighgamma,1)];
 %% %
      figure(1)
        subplot(1,2,1)
    b=bar(mean(goodobjtheta,1));
    set(b,'facecolor',[70/256 150/256 150/256]);
    hold on
    if size(goodobjtheta,1)>1
        stdbar=std(goodobjtheta,1)/sqrt(size(goodobjtheta,2));
    else
        stdbar=zeros(1,size(goodobjtheta,2));
    end
       errorbar(mean(goodobjtheta,1),stdbar);
       xlim([0,6]);ylim([-0.2,0.2]);
   set(gca,'xticklabel',{'4fold','5fold','6fold','7fold','8fold'});
    ylabel('Beta')
    title('Theta-goodobj')
    
          subplot(1,2,2)
    b=bar(mean(badobjtheta,1));
    set(b,'facecolor',[70/256 170/256 155/256]);
    hold on
    if size(badobjtheta,1)>1
        stdbar=std(badobjtheta,1)/sqrt(size(badobjtheta,2));
    else
        stdbar=zeros(1,size(badobjtheta,2));
    end
       errorbar(mean(badobjtheta,1),stdbar);
    set(gca,'xticklabel',{'4fold','5fold','6fold','7fold','8fold'});xlim([0,6]);ylim([-0.2,0.2]);
    ylabel('Beta')
    title('Theta-badobj')
 suptitle(['Sub'  num2str(name(i))])
 
      figname=['E:\goodobjbadobj\Sub'  num2str(name(i)) '_theta_betavalue.png'];
  print(gcf,'-dpng','-r800',figname) 
  close(figure(1)) 
  
  submean_goodobj(i,:)=mean(goodobjtheta,1);
  submean_badobj(i,:)=mean(badobjtheta,1);
    %%
end
      figure(2)
        subplot(1,2,1)
    b=bar(mean(submean_goodobj,1));
    set(b,'facecolor',[100/256 120/256 120/256]);
    hold on
    if size(submean_goodobj,1)>1
        stdbar1=std(submean_goodobj,1)/sqrt(size(submean_goodobj,2));
    else
        stdbar1=zeros(1,size(submean_goodobj,2));
    end
       errorbar(mean(submean_goodobj,1),stdbar1);
       xlim([0,6]);ylim([-0.2,0.2]);
     %---
      
     hold on
     for ss=1:5
         scatter(ss*ones(size(submean_goodobj,1),1),submean_goodobj(:,ss),10,[0.3 0.3 0.3])
         hold on
         [~,p0] =ttest(submean_goodobj(:,ss));
        % text(ss-0.25,mean(submean_goodobj(:,ss))+0.01,num2str(p0,3));
         text(ss-0.15,0.02,num2str(p0,2),'FontSize',6);
         hold on
     end
       
   set(gca,'xticklabel',{'4fold','5fold','6fold','7fold','8fold'});
    ylabel('Beta')
    title('All-Sub-goodobj')
    
          subplot(1,2,2)
    b=bar(mean(submean_badobj,1));
    set(b,'facecolor',[50/256 190/256 205/256]);
    hold on
    if size(submean_badobj,1)>1
        stdbar2=std(submean_badobj,1)/sqrt(size(submean_badobj,2));
    else
        stdbar2=zeros(1,size(submean_badobj,2));
    end
       errorbar(mean(submean_badobj,1),stdbar2);
    
       xlim([0,6]);
       ylim([-0.2,0.2]);
        %---
      
     hold on
     for ss=1:5
       %  scatter(ss*ones(size(submean_badobj,1),1),submean_badobj(:,ss),10,'k','filled')
         scatter(ss*ones(size(submean_badobj,1),1),submean_badobj(:,ss),10,[0.5 0.5 0.5],'filled')
         hold on
         [~,p1] =ttest(submean_badobj(:,ss));
         text(ss-0.15,mean(submean_badobj(:,ss))+0.01,num2str(p1,2),'FontSize',6);
        % text(ss-0.25,0.05,num2str(p1,3));
         hold on
     end   
       
    set(gca,'xticklabel',{'4fold','5fold','6fold','7fold','8fold'});
%     for ii=1:5
%     [~,p(ii)] =ttest(submean_badobj(:,ii));
%     end
    ylabel('Beta')
 %   xlabel([num2str(p)])
    title('All-Sub-badobj')

      figname=['E:\goodobjbadobj\AllSub_theta_betavalue.png'];
  print(gcf,'-dpng','-r800',figname) 
 
     filename=['E:\AllSub_badobj.mat'];
     save(filename,'submean_badobj')
     filename=['E:\AllSub_goodobj.mat'];
     save(filename,'submean_goodobj')
     
          figure(3)
     badobj=submean_badobj(:,3);
     goodobj=submean_goodobj(:,3);
     [~,p1]= ttest2(badobj,goodobj);
     bar([mean(badobj),mean(goodobj)]);
     hold on
     errorbar([mean(badobj),mean(goodobj)],[stdbar2(:,3),stdbar1(:,3)]);
     set(gca,'xticklabel',{'badobj','goodobj'});
     ylabel('Hexadirectional Modulation')
     title(['badobj\_goodobj\_pvalue-' num2str(p1)])
     figname=['E:\goodobjbadobj\AllSub_badobj_goodobj.png'];
     print(gcf,'-dpng','-r800',figname) 
% [h,p] =ttest(submean_badobj(:,3),submean_goodobj(:,3))
% plot(submean_goodobj(:,3))
% hold on
% plot(submean_badobj(:,3))
% 
% 
% bar([mean(submean_goodobj(:,3)),mean(submean_badobj(:,3))])


