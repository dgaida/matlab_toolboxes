%% so_callActualizeGUI
% Start actualizing the GUI <gui_showoptimresults.html gui_showOptimResults>
%
function handles= so_callActualizeGUI(handles)
%% Release: 1.1

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '1st');

%%
%for icontrol= 1:size(handles.lblSubstrateFlow,1)
    
if isfield(handles, 'lblSubstrateFlow') && ~isempty(handles.lblSubstrateFlow)
  delete(handles.lblSubstrateFlow);
  handles.lblSubstrateFlow= [];
end

if isfield(handles, 'txtSubstrateFlow') && ~isempty(handles.txtSubstrateFlow)
  delete(handles.txtSubstrateFlow);
  handles.txtSubstrateFlow= [];
end

if isfield(handles, 'lblSubstrateDiff') && ~isempty(handles.lblSubstrateDiff)
  delete(handles.lblSubstrateDiff);
  handles.lblSubstrateDiff= [];
end

if isfield(handles, 'lblSubstrateFlowUnit') && ~isempty(handles.lblSubstrateFlowUnit)
  delete(handles.lblSubstrateFlowUnit);
  handles.lblSubstrateFlowUnit= [];
end

if isfield(handles, 'lblPumpFlux') && ~isempty(handles.lblPumpFlux)
  delete(handles.lblPumpFlux);
  handles.lblPumpFlux= [];
end

if isfield(handles, 'txtPumpFlux') && ~isempty(handles.txtPumpFlux)
  delete(handles.txtPumpFlux);
  handles.txtPumpFlux= [];
end

if isfield(handles, 'lblPumpFluxUnit') && ~isempty(handles.lblPumpFluxUnit)
  delete(handles.lblPumpFluxUnit);
  handles.lblPumpFluxUnit= [];
end

%set(handles.btnSaveResults, 'enable', 'on');

%%

handles= so_actualizeGui(handles);


%%


