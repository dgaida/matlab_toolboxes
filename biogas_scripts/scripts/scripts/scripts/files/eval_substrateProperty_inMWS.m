%% eval_substrateProperty_inMWS
% Eval substrate property in MWS, for new MATLAB version load substrate
% property from file 
%
function [property_id, t_property]= ...
         eval_substrateProperty_inMWS(volumeflow_id, volumeflow_type, property) 
%% Release: 1.3

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

checkArgument(volumeflow_id, 'volumeflow_id', 'char', '1st', 'on');

if isempty(volumeflow_id)
  return;
end

is_volumeflow_type(volumeflow_type, 2);
checkArgument(property, 'property', 'char', '3rd');

%%

volumeflowfile= sprintf('%s_%s_%s', ...
                        property, volumeflow_id, volumeflow_type);

%%
% for old MATLAB versions |property| is saved in MWS, see
% <createvolumeflowfile.html createvolumeflowfile>
%
if getMATLABVersion() < 711
  
  %%
  
  try

    data= evalinMWS(volumeflowfile);

  catch ME

    data= [];
      
    warning('evalinMWS:error', 'evalinMWS %s problem! %s', ...
            volumeflowfile, ME.message);
    %rethrow(ME);
    
  end
  
else
  %%
  % from MATLAB version 7.11 on, the modelworkspace may not be written and
  % evaluated anymore during runtime, so the property is load and saved from
  % file instead, see ...
  % If running parallel, then there are as many property files as there
  % are models, named: |property_..._1.mat|, 2, 3, ...
  
  %%
  % if cannot load from mws, load from file

  bdroot_split= regexp( bdroot, '_', 'split' );

  %%
  % 
  % die letzte Ziffer muss auf jeden Fall numerisch sein, parallel laufende
  % modelle werden mit ziffern durchgezählt
  % es ist vorteilhaft, wenn plant IDs keine Unterstriche und keine Nummern
  % enthalten, bei unglücklichen Kombinationen, wie bspw: 'gummersbach_1',
  % gibt es Verwechselung mit paralleler Modellkennzeichnung und plant ID
  %
  if size(bdroot_split, 2) >= 3 && ~isnan( str2double(bdroot_split{1,end}) )

   volumeflowfilename= sprintf('%s_%s_%s_%s.mat', ...
                            property, volumeflow_id, volumeflow_type, ...
                            bdroot_split{1,end});

  else
    
    volumeflowfilename= sprintf('%s.mat', volumeflowfile);
    
  end

  %%

  try
    data= load_file ( volumeflowfilename );
  catch ME
    warning('load_file:error', ['Cannot load file ', volumeflowfilename]);

    rethrow(ME);
  end

end

%%

if isempty(data)
  error('isempty(data)');
else
  t_property.(volumeflow_id)= data(1,:);
end

if (size(data,1) < 2)
  error('size(data,1) < 2');
else
  property_id.(volumeflow_id)= data(2,:);
end

%%


