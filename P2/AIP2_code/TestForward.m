function [trnCorrPercent,trnCorr,tstCorrPercent,tstCorr ]...
    = TestForward(chromosome,trnInData,trnOutData,trnPatternNum, tstInData,tstOutData,tstPatternNum)

global hiddenuNum
global inputNum
global outputNum

% w -------------------------
% weights of inputs and bias to hidden units
w11 = chromosome(1,1:inputNum*hiddenuNum);
w1=reshape(w11,hiddenuNum, inputNum);
% weights of hidden units and bias to output units
w22 = chromosome(1,inputNum*hiddenuNum+1:end);
w2=reshape(w22,outputNum,hiddenuNum+1);

% clear huInput huOutput ouInput ouOutput
% startTime=cputime;

outSubErr=zeros(1,outputNum);   
tErr = 0;  
trnCorr = 0; %Accuracy rate of training data
tstCorr = 0; %Accuracy rate of test data

for patternCount=1:trnPatternNum %Training each data=====================================
    
    %forward pass------------------------------------------------
    for i=1:hiddenuNum %hidden layer
        huInput(i)=trnInData(patternCount,:)*w1(i,:)';
        huOutput(i)=logsig(huInput(i));
    end
    
    for i=1:outputNum %output layer
        ouInput(i)= w2(i,:)*[1;huOutput'];
        ouOutput(patternCount,i)= logsig(ouInput(i));
    end
    
    
    % Based on sum of squared error-----------------------
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
% Calculate classification accuracy on Trn set---------
for patternCount=1:trnPatternNum   
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

trnCorrPercent = (trnCorr/trnPatternNum)*100;   %Accuracy rate obtained from training data 


%===========================================================================
% Calculate generalization accuracy on Tst set---------
for patternCount=1:tstPatternNum  
    for i=1:hiddenuNum %hidden layer
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


end

