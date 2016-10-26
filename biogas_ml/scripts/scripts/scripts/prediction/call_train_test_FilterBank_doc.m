
%%

global PUBLISH_FLAG;

%%

if isempty(PUBLISH_FLAG)
  %%
  % 0 is complete
  % 1 is fast
  %% TODO - back to 1
  set= 0; % 0
else
  return;
end

%%

disp(PUBLISH_FLAG)
%error('Ignored PUBLISH_FLAG during publication');

%%

diary on;

%%

try
  
  train_applyFilterBankToDataStream_doc

  test_applyFilterBankToDataStream_doc

catch ME
  
  disp(ME.message);
  
  save('X_training.mat', 'X', '-v7.3');

  save('YU_training.mat', 'YU', '-v7.3');
  
  save('ind_test_data.mat', 'ind_test_data', '-v7.3');
  
end

%%

diary off;
  
shutdown(120);

%%


