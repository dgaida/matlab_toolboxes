%% findExistingPlants
% Find existing 'plant_*.xml' files in the toolbox's folder |config_mat|.
%
function [varargout]= findExistingPlants(varargin)
%% Release: 1.5

%%

error( nargchk(0, 3, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% read out varargin

if nargin >= 1 && ~isempty(varargin{1})
  plant_ids= varargin{1}; 
  
  checkArgument(plant_ids, 'plant_ids', 'cellstr', '1st');
else
  plant_ids= [];
end

if nargin >= 2 && ~isempty(varargin{2})
  plant_names= varargin{2};
  
  checkArgument(plant_names, 'plant_names', 'cellstr', '2nd');
else
  plant_names= []; 
end

% falls der Pfad zu einer bestimmten Datei zurückgegeben werden soll, dann
% wird der über diese variable spezifiziert. erste gefundene plant datei
% hat index 1
if nargin >= 3 && ~isempty(varargin{3})
  p_index= varargin{3};
  
  isN(p_index, 'p_index', 3);
else
  p_index= []; 
end

plant_ids= plant_ids(:);
plant_names= plant_names(:);


%%
% find the config_mat folder 

path_config_mat= getConfigPath();

s_dirs= dir(path_config_mat);

ip_index= 0;
path_to_file= [];

%%
%
for idir= 1:numel(s_dirs)

  if s_dirs(idir,1).isdir && ...
     ~strcmp(s_dirs(idir,1).name(1,1), '.') || ... % svn ordner
      strcmp(s_dirs(idir,1).name, '.')             % current folder

    %%
    
    s= ls(fullfile( path_config_mat, s_dirs(idir,1).name ));

    ls_cell= cell(size(s,1), 1);

    for ii= 1:size(s,1)
      ls_cell{ii}= s(ii,:);
    end

    xml_files= regexp(ls_cell, '\w*.xml', 'match');

    %%
    
    ls_cell= cell(size(s,1), 1);

    for ii= 1:size(s,1)
      ls_cell{ii}= cell2mat(xml_files{ii});
    end

    xml_files= ls_cell;

    %%
    
    try
      if isempty(cell2mat(xml_files))
        continue;
      end
    catch ME
      % dann sind auch chars gefunden, nich alles empty, also weiter
      % machen
    end

    %%

    for ifile= 1:size(xml_files,1)

      if isempty(cell2mat(xml_files(ifile,1)))
        continue;
      end

      try
        plant= biogas.plant( fullfile( path_config_mat, s_dirs(idir,1).name, ...
                             char( xml_files(ifile,1) ) ) );
      catch ME
        % not valid xml file
        continue;
      end

      %%
      
      if ~strcmp( char(plant.id), '' )

        ip_index= ip_index + 1;

        if ~isempty(p_index) && ip_index == p_index
          path_to_file= ...
                fullfile( path_config_mat, s_dirs(idir,1).name );
        end

        plant_ids= [plant_ids; {char(plant.id)}];
        plant_names= [plant_names; {char(plant.name)}];
        
        clear plant;

      end

    end % end for

    clear s;
    
  end % end if
    
end % end for


%%
% set varargout

if nargout >= 1, varargout{1}= plant_ids; else varargout{1}= []; end;
if nargout >= 2, varargout{2}= plant_names; else varargout{2}= []; end;
if nargout >= 3, varargout{3}= path_config_mat; else varargout{3}= []; end;
if nargout >= 4, varargout{4}= path_to_file; else varargout{4}= []; end;

%%


