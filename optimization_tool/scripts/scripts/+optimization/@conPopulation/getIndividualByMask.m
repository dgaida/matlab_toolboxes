%% optimization.conPopulation.getIndividualByMask
% Get the size of the individual from the structure of the constraints.
%
function [u, uMask]= getIndividualByMask(obj, nCols, Amax, Aeqmax, ...
                    LBmax, UBmax, varargin)
%% Release: 1.4

error( nargchk(6, 8, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%% 
% check arguments

checkArgument(obj, 'obj', 'optimization.conPopulation', 1);

if ~isempty(nCols)
  validateattributes(nCols, {'double'}, {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'nCols', 2);
end

checkArgument(Amax,   'Amax',   'double', 3);
checkArgument(Aeqmax, 'Aeqmax', 'double', 4);

checkArgument(LBmax, 'LBmax', 'double', 5);
checkArgument(UBmax, 'UBmax', 'double', 6);

%%

[lenIndividual, uMask, Amin, Aeqmin, LBmin, UBmin, u]= ...
        getMinimalDescription( nCols, Amax, Aeqmax, LBmax, UBmax, ...
                               varargin{:} );


%%


