function [T1_out_K, T2_out_K, q, UA, NTU, Cr, fval] = heat_exchanger_epsilonNTU_inv(...
    T1_in_K, P1_bar, dNdt_1_mol_sec, fluidName_1, T2_in_K, P2_bar, ...
    dNdt_2_mol_sec, fluidName_2, epsilon, flowType)
% heat_exchanger_epsilonNTU_inv    Heat exchanger computation (inverse)
% This function computes the outlet temperatures of a heat exchanger. It
% applies the effectiveness-NTU (or epsilon-NTU) iterative method.
% The function accepts the 'epsilon' coefficient and it returns the
% conductance 'UA'.
%
% Input arguments:
%   T1_in_K             Stream 1 inlet temperature (K)
%   P1_bar              Stream 1 pressure (bar) (no pressure drop is assumed)
%   dNdt_1_mol_sec      Stream 1 molar flow rate (mol/sec)
%   fluidName_1         Stream 1 fluid name (must be availabe in CoolProp library)
%   T2_in_K             Stream 2 inlet temperature (K)
%   P2_bar              Stream 2 pressure (bar) (no pressure drop is assumed)
%   dNdt_2_mol_sec      Stream 2 molar flow rate (mol/sec)
%   fluidName_2         Stream 2 fluid name (must be availabe in CoolProp library)
%   epsilon             Effectiveness (0..1)
%   flowType 			Heat exchanger flow type: 
%                         'Counter-flow'
%                         'Parallel-flow'
%                         'Cross-flow, both unmixed'
%                         'Cross-flow, both mixed' --> NOT IMPLEMENTED!!!
%                         'Cross-flow, Cmax mixed, Cmin unmixed'
%                         'Cross-flow, Cmin mixed, Cmax unmixed'
% Output arguments:
%   T1_out_K            Stream 1 outlet temperature (K)
%   T2_out_K            Stream 2 outlet temperature (K)
%   q                   Total heat exchanged between streams (W)
%   UA					Heat exchanger conductance (W/K)
%   NTU                 Number of transfer units (dimensionless)
%   Cr                  Capacity ratio (0..1)
%   fval                Measure of the minimization success (must be very small)

% Ref:
% [1] Gregory Nellis, Sanford Klein -  Heat Transfer - Cambridge University 
%     Press (2008). Section 8, Table 8-2.
% [2] Ian H. Bell, Jorrit Wronski, Sylvain Quoilin, and Vincent Lemort,Pure 
%     and pseudo-pure fluid thermophysical  property evaluation  and  the  
%     open-source  thermophysical  property  library  cool-prop, Industrial 
%     & Engineering Chemistry Research 53 (2014), no. 6, 2498–2508.

% Franco Ferrucci
% ferruccifranco@gmail.com
% May 2018

%%
    % Bunble set of parameters into one cell:
    par = {T1_in_K, P1_bar, dNdt_1_mol_sec, T2_in_K, P2_bar, ...
           dNdt_2_mol_sec, epsilon, fluidName_1, fluidName_2, flowType};

    % disp(par) % for debugging!
    
    % Minimizing function 'fun_1_arg' with only one argument 'x' so that:
    %    x(1) = T1_out_K
    %    x(2) = T2_out_K
    % (This trick is necessary as the minimization function only accepts
    % functions with no parameters)
    fun_1_arg = @(x) fun(x,par);

    % Initial guess for iterative minimization (K):
    if T1_in_K > T2_in_K
        T1_out_K_guess = T1_in_K - 1;
        T2_out_K_guess = T2_in_K + 1;
    else
        T1_out_K_guess = T1_in_K + 1;
        T2_out_K_guess = T2_in_K - 1;
    end
    x0 = [T1_out_K_guess, T2_out_K_guess];
    
    % Iterative minimization algorithm:
    [x,fval,~,~] = fminsearch(fun_1_arg, x0);
    
    % Read solutions:
    T1_out_K = x(1);
    T2_out_K = x(2);
    
    % Compute 'q' and 'epsilon' with the auxiliary funciton:
    [q, UA,~,~,NTU,Cr] = heat_exchanger_temperatures_known_inv( ...
        T1_in_K, T1_out_K, P1_bar, dNdt_1_mol_sec, fluidName_1, ...
        T2_in_K,T2_out_K,P2_bar,dNdt_2_mol_sec,fluidName_2,epsilon,flowType);
    
    % Sanity check:
    if fval > 1e-2
        error('ERROR. Cannot find solution');
    end
    if ~isreal(q) || ~isreal(UA) || ~isreal(NTU) || ~isreal(Cr)
        error('ERROR. Nonreal solution. Try changing the value of epsilon (e.g. epsilon: 0..0.5 for parallel flow)')
    end
    
    % Debug:  
    % if any(isnan(x))
    %     error('Something is NaN!')
    % end
