%% create_pcode
% Create pcode for all m-files in the toolbox.
%
function create_pcode(varargin)
%% Release: 1.9

%%

error( nargchk(0, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
%

if nargin >= 1 && ~isempty(varargin{1})
  path= varargin{1};
  
  checkArgument(path, 'path', 'char', '1st');
else
  path= pwd;
end


%%
% from v. 2009b also ~ is ok
[dummy1, dummy2, Names]= dirr(path, '\.m\>', 'name');

for ifile= 1:size(Names,2)
    
  filename_split= regexp(char(Names(1,ifile)), filesep, 'split');

  filename= char(filename_split(end));
  
  %%
  
  if ~isempty(regexp(filename, '_doc.m', 'once'))
    
    try
      delete( char(Names(1,ifile)) );
      
      continue;
    catch ME
      warning('delete:docfile', 'Could not delete: %s!', char(Names(1,ifile)));
      disp(ME.message)
    end
    
  end
  
  %%
  % die datei darf nicht als pcode compiliert werden, sondern muss
  % als m-code vorliegen. die datei gibt informationen an simulink 
  % damit die library in simulink library browser eingelesen werden kann
  if ~strcmp(filename, 'slblocks.m')

    try
      pcode( char(Names(1,ifile)), '-inplace' );

      delete( char(Names(1,ifile)) );
    catch ME
      disp(ME.message)
    end
    
  end
    
end


%%
% wirft sourcecode aus den html dokumentationsdateien raus. braucht
% mittlerweile nicht mehr, da xls file so weit angepasst wurde, dass source
% nicht mehr in html file geschrieben wird

% [~, ~, Names]= dirr(fullfile( path, filesep, 'biogas' ), '\.html\>', 'name');
% 
% for ifile= 1:size(Names,2)
% 
%   filename= char(Names(1,ifile));
% 
%   %%
% 
%   if regexp(filename, '.html.html')
%     continue;
%   end
% 
%   %%
%   % read file
%   [r_file, message]= fopen(filename, 'rt');
% 
%   if r_file == -1
%     errordlg(['Could not open the file ', filename, ...
%              '. Got the message: ', message]);
%     %error(message);
%     continue;
%   end
% 
%   [w_file, message]= fopen([filename, '.html'], 'wt');
% 
%   if w_file == -1
%     errordlg(['Could not open/create the file ', [filename, '.html'], ...
%              '. Got the message: ', message]);
%     %error(message);
%     continue;
%   end
% 
%   %%
% 
%   tline= fgetl(r_file);
% 
%   write= 1;
% 
%   while ischar(tline)
% 
%     if strcmp(tline, '##### SOURCE BEGIN #####')
%         write= 0;
%     end
% 
%     if strcmp(tline, '##### SOURCE END #####')
%         write= 1;
%     end
% 
%     if write
%         %fprintf(w_file, '%s\r\n', tline);
%         fprintf(w_file, '%s\r', tline);
%     end
% 
%     tline= fgetl(r_file);
% 
%   end
% 
%   status= fclose(r_file);
% 
%   if status == 0
%     disp(['Successfully closed file ', filename]);
%   else
%     errordlg(['Could not close the file ', ...
%              filename]);
%   end
% 
%   status= fclose(w_file);
% 
%   if status == 0
%     disp(['Successfully closed file ', [filename, '.html']]);
%   else
%     errordlg(['Could not close the file ', ...
%              [filename, '.html']]);
%   end
% 
%   %%
% 
%   delete( filename );
% 
%   %%
% 
%   try
%     movefile([filename, '.html'], filename);
%   catch ME
%     disp(ME.message);
%   end
%     
% end

%%


