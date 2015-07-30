function [] = BatchPerceptronForHandwritingRecognition_FULLDATA()

ziptrain = load ('ziptrain.dat');
ziptest = load ('ziptest.dat');


X_train = ziptrain(:, 2:end);
Y_train = ziptrain(:,1);
X_test = ziptest(:,2:end);
Y_test = ziptest(:, 1);




inputValues = X_train';
labels = Y_train;
      
    targetValues = zeros(10, size(inputValues,2));
    for n = 1: size(labels, 1)
        targetValues(labels(n) + 1, n) = 1;
    end;
        
    learningRate = 0.1;
    
    % Choose activation function.
    activate = @logisticSigmoid; %some other function and not
    %sigmoid
    dActivate = @dLogisticSigmoid;
    
    
    %for model selection, we choose the batchsize as the parameter?
    %and see how the validation error rate changes with changes in the
    %batchsize
    batchSize = [400 800 1200 1600 2000];
    epochs = 1000;
    ErrorTable = zeros(1, length(batchSize));
    
    errorScannedDigits=zeros(length(X_test),2);
  
    
  for i = 1:length(batchSize)  
    
    [weights] = trainPerceptron(activate, dActivate,inputValues, targetValues, epochs, batchSize(i), learningRate,labels);
        
    validInputValues = X_test';
    validLabels = Y_test;
    
    fprintf('Validating the Batch Perceptron Algorithm \n');
    
    [correctlyClassified, mistakes, table,errorScannedDigits] = testPerceptron(activate, weights, validInputValues, validLabels, errorScannedDigits);
    
        fprintf('Total Mistakes for Values from 0 to 9\n\n')
        sum(table(2:end,3:end))
        [HardestDigits,num]=sort(errorScannedDigits(:,2),1,'descend');
        [HardestDigits(1:5) num(1:5)]   
    
    errorRate = mistakes / size(validInputValues,2) * 100;
    
    fprintf('Batch Size: %d\n', batchSize(i));
    fprintf('Classification errors: %d\n', mistakes);
    fprintf('Correctly classified: %d\n', correctlyClassified);
    fprintf('Validation Error Rate : %d\n', errorRate);
    
    
    ErrorTable(1,i) = errorRate;
    
    table
    
  end
    
%     
%     fprintf('Testing the Batch Perceptron Algorithm \n');
%     [testCorrectlyClassified, TestMistakes] = testPerceptron(activate, weights, transpose(X_test), Y_test);   
%     TestErrorRate = TestMistakes / size(X_test,1) * 100;   
%     fprintf('Test Classification errors: %d\n', TestMistakes);
%     fprintf('Test Correctly classified: %d\n', testCorrectlyClassified);
%     fprintf('Test Error Rate : %d\n', TestErrorRate);
    
    
figure(1)
plot(batchSize, ErrorTable)
title('Test Error vs Batch Size - Model Selection in Batch One Layer Perceptron')
xlabel('Batch Size')
ylabel('Error Rate');
grid on

    



end
