%% LDA_evaluation
% Evaluate trained Linear Discriminant Analysis on a testset
%
function [gefundenmatrix, varargout]= ...
    LDA_evaluation(ziptest, no_classes, TransMatnorm, ClassMeanM, ...
                   alpha)
%% Release: 1.8

%%
%

error( nargchk(5, 5, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%

validateattributes(ziptest, {'double'}, {'2d', 'nonempty'}, ...
                   mfilename, 'ziptest', 1);

isN(no_classes, 'number of classes', 2);

validateattributes(TransMatnorm, {'double'}, {'2d', 'nonempty'}, ...
                   mfilename, 'TransMatnorm', 3);
                 
validateattributes(ClassMeanM, {'double'}, {'2d', 'nonempty'}, ...
                   mfilename, 'ClassMeanM', 4);
 
isRn(alpha, 'alpha', 5);
                  
%%

no_classes_test= max(no_classes, numel(unique(ziptest(:,1))));

if (no_classes_test > no_classes)
  warning('LDA:no_classes', 'no_classes_test > no_classes: %i > %i', no_classes_test, no_classes);
end

gefundenmatrix(1:no_classes_test,1:no_classes_test)= 0;

size_dataset_test= size(ziptest, 1);

% Testmatrix
xtestmatrix= ziptest(:, 2:end);

%%

erg(1:no_classes)= 0;

if nargout >= 2,
  failure(1:size_dataset_test, 1)= 0;
end

if nargout >= 3,
  foundClass= NaN(size_dataset_test, 1);
end

%%
% transformierter Klassenmittelwertvektor
% 
% the rows of ClassMeanM contain the mean values of the dataset in the
% original space of the different classes 
%
% $Mytheta := LDA \left( M_\vartheta \right)$
%
Mytheta= TransMatnorm' * ClassMeanM';

%%
% transformierte Daten
%
% $ytestmatrix := LDA \left( \vec{x} \right)$
%
ytestmatrix= TransMatnorm' * xtestmatrix';

%%
%

for z= 1:size_dataset_test,
   
  %%
  % Gütefunktion ausführen
  %
  % $f^*(\vec{x})= arg min_{\vartheta \in \Theta} \left\{
  % \vec{W_\vartheta}^T \cdot LDA \left( \vec{x} - \frac{M_\vartheta}{2}
  % \right) + 2 \alpha_\vartheta \right\}$  
  %
  % $f^*(\vec{x})= arg min_{\vartheta \in \Theta} \left\{
  % \vec{W_\vartheta}^T \cdot \left( LDA \left( \vec{x} \right) -
  % \frac{1}{2} \cdot LDA \left( M_\vartheta \right)
  % \right) + 2 \alpha_\vartheta \right\}$  
  %
  % $\vec{W_\vartheta}^T= -2 \cdot LDA \left( M_\vartheta \right)= -2
  % \cdot Mytheta$ 
  %
  for i= 1:no_classes,
    erg(i)= Mytheta(:,i)' * ( ytestmatrix(:,z) - Mytheta(:,i)/2 ) - alpha(i);
  end

  %%
  % Die Klasse suchen, die zum Max-Wert gehört
  %
  % aus obigem min wird hier ein max durch VZ Drehung, oben
  %
  [max_value, numberLDA]= max(erg);

  %%
  % numberLDA = 1,...,M
  %
  % Klassen in Datensatz von 0, ..., M - 1
  %
  numberLDA= numberLDA - 1;
  
  if nargout >= 3
    foundClass(z, 1)= numberLDA;
  end

  try
    gefundenmatrix(ziptest(z,1) + 1, numberLDA + 1)= ...
          gefundenmatrix(ziptest(z,1) + 1, numberLDA + 1) + 1;
  catch ME
    %ziptest(z,1)
    %% TODO
    % was bedeutet dieser Fehler? kann man hier noch was besseres machen?
    % der fehler bedeutet, dass in testdaten offensichtlich mehr klassen
    % sind, als wie in traingsdaten (no_classes)
    % sollte durch obige korrektur von no_classes gelöst sein
    ziptest(z,1)
    numberLDA
    size(gefundenmatrix)
    
    %rethrow(ME);  
    disp(ME.message);
  end

  if nargout >= 2 && ziptest(z,1) ~= numberLDA

    failure(z,1)= 1;%10 + numberLDA + 1000*ziptest(z,1);

  end
    
end

%ytestmatrixext= [ytestmatrix; ziptest(:,1)'];

%figure,imagesc( gefundenmatrix );

if nargout >= 2
  varargout{1}= failure;
end

if nargout >= 3
  varargout{2}= foundClass;
end

%%


