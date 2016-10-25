%% L1median
% Computing L1-median (multivariate L1-median)
%
function [mX]= L1median(X, tol)
%% Release: 1.1

% L1MEDIAN calculates the multivariate L1 median 
% I/O: [mX]=L1median(X,tol);
%
% X is the data matrix 
% tol is the convergence criterium; the iterative proces stops when ||m_k - m_{k+1}|| < tol.
%
% Ref: Hossjer and Croux (1995) "Generalizing Univariate Signed Rank Statistics for Testing
% and Estimating a Multivariate Location Parameter", Non-parametric Statistics, 4, 293-308.

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin < 2
  tol=1.e-08;
end

%%

checkArgument(X, 'X', 'double', '1st');

isR(tol, 'tol', 2, '+');

%%

[n,p]=size(X);
maxstep=100;%200

% initializing starting value for m
m=median(X);
k=1;

while (k<=maxstep)
  mold=m;
  % sort X based on median distance to X, increasing order
  Xext=sortrows([numerics.math.norme(X-repmat(m,n,1)) X],1);
  dx=Xext(:,1);
  X=Xext(:,2:p+1);

  if all(dx) % all dx > 0
    w=1./dx;
  else
    ww=dx(all(dx,2));
    w=1./ww; % calculate weights only for dx > 0
    w=[zeros(length(dx)-length(w),1);w]; % add single weights for dx= 0, they are
    % the first in the vector
  end

  % calc weighted distance of X to median
  delta=sum((X-repmat(m,n,1)).*repmat(w,1,p),1)./sum(w);
  nd=numerics.math.norme(delta);

  if all(nd<tol)
      maxhalf=0;
  else
      maxhalf=log2(nd/tol);
  end

  m=mold+delta;   % computation of a new estimate
  nstep=0;

  while all(mrobj(X,m)>=mrobj(X,mold))&(nstep<=maxhalf)
      nstep=nstep+1;
      m=mold+delta./(2^nstep);
  end

  if (nstep>maxhalf)
      mX=mold;
      break
  end

  k=k+1;

end

mX=m;



%%
%
function s=mrobj(X,m)

%MROBJ computes objective function in m based on X and a

xm=numerics.math.norme(X-repmat(m,size(X,1),1));
s=sum(xm,1)';

%%


