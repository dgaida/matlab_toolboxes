%% pca
% Principal Component Analysis by Singular Value Decomposition
% always on the smaller data dimension. 
%
function [pc,s,v,d,pr]=pca(x)
%% Release: 1.1

% Function: [pc,s,v,d,pr]=pca(x)
%
% Aim:	
% Principal Component Analysis by Singular Value Decomposition
% always on the smaller data dimension. 
%
% Input: 
% x - data matrix (m,n)
%
% Output:
% pc - matrix containing in columns Principal Components
% s - matrix containing in columns normalized scores
% v - vector of eigenvalues
% d - matrix containing in columns loadings 
% pr - % of explained data variance by each PC
%
% Example:
% [pc,s,v,d,pr]=pca(x)

[m,n]=size(x);

if m<n                      	
   [s,v]=eig(x*x');
   v=abs(diag(v));
   [a,b]=sort(v);
   b=flipud(b);
   v=v(b);
   s=s(:,b);
   d=x'*(s*diag(sqrt(1./v)));
   pr=100*(v/sum(v));
   v=sqrt(v);
   pc=s*diag(v);
else                        
   [s,v,d]=svd(x,0);
   pc=s*v;
   v=diag(v);
   e=v.^2;
   pr=(e)*100/sum(e);
end

%%


