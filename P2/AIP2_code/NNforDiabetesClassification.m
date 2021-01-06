%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The code is to be run using MATLAB version 6.5 or other higher versions.
%This program trains the Multi-Layer Perceptrons for the diabetes classification
%problem using gradient descent based backpropagation. The MLPs architecture used
%here consist of a single hidden layer and an output layer,and both layers use the
%sigmoid neurons. There are eight input neurons for the diabetes input feature and
%one input neuron for the bias. There are two output neurons, and the decided class
%of the MLPs uses the winner-take-all strategy, i.e., the output class predicted by the
%network is the corresponding output neuron with the highest value. The number of hidden
%neurons used by the MLPs is varied from one to a maximum number pre-defined by the user.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%使用基于梯度下降的反向传播的问题。
%这里使用的MLPs体系结构由一个隐藏层和一个输出层组成，两层都使用s形神经元。
%糖尿病输入特征有8个输入神经元，偏置有1个输入神经元。
%有两个输出神经元，MLPs的确定类采用赢者通吃的策略，即网络预测的输出类为对应的值最大的输出神经元。
%MLPs使用的隐藏神经元的数量从一个变化到用户预先定义的最大数量。

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The original data file from the UCI repository has been preprocessed to be
%used for this program. All feature values have been normalised.
%The first column of the diabetes data file is the bias input, and the
%second to the ninth columns are the input features. The tenth and eleventh
%columns of the diabetes data file are the output values. A one in the tenth column
%would represent diabetes positive. There are a total of 768 patterns in
%the dataset. 576 are used as training pattern and 192 are used as test
%pattern.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%来自UCI存储库的原始数据文件已经被预处理，以便用于这个程序。
%所有的特征值都被正常化了。
%糖尿病数据文件的第一列为偏置输入，第二到第九列为输入特征。
%糖尿病数据文件的第10和第11列为输出值。
%第十栏的1表示糖尿病阳性。
%数据集中共有768个模式。576作为训练模式，192作为测试模式。

function MLP()

close all
clear all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialisation==================================================================================================
patternNum=768;
trnDataRatio=0.75; %Percentage of the whole dataset used as training dataset
inputNBiasNum=9;  %Number of input units plus one for bias input
outputNum=2;


diabetesData = load('.\diabetes.txt'); %Change the directory to the one on your computer

trnInData=diabetesData(1:ceil(trnDataRatio*patternNum),1:inputNBiasNum); %Training input data
trnOutData=diabetesData(1:ceil(trnDataRatio*patternNum),inputNBiasNum+1:inputNBiasNum+outputNum); %Training output data
tstInData=diabetesData(ceil(trnDataRatio*patternNum+1):patternNum,1:inputNBiasNum); %Test input data
tstOutData=diabetesData(ceil(trnDataRatio*patternNum+1):patternNum,inputNBiasNum+1:inputNBiasNum+outputNum); %Test output data

[trnPatternNum,inputNum]=size(trnInData);
[trnPatternNum,outputNum]=size(trnOutData);
[tstPatternNum,inputNum]=size(tstInData);

maxRun=5; %number of runs
maxHuNum= 2; %maximum number of hidden neurons to be used.
maxEpoch=50;
learningRate = 0.9;

