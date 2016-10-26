%% saveStateInEquilibriumStruct
% Load the initstate from selected workspace and save it in the
% equilibrium struct.
%
function equilibrium= saveStateInEquilibriumStruct(...
                      equilibrium, plant, plant_network, fitness, varargin)
%% Release: 1.8

%%

error( nargchk(4, 5, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 5 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  isZ(accesstofile, 'accesstofile', 5, -1, 1);
else
  accesstofile= -1; 
end


%%
% check input parameters

is_equilibrium(equilibrium, '1st');
is_plant(plant, '2nd');
is_plant_network(plant_network, 3, plant);
% for multiobjective optimization fitness is a vector, else a scalar
isRn(fitness, 'fitness', 4);  

%%

n_fermenter= plant.getNumDigestersD();


%%

initstate= get_initstate_from(char(plant.id), accesstofile);

%%

if ~isempty(initstate)

  %%
  % fermenter

  for ifermenter= 1:n_fermenter

    fermenter_name= char(plant.getDigesterID(ifermenter));

    if isfield(equilibrium, 'fermenter')
      if isfield(equilibrium.fermenter, fermenter_name)
        if isfield(equilibrium.fermenter.( fermenter_name ), 'x0')
          if isfield(initstate, 'fermenter')
            if isfield(initstate.fermenter, fermenter_name)
              if isfield(initstate.fermenter.( fermenter_name ), 'user')

                equilibrium.fermenter.( fermenter_name ).x0= ...
                    initstate.fermenter.( fermenter_name ).user;

              else
                error('~isfield(initstate.fermenter.( fermenter_name ).user)');
              end
            else
              error('~isfield(initstate.fermenter.( fermenter_name ))');
            end
          else
            error('~isfield(initstate.fermenter)');
          end
        else
          error('~isfield(equilibrium.fermenter.( fermenter_name ).x0)');
        end
      else
        error('~isfield(equilibrium.fermenter.( fermenter_name ))');
      end
    else
      error('~isfield(equilibrium.fermenter)');
    end

  end % for


  %%
  
  [nRecirculations, digester_recirculations]= ...
       getNumRecirculations(plant_network, plant);

  %%

  for ihydraulicdelay= 1:nRecirculations

    rec= digester_recirculations{ihydraulicdelay};

    try
      equilibrium.hydraulic_delay.( rec ).x0= initstate.hydraulic_delay.( rec ).user;
    catch ME

      warning('initstate:userNotExist', 'strange error user not existent! %s', ...
              ME.message);

    end
      
  end

else

  warning('initstate:empty', 'initstate is empty, maybe the model is already closed!');

end

%%

equilibrium.fitness= fitness;

%%

    
    