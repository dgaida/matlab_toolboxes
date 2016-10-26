%% volumeflowfile_append
% Append values to volumeflow file at start or end of file
%
function volumeflowfile_append(volflowfile, values, position)
%% Release: 1.3

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

checkArgument(volflowfile, 'volflowfile', 'char', '1st');
isRnm(values, 'values', 2);
validatestring(position, {'start', 'end'}, mfilename, 'position', 3);

%%
% throw .mat out of filename if given, needed for save_varname at the end

filename_s= regexp(volflowfile, ['\.', 'mat'], 'split');
volflowfile= char(filename_s(1));

%%

volflow= load_file(volflowfile);

%%

switch position
  
  case 'start'
    
    %%
    % shift is the next higher integer, measured in days
    % if 9.7 is given, shift will be 10
    % if 9 is given, then shift will be 10
    shift= fix(values(1,end) + 1);
    
    % shift time vector by days
    volflow(1,:)= volflow(1,:) + shift;
    
    % add values at start
    volflow= [values, volflow];
    
    %%
    
  case 'end'
    
    %%
    
    if (volflow(1,end) >= values(1,1))
      error('start time of given values is <= end time of file: %.2f >= %.2f!', ...
        volflow(1,end), values(1,1))
    end
    
    %%
    
    volflow= [volflow, values];
    
    %%
    
  otherwise
    
    error('The parameter position must either be start or end, but is %s!', position);
  
end

%%

save_varname(volflow, volflowfile);

%%


