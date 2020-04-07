function der = derivative_datatip(figure_cursor)
%% Computes the derivative of the line that connects two figure datatips
% Franco Ferrucci
% Nov. 2019

t1 = figure_cursor(1).Position(1,1);
t2 = figure_cursor(2).Position(1,1);
dt = t1-t2;
y1 = figure_cursor(1).Position(1,2);
y2 = figure_cursor(2).Position(1,2);
dy = y1-y2;
der = dy/dt;
