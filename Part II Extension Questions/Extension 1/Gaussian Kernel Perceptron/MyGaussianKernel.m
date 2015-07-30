function Kd= MyGaussianKernel(p, q, d)
 
        R = repmat(p,length(q),1)-q;
        
        K = arrayfun(@(x) norm(R(x,:)), 1:size(R,1));
        Kd = exp(-d*K.^2);
    
   %Kd = zeros(length(p), length(p)); 
%    %Kernel(i,j)=exp((-norm(X(i,:)'- X(j,:)').^2)./2);
%    for i = 1:length(p)
%        for j = 1:length(q)
   %Kd(i,j) = exp((-norm(p(i,:)' - q(j,:)').^2)./2);

   
%    Kd = zeros(length(p), length(q));  
%    for i =1:size(p,1)
%        for j = 1:size(q,1)
%            K = norm(p(i,:) - q(j,:));
%            Kd(i,j) = exp( -d * K.^2);
%        end
%    end

     
    %%%p - train(:, 2:end);  q - train(:, 2:end);
%     for i = 1:size(p,1)
        
        %R = bsxfun(@minus, p(i,:), q);       
%         for j = 1:size(R,1)
%             K = norm(R(j,:));
%         end



        
        
        
%         R = norm(repmat(p, length(q),1)-q);
%         Kd = exp(-d*R.^2);
%         
    %end
    
       
end

