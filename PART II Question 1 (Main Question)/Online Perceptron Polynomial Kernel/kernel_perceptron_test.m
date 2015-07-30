function [mistakes, table, errorScannedDigits] = kernel_perceptron_test(test, weight, kernel, errorScannedDigits)

% Test perceptron 
%kernel=kerneld(test(:,2:end),train(:,2:end), degree);
mistakes = 0;
digits = 10;
errorTable=[[0 0:9]' zeros(11,1)];
table=[errorTable [[0:9];zeros(10,10)]];

for i=1:length(test)
    y_labels=test(i,1);
    x=test(i,2:end);
    y=-1;
    maxi=0;
    updateKernel=kernel(i,:);
    prediction = zeros(1,digits);
    errorScannedDigits(i,1)=i;
    
    %sum - alpha * Kernel(i,:)
    for j=1:digits
        %confidence for each digit
        prediction(j)= classpredk(updateKernel,weight(j,:));
    end
    

    
    maxc=-10^9;
    for j=0:digits-1
        if y_labels==j
            y=1;
        else
            y=-1;
        end
        
        %assigning maxj as the label of the digit
        if prediction(j+1)>maxc
            maxc=prediction(j+1);
            maxi=j;
        end
        
    end
    
    %if there is a mistake
    if maxi~=y_labels
        table(y_labels+2,2)=table(y_labels+2,2)+1;
        table(y_labels+2,maxi+3)=table(y_labels+2,maxi+3)+1;
        %increment the number of mistakes
        mistakes=mistakes+1;
        errorScannedDigits(i,2)=errorScannedDigits(i,2)+1;
    end
end
end
