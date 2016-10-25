%% publish_toolbox
% Publishes the toolbox.
%
function publish_toolbox(toolbox)
%% Release: 1.3

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox, 'toolbox', 'gecoc_tool', '1st');

%%

diary on;

%%

global PUBLISH_FLAG;

PUBLISH_FLAG= 1;

global IS_DEBUG;      % is used by checkArgument, and is_... methods

IS_DEBUG= 1;

%%

base_path= toolbox.getToolboxPath();

help_path= toolbox.getHelpPath();

html_subfolder= toolbox.getHTMLsubfolder();

help_path_doc_tool= fullfile( doc_tool.getToolboxPath(), 'scripts', ...
                              'help', 'doc_tool', 'doc_creation_files' );


%%

rel_path_m= getToolboxFolderStructure(base_path);


%%

options_html_nocode.format= 'html';
options_html_nocode.showCode= false;
options_html_nocode.evalCode= false;
options_html_nocode.stylesheet= fullfile(help_path_doc_tool, 'publish2html_style.xsl');             
                         

%% 
% go through all html folders and delete html and png files

%%

if isempty(html_subfolder)
  fileList= getAllFiles( fullfile(help_path, 'toolbox') ); % for biogas tool
else
  fileList= getAllFiles( fullfile(help_path, html_subfolder) );
end

test=  cellfun(@(x) ~isempty( regexp(x, '\w*\.html', 'once')), fileList );
HTML_Files= fileList( test );

for ifile= 1:numel(HTML_Files)
  delete( HTML_Files{ifile,1} );
end

test=  cellfun(@(x) ~isempty( regexp(x, '\w*\.png', 'once')), fileList );
PNG_Files= fileList( test );

for ifile= 1:numel(PNG_Files)
  delete( PNG_Files{ifile,1} );
end

%%

find_entry= @(tocfile, entry) find(~cellfun('isempty', strfind(tocfile, entry)));
  
%%

