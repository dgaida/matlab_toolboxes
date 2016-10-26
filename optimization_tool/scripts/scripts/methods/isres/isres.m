function [xb,Statistics,Gm, varargout]= ...
    isres(fcn,mm,lu,lambda,G,mu,pf,varphi, x)
% ISRES "Improved" Evolution Strategy using Stochastic Ranking
% usage:
%        [xb,Stats,Gm] = isres(fcn,mm,lu,lambda,G,mu,pf,varphi);
% where
%        fcn       : name of function to be optimized (string)
%        mm        : 'max' or 'min' (for maximization or minimization)
%        lu        : parameteric constraints (lower and upper bounds)
%        lambda    : population size (number of offspring) (100 to 400)
%        G         : maximum number of generations
%        mu        : parent number (mu/lambda usually 1/7)
%        pf        : pressure on fitness in [0 0.5] try 0.45
%        varphi    : expected rate of convergence (usually 1)
%
%        xb        : best feasible individual found
%        Stats     : [min(f(x)) mean(f(x)) number_feasible(x)]
%        Gm        : the generation number when "xb" was found

% Copyleft (C) 2003-2004 Thomas Philip Runarsson (e-mail: tpr@hi.is)
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
% GNU General Public License for more details.

% randomize seed
  rand('seed',sum(100*clock));
  if strcmp(lower(mm),'max'), mm = -1; else, mm = 1; end

% Initialize Population
  n = size(lu,2);
  
  if isempty(x)
    x = ones(lambda,1)*lu(1,:)+rand(lambda,n).*(ones(lambda,1)*(lu(2,:)-lu(1,:)));
  end
  
% Selection index vector
  sI = (1:mu)'*ones(1,ceil(lambda/mu)); sI = sI(1:lambda);

% Initial parameter settings
  eta = ones(lambda,1)*(lu(2,:)-lu(1,:))/sqrt(n);
  gamma = 0.85;
  alpha = 0.2;
  chi = (1/(2*n)+1/(2*sqrt(n)));
  varphi = sqrt((2/chi)*log((1/alpha)*(exp(varphi^2*chi/2)-(1-alpha))));

  tau  = varphi/(sqrt(2*sqrt(n)));
  tau_ = varphi/(sqrt(2*n));
  ub = ones(lambda,1)*lu(2,:);
  lb = ones(lambda,1)*lu(1,:);
  eta_u = eta(1,:);
  BestMin = inf;
  nretry = 10;
  xb = [];

% Start Generation loop ...
  for g=1:G,

  % fitness evaluation
    [f,phi] = feval(fcn,x); f = mm*f;
    Feasible = find((sum((phi>0),2)<=0));

  % Performance / statistics
    if ~isempty(Feasible),
      [Min(g),MinInd] = min(f(Feasible));
      MinInd = Feasible(MinInd);
      Mean(g) = mean(f(Feasible));
    else,
      Min(g) = NaN; Mean(g) = NaN;
    end
    NrFeas(g) = length(Feasible);

  % Keep best individual found
    if (Min(g)<BestMin) & ~isempty(Feasible)
      xb = x(MinInd,:);
      BestMin = Min(g);
      Gm = g;
    end

  % Compute penalty function "quadratic loss function" (or any other)
    phi(find(phi<=0)) = 0;
    phi = sum(phi.^2,2);

  % Selection using stochastic ranking (see srsort.c)
    I = srsort(f,phi,pf);
    x = x(I(sI),:); eta = eta(I(sI),:);

  % Update eta (traditional technique using exponential smoothing)
    eta_ = eta;
    eta(mu:end,:) = eta(mu:end,:).*exp(tau_*randn(lambda-mu+1,1)*ones(1,n)+tau*randn(lambda-mu+1,n));
     
  % Upper bound on eta (used?)
    for i=1:n,
      I = find(eta(:,i)>eta_u(i)); 
      eta(I,i) = eta_u(i)*ones(size(I));
    end

  % make a copy of the individuals for repeat ...    
    x_ = x;
   
  % differential variation
    x(1:mu-1,:) = x(1:mu-1,:) + gamma*(ones(mu-1,1)*x(1,:) - x(2:mu,:));
    
  % Mutation
    x(mu:end,:) = x(mu:end,:) + eta(mu:end,:).*randn(lambda-mu+1,n);
      
  % If variables are out of bounds retry "nretry" times 
    I = find((x>ub) | (x<lb));
    retry = 1 ;
    while ~isempty(I)
      x(I) = x_(I) + eta(I).*randn(length(I),1);
      I = find((x>ub) | (x<lb));
      if (retry>nretry), break; end
      retry = retry + 1;
    end
    % ignore failures
    if ~isempty(I),
      x(I) = x_(I);
    end
    
  % exponential smoothing
    eta(mu:end,:) = eta_(mu:end,:) + alpha*(eta(mu:end,:) - eta_(mu:end,:));
    
    %%
    
    fprintf('Minimum in Iter %i / %i: %.2f\n', g, G, Min(g));
    
    % FitnessLimit == 0
    if Min(g) == 0
        break; 
    end
    
    if g >= 5
        if sum(Min(g:g-4))./5 - Min(g) >= 0 && ...
           sum(Min(g:g-4))./5 - Min(g) < 1e-6
            break;
        end
    end
    
end

% Check Output
  if isempty(xb),
    [dummy,MinInd] = min(phi);
    xb = x(MinInd,:);
    Gm = g;
    disp('warning: solution is infeasible');
  end
  if nargout > 1,
    Statistics = [mm*[Min' Mean'] NrFeas'];
  end
  
  if nargout >= 4,
      varargout{1}= x;
  end
  
  
  