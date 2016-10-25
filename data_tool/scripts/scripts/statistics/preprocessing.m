%% preprocessing
% Data preprocessing
% 
function out=preprocessing(X,method)
%% Release: 1.1

% Check if 'method' string is peoperly specified
options=[{'mean centering'};{'standardisation'};{'snv'};{'median centering'};{'l1-median centering'};,...
        {'qn-standardisation'};{'qn-autoscaling'};{'sn-standardisation'};{'sn-autoscaling'};{'mad'};,...
        {'median-snv'};{'qn-snv'};{'sn-snv'}];

if isempty(strmatch(lower(method),lower(options),'exact'))
    errordlg([{'Input variable ''method'' is wrongly specified'};{' '};{'See: help preprocessing'}] ,'Error')
    out=[]
    return
end

[m,n]=size(X);

switch method
    
    % Classical proprocessing
    case 'mean centering'
        out=X-(ones(m,1)*mean(X));
        
    case 'standardisation'
        out=X./(ones(m,1)*std(X));
        
    case 'snv'
        out=(X-mean(X')'*ones(1,n))./(std(X')'*ones(1,n));
        
    % Robust proprocessing
    case 'median centering'
        out=X-(ones(m,1)*median(X));
        
    case 'l1-median centering'
        out=X-(ones(m,1)*L1median(X));
        
    case 'qn-standardisation'
        out=X./(ones(m,1)*qn(X));
        
    case 'qn-autoscaling'
        out=X-(ones(m,1)*L1median(X));
        out=out./(ones(m,1)*qn(out));
        
    case 'sn-standardisation'
        out=X./(ones(m,1)*sn(X));
              
    case 'sn-autoscaling'
        out=X-(ones(m,1)*L1median(X));
        out=out./(ones(m,1)*sn(out));
        
    case 'mad'
        out=mad(X);
        
    case 'median-snv'
        out=(X-median(X')'*ones(1,n))./(median(X')'*ones(1,n));
        
    case 'qn-snv'
        out=(X-qn(X')'*ones(1,n))./(qn(X')'*ones(1,n));
        
    case 'sn-snv'
        out=(X-sn(X')'*ones(1,n))./(sn(X')'*ones(1,n));
end
    

