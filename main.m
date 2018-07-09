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
       
    fprintf('%g Recognition rate : %f \n' ,i,mean(Predict(1:i)==LabelTest(1:i)) )
end



