%% startFMinSearch
% Prepare and start <matlab:doc('fminsearch') fminsearch> to minimize objective
% function
%
function [u, varargout]= startFMinSearch(ObjectiveFunction, u0, varargin)
%% Release: 0.7

%%

error( nargchk(2, 7, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check parameters

checkArgument(ObjectiveFunction, 'ObjectiveFunction', 'function_handle', '1st');

%% 
% read out varargin

if nargin >= 3, 
  LB= varargin{1}; 
  
  checkArgument(LB, 'LB', 'double', '3rd');
else
  LB= [];
end

if nargin >= 4, 
  UB= varargin{2}; 
  
  checkArgument(UB, 'UB', 'double', '4th');
else
  UB= []; 
end

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end

%%
% params are checked in setFMinOptions
if nargin >= 5, noGenerations= varargin{3}; else noGenerations= []; end

if nargin >= 6, tolerance= varargin{4}; else tolerance= []; end

% param is checked in setFMinOptions
if nargin >= 7, OutputFcn= varargin{5}; else OutputFcn= []; end



%%
% set options

options= setFMinSearchOptions(noGenerations, tolerance, OutputFcn);

if isvector(u0)
  u0= u0(:)';     % make row vector if it is a vector at all
end

%%

if exist(fullfile(pwd, 'final_u_FMinSearch.mat'), 'file')
  
  uopt= load_file(fullfile(pwd, 'final_u_FMinSearch.mat'));
    
  if numel(uopt) ~= size(u0,2)
    warning('uopt:dim', ...
      'Rejecting previous optimal individual, because of dimension mismatch: %i ~= %i!', ...
      numel(uopt), size(u0,2));
  else
    u0= uopt;    % this a row vector
  end
  
end
                 
%% 
% start fminsearch

if exist('fminsearchbnd', 'file') == 2
    
  [u, fitness, exitflag, output]= ...
    fminsearchbnd(ObjectiveFunction, u0, LB, UB, options);

else
  errordlg('Optimization Toolbox not installed!');
  error('Optimization Toolbox not installed!');
end

%%

save('final_u_FMinSearch.mat', 'u');

%%

if nargout >= 2
  varargout{1}= fitness;
end
if nargout >= 3
  varargout{2}= exitflag;
end
if nargout >= 4
  varargout{3}= output;
end


%%


