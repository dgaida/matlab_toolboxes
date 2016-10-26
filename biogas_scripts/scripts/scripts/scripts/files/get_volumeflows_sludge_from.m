%% get_volumeflows_sludge_from
% Get sludge volumeflows from file or workspace
%
function volumeflows= get_volumeflows_sludge_from(plant, plant_network, ...
                          plant_network_max, vol_type, varargin)
%% Release: 1.4

%%

error( nargchk(4, 6, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 5 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  isZ(accesstofile, 'accesstofile', 5, 0, 1);
else
  accesstofile= 1; 
end

if nargin >= 6 && ~isempty(varargin{2})
  mypath= varargin{2};
  checkArgument(mypath, 'mypath', 'char', 6);
else
  mypath= pwd;
end

%%
% check arguments

is_plant(plant, 1);
is_plant_network(plant_network, 2, plant);
is_plant_network(plant_network_max, 3, plant);
is_volumeflow_type(vol_type, 4);

%% 
% für plant "digester" code hinzufügen

[nSplits, digester_splits]= ...
     getNumDigesterSplits(plant_network, ...
                          plant_network_max, plant);

%%

for isplit= 1:nSplits

  filename= ['volumeflow_', digester_splits{isplit}, '_', vol_type];
  varname=  digester_splits{isplit};
  
  %%

  if accesstofile == 1
    % load from file
    try

      %%

      filename_full= fullfile(mypath, [filename, '.mat']);

      %%

      if exist(filename_full, 'file')

        s= load(filename_full);

        % get volumeflow
        volumeflows.(varname)= s.(filename);

        clear s;

      else

        volumeflows.(varname)= [];

      end

    catch ME
      rethrow(ME);
    end

  else
    % load from workspace
    % get volumeflow
    volumeflows.(varname)= evalin('base', filename);
    
  end
  
  %%

end

%%


