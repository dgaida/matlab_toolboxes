%% katz_lda
% Linear Discriminant Analysis implemented by M. Katz
%
function [TransMatnorm, varargout]= katz_lda(data, numeigvec)
%% Release: 1.9

%%
% data: Vektoren zeilenweise geordnet, erste spalte klassenlabel
% numeigvec: Anzahl der gewuenschten Eigenvektoren
% M. Katz 2006

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check arguments

validateattributes(data, {'double'}, {'2d', 'nonempty'}, mfilename, 'data', 1);
isN(numeigvec, 'number of eigenvalues', 2);


%%
% $X^T := \left[ \vec{x}_1, \dots, \vec{x}_i, \dots, \vec{x}_N \right]^T,
% \vec{x}_i \in R^n, i= 1, \dots, N$ 
%
X_tr= data(:,2:end);                % herausfiltern der Datenvektoren
%%
% $\vec{y}^T := \left( y_1, \dots, y_i, \dots, y_N \right)^T$ 
%
y_tr= data(:,1) + 1;                % und der zugehoerigen Klassenlabel
%%
% $\Theta := \left\{ 1, \dots, \vartheta, \dots, M \right\}$
label= unique(y_tr);                % herausfiltern unterschiedlicher klassenlabel
%%
% $M := NumClass$
NumClass= max(label);               % Anzahl Klassen

%%

if (NumClass ~= numel(label))
  TransMatnorm= [];
  varargout{1}= [];
  varargout{2}= [];
  varargout{3}= [];

  return;
end

%%

%%
% $N := Numfeat$
Numfeat= size(X_tr,1);              % Anzahl Datenvektoren
%%
% $n := dim$
dim= size(X_tr,2);                  % Dimension der Daten
%%
% $S_W$
SW= zeros(dim);                     % WithinClass ScatterMatrix
%%
% $S_T$
ST= zeros(dim);                     % TotalClass ScatterMatrix
%%
% $\vec{M}_0 := \frac{1}{N} \sum_{i=1}^{N} \vec{x}_i$
%
TotMean= mean(X_tr);                % Mittelwert der gesamten Verteilung

%%
%
if nargout >= 2,
  ClassMeanM= zeros(NumClass, size(X_tr, 2));
end


%%
%

for k=1:NumClass

  X= X_tr(y_tr == label(k), :);   % herausfiltern der Datenvektoren zur Klasse k

  %%
  % $N_\vartheta := ClassNumfeat$
  ClassNumfeat= size(X,1);        % Anzahl Datenvektoren in der Klasse k

  %%

  S= zeros(dim);

  %%
  % $\vec{M}_\vartheta := \frac{1}{N_\vartheta} \sum_{i=1, Y \left(
  % \vec{x}_i \right) = \vartheta}^{N} \vec{x}_i$ 
  ClassMean= mean(X);             % Mittelwert der Klassenverteilung

  %%

  if nargout >= 2,
    ClassMeanM(k,:)= ClassMean;
  end

  %%
  % geht auch noch schoener, ist so aber anschaulicher:
  for n= 1:ClassNumfeat

    %%
    % $\sum_{i=1, Y \left( \vec{x}_i \right) = \vartheta}^{N} \left(
    % \vec{x}_i - \vec{M}_\vartheta \right) \cdot \left( \vec{x}_i -
    % \vec{M}_\vartheta \right)^T$  
    tmp= X(n,:) - ClassMean;   
    S= S + tmp'*tmp;            % Berechnung der SW Matrix der Klasse k

    %%
    % $\sum_{i=1}^{N} \left( 
    % \vec{x}_i - \vec{M}_0 \right) \cdot \left( \vec{x}_i - \vec{M}_0
    % \right)^T$  
    tmp2= X(n,:) - TotMean;
    ST= ST + tmp2'*tmp2;        % Berechnung der ST Matrix der Klasse k

  end

  %%
  % $\sum_{\vartheta=1}^{M} \sum_{i=1, Y \left( \vec{x}_i \right) =
  % \vartheta}^{N} \left( 
  % \vec{x}_i - \vec{M}_\vartheta \right) \cdot \left( \vec{x}_i -
  % \vec{M}_\vartheta \right)^T$  
  SW= SW + S;                     % Aufaddieren ueber alle Klassen

end

%%
% $S_W := \frac{1}{N} \cdot \sum_{\vartheta=1}^{M} \sum_{i=1, Y \left(
% \vec{x}_i \right) = \vartheta}^{N} \left( 
% \vec{x}_i - \vec{M}_\vartheta \right) \cdot \left( \vec{x}_i -
% \vec{M}_\vartheta \right)^T$  
SW= SW/Numfeat;

