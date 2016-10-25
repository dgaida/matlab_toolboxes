%% sn
% Computing SN - scale estimator
% 
function s=sn(X)
%% Release: 1.2

if size(X,2)>1 % then a matrix or a row vector
    if size(X,1)>1 % a matrix
        for i=1:size(X,2) % for each column of the matrix
            s(:,i)=snsven(X(:,i)); % apply sn to each column
        end
    else % a row vector
        X=X'; % get a column vector
        s=snsven(X);
    end
else % a column vector
    s=snsven(X);
end;



%%
% -----------------------------------------
function s=snsven(y)

n=length(y);

if n>1000 % divide y into bins
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
% calc absolute deviation of y's
pairwisediff=sort(abs(repmat(y',n,1)-repmat(y,1,n))); 
pairwisediff=pairwisediff(floor((n+1)/2),:); % get median
pairwisediff=sort(pairwisediff); % sort to get median again
s=1.1926*(pairwisediff(floor(n/2)+1));

%%
% select factor cn

cn=1;
switch n
    case 2 
        cn=0.743;
    case 3 
        cn=1.851;
    case 4 
        cn=0.954;
    case 5
        cn=1.351;
    case 6 
        cn=0.993;
    case 7 
        cn=1.198;
    case 8 
        cn=1.005;
    case 9 
        cn=1.131;
    otherwise 
        if (mod(n,2)==1) 
            cn=n/(n-0.9);
        end
end

%%

s=cn*s;

%%