for ipath= 1:numel(rel_path_m)

  path_m= fullfile(base_path, rel_path_m{ipath});
  
  %%
  % read publish_location.txt to get html path
  
  rel_path_html= getPublicationLocation(path_m);
  
  if isempty(rel_path_html)
    continue;
  end
  
  %%
  
  cell_pub_loc= file2cell(fullfile(path_m, 'publish_location.txt'));
  
  
  %%
  
  Files= dir( fullfile(path_m, '*.m') );

  %%

  for ifile= 1:size(Files,1)

    file_path= char(Files(ifile,1).name);

    filename_split= regexp(file_path, filesep, 'split');

    filename= char(filename_split(end));

    %%

    options_html_nocode.codeToEvaluate= [];

    %% TODO
    % einen schalter einführen, welcher unterscheidet zwischen komplette
    % doku machen oder nur auf die schnelle
    
    if strcmp(rel_path_m{ipath}, 'examples\m_files') %|| ...
       %strcmp(rel_path_m{ipath}, 'biogas\m_files\src\numerics\conRandMatrix') || ...
       %strcmp(filename, 'plot4Dscatterdata_doc.m')
                  
      continue;
      
    end
    
    %%
    
    if ~isempty(regexp(filename, '_doc.m', 'once')) || ...
        (checkIfFunction(filename) == 0) || ... % it is a script, not a function
       strcmp(rel_path_m{ipath}, 'blocks\ad_models\gui') || ...
       strcmp(rel_path_m{ipath}, 'examples\m_files') || ...
       strcmp(rel_path_m{ipath}, 'gui') || ...
       strcmp(rel_path_m{ipath}, 'gui\optimization\nmpc') || ...
       strcmp(rel_path_m{ipath}, 'gui\optimization\optimization') || ...
       strcmp(rel_path_m{ipath}, 'gui\optimization\stream') || ...
       strcmp(rel_path_m{ipath}, 'gui\plant') || ...
       strcmp(rel_path_m{ipath}, 'gui\plant_network') || ...
       strcmp(rel_path_m{ipath}, 'gui\substrate') || ...
       strcmp(rel_path_m{ipath}, 'gui\substrate_network') || ...
       strcmp(rel_path_m{ipath}, 'gui\stream') || ...
       strcmp(rel_path_m{ipath}, 'biogas\m_files\getting_started') || ...
       strcmp(rel_path_m{ipath}, 'biogas\m_files\user_guide')

      options_html_nocode.evalCode= true;

    else

      options_html_nocode.evalCode= false;

    end
    
    %%
    % show examples in html of doc files
     
    if ~isempty(regexp(filename, '_doc.m', 'once')) || ...
        (checkIfFunction(filename) == 0) || ... % it is a script, not a function
       strcmp(rel_path_m{ipath}, 'biogas\m_files\getting_started') || ...
       strcmp(rel_path_m{ipath}, 'biogas\m_files\user_guide') || ...
       strcmp(rel_path_m{ipath}, 'examples\m_files')
      
      options_html_nocode.showCode= true;
      
    else
      
      options_html_nocode.showCode= false;

    end

    %%
    
    % only publish if filename is not listed as exception
    % and if there does not exist a _doc file to a script file
    if isempty( find_entry(cell_pub_loc, filename) ) && ...
       ~( isempty(regexp(filename, '_doc.m', 'once')) && ...
          exist(getDocFileOfFunction(filename), 'file') )

     if ~strcmp(filename, 'plot3d4d.m') && ...
        ~strcmp(filename, 'p_adm1xp_main.m') && ...
        ~strcmp(filename, 'Contents.m') && ...
        ~strcmp(filename, 'plot_initstate.m')

      options_html_nocode.outputDir= fullfile(help_path, rel_path_html);

      %%
      
      %disp(fullfile(path_m, filename));

      %%
      
      if ~isempty(regexp(filename, '_doc.m', 'once'))
        
        html_file= strrep(filename, '_doc.m', '.html');
      
      else
        
        html_file= strrep(filename, '.m', '.html');
        
      end
      
      %%
      
      html_link= fullfile(rel_path_html, html_file);
      
      xml_file= 'helpfuncbycat.xml';
      
      if ~exist(fullfile(path_m, 'NOTinXML.txt'), 'file')
        
        try
          checkIfInXMLfile(toolbox, xml_file, lower(html_link));
        catch ME1

          xml_file= 'helpblockbycat.xml';

          try
            checkIfInXMLfile(toolbox, xml_file, lower(html_link));
          catch ME
            ME= ME.addCause(ME1);
            warning('publish_toolbox:XMLfile', ME.message);
            %disp('OK: ignore warning, found it in helpblockbycat!');
          end

        end
        
      end
      
      %%
      
      %if (  )
      
        %%

        %% 
        % datei fullfile(path_m, filename) öffnen
        % und am anfang kurzbeschreibung und toolboxinfo rein schreiben
        % nutze: file2cell, getHeaderLinesOfMFile, so ähnliches wie
        % replaceToolboxTagByText
        %
        % ersetze %% <<AuthorTag_DG/>> und andere
        % mit replaceToolboxTagByText
        %
        if ~isempty(regexp(filename, '_doc.m', 'once'))
          
          mfile= fullfile(path_m, filename);
          
          %%
          % make a copy of the doc file, needed for biogas toolbox, because
          % here the original doc files are overwritten
          
          copyfile(mfile, [mfile, '_copy']);
          
          
          %%
          
          myfile= file2cell(mfile);
          
          headerlines= getHeaderLinesOfMFile(mfile);
  
          headerlines_split= regexp(headerlines, '\n', 'split');
          
          headerlines_split= [headerlines_split, {'%% Toolbox'}, ...
               {sprintf('%% |%s| belongs to _%s_ Toolbox.', ...
                getHeaderOfMFile(mfile), toolbox.getToolboxName())}, {'%'}, ...
                {'%% Release'}, {['% Approved for Release ', ...
                getReleaseVersionOfMfile( mfile )]}, ...
                {'%'}];
          
          myfile= [headerlines_split, myfile];
          
          %%
          
          try
            cell2file(mfile, myfile);
          catch ME
            disp(ME.message)
          end
          
          %% 
          
          try
            replaceToolboxTagByText(mfile);
          catch ME
            disp(ME.message);
          end
          
          %%
          
        end
        
        %%
        
        try
          current_path= pwd;
          
          cd(path_m);
          
          publish(fullfile(path_m, filename), options_html_nocode);
          
          cd(current_path);
        catch ME
          disp(fullfile(path_m, filename));
          %rethrow(ME);
          disp(ME.message);
          
          continue;
        end
        
        %% 
        % rename html file to lowercase, needed for "doc ..."
        
        if ~isempty(regexp(filename, '_doc.m', 'once'))
        
          %%
          
          movefile(fullfile(help_path, ...
                         rel_path_html, strrep(filename, '.m', '.html')), ... 
             lower(fullfile(help_path, ...
                         rel_path_html, html_file)) ...
                  );
          
          %%
          % copy the doc file back, needed for biogas toolbox, because
          % here the original doc files are overwritten
          
          movefile([mfile, '_copy'], mfile);
          
          
        else
            
          %%
          
          movefile(fullfile(help_path, ...
                         rel_path_html, html_file), ... 
             lower(fullfile(help_path, ...
                         rel_path_html, strrep(filename, '.m', '.htmlx'))) ...
                  );

          movefile(lower(fullfile(help_path, ...
                         rel_path_html, strrep(filename, '.m', '.htmlx'))), ...
                   lower(fullfile(help_path, ...
                         rel_path_html, html_file)));             
           
        end
        
      %else
      
        %disp('Do not publish, because of invalid links!');
        
      %end
      
      %%
      % close open guis
      close all;
      close all force;

     end
    
    end

  end
    
end

%%

% close open guis
close all force;


%%

getToolboxDevelopmentStatus(toolbox);


%%

