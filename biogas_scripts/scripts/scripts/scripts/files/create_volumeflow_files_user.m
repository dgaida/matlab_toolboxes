%% create_volumeflow_files_user
% Create volumeflow user mat files
%
function create_volumeflow_files_user(plant_id, time, Q)
%% Release: 1.3

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

is_plant_id(plant_id, '1st');
isRn(time, 'time', 2);
isRnm(Q, 'Q', 3);

%%

substrate= load_biogas_mat_files(plant_id, [], {'substrate'});

n_substrates= substrate.getNumSubstratesD();

%%

if size(Q, 2) ~= n_substrates
  error('Number of columns of Q must be %i, but is %i!', n_substrates, size(Q, 2));
end

if size(Q,1) ~= 1/2*numel(time)
  error('There must be for each value in Q two values in time!');
end

%%

for isubstrate= 1:n_substrates

  %%
  
  substrate_id= char(substrate.getID(isubstrate));
  
  myQ= Q(:,isubstrate)';
  
  % for each value in Q there exist two values in time. start and end time
  % of Q. 
  myQ= repmat(myQ, 2, 1);
  myQ= myQ(:)';
  
  %%
  
  volflow= [time(:)'; myQ];
  
  save_varname(volflow, sprintf('volumeflow_%s_user', substrate_id));
  
  %%
  
end

%%



%%


