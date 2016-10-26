%% po_actualizeGui
% Loads the database and actualizes the lists on the gui
% <gui_plot_optimResults.html gui_plot_optimResults>. 
%
function handles= po_actualizeGui(handles)
%% Release: 1.5

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%

try 
  handles.dataAnalysis= load_file( handles.fileName );
catch ME
  rethrow(ME);
end

%%

try
  varnames= get(handles.dataAnalysis, 'VarNames');
catch ME
  rethrow(ME);
end

%%

set(handles.lstXAxis,  'String', varnames);
set(handles.lstYAxis,  'String', varnames);
set(handles.lstZAxis,  'String', varnames);
set(handles.lst4Daxis, 'String', varnames);

%%

set(handles.lblPlant,  'String', handles.fileName);

%%


