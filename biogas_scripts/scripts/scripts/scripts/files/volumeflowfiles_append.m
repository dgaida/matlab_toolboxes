%% volumeflowfiles_append
% Append volumeflow to all substrate volumeflow user files of given plant
%
function volumeflowfiles_append(plant_id, substrate_feed, shift, varargin)
%% Release: 1.3

%%

error( nargchk(3, 6, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1})
  id_write= varargin{1};
  isN0(id_write, 'id_write', 4);
else
  id_write= [];
end

if nargin >= 5 && ~isempty(varargin{2})
  position= varargin{2};
  validatestring(position, {'start', 'end'}, mfilename, 'position', 5);
else
  position= 'start';
end

if nargin >= 6 && ~isempty(varargin{3})
  start_time= varargin{3};
  isR(start_time, 'start_time', 6, '+');
else
  start_time= shift - 1;
end

%%
% check arguments

is_plant_id(plant_id, '1st');
isRn(substrate_feed, 'substrate_feed', 2);
isR(shift, 'shift', 3);   % measured in days

%%

substrate= load_biogas_mat_files(plant_id);

n_substrates= substrate.getNumSubstratesD();

%%

if numel(substrate_feed) ~= n_substrates
  error('The 2nd parameter substrate_feed must have %i elements, but has %i!', ...
    n_substrates, numel(substrate_feed));
end

%%

for isubstrate= 1:n_substrates
  
  %%
  
  substrate_id= char(substrate.getID(isubstrate));
  
  %%
  
  if ~isempty(id_write)
    filename= sprintf('volumeflow_%s_user_%i', substrate_id, id_write);
  else
    filename= sprintf('volumeflow_%s_user', substrate_id);
  end
  
  % values are duplicated to get a constant signal
  if strcmp(position, 'start')
    values= [max(0, start_time) shift; substrate_feed(isubstrate) substrate_feed(isubstrate)];
  else % 'end'
    values= [shift shift + 1; substrate_feed(isubstrate) substrate_feed(isubstrate)];
  end
  
  %%
  
  volumeflowfile_append(filename, values, position);
  
  %%
  
end

%%


