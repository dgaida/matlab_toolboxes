%% get_initstate_from
% Get initstate struct from different possible sources
%
function initstate= get_initstate_from(plant_id, varargin)
%% Release: 1.4

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

is_plant_id(plant_id, '1st');

if nargin >= 2 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  isZ(accesstofile, 'accesstofile', 2, -1, 1);
else
  accesstofile= -1; 
end

%%

initstate= [];

%%

if accesstofile == 1 % load from file

  %%

  filename= sprintf('initstate_%s.mat', plant_id);

  if exist(filename, 'file') == 2
    initstate= load_file(filename);
  else
    warning('IO:FileNotExist', ['The file ', filename, ' does not exist!']);
  end

elseif accesstofile == 0 % load from base workspace

  %%

  try
    initstate= evalin('base', 'initstate');
  catch ME
    warning('evalin:error', ...
            ['Could not evaluate the variable initstate in the base workspace! ', ...
             'You have to load the file initstate_', plant_id, ...
             '.mat into the base ', ...
             'workspace or change the datasource type to file! %s'], ...
            ME.message);
  end

elseif accesstofile == -1 % load from modelworkspace

  %%

  initstate= eval_initstate_inMWS(plant_id);

else
  error('Unknown accesstofile type: %i', accesstofile);
end

%%


