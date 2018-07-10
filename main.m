clear all
clc

% define lamnda value which shows regularization coef.

lambda=100;

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


