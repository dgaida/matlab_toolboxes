%% LDA_lin_classifier
% Implementation of a linear classifier using parameters gotten from LDA
%
function [class, varargout]= LDA_lin_classifier(featurevector, no_classes, ...
                              TransMatnorm, ClassMeanM, alpha)
%% Release: 1.4

%%
%

error( nargchk(5, 5, nargin, 'struct') );
error( nargoutchk(0, 2, nargout, 'struct') );

%%

isRn(featurevector, 'featurevector', 1);

isN(no_classes, 'number of classes', 2);

validateattributes(TransMatnorm, {'double'}, {'2d', 'nonempty'}, ...
                   mfilename, 'TransMatnorm', 3);
                 
validateattributes(ClassMeanM, {'double'}, {'2d', 'nonempty'}, ...
                   mfilename, 'ClassMeanM', 4);
 
isRn(alpha, 'alpha', 5);
 

%%
% transformierter Klassenmittelwertvektor
%
% $Mytheta := LDA \left( M_\vartheta \right)$
%
Mytheta= TransMatnorm' * ClassMeanM';

%%
% transformierte Daten
%
% $ytestmatrix := LDA \left( \vec{x} \right)$
%
ytestvector= TransMatnorm' * featurevector';

%%

erg(1:no_classes)= 0;

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
  erg(i)= Mytheta(:,i)' * ( ytestvector - Mytheta(:,i)/2 ) - alpha(i);
end

%%
% Die Klasse suchen, die zum Max-Wert gehört
%
% aus obigem min wird hier ein max durch VZ Drehung, oben
%
[max_value, class]= max(erg);

%%

if nargout >= 2
  varargout{1}= ytestvector;
end

%%


