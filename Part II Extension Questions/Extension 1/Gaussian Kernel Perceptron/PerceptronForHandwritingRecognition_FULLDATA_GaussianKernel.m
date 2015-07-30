function [tableErrors] = PerceptronForHandwritingRecognition_FULLDATA_GaussianKernel()

clear all


train = load('ziptrain.dat');
test = load('ziptest.dat');

digits = 10;
 
c = [1 1/10 1/100 1/1000];
degree = c;


fprintf('Using Full Data for Gaussian Kernel Perceptron Algorithm \n ')


fprintf('Training set of size : %d\n', length(train));
fprintf('Validation set of size : %d\n', length(test));

weight = zeros(digits, length(train));
tableTestErrors = zeros(1,length(degree));




for k = 1:length(c)
    
i = degree(k);

Degree_GaussianKernel = i
epoch = 3;
testPercent = zeros(epoch,1);

%only one epoch for the Gaussian Perceptron

errorScannedDigits=zeros(length(test),2);

for n = 1:epoch
    t=cputime;
    [mistakes, weight] = kernel_perceptron_training(train, i, weight); 
    trainT=cputime-t;
    fprintf('Classification errors during training: %d\n', mistakes);
    fprintf('Training - Epoch %i required %d with %i mistakes out of %i items\n', [n trainT mistakes length(train)])
   
    testPercent = zeros(n,1);
    t=cputime;
    [test_mistakes, table,errorScannedDigits] = kernel_perceptron_test(train, test, i, weight, errorScannedDigits);
    testT=cputime-t;
    fprintf('Classification errors during testing: %d\n', test_mistakes);
    testPercent(n)=test_mistakes/length(test)*100;
    fprintf('Testing - Epoch %i required %i with a test error of %.2f%% \n\n', [n testT testPercent(n) ])
    
        
    if (n==epoch)
            fprintf('Total Mistakes for Values from 0 to 9\n\n')
            sum(table(2:end,3:end))
            [HardestDigits,num]=sort(errorScannedDigits(:,2),1,'descend');
            [HardestDigits(1:5) num(1:5)]
    end
        
    
    table

end    
    fprintf('For Degree : %d\n', degree);
    fprintf('Test Error on the 5th Epoch: %d\n', testPercent(end,:)); 
    tableTestErrors(1, k) = testPercent(end,:);
    
    table
    
    
    
 end

 
 fprintf('Plotted - Variation of Test Errors with Degree of Polynomial Kernel')
 
 figure(1)
 plot(log10(degree), tableTestErrors)
 title('Average Test Error for 5 Epochs vs Degree of Polynomial Kernel')
 xlabel('Degree of Polynomial')
 ylabel('Test Error (%)')
 grid on
 
    
fprintf('Easiest and Hardest Digits to Recognize')
table

tableErrors = tableTestErrors

ModelSelectionDegree = find(tableErrors == min(tableErrors))
 
end