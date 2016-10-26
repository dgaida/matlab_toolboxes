%% nonlconSphere
% Nonlinear (in-)equality constraint function in form of a n-dimensional
% sphere. 
%
function [c, ceq]= nonlconSphere(r, varargin)
%% Release: 1.9

%%

error( nargchk(1, 5, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%
% check parameters

if numel(size(r)) > 2 || ~isa(r, 'numeric')
  error(['The 1st parameter r must be a scalar or vector number, ', ...
         'but is of type ', class(r), ' with ', ...
         num2str(numel(size(r))), ' number of dimensions!']);
end

%%
% read out varargin

if nargin >= 2 && ~isempty(varargin{1})
  % radius of the sphere
  radius= varargin{1}; 
else
  radius= 2;
end

if numel(radius) ~= 1 || ~isa(radius, 'numeric')
  error(['The 2nd parameter radius must be a scalar number, ', ...
         'but is of type %s with %i', ...
         ' number of elements!'], class(radius), numel(radius));
end

%%

if nargin >= 3 && ~isempty(varargin{2})
  % center of the sphere
  center= varargin{2};
else
  center= 0;
end

if ( numel(center) ~= 1 && numel(center) ~= numel(r) ) || ...
 ~isa(center, 'numeric')
  error(['The 3rd parameter center must either be a scalar number ', ...
         'or have the same dimension as r (%i)! It is of type %s with ', ...
         '%i number of elements!'], numel(r), class(center), numel(center));
end

%%
% should the sphere behave as an inequality constraint? default yes

if nargin >= 4 && ~isempty(varargin{3})
  ineq= varargin{3};
  
  is0or1(ineq, 'ineq', 4);
else
  ineq= 1; 
end


%%
% should the sphere behave as an equality constraint? default no

if nargin >= 5 && ~isempty(varargin{4})
  eq= varargin{4};
  
  is0or1(eq, 'eq', 5);
else
  eq= 0;
end


%%
% bring the variables into row vector form

r= r(:)';

if numel(center) == 1
  center= center .* ones(size(r));
else
  center= center(:)';
end


%%
% nonlinear inequality constraint

if (ineq)
  c= sqrt((r - center)*(r - center)') - radius;
else
  c= [];
end


%%
% nonlinear equality constraint

if eq
  ceq= sqrt((r - center)*(r - center)') - radius;
else
  ceq= [];
end
    
%%


