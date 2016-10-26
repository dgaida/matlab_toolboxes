%% loadPumpFluxDataFromFile
% Load volumeflow_digester_const files from directory and return them in
% handles
%
function handles= loadPumpFluxDataFromFile(handles, total_number_fluxes)
%% Release: 1.3

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st')
isN(total_number_fluxes, 'total_number_fluxes', 2);

%%

if ~isempty(handles.plant_network)
    
  iPumpFlux= 0;

  %%
  
  for ifermenterOut= 1:size(handles.plant_network,1)

    %%
    
    fermenterOutID= char( handles.plant.getDigesterID(ifermenterOut) );

    for ifermenterIn= 1:size(handles.plant_network,2) - 1

      %%
      
      fermenterInID= char( handles.plant.getDigesterID(ifermenterIn) );

      % interessante Abfrage, anders als was ich sonst mache
      if handles.plant_network(ifermenterOut, ifermenterIn) > 0 && ...
         sum(handles.plant_network(ifermenterOut, :) > 0) > 1

        %%
        
        iPumpFlux= iPumpFlux + 1;

        filename= ['volumeflow_', ...
                fermenterOutID, '_', fermenterInID, '_const'];

        %%
        
        try

          %%
          
          filename_full= fullfile(handles.model_path, [filename, '.mat']);

          if exist(filename_full, 'file')

            s= load(filename_full);

            handles.pumpFlux(iPumpFlux,1)= s.(filename)(2,1);

            clear s;
            
          else

            handles.pumpFlux(iPumpFlux,1)= 0;

          end

        catch ME
          rethrow(ME)
        end

      end

    end

  end

else

  handles.pumpFlux= [];

end

%%

if size(handles.pumpFlux,1) ~= total_number_fluxes
  handles.pumpFlux= zeros(total_number_fluxes,1);
end

%%


