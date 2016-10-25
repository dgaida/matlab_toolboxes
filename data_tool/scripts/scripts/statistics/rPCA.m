%% rPCA
% Robust Principal Component Analysis (with Croux and Ruiz-Gazen algorithm)  
% 
function [rpc,rv,rd,ROD,RD,pct]=rPCA(x,fn)
%% Release: 1.1

if fn>rank(x)-1
    errordlg('The number of Robust Principal Components to be extracted exceeds the rank of the data-1','Error')
    rpc=[];rv=[];rd=[];exRD=[];ROD=[];RD=[];cutoff=[];
    return
end

[m,n]=size(x);

if n>m 
    dimensions = true;
else
    dimensions = false;
end

if n>m
     Xc = (x-ones(m,1)*mean(x));
     [V,S,U]=svd(Xc',0);
     Xnew=U*S;
     [m,n]=size(Xnew);
     X=Xnew;
else
     n=size(x,2);
     Xc=x-ones(m,1)*L1median(x);
     Xnew=Xc;
     X=Xnew;
end

h=waitbar(0,'Progress ...'); 
h=waitbar(0/fn,h);

for i=1:fn
    [A]=normalise(Xnew',n);			               	
    Y=Xnew*A'; 					                    
    E=qn(Y);                                         
    [maxs j]=max(E);				                         
    rv(i,1)=maxs;
    rd(:,i)=A(j,:)';  				                
    Xnew=(Xnew'-(rd(:,i)*rd(:,i)')*Xnew')';	        
    h=waitbar(i/fn,h);
end

rpc=X*rd;
if dimensions
    rd = (rd'*V')';
end
close(h);

% Calculate Robust Orthogonal Distance

Xfinal=x-(rpc*rd');
for i=1:fn
    Xfinal=x-(rpc(:,1:i)*rd(:,1:i)');
    ROD(:,i)=sqrt(sum(Xfinal.^2,2));
end

% Calculate Robust Distance

S=(rv').^2;
RD=(rpc).^2./(repmat(S,size(rpc,1),1));
RD=sqrt(cumsum(RD,2));
RD=(abs(RD-ones(m,1)*median(RD)))./(ones(m,1)*qn(RD));
ROD=(abs(ROD-ones(m,1)*median(ROD)))./(ones(m,1)*qn(ROD));



% ---> Normalise direction 

function [A]=normalise(x,n)

A=((x)./(ones(n,1)*sqrt(sum(x.^2))))';

