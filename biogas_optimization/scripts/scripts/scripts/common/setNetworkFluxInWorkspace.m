%% setNetworkFluxInWorkspace
% Write the network flux (substrate flow and pump flow) arrays in the
% selected workspace.
%
function [substrate_network]= setNetworkFluxInWorkspace(equilibrium, ...
                    lenGenomSubstrate, lenGenomPump, ...
                    substrate, plant, substrate_network, varargin)
%% Release: 1.3

%%

error( nargchk(6, 8, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% read out varargin

if nargin >= 7 && ~isempty(varargin{1}), 
  accesstofile= varargin{1}; 
  isZ(accesstofile, 'accesstofile', 7, -1, 1);
else
  accesstofile= -1;
end

if nargin >= 8 && ~isempty(varargin{2})
  control_horizon= varargin{2};
  %% TODO
  % in NMPC I only allow natural numbers
  isR(control_horizon, 'control_horizon', 8, '+');
else
  control_horizon= lenGenomSubstrate*7;
end


%%
% check input params

is_equilibrium(equilibrium, '1st');

isN(lenGenomSubstrate, 'lenGenomSubstrate', 2);
isN(lenGenomPump, 'lenGenomPump', 3);
is_substrate(substrate, 4);
is_plant(plant, 5);
is_substrate_network(substrate_network, 6, substrate, plant);

%% 
% set NetworkFlux for Substrate Mix

n_substrate= substrate.getNumSubstratesD();


%%
% get substrate feed out of equilibrium and save it to volumeflow files or
% variables
[substrate_feed, volumeflows]= get_feed_oo_equilibrium_and_save_to(equilibrium, ...
  substrate, plant, accesstofile, control_horizon, lenGenomSubstrate);


%%
% write flow for substrates in given workspace

for isubstrate= 1:n_substrate
  
  volumeflow= volumeflows((isubstrate - 1)*lenGenomSubstrate + 1:isubstrate*lenGenomSubstrate, :);
  volumeflow= volumeflow';
  
  %% 
  % determine the new substrate mix
  if sum(volumeflow) > 0
    
    %%
    
    if (lenGenomSubstrate == 1)
      substrate_network(isubstrate, 1:end)= ...
                                      volumeflow' / sum(volumeflow);
    else
      %% 
      % wenn 2 oder mehr fermenter gefüttert werden und das verhältnis
      % über den control horizont sich verändert, dann wird das hier
      % nicht richtig modelliert
      % Wenn Substrate wirklich entkoppelt sein sollen, dann muss man diese
      % für jeden einzelnen Fermenter seperat modellieren. Allerdings ist
      % das hier meistens kein Problem, wenn man nur 2 Fermenter hat und
      % einer davon der nicht gefütterte Nachgärer ist. Falls anders, dann
      % gibt es immer eine Kopplung zwischen der Fütterung der Fermenter
      % durch |substrate_network|. Es wird dann wie hier berechnet der
      % Mittelwert der Verteilung über dem Regelungshorizont gewählt
      
      substrate_network(isubstrate, 1:end)= ...
                        sum(volumeflow, 2)' / sum(sum(volumeflow));
    end
    
  end % if
    
end % for isubstrate


%%
% save substrate_network to file or some workspace
save_substrate_network_to(substrate_network, char(plant.id), accesstofile);


%%
% get (recirculation) sludge out of equilibrium and save it to file or
% workspace
get_sludge_oo_equilibrium_and_save_to(equilibrium, substrate, ...
  plant, accesstofile, control_horizon, lenGenomSubstrate, lenGenomPump);

%%


