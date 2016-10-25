%% optimization.RL.RLearner.updateSARSA_e
% Update SARSA lambda algorithm
%
function [Q, trace]= updateSARSA_e( RLearner, s, a, r, sp, ap, Q, ...
                                    trace, alpha, gamma, lambda )
%% Release: 0.8

% UpdateQ update de Qtable and return it using SARSA
% s1: previous state before taking action (a)
% s2: current state after action (a)
% r: reward received from the environment after taking action (a) in state
%                                             s1 and reaching the state s2
% a:  the last executed action
% Q: the current Qtable
% alpha: learning rate
% gamma: discount factor
% lambda: eligibility trace decay factor
% trace : eligibility trace vector

%%

error( nargchk(11, 11, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%% TODO
% check input arguments



%%

%disp(sprintf('r= %.2f, Q(sp,ap)= %.2f, Q(s,a)= %.2f', r, ...
 %                      full(Q(sp,ap)), full(Q(s,a))));

delta= ( r + gamma * Q(sp,ap) ) - Q(s,a);

disp(['Q(s,a)= ', num2str(full(Q(s,a))), ', delta= ', num2str(full(delta))]);

% s. S. 188 replacing egibility traces
trace(s,:)= 0.0;  %optional trace reset
trace(s,a)= 1.0;

%disp(['e(s,a)= ', num2str(full(trace(s,a)))]);

%%
% for all s,a

Q= Q + alpha * delta * trace;

trace= gamma * lambda * trace;

%%


