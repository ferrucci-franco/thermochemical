function [z, x_real, y_real, idx_x, idx_y] = lookUp(X,Y,table,x,y)

idx_x = find(X>=x,1);
idx_y = find(Y>=y,1);
z = table(idx_x, idx_y);
x_real = X(idx_x);
y_real = Y(idx_y);