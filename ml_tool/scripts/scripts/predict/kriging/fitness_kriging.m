%% fitness_kriging
% Fitness function to determine optimal Kriging model for interpolation of
% given dataset
%
function [ fitness, varargout ]= ...
           fitness_kriging(inputs, outputs, validSet_index, ...
                           regMethod, corrMethod, varargin)
%% Release: 1.2

%%
%

error( nargchk(5, 8, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% Check how many optional parameters are in the function

if isempty(varargin)
  numberVarargin= 0;
else
  numberVarargin= size(varargin, 2);
end

%% 
% compute the optional parameters and set them according to their meaning

ninputs= size(inputs, 2);

noBounds= 0;

%%
%

switch numberVarargin
  case (0)
    %%
    disp('Standard values for theta and its lower and upper bounds are used.');
    theta(1, 1: ninputs)= 10;
    lob(1, 1:ninputs)= 1e-3;
    upb(1, 1:ninputs)= 20;
    disp(['The value for theta is: ', num2str(theta)]);
    disp(['The value for lob is: ', num2str(lob)]);
    disp(['The value for upb is: ', num2str(upb)]);

  case (1)
    %%
    theta= varargin{1};
    noBounds= 1;

  case (2)
    %%
    theta= varargin{1};
    disp('Wrong number of input arguments for lower and upper bound of theta!');
    disp('No bounds are set for theta.');
    noBounds= 1;

  case (3)
    %%
    theta= varargin{1};

    if ((size(varargin{2},2) == ninputs) && (size(varargin{3},2) == ninputs))
      lob= varargin{2};
      upb= varargin{3};
    else
      lob(1, 1:ninputs)= 1e-3;
      upb(1, 1:ninputs)= 20;
      disp('Dimension mismatch of lower and upper bounds for theta!');
      disp(['The value for lob is: ', num2str(lob)]);
      disp(['The value for upb is: ', num2str(upb)]);
    end

%     case (4)
%         %%
%         theta= varargin{1};
%         if ((size(varargin{2},2) == ninputs) && (size(varargin{3},2) == ninputs))
%             lob= varargin{2};
%             upb= varargin{3};
%         else
%             lob(1, 1:ninputs)= 1e-3;
%             upb(1, 1:ninputs)= 20;
%             disp('Dimension mismatch of lower and upper bounds for theta!');
%             disp(['The value for lob is: ', num2str(lob)]);
%             disp(['The value for upb is: ', num2str(upb)]);
%         end
%         
%         predictionRange= varargin{4};


  otherwise
    %%
    disp('Too many input arguments!');

    theta= [];
    fitness= [];
    model= [];

    if nargout >= 2
      varargout{1}= theta;
    end

    if nargout >= 3
      varargout{2}= model;
    end

    return;

end

%%
% Determine regression model

switch regMethod
  % constante regression \beta_0
  case 'poly0'
    regression= @regpoly0;
  case 'poly1'
    % lineare regression: \beta_0 + \beta_1 * x_1 + \beta_2 * x_2
    regression= @regpoly1;
  case 'poly2'
    % quadratische regression: \beta_0 + \beta_1 * x_1 + \beta_2 * x_2
    % + \beta_3 * x_1 * x_2 + \beta_4 * x_1^2
    regression= @regpoly2;
  otherwise
    disp('Regression method is not known to the DACE toolbox!');

    theta= [];
    fitness= [];
    model= [];

    if nargout >= 2
        varargout{1}= theta;
    end

    if nargout >= 3
        varargout{2}= model;
    end

    return;
end

%% 
% Determine Correlation model

switch corrMethod
  case 'exponential'
    correlation= @correxp;
  case 'gaussian'
    correlation= @corrgauss;
  case 'linear'
    correlation= @corrlin;
  case 'spherical'
    correlation= @corrspherical;
  case 'cubic spline'
    correlation= @corrspline;
  otherwise
    disp('Correlation method is not known to the DACE toolbox!');

    theta= [];
    fitness= [];
    model= [];

    if nargout >= 2
      varargout{1}= theta;
    end

    if nargout >= 3
      varargout{2}= model;
    end

    return;
end


%%
% k-fold cross validation

classes= unique(validSet_index);

k= numel( classes );

if (k <= 1)
  error(['k= ', num2str(k)]);
end

if (k == 2)

  % validation & training data set
  if all(classes <= 1)

    k= 1;

  else
    % könnte dann eine 2-fache kreuzvalidierung sein
    % 1 und 2
  end

end

%%

%% 
% with PSO and CMAES a Individual consists out of many individuals -> the
% swarm 

uswarm= theta;

fitness= zeros(size(uswarm, 1), 1);


%%
% evtl. parfor

for iIndividual= 1:size(uswarm, 1)

  theta= uswarm(iIndividual, :);


  %%

  for ik= 1:k

    %%
    % create test and training dataset

    test_inputs= inputs(validSet_index ~= ik, :);
    test_outputs= outputs(validSet_index ~= ik, :);

    train_inputs= inputs(validSet_index == ik, :);
    train_outputs= outputs(validSet_index == ik, :);


    %% 
    % Build up Kriging model

    if exist('dacefit', 'file') == 2

      if (noBounds == 1)
        [model, PerformanceIndex]= dacefit(train_inputs, train_outputs, ...
                                           regression, correlation, ...
                                           theta);
      else
        [model, PerformanceIndex]= dacefit(train_inputs, train_outputs, ...
                                           regression, correlation, ...
                                           theta, lob, upb);
      end

    else

      errordlg('The DACE toolbox is not installed!');
      error('The DACE toolbox is not installed!');

    end

    %%

    [pred_outputs]= predictor(test_inputs, model);

    %%

    %Q= eye( size(test_outputs, 2) );
    N= size(test_outputs, 1);

    %%

%     fitness= fitness + sqrt( 1/N .* diag( ...
%                                     ( pred_outputs - test_outputs )*Q*...
%                                     ( pred_outputs - test_outputs )' ...
%                                         ) ...
%                            );

    %%

    fitness(iIndividual,1)= fitness(iIndividual,1) + ...
                      sqrt( 1/N .* sum( ...
                                    diag( ...
                                    ( pred_outputs - test_outputs )'* ...
                                    ( pred_outputs - test_outputs ) ...
                                        ) ...
                                       ) ...
                           );                   

    %%           

  end

  %%

  fitness(iIndividual,1)= fitness(iIndividual,1) / k;


end % swarm


%%
%

varargout= [];

%% TODO
%
% hier müsste das beste model und sein theta zurück gegeben werden

if nargout >= 2
  varargout{1}= model.theta;
end

if nargout >= 3
  varargout{2}= model;
end


%%
%


