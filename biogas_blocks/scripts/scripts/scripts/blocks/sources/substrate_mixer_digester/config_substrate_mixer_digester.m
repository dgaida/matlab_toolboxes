%% config_substrate_mixer_digester
% Creates/deletes GoTo blocks inside Substrate Mixer (Digester) as many as
% needed
%
function config_substrate_mixer_digester(substrate, plant, varargin)
%% Release: 1.3

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 3 && ~isempty(varargin{1}), 
  DEBUG_DISP= varargin{1}; 
  is0or1(DEBUG_DISP, 'DEBUG_DISP', 3);
else
  DEBUG_DISP= 0; 
end

%% 
% check input params

is_substrate(substrate, 1);
is_plant(plant, 2);

%%

this_block= gcb;

n_fermenter= plant.getNumDigestersD();

% the number of outputs is contrained up number of fermenters

%% TODO 
% funktioniert so nicht, bei einer neuen Anlage mit weniger
% Fermentern als bei einer alten werden die Blöcke nicht gelöscht...
% sollte ok sein, unten werden blöcke hinzugefügt
for i_output= n_fermenter + 1:n_fermenter + 100

  %fermenter_name= char(plant.fermenter.ids(1,i_output));

  try
    % find output blocks which are to much
    % this is a goto block
    sys_output= char ( find_system(this_block, 'LookUnderMasks', 'all', ...
        'FollowLinks', 'on', 'Name', sprintf('Substrate Mix %i', i_output)) );
  catch ME
    disp(ME.message);
    rethrow(ME);
  end

  if isempty(sys_output)
    break;
  else

    try
      % delete line between input and the output port of the Demux
      delete_line(this_block, sprintf('Demux/%i', i_output), ...
                          sprintf('Substrate Mix %i/1', i_output));
    catch ME
      disp(ME.message);
      rethrow(ME);
    end

    try
      % delete output block
      delete_block(sys_output);
    catch ME
      disp(ME.message);
      rethrow(ME);
    end
    
  end
    
end



%% TODO 
% delete weitere Blöcke
%if n_fermenter > size(sys_outputs, 1)

    
    
%end


%%

if (DEBUG_DISP)
  disp(['Successfully deleted all blocks in ', mfilename, ' in block ', gcb]);
end

%%
% init pos1

pos1= [0, 0, 100, 50];

%% 
% set number of outputs of demux

sys_demux= char ( find_system(this_block, 'LookUnderMasks', 'all', ...
      'FollowLinks', 'on', 'Name', 'Demux') );

%%

try
  set_param(sys_demux, 'Outputs', sprintf('%i', n_fermenter));
catch ME
  disp(ME.message);
  rethrow(ME);
end


%%

% add outputs, if there are to few
for i_output= 1:n_fermenter

  %%
  %fermenter_name= char(plant.fermenter.ids(1,i_output));

  sys_output= char ( find_system(this_block, 'LookUnderMasks', 'all', ...
      'FollowLinks', 'on', 'Name', sprintf('Substrate Mix %i', i_output) ) );

  %%
  
  if isempty(sys_output)

    add_block('built-in/Goto', ...
              sprintf('%s/Substrate Mix %i', this_block, i_output), ...
              'Position', pos1 + [0 50*(i_output - 1) 0 50*(i_output - 1)]);

  else

    % get Position of 1st block
    if i_output == 1
      pos1= get_param(sys_output,'Position');
    end

  end

  %%
  
  try
    set_param(sprintf('%s/Substrate Mix %i', this_block, i_output), ...
              'TagVisibility', 'global');

    set_param(sprintf('%s/Substrate Mix %i', this_block, i_output), ...
              'GotoTag', char(plant.getDigesterID(i_output)));
  catch ME
    disp(ME.message);
    rethrow(ME);
  end
  
  %%
  
  lineHandles= get_param([this_block, ...
                        sprintf('/Substrate Mix %i', i_output)], 'LineHandles');

  %%
  
  if (lineHandles.Inport(1)) == - 1   % nicht verbunden

    try

      add_line(this_block, sprintf('Demux/%i', i_output), ...
            sprintf('Substrate Mix %i/1', i_output), 'autorouting','on');

    catch ME
      warning('add_line:error', 'Could not add line.');
      disp(ME.message);
      rethrow(ME);
    end

  end
    
end

%%

if (DEBUG_DISP)
  disp(['Successfully ran ', mfilename, ' for block ', gcb]);
end

%%


