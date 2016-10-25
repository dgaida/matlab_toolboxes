%% make_release_notes
% Create the release notes folders and files for the given toolbox
%
function make_release_notes(path_doc_tool, toolbox_path)
%% Release: 1.1

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

checkArgument(path_doc_tool, 'path_doc_tool', 'char', '1st');
checkArgument(toolbox_path, 'toolbox_path', 'char', '2nd');


%%

find_entry= @(m_file, entry) find(~cellfun('isempty', strfind(m_file, entry)));

%%

path_rn_tool= getPathToReleaseNotes(toolbox_path);
path_rn_template_doc= fullfile(path_doc_tool, 'templates_doc', ...
                               'scripts', 'help_mfiles', 'rn');
path_rn_template= fullfile(path_doc_tool, 'templates', ...
                               'scripts', 'help_mfiles', 'rn');

%%

r_folders= getAllSubfolders(path_rn_tool, 'rel');

%% TODO
% this is temporary, because it is assumed, that r_folders is sorted like 
% 1.0, 1.1, ...
% but is sorted the other way round, so flip it
%

r_folders= flipud(r_folders);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% MAKE release_notes.m

rn_template= file2cell(fullfile(path_rn_template_doc, 'release_notes_template.m'));

%%

release_notes= [];

%%

for iversion= numel(r_folders):-1:1
  
  s_version= strrep(r_folders{iversion}, filesep, '');
  
  s_version_= strrep(s_version, '.', '_');
  
  release_notes= [release_notes, make_tr_releasenote(s_version, s_version_, ...
                  iversion == numel(r_folders))];
  
end

%%

rn_template= replace_entry(rn_template, release_notes, ...
                           find_entry(rn_template, '<<INSERT RELEASE NOTES/>>'));
                 
%%

if ~exist(path_rn_template, 'dir')
  mkdir(path_rn_template);
end

cell2file(fullfile(path_rn_template, 'release_notes.m'), rn_template);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%
% MAKE bugreport and details for each version

rn_bug_template= file2cell(fullfile(path_rn_template_doc, '0.1', 'rn_bugreport_v0_1.m'));
rn_det_template= file2cell(fullfile(path_rn_template_doc, '0.1', 'rn_details_v0_1.m'));

for iversion= numel(r_folders):-1:1
  
  %%
  
  s_version= strrep(r_folders{iversion}, filesep, '');
  
  s_version_= strrep(s_version, '.', '_');
              
  %%
  
  rn_bugreport= file2cell(fullfile(path_rn_tool, s_version, ...
                sprintf('rn_bugreport_v%s.m', s_version_)));
  
  rn_bugreport= [rn_bug_template, rn_bugreport];     
  
  %%
  
  rn_details= file2cell(fullfile(path_rn_tool, s_version, ...
              sprintf('rn_details_v%s.m', s_version_)));
  
  rn_details= [rn_det_template, rn_details];   
  
  %%
  
  if ~exist( fullfile(path_rn_template, r_folders{iversion}), 'dir' )
    mkdir( fullfile(path_rn_template, r_folders{iversion}) );
  end
  
  %%
  
  cell2file(fullfile(path_rn_template, s_version, ...
            sprintf('rn_bugreport_v%s.m', s_version_)), rn_bugreport);
  
  %%
  
  replaceinfile( '<<toolbox_version/>>', ...
                 s_version, ...
                 fullfile(path_rn_template, s_version, ...
                 sprintf('rn_bugreport_v%s.m', s_version_)), '-nobak');
  
  %%
  
  cell2file(fullfile(path_rn_template, s_version, ...
            sprintf('rn_details_v%s.m', s_version_)), rn_details);
                       
  %%
  
  replaceinfile( '<<toolbox_version/>>', ...
                 s_version, ...
                 fullfile(path_rn_template, s_version, ...
                 sprintf('rn_details_v%s.m', s_version_)), '-nobak');
  
  replaceinfile( '<<toolbox_version_/>>', ...
                 s_version_, ...
                 fullfile(path_rn_template, s_version, ...
                 sprintf('rn_details_v%s.m', s_version_)), '-nobak');
  
  %%
  
  copyfile(fullfile(path_rn_template_doc, 'publish_location.txt'), ...
           fullfile(path_rn_template, s_version, 'publish_location.txt'));
         
  copyfile(fullfile(path_rn_template_doc, 'NOTinXML.txt'), ...
           fullfile(path_rn_template, s_version, 'NOTinXML.txt'));       
         
  copyfile(fullfile(path_rn_template_doc, 'InPath.txt'), ...
           fullfile(path_rn_template, s_version, 'InPath.txt'));
         
  %%
  
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% MAKE rn_compatibility

