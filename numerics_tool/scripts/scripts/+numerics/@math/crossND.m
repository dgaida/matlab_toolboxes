%% crossND
% Calculate cross product of n-1 n-dim. vectors.
%
function c= crossND(varargin)
%% Release: 1.9

%%

error( nargchk(1, nargin, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check input arguments

if nargin < 1
  error(['Not enough input arguments! ', ...
         'You have to provide at least 1 argument!']);
end

cellfun(@checkArgument, varargin, repmat({'vector'}, 1, nargin), ...
                                  repmat({'double'}, 1, nargin), ...
                                  num2cell(1:nargin));

%%

input_args= varargin;

for iargin= 1:nargin
   
  %%
  % make column vector

  input_args{1,iargin}= varargin{1,iargin}(:);

  nRows= size(input_args{1,1}, 1);

  %%
  % check dimension of vector

  if size(input_args{1,iargin}, 1) ~= nRows || ...
          min(size(varargin{1,iargin})) ~= 1
    if iargin == 2
      error(['The %ind argument is not %i dimensional, ', ...
             'but %i-by-%i dimensional!'], ...
             iargin, nRows, size(varargin{1,iargin}, 1), ...
                            size(varargin{1,iargin}, 2));
    elseif iargin == 3
      error(['The %ird argument is not %i dimensional, ', ...
             'but %i-by-%i dimensional!'], ...
             iargin, nRows, size(varargin{1,iargin}, 1), ...
                            size(varargin{1,iargin}, 2));
    else
      error(['The %ith argument is not %i dimensional, ', ...
             'but %i-by-%i dimensional!'], ...
             iargin, nRows, size(varargin{1,iargin}, 1), ...
                            size(varargin{1,iargin}, 2));
    end
  end
        
end

%%
% 

if nargin ~= nRows - 1
  error(['You have to provide %i %i-dim. vectors, ', ...
         'but you only provided %i vectors!'], ...
         nRows - 1, nRows, nargin);
end

%%
% the 2-dimensional case is not working below, thus do it differently here
% it is working, just did not scale the axes right
% if nargin == 1
%   
%   a= input_args{1,1};
%   
%   alpha= atan2(a(2), a(1));
%   r= sqrt(a(1)^2 + a(2)^2);
%   
%   % Vektor um 90° weiter drehen
%   c(1)= r * cos(alpha + pi/2);
%   c(2)= r * sin(alpha + pi/2);
%   
%   c= c(:);
%   
%   return;
%   
% end

%%
% readout input_args

ab(1:nRows, 1:nargin)= 0;

for imat= 1:nargin
  ab(:,imat)= input_args{1,imat};
end

%%
% calculate cross product c

c(1:nRows, 1)= 0;

%%
% It is well known, that 
%
% $$\vec{c}= \vec{a} \times \vec{b} = 
% \left| { \matrix{ e_1 & e_2 & e_3 \cr 
%                   a_1 & a_2 & a_3 \cr
%                   b_1 & b_2 & b_3 \cr
%                 } } \right|
% $$
%
% where $\left| \cdot \right|$ calculates the determinant and 
% $\vec{a} := \left( a_1, a_2, a_3 \right)^T$, 
% $\vec{b} := \left( b_1, b_2, b_3 \right)^T$ and $e_i, i= 1,2,3$ stand as
% symbol for the orthormal basis, spanned by the set of orthonormal vectors
% $\vec{e}_i, i= 1,2,3$.
%
% Since $\left| A \right|= \left| A^T \right|$ we furthermore can write
%
% $$\vec{c}= \vec{a} \times \vec{b} = 
% \left| { \matrix{ e_1 & a_1 & b_1 \cr 
%                   e_2 & a_2 & b_2 \cr
%                   e_3 & a_3 & b_3 \cr
%                 } } \right|
% $$
%
% and
%
% $$c_i= \left| \vec{e}_i, \vec{a}, \vec{b} \right|, i= 1,2,3$$
%
% where $\vec{c} := \left( c_1, c_2, c_3 \right)^T$
%
% This form is extended to n-1 n-dimensional vectors $\vec{a}, \vec{b},
% \vec{d}, ... \in R^n$ as 
%
% $$c_i= \left| \vec{e}_i, \vec{a}, \vec{b}, \vec{d}, \dots \right|$$
%

for irow= 1:nRows

  %%
  % create unit vector
  e= zeros(nRows,1);
  e(irow,1)= 1;

  %%
  % calculate cross product
  c(irow,1)= det([e, ab]);

end

%%