end
    
%% Sub-function: Minimizing function, with arguments:
% This is the function to minimize. Matlab will run this function many
% times until the output 'y' hits a minimum.

function y = fun(x,par)
    % Parse 'x' and 'par':
    T1_out_K = x(1);
    T2_out_K = x(2);
    T1_in_K = par{1};
    P1_bar = par{2};
    dNdt_1_mol_sec = par{3};
    T2_in_K = par{4};
    P2_bar = par{5};
    dNdt_2_mol_sec = par{6};
    epsilon = par{7};
    fluidName_1 = par{8};
    fluidName_2 = par{9};
    flowType = par{10};
    
    % Call auxiliary function:
    [q,~,C1,C2,~,~] = heat_exchanger_temperatures_known_inv(...
        T1_in_K, T1_out_K, P1_bar, dNdt_1_mol_sec, fluidName_1, ...
        T2_in_K,T2_out_K,P2_bar,dNdt_2_mol_sec,fluidName_2,epsilon,flowType);

    % Compute new outlet temperatures:
    T1_out_new_K = T1_in_K - q/C1;
    T2_out_new_K = T2_in_K + q/C2;
    % Note: these two equation are always correct, even if T1_in_K is
    % smaller than T2_in_K (as 'q' will be negative in this last case).
    
    % Compute cuadratic error:
    y = (T1_out_K - T1_out_new_K)^2 + (T2_out_K - T2_out_new_K)^2;
end

%% Sub-function: auxiliary function
% This is an auxiliary function for function 'fun'. It computes the heat
% exchanger heat, epsilon and specific heats for a given set of inlet and
% outlet temperatures (plus other input parametes).

function [q,UA,C1,C2,NTU,Cr] = heat_exchanger_temperatures_known_inv( ...
    T1_in_K, T1_out_K,P1_bar, dNdt_1_mol_sec, fluidName_1, T2_in_K, ...
    T2_out_K,P2_bar,dNdt_2_mol_sec,fluidName_2,epsilon,flowType)
    
    % Load conversion factors:
    con = conversion_factors();
    %
    T1_avg_K = 0.5 * (T1_in_K + T1_out_K);
    T2_avg_K = 0.5 * (T2_in_K + T2_out_K);

    % Check that 'T1_avg_K' and 'T2_avg_K' are above the triple point
    % temperature (ohtherwise CoolProp gives error):
    Ttriple1_K = CoolProp.Props1SI('Ttriple',fluidName_1);
    Ttriple2_K = CoolProp.Props1SI('Ttriple',fluidName_2);
    
    % Saturate 'T1_avg_K' and 'T2_avg_K' if they are below triple point:
    if T1_avg_K <= Ttriple1_K
        T1_avg_K = Ttriple1_K + 10;
    end
    %
    if T2_avg_K <= Ttriple2_K
        T2_avg_K = Ttriple2_K + 10;
    end 
    %
    cp_1 = CoolProp.PropsSI('CPMOLAR','T',T1_avg_K,'P',P1_bar*con.bar_to_Pa,fluidName_1);
    cp_2 = CoolProp.PropsSI('CPMOLAR','T',T2_avg_K,'P',P2_bar*con.bar_to_Pa,fluidName_2);
    %
    C1 = dNdt_1_mol_sec * cp_1;
    C2 = dNdt_2_mol_sec * cp_2;
    %
    Cmin = min([C1 C2]);
    Cmax = max([C1 C2]);
    %
    Cr = Cmin/Cmax;
    %
    NTU = heat_exchanger_NTU_function(epsilon, Cr, flowType);
    %
    UA = NTU*Cmin;
    %
    q_max = Cmin * (T1_in_K - T2_in_K);
    %
    q = epsilon * q_max;
end
