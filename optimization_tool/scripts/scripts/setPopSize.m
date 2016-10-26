%% setPopSize
% Set the population size of an optimization problem.
%
function popSize= setPopSize(spacedimension, varargin)
%% Release: 1.8

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin

if nargin >= 2 && ~isempty(varargin{1}), 
  maxPopSize= varargin{1}; 
else
  maxPopSize= 75;
end


%%
% check param

checkArgument(spacedimension, 'spacedimension', 'double', '1st');

if ( min(size(spacedimension)) ~= 1 || numel(size(spacedimension)) ~= 2 ) && ...
     ~isempty(spacedimension)

  error('The parameter spacedimension has not the correct dimension!');
    
end

validateattributes(maxPopSize, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'maxPopSize', 2);


%%
% number of dimmensions
ndim= numel(spacedimension);

%%
% space determinant
spacedet= prod(spacedimension);

if spacedet == 0
  spacedet= round( numel(spacedimension) / 2 );
end

popSize= min( round( sqrt( (spacedet)*log(ndim)^4 ) / 4 ), maxPopSize );

popSize= max( popSize, min(round(ndim/3), maxPopSize) );

%%


