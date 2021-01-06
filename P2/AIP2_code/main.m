% Empty environment variables
clc
clear
% 

t0 = clock; %The clock that calls the Windows system does the time difference calculation

global hiddenuNum
global inputNum
global outputNum

%Initialisation NN ==========================================================
diabetesData = load('.\diabetes.txt'); %Change the directory to the one on your computer

%Number of nodes per layer
inputNum=9;         %8 Number of input units + 1 one for bias input
hiddenuNum = 4;     %the number of units in hidden layer 
outputNum=2;        %the number of units in output layer 

%Training/Testing
dataNum=768; %Total data
trnDataRatio=0.75; %The ratio of data training
inputTrain=diabetesData(1:ceil(trnDataRatio*dataNum),1:inputNum); %Training input data
outputTrain=diabetesData(1:ceil(trnDataRatio*dataNum),inputNum+1:inputNum+outputNum); %Training output data
inputTest=diabetesData(ceil(trnDataRatio*dataNum+1):dataNum,1:inputNum); %Test input data
outputTest=diabetesData(ceil(trnDataRatio*dataNum+1):dataNum,inputNum+1:inputNum+outputNum); %Test output data

[trainNum,outputNum]=size(outputTrain);  %trainNum Training data quantity
[testNum,inputNum]=size(inputTest);      %testNum Test data quantity

% inputTrain = mapminmax(inputTrain);
% inputTest = mapminmax(inputTest);

%Initialisation GA ==========================================================

generation = 100;     %Generations/iterations/epoch
chromosomeNum = 10;   %Initial population size

geneNum = inputNum*hiddenuNum + hiddenuNum*outputNum + outputNum; %The total number of w

fitnessStatis = zeros(generation,chromosomeNum); %Record fitness changes for each round
fitnessBest = zeros(1,generation);
fitnessAve = zeros(1,generation);
fitnessMin = zeros(1,generation);
w_evolution = zeros(generation,geneNum+1);  %(best chromosome + bestfitness)

pc = 0.7;      %Crossover probability
pm = 0.1;      %Mutation probability
GAP = 0.9;     %Generation gap (i.e., selection probability)


% Initialization of the population---------------------------------
Chrom = InitialChrom (chromosomeNum,geneNum);
fitness = zeros(1,chromosomeNum);  %≥ı ºªØ

iter = 0;

% GA ====================================================================
while iter < generation
    iter
    
    %Calculated fitness-------------------------------
    for c = 1: chromosomeNum
        [trnCorrPercent,trnCorrnum] = NNforward( Chrom(c,:),inputTrain,outputTrain,trainNum);
        %[Correct rate of training data, correct number of training data]
        fitness(c) = trnCorrnum/trainNum;
    end
    
    %Record w Settings for maximum Fitness + average + iteration per round-------------------------------
    [fitness_best,best_index] = max(fitness);
    fitnessBest(iter+1) = fitness_best;     %Maximum fitness for each iteration
    fitnessAve(iter+1) = mean(fitness);     %Average fitness for each iteration
    fitnessMin(iter+1) = min(fitness);      %Min
    w_evolution(iter+1,:) = [Chrom(best_index,:) Chrom(best_index,1)];  %record optimal
    fitnessStatis(iter+1,:)= fitness;  %Record all fitness values for this time
    
    %==========================================
    
    % select-------------------------------
    select_num = max(floor(chromosomeNum*GAP+0.6),2);   %The number of chromosomes selected

    Chrom1 = Select(Chrom, fitness,select_num);

    % crossover-------------------------------
    Chrom2 = Crossocer( Chrom1, pc, fitness );
   
    % mutation-------------------------------
    Chrom3 = Mutation( Chrom2, pm ); 
    
    %Reverse evolution--------------------------
    Chrom4 = Reverse( Chrom3 , inputTrain , outputTrain ,trainNum);
    
    % rein-------------------------------
    Chrom = Rein( Chrom4, Chrom, fitness ); 
   
    
    iter = iter+1;


    
end


% test data ==tstCorrPercent,tstCorr================================

% [trnCorrPercent,trnCorrnum,tstCorrPercent,tstCorrnum ]...
% = TestForward(w_evolution(end,1:geneNum), inputTrain, outputTrain,trainNum, inputTest,outputTest,testNum);

% test data ==tstCorrPercent,tstCorr================================
[trnCorrPercent1,trnCorrnum1,tstCorrPercent1,tstCorrnum1 ]...
= TestWith(w_evolution(end,1:geneNum), inputTrain, outputTrain,trainNum, inputTest,outputTest,testNum);




%output==============================================================================
%parameters setting

disp(['The generation is:' num2str(generation)]);

% time 
Time_Cost=etime(clock,t0);   %The clock that calls the Windows system does the time difference calculation
disp(['program execution time:' num2str(Time_Cost) 'seconds']);

% % best fitness 
% disp(['The best fitness in the last generation of training data:' num2str(trnCorrPercent)]);
% disp(['The best fitness in the last generation of testing data:' num2str(tstCorrPercent)]);

disp(['Accuracy on training data set:' num2str(trnCorrPercent1)]);
disp(['Accuracy on testing data set:' num2str(tstCorrPercent1)]);

% figure ====================================================

% for g=1:generation
%     avgTstAcc(g)=mean(tstAccuracy(:,g));
%     maxTstAcc(g)=max(tstAccuracy(:,g));
%     minTstAcc(g)=min(tstAccuracy(:,g));
% end
% figure (1)
% plot([1:1:9],fitnessBest,'ro-',[1:1:9],fitnessAve,'b^-',[1:1:9],fitnessMin,'g+-'),
% xlabel('Number of hidden unit');
% ylabel('Classification Accuracy (%)');
% legend('Max Accuracy','Mean Accuracy','Min Accuracy');



