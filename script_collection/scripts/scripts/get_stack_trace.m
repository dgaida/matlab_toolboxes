%% get_stack_trace
% Get stack trace of an <matlab:doc('MException') MException> object
%
function msg= get_stack_trace(s)
%% Release: 1.8

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

msg= '';

if ~isfield(s, 'stack') && ~isa(s, 'MException'),  
  return;  
end

stack= s.stack;

%%

for i= 1:length(stack)
  
  %%
  %stack(i)  % DEBUG
  %if (stack(i).name(1) == '@')  % WRONG!
  if strfind(stack(i).name, '@')
    
    % inline or function handle.
    full_name= '';
    name= '(inline function)';
    temp= stack(i).name;
    
  else
    
    full_name= which(stack(i).file);
    name= stack(i).name;
    temp= sprintf('dbtype ''%s'' %d', full_name, stack(i).line);
    %disp(temp)  % DEBUG
    
    %%
    
    try
      temp= evalc(temp);
      temp= temp(8:end - 2);  % discard line # and \n\n
    catch ME
      temp= '';
      disp(ME.message)
    end
  end

  %%
  
  msg= strcat(msg, sprintf(...
      '\n\nError in ==> <a href="error:%s,%d,1">%s at %d</a>\n%s', ...
      full_name, stack(i).line, ...
      name, stack(i).line, ...
      temp));
    
end

%%
% delete \n\n
msg= msg(3:end);

%%


