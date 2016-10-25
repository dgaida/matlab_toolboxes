%% startLDA
% Start training and evaluation of Linear Discriminant Analysis (LDA) for
% discriminant analysis.
%
function [gefundenmatrix, confusionmatrix, ...
          TransMatnorm, ClassMeanM, alpha, X_trans, failure, foundClass]= ...
                                    startLDA(ziptrain, ziptest, varargin)
%% Release: 1.6

%%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 8, nargout, 'struct') );

%%

validateattributes(ziptrain, {'double'}, {'2d', 'nonempty'}, ...
                   mfilename, 'ziptrain', 1);

validateattributes(ziptest, {'double'}, {'2d', 'nonempty'}, ...
                   mfilename, 'ziptest', 2);
                                 
%%
% read out varargin

if nargin >= 3 && ~isempty(varargin{1}),
  no_eigV= varargin{1};
  isN(no_eigV, 'number of eigenvalues (classes)', 3);
else
  % Anzahl der Eigenvektoren, an denen Klassifizierung durch
  % geführt werden soll, Dimension des reduzierten Raumes
  no_eigV= 3;
end
                 
%%
% LDA ausführen

[TransMatnorm, ClassMeanM, alpha, X_trans]= katz_lda(ziptrain, no_eigV);

if isempty(TransMatnorm)
    gefundenmatrix= [];
    confusionmatrix= [];
    failure= [];
    foundClass= [];
    
    return;
end

%%
% Anzahl der unterschiedlichen Klassen
%
no_classes= size(unique( ziptrain(1:end,1) ), 1);


%%
%

[gefundenmatrix, failure, foundClass]= ...
        LDA_evaluation(ziptest, no_classes, TransMatnorm, ...
                       ClassMeanM, alpha);


%%
% plot hyperplanes

if numel(ziptest(1,2:end)) == 3 && no_eigV == 2
  plot_hyperplanes= 1;
else
  plot_hyperplanes= 0;
end

if (plot_hyperplanes)
  
  min_test= min(ziptest(:,2:end));
  max_test= max(ziptest(:,2:end));

  if numel(min_test) == 3
    
    xlimits= xlim();
    ylimits= ylim();
    
    %%
    
    [a,b,c]= ndgrid(min_test(1):1:max_test(1), min_test(2):1:max_test(2), ...
                    min_test(3):1:max_test(3));
    testvectors= [zeros(numel(a), 1), a(:), b(:), c(:)];

    featurevectors= zeros(numel(a), no_eigV + 1);
    
    %%
    
    for ifeature= 1:size(testvectors, 1)
      [featurevectors(ifeature,1), featurevectors(ifeature,2:end)]= ...
          LDA_lin_classifier(testvectors(ifeature,2:end), no_classes, ...
                             TransMatnorm, ClassMeanM, alpha);
    end

    %%
    
    hold on;
    
    [X, Y, F]= griddata_vectors(featurevectors(:,2), featurevectors(:,3), ...
                                                 [], featurevectors(:,1));
    
    surf(X, Y, F, F, 'LineStyle', 'none', 'FaceAlpha', 0.15);
    view(0,90);
    hold off;
    
    %%
    
    xlim(xlimits);
    ylim(ylimits);
    
    %%
    
  end
    
  %%
  
end

%%

confusionmatrix= gefundenmatrix;

for ii= 1:size(gefundenmatrix,1)
  confusionmatrix(ii,:)= ...
            gefundenmatrix(ii,:) ./ ( sum(gefundenmatrix(ii,:)) ) .* 100;
end

%%


