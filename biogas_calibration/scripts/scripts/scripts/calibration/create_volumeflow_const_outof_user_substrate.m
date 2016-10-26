%% create_volumeflow_const_outof_user_substrate
% Create volumeflow_const files out of volumeflow_user files for substrates
%
function create_volumeflow_const_outof_user_substrate(plant_id, method_type, varargin)
%% Release: 1.4

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% get arguments

% id where to read from
if nargin >= 3 && ~isempty(varargin{1}), 
  id_read= varargin{1}; 
  isN(id_read, 'id_read', 3);
else
  id_read= []; 
end

%%
% check arguments

checkArgument(plant_id, 'plant_id', 'char', '1st');
validatestring(method_type, {'mean', 'median', 'last'}, ...
               mfilename, 'method_type', 2);

%%
% Load plant's data [ substrate, plant, ... ]
%
[substrate]= load_biogas_mat_files(plant_id);

%%

n_substrate= substrate.getNumSubstratesD();  % nº of substrates

%%
% SUBSTRATE FLOW

for isubstrate= 1:n_substrate

  %%
  
  substrate_id= char(substrate.getID(isubstrate));

  %%
  % Read Out original Substrate feed from: 
  % volumeflow_'substrate_id'_user.mat
  if ~isempty(id_read)
    % volumeflow index '_%i'
    vdata1= load_file(['volumeflow_', substrate_id, ...
                       sprintf('_user_%i', id_read)]);  
  else
    % original volumeflow
    vdata1= load_file(['volumeflow_', substrate_id, '_user']); 
  end

  %%
 
  % 'last' -> last known user substrate feed
  if strcmp(method_type, 'last') 
    % save "volumeflow_substrate_const" : user(:,end) -> const.mat

    vdata2 = [ 0, 7.0000, 14.0000, 21.0000; vdata1(2,end), ...
               vdata1(2,end), vdata1(2,end), vdata1(2,end) ];

  else
    % 'mean' -> mean value of the user substrate feed
    if strcmp(method_type, 'mean') 
      % mean value of the volumeflow_'substrate_id'_user.mat
      vdata3= mean( vdata1(2,:) );
    elseif strcmp(method_type, 'median') 
      vdata3= median( vdata1(2,:) );
    end
  
    vdata2= [0,      7.0000, 14.000, 21.000; ...
             vdata3, vdata3, vdata3, vdata3];

  end
  
  %%
  
  vname1= ['volumeflow_', substrate_id, '_const'];
  vname2= 'vdata2'; 
  eval(sprintf('%s= %s;', vname1, vname2));

  save (['steadystate/volumeflow_', substrate_id, '_const'], ...
        ['volumeflow_', substrate_id, '_const']); 

  save (['volumeflow_', substrate_id, '_const'], ...
        ['volumeflow_', substrate_id, '_const']); 
     
end

%%


