function outputVector = predicted_outputVector(activationFunction, weights, inputVector)

    outputVector = activationFunction(weights * inputVector);
end