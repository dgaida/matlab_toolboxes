%% pump_stream_closefcn
% Close the 'Pump Stream (Energy)' block.
%
function pump_stream_closefcn(varargin)
%% Release: 1.3

%%

narginchk(0, 1);
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 1 && ~isempty(varargin{1}), 
  DEBUG_DISP= varargin{1}; 
  
  is0or1(DEBUG_DISP, 'DEBUG_DISP', 1);
else
  DEBUG_DISP= 0; 
end

%%

if ~isempty(bdroot)
  hws= get_param(bdroot, 'modelworkspace');
else
  hws= [];
end

%%

if ~isempty(hws)

  %%
  % get chosen values
  values= get_param_error('MaskValues');

  %%
  % 11 : isload
  % 12 : isbeingloaded
  % 13 : isbeingclosed

  values(13,1)= {'on'};

  set_param_tc('MaskValues', values);

  %%
  % saves selected values in user data and then resets values to default
  
  createfermenterpopup(1, 0.8, 1, 0, 'Close', 11:12);       

  createfermenterpopup(2, 0.4, 1, 0, 'Close', 11:12);       

  %createvolumeflowtypepopup(3, 1);

  %createdatasourcetypepopup(4, 1);

  %createinitstatetypepopup(7, 1);  

end        

%%


