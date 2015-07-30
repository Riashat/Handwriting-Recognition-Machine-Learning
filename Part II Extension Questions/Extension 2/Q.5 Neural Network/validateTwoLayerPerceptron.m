function [correctlyClassified, classificationErrors] = validateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputValues, labels)



    testSetSize = size(inputValues, 2);
    classificationErrors = 0;
    correctlyClassified = 0;
    
    for n = 1: testSetSize
        inputVector = inputValues(:, n);
        outputVector = evaluateTwoLayerPerceptron(activationFunction, hiddenWeights, outputWeights, inputVector);
        
        class = classifierDecision(outputVector);
        if class == labels(n) + 1
            correctlyClassified = correctlyClassified + 1;
        else
            classificationErrors = classificationErrors + 1;
        end;
    end;
end


