%% NMPC_save_SimOptmimData
% Save all data from startNMPC optimization function
%
function NMPC_save_SimOptmimData(varargin)
%% Release: 1.1

%%

error( nargchk(10, 10, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% Input Initialization

substrate=         varargin{1};
plant=             varargin{2};
%% TODO
% why is plant and plant_id passed?
plant_id=          varargin{3};
plant_network=     varargin{4};
plant_network_max= varargin{5};
equilibrium=       varargin{6};


% is needed, because NMPC_createDigesterStateMinMax evaluates the variable
% in the caller workspace, which is the workspace of this function
initstate=         varargin{7};

if nargin >= 8 && ~isempty(varargin{8})
  id_write= varargin{8};
  isN0(id_write, 'id_write', 8);
else
  id_write= [];
end

nsteps= varargin{9};
delta= varargin{10};

%%
% check params

is_substrate(substrate, '1st');
is_plant(plant, '2nd');
checkArgument(plant_id, 'plant_id', 'char', '3rd');
is_plant_network(plant_network, 4);
is_plant_network(plant_network_max, 5);
is_equilibrium(equilibrium, 6);
is_initstate(initstate, 7);
isN(nsteps, 'nsteps', 9);
isR(delta, 'delta', 10, '+');

lenGenomSubstrate= nsteps;

%% TODO
% muss als Parameter übergeben werden

lenGenomPump= 1;


%% 
% Auxiliary variables 

n_substrate= substrate.getNumSubstratesD();   % nº of substrates
n_fermenter= plant.getNumDigestersD();        % nº of fermenters

%% 
% WRITE optimal volumeflow / id_write
% i.e. 'volumeflow_substrate_id_const_id_write'

substrate_feed= get_feed_oo_equilibrium(equilibrium, substrate, plant, ...
                                        'user', lenGenomSubstrate);

%% 
% New Volumeflow saving
for isubstrate = 1:n_substrate
  % id_write
  % in die const file wird immer nur die letzte substratzufuhr
  % geschrieben, oder wäre das erste (bezieht sich auf lenGenomSubstrate)
  % element besser? 
  %% TODO
  % das erste wäre glaube ich besser
  createvolumeflowfile( ...
      'const', substrate_feed(isubstrate, lenGenomSubstrate), ...
               char(substrate.getID(isubstrate)), ...
               [], [], [], 'm3_day', 1, [], id_write );
end
% clear isubstrate

%% 
% New Fermenterflow saving
% Equilibrium structure -> current vflow

[nSplits, digester_splits]= ...
       getNumDigesterSplits(plant_network, plant_network_max, plant);
        
%%

sludge= get_sludge_oo_equilibrium(equilibrium, substrate, plant, ...
                                  'user', lenGenomSubstrate, lenGenomPump, ...
                                  plant_network, plant_network_max);

%%

for isplit= 1:nSplits     

  % Fermenter Names for Output_Input  
  fermenter_id_out_in= digester_splits{isplit};         

  value= sludge(isplit, lenGenomPump);

  % save new i.e. 'volumeflow_fermenter2nd_main_const'
  createvolumeflowfile('const', value, fermenter_id_out_in,...
      [], [], [],'m3_day', 1, [], id_write);

end % for
% clear ifermenterIn ifermenterOut fermenter_id_in fermenter_id_out % clear temp variables

%% 
% Write New optimal Initstate / id_write
% i.e. 'inistate_sunderhook_id_write'

get_initstate_dig_oo_equilibrium(equilibrium, initstate, plant_id, id_write);

%% 
% WRITE the CONTROL STRATEGY for the Volumeflow saving
for isubstrate = 1:n_substrate

  %%
  
  substrate_id= char(substrate.getID(isubstrate));

  last_c_horizon= evalin('caller', sprintf( 'volumeflow_%s_user(1,end)', substrate_id ) );

  % This routine loads a 'filename.mat' and saves the data with the
  % same 'filename' string in workspace
  vname1 = sprintf( 'volumeflow_%s_user', substrate_id ); 
  vdata1 = evalin( 'caller', sprintf('volumeflow_%s_user', substrate_id) );
  eval( sprintf('%s=%s;', vname1, 'vdata1') );

  % im grunde wird einfach noch mal die letzte substratzufuhr in die datei
  % geschrieben, damit ab da substratzufuhr konstant ist
  eval( sprintf( 'volumeflow_%s_user(:,end + 1)= [%i; %.2f];', ...
        substrate_id, last_c_horizon + (0.1*delta), ...
        substrate_feed(isubstrate, 1 )));%lenGenomSubstrate) ) );
  
  %% TODO
  % für lenGenomSubstrate > 1
  % muss komplettes substrate_feed in die datei geschrieben werden
  
  

  %%
  
  if ~isempty(id_write)

      save ( sprintf('volumeflow_%s_user_%i', substrate_id, id_write), ...
             sprintf('volumeflow_%s_user', substrate_id) ); 
  else

      save ( sprintf('volumeflow_%s_user', substrate_id), ...
             sprintf('volumeflow_%s_user', substrate_id) ); 
  end

end
clear isubstrate

%% 
% write the CONTROL STRATEGY for the Fermenter flux

% Equilibrium structure -> current vflow
%n_fermenter_eq= size( equilibrium.network_flux, 2 ); 
%n_fermenter_net= ( n_fermenter*n_substrate ); 

for isplit= 1:nSplits     

  % Fermenter Names for Output_Input  
  fermenter_id_out_in= digester_splits{isplit};         

  % Optimized fermenter flow between Fermenters -> Network
  value= sludge(isplit,1);

  last_c_horizon= evalin('caller', sprintf( 'volumeflow_%s_user(1,end)', ...
                         fermenter_id_out_in ) );

  % This routine loads a 'filename.mat' and saves the data with the
  % same 'filename' string in workspace
  vname1 = sprintf('volumeflow_%s_user', fermenter_id_out_in); 
  vdata1 = evalin( 'caller', sprintf('volumeflow_%s_user', ...
                   fermenter_id_out_in) );

  eval( sprintf('%s=%s;', vname1, 'vdata1') );

  % im grunde wird einfach noch mal die letzte fermenter fluss in die datei
  % geschrieben, damit ab da fermenter fluss konstant ist
  eval( sprintf( 'volumeflow_%s_user(:,end + 1)= [%i; %.2f];', ...
      fermenter_id_out_in, last_c_horizon + 1, value ) );

  %%

  if ~isempty(id_write)

    save( sprintf('volumeflow_%s_user_%i', fermenter_id_out_in, id_write), ...
          sprintf('volumeflow_%s_user', fermenter_id_out_in) );
  else

    save( sprintf('volumeflow_%s_user', fermenter_id_out_in), ...
          sprintf('volumeflow_%s_user', fermenter_id_out_in) );
  end

end

clear fermenter_id_out_in % clear temp variables

%%


