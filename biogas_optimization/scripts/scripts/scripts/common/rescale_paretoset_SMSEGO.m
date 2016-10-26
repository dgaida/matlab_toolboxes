%% rescale_paretoset_SMSEGO
% Load final paretoset of SMS-EGO and rescale it to new lower and upper
% boundaries
%
function rescale_paretoset_SMSEGO(LBold, UBold, LBnew, UBnew, path2file)
%% Release: 0.5

%%

error( nargchk(5, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check arguments

%% TODO

checkArgument(path2file, 'path2file', 'char', 5);

%% TODO
% was ist mit linearen Gleichungs-Randbedingungen?

[popBiogasold]= biogasM.optimization.popBiogas(0, LBold, UBold);

[popBiogasnew]= biogasM.optimization.popBiogas(0, LBnew, UBnew);

%%
% load paretoset

filename= sprintf('%s/par_final.txt', path2file);

if ~exist(filename, 'file')

  dispMessage(sprintf('File %s does not exist!', filename), mfilename);
  return;
  
end

%%

paretoset= importdata(sprintf('%s/par_final.txt', path2file));

%%
% rescale paretoset to original feed space

feed= popBiogasold.conObj.getPointsInFullDimension(paretoset);

%%
% wenn sich anzahl zu optimierender substrate verändert hat, entweder ein
% substrat weniger oder mehr ist zu optimieren, dann stimmt spaltenzahl von
% feed nicht mehr mit popBiogasnew.nCols überein.

if size(feed, 2) ~= popBiogasnew.nCols
  
  %% TODO
  % add as parameter
  plant_id= 'geiger';
  
  [substrate, plant, plant_network, plant_network_min, plant_network_max]= ...
    load_biogas_mat_files(plant_id, [], ...
    {'substrate', 'plant', 'plant_network', ...
    'plant_network_min', 'plant_network_max'});
  
  %%
  %
  
  [popBiogasold]= biogasM.optimization.popBiogas(0, LBold, UBold, ...
    plant_network_min, plant_network_max);

  %%
  
  paretosetNew= zeros(size(feed, 1), popBiogasnew.nCols);
  
  for iind= 1:size(feed, 1)
  
    %%
    
    u= feed(iind, :);
    
    [substrateFlow]= ...
           getSubstrateFlowFromIndividual(popBiogasold, u, plant, substrate, plant_network);
  
    %% TODO
    % alles gewurschtel
    
    substrateFlow= repmat(substrateFlow, 1, plant.getNumDigestersD());
    substrateFlow(:,2:end)= 0;
    substrateFlow= substrateFlow(:)';
    
    LBnew= LBnew(:)';
    UBnew= UBnew(:)';
    
    substrateFlow= max(substrateFlow, LBnew);
    substrateFlow= min(substrateFlow, UBnew);
    
    %%
    %
    lenGenomSubstrate= popBiogasnew.pop_substrate.lenGenom;
    
    uNetworkSubstrateFlux= ...
      getIndividualByMask(popBiogasnew, ...
      numel(popBiogasnew.pop_substrate.substrate_network_min) * lenGenomSubstrate, ...
      popBiogasnew.pop_substrate.substrate_ineq(:, 1:end - 1), ...
      popBiogasnew.pop_substrate.substrate_eq(:, 1:end - 1), ...
      popBiogasnew.pop_substrate.substrate_network_min, ...
      popBiogasnew.pop_substrate.substrate_network_max, ...
      substrateFlow, lenGenomSubstrate);
    
    %%
    
    u= popBiogasnew.conObj.getPointsInConstrainedDimension(uNetworkSubstrateFlux');
    
    %%
    
    paretosetNew(iind,:)= u;
    
  end
  
  %%
  
else
  
  %%
  % scale feed back to new subspace

  paretosetNew= popBiogasnew.conObj.getPointsInConstrainedDimension(feed);
  
end

%%
% keep the values scaled between 0 and 10. cut smaller and higher values to
% these boundaries. 

paretoset= max( min(paretosetNew, 10) , 0 );

%%
% save paretoset

dlmwrite(filename, paretoset,...
        'delimiter', '\t', 'precision', '%03.3f');

%%


