function [hiddenWeights, outputWeights, error] =  train_NeuralNetwork (activationFunction, dActivationFunction, hiddenUnits, input, targetValues, epochs, batchSize, learningRate);

  % The number of training vectors.
    trainingSetSize = size(input, 2);
    
    % Input vector has 784 dimensions.
    inputDimensions = size(input, 1);
    % We have to distinguish 10 digits.
    outputDimensions = size(targetValues, 1);

    
    %initialize weights for the hidden layer and the output layer
    
    hiddenWeights = rand(hiddenUnits, inputDimensions);
    outputWeights = rand(outputDimensions, hiddenUnits);

    hiddenWeights = hiddenWeights./size(hiddenWeights, 2);
    outputWeights = outputWeights./size(outputWeights, 2);
    
    n = zeros(batchSize);

    
    for t = 1: epochs
        for k = 1: batchSize
            % Select which input vector to train on.
            n(k) = floor(rand(1)*trainingSetSize + 1);
            
            
            %need to find a way to propagate the input vector through the
            %network
            inputVector = input(:, n(k));
            
            hiddenActualInput = hiddenWeights*inputVector;
            
            hiddenOutputVector = activationFunction(hiddenActualInput);
            
            outputActualInput = outputWeights*hiddenOutputVector;
            
            outputVector = activationFunction(outputActualInput);
            
            targetVector = targetValues(:, n(k));
            
            
            
            %error backpropagation during training of neural network
             % Backpropagate the errors.
            outputDelta = dActivationFunction(outputActualInput).*(outputVector - targetVector);
            hiddenDelta = dActivationFunction(hiddenActualInput).*(outputWeights'*outputDelta);
            
            outputWeights = outputWeights - learningRate.*outputDelta*hiddenOutputVector';
            hiddenWeights = hiddenWeights - learningRate.*hiddenDelta*inputVector';
        end;

          error = 0;
          
          
        for k = 1: batchSize
            inputVector = input(:, n(k));
            targetVector = targetValues(:, n(k));
            
            error = error + norm(activationFunction(outputWeights*activationFunction(hiddenWeights*inputVector)) - targetVector, 2);
        end;
        error = error/batchSize;
       
    end

end