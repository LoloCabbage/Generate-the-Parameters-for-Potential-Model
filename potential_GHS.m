function yhat = potential_GHS(beta,x)
global pop_t1
yhat = x*(pop_t1.^beta);
end
