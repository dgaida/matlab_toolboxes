%% install_tool
% Install GECO-C MATLAB toolbox with given name and id.
%
function success= install_tool(tool_name, tool_id, varargin)
%% Release: 1.5

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

success= 0;

%%
% check input args

if ~ischar(tool_name)
  error(['The 1st argument tool_name must be a ', ...
         '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
         '<a href="matlab:doc(''%s'')">%s</a>!'], ...
        class(tool_name), class(tool_name));
end

if ~ischar(tool_id)
  error(['The 2nd argument tool_id must be a ', ...
         '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
         '<a href="matlab:doc(''%s'')">%s</a>!'], ...
        class(tool_id), class(tool_id));
end

if nargin >= 3 && ~isempty(varargin{1})
  silent= varargin{1};
  
  validateattributes(silent, {'double'}, {'scalar', 'nonnegative', 'integer', '<=', 1}, ...
                     mfilename, 'silent', 3);
else
  silent= 0;
end


%%

if ~silent
  answer= questdlg(sprintf(...
      'Do you really want to install the ''%s'' Toolbox?', tool_name), ...
      sprintf('Installer of ''%s'' Toolbox', tool_name));

  if ~strcmp(answer, 'Yes')

    msgbox('Exit Installation. The toolbox was not installed!', ...
           sprintf('Installer of ''%s'' Toolbox', tool_name));

    return;

  end
end

%%
% check if a version of this toolbox is already installed and if the
% already installed version is newer or from the same date

%% 
% würde nur build txt in pwd finden und nicht die in dem ordner wo die
% toolbox evtl. schon installiert ist! müsste so ok sein, aber noch nicht
% getestet
[pathes]= regexp(pwd, filesep, 'split');
cur_dir= pathes{end};

%addpath(pwd, '-end');   % das war ein workaround, damit die funktion 
% getToolboxBuild gefunden werden kann.

cd ..

% Annahme, falls irgendeine version der zu installierenden Toolbox
% existiert, dann wird auch irgendeine version von setup_tool existieren,
% welche getToolboxBuild beinhaltet
if ( exist('getToolboxBuild', 'file') == 2 ) || ...
   ( exist('getToolboxBuild', 'file') == 6 )
  datetime_inst= getToolboxBuild(tool_id);
else
  datetime_inst= [];
end

cd(cur_dir);

%

if ~isempty(datetime_inst)
  datetime_new= getToolboxBuild(tool_id, pwd);
  
  if (datetime_inst >= datetime_new)
    fprintf(['A newer or this version of the toolbox is installed already! ', ...
             'No need to install it!\n']);
    
    return;
  else
    % an older version is installed already, find position in startup.m
    % file
    [start_idx, end_idx, doexist]= exist_in_startup(tool_name);
  end
else
  doexist= 0;
end


%%

fprintf('Start the Installation of the toolbox ''%s''\n', tool_name);

% userpath returns the user directory for MATLAB
startup_filename= [userpath, filesep, 'startup'];

% since userpath is returned with an ending ;, replace ; by ''
startup_filename= strrep(startup_filename, ';', '');



%%
% make a copy of startup.m
% 
if exist([startup_filename '.m'], 'file')
  
  %%
  % make a copy of the original startup.m, if existent
  
  [status,message,messageid]= ...
      copyfile([startup_filename '.m'], ...
               [startup_filename '_copy_' tool_id '.m']);    

  %%
  
  if (status == 1)
    disp(['Successfully saved a copy of startup.m as ', ...
         [startup_filename '_copy_' tool_id '.m']]);
  else
    warning('install:copyStartup', ['Could not create a copy of startup.m. ', ...
            'Installation failed. Please make sure that you have Administrator rights ', ...
            'on the computer and that you have started MATLAB as Administrator. ', ...
            'Got the message:']);
           
    error(messageid, message);
  end
  
else
  disp(['The file ', [startup_filename, '.m'], ...
        ' does not exist at the moment. We create it!']);
end



%% 
% create a folder for the toolbox in the matlab toolbox folder
%
%% TODO
% Es kann unter Windows 7 passieren, dass dieser Ordner nicht erstellt
% werden kann oder dass es zumindest eine Warnung gibt, dass dieser Ordner
% nicht erstellt werden kann, aber evtl. trotzdem erstellt wird -> könnte
% was mit Administrationsrechten zu tun haben
%
pathtofolder= fullfile(matlabroot, 'toolbox', tool_id, filesep);

%% TODO
% txt Dateien welche hier bei der Installation erstellt werden, in pwd
% schreiben und nicht in matlab toolbox pfad. pwd heißt in
% mTools/biogas_control um ein bsp. zu nennen. 
%% 
% ich mache das nicht mit allen txt dateien, da bei einer aktualisierung
% der toolbox, die mtools ordner ausgetauscht werden und damit diese txt
% dateien verloren gehen würden. in matlab pfad muss man dann nur manuell
% eine txt datei editieren

try 
    
  %%
  
  [status, message, messageid]= mkdir(pathtofolder);

  if status == 0
    warning('install:failure', ...
           ['The library ''%s'' was NOT ', ...
            'successfully installed. Please try to create the folder ''%s'' manually.', ...
            ' Otherwise please contact the developer.'], ...
           tool_name, pathtofolder);
          
    error(messageid, message);
  end

catch ME

  %%
  
  warning('install:failure', ...
         ['The library ''%s'' was NOT ', ...
          'successfully installed. Please try to create the folder ''%s'' manually.', ...
            ' Otherwise please contact the developer.'], ...
          tool_name, pathtofolder);

  rethrow(ME);

end



