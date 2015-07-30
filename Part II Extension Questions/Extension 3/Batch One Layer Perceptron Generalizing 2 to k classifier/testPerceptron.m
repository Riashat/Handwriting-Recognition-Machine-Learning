function [correctlyClassified, mistakes, table,errorScannedDigits] = testPerceptron(activationFunction, weights, inputValues, labels, errorScannedDigits)

   testSetSize = size(inputValues, 2);
    mistakes = 0;
    correctlyClassified = 0;
    
    
    errorTable=[[0 0:9]' zeros(11,1)];
    table=[errorTable [[0:9];zeros(10,10)]];
    
    
    for n = 1: testSetSize

        errorScannedDigits(n,1)=n;
        inputVector = inputValues(:, n);

        outputVector = predicted_outputVector(activationFunction, weights, inputVector);
                
        class = classifierDecision(outputVector);
        if class == labels(n)+1
            correctlyClassified = correctlyClassified + 1;
        else
            mistakes = mistakes + 1;
        table(labels(n)+2,2)=table(labels(n)+2,2)+1;
        table(labels(n)+2,class+2)=table(labels(n)+2,class+2)+1;
        errorScannedDigits(n,2)=errorScannedDigits(n,2)+1;
        end;
    end
    
end



