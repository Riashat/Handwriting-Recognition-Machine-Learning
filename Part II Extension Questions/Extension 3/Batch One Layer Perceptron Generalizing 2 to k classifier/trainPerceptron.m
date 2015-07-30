function [weights] = trainPerceptron(activationFunction, dActivationFunction,inputValues, targetValues, epochs, batchSize, learningRate,labels)


 % The number of training vectors.
    trainingSize = size(inputValues, 2);
    
    % Input vector has 256 dimensions.
    inputDimensions = size(inputValues, 1);
    % We have to distinguish 10 digits.
    outputDimensions = size(targetValues, 1);
    
    %initialize the weights
    weights = rand(outputDimensions, inputDimensions);
    
    weights = weights./size(weights,2);
    
    % weights = weights./size(weights,2);    
    n = zeros(batchSize);
             
   [rows, cols] = size(inputValues);


alpha = zeros(rows,1);
 mistakes = 0;
       
    for t = 1: epochs
        
        for k = 1: batchSize
            
            %randomly select which input vector to train on
            n(k) = floor(rand(1)*trainingSize + 1);
            
            inputVector = inputValues(:, n(k));

            ActualInput = weights * inputVector; %%%%%weights - 10x256, inputVector - 256x1
            
            OutputVector = activationFunction (ActualInput);
            
            targetVector = targetValues(:, n(k));

        %backpropagation in the one layer perceptron
        outputDelta = dActivationFunction(ActualInput).*(OutputVector - targetVector);

        %updating the weight parameters    
        weights = weights - learningRate .* outputDelta * inputVector'; 
          
        end
        
   
    end


end



            
            
           