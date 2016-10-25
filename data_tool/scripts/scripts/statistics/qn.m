%% qn
% Computing QN - scale estimator
% 
function s=qn(X)
%% Release: 1.2

if size(X,2)>1 % then a matrix or a row vector
    if size(X,1)>1 % a matrix
        for i=1:size(X,2) % for each column of the matrix
            s(:,i)=qnsven(X(:,i)); % apply qn to each column
        end
    else % a row vector
        X=X'; % get a column vector
        s=qnsven(X);
    end
else % a column vector
    s=qnsven(X);
end;



%%
%
function s=qnsven(y)

n=length(y);

%%
% Do binning for big n
if n>1000
    sy=sort(y);
    nbins=floor(n/10);
    mys=zeros(nbins,1);
    ninbins=floor(n/nbins);
    for i=1:nbins
        if (mod(n,nbins)~=0 & i==nbins)
            mys(i)=median(sy((i-1)*ninbins+1:n));
        else
            mys(i)=median(sy((i-1)*ninbins+1:i*ninbins));
        end
    end
    y=mys;
    n=nbins;
end

%%

h=floor(n/2)+1;
k=0.5*h*(h-1);
pairwisediff=repmat(y,1,n)-repmat(y',n,1); 
pairwisediff=sort(abs(pairwisediff(find(tril(ones(n,n),-1)))));
s=2.2219*(pairwisediff(k));

%%
% select factor dn

switch n
    case 1
        error('Sample size too small');
    case 2
        dn=0.399;
    case 3 
        dn=0.994;
    case 4 
        dn=0.512;
    case 5 
        dn=0.844;
    case 6 
        dn=0.611;
    case 7 
        dn=0.857;
    case 8 
        dn=0.669;
    case 9 
        dn=0.872;
        
    otherwise 
        if (mod(n,2)==1) 
            dn=n/(n+1.4);
        elseif (mod(n,2)==0) 
            dn=n/(n+3.8);
        end
end

%%

s=dn*s;

%%


