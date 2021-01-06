function [trnCorrPercent,trnCorr] = NNforward( chromosome,trnInData,trnOutData,trnPatternNum)
%UNTITLED �˴���ʾ�йش˺�����ժҪ

global hiddenuNum
global inputNum
global outputNum

% w -------------------------
%�����Ȩ�غ����ص�λ��ƫ�� weights of inputs and bias to hidden units
w11 = chromosome(1,1:inputNum*hiddenuNum);
w1=reshape(w11,hiddenuNum, inputNum);
%���ص�Ԫ��Ȩ�غ������Ԫ��ƫ��weights of hidden units and bias to output units
w22 = chromosome(1,inputNum*hiddenuNum+1:end);
w2=reshape(w22,outputNum,hiddenuNum+1);

% clear huInput huOutput ouInput ouOutput
% startTime=cputime;

outSubErr=zeros(1,outputNum);  %
tErr = 0;   %
trnCorr = 0; %ѵ�����ݵ���ȷ��
tstCorr = 0; %�������ݵ���ȷ��

for patternCount=1:trnPatternNum %ѵ��ÿ������=====================================
    
    %��ǰ-------------forward pass-----------------------------------
    for i=1:hiddenuNum %hidden layer
        huInput(i)=trnInData(patternCount,:)*w1(i,:)';
        huOutput(i)=logsig(huInput(i));
    end
    
    for i=1:outputNum %output layer
        ouInput(i)= w2(i,:)*[1;huOutput'];
        ouOutput(patternCount,i)= logsig(ouInput(i));
    end

    
    %����ƽ�������Based on sum of squared error-----------------------
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
%������ѵ����������ȷ���������Calculate classification accuracy on Trn set---------
for patternCount=1:trnPatternNum  %ѵ������
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
%��ȷ��---------------
trnCorrPercent = (trnCorr/trnPatternNum)*100;    %ѵ�������ϵõ�����ȷ��********

% %��¼��run��
% trnAccuracy =trnCorrPercent;


%         %%%%%%%%%Calculate generalization accuracy on Tst set%%%%%%%%%
%         for patternCount=1:tstPatternNum %ѵ������
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

