%% del_volumeflow_files
% Delete all volumeflow substrate files of a plant
%
function del_volumeflow_files(plant_id, type, varargin)
%% Release: 1.5

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  id_write= varargin{1};
  isN0(id_write, 'id_write', 3);
else
  id_write= [];
end

%%

is_plant_id(plant_id, '1st');
is_volumeflow_type(type, 2);

%%

[substrate]= load_biogas_mat_files(plant_id);

n_substrates= substrate.getNumSubstratesD();


%%

for isubstrate= 1:n_substrates
  
  substrateID= char(substrate.getID(isubstrate));
  
  if ~isempty(id_write)
    delete(sprintf('volumeflow_%s_%s_%i.mat', substrateID, type, id_write));
  else
    delete(sprintf('volumeflow_%s_%s.mat', substrateID, type));
  end
  
end

%%