%%
% $S_T := \frac{1}{N} \cdot \sum_{i=1}^{N} \left( 
% \vec{x}_i - \vec{M}_0 \right) \cdot \left( \vec{x}_i - \vec{M}_0
% \right)^T$  
ST= ST/Numfeat;

%%
% $W := S_W^{-1} \cdot S_T$
W= inv(SW)*ST;                      % Berechnung der LDA Matrix

%%

if any(any(isnan(W))) || any(any(W == Inf))
  TransMatnorm= [];
  varargout{1}= [];
  varargout{2}= [];
  varargout{3}= [];

  return;
end

%%
% $B := TransMat$ besteht aus Eigenvektoren von $S_W^{-1} \cdot S_T$ mit
% geordneten Eigenwerten $\lambda_1 \geq \lambda_2 \geq \dots \geq \lambda_N
% > 0$ 
[veclda, vallda]= eig(W);

TransMat= zeros(dim,numeigvec);          % Sortierung der Eigenvektoren(spaltenweise)
[val, idx]= sort(diag(vallda),'descend');% in absteigender Reihenfolge der Eigenwerte

for i=1:numeigvec
  TransMat(:,i)= veclda(:,idx(i));
end


%%

nt(1:numeigvec)= 0;
ntw(1:numeigvec)= 0;
TransMatnorm(size(TransMat,1), 1:numeigvec)= 0;

% Normierung durchführen
for j= 1:numeigvec,
  nt(j)= TransMat(:,j)' * SW * TransMat(:,j);
  ntw(j)= sqrt( nt(j) );
  TransMatnorm(:,j)= TransMat(:,j) / ntw(j);
end


%%

% nt(1:dim)= 0;
% ntw(1:dim)= 0;
% vecldanorm(size(veclda,1), 1:dim)= 0;
% 
% % Normierung durchführen
% for j= 1:dim,
%     nt(j)= veclda(:,j)' * SW * veclda(:,j);
%     ntw(j)= sqrt( nt(j) );
%     vecldanorm(:,j)= veclda(:,j) / ntw(j);
% end


%%
%

if nargout >= 2,
  varargout{1}= ClassMeanM;
end


%%
%

if nargout >= 3

  %%
  % Wahrscheinlichkeit für Auftreten einer Ziffer bestimmen
  %

  ntn(1:NumClass)= 0;

  for z= 1:NumClass,
    for J= 1:Numfeat,
      if data(J,1) == z - 1
        ntn(z)= ntn(z) + 1;
      end
    end
  end

  %%
  % $\alpha_\vartheta= -ln( P( Y = \vartheta ) )$
  %
  % $\vec{\alpha} := ( \alpha_1, \dots, \alpha_\vartheta, \dots, \alpha_M
  % )^T$ 
  %
  alpha= -log( ntn / sum(ntn) );

  varargout{2}= alpha;

end


%%
% Zur Verwendung von Testdaten muss man hier die Testdaten mit load wie
% oben einlesen und Daten/Label herausfiltern. 
%

%%
% TransMat ist die Transformationsmatrix LDA
%
X_trans= X_tr*TransMat;             % Transformation der Daten

X_trans_norm= X_tr*TransMatnorm;             % Transformation der Daten

%%

if nargout >= 4,
  varargout{3}= [y_tr, X_trans];
end

%%
%

if(numeigvec <= 3)                % Wenn wir im ein/zwei/dreidimensionalen sind,

  for idata= 1:2
    
    figure();                       % koennen wir uns das anschauen ... 
    %colors= ['r';'b';'g';'m';'y';'k'];
    % the colors in this direction are better, when also boundaries are
    % plotted
    colors= ['b';'g';'r';'m';'y';'k'];
    sym= '*';

    for k= 0:NumClass - 1

      X_res= X_trans(y_tr == label(k + 1), :);

      if(numeigvec == 2)
        plot(X_res(:,1), X_res(:,2), [colors(mod(k,6) + 1) sym]);
      elseif(numeigvec == 3)
        plot3(X_res(:,1), X_res(:,2), X_res(:,3), [colors(mod(k,6) + 1) sym]);
      else
        plot(X_res(:,1), 1, [colors(mod(k,6) + 1) sym]);
      end

      hold on;

    end

    %%

    formats= repmat(', ''class %i''', 1, NumClass - 1);

    string= sprintf('legend(''class 0''%s);', formats);

    eval( sprintf(string, (1:NumClass - 1)) );

    %%

    hold off
    
    %%
    % for the 2nd plot use the data transformed with the normalized
    % transformation matrix. in the 2nd plot we should be able to plot the
    % hyperplanes
    
    X_trans= X_trans_norm;
  
  end

end

%%


