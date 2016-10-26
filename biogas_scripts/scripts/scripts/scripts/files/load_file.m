%% load_file
% Load the MAT-file |filename| in a try catch block.
%
function varargout= load_file(filename, varargin)
%% Release: 1.8

%%

error( nargchk(1, 4, nargin, 'struct') );
error( nargoutchk(0, nargout, nargout, 'struct') );

%% 
% read out varargin

if nargin >= 2 && ~isempty(varargin{1}), 
  warning_msg= varargin{1}; 
  
  checkArgument(warning_msg, 'warning_msg', 'char', '2nd');
else
  warning_msg= ''; 
end

if nargin >= 3 && ~isempty(varargin{2}), 
  setting= varargin{2};
  
  checkArgument(setting, 'setting', 'char', '3rd');
else
  setting= [];
end

if nargin >= 4 && ~isempty(varargin{3}), 
  file_extension= varargin{3};
  
  checkArgument(file_extension, 'file_extension', 'char', 4);
else
  file_extension= 'mat';
end


%%
% bei dem dateinamen
% filename= 'has.e.mat.mat' werden beide .mat gelöscht nicht nur das letzte

filename_s= regexp(filename, ['\.', file_extension], 'split');
filename= char(filename_s(1));
    

%% 
% load MAT-file

%s= struct;

try
  if ~isempty(setting)
    %% 
    % generate path to file
    searchfile= fullfile(pwd, setting, [filename, '.', file_extension]);

    if exist(searchfile, 'file')
      s= load (searchfile);
    else % file in the path does not exist
      %%
      % if setting contains .., then the call of exist above does not work,
      % so we better change in the path in which the file should be and see
      % if it is there, later doo not forget to return in the current_path
      % again.
      current_path= pwd;
      
      try
        cd( fullfile(getBiogasLibPath(), setting) );
      catch ME
        
      end
      
      if exist([filename, '.', file_extension], 'file')
        s= load ([filename, '.', file_extension]);
        
        cd(current_path);
      else
        cd(current_path);
        
        
        %%
        % see if file exist anywhere in the path
        if exist([filename, '.', file_extension], 'file') 
          s= load ([filename, '.', file_extension]);
        else
          %%
          % load file from config_mat folder

          searchfile= fullfile( getConfigPath(), ...
                                setting, [filename, '.', file_extension] );

          s= load (searchfile);
        end
        
      end
      
    end
  else
    %%
    % load file anywhere from path
    
    s= load ([filename, '.', file_extension]);
  end
catch ME
  warning('MATLAB:load:couldNotReadFile', ...
          ['The file ', ['%s', '.', file_extension], ...
          ' does not exist. ', warning_msg], filename);

  rethrow(ME);
end


field= fieldnames(s);


%% 
% set return values

varargout= cell(nargout, 1);

for iOutput= 1:size(field,1)

  if nargout >= iOutput, varargout{iOutput}= s.(field{iOutput}); end

end

% if there are more return values then variables in the struct
for iOutput= size(field,1) + 1:nargout

  varargout{iOutput}= [];

end

%%


