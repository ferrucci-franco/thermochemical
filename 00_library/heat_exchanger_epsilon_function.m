function epsilon = heat_exchanger_epsilon_function(NTU, Cr, flowType)
% heat_exchanger_epsilon_function    epsilon computation
% This function computes the parameter epsilon as function of the values
% NTU and Cr (Cmin/Cmax) for different flow configurations.
%
% Input arguments:
%   NTU                 Number of transfer units (dimensionless)
%   Cr                  Capacity ratio (0..1)
%   flowType 			Heat exchanger flow type: 
%                         'Counter-flow'
%                         'Parallel-flow'
%                         'Cross-flow, both unmixed'
%                         'Cross-flow, both mixed'
%                         'Cross-flow, Cmax mixed, Cmin unmixed'
%                         'Cross-flow, Cmin mixed, Cmax unmixed'
%                         'Condensation/evaporation'
% Output argument:
%   epsilon             Effectiveness (0..1)
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
            epsilon = NTU/(1+NTU);
        else
            epsilon = (1-exp(-NTU*(1-Cr)))/(1-Cr*exp(-NTU*(1-Cr)));
        end
    case 'Parallel-flow'
        epsilon = (1-exp(-NTU*(1+Cr)))/(1+Cr);
    case 'Cross-flow, both unmixed'
        epsilon = 1 - exp(NTU^0.22/Cr * (exp(-Cr*NTU^0.78) - 1));
    case 'Cross-flow, both mixed'
        epsilon = inv(1/(1-exp(-NTU)) + Cr/(1-exp(-Cr*NTU)) - 1/NTU);
    case 'Cross-flow, Cmax mixed, Cmin unmixed'
        epsilon = (1-exp(-Cr*(1-exp(-NTU))))/Cr;
    case 'Cross-flow, Cmin mixed, Cmax unmixed'
        epsilon = 1-exp(-(1-exp(-Cr*NTU))/Cr);
    case 'Condensation/evaporation'
        epsilon = 1-exp(-NTU);
otherwise
    error('Wrong flow type or flow type not implemented.')
end
    