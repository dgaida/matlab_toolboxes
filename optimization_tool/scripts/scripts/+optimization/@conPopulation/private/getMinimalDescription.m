%% optimization.conPopulation.private.getMinimalDescription
% Get the size of the individual from the structure of the constraints.
%
function [lenIndividual, uMask, varargout]= ...
         getMinimalDescription( lenVector, varargin )
%% Release: 1.4

%%

error( nargchk(1, 7, nargin, 'struct') );
error( nargoutchk(0, 7, nargout, 'struct') );

%% 
% read out varargin
   
%%
%

if nargin >= 7 && ~isempty(varargin{6})
  lenGenom= varargin{6};
  
  validateattributes(lenGenom, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'lenGenom', 7);
else
  lenGenom= 1; 
end

% Reihenfolge mit Absicht vertauscht
%
if nargin >= 4 && ~isempty(varargin{3})
  LB= varargin{3}; 

  if isempty(lenVector)
    lenVector= numel(LB) * lenGenom;
  end
else
  LB= zeros(lenVector, 1); 
end

if nargin >= 5 && ~isempty(varargin{4}), 
  UB= varargin{4};

  if isempty(lenVector)
    lenVector= numel(UB) * lenGenom;
  end
else
  UB= Inf(lenVector, 1); 
end


if nargin >= 2

  A= varargin{1};

  if isempty(A), A= zeros(1, lenVector); end;

  % mehrere Gleichungen zusammenfassen, nur um zu schauen ob überhaupt
  % ein Datenelement an einem Gleichgewicht beteiligt ist
  A_mask= max(abs(A), [], 1);

else

  A_mask= zeros(1, lenVector);

end

if nargin >= 3

  Aeq= varargin{2};

  if isempty(Aeq), Aeq= zeros(1, lenVector); end;

  % mehrere Gleichungen zusammenfassen, nur um zu schauen ob überhaupt
  % ein Datenelement an einem Ungleichgewicht beteiligt ist
  Aeq_mask= max(abs(Aeq), [], 1);

else

  Aeq_mask= zeros(1, lenVector);

end

if nargin >= 6 && ~isempty(varargin{5})
  dataForIndividual= varargin{5};
  
  checkArgument(dataForIndividual, 'dataForIndividual', 'double', 6);
else
  dataForIndividual= []; 
end



%% 
% check parameters

validateattributes(lenVector, {'double'}, ...
                   {'scalar', 'nonnegative', 'integer'}, ...
                   mfilename, 'lenVector', 1);

checkArgument(A, 'A', 'double', 2);
checkArgument(Aeq, 'Aeq', 'double', 3);

checkArgument(LB, 'LB', 'double', 4);
checkArgument(UB, 'UB', 'double', 5);

%%

if isempty(LB), LB= zeros(lenVector, 1); end
if isempty(UB), UB= Inf(lenVector, 1); end

LB= LB(:);
UB= UB(:);

dataForIndividual= dataForIndividual(:);


%%
% detect of constraints have to be changed, because lenGenom > 1

if numel(LB) ~= lenVector || ... % && ( numel(LB) * lenGenom == lenVector )
   numel(UB) ~= lenVector || ...
   size(A, 2) ~= lenVector || ...
   size(Aeq, 2) ~= lenVector
  
  %%
  % anpassen der lineare ungleichungsnebenbedingung
  % A

  if (size(A, 2) ~= lenVector)
    
    [A]= adaptConstraintsToLenGenom(A, [], lenGenom);

    A_mask= max(abs(A), [], 1);
  
  end
  

  %%
  % Aeq und beq

  if (size(Aeq, 2) ~= lenVector)
    
    [Aeq]= adaptConstraintsToLenGenom(Aeq, [], lenGenom);

    Aeq_mask= max(abs(Aeq), [], 1);
  
  end
  
  
  %%
  % LB und UB

  if numel(LB) ~= lenVector && numel(LB) > 0

    LB= LB(:);
    
    LB_ext= repmat(LB, 1, lenGenom);

    LB_ext= LB_ext';

    LB= LB_ext(:)';

  end


  %%
  % UB

  if numel(UB) ~= lenVector && numel(UB) > 0

    UB= UB(:);
    
    UB_ext= repmat(UB, 1, lenGenom);

    UB_ext= UB_ext';

    UB= UB_ext(:)';

  end
  
end


%%

LB= LB(:);
UB= UB(:);

%%

boundDiff= UB - LB;

%% TODO
% die Abfrage UB > 0, scheint zu suggerieren, dass LB nur >= 0 sein darf,
% d.h. alle u's nur positiv sein dürfen.

% entscheide wann ein Datenelement in das Individuum aufgenommen werden muss
% 1. wenn min ~= max oder
% 2. wenn das Datenelement einer Gleichungsnebenbedingung unterliegt und der 
% max Wert > 0 ist oder
% 3. wenn das Datenelement einer Ungleichungsnebenbedingung unterliegt und der 
% max Wert > 0 ist
uMask= ( 1 - all(~boundDiff) ) .* ...
       min( ...
          ( boundDiff > 0 ) .* ( boundDiff < Inf ) + ...
          ( min(   A_mask' ~= 0, UB > 0 ) ) + ...
          ( min( Aeq_mask' ~= 0, UB > 0 ) ), 1 ...
          );


% Bestimme an Hand der Maske welche Daten in das Individuum
% aufgenommen wird -> wird genannt: u
u= [uMask, A', Aeq', LB, UB, dataForIndividual];

u= sortrows(u, 1);

%%

Amin=   u(end - sum(uMask) + 1:end, 2            :1 + size(A,1));
Aeqmin= u(end - sum(uMask) + 1:end, 2 + size(A,1):1 + size(A,1) + size(Aeq,1));
LBmin=  u(end - sum(uMask) + 1:end, 2 + size(A,1) + size(Aeq,1));
UBmin=  u(end - sum(uMask) + 1:end, 3 + size(A,1) + size(Aeq,1));

if ~isempty(dataForIndividual)
    u= u(end - sum(uMask) + 1:end, 4 + size(A,1) + size(Aeq,1));
end

lenIndividual= sum(uMask);

%%

if lenIndividual == 0
   
    Amin= [];
    Aeqmin= [];
    LBmin= [];
    UBmin= [];
    u= [];
    
end

%%

if nargin >= 2 
  if isempty(varargin{1})
      Amin= [];
  end
else
  Amin= [];
end

if nargin >= 3
  if isempty(varargin{2})
      Aeqmin= []; 
  end
else
  Aeqmin= []; 
end

if nargin >= 4
  if isempty(varargin{3})
      LBmin= []; 
  end
else
  LBmin= []; 
end

if nargin >= 5
  if isempty(varargin{4})
      UBmin= []; 
  end
else
  UBmin= []; 
end

if nargin >= 6
  if isempty(varargin{5})
      u= []; 
  end
else
  u= []; 
end

%%

Amin= Amin';
Aeqmin= Aeqmin';
LBmin= LBmin';
UBmin= UBmin';

%%

%%
% ändere setup wenn länge eines genoms > 1 ist

%lenIndividual= lenIndividual * lenGenom;



%%

varargout= {Amin, Aeqmin, LBmin, UBmin, u};

%%
%


