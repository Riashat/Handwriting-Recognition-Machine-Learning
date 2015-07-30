function [correctlyClassified, mistakes] = validatePerceptron(activationFunction, weights, inputValues, labels)

    validationSetSize = size(inputValues, 2);
    mistakes = 0;
    correctlyClassified = 0;
    
    
    for n = 1: validationSetSize

        inputVector = inputValues(:, n);

        outputVector = predicted_outputVector(activationFunction, weights, inputVector);
                
        class = classifierDecision(outputVector);
        if class == labels(n)+1
            correctlyClassified = correctlyClassified + 1;
        else
            mistakes = mistakes + 1;
        end;
    end
    
end



