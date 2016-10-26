%% create_pwc_volumeflows
% Create stepwise constant user volumeflows for given plant between start
% and end values
%
function create_pwc_volumeflows(plant_id, Q_start, Q_end, timespan, num_steps, varargin)
%% Release: 1.3

%%

error( nargchk(5, 7, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 6 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  
  isZ(accesstofile, 'accesstofile', 6, -1, 1);
else
  accesstofile= 1; 
end

if nargin >= 7 && ~isempty(varargin{2}), 
  do_plots= varargin{2}; 
  
  is0or1(do_plots, 'do_plots', 7);
else
  do_plots= 0; 
end

%%
% check arguments

is_plant_id(plant_id, '1st');
isRn(Q_start, 'Q_start', 2);
isRn(Q_end, 'Q_end', 3);
isR(timespan, 'timespan', 4, '+');
isN(num_steps, 'num_steps', 5);

%%

substrate= load_biogas_mat_files(plant_id);
n_substrate= substrate.getNumSubstratesD();

if numel(Q_start) ~= n_substrate || numel(Q_end) ~= n_substrate

  error('Q_start (%i) and Q_end (%i) must have each %i elements!', ...
    numel(Q_start), numel(Q_end), n_substrate);
  
end

%%

dT= timespan / num_steps;

%%

for isubstrate= 1:n_substrate
  
  %%
  
  Q1= Q_start(isubstrate);
  Q2= Q_end(isubstrate);
  dQ= (Q2 - Q1) / num_steps;
  
  %%
  
  substrate_id= char(substrate.getID(isubstrate));
  
  Qs= Q1:dQ:Q2;
  % add Q1 in the beginning to have a constant feed at the beginning
  % add Q2 at the end because it may not exist in Qs, dependent on Q1 and
  % dQ
  Qs= [Q1, Qs, Q2];
  
  %%
  
  createvolumeflowfile('user', [], substrate_id, dT, Qs, [], 'm3_day', accesstofile);
  
  %%
  
end

%%

if do_plots
  plot_volumeflow_files('substrate', 'user', substrate, [], [], accesstofile);
end

%%


