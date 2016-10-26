%% get_ADM_params_out_of_file
% Get ADM params out of adm1_params_opt_....mat file
%
function [p_values, p_ids]= get_ADM_params_out_of_file(varargin)
%% Release: 1.0

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if ischar(varargin{1})
  % then plant_id is given
  plant_id= varargin{1};
else
  % then plant is given
  plant= varargin{1};
  is_plant(plant, 1);
  plant_id= char(plant.id);
end

%%

p_opt= load_file( sprintf('adm1_params_opt_%s.mat', plant_id) );

%%

fields= fieldnames(p_opt);

%%

%n_digester= plant.getNumDigestersD();
n_digester= numel(fields);

%%
%% TODO
% nutze calib_getDefaultADM1params, diese gibt parameter ids zurück

p_ids= cell(1, n_digester * numel(p_opt.(fields{1})));

p_values= zeros(1, n_digester * numel(p_opt.(fields{1})));

%%

for ifermenter= 1:n_digester

  %%
  
  %fermenter_id= char(plant.getDigesterID(ifermenter));
  fermenter_id= fields{ifermenter};
  
  nparams= numel( p_opt.(fermenter_id) );

  %%
  
  for iparam= 1:nparams

    %%
    
    p_values(1, (ifermenter - 1)*nparams + iparam)= ...
                p_opt.(fermenter_id)(iparam,1);

    p_ids(1, (ifermenter - 1)*nparams + iparam)= {sprintf('p%i_%s', ...
           0*(ifermenter - 1)*nparams + iparam, fermenter_id)}; 

    %%
    
  end
  
  %%

end

%%



%%


