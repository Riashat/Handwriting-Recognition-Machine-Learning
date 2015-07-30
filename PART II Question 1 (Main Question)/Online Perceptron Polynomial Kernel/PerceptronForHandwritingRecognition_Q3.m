function [tableErrors] = PerceptronForHandwritingRecognition_Q3()

%Function for the entire training and test data

% using the other main class, we performed hold out for model selection to
% choose degree of polynomial kernel

clear all

train = load('ziptrain.dat');
test = load('ziptest.dat');
digits = 10;
 
fprintf('Kernel Perceptron on ALL DATA \n');
fprintf('Training set of size : %d\n', length(train));
fprintf('Validation set of size : %d\n', length(test));

weight = zeros(digits, length(train));
tableTestErrors = zeros(1,7);

 
 for degree = 1:7
 

%computing the kernel with the training and validation sets
%kerneld is the function to compute the polynomial kernel
kernel_train = kerneld(train(:, 2:end), train(:, 2:end), degree);
kernel_test=kerneld(test(:,2:end),train(:,2:end), degree);

degree
epoch = 5;
testPercent = zeros(epoch,1);
 
errorScannedDigits=zeros(length(test),2);

%n for the number of epochs
for n=1:epoch
    
    %training of online perceptron
    t=cputime;
    [mistakes, weight] = kernel_perceptron_training(train, weight, kernel_train); 
    trainT=cputime-t;
    fprintf('Classification errors during training: %d\n', mistakes)  
    fprintf('Training - Epoch %i required %d time\n', [n trainT])
    fprintf('Training -  %i mistakes out of %i times \n', [mistakes length(train)])
    
        
    %testing of online perceptron using the weights from training
    t=cputime;
    [test_mistakes, table,errorScannedDigits ] = kernel_perceptron_test(test,weight, kernel_test, errorScannedDigits);
    testT=cputime-t;
    fprintf('Classification errors during testing: %d\n', test_mistakes);
    testPercent(n)=test_mistakes/length(test)*100;
    
    fprintf('Testing - Epoch %i required %d time\n', [n testT])
    fprintf('Testing with a test error of %.2f%% \n\n', testPercent(n))
    
    
    if (n==epoch)
            fprintf('Total Mistakes for Values from 0 to 9\n\n')
            sum(table(2:end,3:end))
            [HardestDigits,num]=sort(errorScannedDigits(:,2),1,'descend');
            [HardestDigits(1:5) num(1:5)]
    end
        
       
end

    fprintf('For Degree : %d\n', degree);
    fprintf('Test Error on the 5th Epoch: %d\n', testPercent(end,:)); 
    
    %test Errors for each degree of polynomial kernel
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