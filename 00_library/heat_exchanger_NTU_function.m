function NTU = heat_exchanger_NTU_function(epsilon, Cr, flowType)
% heat_exchanger_NTU_function    NTU computation
% This function computes the parameter NTU as function of the effectiveness
% 'epsilon' and the value Cr (Cmin/Cmax) for different flow configurations.
%
% Input arguments:
%   epsilon             Effectiveness (0..1)
%   Cr                  Capacity ratio (0..1)
%   flowType 			Heat exchanger flow type: 
%                         'Counter-flow'
%                         'Parallel-flow'
%                         'Cross-flow, both unmixed'
%                         'Cross-flow, Cmax mixed, Cmin unmixed'
%                         'Cross-flow, Cmin mixed, Cmax unmixed'
%                         'Condensation/evaporation'
% Output argument:
%   NTU                 Number of transfer units (dimensionless)
%
% Ref:
% [1] Gregory Nellis, Sanford Klein -  Heat Transfer - Cambridge University 
%     Press (2008). Section 8, Table 8-2.
% [2] Ian H. Bell, Jorrit Wronski, Sylvain Quoilin, and Vincent Lemort,Pure 
%     and pseudo-pure fluid thermophysical  property evaluation  and  the  
%     open-source  thermophysical  property  library  cool-prop, Industrial 
%     & Engineering Chemistry Research 53 (2014), no. 6, 2498–2508.
%
% Franco Ferrucci
% ferruccifranco@gmail.com
% March 2019
%% 
switch flowType
    case 'Counter-flow'
        if Cr ==1
            NTU = epsilon/(1-epsilon);
        else
            NTU = log((1-epsilon)/(1-epsilon*Cr))/(Cr-1);
        end
    case 'Parallel-flow'
        NTU = -log(1-epsilon*(1+Cr))/(1+Cr); % Table 8-1 in [1] is missing the '-1'!
    case 'Cross-flow, both unmixed'
        % Numerical inverse:
        fun = @(NTU) 1 - exp(NTU^0.22/Cr * (exp(-Cr*NTU^0.78) - 1)) - epsilon;
        NTU = fzero(fun,[0 1e6]);
    case 'Cross-flow, both mixed'
        error('Cross-flow, both mixed in not implemented (non-injective function)');
    case 'Cross-flow, Cmax mixed, Cmin unmixed'
        NTU = -log(1+(log(1-epsilon*Cr))/Cr);
    case 'Cross-flow, Cmin mixed, Cmax unmixed'
        NTU = -log(Cr*log(1-epsilon)+1)/Cr;
    case 'Condensation/evaporation'
        NTU = -log(1-epsilon);
    otherwise
        error('Wrong flow type or flow type not implemented.')
end

