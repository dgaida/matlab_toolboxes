%% txtDistributionCallback
% Executes on txtDistribution Callback of <gui_substrate_network.html 
% gui_substrate_network>.  
%
function txtDistributionCallback(hObject, eventdata, handles)
%% Release: 1.3

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

handles= guidata(hObject);

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%

%tooltip= get(hObject, 'ToolTipString');

userdata= get(hObject, 'UserData');

%%

i_fermenter= round( userdata / 1000 );
i_substrate= userdata - i_fermenter * 1000;

handles.substrate_network(i_substrate, i_fermenter)= ...
            str2double(get(hObject, 'String'));

sum_substrate= sum(handles.substrate_network(i_substrate, :), 2);
        
%%

n_fermenter= handles.plant.getNumDigestersD();

for ifermenter= 1:n_fermenter
    
  tooltip= sprintf('%i %% of %s is going in %s!', ...
              round(str2double(...
              get(handles.txtDistribution(i_substrate, ifermenter), ...
              'String')) / sum_substrate * 100), ...
              char( handles.substrate.getName(i_substrate) ), ...
              char( handles.plant.getDigesterName(ifermenter) ));

  %%

  set(handles.txtDistribution(i_substrate, ifermenter), 'ToolTipString', tooltip);

end

%%

guidata(hObject, handles);

%%


