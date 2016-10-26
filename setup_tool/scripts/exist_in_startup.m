%% exist_in_startup
% Check if entry for toolbox exists in startup.m
%
function [start_idx, end_idx, doexist]= exist_in_startup(toolbox_name)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

checkArgument(toolbox_name, 'toolbox_name', 'char', '1st');

%%

find_entry= @(tocfile, entry) find(~cellfun('isempty', strfind(tocfile, entry)));

start_idx= [];
end_idx= [];

%%

if exist('startup.m', 'file')
  
  %%
  
  content= file2cell('startup.m');
  
  %%
  
  entries= find_entry(content, ...
    sprintf('%%*** The following code was created by the toolbox ''%s'' ***', ...
            toolbox_name));

  %%
  
  if ~isempty( entries )

    start_idx= entries(1);
    
    entries= find_entry(content, sprintf('%%*** ''%s'' ***', toolbox_name));
    
    end_idx= entries(1);
    
  end
  
end

%%

if ~isempty(start_idx) && ~isempty(end_idx)
  doexist= 1;
else
  doexist= 0;
end

%%


