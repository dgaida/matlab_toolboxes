%% optimization.RL.RLearner
% doc optimization.RL.RLearner
%
% Definition of a basic Reinforcement learner.
%
classdef RLearner
%% Release: 0.8

  %% Properties (private)
  %
  properties (SetAccess= private)

      % current state s, needed to check, if we are
      % still in this state or if we are already in the new state s'
      s;

      % action value function
      Q;

      % eligibility trace
      trace;

      % grid of state space
      stategrid;

      % action list
      actionlist;

      % learning rate, double scalar
      alpha;

      % discount factor, double scalar
      gamma;

      % the decaying elegibiliy trace parameter, double scalar
      lambda;

      % probability of a random action selection, double scalar
      epsilon;

      % max number of steps in one episode, double scalar integer
      maxSteps;

      % set of transition probability 
      Ps_ss_a;



  end % Properties (private)



  %% Methods (public)
  %
  methods (Access= public)

    %%
    %
    function obj= RLearner(varargin)
      %
      % Standard Constructor
      %
      % @param 
      % 
      
      %%
      
      error( nargchk(0, 7, nargin, 'struct') );
      error( nargoutchk(0, 1, nargout, 'struct') );
      
      %%

      if nargin >= 1,
          LB= varargin{1};
      else
          LB= [];
      end

      if nargin >= 2,
          UB= varargin{2};
      else
          UB= [];
      end

      if nargin >= 3 && ~isempty(varargin{3}),
          size_u= varargin{3};
      else
          error('The 3rd parameter ''number of individuals'' must be given!');
      end

      if nargin >= 4 && ~isempty(varargin{4}),
          nSamples= varargin{4};
      else
          nSamples= 10;
      end

      if nargin >= 5 && ~isempty(varargin{5}),
          change= varargin{5};
      else
          if (nSamples > 1)
              change= numerics.math.round_float( 10 / ( nSamples - 1 ), 1 );
          else
              change= 1;
          end
      end

      if nargin >= 6 && ~isempty(varargin{6}),
          p_epsilon= varargin{6};
      else
          p_epsilon= 0.15;%0.5
      end

      if nargin >= 7 && ~isempty(varargin{7}),
          usePs_ss_a= varargin{7};
      else
          usePs_ss_a= 0;%1
      end


      %%

      obj.maxSteps= 500;  % maximum number of steps per episode

      %

      % the list of states
      obj.stategrid= buildStateGrid(obj, LB, UB, nSamples);  

      % the list of actions
      obj.actionlist= buildActionList(obj, size_u, change); 

      nStates  = size(obj.stategrid, 1);
      nActions = size(obj.actionlist, 1);

      if exist('Q.mat', 'file')
          Qsave= load_file('Q.mat');

          obj.Q= buildQTable(obj, nStates, nActions, Qsave ); 
      else
          % the QTable
          obj.Q= buildQTable(obj, nStates, nActions, 0 );  
      end

      % the elegibility trace
      obj.trace= buildQTable(obj, nStates, nActions );  

      %

      if (usePs_ss_a)
          if exist('Ps_ss_a.mat', 'file')
              Ps_ss_a_save= load_file('Ps_ss_a.mat');

              obj.Ps_ss_a= buildTransProb( obj, nStates, ...
                                           nActions, Ps_ss_a_save );
          else
              obj.Ps_ss_a= buildTransProb( obj, nStates, nActions );
          end
      else
          obj.Ps_ss_a= [];
      end

      %

      % learning rate
      obj.alpha  = 0.5;   
      % discount factor
      obj.gamma  = 0.9;
      % the decaying elegibiliy trace parameter
      obj.lambda = 0.75;   
      % probability of a random action selection
      obj.epsilon= p_epsilon;  

      %%



    end


    %%
    % sets the state s, the current state
    %
    function obj= set_s(obj, s)

        if isnumeric(s) && ~any(size(obj.s) - size(s))

            obj.s= s;

        else

            error('Size of parameter s is not correct!');

        end

    end


    %%
    % returns the state s, the current state
    %
    function s= get_s(obj)

        s= obj.s;

    end


    %%
    % returns the stategrid
    %
    function stategrid= getStateGrid(obj)

        stategrid= obj.stategrid;

    end


  end % end Methods (public)



  %% Methods (protected)
  %
  methods (Access= protected)

      %%
      % sets Q
      %
      function obj= set_Q(obj, Q)

          if isnumeric(Q) && ~any(size(obj.Q) - size(Q))

              obj.Q= Q;

          else

              error('Size of parameter Q is not correct!');

          end

      end


      %%
      % sets trace
      %
      function obj= set_trace(obj, trace)

          if isnumeric(trace) && ~any(size(obj.trace) - size(trace))

              obj.trace= trace;

          else

              error('Size of parameter trace is not correct!');

          end

      end


      %%
      % sets Ps_ss_a
      %
      function obj= set_Ps_ss_a(obj, Ps_ss_a)

          if isnumeric(Ps_ss_a) && ~any(size(obj.Ps_ss_a) - size(Ps_ss_a))

              obj.Ps_ss_a= Ps_ss_a;

          else

              error('Size of parameter Ps_ss_a is not correct!');

          end

      end


  end % end Methods (protected)



  %% Methods (protected)
  methods (Access= protected)

      %%
      %
      s= discretizeState( obj, x, statelist )


      %%
      %
      [a, greedy]= e_greedy_selection(obj, Q, s, epsilon)


      %%
      %
      [Q, trace]= updateSARSA_e( obj, s, a, r, sp, ap, Q, ...
                                 trace, alpha, gamma, lambda )


  end



  %% Methods (private)
  methods (Access= private)

      %%
      %
      stategrid= buildStateGrid(obj, LB, UB, nSamples)


      %%
      %
      actionlist= buildActionList(obj, change)


      %%
      %
      Q= buildQTable(obj, nStates, nActions )


      %%
      %
      [ a ]= getBestAction( obj, Q, s )


      %%
      %



  end % end Methods (private)
            
end % end class

%%


