%% nmpc_callActualizeGUI
% Delete dynamic created fields and call <nmpc_actualizeGUI.html
% nmpc_actualizeGUI> 
%
function handles= nmpc_callActualizeGUI(handles)
   
%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%
% delete substrate fields
% name      range      unit

if isfield(handles, 'lblSubstrateFlow') && ~isempty(handles.lblSubstrateFlow)
    
  for iitem= 1:size(handles.lblSubstrateFlow, 1)
      delete(handles.lblSubstrateFlow(iitem,1));
  end

  handles.lblSubstrateFlow= [];
end

if isfield(handles, 'lblSubstrateFlowRange') && ~isempty(handles.lblSubstrateFlowRange)

  for iitem= 1:size(handles.lblSubstrateFlowRange, 1)
      delete(handles.lblSubstrateFlowRange(iitem,1));
  end

  handles.lblSubstrateFlowRange= [];
end

if isfield(handles, 'lblSubstrateFlowUnit') && ~isempty(handles.lblSubstrateFlowUnit)
  delete(handles.lblSubstrateFlowUnit);
  handles.lblSubstrateFlowUnit= [];
end

%%
% delete pump flux fields
% name      range      unit

if isfield(handles, 'lblPumpFlux') && ~isempty(handles.lblPumpFlux)
  delete(handles.lblPumpFlux);
  handles.lblPumpFlux= [];
end

if isfield(handles, 'lblPumpFluxRange') && ~isempty(handles.lblPumpFluxRange)

  for iitem= 1:size(handles.lblPumpFluxRange, 1)
      delete(handles.lblPumpFluxRange(iitem,1));
  end

  handles.lblPumpFluxRange= [];
end

if isfield(handles, 'lblPumpFluxUnit') && ~isempty(handles.lblPumpFluxUnit)
  delete(handles.lblPumpFluxUnit);
  handles.lblPumpFluxUnit= [];
end

%%

handles= nmpc_actualizeGui(handles);

%%


