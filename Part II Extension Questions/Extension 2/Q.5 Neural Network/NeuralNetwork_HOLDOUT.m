function [] = NeuralNetwork_HOLDOUT()

load ziptrain.dat
k = round(length(ziptrain) * 2/3);

X_train = ziptrain(1:k, 2:end);
Y_train = ziptrain(1:k,1);
X_validation = ziptrain(4862:7291,2:end);
Y_validation = ziptrain(4862:7291, 1);

% load('ziptest.mat')
% ziptest = ziptest;
% X_test = ziptest(:,2:257);
% Y_test = ziptest(:,1);

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


for i = 1:length(hiddenUnits) 
 
 learningRate = 0.1;
 
 %activation and deactivation functions
  activationFunction = @logisticSigmoid;
  dActivationFunction = @dLogisticSigmoid;
  
    batchSize = 100;
    epochs = 500;
        
    fprintf('Train twolayer perceptron with %d hidden units.\n', hiddenUnits(i));
    fprintf('Learning rate: %d.\n', learningRate);
    
   
    %training the neural network to learn the weights
    [hiddenWeights, outputWeights, error] = train_NeuralNetwork (activationFunction, dActivationFunction, hiddenUnits(i), inputValues, targetValues, epochs, batchSize, learningRate);
     
    
    validInputValues = X_validation';
    validLabels = Y_validation;
    
    %test neural network with learned weights
    % returns the number of classified and misclassified digits
    %also a table containing the errors for each digit
    
    %function to validate the two layer perceptron using the validation set
     [correctlyClassified, classificationErrors] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, validInputValues, validLabels);
    
     m = size(validInputValues,2);
     
     errorRate = classificationErrors/m * 100;
     
    fprintf('Classification errors: %d\n', classificationErrors);
    fprintf('Correctly classified: %d\n', correctlyClassified);
    fprintf('Two Layer Perceptron Validation Error Rate: %d\n', errorRate);
    
    ErrorTable(1,i) = errorRate;  
end

figure(1)
plot(hiddenUnits, ErrorTable)
title('Test Error vs Number of Hidden Units - Model Selection in Neural Network')
xlabel('Number of Hidden Units')
ylabel('Error Rate');
grid on
   
end