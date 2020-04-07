function y = LMTD_inv(u)
% Simbolic/numeric inverse solution of the mean log temperature difference.
%
% NOTE: do not set the output dimension to -1, otherwise Simulink will run
% the function with input parameters equal to 0 to detect the dimension
% (but that would create an error in the function).
%% Inputs
u1 = u(1);
u2 = u(2);

%% Simbolic solution
syms u1 u2 dx
eq = u1 == (dx-u2)/log(dx/u2);
s = solve(eq,dx,'ReturnConditions',true);
%% Solution treatment
% We know there are three solutions:
dx1 = s.dx(1);
dx2 = s.dx(2);
dx3 = s.dx(3);

% Parameter substitution:
dx1_subs = subs(dx1,u1,u(1));
dx1_subs = subs(dx1_subs,u2,u(2));
dx2_subs = subs(dx2,u1,u(1));
dx2_subs = subs(dx2_subs,u2,u(2));
dx3_subs = subs(dx3,u1,u(1));
dx3_subs = subs(dx3_subs,u2,u(2));

% Create array of solutions:
p = double([dx1_subs; dx2_subs; dx3_subs]);

% Eliminate dx = dy solution:
p(p == u(2)) = [];

% Eliminate solution with non-zero imaginary part:
p(imag(p) ~= 0) = [];

% Return solution:
y = p;