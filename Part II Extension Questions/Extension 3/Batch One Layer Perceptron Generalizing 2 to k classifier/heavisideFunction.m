function y = heavisideFunction(x)

y = [];
l = length(x);

if sum(x) >= 0
    y = ones(10,1);
else
    if sum(x) < 0
        y = zeros(10,1);
        
    end
end
end

