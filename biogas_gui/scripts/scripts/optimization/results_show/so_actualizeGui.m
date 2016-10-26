%% so_actualizeGui
% Actualize the GUI <gui_showoptimresults.html gui_showOptimResults>
%
function handles= so_actualizeGui(handles)
%% Release: 1.1

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

if isempty(handles.plantName)
  plant_id_or_name= handles.plantID;
else
  plant_id_or_name= handles.plantName;
end


%%

[handles.plant, path_config_mat]= loadPlantStructure(plant_id_or_name);


%%

if ~isempty(handles.plant)

%     if isempty(handles.plantName)
%         
%         handles= setpopPlantToValue(handles, handles.plant.name);
%         
%     end

  handles.plantID= char(handles.plant.id);
  handles.plantName= char(handles.plant.name);

end


%%

posPanels= get(handles.panSubstrate, 'Position');
topPanels= posPanels(1,4) - 1.8 - 1.615/2.0;

%%

if ~isempty(handles.plant)

  %%

  substrate_file= fullfile( ...
          path_config_mat, ['substrate_', char(handles.plant.id), '.xml' ] ...
                    );

  if exist( substrate_file, 'file' )

      %%

      substrate= biogas.substrates(substrate_file);

      %for ipop= 1:3
      %    set(handles.(sprintf('popSubstrateFlow%i', ipop)), ...
      %        'String', '--- Bitte Substrat wählen ---');
      %end

      handles.substrate= substrate;

      n_substrates= handles.substrate.getNumSubstratesD();

      handles.substrateflow=        zeros(n_substrates,1);
      handles.lblSubstrateFlow=     zeros(n_substrates,1);
      handles.txtSubstrateFlow=     zeros(n_substrates,1);
      handles.lblSubstrateFlowUnit= zeros(n_substrates,1);
      handles.lblSubstrateDiff=     zeros(n_substrates,1);

      %handles= loadDataFromFile(handles, size(handles.substrate.ids,2));


      %%

      if exist( ['equilibria_', handles.plantID, '.mat'], 'file' ) && ...
         exist('dataset', 'file') == 2

          dataAnalysis= load_file(['equilibria_', handles.plantID]);

          %% TODO
          % kann mir nicht vorstellen, dass der überhaupt was rausfiltert,
          % da simulationsergebnisse wohl nie identisch sind
          data= unique(double(dataAnalysis(:,2:end)), 'rows');

          % sort with respect to fitness value
          data= sortrows(data, size(dataAnalysis,2) - 1);

      end


      %%

      %n_substrates= size(handles.substrate.ids,2);

      set(handles.lblFitness, 'String', ...
          sprintf('Fitness= %.2f', handles.equilibrium.fitness));

      isubstrateOptimum= 0;

      for isubstrate= 1:n_substrates

          %%

          substrateName= char(substrate.getName(isubstrate));

          handles.lblSubstrateFlow(isubstrate,1)= ...
              uicontrol('Style', 'text', 'Units', 'characters', ...
                        'Position', [1.8 topPanels - ...
                        (isubstrate-1)*2 43.1 1.615],...
                        'String', substrateName, ...
                        'Parent', handles.panSubstrate, ...
                        'HorizontalAlignment', 'left');

          optVal= 0;          

          %%

          for ifermenter= 1:handles.plant.getNumDigestersD()          

            optVal= optVal + handles.equilibrium.network_flux(1,...
                   isubstrate + (ifermenter - 1)*n_substrates);

          end

          %%

          handles.txtSubstrateFlow(isubstrate,1)= ...
              uicontrol('Style', 'edit', 'Units', 'characters', ...
                        'Position', [44.8 topPanels - ...
                        (isubstrate-1)*2 12.2 1.615],...
                        'String', optVal, ...
                        'BackgroundColor', 'white', ...
                        'Parent', handles.panSubstrate, ...
                        'HorizontalAlignment', 'center', ...
                        'ToolTipString', ...
                        sprintf(['Optimale Substratmenge für ', ...
                        '%s!'], ...
                        substrateName));%, ...
                        %'KeyPressFcn', {@saveSubstrateFlow, handles, isubstrate});%, ...
                        %'Callback', {@saveSubstrateFlow, handles, isubstrate});

          %%

          if optVal ~= 0 && exist('dataset', 'file') == 2 && ...
                            exist('data', 'var')
              isubstrateOptimum= isubstrateOptimum + 1;

              maxdiff= max(...
                  abs( data((data(:,end) < 1.1.*data(1,end)), isubstrateOptimum) - ...
                  optVal ) );
          else
              maxdiff= 0;
          end

          %%

          handles.lblSubstrateDiff(isubstrate,1)= ...
              uicontrol('Style', 'text', 'Units', 'characters', ...
                        'Position', [57.8 topPanels - ...
                        (isubstrate-1)*2 10.2 1.615],...
                        ...'String', '<html>[m<sup>3</sup>/d]<html>');
                        'String', sprintf('+- %.2f', maxdiff), ...
                        'Parent', handles.panSubstrate, ...
                        'HorizontalAlignment', 'center');              

          handles.lblSubstrateFlowUnit(isubstrate,1)= ...
              uicontrol('Style', 'text', 'Units', 'characters', ...
                        'Position', [67.9 topPanels - ...
                        (isubstrate-1)*2 8.2 1.615],...
                        ...'String', '<html>[m<sup>3</sup>/d]<html>');
                        'String', '[m³/d]', ...
                        'Parent', handles.panSubstrate, ...
                        'HorizontalAlignment', 'center');

