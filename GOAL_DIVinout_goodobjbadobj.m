%%
clear all;
folderPathName = {'1_lvjutao_yuquan','2_guyitao_304','3_yinjin_301','4_liuzhiming_yuquan','5_heqiang_304',...
    '6_fanjiang_301','7_changdanyuan_yuquan','8_xiezhidong_301','9_zhanghaibin_yuquan','10_gaozhibo_yuquan',...
    '11_zhangqiaofeng_yuquan','12_guobin_yuquan','13_peijian_304','14_dinglanlan_304','15_dongfenlian_yuquan',...
    '16_yuyanan_304','17_duruijiao_yuquan','18_Bielefeld_170417_problem','19_Bielefeld_180617_problem','20_Freiburg_070817b_problem',...
    '21_Freiburg_190517', '22_Freiburg_190717','23_Freiburg_210617','24_wangyanbin_304','25_lixiangju_yuquan',...
    '26_Bielefeld_030317_problem','27_Bielefeld_08122017_empty','28_Bielefeld_10092017_problem','29_Bielefeld_24112017_problem', '30_Bielefeld_26102017',...
    '31_Freiburg_181017','32_wangcheng_xuanwu','33_Freiburg_070817a','34_Freiburg_081217b','35_dudan_304',...
    '36_wuwenting_304','37_wuwenting2_304','38_chenjiantang_304','39_Freiburg_081217a',};
Name = {'lvjutao','guyitao','yinjin','liuzhiming','heqiang',...
    'fanjiang','changdanyuan','xiezhidong','zhanghaibin','gaozhibo',...
    'zhangqiaofeng','guobin','peijian','dinglanlan','dongfenlian',...
    'yuyanan','duruijiao','18_Bielefeld_170417_problem','19_Bielefeld_180617_problem','20_Freiburg_070817b_problem',...
    '21_Freiburg_190517', '22_Freiburg_190717','23_Freiburg_210617','wangyanbin','25_lixiangju_yuquan',...
    '26_Bielefeld_030317_problem','27_Bielefeld_08122017_empty','28_Bielefeld_10092017_problem','29_Bielefeld_24112017_problem', '30_Bielefeld_26102017',...
    '31_Freiburg_181017','32_wangcheng_xuanwu','33_Freiburg_070817a','34_Freiburg_081217b','35_dudan_304',...
    '36_wuwenting_304','37_wuwenting2_304','38_chenjiantang_304','39_Freiburg_081217a',};

logFileName = {'sub1','sub2','sub3','sub4','sub5',...
               'sub6','sub7','sub8','sub9','sub10',...
               'sub11','sub12','sub13','sub14','sub15',...
               'sub16','sub17','sub18','sub19','sub20',...
               'sub21','sub22','sub23','sub24','sub25',...
               'sub26','sub27','sub28','sub29','sub30',...
               'sub31','sub32','sub33','sub34','sub35',...
               'sub36','sub37','sub38','sub39'};

s=0:49;f=@(x)2*10^(0.0383*x);F=arrayfun(f,s);
fileName = ['D:\eledata\eleinformation.mat'];
load(fileName);  
fileName = ['D:\eledata\ele_interest_region.mat'];
load(fileName);  
brainregion={'hippocampus','entorhinal','amygdata','middtemporal','superparietal','acc','middleprefrontal','middleofc'};
savepath = ['F:\Goal_ec_epoch\epochdata5std\in4out4\'];
condition={'ingood4','outgood4','inbad4','outbad4'};
behaviorsamplerate=0.01;
sigma=5;
%%  
name=[3 4 7 13 15 17 24 22 33];
for i=1:length(name)
    folderPathName{name(i)}
    fileName = ['D:\dollermaze_navigation_data\' folderPathName{name(i)} '\markertime.mat'];
    load(fileName);
    fileName = ['D:\dollermaze_navigation_data\' folderPathName{name(i)} '\beh_info.mat'];
    load(fileName);
    fileName = ['D:\dollermaze_navigation_data\'  folderPathName{name(i)} '\artifact_matrix.mat'];
    load(fileName);
    [slope,intercept]=calibration_time(marker,behInfo);
  
    [goal] =Extract_in4out4_with_badobjgoodobj(behInfo,slope,intercept,66);
%% 
   ingood4=goal.ingood4;
   outgood4=goal.outgood4;
   inbad4=goal.inbad4;
   outbad4=goal.outbad4;


%% epoch 
%    goodobjmid=goal.goodobjmid;
%    badobjmid=goal.badobjmid;
%    goodobjnear=goal.goodobjnear;
%    badobjnear=goal.badobjnear;
%    goodobjfar=goal.goodobjfar;
%    badobjfar=goal.badobjfar;
% % %    
%    badobj_C= goal.badobj_C;
%    badobj_B=goal.badobj_B;
%    goodobj_C=goal.goodobj_C;
%    goodobj_B=goal.goodobj_B;
%%
    [second_iti] = ITI(behInfo,slope,intercept);
       
    for j=2
        ele=ele_interest_region{j,name(i)};
        if isempty(ele)==0
           for k=1:size(ele,1)
               ele(k,1)
               if j<=3
                  fileName = ['F:\white_thetapower\White_Hilbertthetapower_',num2str(name(i)),'_',num2str(ele(k,1)) '.mat'];                 
               elseif j==4
                  fileName = [ 'K:\temporal_ele\temporalpower_',num2str(name(i)),'_',num2str(ele(k,1)) '.mat'];
               else
                  fileName = [ 'K:\acc_pfc_ofc_ele\pfcpower_',num2str(name(i)),'_',num2str(ele(k,1)) '.mat'];
               end 
               if exist(fileName) && isnan(ele(k,4))==0;
                  load(fileName);
                  power=log10(double(power));
                 % power=double(power);
                  artifact_ele=artifact_matrix{ele(k,1),sigma-2};
                  artifact_ref=artifact_matrix{ele(k,4),sigma-2};

                  second_arti=unique(unique(ceil(unique([artifact_ele artifact_ref])/2000)));   
                  second_arti_iti=unique([1:second_iti(1) second_iti second_arti]);
                  second_clea= find(ismember(1:floor(size(power,2)/2000), second_arti_iti)==0); 
                  index=[(second_clea-1)*2000+1;second_clea*2000];
                  index_of_clea=[];
                  for W=1:size(index,2)
                     index_of_clea=[index_of_clea index(1,W):index(2,W)];
                  end
                 POWER=power(:,index_of_clea);
                 m=nanmean(POWER,2);SD=nanstd(POWER')';
                 clear POWER
                 

                  
             for ii=1:length(condition)    

                 eval(['[' condition{ii} 'epochdata]=add_session_power(' condition{ii} ',power,behaviorsamplerate,second_clea);']);
                 eval([condition{ii} 'epochdata.normal=[m SD];']); 
                 eval(['matrixname=[''' condition{ii} 'epochdata_' num2str(name(i)) '_' num2str(ele(k,1)) '.mat''' '];']);
                 eval(['save([savepath, matrixname],''' condition{ii} 'epochdata''' ');'])
             end
                            
               end
           end
        end
    end     
end