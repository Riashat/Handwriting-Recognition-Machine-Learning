function y = dHeavisideFunction(x)
% dLogisticSigmoid Derivative of the logistic sigmoid.
% 
% INPUT:
% x     : Input vector.
%
% OUTPUT:
% y     : Output vector where the derivative of the logistic sigmoid was
% applied element by element.

y = [];

    y = heavisideFunction(x).*(1 - heavisideFunction(x));
end