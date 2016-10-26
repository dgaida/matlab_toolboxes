%% create_substrate_cell
%
%
function substrates= create_substrate_cell(varargin)
%% Release: 0.0

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

TS_maize= create_rand_signal(10, 4, [21 29], 'linear');
TS_maize= [25.2; TS_maize; 25.2];

%%

pH_maize= create_rand_signal(10, 4, [3.5 4.1], 'linear');
pH_maize= [3.8; pH_maize; 3.8];

%%

TS_bullmanure= create_rand_signal(10, 4, [8.1 9.7], 'linear');
TS_bullmanure= [8.9; TS_bullmanure; 8.9];

%%

pH_bullmanure= create_rand_signal(10, 4, [6.8 7.5], 'linear');
pH_bullmanure= [7.2; pH_bullmanure; 7.2];

%%

NH4N_bullmanure= create_rand_signal(10, 4, [1.3 2.1], 'linear');
NH4N_bullmanure= [1.7; NH4N_bullmanure; 1.7];

%%

% clear;
% close all;
% clc;

%%

load('substrate_params.mat')

%%

substrates= cell(numel(TS_maize), 1);

%%

for iel= 1:numel(TS_maize)

  % damit immer wieder ein neues substrate Objekt erstellt wird
  substrate= load_biogas_mat_files('sunderhook');

  %%

  for isubstrate= 1:2
  
    %%
    
    if isubstrate == 1
      substrate_name= 'maize1';
    else
      substrate_name= 'bullmanure';
    end

    %%

    if isubstrate == 1
      substrate.get(substrate_name).set_params_of(...
        'TS', science.physValue('TS', TS_maize(iel), '% FM'), ...
        'pH', science.physValue('pH', pH_maize(iel)));
    else
      substrate.get(substrate_name).set_params_of(...
        'TS', science.physValue('TS', TS_bullmanure(iel), '% FM'), ...
        'pH', science.physValue('pH', pH_bullmanure(iel)), ...
        'Snh4', science.physValue('Snh4', NH4N_bullmanure(iel), 'g/l'));
    end
    
    %%
    % da CSB von TS abhängt, hier berechnen und CSB setzen
    %% TODO, warum macht man das nicht schon intern?

    COD_c= biogas.substrate.calcXc(substrate.get(substrate_name));

    %% TODO 
    % 0.3

    COD_c= COD_c.Value;

    substrate.get(substrate_name).set_params_of('COD',  COD_c);
    substrate.get(substrate_name).set_params_of('COD_S', 0.3 .* COD_c);   

  end

  %%

  substrates{iel}= substrate;

  %%
  
end

%%

index= 12;%3;

%%

for isubstrate= 1:2

  %%

  if isubstrate == 1
    substrate_name= 'maize1';
  else
    substrate_name= 'bullmanure';
  end

  %%

  substrates{index}.get(substrate_name).print()

  if isubstrate == 1
    TS_maize(index)
    pH_maize(index)
  else
    TS_bullmanure(index)
    pH_bullmanure(index)
    NH4N_bullmanure(index)
  end

end

%%



%%



%%

