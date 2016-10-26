%% save_initstate_to
% Save initstate struct to different possible sinks
%
function save_initstate_to(initstate, plant_id, varargin)
%% Release: 1.4

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

is_initstate(initstate, '1st');
checkArgument(plant_id, 'plant_id', 'char', '2nd');

if nargin >= 3 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  isZ(accesstofile, 'accesstofile', 3, -1, 1);
else
  accesstofile= -1; 
end

%%

if accesstofile == 1

  save_varname(initstate, 'initstate', sprintf('initstate_%s.mat', plant_id));

elseif accesstofile == 0

  assignin('base', 'initstate', initstate);

elseif accesstofile == -1

  assign_initstate_inMWS(plant_id, initstate);

else

  error('Unknown accesstofile type: %i', accesstofile);

end

%%


