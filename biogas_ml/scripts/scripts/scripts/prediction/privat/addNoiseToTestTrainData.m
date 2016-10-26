%% addNoiseToTestTrainData
% Add normally distributed noise to test and train data
%
function [traindata, testdata]= addNoiseToTestTrainData(traindata, testdata, varargin)
%% Release: 0.9

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  error_scl= varargin{1};
  isR(error_scl, 'error_scl', 4, '+');
else
  error_scl= 0.01;
end

%%
% check arguments

checkArgument(traindata, 'traindata', 'double', '1st');
checkArgument(testdata, 'testdata', 'double', '2nd');

%%

if(0)

%             error_vec= mean(testdata(:,2:end)) .* 0.01;
%             
%             error_vec(1:7)= 0*0.1;
%             error_vec(8:14)= 0;
%             error_vec(15:21)= 0;
%             %error_vec(22:28)= 0;
%             error_vec(29:end)= 0;

  %% TODO
  % change rand to randn

  % eigentlich wird prozentualer Fehler auf ganzen Messbereich, also der
  % oberen grenze, bezogen und nicht auf jeden wert einzeln
  
  err_matrix= rand(size(testdata,1), size(testdata,2) - 1) .* ...
              error_scl .* testdata(:,2:end);

%             testdata(:,2:end)= ...
%                 testdata(:,2:end) + rand(size(testdata, 1), 1) * ...
%                 error_vec;

  err_matrix(:,8:end)= 0;   % only add error to pH values (first 7 columns) 
  % and the rest of the error is 0

  testdata(:,2:end)= testdata(:,2:end) + err_matrix;

  %%

%             traindata(:,2:end)= ...
%                 traindata(:,2:end) + rand(size(traindata, 1), 1) * ...
%                 error_vec;

  %% TODO
  % change rand to randn
  
  err_matrix= rand(size(traindata,1), size(traindata,2) - 1) .* ...
              error_scl .* traindata(:,2:end);

  err_matrix(:,8:end)= 0;   % only add error to pH values (first 7 columns) 
  % and the rest of the error is 0

  traindata(:,2:end)= traindata(:,2:end) + err_matrix;

end

%%


