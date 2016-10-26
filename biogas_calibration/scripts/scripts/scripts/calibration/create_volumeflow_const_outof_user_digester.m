%% create_volumeflow_const_outof_user_digester
% Create volumeflow_const files out of volumeflow_user files for digesters
%
function create_volumeflow_const_outof_user_digester(plant_id, method_type, varargin)
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
[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, plant_network_min, ...
 plant_network_max]= load_biogas_mat_files(plant_id);

%%

n_fermenter= plant.getNumDigestersD(); % nº of fermenters

%% 
% FERMENTER FLOW

for ifermenterIn= 1:( n_fermenter + 1 )      % nº of Columms -> Inputs to the fermenter
  
  for ifermenterOut= 1:n_fermenter           % nº of Rows -> Outputs to the fermenter

    %%
    % Connection condition within fermenters
    if ( plant_network(ifermenterOut, ifermenterIn) > 0 ) && ...
       ( plant_network_max(ifermenterOut, ifermenterIn) < Inf ) 

      %%
      % Fermenter Name for Input
      fermenter_id_in= char(plant.getDigesterID(ifermenterIn));  
      % Fermenter Name for Output
      fermenter_id_out= char(plant.getDigesterID(ifermenterOut));  

      %%
      % Read Out original digester recirculation from:
      % volumeflow_'fermenter_id'_user.mat
      if ~isempty(id_read)
          % volumeflow index '_%i'
          vdata1= load_file( sprintf('volumeflow_%s_%s_user_%i',...
              fermenter_id_out, fermenter_id_in, id_read) ); 
      else
          % original volumeflow
          vdata1= load_file( sprintf('volumeflow_%s_%s_user', ...
              fermenter_id_out, fermenter_id_in) );
      end

      %%
      % 'default' -> last known user digester recirculation
      if strcmp(method_type, 'last') 
        % save "volumeflow_digester_const" : user(:,end) -> const.mat

        vdata2= [ 0, 7.0000, 14.0000, 21.0000; vdata1(2,end), ...
                  vdata1(2,end), vdata1(2,end), vdata1(2,end) ];

      % 'mean' -> mean value of the user digester recirculation
      else
        if strcmp(method_type, 'mean') 
          % mean value of the volumeflow_'digester_id'_user.mat
          vdata3= mean( vdata1(2,:) );
        elseif strcmp(method_type, 'median') 
          vdata3= median( vdata1(2,:) );
        end
    
        vdata2= [0,      7.0000, 14.000, 21.000; ...
                 vdata3, vdata3, vdata3, vdata3];

      end
      
      %%
      
      vname1= sprintf('volumeflow_%s_%s_const', ...
                      fermenter_id_out, fermenter_id_in);
      vname2= 'vdata2'; 
      eval(sprintf('%s= %s;', vname1, vname2));

      save( sprintf( 'steadystate/volumeflow_%s_%s_const', ...
                      fermenter_id_out, fermenter_id_in ), ...
            sprintf( 'volumeflow_%s_%s_const', ...
                      fermenter_id_out, fermenter_id_in ) );

      save( sprintf( 'volumeflow_%s_%s_const', ...
                      fermenter_id_out, fermenter_id_in ), ...
            sprintf( 'volumeflow_%s_%s_const', ...
                      fermenter_id_out, fermenter_id_in ) );            

      %%
      
    end % end if   
    
  end
  
end

%%


