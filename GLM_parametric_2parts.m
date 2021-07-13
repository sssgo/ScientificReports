function [gridlike] = GLM_parametric_2parts(epochdata1,epochdata2)
%-----------------------------------------
% GLM_parametric_2parts(epochdata1,epochdata2,behevepoch1,behevepoch2,shufflenum)

% wwj 2019 5
%���룺
%fastepochdata:���и���Ƭ��
%   fastepochdata.behave %����
%   ʱ�̵� �Ƕ� session���� ������� �׶�(2����drop 4����grab)��������trial number����trial number��droperror
%   fastepochdata.ieeg=power_speed;%����50��Ƶ�ε�power  
%50�� F [2,2.2,2.4,2.6,2.8,3.1,3.4,3.7,4,4.4,4.8,5.3,5.8,6.3,6.9,7.5,8.2,9,9.8,10.7,/////,137.8,150.5]
%�������� 4 5 6 7 8  
%shufflenum��������1000��)
%shuffleҪ����ԭ����ʱ��ṹ������cfc��Ҫ����ԭ���ķֲ����в��ı䣬����һ�㲻�ܴ����shuffle
%ͬʱ��6���ڵ�ָ�����������phi��һ���ԣ��������ǲ���ȫ������shuffle��ֻ�޸�ѵ�������ɡ�
%�����
%beta= zeros(50,5);
%p=zeros(50,5)
%phi = zeros(50,5);
%nullbeta=zeros(50,5,shufflenum);
%nullp=zeros(50,5,shufflenum);
%-----------------------------------------
orient_matrix1=epochdata1.behave;
orient_matrix2=epochdata2.behave;
% ff=fastepochdata.ieeg;
% fastepochdata.ieeg=10.^ff;
power1=zscore(epochdata1.ieeg,[],2);
power2=zscore(epochdata2.ieeg,[],2);
beta= zeros(size(power1,1),5);
phi = zeros(size(power1,1),5);
p=  zeros(size(power1,1),5);
t=  zeros(size(power1,1),5);
% GLM1_index=[find(orient_matrix(13,:)==1),find(orient_matrix(13,:)==3),find(orient_matrix(13,:)==5)];
% GLM2_index=[find(orient_matrix(13,:)==2),find(orient_matrix(13,:)==4),find(orient_matrix(13,:)==6)];
%a=length(GLM1_index);b=length(GLM2_index);
for freq=1:size(power1,1)
    GLM1y=power1(freq,:)'; 
    GLM2y=power2(freq,:)';  
    for k=4:8
        % ���faiƫ��(ǰ�벿������ѵ����6���ڣ�
        GLM1x=[sind(k*orient_matrix1(4,:));cosd(k*orient_matrix1(4,:))]';
        [glm] = fitglm(GLM1x,GLM1y);
        warning off all
        beta2=glm.Coefficients.Estimate(2); beta1=glm.Coefficients.Estimate(3);
        orient=atan2d(beta2,beta1);
        if orient<0
            orient=orient+360;
        end
        if orient==360
            orient=0;
        end
        orient=orient/k;
        phi(freq,k-3)=orient;
       %ƫ�Ǵ���GLM2��beta      
        GLM2x=cosd(k*(orient_matrix2(4,:)-orient))';
        [glm] = fitglm(GLM2x,GLM2y);
        warning off all
        beta(freq,k-3)=glm.Coefficients.Estimate(2);
        p(freq,k-3)=glm.Coefficients.pValue(2);
        t(freq,k-3)=glm.Coefficients.tStat(2);
    end
end
%%

gridlike.beta=beta;
gridlike.phi=phi;
gridlike.pvalue=p;
gridlike.tvalue=t;
% gridlike.nullbeta=nullbeta;
% gridlike.nullpvalue=nullp;
% gridlike.nulltvalue=nullt;
end





 


















