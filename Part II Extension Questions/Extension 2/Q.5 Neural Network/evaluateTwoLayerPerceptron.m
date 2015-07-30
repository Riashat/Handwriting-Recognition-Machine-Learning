function outputVector = evaluateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputVector)
% evaluateTwoLayerPerceptron Evaluate two-layer perceptron given by the
% weights using the given activation function.
%
% INPUT:
% activationFunction             : Activation function used in both layers.
% hiddenWeights                  : Weights of hidden layer.
% outputWeights                  : Weights for output layer.
% inputVector                    : Input vector to evaluate.
%
% OUTPUT:
% outputVector                   : Output of the perceptron.
% 


    outputVector = activationFunction(outputWeights*activationFunction(hiddenWeights*inputVector));
end