for run=1:maxRun   %最大运行次数
    run
    
     for huNum=1:1:maxHuNum   %隐藏层的神经元数
        
        
        epoch = 1;
        w1=2*rand(huNum,inputNum)-1; %输入的权重和隐藏单位的偏置【8+1】 weights of inputs and bias to hidden units
        w2=2*rand(outputNum,huNum+1)-1; %隐藏单元的权重和输出单元的偏置【10+1】weights of hidden units and bias to output units
        clear huInput huOutput ouInput ouOutput
        startTime=cputime;
        
        while(epoch<=maxEpoch)
            outSubErr=zeros(1,outputNum); 
            tErr = 0; 
            trnCorr = 0; %训练数据的正确率
            tstCorr = 0; %测试数据的正确率
            
            for patternCount=1:trnPatternNum %训练每个数据------------------------------------------------------------------
                
                %向前--------------%%%%%%%%forward pass%%%%%%%%%%%%%%
                for i=1:huNum %hidden layer
                    huInput(i)=trnInData(patternCount,:)*w1(i,:)';
                    huOutput(i)=logsig(huInput(i));
                end
                
                for i=1:outputNum %output layer
                    ouInput(i)= w2(i,:)*[1;huOutput'];
                    ouOutput(patternCount,i)= logsig(ouInput(i));
                end
                
                %向后-------------%%%%%%%%%%%%%backward pass%%%%%%%%%
                for i=1:outputNum
                    outputLocalError(i)=(trnOutData(patternCount,i)-ouOutput(patternCount,i))*ouOutput(patternCount,i)*(1-ouOutput(patternCount,i));
                end
                for i=1:huNum
                    huLocalError(i)=huOutput(i)*(1-huOutput(i))*outputLocalError(1,:)*w2(:,i+1);
                end
                
                %权重更新------------%%%%%%%%weights update%%%%%%%%%%%%%%
                for i=1:outputNum
                    w2(i,:)=w2(i,:)+learningRate*outputLocalError(i)*[1;huOutput']';
                end
                for i=1:huNum
                    w1(i,:)= w1(i,:)+learningRate*huLocalError(i)*trnInData(patternCount,:);
                end
                
                
                %基于平方和误差Based on sum of squared error
                for i=1:outputNum
                    outSubErr(i)=outSubErr(i)+0.5*(trnOutData(patternCount,i)-ouOutput(patternCount,i))^2;
                end
                
            end %of one epoch-------------------------------------------------------------------------------
            
            for i=1:outputNum
                tErr=tErr+outSubErr(i); %total error for all output during one epoch pass
            end
            Err(run,epoch,huNum) = tErr;
            
            
            %%%%%%%%%%%%%===========================================================================
            %计算在训练数据上正确分类的数量---------%%%%%%%%Calculate classification accuracy on Trn set
            for patternCount=1:trnPatternNum  %训练数量
                for i=1:huNum %hidden layer
                    huInput(i)=trnInData(patternCount,:)*w1(i,:)';
                    huOutput(i)=logsig(huInput(i));
                end
                for i=1:outputNum %output layer
                    ouInput(i)= w2(i,:)*[1;huOutput'];
                    ouOutput(patternCount,i)= logsig(ouInput(i));
                end
                winningClassTrn=1;
                for i=2:outputNum
                    if(ouOutput(patternCount,i)>ouOutput(patternCount,1))&(ouOutput(patternCount,i)>ouOutput(patternCount,winningClassTrn))
                        winningClassTrn=i;
                    end
                end
                if trnOutData(patternCount,winningClassTrn)== 1
                    trnCorr=trnCorr+1;
                end
            end
            %正确率---------------
            trnCorrPercent = (trnCorr/trnPatternNum)*100;    %训练数据上得到的正确率********
            
            %记录个run各
            trnAccuracy(run,epoch,huNum)=trnCorrPercent;
            
            
            epoch = epoch+1;
        end  %maxEpoch-------------------------------------------------------------------------------
        
        endTime=cputime;
        time(run,huNum)=(endTime-startTime);
        endTime=0;
        startTime=0;
        
        %%%%%%%%%Calculate generalization accuracy on Tst set%%%%%%%%%%
        for patternCount=1:tstPatternNum %测试数量
            for i=1:huNum %hidden layer
                huInput(i)=tstInData(patternCount,:)*w1(i,:)';
                huOutput(i)=logsig(huInput(i));
            end
            for i=1:outputNum %output layer
                ouInput(i)= w2(i,:)*[1;huOutput'];
                ouOutput(patternCount,i)= logsig(ouInput(i));
            end
            winningClass=1;
            for i=2:outputNum
                if(ouOutput(patternCount,i)>ouOutput(patternCount,1))&(ouOutput(patternCount,i)>ouOutput(patternCount,winningClass))
                    winningClass=i;
                end
            end
            if tstOutData(patternCount,winningClass)== 1
                tstCorr=tstCorr+1;
            end
        end
        tstCorrPercent = (tstCorr/tstPatternNum)*100;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        tstAccuracy(run,huNum)=tstCorrPercent;
        
    end %maxHuNum
end %maxRun
save Results











%plot
%sum==================================================================================================
%%%%%%%%Plot Sum of Squared Error%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for epoch=1:maxEpoch
    for huNum=1:maxHuNum
        avgErr(epoch,huNum)=mean(Err(:,epoch,huNum));
    end
end
figure (1);
surf(avgErr);
colormap(winter);
xlabel(['Number of hidden units']);
ylabel('Number of epochs');
zlabel('Sum of Squared Error');


%%%%%%%%Plot Training Accuracy%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for epoch=1:maxEpoch
    for huNum=1:maxHuNum
        avgTrnAcc(epoch,huNum)=mean( trnAccuracy(:,epoch,huNum));
    end
end
figure (2);
surf(avgTrnAcc);
colormap(winter);
xlabel(['Number of hidden units']);
ylabel('Number of epochs');
zlabel('Accuracy on training set (%)');

%%%%%%%%Plot Test Accuracy%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for huNum=1:maxHuNum
    avgTstAcc(huNum)=mean(tstAccuracy(:,huNum));
    maxTstAcc(huNum)=max(tstAccuracy(:,huNum));
    minTstAcc(huNum)=min(tstAccuracy(:,huNum));
end
figure (3),
plot([1:1:maxHuNum],maxTstAcc,'ro-',[1:1:maxHuNum],avgTstAcc,'b^-',[1:1:maxHuNum],minTstAcc,'g+-'),
xlabel('Number of hidden units');
ylabel('Classification Accuracy (%)');
legend('Max Accuracy','Mean Accuracy','Min Accuracy');


%%%%%%%%Plot Time graph %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for huNum=1:maxHuNum
    avgTime(huNum)=mean(time(:,huNum));
    maxTime(huNum)=max(time(:,huNum));
    minTime(huNum)=min(time(:,huNum));
end
figure (4),
plot([1:1:maxHuNum],maxTime,'ro-',[1:1:maxHuNum],avgTime,'b^-',[1:1:maxHuNum],minTime,'g+-'),
xlabel('Number of hidden units');
ylabel('Time in seconds');
legend('Max Time','Mean Time','Min Time');

end
