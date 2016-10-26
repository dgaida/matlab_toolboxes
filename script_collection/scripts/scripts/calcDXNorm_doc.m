%% Syntax
%       [dxNorm]= calcDXNorm(fcn)
%       [dxNorm]= calcDXNorm(fcn, norm)
%       [dxNorm]= calcDXNorm(fcn, norm, u)
%       [dxNorm, y]= calcDXNorm(...)
%
%% Description
% |dxNorm= calcDXNorm(fcn)| calculates the infinity norm of the state
% derivation vector $\frac{d}{dt}\vec{x}(t) = \vec{x}'(t)$ of the  
% Simulink model |fcn| at the current (initial) state 
% $\vec{x}_0 := \vec{x}(0)$. Current state means the initial state of the
% model at time $t= 0$. If you want to change the current state, then load
% the initial state via the Simulink model, see the 2nd example.
%
% Here we assume that the Simulink system has the form:
%
% $$\frac{d}{dt}\vec{x}(t) = \vec{f} \left( \vec{x}(t), \vec{u}(t) \right)$$
%
% Here $\vec{u}(t)$ is the input of the system, see the function argument
% |u|. 
%
% The model does not have to be load before the function is called. If it
% is load and in a changed state, then the model is saved in the beginning
% of the function using <matlab:doc('save_system') save_system>. 
%
% As the function does not close the model at the end, it is advised to do
% this manually calling <matlab:doc('close_system') close_system>, see the
% examples below. 
%
%%
% @param |fcn| : name of the Simulink model with or without the file extension
% (*.mdl) as char or cell. 
%
%%
% @return |dxNorm| : the norm of the state derivation vector
% $\frac{d}{dt}\vec{x}(t)$ of the Simulink model |fcn| at the current state
% $\vec{x}_0$ 
%
%%
% |calcDXNorm(fcn, norm)| calculates the norm |norm| of the state
% derivation vector $\vec{x}'$ at time $t= 0$, thus $\vec{x}'(0)$.
%
%%
% @param |norm| : norm to be calculated from the state derivation vector
% $\vec{x}'(0)$ as char. For some explanations about norms, see
% <http://en.wikipedia.org/wiki/Norm_%28mathematics%29 wikipedia>. 
% 
% * 'infinity' : calculates the infinity norm, which is 
%
% $$||\vec{x}'(0)||_{\infty} := max(|\vec{x}'(0)|)$$ 
%
% * '2' : calculates the 2-norm (euclidean norm) of the $N$-dimensional
% vector, which is 
%
% $$||\vec{x}'(0)||_2 := \sqrt{ \sum_{i= 1}^N{ \left( {x'}_i \right)^2(0) } }$$ 
%
% * '1' : calculates the 1-norm (manhattan norm) of the $N$-dimensional
% vector, which is 
%
% $$||\vec{x}'(0)||_1 := \sum_{i= 1}^N{ |x'_i(0)| }$$ 
%
%%
% |calcDXNorm(fcn, norm, u)| lets you specify the input of the Simulink
% model, in case the model has an input. 
% 
%%
% @param |u| : input scalar or vector of the Simulink model, double. Size
% of |u| depends on number of inputs the Simulink model has. 
%
%%
% |[dxNorm, y]= calcDXNorm(...)| additionally returns the output of the
% Simulink model |fcn| at the current state $\vec{x}_0$ 
%
%%
% @return |y| : the output of the simulink model |fcn| at the current state
% $\vec{x}_0$, which is a double scalar or vector, depending on the number
% of outputs of the model. 
%
%% Example
%
% Calculate infinity norm of two PT1 blocks at their initial state, which in
% this case are 0 and 5. As the slope of a PT1 block only depends on its
% input and its initial state (more accurate: the difference between input
% and initial state), the infinity norm of the first will be as is the
% input, here it is 5. For the second PT1 block the slope is 0, because the
% input and the initial state are the same, thus the block is already in
% equilibrium. So in total the infinity norm of both blocks together is 5. 
%

try
  dxNorm= calcDXNorm('PT1', 'infinity', [5 5]);
  
  fprintf('max( x''(0) )= %.2f\n', dxNorm);

  close_system('PT1', 0);
catch ME
  close_system('PT1', 0);
  
  disp(ME.message);
end

%%
% Calculate euclidean norm of the same model, this time the inputs are 3.
% For the first block the slope is 3, and for the second it is -2. 
%
% And calculate manhattan norm. The Manhattan norm is just |3| + |-2| = 5.

try
  [dxNorm, y]= calcDXNorm('PT1', '2', [3 3]);
  
  fprintf('sqrt( x_1^2''(0) + x_2^2''(0) )= %.2f\n', dxNorm);

  [dxNorm, y]= calcDXNorm('PT1', '1', [3 3]);
  
  fprintf('|x_1''(0)| + |x_2''(0)|= %.2f\n', dxNorm);
  
  close_system('PT1', 0);
catch ME
  close_system('PT1', 0);
  
  disp(ME.message);
end


%% Dependencies
%
% This method calls:
%
% <html>
% <a href="matlab:doc('matlab/feval')">
% matlab/feval</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save_system')">
% matlab/save_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/get_stack_trace')">
% script_collection/get_stack_trace</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/set_param')">
% matlab/set_param</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('simbiogasplant')">
% simBiogasPlant</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('matlab/close_system')">
% matlab/close_system</a>
% </html>
%
%% TODOs
% # create documentation for script
%
%% <<AuthorTag_DG/>>


