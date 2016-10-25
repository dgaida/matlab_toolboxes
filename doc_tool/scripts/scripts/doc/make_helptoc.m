%% make_helptoc
% Create helptoc files of MATLAB's help system.
%
function make_helptoc(toolbox, varargin)
%% Release: 1.2

%%

error( nargchk(1, nargin, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox,  'toolbox',  'gecoc_tool', '1st');

%%

help_path= toolbox.getHelpPath();

help_path_doc_tool= fullfile( doc_tool.getToolboxPath(), 'scripts', ...
                              'help', 'doc_tool', 'doc_creation_files' );


%%

f_userguide_template= fullfile(help_path, 'userguide.xml');

f_releasenotes_template= fullfile(help_path, 'release_notes.xml');

%%

if exist(fullfile(help_path, 'helpblockbycat.xml'), 'file')
  
  f_helpblockbycat=      fullfile(help_path, 'helpblockbycat.xml');

  f_helpblockbycat_xsl=  fullfile(help_path_doc_tool, 'helpblockbycat_2009a_xml.xsl');

  f_helpblockbycat_2009= fullfile(help_path, 'helpblockbycat_R2009a.xml');

end

%%

f_helpfuncbycat= fullfile(help_path, 'helpfuncbycat.xml');

f_helpfuncbycat_xsl= fullfile(help_path_doc_tool, ...
                               'helpfuncbycat_2009a_xml.xsl');

f_helpfuncbycat_2009= fullfile(help_path, ...
                           'helpfuncbycat_R2009a.xml');

                         
%%

find_entry= @(tocfile, entry) find(~cellfun('isempty', strfind(tocfile, entry)));

%%

for iversion= 1:2

  switch(iversion)
    case 1
      version= 'R2009a';
    case 2
      version= 'R2009b';
  end

  f_helptoc_template= fullfile(help_path_doc_tool, ...
                               ['helptoc_template_', version, '.xml']);

  f_helptoc= fullfile(help_path, ...
                      ['helptoc_', version, '.xml']);



  %%
  % read helptoc template

  toc_toc= file2cell(f_helptoc_template);

  %%
  % insert title of toolbox and help start html page
  
  toc_toc= replace_entry(toc_toc, ...
      [{sprintf('<tocitem target="%s_product_page.html"', toolbox.getToolboxID())}, ... 
       {'image="$toolbox/matlab/icons/matlabicon.gif">'}, ...
    	 {toolbox.getToolboxName()}], ...
                         find_entry(toc_toc, '<make_doc_title />'));
  
  %%
  % make examples
  
  %% TODO
  % ist es richtig, dass in 2009a examples noch nicht in helptoc
  % geschrieben wurden?
  if iversion == 2
    if exist(fullfile(toolbox.getToolboxPath(), 'examples', 'demos.xml'), 'file') == 2
      toc_toc= replace_entry(toc_toc, ...
        [{'<tocreference target="../examples/demos.xml">'}, ... 
         {''}, ...
         {'</tocreference>'}], ...
                           find_entry(toc_toc, '<make_examples />'));
    else
      toc_toc= replace_entry(toc_toc, {''}, ...
                           find_entry(toc_toc, '<make_examples />'));
    end
  end
  
  
  %%
  %
  
  if ~exist(fullfile(help_path, 'helpblockbycat.xml'), 'file')
    if (iversion == 1)    
      toc_toc= replace_entry(toc_toc, {''}, ...
                  find_entry(toc_toc, '<make_helpblockbycat />'));
    else
      toc_toc= replace_entry(toc_toc, {''}, ...
                  find_entry(toc_toc, ...
                  '<tocreference target="helpblockbycat.xml"></tocreference>'));
    end
  end
  
  
  %% 
  % read userguide

  cell_userguide= file2cell(f_userguide_template);

  if (iversion == 1)
    % das tocitem von user guide soll übersprungen werden
    cell_userguide= cell_userguide(10:end-2);
  else
    % hier soll nur toc übersprungen werden
    cell_userguide= cell_userguide(7:end-1);
  end

  %%

  toc_toc= replace_entry(toc_toc, cell_userguide, ...
                         find_entry(toc_toc, '<make_userguide />'));


  %% 
  % read release notes

  cell_release_notes= file2cell(f_releasenotes_template);

  %%

  toc_toc= replace_entry(toc_toc, cell_release_notes, ...
                         find_entry(toc_toc, '<make_releasenotes />'));


  %%                   
  % for 'R2009a' we have to copy helpblockbycat and helpfuncbycat into the
  % helptoc file
  %
  if (iversion == 1) % 'R2009a'

    %% 
    % read helpblockbycat

    if exist(fullfile(help_path, 'helpblockbycat.xml'), 'file')
      
      xslt(f_helpblockbycat, f_helpblockbycat_xsl, f_helpblockbycat_2009);
    
      %%

      cell_helpblock= file2cell(f_helpblockbycat_2009);
      cell_helpblock= cell_helpblock(3:end-1);


      %%

      toc_toc= replace_entry(toc_toc, cell_helpblock, ...
                         find_entry(toc_toc, '<make_helpblockbycat />'));

                       
      %%
      
      delete( f_helpblockbycat_2009 );
                     
    end

    %% 
    % read helpfuncbycat

    xslt(f_helpfuncbycat, f_helpfuncbycat_xsl, f_helpfuncbycat_2009);


    %%

    cell_helpfunc= file2cell(f_helpfuncbycat_2009);
    cell_helpfunc= cell_helpfunc(3:end-1);


    %%

    toc_toc= replace_entry(toc_toc, cell_helpfunc, ...
                       find_entry(toc_toc, '<make_helpfuncbycat />'));

    %%
    % delete temp files

    delete( f_helpfuncbycat_2009 );


  end


  %%
  % write in helptoc

  cell2file(f_helptoc, toc_toc, 'w');
    
end % end for

%% TODO

copyfile(fullfile(help_path, ['helptoc_', 'R2009b', '.xml']), ...
         fullfile(help_path, 'helptoc.xml'));

copyfile(fullfile(help_path, 'helptoc.xml'), ...
         fullfile(help_path, 'html', 'helptoc.xml'));

     
%%


    