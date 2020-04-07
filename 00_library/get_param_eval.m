function y = get_param_eval(blk,param)

% This function is a "smart" alternative to the funtion 'get_param()' that
% gets the evaluated value of the parameter, and not the string. This 
% function is useful when used in the Intialization tab of a Simulink mask.
% 
% PARAMETERS:
%   blk:   block name (string) 
%   param: object name (string) (e.g. variable defined in the mask dialogbox)
%
% USE:
% If the evaluated value of a mask parameter is needed, the function:
%      x = get_param(blk,'MyParam');
% will always return a string, even if the mask parameter is configured as
% 'evaluate'. To get the evalueated version of 'MyParam' (i.e. evaluated
% BEFORE entering the mask initialization function!), use this function:
%      x = get_param_eval(blk,'MyParam');
%
% NOTE: the function will give an error if the mask parameter is not
% configured as 'evaluate' (check box in the parameter dialog box).
%
% ferruccifranco@gmail.com
% August 2018
%
%% Check if parameters has the attribute 'evaluate' checked:
h = get_param(gcb,'ObjectParameters');
a = h.(param).Attributes;
if any(strcmp(a,'dont-eval'))
    error('The attribute must have the ''Evaluate'' attribute checked. Aborting.')
end

%% Get the list of variables defined in the mask workspace:
paramList = get_param(blk,'MaskWSVariables');

%% Creates a map with keys:
getMaskValues = containers.Map({paramList.Name}',{paramList.Value}');

%% Get the parameter of key 'ObjectName':
y = getMaskValues(param);
