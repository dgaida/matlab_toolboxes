%% callDNNforStateEstimation
%
%
function [perf_temp]= callDNNforStateEstimation(traindata, testdata, ...
                fermenter_id, ivariable, itest, index_file, y, my_bins)

%%



%%
% check arguments

checkArgument(traindata, 'traindata', 'double', '1st');
checkArgument(testdata, 'testdata', 'double', '2nd');

%%

featurespace= size(testdata, 2) - 1;  % -1, da erste komponente die klasse ist

nodes = [featurespace 200 100 50 my_bins]; % just example!
bbdbn = randDBN( nodes, 'BBDBN' );
nrbm = numel(bbdbn.rbm);

opts.MaxIter = 1000;
opts.BatchSize = max(100, fix(size(traindata, 1) / opts.MaxIter));
opts.Verbose = true;
opts.StepRatio = 0.1;
opts.object = 'CrossEntropy';

%%
% one-hot encoding for test and training labels

TrainLabels1hot= zeros( size(traindata, 1), my_bins );

trainlabels= traindata(:,1) + 1; % one based

for i=1:my_bins
  TrainLabels1hot(i, trainlabels(i))= 1;
end

%

TestLabels1hot= zeros( size(testdata, 1), my_bins );

testlabels= testdata(:,1) + 1; % one based

for i=1:my_bins
  TestLabels1hot(i, testlabels(i))= 1;
end

%%

opts.Layer = nrbm-1;
bbdbn = pretrainDBN(bbdbn, traindata(:,2:end), opts);
bbdbn= SetLinearMapping(bbdbn, traindata(:,2:end), TrainLabels1hot);

opts.Layer = 0;
bbdbn = trainDBN(bbdbn, traindata(:,2:end), TrainLabels1hot, opts);
                
%%

rmse= CalcRmse(bbdbn, testdata(:,2:end), TestLabels1hot);

ErrorRate= CalcErrorRate(bbdbn, testdata(:,2:end), TestLabels1hot);

perf_temp= 100 - 100*ErrorRate;

%%

if ~isempty(fermenter_id)   
  %% 
  if ~(exist('DNN', 'dir') == 7)
    [status,message,messageid]= mkdir('DNN');
    if (status == 0)
      error(messageid, message);
    end
  end

  save(sprintf('DNN/dnn_model_classify_%s_v%02i_%ih_%in_%if_%it.mat', ...
       fermenter_id, ivariable, ...
       index_file{1}, index_file{2}, index_file{3}, itest), 'bbdbn');
end       

%%


