function [tableErrors] = PerceptronForHandwritingRecognition_HOLDOUT_GaussianKernel()

%function for hold out method using the Gaussian kernel


clear all

train = load('ziptrain.dat');
test = load('ziptest.dat');

digits = 10;
 
k_hold_out = round(length(train) * 2/3) ; 
train_holdOut = train(1:k_hold_out, :);
valid_holdOut = train(k_hold_out+1:end, :);


%c parameters that needs to be optimized
c = [1 1/10 1/100 1/1000];
degree = c;


fprintf('Using the HOLD OUT method for Model Selection \n ')

fprintf('Training set of size : %d\n', length(train_holdOut));
fprintf('Validation set of size : %d\n', length(valid_holdOut));

weight = zeros(digits, length(train_holdOut));
tableTestErrors = zeros(1,length(degree));

errorScannedDigits=zeros(length(test),2);


for k = 1:length(c)
    
i = degree(k);
     
Degree_GaussianKernel = i
epoch = 3;
testPercent = zeros(epoch,1);

% using 3 epochs for the Gaussian Perceptron
%since computation takes a lot of time for 5 epochs

for n = 1:epoch
    t=cputime;
    %training the perceptron for gaussian kernel
    [mistakes, weight] = kernel_perceptron_training(train_holdOut, i, weight); 
    trainT=cputime-t;
    fprintf('Classification errors during training: %d\n', mistakes);
    fprintf('Training - Epoch %i required %d with %i mistakes out of %i items\n', [n trainT mistakes length(train_holdOut)])
   
    testPercent = zeros(n,1);
    t=cputime;
    %testing of the kernel perceptron
    [test_mistakes, table,errorScannedDigits] = kernel_perceptron_test(train_holdOut, valid_holdOut, i, weight, errorScannedDigits);
    testT=cputime-t;
    fprintf('Classification errors during testing: %d\n', test_mistakes);
    testPercent(n)=test_mistakes/length(valid_holdOut)*100;
    fprintf('Testing - Epoch %i required %i with a test error of %.2f%% \n\n', [n testT testPercent(n) ])
    
    
    if (n==epoch)
            fprintf('Total Mistakes for Values from 0 to 9\n\n')
            sum(table(2:end,3:end))
            [HardestDigits,num]=sort(errorScannedDigits(:,2),1,'descend');
            [HardestDigits(1:5) num(1:5)]
    end
        
end    
   fprintf('For Degree : %d\n', degree);
   fprintf('Test Error on the 5th Epoch: %d\n', testPercent(end,:)); 
   tableTestErrors(1, k) = testPercent(end,:);
    
    table
    
  
    
    
 end

 
 fprintf('Plotted - Variation of Test Errors with Degree of Polynomial Kernel')
 
 figure(1)
 plot(degree, tableTestErrors)
 title('Average Test Error for 5 Epochs vs Degree of Gaussian Kernel')
 xlabel('Degree of Polynomial')
 ylabel('Test Error (%)')
 grid on
 
    
fprintf('Easiest and Hardest Digits to Recognize')
table

tableErrors = tableTestErrors

ModelSelectionDegree = find(tableErrors == min(tableErrors))
 
end