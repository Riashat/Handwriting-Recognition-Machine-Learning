function [mistakes, weight] = kernel_perceptron_training(train,weight, kernel)

digits = 10;
%X = train(:,2:end);

%implementing the kernel
%kernel = kerneld(train(:, 2:end), train(:, 2:end), degree);

mistakes = 0;

for i=1:size(train,1)

    y_label = train(i,1);
    x = train(i,2:end);
    y=-1;
    maxi = 0;
    updateKernel=kernel(i,:);    
    prediction = zeros(digits,1);
    
    for j = 1:digits       
        prediction(j) = classpredk(updateKernel, weight(j,:));
    end
    
    maxc = -10^15;
    for j = 0:digits-1
        
        if y_label==j
            y=1;
        else
            y=-1;
        end
              
        if y*prediction(j+1)<=0
            weight(j+1,i)=weight(j+1,i)-mysign(prediction(j+1));
        end
    
        if prediction(j+1)>maxc
            maxc=prediction(j+1);
            maxi=j;
        end
    
    end
    
    if maxi ~= y_label
        mistakes = mistakes + 1;        
    end    
    
end  
    
end
    