rn_comp_template= file2cell(fullfile(path_rn_template_doc, 'rn_compatibility.m'));

rn_comp= file2cell(fullfile(path_rn_tool, 'rn_compatibility.m'));
  
rn_comp= [rn_comp_template, rn_comp]; 

cell2file(fullfile(path_rn_template, 'rn_compatibility.m'), rn_comp);


%%
  
copyfile(fullfile(path_rn_template_doc, 'publish_location.txt'), ...
         fullfile(path_rn_template, 'publish_location.txt'));

copyfile(fullfile(path_rn_template_doc, 'NOTinXML.txt'), ...
         fullfile(path_rn_template, 'NOTinXML.txt'));       

copyfile(fullfile(path_rn_template_doc, 'InPath.txt'), ...
         fullfile(path_rn_template, 'InPath.txt'));

%%

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
% MAKE release_notes.xml

rel_notes= [{'<tocitem target="rn/release_notes.html">'}, ...
            {'Summary by Version'}, ...
            {'</tocitem>'}];

%%

for iversion= numel(r_folders):-1:1
  
  %%
  
  s_version= strrep(r_folders{iversion}, filesep, '');
  
  s_version_= strrep(s_version, '.', '_');
  
  %%
  
  rel_notes= [rel_notes, ...
    {sprintf('<tocitem target="rn/rn_details_v%s.html">', s_version_)}, ...
    {sprintf('Version %s <<toolbox_name/>> Toolbox', s_version)}, ...
            {'</tocitem>'}];
  
  %%
  
end
          
%%

rel_notes= [rel_notes, {'<tocitem target="rn/rn_compatibility.html">'}, ...
            {'Compatibility Summary for <<toolbox_name/>> Toolbox'}, ...
            {'</tocitem>'}];

%%

if ~exist( fullfile(path_doc_tool, 'templates', 'help'), 'dir' )
  mkdir(fullfile(path_doc_tool, 'templates', 'help'));
end

if ~exist( fullfile(path_doc_tool, 'templates', 'help', 'tool_template'), 'dir' )
  mkdir(fullfile(path_doc_tool, 'templates', 'help', 'tool_template'));
end

cell2file(fullfile(path_doc_tool, 'templates', 'help', ...
                   'tool_template', 'release_notes.xml'), rel_notes);

%%



%%
%
function tr_string= make_tr_releasenote(s_version, s_version_, latest_v)

%%

if (latest_v)
  temp_var= sprintf('%% <td><b>Latest Version<br>v%s</b></td>', s_version);
else
  temp_var= sprintf('%% <td>v%s</td>', s_version);
end

%%

tr_string= [{'% <tr>'}, ...
            {temp_var}, ...
            {sprintf('%% <td>Yes<br><a href="rn_details_v%s.html">Details</a></td>', s_version_)}, ...
            {'% <td>No<br></td>'}, ...
            {sprintf('%% <td><a href="rn_bugreport_v%s.html">Bug Reports</a>', s_version_)}, ...
            {'% <br>Includes fixes</td>'}, ...
            {'% </tr>'} ...
           ];

%%


