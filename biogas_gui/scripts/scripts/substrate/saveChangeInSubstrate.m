%% saveChangeInSubstrate
% Saves text values of selected substrate in substrate structure.
%
function handles= saveChangeInSubstrate(handles, index)
%% Release: 1.6

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%
% check input params

checkArgument(handles, 'handles', 'struct', '1st');

validateattributes(index, {'double'}, ...
                  {'integer', 'scalar', 'positive'}, mfilename, 'index', 2);

%%

try
  
  mySubstrate= handles.substrate.get(index);

  %%
  % check params on gui
  
  pH=    str2double(get(handles.txtpHvalue,    'String'));
  COD=   str2double(get(handles.txtCSBtotal,   'String'));
  COD_S= str2double(get(handles.txtCSBfilter,  'String'));
  TS=    str2double(get(handles.txtTS,         'String'));
  VS=    str2double(get(handles.txtoTS,        'String'));
  
  %%
  
  if COD < COD_S || COD < 0 || COD_S < 0
    errordlg(['The total COD value must be at least equal to the soluble ', ...
              'COD value and both must be positive!'], ...
              'COD value error');
    return;
  end
  
  if pH < 0 || pH > 14
    errordlg('The pH value must be between 0 and 14!', ...
             'pH value error');
    return;
  end
  
  if TS < 0 || TS > 100
    errordlg('The TS concentration must be between 0 % FM and 100 % FM!', ...
             'TS value error');
    return;
  end
  
  if VS < 0 || VS > 100
    errordlg('The VS concentration must be between 0 % TS and 100 % TS!', ...
             'VS value error');
    return;
  end
  
  %% TODO
  % add further tests for parameters
  
  %%

  mySubstrate.set_params_of('pH',    pH);
  mySubstrate.set_params_of('COD',   COD);
  mySubstrate.set_params_of('COD_S', COD_S);
  mySubstrate.set_params_of('TS',    TS);
  mySubstrate.set_params_of('VS',    VS);

  mySubstrate.set_params_of('Snh4',  str2double(get(handles.txtNH4,        'String')));
  mySubstrate.set_params_of('TAC',   str2double(get(handles.txtAlkalinity, 'String')));
  mySubstrate.set_params_of('T',     str2double(get(handles.txtT,          'String')));
  mySubstrate.set_params_of('rho',   str2double(get(handles.txtDichte,     'String')));

  mySubstrate.set_params_of('Sac',   str2double(get(handles.txtEssig,      'String')));
  mySubstrate.set_params_of('Sbu',   str2double(get(handles.txtButter,     'String')));
  mySubstrate.set_params_of('Spro',  str2double(get(handles.txtPropion,    'String')));
  mySubstrate.set_params_of('Sva',   str2double(get(handles.txtValerian,   'String')));

  mySubstrate.set_params_of('RP',    str2double(get(handles.txtRohprotein, 'String')));
  mySubstrate.set_params_of('RF',    str2double(get(handles.txtRohfaser,   'String')));
  mySubstrate.set_params_of('RL',    str2double(get(handles.txtRohfett,    'String')));
  mySubstrate.set_params_of('NDF',   str2double(get(handles.txtNDF,        'String')));
  mySubstrate.set_params_of('ADF',   str2double(get(handles.txtADF,        'String')));
  mySubstrate.set_params_of('ADL',   str2double(get(handles.txtADL,        'String')));
  mySubstrate.set_params_of('cost',  str2double(get(handles.txtCosts,      'String')));

  %%

  contents= cellstr(get(handles.popSubstrateClass,'String'));
  substrate_class= contents{get(handles.popSubstrateClass,'Value')};

  %%

  mySubstrate.set_params_of('substrate_class', substrate_class);

  %%

  disp('substrate structure changed!');

catch ME

  disp(sprintf('substrate structure not changed! error: %s', ME.message));
  
end

%%


