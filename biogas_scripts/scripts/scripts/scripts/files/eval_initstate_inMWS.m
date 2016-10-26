%% eval_initstate_inMWS
% Eval initstate in MWS, for new MATLAB version load initstate from file
%
function initstate= eval_initstate_inMWS(plant_id)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(plant_id, 'plant_id', 'char', '1st');

%%
% for old MATLAB versions |initstate| is saved in MWS, see
% <assign_initstate_inMWS.html assign_initstate_inMWS>
%
if getMATLABVersion() < 711
  
  %%
  
  try

    initstate= evalinMWS('initstate');

  catch ME

    initstate= [];
      
    warning('evalinMWS:error', 'evalinMWS initstate problem! %s', ME.message);
    %rethrow(ME);
    
  end
  
else
  %%
  % from MATLAB version 7.11 on, the modelworkspace may not be written and
  % evaluated anymore during runtime, so initstate is load and saved from
  % file instead, see <assign_initstate_inMWS.html assign_initstate_inMWS>.
  % If running parallel, then there are as many initstate files as there
  % are models, named: |initstate_gummersbach_1.mat|, 2, 3, ...
  
  %%
  % if cannot load from mws, load from file

  bdroot_split= regexp( bdroot, '_', 'split' );

  %%
  % initialize the state with initial conditions
  %
  % die letzte Ziffer muss auf jeden Fall numerisch sein, parallel laufende
  % modelle werden mit ziffern durchgezählt
  % es ist vorteilhaft, wenn plant IDs keine Unterstriche und keine Nummern
  % enthalten, bei unglücklichen Kombinationen, wie bspw: 'gummersbach_1',
  % gibt es Verwechselung mit paralleler Modellkennzeichnung und plant ID
  %
  if size(bdroot_split, 2) >= 3 && ~isnan( str2double(bdroot_split{1,end}) )

   filename= sprintf('initstate_%s_%s.mat', plant_id, bdroot_split{1,end});

  else
    
    filename= sprintf('initstate_%s.mat', plant_id);
    
  end

  %%

  if exist(filename, 'file') == 2

    initstate= load_file(filename);

  else

    initstate= [];
    warning('IO:FileNotExist', ['The file ', filename, ' does not exist!']);
    
  end

end


%%


