function [] = NeuralNetwork_FULLDATA()

load ('ziptrain.dat')
load ('ziptest.dat')

X_train = ziptrain(:, 2:end);
Y_train = ziptrain(:,1);
X_test = ziptest(:,2:end);
Y_test = ziptest(:, 1);


inputValues = X_train';
labels = Y_train;


%targetValues - 0s and 1s - transforming labels to the correct target
%values
    targetValues = zeros(10, size(inputValues,2));
    for n = 1: size(labels, 1)
        targetValues(labels(n) + 1, n) = 1;
    end;
    
    
    
%model selection in neural networks entails structure of the network - ie, the number 
%of hidden nodes. 
%size of the network - more hidden units will give a better fit
hiddenUnits = [ 500 700 900 1100 1300 1500];
ErrorTable = zeros(1, length(hiddenUnits));


errorScannedDigits=zeros(length(X_test),2);

for i = 1:length(hiddenUnits) 
 
 learningRate = 0.1;
 
 %activation and deactivation functions
  activationFunction = @logisticSigmoid;
  dActivationFunction = @dLogisticSigmoid;
  
    batchSize = 100;
    epochs = 500;
        
    fprintf('Train twolayer perceptron with %d hidden units.\n', hiddenUnits(i));
    fprintf('Learning rate: %d.\n', learningRate);
      
    %training the neural network for updated hidden and output weights
    [hiddenWeights, outputWeights, error] = train_NeuralNetwork (activationFunction, dActivationFunction, hiddenUnits(i), inputValues, targetValues, epochs, batchSize, learningRate);
       
    validInputValues = X_test';
    validLabels = Y_test;
       
    %test neural network with learned weights
    % returns the number of classified and misclassified digits
    %also a table containing the errors for each digit
    [correctlyClassified, classificationErrors, table,errorScannedDigits] = testNeuralNetwork(activationFunction, hiddenWeights, outputWeights, validInputValues, validLabels,errorScannedDigits );
     
        fprintf('Total Mistakes for Values from 0 to 9\n\n')
        sum(table(2:end,3:end))
        [HardestDigits,num]=sort(errorScannedDigits(:,2),1,'descend');
        [HardestDigits(1:5) num(1:5)]
    
     m = size(validInputValues,2);
     
     errorRate = classificationErrors/m * 100;
     
    fprintf('Classification errors: %d\n', classificationErrors);
    fprintf('Correctly classified: %d\n', correctlyClassified);
    fprintf('Two Layer Perceptron Validation Error Rate: %d\n', errorRate);
    
    ErrorTable(1,i) = errorRate;  
    
    table
end

figure(1)
plot(hiddenUnits, ErrorTable)
title('Test Error vs Number of Hidden Units - Model Selection in Neural Network')
xlabel('Number of Hidden Units')
ylabel('Error Rate');
grid on

      
end