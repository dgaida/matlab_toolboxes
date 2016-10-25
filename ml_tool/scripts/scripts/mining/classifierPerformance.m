%% classifierPerformance
% Calculate the performance of a classification result using the confusion 
% matrix returned by the classifier.
%
function [performance, err, varargout]= ...
                classifierPerformance(confusionmatrix)
%% Release: 1.8

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%

validateattributes(confusionmatrix, {'double'}, {'2d', 'nonempty', ...
                   'size', [size(confusionmatrix, 1), size(confusionmatrix, 1)]}, ...
                   mfilename, 'confusionmatrix', 1);


%%
% change from 1 to 100 %

%% 
% otherwise this would fail if conf. matrix contains NaNs

conf_test= kickNaNsoo2matrix(confusionmatrix);

if all( sum(conf_test,2) <= ones(size(conf_test,1),1) )  || ...
   numerics.math.approxEq(sum(conf_test,2), ones(size(conf_test,1),1))
  confusionmatrix= 100 .* confusionmatrix;
end

%%
% if the confusion matrix contains NaNs, then this test fails, thus check
% at the end that confusion matrix is not NaN
%
if ( any( abs( ...
     sum(confusionmatrix,2) - 100 .* ones(size(confusionmatrix,1),1) ...
             ) > 1e-6 ) && all(all(~isnan(confusionmatrix))) )
         
  disp(confusionmatrix);
  
  disp(conf_test);
  
  sum(conf_test,2)

  sum(conf_test,2) <= ones(size(conf_test,1),1)

  error('The sum of each row of the confusion matrix must be 100!');
end

%%
% performance 0st order

diag_conf= diag(confusionmatrix);

% could contain NaNs if no test data for one class is given
diag_conf= diag_conf(~isnan(diag_conf));

performance= mean(diag_conf);



err= 100 - performance;


%%
%

if nargout >= 3

  % Wahrscheinlichkeit dafür, dass man eine Klasse höher oder niedriger
  % klassifiziert hat, als zusätzliches 2. Maß. Könnte man als
  % Verwechselung 1. Ordnung bezeichnen, wenn man das Maß der
  % Hauptdiagonale als 0. Ordnung ansieht...
  %
  % führende und endende 0 wird benötigt, da sonst performance über 100 %
  % sein kann.
  %
  
  diag_conf_1= diag(confusionmatrix, -1);
  diag_conf_1= diag_conf_1(~isnan(diag_conf_1));
  
  diag_conf_2= diag(confusionmatrix, 1);
  diag_conf_2= diag_conf_2(~isnan(diag_conf_2));
  
  performance1storder= performance + ...
                       mean([0; diag_conf_1] ...
                           ) + ...
                       mean([ diag_conf_2; 0] ...
                           );

  varargout{1}= performance1storder;

end

%%

if nargout >= 4

  varargout{2}= 100 - performance1storder;
    
end

%%


