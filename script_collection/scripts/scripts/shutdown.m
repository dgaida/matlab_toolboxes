%% shutdown
% Turn off a Windows machine from within MATLAB
%
function shutdown(varargin)
%% Release: 1.9

%%

error( nargchk(0, 1, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin
  
  %%
  
  if isnumeric(varargin{1})
    
    %%
    
    if varargin{1} == -1
      evalc('!shutdown -a');  % abort the shutdown
      
      return;
    end
    
    t= ceil(varargin{1});     % this is the time in seconds
  
  else
    t= 60;    % default 60 seconds
  end
  
else
  t= 60;      % default 60 seconds
end

%%

eval(['!shutdown -s -f -t ' num2str(t)]); 

%%


