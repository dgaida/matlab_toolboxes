%% call_listSubstrate
% Sets text fields showing the parameters of the substrates.
%
function handles= call_listSubstrate(handles)
%% Release: 1.7

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(1, 1, nargout, 'struct') );

%%
% check input params

checkArgument(handles, 'handles', 'struct', '1st');

%%

contents= get(handles.listSubstrate,'String');
index= min(get(handles.listSubstrate,'Value'), size(contents,1));

if isempty(index) || index == 0
  index= 1;
end

set(handles.listSubstrate, 'Value', index);

%%

if ~isempty(contents)

  %%
  
  substratename= char(contents{ index });

  set(handles.lblSubstrateName, 'String', substratename);

  mySubstrate= handles.substrate.get(index);

  %%
  %

  set(handles.txtpHvalue,    'String', mySubstrate.get_param_of('pH'));
  set(handles.txtCSBtotal,   'String', mySubstrate.get_param_of('COD'));
  set(handles.txtCSBfilter,  'String', mySubstrate.get_param_of('COD_S'));
  set(handles.txtAlkalinity, 'String', mySubstrate.get_param_of('TAC'));

  set(handles.txtoTS,        'String', mySubstrate.get_param_of('VS'));
  set(handles.txtNH4,        'String', mySubstrate.get_param_of('Snh4'));                     
  set(handles.txtTS,         'String', mySubstrate.get_param_of('TS'));
  set(handles.txtT,          'String', mySubstrate.get_param_of('T'));
  set(handles.txtDichte,     'String', mySubstrate.get_param_of('rho'));

  set(handles.txtRohfaser,   'String', mySubstrate.get_param_of('RF'));
  set(handles.txtRohfett,    'String', mySubstrate.get_param_of('RL'));
  set(handles.txtRohprotein, 'String', mySubstrate.get_param_of('RP'));
  set(handles.txtNDF,        'String', mySubstrate.get_param_of('NDF'));
  set(handles.txtADF,        'String', mySubstrate.get_param_of('ADF'));
  set(handles.txtADL,        'String', mySubstrate.get_param_of('ADL'));

  set(handles.txtfCH_XC, 'String', ...
    numerics.math.round_float( mySubstrate.get_param_of_d('fCh_Xc'), 3));
  set(handles.txtfPR_XC, 'String', ...
    numerics.math.round_float( mySubstrate.get_param_of_d('fPr_Xc'), 3));
  set(handles.txtfLI_XC, 'String', ...
    numerics.math.round_float( mySubstrate.get_param_of_d('fLi_Xc'), 3));  
  set(handles.txtfSI_XC, 'String', ...
    numerics.math.round_float( mySubstrate.get_param_of_d('fSI_Xc'), 3));
  set(handles.txtfXI_XC, 'String', ...
    numerics.math.round_float( mySubstrate.get_param_of_d('fXI_Xc'), 3));
  set(handles.txtfXP_XC, 'String', ...
    numerics.math.round_float( mySubstrate.get_param_of_d('fXp_Xc'), 3));              

  set(handles.txtPropion, 'String', mySubstrate.get_param_of('Spro'));     
  set(handles.txtEssig,   'String', mySubstrate.get_param_of('Sac'));     
  set(handles.txtButter,  'String', mySubstrate.get_param_of('Sbu'));                          
  set(handles.txtValerian,'String', mySubstrate.get_param_of('Sva')); 
  
  set(handles.txtCosts,   'String', mySubstrate.get_param_of('cost'));

  substrate_class= char(mySubstrate.get_param_of_s('substrate_class'));
  subs_index= biogas.substrate.getIndexOfSubstrateClass(substrate_class);
  
  if (subs_index > 0 && subs_index <= numel(cellstr(get(handles.popSubstrateClass, 'String'))))
    set(handles.popSubstrateClass, 'Value', subs_index);
  end
  
else

  set(handles.lblSubstrateName, 'String', '-');

  set(handles.txtpHvalue,    'String', '-');
  set(handles.txtCSBtotal,   'String', '-');
  set(handles.txtCSBfilter,  'String', '-');
  set(handles.txtAlkalinity, 'String', '-');

  set(handles.txtoTS,        'String', '-');
  set(handles.txtNH4,        'String', '-');                     
  set(handles.txtTS,         'String', '-');
  set(handles.txtT,          'String', '-');
  set(handles.txtDichte,     'String', '-');

  set(handles.txtRohfaser,   'String', '-');
  set(handles.txtRohprotein, 'String', '-');
  set(handles.txtRohfett,    'String', '-');
  set(handles.txtNDF,        'String', '-');
  set(handles.txtADF,        'String', '-');
  set(handles.txtADL,        'String', '-');

  set(handles.txtPropion,    'String', '-');
  set(handles.txtEssig,      'String', '-');
  set(handles.txtButter,     'String', '-');
  set(handles.txtValerian,   'String', '-');

  set(handles.txtfCH_XC,     'String', '-');
  set(handles.txtfPR_XC,     'String', '-');
  set(handles.txtfLI_XC,     'String', '-');
  set(handles.txtfSI_XC,     'String', '-');
  set(handles.txtfXI_XC,     'String', '-');
  set(handles.txtfXP_XC,     'String', '-');

  set(handles.txtCosts,      'String', '-');
  
  substrate_class= 'miscellaneous';
  set(handles.popSubstrateClass, 'Value', ...
      biogas.substrate.getIndexOfSubstrateClass(substrate_class));

end

%%


