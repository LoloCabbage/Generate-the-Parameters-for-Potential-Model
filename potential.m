function yhat = potential(beta,x)
global pop_t1
%     yhat = 0;
%     for i = 1:GridNum
%         yhat = yhat + pop_t1(i)^(beta(1)).*x(i).^(beta(2));
%     end
yhat = x.^beta(2)*(pop_t1.^beta(1));
end

