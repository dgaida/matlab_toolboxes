%% startSPOt
%
%
function startSPOt()
%% Release: 0.0

%%

error( nargchk(0, 4, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%



%%
% m-file or p-file
if existMPfile('spotdriver2')
    
  %%
  
  try
    
    spotdriver2('adm1nmpc0000');

  catch ME

    warning('SPOt:Error', 'SPOt failed!');
    disp(ME.message);

    disp(get_stack_trace(ME));

  end

else

  errordlg('The SPOt algorithm is not installed!');
  error('The SPOt algorithm is not installed!');

end

%%



%%


