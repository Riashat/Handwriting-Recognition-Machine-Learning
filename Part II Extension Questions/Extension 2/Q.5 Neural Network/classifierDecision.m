function class = classifierDecision(outputVector)
 
max = 0;
    class = 1;
    for i = 1: size(outputVector, 1)
        if outputVector(i) > max
            max = outputVector(i);
            class = i;
        end;
    end;    
end