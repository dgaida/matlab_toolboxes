%% actualizeGui
% Actualize gui set_input_stream
%
function handles= actualizeGui(handles)
%% Release: 1.1

% [path_config_mat]= fileparts(which('plant_plantname.mat'));
% 
% s= what(path_config_mat);
% 
% mat_files= s.mat;
% 
% for ifile= 1:size(mat_files,1)
%     
%     s= whos('-file', char(mat_files(ifile,1)));
%     
%     if strcmp( s.name, 'plant' )
%        load ( char(mat_files(ifile,1)) );
%        
%        if strcmp(plant.name, handles.plantName) || ...
%           strcmp(plant.id, handles.plantID)
%            handles.plant= plant;
%            
%            if isempty(handles.plantName)
%            
%                handles= setpopPlantToValue(handles, plant.name);
%                
%            end
%            
%            handles.plantID= plant.id;
%            handles.plantName= plant.name;
%                       
%            % Update handles structure
%            %guidata(hObject, handles);
%            
%            clear s;
%            
%            break;
%        else
%            clear plant;
%        end
%        
%     end
%     
%     clear s;
%     
% end

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
    
  if isempty(handles.plantName)

    handles= setpopPlantToValue(handles, char(handles.plant.name));

  end

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

  %%
  
  if exist( substrate_file, 'file' )

    %load(substrate_file);

    %for ipop= 1:3
    %    set(handles.(sprintf('popSubstrateFlow%i', ipop)), ...
    %        'String', '--- Bitte Substrat wählen ---');
    %end

    handles.substrate= biogas.substrates(substrate_file);

    handles.substrateflow= zeros(handles.substrate.getNumSubstratesD(),1);
    handles.lblSubstrateFlow= zeros(handles.substrate.getNumSubstratesD(),1);
    handles.txtSubstrateFlow= zeros(handles.substrate.getNumSubstratesD(),1);
    handles.lblSubstrateFlowUnit= zeros(handles.substrate.getNumSubstratesD(),1);

    handles= loadDataFromFile(handles, handles.substrate.getNumSubstratesD());

    n_substrates= handles.substrate.getNumSubstratesD();

    %%
    
    for isubstrate= 1:n_substrates

      %%
      
      substrateName= char(handles.substrate.getName(isubstrate));

      handles.lblSubstrateFlow(isubstrate,1)= ...
          uicontrol('Style', 'text', 'Units', 'characters', ...
                    'Position', [1.8 topPanels - ...
                    (isubstrate-1)*2 43.1 1.615],...
                    'String', substrateName, ...
                    'Parent', handles.panSubstrate, ...
                    'HorizontalAlignment', 'left');

      %%
      
      if ~isempty(handles.equilibrium)

        optVal= 0;          

        for ifermenter= 1:handles.plant.getNumDigestersD()    

          optVal= optVal + handles.equilibrium.network_flux(1,...
               isubstrate + (ifermenter - 1)*n_substrates);

        end

      else

        optVal= handles.substrateflow(isubstrate,1);

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
                    sprintf(['Geben Sie eine positive Zahl für ', ...
                    'die Substratmenge von %s an!'], ...
                    substrateName));%, ...
                    %'KeyPressFcn', {@saveSubstrateFlow, handles, isubstrate});%, ...
                    %'Callback', {@saveSubstrateFlow, handles, isubstrate});

      handles.lblSubstrateFlowUnit(isubstrate,1)= ...
          uicontrol('Style', 'text', 'Units', 'characters', ...
                    'Position', [56.9 topPanels - ...
                    (isubstrate-1)*2 12.2 1.615],...
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

    end % for isubstrate ...

  end % if exist( substrate_file, 'file' )


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

    handles= loadPumpFluxDataFromFile(handles, total_number_fluxes);

    iPumpFlux= 0;

    n_fermenter= handles.plant.getNumDigestersD();

    %%
    
    for ifermenterOut= 1:size(handles.plant_network,1)

      fermenterOutName= char(handles.plant.getDigesterName(ifermenterOut));

      %%
      
      for ifermenterIn= 1:size(handles.plant_network,2) - 1

        %if ifermenterIn == size(handles.plant_network,2)
        %    fermenterInName= 'Endlager';
        %else
        fermenterInName= char(handles.plant.getDigesterName(ifermenterIn));
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

          if ~isempty(handles.equilibrium)

            optVal= handles.equilibrium.network_flux(1,...
                    n_fermenter*n_substrates + iPumpFlux);

          else

            optVal= handles.pumpFlux(iPumpFlux,1);

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
                    sprintf(['Geben Sie eine positive Zahl für ', ...
                    'die zu pumpende Menge zwischen %s und %s an!'], ...
                    fermenterOutName, fermenterInName));

          handles.lblPumpFluxUnit(iPumpFlux,1)= ...
              uicontrol('Style', 'text', 'Units', 'characters', ...
                    'Position', [56.9 topPanels - ...
                    (iPumpFlux-1)*2 12.2 1.615],...
                    ...'String', '<html>[m<sup>3</sup>/d]<html>');
                    'String', '[m³/d]', ...
                    'Parent', handles.panPumpFlux, ...
                    'HorizontalAlignment', 'center');

        end % if handles.plant_network(ifermenterOut, ifermenterIn) > 0

      end % for ifermenter ...

    end % for ifermenter

  end % if exist
        
else
  error('Could not find the selected plant!');
end

%handles


% Update handles structure
%guidata(hObject, handles);

%%


