%% plot_volumeflow_files
% Plot volumeflow substrate/digester files from current path
%
function plot_volumeflow_files(id, vol_type, varargin)
%% Release: 1.3

%%

error( nargchk(3, 17, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

validatestring(id, {'substrate', 'digester'}, mfilename, 'id', 1);

%%

if nargin >= 3 && ~isempty(varargin{1})
  if strcmp(id, 'substrate')
    substrate= varargin{1};
    is_substrate(substrate, 3);
  elseif strcmp(id, 'digester')
    %% 
    % 
    plant= varargin{1};
    is_plant(plant, 3);
    
    % WARNING! if further parameters are added to this function, then shift
    % these numbers accordingly
    error( nargchk(17, 17, nargin, 'struct') );

    plant_network= varargin{14};
    plant_network_max= varargin{15};
    
    is_plant_network(plant_network, 16, plant);
    is_plant_network(plant_network_max, 17, plant);
    
  else
    error('Unknown id: %s!', id);
  end
end

if nargin >= 4 && ~isempty(varargin{2})
  mypath= varargin{2};
  checkArgument(mypath, 'mypath', 'char', 4);
else
  mypath= pwd;
end

if nargin >= 5 && ~isempty(varargin{3})
  id_write= varargin{3};
  
  checkArgument(id_write, 'id_write', 'char || cellstr', 5);
else
  id_write= [];
end

if nargin >= 6 && ~isempty(varargin{4}), 
  accesstofile= varargin{4}; 
  
  isZ(accesstofile, 'accesstofile', 6, -1, 1);
else
  accesstofile= 1;
end

if nargin >= 7 && ~isempty(varargin{5}), 
  myfig= varargin{5}; 
  
  % check figure
else
  if strcmp(id, 'substrate')    % parameter wird nur für substrate benötigt
    myfig= figure; % für reci wird immer eine neue figure erstellt
  end
end

if nargin >= 8 && ~isempty(varargin{6}), 
  colors= varargin{6}; 
  
  if ischar(colors)
    colors= {colors};
  end
  
  checkArgument(colors, 'colors', 'cellstr', 8);
else
  colors= [];
end

if nargin >= 9 && ~isempty(varargin{7}), 
  nPlots= varargin{7}; 
  
  isN(nPlots, 'nPlots', 9);
else
  nPlots= [];
end

if nargin >= 10 && ~isempty(varargin{8}), 
  xlimits= varargin{8}; 
  
  isRn(xlimits, 'xlimits', 10);
else
  xlimits= [];
end

if nargin >= 11 && ~isempty(varargin{9}), 
  where2plot= varargin{9}; 
  
  isZ(where2plot, 'where2plot', 11, 0, 2);
else
  where2plot= 1;    % 0 == each in one figure, 1 == subplot, 2 == all in one plot
end

if nargin >= 12 && ~isempty(varargin{10}), 
  legend_labels= varargin{10}; 
  
  checkArgument(legend_labels, 'legend_labels', 'cellstr', 12);
else
  legend_labels= [];
end

if nargin >= 13 && ~isempty(varargin{11}), 
  legend_location= varargin{11}; 
  
  checkArgument(legend_location, 'legend_location', 'char', 13);
else
  legend_location= [];
end

if nargin >= 14 && ~isempty(varargin{12}), 
  Q_control= varargin{12}; 
  
  checkArgument(Q_control, 'Q_control', 'double', 14);
else
  Q_control= [];
end

if nargin >= 15 && ~isempty(varargin{13}), 
  linewth= varargin{13}; 
  
  isR(linewth, 'linewth', 15);
else
  linewth= 0.5;
end

%%
% check arguments

%% 
% depends on an external mat file

is_volumeflow_type(vol_type, 2);

%%

if strcmp(id, 'substrate')

  if ischar(id_write) || isempty(id_write)
    id_write= {id_write};   % {[]} has one element
  end
  
  id_writes= id_write;
  
  %%
  
  n_substrates= substrate.getNumSubstratesD();
  
  if isempty(nPlots)
    nPlots= n_substrates;
  end
  
  %% 
  % sollte mind. so viele elemente wie id_writes haben
  
  if isempty(colors)
    if where2plot ~= 2
      colors= get_plot_colors(numel(id_writes), 1);
      
      marker= get_plot_marker(numel(id_writes), 1);
      
      linestyles= get_line_styles(numel(id_writes), 1);
      
      %% TODO - colors wird hier durch marker überschrieben
      %colors= marker;
      %colors= linestyles;
    else % all plots are done in one plot
      colors= get_plot_colors(nPlots * numel(id_writes), 1);
      
      marker= get_plot_marker(nPlots * numel(id_writes), 1);
      
      linestyles= get_line_styles(nPlots * numel(id_writes), 1);
      
      %% TODO - colors wird hier durch marker überschrieben
      %colors= marker;
    end
  else
    linestyles= repmat({'-'}, 1, numel(colors));
  end
  
  %%
  
  if where2plot == 1
    [ncols, nrows]= get_subplot_matrix(nPlots);
  end
  
  %%
  
  iplot= 1;
  
  if isempty(legend_labels)
    legend_labels= cell(nPlots * numel(id_writes), 1);
  else
    if numel(legend_labels) ~= nPlots * numel(id_writes)
      error('legend_labels must contain %i elements, but contains %i!', ...
        nPlots * numel(id_writes), numel(legend_labels));
    end
  end
  
  %%
  
  if ~isempty(Q_control)
    %% TODO - da ich noch nciht plant_id übergebe, hier geiger übergeben
    %% TODO - nehme hier nur jeden 10. wert, sonst dauert es ewig
    % sum of all volumeflows
    Q_control= Q_control(:,1:10:end);
    
    Qtot= get_volumeflow_total(Q_control(1,:), 'geiger', vol_type, accesstofile);
  end
  
  %%
  
  for isubstrate= 1:n_substrates

    %%
  
    for iid= 1:numel(id_writes)

      id_write= id_writes{iid};

      %%

      if isempty(id_write)
        filename= ['volumeflow_', char(substrate.getID(isubstrate)), '_', vol_type];
      else
        filename= ['volumeflow_', char(substrate.getID(isubstrate)), '_', vol_type, '_', id_write];
      end

      %%

      try

        %%

        volumeflow= [];

        %%

        if accesstofile == 1
          filename_full= fullfile(mypath, [filename, '.mat']);

          %%

          if exist(filename_full, 'file')
            volumeflow= load_file(filename_full);
          end
        elseif accesstofile == 0
          volumeflow= evalin('base', ['volumeflow_', char(substrate.getID(isubstrate)), '_', vol_type]);
        else
          warning('accesstofile:m1', 'Not yet implemented!');
        end

        %% 
        % 
        % wenn volflowrate == 0 durchgehend, dann muss nicht geplottet
        % werden, bei subplot ist es auch egal
        if ~isempty(volumeflow) && (sum(volumeflow(2,:)) ~= 0 || nPlots == n_substrates)

          %%
          
          if iid == 1
            figure(myfig);
            
            if where2plot == 1
              subplot(nrows, ncols, iplot);
              hold on;
            elseif where2plot == 2
              hold on;
            end
          else
            if where2plot == 0
              figure;
            else
              hold on;
            end
          end
          
          %%
          
          if ~isempty(Q_control)
            %Q_control_new= resampleData(Q_control(2,:), Q_control(1,:), volumeflow(1,:));
            
            %Qtot_new= resampleData(Qtot, Q_control(1,1:10:end), volumeflow(1,:));
            
            Q_new= resampleData(volumeflow(2,:), volumeflow(1,:), Q_control(1,:));
            
            volumeflow= [Q_control(1,:); Q_new .* Q_control(2,:) ./ Qtot];
          end
          
          %%
          
          %plot(volumeflow(1,:), volumeflow(2,:), 'Color', colors(iid,:))
          if where2plot == 2
            plot(volumeflow(1,:), volumeflow(2,:), [linestyles{iplot}, colors{iplot}], 'LineWidth', linewth)
            %plot(volumeflow(1,:), volumeflow(2,:), [linestyles{iplot}, 'k'], 'LineWidth', linewth)
          else
            plot(volumeflow(1,:), volumeflow(2,:), [linestyles{iid}, colors{iid}], 'LineWidth', linewth)
          end
          
          xlabel('time [d]', ...
              'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
          
          if where2plot ~= 2
            ylabel(sprintf('%s [m^3/d]', char(substrate.getName(isubstrate))));
          else
            ylabel('substrate feed $[\mbox{m}^3/\mbox{d}]$', ...
              'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
          end
          
          %% TODO
          % wenn man dieses skript für einen plot mehrmals aufruft, dann
          % ist ylim schwierig, da ein vorheriger plot dann evtl. teilweise
          % aus dem sichtbaren bereich raus geht.
          %ylim([0, max(1, ceil(max(volumeflow(2,:))))])

          if ~isempty(xlimits)
            xlim(xlimits);
          end
          
          if ~isempty(id_write) && numel(id_writes) > 1
            if isempty(legend_labels(iplot))
              legend_labels(iplot)= {sprintf('%s %s [m^3/d]', ...
                char(substrate.getName(isubstrate)), id_writes{iid})};
            else
              legend_labels(iplot)= {sprintf('%s %s [m^3/d]', ...
                char(legend_labels(iplot)), id_writes{iid})};
            end
          else
            if isempty(legend_labels{iplot})
              legend_labels(iplot)= {sprintf('%s [m^3/d]', char(substrate.getName(isubstrate)))};
            else
              %legend_labels(iplot)= {sprintf('%s [m^3/d]', char(legend_labels(iplot)))};
              legend_labels(iplot)= {sprintf('\\mbox{%s}', char(legend_labels(iplot)))};
            end
          end
          
          iplot= iplot + 1;
          
        end

        %%

      catch ME
        rethrow(ME);
      end

      %%

    end
    
    %%
    % if where2plot == 2, then id_write is already integrated in
    % legen_labels. legend for legend_labels is created below after the end
    % of the for loop
    if where2plot ~= 2
      if ~isempty(volumeflow) && ~isempty(id_writes{1}) && numel(id_writes) > 1
        if isempty(legend_location)
          ml= legend(id_writes);
        else
          ml= legend(legend_labels, 'Location', legend_location);
        end
        
        set(ml, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
      end
    end
    
    hold off;
  
  end
  
  %%
  
  if ~isempty(volumeflow) && where2plot == 2
    if isempty(legend_location)
      ml= legend(legend_labels, 'Location', 'Best');
    else
      ml= legend(legend_labels, 'Location', legend_location);
    end
    
    set(ml, 'FontSize', 10, 'FontName', 'Times New Roman', 'Interpreter', 'latex');
  end
  
  %%

else        % 'digester'
   
  %% 
  % für plant "digester" code 

  [nSplits, digester_splits, digester_indices]= ...
       getNumDigesterSplits(plant_network, ...
                            plant_network_max, plant);
                          
  %%
  
  [ncols, nrows]= get_subplot_matrix(nSplits);
  
  figure
  
  %%
  
  for isplit= 1:nSplits
    
    %%

    if isempty(id_write)
      filename= ['volumeflow_', digester_splits{isplit}, '_', vol_type];
    else
      filename= ['volumeflow_', digester_splits{isplit}, '_', vol_type, '_', id_write];
    end

    %%

    try

      %%

      volumeflow= [];
      
      %%
      
      if accesstofile == 1
        filename_full= fullfile(mypath, [filename, '.mat']);

        %%

        if exist(filename_full, 'file')
          volumeflow= load_file(filename_full);
        end
      elseif accesstofile == 0
        volumeflow= evalin('base', ['volumeflow_', digester_splits{isplit}, '_', vol_type]);
      else
        warning('accesstofile:m1', 'Not yet implemented!');
      end

      %%

      if ~isempty(volumeflow)
        
        %figure;
        subplot(nrows, ncols, isplit);
        plot(volumeflow(1,:), volumeflow(2,:), 'LineWidth', linewth)
        xlabel('time [d]');
        
        digester1= char(plant.getDigesterName(digester_indices(isplit,1)));
        digester2= char(plant.getDigesterName(digester_indices(isplit,2)));
        
        ylabel(sprintf('%s -> %s [m^3/d]', digester1, digester2));
        ylim([0, max(1, ceil(max(volumeflow(2,:))))])

      end
      
      %%

    catch ME
      rethrow(ME);
    end

    %%
    
  end
  
  %%
  
end
  
%%



%%


