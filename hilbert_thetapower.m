%%
%2020-12-24
%%
clear all;
%%
folderPathName = {'1_lvjutao_yuquan','2_guyitao_304','3_yinjin_301','4_liuzhiming_yuquan','5_heqiang_304',...
    '6_fanjiang_301','7_changdanyuan_yuquan','8_xiezhidong_301','9_zhanghaibin_yuquan','10_gaozhibo_yuquan',...
    '11_zhangqiaofeng_yuquan','12_guobin_yuquan','13_peijian_304','14_dinglanlan_304','15_dongfenlian_yuquan',...
    '16_yuyanan_304','17_duruijiao_yuquan','18_Bielefeld_170417_problem','19_Bielefeld_180617_problem','20_Freiburg_070817b_problem',...
    '21_Freiburg_190517', '22_Freiburg_190717','23_Freiburg_210617','24_wangyanbin_304','25_lixiangju_yuquan',...
    '26_Bielefeld_030317_problem','27_Bielefeld_08122017_empty','28_Bielefeld_10092017_problem','29_Bielefeld_24112017_problem', '30_Bielefeld_26102017',...
    '31_Freiburg_181017','32_wangcheng_xuanwu','33_Freiburg_070817a','34_Freiburg_081217b','35_dudan_304',...
    '36_wuwenting_304','37_wuwenting2_304','38_chenjiantang_304','39_Freiburg_081217a',};
Name = {'yinjin','liuzhiming','heqiang',...
    'fanjiang','changdanyuan','xiezhidong','zhanghaibin','gaozhibo',...
    'zhangqiaofeng','guobin','peijian','dinglanlan','dongfenlian',...
    'yuyanan','duruijiao','18_Bielefeld_170417_problem','19_Bielefeld_180617_problem','20_Freiburg_070817b_problem',...
    '21_Freiburg_190517', '22_Freiburg_190717','23_Freiburg_210617','wangyanbin','25_lixiangju_yuquan',...
    '26_Bielefeld_030317_problem','27_Bielefeld_08122017_empty','28_Bielefeld_10092017_problem','29_Bielefeld_24112017_problem', '30_Bielefeld_26102017',...
    '31_Freiburg_181017','32_wangcheng_xuanwu','33_Freiburg_070817a','34_Freiburg_081217b','35_dudan_304',...
    '36_wuwenting_304','37_wuwenting2_304','38_chenjiantang_304','39_Freiburg_081217a',};

logFileName = {'sub3','sub4','sub5',...
               'sub6','sub7','sub8','sub9','sub10',...
               'sub11','sub12','sub13','sub14','sub15',...
               'sub16','sub17','sub18','sub19','sub20',...
               'sub21','sub22','sub23','sub24','sub25',...
               'sub26','sub27','sub28','sub29','sub30',...
               'sub31','sub32','sub33','sub34','sub35',...
               'sub36','sub37','sub38','sub39'};
wavenumber=6;s=0:49;f=@(x)2*10^(0.0383*x);F=arrayfun(f,s);
fileName = ['D:\eledata\eleinformation.mat'];
load(fileName);  
fileName = ['D:\eledata\ele_interest_region.mat'];
load(fileName);  
%brainregion={'hippocampus','entorhinal','amygdata','middtemporal','superparietal','acc','middleprefrontal','middleofc'};
%%  
% x=1;
% band=[];
% for i=1:29
%     band=[band x];
%     x=1.2*x;
% end
% band1=band(1:end-1);
% band2=band(2:end);
% band=[band1;band2]';
% band3=[1 2;2 4;4 8;8 12;12 30;30 80;80 150;40 50;];
% band=[band;band3];

% band=[];
% for i=4:8
%     band=[band ; i-1 i;];
% end

 band=[4 8];
%band=[4 8;30 90]; %只看theta和gamma频段
%band=band_low;

