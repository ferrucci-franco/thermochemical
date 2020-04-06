function [y, x_real, idx_x] = lookUp_1D(X,table,x)

idx_x = find(X>=x,1);
y = table(idx_x);
x_real = X(idx_x);