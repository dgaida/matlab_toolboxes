%% initializeSMSproblem
% Initializes optimization problem for SMS-EMOA
%
function [nVar rngMin rngMax isInt nObj algoCall]= initializeSMSproblem(params)
%% Release: 1.7

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 6, nargout, 'struct') );

%%
% check argument

checkArgument(params, 'params', 'cell', '1st');

%%

if numel(params) ~= 6
  error('The argument params must have 6 components, but has %i components!', ...
        numel(params));
end

%%

nVar    = params{1};
rngMin  = params{2};
rngMax  = params{3};
isInt   = params{4};
nObj    = params{5};
algoCall= params{6};

%%