%             for ipop= 1:3
%                 contents= ...
%                     get(handles.(sprintf('popSubstrateFlow%i', ipop)), 'String');
%    
%                 set(handles.(sprintf('popSubstrateFlow%i', ipop)), ...
%                     'String', {char(contents); substrateName});
%             end

      end

  end


  %%

  plant_network_file= fullfile( ...
          path_config_mat, ['plant_network_', char(handles.plant.id), '.mat' ] ...
                    );

  %%

  if exist( plant_network_file, 'file' )

      load(plant_network_file);

      handles.plant_network= plant_network;

      total_number_fluxes= 0;

      %%

      for irow= 1:size(plant_network, 1)

          if sum(handles.plant_network(irow, :) > 0) > 1

              total_number_fluxes= total_number_fluxes + ...
                          sum(handles.plant_network(irow, 1:end-1) > 0);

          end

      end

      %%

      handles.pumpFlux=        zeros(total_number_fluxes, 1);
      handles.lblPumpFlux=     zeros(total_number_fluxes, 1);
      handles.txtPumpFlux=     zeros(total_number_fluxes, 1);
      handles.lblPumpFluxUnit= zeros(total_number_fluxes, 1);
      handles.lblPumpFluxDiff= zeros(total_number_fluxes, 1);

      %handles= loadPumpFluxDataFromFile(handles, total_number_fluxes);

      iPumpFlux= 0;

      n_fermenter= handles.plant.getNumDigestersD();

      %%

      for ifermenterOut= 1:size(handles.plant_network,1)

          fermenterOutName= char(handles.plant.getDigesterName(ifermenterOut));

          for ifermenterIn= 1:size(handles.plant_network,2) - 1

              %%
              %if ifermenterIn == size(handles.plant_network,2)
              %    fermenterInName= 'Endlager';
              %else
                  fermenterInName= ...
                      char(handles.plant.getDigesterName(ifermenterIn));
              %end

              if handles.plant_network(ifermenterOut, ifermenterIn) > 0 && ...
                 sum(handles.plant_network(ifermenterOut, :) > 0) > 1

                  iPumpFlux= iPumpFlux + 1;

                  fermenterString= ...
                      [fermenterOutName, ' -> ', fermenterInName];

                  handles.lblPumpFlux(iPumpFlux,1)= ...
              uicontrol('Style', 'text', 'Units', 'characters', ...
                        'Position', [1.8 topPanels - ...
                        (iPumpFlux-1)*2 43.1 1.615],...
                        'String', fermenterString, ...
                        'Parent', handles.panPumpFlux, ...
                        'HorizontalAlignment', 'left');

        try
              optVal= handles.equilibrium.network_flux(1,...
                  n_fermenter*n_substrates + iPumpFlux);          
          catch ME
              % für rezirkulat, welches constant 0 ist und deshalb nicht
              % in network_flux steht
              optVal= 0;
          end

          handles.txtPumpFlux(iPumpFlux,1)= ...
              uicontrol('Style', 'edit', 'Units', 'characters', ...
                        'Position', [44.8 topPanels - ...
                        (iPumpFlux-1)*2 12.2 1.615],...
                        'String', optVal, ...
                        'BackgroundColor', 'white', ...
                        'Parent', handles.panPumpFlux, ...
                        'HorizontalAlignment', 'center', ...
                        'Tag', ...
          [char(handles.plant.getDigesterID(ifermenterOut)), '_', ...
           char(handles.plant.getDigesterID(ifermenterIn))], ...
                        'ToolTipString', ...
                        sprintf(['Optimal gepumpter Fluss ', ...
                        'zwischen %s und %s!'], ...
                        fermenterOutName, fermenterInName));

          if optVal ~= 0 && exist('dataset', 'file') == 2 && ...
                            exist('data', 'var')
              isubstrateOptimum= isubstrateOptimum + 1;

              maxdiff= max(...
                  abs( data((data(:,end) < 1.1.*data(1,end)), isubstrateOptimum) - ...
                  optVal ) );
          else
              maxdiff= 0;
          end

          handles.lblPumpFluxDiff(iPumpFlux,1)= ...
              uicontrol('Style', 'text', 'Units', 'characters', ...
                        'Position', [57.8 topPanels - ...
                        (iPumpFlux-1)*2 12.2 1.615],...
                        ...'String', '<html>[m<sup>3</sup>/d]<html>');
                        'String', sprintf('+- %.2f', maxdiff), ...
                        'Parent', handles.panPumpFlux, ...
                        'HorizontalAlignment', 'center');               

          handles.lblPumpFluxUnit(iPumpFlux,1)= ...
              uicontrol('Style', 'text', 'Units', 'characters', ...
                        'Position', [69.9 topPanels - ...
                        (iPumpFlux-1)*2 8.2 1.615],...
                        ...'String', '<html>[m<sup>3</sup>/d]<html>');
                        'String', '[m³/d]', ...
                        'Parent', handles.panPumpFlux, ...
                        'HorizontalAlignment', 'center');

              end

          end

      end



  end



else
  error('Could not find the selected plant!');
end

%%


