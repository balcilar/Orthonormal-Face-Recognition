%% written by Muhammet Balcilar

clear all
clc

% define lamnda value which shows regularization coef.

lambda=2000000;

% read dataset divide %50 of them train and test set
[Train LabelTrain Test LabelTest]=read_split_dataset('data/CroppedYale/');


XUT=inv(Train'*Train+lambda*eye(size(Train,2)))*Train'*Test;    


for i=1:size(Test,2)
    
    y=Test(:,i);    
    x_est=XUT(:,i);
    [lhat,ssdist2]=checkperson(Train,x_est,y,LabelTrain);    
    Predict(i,1)=lhat;
    S(i,:)=ssdist2;
       
    fprintf('%g Recognition rate : %f \n' ,i,mean(Predict(1:i)==LabelTest(1:i)) )
end

for i=1:size(Test,2)
    tmp=S(i,:);
    pscore=tmp(LabelTest(i));
    tmp(LabelTest(i))=inf;
    nscore=min(tmp);
    Score(i,:)=[pscore nscore];
end

plot(Score(:,2)-Score(:,1))
hold on;plot([1 size(Test,2)],[0 0],'r','linewidth',3)
xlabel('Test instance number');
ylabel('difference of scores');
legend({'difference between original class and most similar class score','decision border'})
title('Score differences between ground truth class and most similar class according to algorithm')


%% multi class roc curve
label=1:size(S,2);
for i=1:size(S,2)
    I=LabelTest==i;
    SS(:,1)=S(:,i);
    
    SS(:,2)=min(S(:,(label~=i))')';
    
    tt=zeros(size(S,1),2);
    tt(I)=1;    
        
    [tpr,fpr,thresholds] = roc(tt',-SS');
    
    TPR(i,:)=tpr{1};
    FPR(i,:)=fpr{1};
end
    
figure;hold on;
for i=1:size(S,2)
    plot(FPR(i,:),TPR(i,:))
end
title('Multi Class Roc Curve');
xlabel('False Positive');
ylabel('True Positive');

%% confusion matrix
TT=zeros(size(S));
HH=zeros(size(S));

for i=1:size(S,1)
    
    TT(i,LabelTest(i))=1;
    HH(i,Predict(i))=1;
end

[c,cm,ind,per] = confusion(TT',HH');
figure;imagesc(cm);
title('Confusion Matrix');
xlabel('Actual Class');
ylabel('Prediction');
