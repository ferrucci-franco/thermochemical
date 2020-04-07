function blk_ideal_gas_equation_of_state(blk)

%% Simulink block callback.
% Block name: blk_ideal_gas_equation_of_state

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% January 2019

%% Get mask parameters:
par = get_param(blk,'sel');

switch par
    case 'P(T,v)'    
        in1 = 'T (K)';
        in2 = 'v (m³/mol)';
        out1 = 'P (bar)';
        count = 1;
    case 'P(T,rho)'    
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'P (bar)';
        count = 2;
    case 'T(P,v)'
        in1 = 'P (bar)';
        in2 = 'v (m³/mol)';
        out1 = 'T (K)';
        count = 3;
    case 'T(P,rho)'
        in1 = 'P (bar)';
        in2 = 'rho (mol/m³)';
        out1 = 'T (K)';
        count = 4;
    case 'v(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'v (m³/mol)';
        count = 5;
	case 'rho(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'rho (mol/m³)';
        count = 6;
    otherwise
        error('It shouldn''t have gotten in her!')
end

%% Update mask parameters:
set_param([blk,'/Constant'],'Value',num2str(count))

%% Change name of input 1:
p = get_param([blk,'/In1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',in1);

%% Change name of input 2:
p = get_param([blk,'/In2'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',in2);
set_param([blk,'/In2'],'IconDisplay','Signal name');

%% Change name of output:
p = get_param([blk,'/Multiport Switch'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',out1);
