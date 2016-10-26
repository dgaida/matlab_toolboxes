%% calcDXNorm
% Calculate a norm of the state derivation vector of the Simulink model
% |fcn| at the current (initial) state.
%
function [dxNorm, varargout]= calcDXNorm(fcn, varargin)
%% Release: 1.6

%%

error( nargchk(1, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% read out varargin

if nargin >= 2 && ~isempty(varargin{1}), 
  norm= varargin{1}; 
  
  validatestring(norm, {'infinity', '1', '2'}, mfilename, 'norm', 2);
else
  norm= 'infinity';
end

% we assume that the model has no input u
if nargin >= 3, 
  u= varargin{2}; 
else
  u= []; 
end


%% 
% check input parameters

fcn= char(fcn);

checkArgument(fcn, 'fcn', 'char', '1st');
checkArgument(u, 'u', 'numeric', '3rd');


%%
% throw away file extension '.mdl' if there is one

fcn= regexp(fcn, '.mdl', 'split');
fcn= char(fcn{1});


%%
% we just want to look at the current state $\vec{x}_0 := \vec{x}(t=
% 0)$ 
t= 0;


%%
% Pre-compile the model

try
  feval(fcn, [], [], [], 'lincompile');
catch ME
  warning('model:lincompile', ...
      'The model ''%s.mdl'' does not seem to exist or an error occured!', fcn);
  rethrow(ME);
end


%% 
% save the model, if it has changed, then 'dirty' is 'on', else 'off'

isdirty= get_param(fcn, 'Dirty');

% 
if strcmp( isdirty, 'on' )
  save_system(fcn);
end


%%
% get dx and y at the current (initial) operating point x0 (current
% state x0) 

% get current state $\vec{x}_0$
[sizes, x0]= feval(fcn, [], [], [], 'sizes');

% trigger all
feval(fcn, [], [], [], 'all');



%%
% because of warnings from calcDXNorm, should be called before line 59,
% because there the warning is thrown. but here it helps to avoid
% further warnings. 

set_param(fcn, 'InitInArrayFormatMsg', 'None');



%%
% get output (not the correct one) (without this command, dx would be
% the zero vector) 
%y= 
try
  feval(fcn, t, x0, u, 'outputs');
catch ME
  warning('calcDXNorm:outputs', ME.message);
  
  disp( get_stack_trace(ME) );
  
  feval(fcn, [], [], [], 'term');
  
  rethrow(ME);
end

% get $\frac{d}{dt}\vec{x}(t)$
dx= feval(fcn, t, x0, u, 'derivs');

% get output again, this is the correct one
y= feval(fcn, t, x0, u, 'outputs');

% if fcn isn't compiled, then you can terminate the model with this
% command, good for the command window, if a model can't be stopped
% by hand
%eval([fcn '([],[],[],''term'')']);

% terminate model
feval(fcn, [], [], [], 'term');


%%
% reset to warning

set_param(fcn, 'InitInArrayFormatMsg', 'Warning');


%%
%
if (nargout >= 2)
  varargout{1}= y;
end


%%
% calculate the norm of $\frac{d}{dt}\vec{x}(t)$

switch norm

  case 'infinity'

    %% 
    % infinity norm : meaning 'peak' ... of the vector
    % $\frac{d}{dt}\vec{x}(t)$
    % 
    % $$|| \vec{x} ||_\infty := \max_i | x_i |$$
    %
    % with
    %
    % $$ \vec{x}^T := (x_1, \dots, x_i, \dots, x_n)^T $$
    %
    dxNorm= max( abs( dx ) );

  case '2'

    %% 
    % euclidean (2-) norm : meaning 'energy' ... of the vector
    % $\frac{d}{dt}\vec{x}(t)$
    % 
    % $$|| \vec{x} ||_2 := \sqrt{ \vec{x}^T \vec{x} }$$
    %
    dxNorm= sqrt( dx' * dx );

  case '1'

    %% 
    % manhattan (1-) norm
    % 
    % $$|| \vec{x} ||_1 := \sum_{i=1}^n | x_i |$$
    %
    dxNorm= sum( abs( dx ) );

  otherwise

    error('Unknown norm: %s!', norm);

end

%%


