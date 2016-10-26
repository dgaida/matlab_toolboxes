%% mm_callActualizeGUI
%
%
%% Toolbox
% |mm_callActualizeGUI| belongs to the _Biogas Plant Modeling_ Toolbox
% and is an internal function.
%
%% Release
% Approval for Release 1.1, to get the approval for Release 1.2 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       handles= mm_callActualizeGUI(handles)
%
%% Description
% |handles= mm_callActualizeGUI(handles)|.
% GUI <set_input_stream_min_max.html set_input_stream_min_max>.
%
%%
% @param |handles| : handle of gui
%
%%
% @return |handles| : handle of gui
%
%% Example
%
% 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="mm_actualizeGui.html">
% mm_actualizeGui</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="mm_btnPath_Callback.html">
% mm_btnPath_Callback</a>
% </html>
% ,
% <html>
% <a href="set_input_stream_min_max.html">
% set_input_stream_min_max</a>
% </html>
% 
%% See Also
%
%
%% TODOs
%
%
%% Author
% Daniel Gaida, M.Sc.EE.IT
%
% Cologne University of Applied Sciences (Campus Gummersbach)
%
% Department of Automation & Industrial IT
%
% GECO-C Group
%
% daniel.gaida@fh-koeln.de
%
% Copyright 2010-2011
%
% Last Update: 17.10.2011
%
%% Function
%
function handles= mm_callActualizeGUI(handles)

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 1st parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%
   
if isfield(handles, 'lblSubstrateFlow') && ~isempty(handles.lblSubstrateFlow)
    delete(handles.lblSubstrateFlow);
    handles.lblSubstrateFlow= [];
end

if isfield(handles, 'txtSubstrateFlowMin') && ~isempty(handles.txtSubstrateFlowMin)
    
    for iitem= 1:size(handles.txtSubstrateFlowMin, 1)
        delete(handles.txtSubstrateFlowMin(iitem,1));
    end
    
    handles.txtSubstrateFlowMin= [];
end

if isfield(handles, 'txtSubstrateFlowMax') && ~isempty(handles.txtSubstrateFlowMax)
    
    for iitem= 1:size(handles.txtSubstrateFlowMax, 1)
        delete(handles.txtSubstrateFlowMax(iitem,1));
    end
    
    handles.txtSubstrateFlowMax= [];
end

if isfield(handles, 'lblSubstrateFlowUnit') && ~isempty(handles.lblSubstrateFlowUnit)
    delete(handles.lblSubstrateFlowUnit);
    handles.lblSubstrateFlowUnit= [];
end

%%

if isfield(handles, 'radPanFermenter') && ~isempty(handles.radPanFermenter)
    
  for iitem= 1:size(handles.radPanFermenter, 1)
      delete(handles.radPanFermenter(iitem,1));
  end

  %delete(handles.radPanFermenter);

  handles.radPanFermenter= [];

  %%

  for iitem= 1:size(handles.lblSubstrateFlowMin, 1)
      delete(handles.lblSubstrateFlowMin(iitem,1));
  end

  handles.lblSubstrateFlowMin= [];

  %%

  for iitem= 1:size(handles.lblSubstrateFlowMax, 1)
      delete(handles.lblSubstrateFlowMax(iitem,1));
  end

  handles.lblSubstrateFlowMax= [];

end

%%

if isfield(handles, 'lblPumpFlux') && ~isempty(handles.lblPumpFlux)
    delete(handles.lblPumpFlux);
    handles.lblPumpFlux= [];
    
    delete(handles.lblPumpFluxMin);
    handles.lblPumpFluxMin= [];
    
    delete(handles.lblPumpFluxMax);
    handles.lblPumpFluxMax= [];
    
end

%%

if isfield(handles, 'txtPumpFluxMin') && ~isempty(handles.txtPumpFluxMin)
    
    for iitem= 1:size(handles.txtPumpFluxMin, 1)
        delete(handles.txtPumpFluxMin(iitem,1));
    end
    
    handles.txtPumpFluxMin= [];
end

if isfield(handles, 'txtPumpFluxMax') && ~isempty(handles.txtPumpFluxMax)
    
    for iitem= 1:size(handles.txtPumpFluxMax, 1)
        delete(handles.txtPumpFluxMax(iitem,1));
    end
    
    handles.txtPumpFluxMax= [];
end

if isfield(handles, 'lblPumpFluxUnit') && ~isempty(handles.lblPumpFluxUnit)
    delete(handles.lblPumpFluxUnit);
    handles.lblPumpFluxUnit= [];
end

%%

set(handles.mm_btnSave, 'enable', 'on');

%%

handles= mm_actualizeGui(handles);

%%


