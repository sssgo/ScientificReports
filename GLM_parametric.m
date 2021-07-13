function [gridlike] = GLM_parametric(epochdata,behevepoch,shufflenum)

%-----------------------------------------
orient_matrix=epochdata.behave;
power=zscore(epochdata.ieeg,[],2);
beta= zeros(size(power,1),5);
phi = zeros(size(power,1),5);
p=  zeros(size(power,1),5);
t=  zeros(size(power,1),5);
GLM1_index=[find(orient_matrix(13,:)==1),find(orient_matrix(13,:)==3),find(orient_matrix(13,:)==5)];
GLM2_index=[find(orient_matrix(13,:)==2),find(orient_matrix(13,:)==4),find(orient_matrix(13,:)==6)];
%a=length(GLM1_index);b=length(GLM2_index);
for freq=1:size(power,1)
    GLM1y=power(freq,GLM1_index)'; 
    GLM2y=power(freq,GLM2_index)';  
    for k=4:8
        % 
        GLM1x=[sind(k*orient_matrix(4,GLM1_index));cosd(k*orient_matrix(4,GLM1_index))]';
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
       %
        GLM2x=cosd(k*(orient_matrix(4,GLM2_index)-orient))';
        [glm] = fitglm(GLM2x,GLM2y);
        warning off all
        beta(freq,k-3)=glm.Coefficients.Estimate(2);
        p(freq,k-3)=glm.Coefficients.pValue(2);
        t(freq,k-3)=glm.Coefficients.tStat(2);
    end
end
%%

nullbeta=zeros(size(power,1),5,shufflenum);
nullp  = zeros(size(power,1),5,shufflenum);
nullt =zeros(size(power,1),5,shufflenum);

epoch=behevepoch(1,GLM2_index);
 epochindex=hist(epoch,unique(epoch));
GLM2power=power(:,GLM2_index);

gridlike.beta=beta;
gridlike.phi=phi;
gridlike.pvalue=p;
gridlike.tvalue=t;

end





 


















