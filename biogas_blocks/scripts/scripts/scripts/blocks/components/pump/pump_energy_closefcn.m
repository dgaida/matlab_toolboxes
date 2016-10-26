%% pump_energy_closefcn
% Close the 'Pump (Energy)' block.
%
function pump_energy_closefcn(varargin)
%% Release: 0.9

%%
% read out varargin

if nargin >= 1, DEBUG_DISP= varargin{1}; else DEBUG_DISP= 0; end

if nargin >= 2
    error(['You may only call this function with max. 1 argument, ', ...
           'but it was called with %i arguments.'], nargin);
end


%% 
% check input parameters

if (DEBUG_DISP ~= 0) && (DEBUG_DISP ~= 1)
    error('The 1st parameter DEBUG_DISP must be either 0 or 1, but is %i', ...
          DEBUG_DISP);
end


%%

if ~isempty(bdroot)
    hws= get_param(bdroot, 'modelworkspace');
else
    hws= [];
end

if ~isempty(hws)
    
    %%
    % get chosen values
    values= get_param(gcb, 'MaskValues');
    
    if isempty(values)
        error('Could not read the parameter MaskValues of block %s!', gcb);
    end
    
    
    %%
    
    values(5,1)= {'on'};
        
    try
        set_param(gcb, 'MaskValues', values);
    catch ME
        warning(['Could not set the parameter MaskValues of block ', ...
                gcb, '! Tried to set ', char(values(5,1))]);
    
        rethrow(ME);
    end
    
    
    %%
    
    createfermenterpopup(1, 0.3, 1, 0, 'Close', 3:4);   
        
end


