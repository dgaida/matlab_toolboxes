%% numerics.math
% doc numerics.math
%
classdef math < handle
%% Release: 1.9
    
  %% Properties
  %
  properties (Access= public)

    

  end


  %% Methods
  %
  methods (Access= public)

    
    
  end
  
  %% Methods
  %
  methods (Static)

    %%
    %
    equal= approxEq(a, varargin)

    %%
    %
    n_rmse= calcNormalizedRMSE(x, y)

    %%
    %
    [V]= calcNullspace(A)

    %%
    %
    rmse= calcRMSE(x, y)

    %%
    %
    c= crossND(varargin)
    
    %%
    %
    d= edist(x, y)
    
    %%
    %
    n= norme(X)
    
    %%
    %
    round_value= round_float(value, varargin)
    
    %%
    %
    

  end % end methods

  %% Methods
  %
  methods (Static, Access= private)

    

  end

  %%
  %
    
end % end class

%%


