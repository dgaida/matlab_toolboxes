%% loadPlantStructure
% Find specified |plant_*.xml| file in the toolbox's folder 
% <../../../../config_mat |config_mat|> and load it.
%
function [varargout]= loadPlantStructure(plant_id_or_name)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% check input arguments

checkArgument(plant_id_or_name, 'plant_id_or_name', 'cell || char', '1st');

plant_id_or_name= char(plant_id_or_name);


%%

path_config_mat= getConfigPath();

s_dirs= dir(path_config_mat);

path_to_file= [];

for idir= 1:numel(s_dirs)

  if s_dirs(idir,1).isdir && ...
     ~strcmp(s_dirs(idir,1).name(1,1), '.') || ...
      strcmp(s_dirs(idir,1).name, '.')

    %%
    
    s= ls(fullfile( path_config_mat, s_dirs(idir,1).name ));

    ls_cell= [];

    for ii= 1:size(s,1)
      ls_cell= [ls_cell, {s(ii,:)}];
    end

    mat_files= regexp(ls_cell, '\w*.xml', 'match');

    ls_cell= [];

    for ii= 1:size(s,1)
      ls_cell= [ls_cell; {cell2mat(mat_files{:,ii})}];
    end

    mat_files= ls_cell;

    %%
    
    try
      if isempty(cell2mat(mat_files))
        continue;
      end
    catch ME
      % dann sind auch chars gefunden, nich alles empty, also weiter
      % machen
    end


    %%

    for ifile= 1:size(mat_files,1)

      if isempty(cell2mat(mat_files(ifile,1)))
        continue;
      end

      try
        plant= biogas.plant( fullfile( path_config_mat, s_dirs(idir,1).name, ...
                             char( mat_files(ifile,1) ) ) );
      catch ME
        % not valid xml file
        continue;
      end

      if ~strcmp( char(plant.id), '' )

        if strcmp(char(plant.name), plant_id_or_name) || ...
           strcmp(char(plant.id),   plant_id_or_name)

          path_to_file= fullfile( path_config_mat, s_dirs(idir,1).name );

          clear s;

          break;

        else
          clear plant;
        end

      end

      clear s;

    end

    if ~isempty(path_to_file)
      break;
    end

  end
    
end


%%
% set varargout

if nargout >= 1, varargout{1}= plant; else varargout{1}= []; end;
if nargout >= 2, varargout{2}= path_to_file; else varargout{2}= []; end;
if nargout >= 3, varargout{3}= path_config_mat; else varargout{3}= []; end;

%%


