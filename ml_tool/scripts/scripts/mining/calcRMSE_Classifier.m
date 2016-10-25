%% calcRMSE_Classifier
% Calc RMSE for a classification result
%
function [rmse, mse, se, e, foundValues]= calcRMSE_Classifier(foundClass, target_class, target_reg)
%% Release: 1.1

%%

narginchk(3, 3);
error( nargoutchk(0, 5, nargout, 'struct') );

%%
% check arguments

isNn(foundClass, 'foundClass', 1);
isNn(target_class, 'target_class', 2);
isRn(target_reg, 'target_reg', 3);

%%
% make column vectors

foundClass= foundClass(:);
target_class= target_class(:);
target_reg= target_reg(:);

%%
% class mean values
mean_target= zeros(numel(unique(target_class)), 1);
foundValues= zeros(numel(target_reg), 1);

%%

for iclass= 1:numel(unique(target_class))

  % -1 because class index starts at 0
  mean_target(iclass, 1)= mean( target_reg(target_class == iclass - 1, 1) );

  % foundClass starts at zero as well
  foundValues(foundClass == iclass - 1, 1)= mean_target(iclass, 1);

end

%%
% calc error, squared error, mean squared error and root mean squared error

e= foundValues - target_reg;
se= e.^2;
mse= mean(se);
rmse= sqrt(mse);

%%



%%


