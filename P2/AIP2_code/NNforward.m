function [trnCorrPercent,trnCorr] = NNforward( chromosome,trnInData,trnOutData,trnPatternNum)
%UNTITLED 此处显示有关此函数的摘要

global hiddenuNum
global inputNum
global outputNum

% w -------------------------
%输入的权重和隐藏单位的偏置 weights of inputs and bias to hidden units
w11 = chromosome(1,1:inputNum*hiddenuNum);
w1=reshape(w11,hiddenuNum, inputNum);
%隐藏单元的权重和输出单元的偏置weights of hidden units and bias to output units
w22 = chromosome(1,inputNum*hiddenuNum+1:end);
w2=reshape(w22,outputNum,hiddenuNum+1);

% clear huInput huOutput ouInput ouOutput
% startTime=cputime;

outSubErr=zeros(1,outputNum);  %
tErr = 0;   %
trnCorr = 0; %训练数据的正确率
tstCorr = 0; %测试数据的正确率

for patternCount=1:trnPatternNum %训练每个数据=====================================
    
    %向前-------------forward pass-----------------------------------
    for i=1:hiddenuNum %hidden layer
        huInput(i)=trnInData(patternCount,:)*w1(i,:)';
        huOutput(i)=logsig(huInput(i));
    end
    
    for i=1:outputNum %output layer
        ouInput(i)= w2(i,:)*[1;huOutput'];
        ouOutput(patternCount,i)= logsig(ouInput(i));
    end

    
    %基于平方和误差Based on sum of squared error-----------------------
    for i=1:outputNum
        outSubErr(i)=outSubErr(i)+0.5*(trnOutData(patternCount,i)-ouOutput(patternCount,i))^2;
    end
    

end %all data end ========================================================


%total error for all output during one epoch pass------------------------
for i=1:outputNum
    tErr=tErr+outSubErr(i); %total error for all output during one epoch pass
end
Err = tErr;



%===========================================================================
%计算在训练数据上正确分类的数量Calculate classification accuracy on Trn set---------
for patternCount=1:trnPatternNum  %训练数量
    for i=1:hiddenuNum %hidden layer
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

% %记录个run各
% trnAccuracy =trnCorrPercent;


%         %%%%%%%%%Calculate generalization accuracy on Tst set%%%%%%%%%
%         for patternCount=1:tstPatternNum %训练数量
%             for i=1:hiddenuNum %hidden layer
%                 huInput(i)=tstInData(patternCount,:)*w1(i,:)';
%                 huOutput(i)=logsig(huInput(i));
%             end
%             for i=1:outputNum %output layer
%                 ouInput(i)= w2(i,:)*[1;huOutput'];
%                 ouOutput(patternCount,i)= logsig(ouInput(i));
%             end
%             winningClass=1;
%             for i=2:outputNum
%                 if(ouOutput(patternCount,i)>ouOutput(patternCount,1))&(ouOutput(patternCount,i)>ouOutput(patternCount,winningClass))
%                     winningClass=i;
%                 end
%             end
%             if tstOutData(patternCount,winningClass)== 1
%                 tstCorr=tstCorr+1;
%             end
%         end
%         tstCorrPercent = (tstCorr/tstPatternNum)*100;
%         %%%%%%%%%Calculate generalization accuracy on Tst set%%%%%%%end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tstAccuracy = tstCorrPercent;




end