% band=[band_low;20 22;22 25;25 30;30 35;35 40;40 50;50 60;60 70;70 80;80 90;90 110;110 130;130 150;];

band=roundn(band,-1);
%name=[3 4 10 13 15 17 22 24 33];%海马和内嗅都有的被试
%name=[3 4 7 12 13 15 17];%内嗅-前额叶
%name=[3 4 7 10 12 13 15 16 17 22 24 33];%HP-EC-PFC涉及的被试，全脑平均参考和近白质参考可以一起滤波
%name=[3];
name=[3 4 7 13 15 17 22 24 33 ];%内嗅被试
%name=[3 4 7 10 12 13 14 15 16 17];%PFC被试
for i=1:length(name)
    folderPathName{name(i)}
    if isempty(eleinformation{1,name(i)})==0
      % ele=eleinformation{1,name(i)}.Var1; 
     fileName = ['L:\dollermaze_navigation_data\' folderPathName{name(i)} '\after_gongping_eegdata.mat'];
     load(fileName);
     folderPathName{name(i)}
          %% 不用全脑电极平均，仅用分析脑区的所有电极平均做参考，这里是HP和EC
%            refele=[];
%            %refele=[ele_interest_region{1,name(i)};ele_interest_region{2,name(i)}];%HP和EC
%            %refele=[ele_interest_region{1,name(i)};ele_interest_region{7,name(i)}];% HP和middlePFC
%             refele=[ele_interest_region{2,name(i)};ele_interest_region{7,name(i)}];%EC和PFC
%            refele_ind=refele(:,1);%参考电极
           %%
    % for j=1:2     % 只看region的海马和内嗅 1-HPC 2-EC
     %for j=[1,7]    % 只看HP和middlePFC 1HPC 7middlePFC
     for j=[2]      
      ele=ele_interest_region{j,name(i)};
       for k=1:size(ele,1)
           tic
          ele(k,1)
          filename=[ 'F:\white_thetapower\White_Hilbertthetapower_',num2str(name(i)),'_',num2str(ele(k,1)),'.mat'];
          if exist(filename)~=2
            if isnan(ele(k,4))==0 && ele(k,1)-ele(k,4)~=0 %该电极和参考电极
           % if isnan(ele(k,4))==0  %该电极（全脑参考只看该电极是否存在数据）    
               power=[];
              % phase=[];
               
               %sing=double(eegdata(ele(k,1),:));% 无参考
               sing=double(eegdata(ele(k,1),:)-eegdata(ele(k,4),:)); % 转参考，该电极eeg数据减去参考电极（这里是近白质参考）
               %sing=double(eegdata(ele(k,1),:)-mean(eegdata,1)); % 转参考（这里是全脑平均参考）
               %sing=double(eegdata(ele(k,1),:)-mean(eegdata(refele_ind,:),1)); % 转参考（这里是ROI脑区平均参考）
               
               for l=1:size(band,1)
                   filter_signal=band_pass(sing,2000,band(l,1),band(l,2),1);
                   power(l,:)=abs(hilbert(filter_signal));
                  % power(l,:)=hilbert(filter_signal);
                   %phase(l,:)=unwrap(angle(hilbert(filter_signal)),[],2); %滤波出来的相位
                   %phase(l,:)=angle(hilbert(filter_signal)); 
                   
               end
              
               power=single(power);
               %phase=single(phase);
               
               clear sing;
               %fileName = ['I:\hilbert_ROIref_allband_phase\allever\'];
               fileName = ['F:\white_thetapower\'];
%                matrixname=['HP_midPFC_Hilbertlowbandpower_',num2str(name(i)),'_',num2str(ele(k,1))];
%                save([fileName, matrixname], 'power');
%                clear power;
               matrixname=['White_Hilbertthetapower_',num2str(name(i)),'_',num2str(ele(k,1))];
               save([fileName, matrixname], 'power');
               clear power;
            end
          end
          toc
       end
    end
    end
end
           
   
                       
                 