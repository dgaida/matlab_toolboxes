%% create_volumeflow_files
% Create substrate volumeflow files for plant
%
function create_volumeflow_files(Q, plant_id, varargin)
%% Release: 1.4

%%

error( nargchk(2, 6, nargin, 'struct') );
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
  
  is_volumeflow_type(type, 4);
else
  type= 'const'; 
end

if nargin >= 5 && ~isempty(varargin{3})
  user_deltatime= varargin{3}; 
  isR(user_deltatime, 'user_deltatime', 5, '+');
else
  user_deltatime= []; 
end

if nargin >= 6 && ~isempty(varargin{4}), 
  user_unit= varargin{4}; 
  validatestring(user_unit, {'m3_day', 'kg_day'}, mfilename, 'user_unit', 6);                 
else
  user_unit= 'm3_day'; 
end

%%
% check arguments

checkArgument(Q, 'Q', 'double', '1st');
is_plant_id(plant_id, '2nd');

%%

substrate= load_biogas_mat_files(plant_id, [], {'substrate'});

n_substrates= substrate.getNumSubstratesD();

%%

if isvector(Q)
  % insert if here, otherwise if below would throw an error
  if n_substrates == 1
    Q= Q(:);    % then lenGenomSubstrate > 1
  else
    Q= Q(:)';   % then lenGenomSubstrate= 1 and Q is a row vector
  end
end

if size(Q, 2) ~= n_substrates
  error('size(Q, 2) ~= n_substrates: %i ~= %i', size(Q, 2), n_substrates);
end

%%

for isubstrate= 1:n_substrates

  %%
  
  if strcmp(user_unit, 'kg_day')
    mySubstrate= substrate.get(isubstrate);
  
    user_density= mySubstrate.get_param_of('rho');    % kg/m^3
  else
    user_density= 1;
  end
  
  %%
  
  createvolumeflowfile(type, Q(1, isubstrate), char(substrate.getID(isubstrate)), ...
                       user_deltatime, Q(:, isubstrate), user_density, user_unit, ...
                       accesstofile);

  %%
  
end

%%