%%
% in this file all paths of the installed versions are written
[installed_v_file, message]= ...
    fopen([pathtofolder 'installed_versions.txt'], 'a');

if installed_v_file == -1
  errordlg(['Installation failed. Could not open the file ', ...
           [pathtofolder 'installed_versions.txt. '], ...
           'Got the message: ', message]);
  %error(message);
end

fprintf(installed_v_file, '%s\r\n', pwd);

status= fclose(installed_v_file);

if status == 0
  disp(['Successfully written to file ', ...
        [pathtofolder 'installed_versions.txt']]);
else
  errordlg(['Installation failed. Could not close the file ', ...
           [pathtofolder 'installed_versions.txt']]);
end



%%
% in this file the to be started library version is written
[start_v_file, message]= fopen([pathtofolder, 'start_version.txt'], 'w');

if start_v_file == -1
  errordlg(['Installation failed. Could not open the file ', ...
           [pathtofolder 'start_version.txt. '], ...
           'Got the message: ', message]);
  %error(message);
end

fprintf(start_v_file, '%s\r\n', pwd);

status= fclose(start_v_file);

if status == 0
  disp(['Successfully written to file ', ...
        [pathtofolder 'start_version.txt']]);
else
  errordlg(['Installation failed. Could not close the file ', ...
         [pathtofolder 'start_version.txt']]);
end



%% 
% open startup.m for appending text, if it does not exist, then it is
% created here
%
% It is important that we write into the startup.m last, because if this
% function crashes after writing to the startup.m the startup.m may be
% corrupt.
%
[startup_file, message]= fopen([startup_filename '.m'], 'a');

if startup_file == -1
  errordlg(['Installation failed. Could not open the file ', ...
           [startup_filename '.m. '], 'Got the message: ', message]);
  %error(message);
else
  disp(['Successfully opened (created) the file ', ...
       [startup_filename '.m'], ' for writing.']);
end

if ~doexist     % if not yet exist entry in startup.m
  
  %%
  % write into the file
  fprintf(startup_file, ...
      ['\n\n%%*** The following code was created by the ', ...
       'toolbox \''', tool_name, '\'' ***']);

  % wenn man eine exe erstellt mit matlab compiler, dann wird die startup.m
  % integriert. das bringt pfadprobleme mit sich, deshalb nur wenn nicht
  % isdeployed den pfad hinzufügen
  fprintf(startup_file, '\n\nif ~isdeployed');

  fprintf(startup_file, ...
      '\n\nstart_v_file= fopen([''%s'', ''start_version.txt''], ''r'');', ...
      pathtofolder);

  % set the path to the toolbox, that is the current working directory
  fprintf(startup_file, '\n\ntool_path= fgetl(start_v_file);');

  fprintf(startup_file, '\n\nfclose(start_v_file);');

  fprintf(startup_file, '\n\npath(path, [tool_path, ''\\'']);');

  % write a function call, which will set the toolbox path at each MATLAB
  % startup
  fprintf(startup_file, ...
      ['\n\nsetpath_', tool_id, '(tool_path, @addpath);']);

  fprintf(startup_file, '\n\nclear start_v_file;');

  fprintf(startup_file, '\n\nend'); % end von if ~isdeployed
  
  fprintf(startup_file, ['\n\n%%*** \''', tool_name, '\'' ***\n\n']);

else
  
  %% TODO
  % die zeile 
  %
  % start_v_file= fopen(['L:\MATLAB\R2011b\toolbox\setup_tool\', 'start_version.txt'], 'r');
  %
  % muss noch ersetzt werden durch neuen Pfad. wäre mit file2cell und
  % cell2file einfach, liegen allerdings in io_tool.
  % allerdings wäre für mich die ersetzung doof, da bei der erstellung
  % eines tools, dann in der startup.m andauernd der pfad geändert würde,
  % den ich dann wieder zurück setzen muss.
  % -> stimmt so nicht, da erst bei publish toolbox der eintrag in
  % startup.m erstellt wird und gepublished wird das tool im endgültigen
  % pfad
  % also noch nicht klar was ich hier am besten mache
  
end

%%

% close the file
status= fclose(startup_file);

if status == 0
  disp(['Successfully written to file ', ...
        [startup_filename '.m']]);
else
  errordlg(['Installation failed. Could not close the file ', ...
         [startup_filename '.m']]);
end



%%

% to avoid a new start of MATLAB set the path now
tool_path= pwd;

%[fileIDpath, message]= fopen(fullfile(pathtofolder, 'path_install.txt'), 'w');
[fileIDpath, message]= fopen(fullfile(tool_path, 'path_install.txt'), 'w');

if fileIDpath == -1
  errordlg(['Installation failed. Could not open the file ', ...
           [tool_path 'path_install.txt. '], ...
           'Got the message: ', message]);
end

feval(sprintf('setpath_%s', tool_id), tool_path, @addpath, fileIDpath, 0);

status= fclose(fileIDpath);

if status == 0
  disp(['Successfully written to file ', ...
        [pathtofolder 'path_install.txt']]);
else
  errordlg(['Installation failed. Could not close the file ', ...
         [pathtofolder 'path_install.txt']]);
end

% optional kann man den Pfad mit 'savepath' auch speichern, dann müsste man
% nicht in die startup.m rein schreiben, aber vielleicht ist das nicht so
% gerne gesehen (vielleicht benötigt der Nutzer dafür auch Admin-Rechte?)

%disp('The toolbox ''Biogas Plant Modeling'' was successfully installed.')

if ~silent
  msgbox(sprintf('The ''%s'' Toolbox was successfully installed.', tool_name), ...
         'Installation completed!');
end

success= 1;

%%


