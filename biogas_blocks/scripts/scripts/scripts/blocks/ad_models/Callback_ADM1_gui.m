%% Callback_ADM1_gui
% Called by the Callback entries of the ADM1DE and ADM1xp with GUI
% block
%
function Callback_ADM1_gui(callback_id, adm1_model, plant, DEBUG, varargin)
%% Release: 1.1

%%

error( nargchk(4, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% read out varargin

if nargin >= 5 && ~isempty(varargin{1}), 
  DEBUG_DISP= varargin{1}; 
  is0or1(DEBUG_DISP, 'DEBUG_DISP', 5);
else
  DEBUG_DISP= 0;
end


%% 
% check input parameters

validatestring(callback_id, {'InitFcn', 'LoadFcn', 'StopFcn', 'ModelCloseFcn'}, ...
               mfilename, 'callback_id', 1);
validatestring(adm1_model, {'ADM1DE', 'ADM1xp'}, mfilename, 'adm1_model', 2);

%% TODO
% warning!!! the plant we get here is not the one in the model workspace
% but in the base workspace, because the callbacks are evaluated in the
% base workspace. this is different with sensors, to name an example.
is_plant(plant, 3);
is0or1(DEBUG, 'DEBUG', 4);

%%

try
  plant_mws= evalinMWS('plant');
  
  if isempty(plant_mws)
    return;
  end
catch ME
  ME.message;
end
    
%%
                       
switch callback_id
    
  case 'InitFcn' 

    %%    

    if strcmp(adm1_model, 'ADM1DE')

      try
        adm1_with_gui_setmasks(1,2,3,4);
      catch ME
        rethrow(ME);
      end

    else

      try
        adm1_with_gui_setmasks(1);
      catch ME
        rethrow(ME);
      end

    end

    %% TODO - ich muss hier anstatt showGUIs nutzen!!!!
    % create GUI 
    if DEBUG == 1                                                        

      values= get_param_error('MaskValues');                                

      fermenter_name= char(values(1)); 

      guihandle= gui_digester_combi(plant, fermenter_name);   

      plant.setDigester_gui_handle(fermenter_name, guihandle);

    end                  

  %%

  case 'ModelCloseFcn'

    %%
    % get chosen values
    values= get_param_error('MaskValues');

    %%

    if strcmp(adm1_model, 'ADM1DE')
      values(7,1)= {'on'};
    else
      values(4,1)= {'on'};
    end

    set_param_tc('MaskValues', values);

    if strcmp(adm1_model, 'ADM1DE')
      createfermenterpopup(1, 0.7, 1, 0, 'Close', 5:6);   
    else
      createfermenterpopup(1, 0.7, 1, 0, 'Close', 2:3);  
    end

  %%

  case 'LoadFcn'

    %%

    if DEBUG_DISP
      disp(['Load block ', gcb]);
    end

    %%
    % get chosen values
    values= get_param_error('MaskValues');

    %%

    if strcmp(adm1_model, 'ADM1DE')
      values(6,1)= {'on'};
      values(7,1)= {'off'};
    else
      values(3,1)= {'on'};
      values(4,1)= {'off'};
    end

    set_param_tc('MaskValues', values);

    %%

    set_param_tc('UserDataPersistent', 'on');
    
    createfermenterpopup(1, 0.7, 1, 1);   

    %%
    
    if strcmp(adm1_model, 'ADM1DE')

      createinitstatetypepopup(2, 1);  
      createdatasourcetypepopup(3, 1);

      try
        adm1_with_gui_setmasks(1,2,3,4);
      catch ME
        rethrow(ME);
      end

    else

      try
        adm1_with_gui_setmasks(1);
      catch ME
        rethrow(ME);
      end

    end

    %%

    if DEBUG_DISP
      disp(['Successfully load block ', gcb]);
    end

    %%
    % get chosen values
    values= get_param_error('MaskValues');

    if strcmp(adm1_model, 'ADM1DE')
      values(5,1)= {'on'};
      values(6,1)= {'off'};
    else
      values(2,1)= {'on'};
      values(3,1)= {'off'};
    end

    set_param_tc('MaskValues', values);
    
  %%

  case 'StopFcn'

    if DEBUG == 1                                                        

      values= get_param_error('MaskValues');
      
      fermenter_name= char(values(1));     
      
      %%
      
      guihandle= plant.getDigester_gui_handle(fermenter_name);

      if isempty(guihandle)
        error('Could not read gui_handle out of obj_digester!');
      end

      %% TODO
      % es gibt ein mismatch zwischen übergebenem plant und plant im
      % mws!
      if guihandle == 0
        guihandle= plant_mws.getDigester_gui_handle(fermenter_name);
      end

      handle= guidata(guihandle);

      % stop and delete timer
      stop(handle.tmr);
      delete(handle.tmr);

      % close figure
      if get(handle.chkCloseFigure,'Value') == 1
        delete(handle.guifig);
      end

    end                                                                  

  %%

  otherwise

    error('Unknown callback_id: %s!', callback_id);

end

%%


