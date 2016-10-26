%% gui_plant_fermsave_but_Callback
% Callback of button fermsave, fermcancel and fermreset on panel for
% fermenter on <gui_plant.html |gui_plant|> 
%
function gui_plant_fermsave_but_Callback(hObject, eventdata, handles)
%% Release: 1.1

% hObject    handle to cmdSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

handles= guidata(hObject);

%%

if ~isstruct(handles)
  error(['The 3rd parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%

userdata= get(hObject, 'userdata');

%%

%%
% fermenter general settings
if isfield(handles.f_edit, 'f_name')
   
  % dann wurde ok gedrückt, sosnt cancel
  if userdata == 1

    fName_new=            get(handles.f_edit.f_name, 'String');
    fVtot_new= str2double(get(handles.f_edit.f_Vtot, 'String'));
    fVliq_new= str2double(get(handles.f_edit.f_Vliq, 'String'));
    fVgas_new= str2double(get(handles.f_edit.f_Vgas, 'String'));
    fT_new=    str2double(get(handles.f_edit.f_T,    'String'));
    fAtot_new= str2double(get(handles.f_edit.f_Atot, 'String'));

    if isnan(fAtot_new) || isnan(fVtot_new) || isnan(fVliq_new) || ...
       isnan(fVgas_new) || isnan(fT_new)
      errordlg('only numeric values, except Name as string', ...
          'Bad Input','modal');
      uicontrol(hObject);
      return;
    end

    if fVtot_new < fVliq_new + fVgas_new
      errordlg('V_tot must be greater equal the sum of V_liq and V_gas!', ...
               'Bad Input', 'modal');
      uicontrol(hObject);
      return;
    end
    
    if ~ischar(fName_new)
      errordlg('You must enter a string value for "Name"', ...
          'Bad Input','modal');
      uicontrol(hObject);
      return;
    end

    handles.workspace.plant.setDigesterParam(handles.f_id_select, 'name', fName_new);
    handles.workspace.plant.setDigesterParam(handles.f_id_select, 'Vtot', fVtot_new);
    handles.workspace.plant.setDigesterParam(handles.f_id_select, 'Vliq', fVliq_new);
    handles.workspace.plant.setDigesterParam(handles.f_id_select, 'Vgas', fVgas_new);
    handles.workspace.plant.setDigesterParam(handles.f_id_select, 'T',    fT_new);
    handles.workspace.plant.setDigesterParam(handles.f_id_select, 'Atot', fAtot_new);

  elseif userdata == 2 % reset

    set(handles.f_edit.f_name,'String', ...
        char(handles.workspace.plant.getDigesterName(handles.f_id_select)));
    set(handles.f_edit.f_Vtot,'String', ...
        handles.workspace.plant.getDigesterParam(handles.f_id_select, 'Vtot'));
    set(handles.f_edit.f_Vliq,'String', ...
        handles.workspace.plant.getDigesterParam(handles.f_id_select, 'Vliq'));
    set(handles.f_edit.f_Vgas,'String', ...
        handles.workspace.plant.getDigesterParam(handles.f_id_select, 'Vgas'));
    set(handles.f_edit.f_T,'String', ...
        handles.workspace.plant.getDigesterParam(handles.f_id_select, 'T'));
    set(handles.f_edit.f_Atot,'String', ...
        handles.workspace.plant.getDigesterParam(handles.f_id_select, 'Atot'));

  end

end


%%

%%
% fermenter inflow settings
if (...%isfield(handles,'f_inflow') && 
        isfield(handles.f_edit,'f_inf_amount'))
    
  % dann wurde ok gedrückt, sosnt cancel
  if userdata == 1 && 0 %% TODO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

    %the folowing commands are seperated for later failure handling
    f_inf_amount_new=get(handles.f_edit.f_inf_amount,'String');
    handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.amount=f_inf_amount_new;
    
    f_inf_liftheight_new=str2double(get(handles.f_edit.f_inf_liftheight,'String'));
    handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.liftingheight=f_inf_liftheight_new;
    
    f_inf_distance_new=str2double(get(handles.f_edit.f_inf_distance,'String'));
    handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.distance=f_inf_distance_new;
    
    f_inf_mu_new=str2double(get(handles.f_edit.f_inf_mu,'String'));
    handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.mu=f_inf_mu_new;
    
    f_inf_power_new=str2double(get(handles.f_edit.f_inf_power,'String'));
    handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.power=f_inf_power_new;
    
    f_inf_maxflow_new=str2double(get(handles.f_edit.f_inf_maxflow,'String'));
    handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.maxflow=f_inf_maxflow_new;
    
    f_inf_minflow_new=str2double(get(handles.f_edit.f_inf_minflow,'String'));
    handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.minflow=f_inf_minflow_new;
    
    f_inf_eta_new=str2double(get(handles.f_edit.f_inf_eta,'String'));
    handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.eta=f_inf_eta_new;

  elseif userdata == 2 && 0 %% TODO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    set(handles.f_edit.f_inf_amount,'String', ...
        handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.amount);
    
    set(handles.f_edit.f_inf_liftheight,'String', ...
        handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.liftingheight);
    
    set(handles.f_edit.f_inf_distance,'String', ...
        handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.distance);
    
    set(handles.f_edit.f_inf_mu,'String', ...
        handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.mu);
    
    set(handles.f_edit.f_inf_power,'String', ...
        handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.power)
    
    set(handles.f_edit.f_inf_maxflow,'String', ...
        handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.maxflow);
    
    set(handles.f_edit.f_inf_minflow,'String', ...
        handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.minflow);
    
    set(handles.f_edit.f_inf_eta,'String', ...
        handles.workspace.plant.fermenter.( ...
        handles.f_id_select).inflow.pump.eta);
    
  end
    
end

%%
% fermenter heating settings
if (...%isfield(handles,'f_heat') && 
        isfield(handles.f_edit,'f_heat_eta'))
    
  % dann wurde ok gedrückt, sosnt cancel
  if userdata == 1
    
    %the folowing commands are seperated for later failure handling
    f_heat_eta_new=str2double(get(handles.f_edit.f_heat_eta, 'String'));
    f_heat_hth_new=str2double(get(handles.f_edit.f_heat_hth, 'String'));
    
    handles.workspace.plant.setDigesterParam( ...
            handles.f_id_select, 'eta', f_heat_eta_new);
    
    handles.workspace.plant.setDigesterParam( ...
            handles.f_id_select, 'h_th', f_heat_hth_new);

  elseif userdata == 2 % reset
            
    set(handles.f_edit.f_heat_eta,'String', ...
        handles.workspace.plant.getDigesterParamD( ...
        handles.f_id_select, 'eta'));
    
    set(handles.f_edit.f_heat_hth,'String', ...
        handles.workspace.plant.getDigesterParam( ...
        handles.f_id_select, 'h_th'));
    
  end

end

%%


%%
% if not reset

if userdata ~= 2

  %%
  % delete fields on the right side after have clicked ok or cancel

  if isfield (handles, 'f_edit')
    f_vars= fieldnames(handles.f_edit);
    f_vars_count= size(f_vars,1);
    
    for i=1:f_vars_count
      f_del=f_vars(i);
      f_del=char(f_del);

      if ishandle(handles.f_edit.(f_del))
        delete(handles.f_edit.(f_del));
        handles.f_edit= rmfield(handles.f_edit, f_del);
      end
    end
    
    handles= rmfield(handles, 'f_edit');
  end

  if isfield (handles, 'ftext')
    
    f_vars=fieldnames(handles.ftext);
    f_vars_count=size(f_vars,1);
    
    for i=1:f_vars_count
      f_del=f_vars(i);
      f_del=char(f_del);

      if ishandle(handles.ftext.(f_del))
        delete(handles.ftext.(f_del));
        handles.ftext= rmfield(handles.ftext, f_del);
      end
    end
    
    handles= rmfield(handles, 'ftext');
    clear f_del
  end

  % panel for fermenter
  if isfield(handles, 'frame1_1')
    if ishandle(handles.frame1_1)
      delete(handles.frame1_1)
    end
    handles=rmfield(handles,'frame1_1');
  end
    
  % panel for pumps
  if isfield(handles, 'frame1_2')
    if ishandle(handles.frame1_2)
      delete(handles.frame1_2)
    end
    handles=rmfield(handles,'frame1_2');
  end

  % panel for heating
  if isfield(handles, 'frame1_3')
    if ishandle(handles.frame1_3)
      delete(handles.frame1_3)
    end
    handles=rmfield(handles,'frame1_3');
  end

%   if isfield(handles,'frame2')
%     if ishandle(handles.frame2)
%       delete(handles.frame2)
%     end
%     handles=rmfield(handles,'frame2');
%   end

%   if isfield(handles,'frame2_2')
%     if ishandle(handles.frame2_2)
%       delete(handles.frame2_2)
%     end
%     handles=rmfield(handles,'frame2_2');
%   end
% 
%   if isfield(handles,'frame2_3')
%     if ishandle(handles.frame2_3)
%       delete(handles.frame2_3)
%     end
%     handles=rmfield(handles,'frame2_3');
%   end
    
    

% if isfield (handles, 'f_but')
%     f_vars=fieldnames(handles.f_but);
%     f_vars_count=size(f_vars,1);
%         for i=1:f_vars_count
%             f_del=f_vars(i);
%             f_del=char(f_del);
%             if ~strcmp(f_del,'fermsave')
%                 delete(handles.f_but.(f_del));
%             end
%         end
%      %delete(handles.fbuttons);
%   %  handles= rmfield(handles, 'f_but');
% end

  %%

  % if ishandle(handles.f_but.fermsave)
  %     delete(handles.f_but.fermsave)  
  %     handles.f_but= rmfield(handles.f_but, 'fermsave');
  % end

  if ishandle(handles.f_but.fermgeneral)
    delete(handles.f_but.fermgeneral)    
    handles.f_but= rmfield(handles.f_but, 'fermgeneral');
  end

  if ishandle(handles.f_but.ferminflow)
    delete(handles.f_but.ferminflow)    
    handles.f_but= rmfield(handles.f_but, 'ferminflow');
  end

  if ishandle(handles.f_but.fermheating)
    delete(handles.f_but.fermheating)    
    handles.f_but= rmfield(handles.f_but, 'fermheating');
  end

  % if isfield(handles,'f_but')
  %     handles=rmfield(handles,'f_but');
  % end

  %%

  if ishandle(handles.fbuttons)
    delete(handles.fbuttons);
    handles=rmfield(handles,'fbuttons');
    %set(handles.fbuttons,'Visible','off');
  end

  %%

  if isfield(handles, 'frame1')
    set(handles.frame1,'Visible','off');
  %         delete(handles.frame1)
  %         handles=rmfield(handles,'frame1');
  end


  % if isfield(handles,'fbuttons_2')
  %     set(handles.fbuttons_2,'Visible','off');
  % end
  % 
  % if isfield(handles.f_but,'fermsave_2')
  %     set(handles.f_but.fermsave_2,'Visible','off');
  % end
  % 
  % if isfield(handles,'fbuttons_3')
  %     set(handles.fbuttons_3,'Visible','off');
  % end
  % 
  % if isfield(handles.f_but,'fermsave_3')
  %     set(handles.f_but.fermsave_3,'Visible','off');
  % end

  %%
  %enable selection of fermenter and bhkw
  handles= gui_plant_enable_elements(handles, 'on');    

end

%%

try
  guidata(hObject, handles);
catch ME
  rethrow(ME);
end

%%


