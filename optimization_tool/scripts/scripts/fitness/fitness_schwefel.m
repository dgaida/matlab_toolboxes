%% fitness_schwefel
% Fitness function with Schwefel's Problem 2.21
%
function [fitness, varargout]= fitness_schwefel(x)
%% Release: 1.9

%%
% check input parameters

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

if ~isa(x, 'double')
  error('The 1st parameter x must be a double scalar, vector or matrix, but is a %s!', ...
        class(x));
end

%%

population= x;

n_particles= size(population,1);

fitness= zeros(n_particles, 1);

%%

for iparticle= 1:n_particles

  %%
  %

  x= population(iparticle, :);

  if any(x < -100) || any(x > 100)
    summary(x);

    error('x is not in the valid range!');
  end


  %%
  % 

  fitness(iparticle, 1)= max( abs(x) );


end


%%
%

if nargout >= 2
  varargout{1}= zeros(size(population, 1), 1);
end

%%


