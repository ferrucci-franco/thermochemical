%% 
% Check results with:
% a) MS-06-84.PDF (see diagrams page 8..11)
% b) https://www.asco.com/en-gb/Pages/calculators-flow-calculator.aspx
% c) https://www.swagelok.com/en/Resources/CVCalculator
% d) https://www.teesing.com/en/pageid/calc-flow-cv-calculator

%%
clc
c = conversion_factors();
X = 400
dP = 69;
P2 = dP;
P1 = P2 + dP;
Y = valve_computation_gas('Cv',X,'std m3/h',P1,P2,21,'Air')
Z = valve_computation_gas('std m3/h',Y,'Cv',P1,P2,21,'Air')

%%
clc
X = 100*60
Y = valve_computation_gas('Cv',X,'SCFH',70,30,20,'Air')
Z = valve_computation_gas('SCFH',Y,'Cv',70,30,20,'Air')

%%
clc
X = 7
Y = valve_computation_gas('Cv',X,'std m3/h',70,30,20,'Air')
Z = valve_computation_gas('std m3/h',Y,'Cv',70,30,20,'Air')

%%
clc
X = 100*60
Y = valve_computation_gas('Cv',X,'SCFH',1000*c.psi_to_bar,(1000-10)*c.psi_to_bar,20,'Air')
Z = valve_computation_gas('SCFH',Y,'Cv',1000*c.psi_to_bar,(1000-10)*c.psi_to_bar,20,'Air')

%%
clc
X = 20*60
Y = valve_computation_gas('Cv',X,'SCFH',76*c.psi_to_bar,(76-5)*c.psi_to_bar,20,'Air')
Z = valve_computation_gas('SCFH',Y,'Cv',76*c.psi_to_bar,(76-5)*c.psi_to_bar,20,'Air')

%%
clc
X = 1*60
Y = valve_computation_gas('Cv',X,'SCFH',200*c.psi_to_bar,90*c.psi_to_bar,20,'Air')
Z = valve_computation_gas('SCFH',Y,'Cv',200*c.psi_to_bar,90*c.psi_to_bar,20,'Air')

%%
clc
X = 10*60
Y = valve_computation_gas('Cv',X,'SCFH',73*c.psi_to_bar,10*c.psi_to_bar,20,'Air')
Z = valve_computation_gas('SCFH',Y,'Cv',73*c.psi_to_bar,10*c.psi_to_bar,20,'Air')

%%
clc
X = 0.02*60
Y = valve_computation_gas('Cv',X,'SCFH',25*c.psi_to_bar,10*c.psi_to_bar,20,'Air')
Z = valve_computation_gas('SCFH',Y,'Cv',25*c.psi_to_bar,10*c.psi_to_bar,20,'Air')

%%
clc
X = 600*60
Y = valve_computation_gas('Cv',X,'SCFH',500*c.psi_to_bar,200*c.psi_to_bar,20,'Air')
Z = valve_computation_gas('SCFH',Y,'Cv',500*c.psi_to_bar,200*c.psi_to_bar,20,'Air')

%%
clc
X = 4000*c.L_min_to_m3_h
Y = valve_computation_gas('Cv',X,'std m3/h',100,99,20,'Air')
Z = valve_computation_gas('std m3/h',Y,'Cv',100,99,20,'Air')
Cv_to_Kv = c.gpmUS_to_m3_h/sqrt(c.psi_to_bar);
Kv_to_Cv = 1/Cv_to_Kv;

%%
clc
X = 600*c.L_min_to_m3_h
Y = valve_computation_gas('Cv',X,'std m3/h',4,3.5,20,'Air')
Z = valve_computation_gas('std m3/h',Y,'Cv',4,3.5,20,'Air')
Cv_to_Kv = c.gpmUS_to_m3_h/sqrt(c.psi_to_bar);
Kv_to_Cv = 1/Cv_to_Kv;

%%
clc
X = 10000*c.L_min_to_m3_h
Y = valve_computation_gas('Cv',X,'std m3/h',10,3.5,20,'Air')
Z = valve_computation_gas('std m3/h',Y,'Cv',10,3.5,20,'Air')
Cv_to_Kv = c.gpmUS_to_m3_h/sqrt(c.psi_to_bar);
Kv_to_Cv = 1/Cv_to_Kv;

%%
clc
X = 400*c.L_min_to_m3_h
Y = valve_computation_gas('Cv',X,'std m3/h',20,3.5,20,'Air')
Z = valve_computation_gas('std m3/h',Y,'Cv',20,3.5,20,'Air')
Cv_to_Kv = c.gpmUS_to_m3_h/sqrt(c.psi_to_bar);
Kv_to_Cv = 1/Cv_to_Kv;

%%
clc
X = 10
Y = valve_computation_gas('Cv',X,'std m3/h',30,20,65,'Ammonia')
Z = valve_computation_gas('std m3/h',Y,'Cv',30,20,65,'Ammonia')

%%
clc
X = 10
Y = valve_computation_gas('Cv',X,'std m3/h',30,20,66,'Ammonia')
Z = valve_computation_gas('std m3/h',Y,'Cv',30,20,66,'Ammonia')

%%
clc
X = 0.1178
Y = valve_computation_gas('Cv',X,'mol/sec',30,20,66,'Ammonia')
Z = valve_computation_gas('std m3/h',Y,'Cv',30,20,66,'Ammonia')
A = volume_to_mass_flow_converter(Z,'m3/h','mol/sec',[c.F_to_C(60) 1*c.atm_to_bar],'Ammonia')

%%
clc
c = conversion_factors();
X = 10 * c.CFM_to_CFH
Y = valve_computation_gas('Cv',X,'SCFH',14,3,80,'Ammonia')
Z = valve_computation_gas('SCFH',Y,'Cv',14,3,80,'Ammonia')
A = Z * c.CFH_to_CFM;

%%
clc
c = conversion_factors();
X = 100
Y = valve_computation_gas('Cv',X,'std m3/h',14,3,80,'Ammonia')
Z = valve_computation_gas('std m3/h',Y,'Cv',14,3,80,'Ammonia')
A = Z