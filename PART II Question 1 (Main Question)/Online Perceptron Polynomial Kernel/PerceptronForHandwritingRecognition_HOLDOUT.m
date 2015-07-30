function [tableErrors] = PerceptronForHandwritingRecognition_HOLDOUT()

%this function is for performing hold out method to choose degree of the
%polynomial kernel
clear all

train = load('ziptrain.dat');
test = load('ziptest.dat');

digits = 10;
 
k_hold_out = round(length(train) * 2/3) ; 
train_holdOut = train(1:k_hold_out, :);
valid_holdOut = train(k_hold_out+1:end, :);
 

fprintf('Using the HOLD OUT method for Model Selection \n ')

fprintf('Training set of size : %d\n', length(train_holdOut));
fprintf('Validation set of size : %d\n', length(valid_holdOut));

weight = zeros(digits, length(train_holdOut));
tableTestErrors = zeros(1,7);
 
 for degree = 1:7
 

%computing the kernel with the training and validation sets
kernel_train = kerneld(train_holdOut(:, 2:end), train_holdOut(:, 2:end), degree);
kernel_test=kerneld(valid_holdOut(:,2:end),train_holdOut(:,2:end), degree);

degree
epoch = 5;
testPercent = zeros(epoch,1);
errorScannedDigits=zeros(length(test),2);

%n for the number of epochs - repeat the number of epochs to
%update/increase the confidence (weights) on the digits
for n=1:epoch
    t=cputime;
    [mistakes, weight] = kernel_perceptron_training(train_holdOut, weight, kernel_train); 
    trainT=cputime-t;
    fprintf('Classification errors during training: %d\n', mistakes)  
    fprintf('Training - Epoch %i required %d time\n', [n trainT])
    fprintf('Training -  %i mistakes out of %i times \n', [mistakes length(train_holdOut)])
    
     
   
    t=cputime;
    [test_mistakes, table, errorScannedDigits] = kernel_perceptron_test(valid_holdOut,weight, kernel_test, errorScannedDigits);
    %[test_mistakes, tmpDigitsError]=testclassifiers(train_holdOut,valid_holdOut, weight, digits, kernel_test);
    testT=cputime-t;
    fprintf('Classification errors during testing: %d\n', test_mistakes);
    testPercent(n)=test_mistakes/length(valid_holdOut)*100;
    
    fprintf('Testing - Epoch %i required %d time\n', [n testT])
    fprintf('Testing with a test error of %.2f%% \n\n', testPercent(n))
       
end

  
    fprintf('For Degree : %d\n', degree);
    fprintf('Test Error on the 5th Epoch: %d\n', testPercent(end,:)); 
    tableTestErrors(1, degree) = testPercent(end,:);
    
    table

 end
 
 fprintf('Plotted - Variation of Test Errors with Degree of Polynomial Kernel')
 
 figure(1)
 plot([1:7], tableTestErrors)
 title('Average Test Error for 5 Epochs vs Degree of Polynomial Kernel')
 xlabel('Degree of Polynomial')
 ylabel('Test Error (%)')
 grid on
 
    
fprintf('Easiest and Hardest Digits to Recognize')
table

tableErrors = tableTestErrors

ModelSelectionDegree = find(tableErrors == min(tableErrors))    


end