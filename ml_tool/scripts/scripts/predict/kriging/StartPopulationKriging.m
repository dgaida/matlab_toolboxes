%% StartPopulationKriging
% Creation of a start population for kriging interpolation
%
function X= StartPopulationKriging(samplingMethod, nov, nosp, ...
                                   vBoundaries, varargin) 
%% Release: 1.1

%%

error( nargchk(4, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check params

checkArgument(samplingMethod, 'samplingMethod', 'char', '1st');

validateattributes(nov, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'number of variables (nov)', 2);

validateattributes(nosp, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'number of sample points (nosp)', 3);

checkArgument(vBoundaries, 'vBoundaries', 'double', '4th');


%%

switch samplingMethod
  
  case ('rectangular Grid')
    X= gridsamp(vBoundaries, nosp);
    
  case ('latin hypercube')
    X=lhSampling(nosp, nov, vBoundaries(1,:), vBoundaries(2,:));
    
  otherwise
    error('Unknown sampling method!');
    
end

%%


