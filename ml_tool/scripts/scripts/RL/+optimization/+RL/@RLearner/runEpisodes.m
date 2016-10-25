%% optimization.RL.RLearner.runEpisodes
% Runs the Reinforcement Learning episodes
%
function RLearner= runEpisodes(RLearner, fcn_Episode, nEpisodes)
%% Release: 0.8

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%% 
% check input arguments

checkArgument(fcn_Episode, 'fcn_Episode', 'function_handle', '2nd');
isN(nEpisodes, 'nEpisodes', 3);

%%

RLearner.trace(:,:)= 0.0;
    
%%

for iepisode= 1:nEpisodes    
    
  %%

  [total_reward, steps, RLearner ]= feval( fcn_Episode, RLearner );

  %%

  disp(['Episode: ', int2str(iepisode), ' steps: ', int2str(steps), ...
        ' reward: ', num2str(total_reward), ...
        ' epsilon: ', num2str(RLearner.epsilon)]);

  %%

  RLearner.epsilon= RLearner.epsilon * 0.99;

end


%%


