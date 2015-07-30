function [] = BatchPerceptronForHandwritingRecognition()

%this function is for using the hold out method for the batch one layer
%perceptron - using hold out, we optimize the number of batch sizes using
%this method


%the batch perceptron is similar to the neural network, except for using
%only one layer, and not having any hidden layer

% we take a batch size of training points for each epoch

load ziptrain.dat
k = round(length(ziptrain) * 2/3);

X_train = ziptrain(1:k, 2:end);
Y_train = ziptrain(1:k,1);
X_validation = ziptrain(4862:7291,2:end);
Y_validation = ziptrain(4862:7291, 1);


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
  
    
  for i = 1:length(batchSize)  
    
    [weights] = trainPerceptron(activate, dActivate,inputValues, targetValues, epochs, batchSize(i), learningRate,labels);
        
    validInputValues = X_validation';
    validLabels = Y_validation;
    
    fprintf('Validating the Batch Perceptron Algorithm \n');
    
    [correctlyClassified, mistakes] = validatePerceptron(activate, weights, validInputValues, validLabels);
    
    errorRate = mistakes / size(validInputValues,2) * 100;
    
    fprintf('Batch Size: %d\n', batchSize(i));
    fprintf('Classification errors: %d\n', mistakes);
    fprintf('Correctly classified: %d\n', correctlyClassified);
    fprintf('Validation Error Rate : %d\n', errorRate);
      
    ErrorTable(1,i) = errorRate;
    
  end
        
figure(1)
plot(batchSize, ErrorTable)
title('Test Error vs Batch Size - Model Selection in Batch One Layer Perceptron')
xlabel('Batch Size')
ylabel('Error Rate');
grid on

    



end
