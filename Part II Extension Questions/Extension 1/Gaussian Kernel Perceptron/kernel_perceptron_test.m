function [mistakes, table, errorScannedDigits] = kernel_perceptron_test(train,test, degree, weight, errorScannedDigits)

% Test perceptron 
%kernel=kerneld(test(:,2:end),train(:,2:end), degree);
mistakes = 0;
digits = 10;
errorTable=[[0 0:9]' zeros(11,1)];
table=[errorTable [[0:9];zeros(10,10)]];
for i=1:length(test)
    y_labels=test(i,1);
    test_x = test(i,2:end);
    updateKernel = MyGaussianKernel(test_x, train(:,2:end), degree);    
    x=test(i,2:end);
    y=-1;
    maxi=0;
    errorScannedDigits(i,1)=i;
    prediction = zeros(1,digits);
    for j=1:digits
        prediction(j)= classpredk(updateKernel,weight(j,:));
    end

    
    maxc=-10^9;
    for j=0:digits-1
        if y_labels==j
            y=1;
        else
            y=-1;
        end
        
        if prediction(j+1)>maxc
            maxc=prediction(j+1);
            maxi=j;
        end
        
    end
    if maxi~=y_labels
        table(y_labels+2,2)=table(y_labels+2,2)+1;
        table(y_labels+2,maxi+3)=table(y_labels+2,maxi+3)+1;
        mistakes=mistakes+1;
        errorScannedDigits(i,2)=errorScannedDigits(i,2)+1;
    end
end
end
