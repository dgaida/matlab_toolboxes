%% is_substrate_network
% Check if argument is a substrate_network
%
function is_substrate_network(argument, argument_number, varargin)
%% Release: 1.9

%%

global IS_DEBUG;

if isempty(IS_DEBUG) || ~IS_DEBUG
  return;
end

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  substrate= varargin{1};
  is_substrate(substrate, '3rd');
else
  substrate= [];
end

if nargin >= 4 && ~isempty(varargin{2})
  plant= varargin{2};
  is_plant(plant, 4);
else
  plant= [];
end

%%
% check arguments

isN(argument_number, 'argument_number', 2);

%%
% this check applies to every call 

validateattributes(argument, {'double'}, ...
                   {'2d', 'nonempty', 'nonsparse', 'nonnegative', 'real'}, ...
                   mfilename, 'substrate_network', argument_number);

%%

if isempty(substrate) && isempty(plant)
  % do no further checks, except the one above
elseif isempty(substrate)
  validateattributes(argument, {'double'}, {'ncols', ...
                    plant.getNumDigestersD()}, ...
                    mfilename, 'substrate_network', argument_number);
elseif isempty(plant)
  validateattributes(argument, {'double'}, {'nrows', ...
                    substrate.getNumSubstratesD()}, ...
                    mfilename, 'substrate_network', argument_number);
else % both not empty
  validateattributes(argument, {'double'}, {'size', ...
                    [substrate.getNumSubstratesD(), plant.getNumDigestersD()]}, ...
                    mfilename, 'substrate_network', argument_number);
end

%%


