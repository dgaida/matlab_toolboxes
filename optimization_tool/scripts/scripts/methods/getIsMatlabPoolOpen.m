%% getIsMatlabPoolOpen
% Get if MATLAB pool is open
%
function isopen= getIsMatlabPoolOpen()
%% Release: 1.9

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

isopen= 0;

if exist('matlabpool', 'file') == 2
    
  try
    %%
    % matlabpool size returns the size of the worker pool if it is open, or
    % 0 if the pool is closed. 
    if ( matlabpool('size') ~= 0 )

      isopen= 1;

    end
  catch ME

    %%
    % if an error is thrown, then matlabpool is open as well
    
    %% TODO
    % Look for the reference where this is from!
    
    isopen= 1;
    disp(ME.message);

  end
    
end

%%


