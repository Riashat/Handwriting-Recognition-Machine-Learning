function Kd= kerneld(p, q, d)
    % Polynomial kernel
    Kd=(p*q').^d;
    
   %Kd = zeros(length(p), length(p)); 
%    %Kernel(i,j)=exp((-norm(X(i,:)'- X(j,:)').^2)./2);
%    for i = 1:length(p)
%        for j = 1:length(q)
   
   %Kd(i,j) = exp((-norm(p(i,:)' - q(j,:)').^2)./2);
   
%    Kd(i,j) = exp( - (p(i,:)-q(j,:)) *  transpose(p(i,:)-q(j,:)) / 18 ) ;

     % Kd = exp ( - ((p-q)*transpose(p-q)) /18 );
   
end

