%% is_plant_network
% Check if argument is a plant_network
%
function is_plant_network(argument, argument_number, varargin)
%% Release: 1.9

%%

global IS_DEBUG;

if isempty(IS_DEBUG) || ~IS_DEBUG
  return;
end

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  plant= varargin{1};
  is_plant(plant, '3rd');
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
                   mfilename, 'plant_network', argument_number);

%%

if ~isempty(plant)
  validateattributes(argument, {'double'}, {'size', ...
                    [plant.getNumDigestersD(), plant.getNumDigestersD() + 1]}, ...
                    mfilename, 'plant_network', argument_number);
end

%%


