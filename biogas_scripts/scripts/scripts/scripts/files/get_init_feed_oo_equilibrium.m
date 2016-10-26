%% get_init_feed_oo_equilibrium
% Gets the first values of the substrate feed out of the equilibrium
%
function init_substrate_feed= get_init_feed_oo_equilibrium(equilibrium, ...
  substrate, plant, control_horizon, delta)
%% Release: 1.1

%%
% narginchk existiert, funktioniert erst ab MATLAB 2011b
narginchk(5, 5);
nargoutchk(0, 1);

%%
% check arguments

is_equilibrium(equilibrium, '1st');
is_substrate(substrate, '2nd');
is_plant(plant, '3rd');
isN(control_horizon, 'control_horizon', 4);
isR(delta, 'delta', 5, '+');

%%
% get number of feed steps over the control horizon
num_steps= getNumSteps_Tc(control_horizon, delta);
  
%%
% network flux on plant
init_substrate_feed= equilibrium.network_flux;

%%
% no. of substrates and digesters

n_substrate= substrate.getNumSubstratesD();
n_digester= plant.getNumDigestersD();

%% TODO
% das ist kein gutes Kriterium! numel(init_substrate_feed) könnte größer
% als wie n_substrate * n_digester * num_steps sein, auf grund von digester
% sludge (recycles), und dann kann auch substrate feed in equilibrium const
% sein. 
if numel(init_substrate_feed) < n_substrate * n_digester * num_steps
  %%
  % then there is a constant feed saved in the equilibrium or a feed with
  % number of steps smaller as num_steps. But, here it is assumed, that it
  % is constant. Calling getNumDigesterSplits one could find out which of
  % both is true
  %% TODO
  
  init_substrate_feed= ...
    reshape(init_substrate_feed(1:n_substrate * n_digester), ...
            n_substrate, n_digester);
          
else
  %%
  % assuming that num_steps is the number of steps in which feed is saved
  % in equilibrium.network_flux. I am not cheking here, if this is really
  % the case
  %% TODO
  
  init_substrate_feed= ...
    reshape(init_substrate_feed(1:num_steps:n_substrate * n_digester * num_steps), ...
            n_substrate, n_digester);
          
end

%%


