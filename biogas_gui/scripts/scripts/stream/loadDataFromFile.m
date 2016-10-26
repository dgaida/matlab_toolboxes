%% loadDataFromFile
% Load volumeflow_substrates_const files from directory and return them in
% handles
%
function handles= loadDataFromFile(handles, n_substrates)
%% Release: 1.4

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');
isN(n_substrates, 'n_substrates', 2);

%%

if ~isempty(handles.substrate)
    
  %%
  
  volumeflows= load_volumeflow_files('substrate', 'const', ...
                              handles.substrate, handles.model_path);
  
  %%
  
  names= fieldnames(volumeflows);
  
  %%
  
  for isubstrate= 1:numel(names)

    %%

    name= names{isubstrate};
    
    if ~isempty(volumeflows.(name))

      handles.substrateflow(isubstrate,1)= volumeflows.(name)(2,1);

    else

      handles.substrateflow(isubstrate,1)= 0;

    end

  end

else

  handles.substrateflow= [];
  
end

%%

handles.pumpFlux= [];

%%

if size(handles.substrateflow,1) ~= n_substrates
  handles.substrateflow= zeros(n_substrates,1);
end

%%


