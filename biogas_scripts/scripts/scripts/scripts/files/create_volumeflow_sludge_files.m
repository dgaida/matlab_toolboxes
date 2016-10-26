%% create_volumeflow_sludge_files
% Create volumeflow files of (recirculation) sludge streams on plant
%
function create_volumeflow_sludge_files(Q, plant_id, varargin)
%% Release: 1.4

%%

error( nargchk(2, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 3 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  
  isZ(accesstofile, 'accesstofile', 3, -1, 1);
else
  accesstofile= 1; 
end

if nargin >= 4 && ~isempty(varargin{2})
  type= varargin{2};
  %% TODO
  % maybe load cellstring out of volumeflowtypes.mat
  validatestring(type, {'random', 'const', 'user'}, mfilename, 'flow type', 4);
else
  type= 'const'; 
end

if nargin >= 5 && ~isempty(varargin{3})
  user_deltatime= varargin{3}; 
  isR(user_deltatime, 'user_deltatime', 5, '+');
else
  user_deltatime= []; 
end

%%
% check arguments

checkArgument(Q, 'Q', 'double', '1st');
checkArgument(plant_id, 'plant_id', 'char', '2nd');

%%

[plant, plant_network, plant_network_max]= load_biogas_mat_files(plant_id, [], ...
  {'plant', 'plant_network', 'plant_network_max'});

%%

[nSplits, digester_splits]= getNumDigesterSplits(plant_network, ...
                                                 plant_network_max, plant);

%%

if isvector(Q)
  % insert if here, otherwise if below would throw an error
  if nSplits == 1
    Q= Q(:);    % then lenGenomPump > 1
  else
    Q= Q(:)';   % then lenGenomPump= 1 and Q is a row vector
  end
end

if size(Q, 2) ~= nSplits
  error('size(Q, 2) ~= nSplits: %i ~= %i', size(Q, 2), nSplits);
end

%%

for isplit= 1:nSplits

  createvolumeflowfile(type, Q(1, isplit), digester_splits{isplit}, ...
                       user_deltatime, Q(:, isplit), [], [], accesstofile);

end

%%


