%% change_initstate_oo_equilibrium
% Change initstate user entries for digesters to given values in equilibrium
%
function initstate= change_initstate_oo_equilibrium(equilibrium, plant_id, varargin)
%% Release: 1.4

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 3 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  isZ(accesstofile, 'accesstofile', 3, -1, 1);
else
  accesstofile= -1; 
end

%%
% check arguments

is_equilibrium(equilibrium, '1st');
is_plant_id(plant_id, '2nd');

%%
% for fermenters
%
fields= fieldnames(equilibrium.fermenter);

for ifield= 1:numel(fields)
  % Select fermenter name independent of model structure
  fermenter_id= fields{ifield}; 
  
  try

    initstate= createinitstatefile('user', plant_id, 'fermenter', fermenter_id, ...
        equilibrium.fermenter.( fermenter_id ).x0, accesstofile);

  catch ME
    rethrow(ME);
  end

end


%%