for ipath= 1:numel(rel_path_m)

  path_m= fullfile(base_path, rel_path_m{ipath});
  
  %% TODO
  % in the future only check '_doc.m' files, dann umstellen wenn doku für
  % alle skripts in _doc.m files steht
  Files= dir( fullfile(path_m, '*.m') );
  % funktioniert so, ist schon getestet, findet nur _doc.m files
  %Files= dir( fullfile(path_m, '*_doc.m') );

  %%

  for ifile= 1:size(Files,1)
    
    file_path= char(Files(ifile,1).name);

    filename_split= regexp(file_path, filesep, 'split');

    filename= char(filename_split(end));
    
    %%
    
    % if this file is not a doc file and if there is a doc file to this
    % one, then do not check link in m file
    if ~( isempty(regexp(filename, '_doc.m', 'once')) && ...
          exist(getDocFileOfFunction(fullfile(path_m, filename)), 'file') )
    
      checkLinksInMfile( toolbox, fullfile(path_m, filename) );

    end
    
    %% TODO
    % ganz irgendwann in der Zukunft, löschen der _doc.m files in den release
    % versionen. bringt nur nichts, wenn man vorher noch links in diesen
    % dateien prüfte und diese dann löscht...

    if ~isempty(regexp(filename, '_doc.m', 'once')) && ...
       ~isempty(html_subfolder)

      %% für BIOGAS TOOLBOX IST DAS TÖDLICH!!!
      delete( fullfile(path_m, filename) );
      
    end

  end
    
end



%%
% create html help files (lists)

cd( help_path );

%%

if exist('helpblockbycat.xml', 'file') == 2
  
  path_xsl= fullfile( help_path_doc_tool, 'helpblockbycat.xsl' );
  
  xslt('helpblockbycat.xml', path_xsl, 'block_reference_category.html');

  path_xsl= fullfile( help_path_doc_tool, 'helpblockbycat_alpha.xsl' );
  
  xslt('helpblockbycat.xml', path_xsl, 'block_reference_alpha.html');
  
end

%%

path_xsl= fullfile( help_path_doc_tool, 'helpfuncbycat.xsl' );
  
xslt('helpfuncbycat.xml', path_xsl, fullfile(html_subfolder, 'function_reference_category.html'));

%% TODO
% test löschen am Ende

path_xsl= fullfile( help_path_doc_tool, 'helpfuncbycat_alpha.xsl' );

xslt('helpfuncbycat.xml', path_xsl, fullfile(html_subfolder, 'function_reference_alpha_test.html'));


%%

try
  make_helptoc(toolbox);
catch ME
  disp(ME.message)
end

%%

%getToolboxDevelopmentStatus(toolbox);

%%

checkLinksInXMLfile(toolbox, 'helpfuncbycat.xml');


if exist(fullfile(help_path, 'helpblockbycat.xml'), 'file') == 2
  checkLinksInXMLfile(toolbox, 'helpblockbycat.xml');
end


copyfile(fullfile(help_path, 'helpfuncbycat.xml'), ...
         fullfile(help_path, 'html', 'helpfuncbycat.xml'));

%%

create_product_page(toolbox);


%%
% create index

cd(base_path);

%%

try
  builddocsearchdb( fullfile(help_path, html_subfolder) );
catch ME
  disp(ME.message);
end

if ~isempty(html_subfolder)
  
  if exist(fullfile(help_path, 'helpsearch'), 'dir') == 7
    try
      rmdir(fullfile(help_path, 'helpsearch'), 's');
    catch ME
      disp(ME.message);
    end
  end

  copyfile(fullfile(help_path, html_subfolder, 'helpsearch'), ...
           fullfile(help_path, 'helpsearch'));
         
end
       
%% TODO

cd('L:\Java\jdk1.7.0_05\bin')

if isempty(html_subfolder)

  if exist(fullfile(help_path, 'help.jar'), 'file')
    try
      delete(fullfile(help_path, 'help.jar'));
    catch ME
      warning('delete:helpjar', 'Could not delete help.jar!')
      disp(ME.message)
    end
  end
  
  for ii= 1:2
    
    system(['jar -cf ' fullfile(base_path, 'help.jar') ...
                ' -C ' fullfile(help_path, html_subfolder) ' .']);

    movefile(fullfile(base_path, 'help.jar'), ...
             fullfile(help_path, 'help.jar'));

  end
  
else
  
  system(['jar -cf ' fullfile(help_path, 'help.jar') ...
              ' -C ' fullfile(help_path, html_subfolder) ' .']);
  
end

%%

cd(base_path);

%%
% remove folders help_mfiles and toolbox_id_doc

try
  [status, message, messageid]= rmdir(fullfile(base_path, 'scripts', 'help_mfiles'), 's');
  
  disp(message);
catch ME
  
  rethrow(ME);
end

try
  [status, message, messageid]= ...
    rmdir(fullfile(base_path, 'scripts', 'tool', [toolbox.getToolboxID(), '_doc']), 's');
  
  disp(message);
catch ME
  
  rethrow(ME);
end

%%
% write file path_install.txt again, because of the folders deleted above

write2path_install_txt(base_path, @addpath, 0, 1);

%%

diary off;

%%


