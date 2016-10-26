%% sn_createNetworkPanel
% Creates the panel of the <gui_substrate_network.html gui_substrate_network>
%
function handles= sn_createNetworkPanel(handles)
%% Release: 1.7

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

plant= handles.plant;
substrate= handles.substrate;
substrate_network= handles.substrate_network;

n_fermenter= handles.plant.getNumDigestersD();
n_substrate= handles.substrate.getNumSubstratesD();

if sum( abs( [n_substrate, n_fermenter] - size(substrate_network) ) ) ~= 0

  errordlg('The loaded substrate_network has not the correct dimension!');

  set(handles.lblPath,     'String', '');
  set(handles.lblFilename, 'String', '');

  return;
    
end

handles.lblSubstrate= zeros(n_substrate, 1);
handles.lblFermenter= zeros(n_fermenter, 1);
handles.txtDistribution= zeros(n_substrate, n_fermenter);

%%

for ifermenter= 1:n_fermenter

  handles.lblFermenter(ifermenter, 1)= ...
      uicontrol('Style', 'Text', ...
      'String', char(plant.getDigesterName(ifermenter)),...
      'units', 'characters', ...
      'HorizontalAlignment', 'center', ...
      'Position', [25.8 + 16.2*(ifermenter - 1) 17.5 16.2 1.154], ...
      'parent', handles.panNetwork);

  for isubstrate= 1:n_substrate

    if ifermenter == 1

      handles.lblSubstrate(isubstrate, 1)= ...
          uicontrol('Style', 'Text', ...
          'String', char(substrate.getName(isubstrate)),...
          'units', 'characters', ...
          'HorizontalAlignment', 'left', ...
          'Position', [3.6 15.385 - 1.615*(isubstrate - 1) 22.2 1.615], ...
          'parent', handles.panNetwork);

    end

    handles.txtDistribution(isubstrate, ifermenter)= ...
        uicontrol('Style', 'edit', ...
        'String', substrate_network(isubstrate,ifermenter),...
        'units', 'characters', ...
        'HorizontalAlignment', 'center', ...
        'Position', ...
        [25.8 + 16.2*(ifermenter - 1) ...
         15.385 - 1.615*(isubstrate - 1) 16.2 1.615], ...
        'parent', handles.panNetwork, ...);..., ...
        'UserData', ifermenter*1000 + isubstrate, ...
        'Callback', @txtDistributionCallback);

    sum_substrate= sum(substrate_network(isubstrate, :), 2);

%         if ifermenter == ifermenterIn
%            
%             set(handles.togConnect(ifermenter, ifermenterIn), ...
%                 'enable', 'off');
%             
%         end

    set(handles.txtDistribution(isubstrate, ifermenter), ...
            'ToolTipString', ...
            sprintf('%i %% of %s is going in %s!', ...
            round(str2double(get(...
            handles.txtDistribution(isubstrate, ifermenter), ...
            'String')) / sum_substrate * 100), ...
            char(substrate.getName(isubstrate)), ...
            char(plant.getDigesterName(ifermenter))));

%         if plant_network(ifermenter,ifermenterIn)
%            
%             set(handles.togConnect(ifermenter, ifermenterIn), ...
%                 'String', 'Connected');
%             
%             if ifermenterIn <= n_fermenter
%                 
%                 set(handles.togConnect(ifermenter, ifermenterIn), ...
%                 'ToolTipString', ...
%                 sprintf('Click to disconnect output of %s from input of %s!', ...
%                 plant.fermenter.(char(plant.fermenter.ids(1,ifermenter))).name, ...
%                 plant.fermenter.(char(plant.fermenter.ids(1,ifermenterIn))).name));
%         
%             else
%                 
%                 
%         
%             end
%             
%         else
%             
%             if ifermenterIn <= n_fermenter
%              
%                 set(handles.togConnect(ifermenter, ifermenterIn), ...
%                 'ToolTipString', ...
%                 sprintf('Click to connect output of %s with input of %s!', ...
%                 plant.fermenter.(char(plant.fermenter.ids(1,ifermenter))).name, ...
%                 plant.fermenter.(char(plant.fermenter.ids(1,ifermenterIn))).name));
%         
%             else
%                 
%                 set(handles.togConnect(ifermenter, ifermenterIn), ...
%                 'ToolTipString', ...
%                 sprintf('Click to connect output of %s with input of %s!', ...
%                 plant.fermenter.(char(plant.fermenter.ids(1,ifermenter))).name, ...
%                 'Endlager'));
%         
%             end
%             
%         end

  end
    
end

%%

% handles.lblFermenterIn(n_fermenter + 1, 1)= ...
%         uicontrol('Style', 'Text', ...
%         'String', 'Endlager',...
%         'units', 'characters', ...
%         'HorizontalAlignment', 'center', ...
%         'Position', [25.8 + 16.2*(n_fermenter) 17.5 16.2 1.154], ...
%         'parent', handles.panNetwork);
    
%%

% set(handles.lblInput, 'Position', [25.8 18.846 16.2*(n_fermenter + 1) 1.154]);
% 
% set(handles.lblOutput, 'Position', ...
%     [1.2 17.5 - 1.615*(n_fermenter) - 0.3 - 0.451 ...
%      6.6 1.615*(n_fermenter) + 1.154 + 0.4 + 0.451]);

set(handles.frmSubstrateNetwork, 'visible', 'on');
set(handles.frmSubstrateNetwork, 'Position', ...
    [3.1   17.5 - 1.615*(n_substrate) - 0.3 - 0.451 ...
     22.2 + 16.2*(n_fermenter) + 0.7 ...
     1.615*(n_substrate) + 1.154 + 0.4 + 0.451]);

%%

set(handles.cmdSave, 'enable', 'on');

%%


