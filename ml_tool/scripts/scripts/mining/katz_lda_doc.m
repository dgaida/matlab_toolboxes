%% Syntax
%       [TransMatnorm]= katz_lda(data, numeigvec)
%       [TransMatnorm, ClassMeanM]= katz_lda(data, numeigvec)
%       [TransMatnorm, ClassMeanM, alpha]= katz_lda(data, numeigvec)
%       [TransMatnorm, ClassMeanM, alpha, [y_tr, X_trans]]= katz_lda(data,
%       numeigvec) 
%
%% Description
% |[TransMatnorm]= katz_lda(data, numeigvec)| performs the Linear
% Discriminant Analysis on the given |data|. If |numeigvec| is smaller
% equal three, then the transformed data is also plotted on a graph.
% Actually two graphs are plotted. The first shows the transformed data and
% the 2nd plot shows the transformed data using the normalized
% transformation |TransMatnorm|. 
%
%%
% @param |data| : training data of the form: [labels, features]
%
% labels is a column vector ranging from 0 to M - 1, labeling the M classes
% and features is the feature matrix of the raw data
%
%%
% @param |numeigvec| : number of eigenvectors of the feature space in
% which is discriminated.
%
%%
% @return |TransMatnorm| : normalized LDA Transformation matrix
%
%%
% |[TransMatnorm, ClassMeanM]= katz_lda(data, numeigvec)|
%
%%
% @return |ClassMeanM| : matrix of class mean vectors
%
%%
% |[TransMatnorm, ClassMeanM, alpha]= katz_lda(data, numeigvec)|
%
%%
% @return |alpha| : see LDA
%
%%
% |[TransMatnorm, ClassMeanM, alpha, [y_tr, X_trans]]= katz_lda(data,
% numeigvec)| 
%
%%
% @return |[y_tr, X_trans]| : the transformed data |X_trans| together with
% their labels |y_tr|. 
%
%%
% The algorithm:
%
% $X^T := \left[ \vec{x}_1, \dots, \vec{x}_i, \dots, \vec{x}_N \right]^T,
% \vec{x}_i \in R^n, i= 1, \dots, N$ 
%
% $\vec{y}^T := \left( y_1, \dots, y_i, \dots, y_N \right)^T$ 
%
% $\Theta := \left\{ 1, \dots, \vartheta, \dots, M \right\}$
%
% $M := NumClass$
%
% $N := Numfeat$
%
% $n := dim$
%
% $\vec{M}_0 := \frac{1}{N} \sum_{i=1}^{N} \vec{x}_i$
%
% $\vec{M}_\vartheta := \frac{1}{N_\vartheta} \sum_{i=1, Y \left(
% \vec{x}_i \right) = \vartheta}^{N} \vec{x}_i$ 
%
% $\sum_{i=1, Y \left( \vec{x}_i \right) = \vartheta}^{N} \left(
% \vec{x}_i - \vec{M}_\vartheta \right) \cdot \left( \vec{x}_i -
% \vec{M}_\vartheta \right)^T$  
%
% $\sum_{i=1}^{N} \left( 
% \vec{x}_i - \vec{M}_0 \right) \cdot \left( \vec{x}_i - \vec{M}_0
% \right)^T$ 
%
% $\sum_{\vartheta=1}^{M} \sum_{i=1, Y \left( \vec{x}_i \right) =
% \vartheta}^{N} \left( 
% \vec{x}_i - \vec{M}_\vartheta \right) \cdot \left( \vec{x}_i -
% \vec{M}_\vartheta \right)^T$  
%
% $S_W := \frac{1}{N} \cdot \sum_{\vartheta=1}^{M} \sum_{i=1, Y \left(
% \vec{x}_i \right) = \vartheta}^{N} \left( 
% \vec{x}_i - \vec{M}_\vartheta \right) \cdot \left( \vec{x}_i -
% \vec{M}_\vartheta \right)^T$  
%
% $S_T := \frac{1}{N} \cdot \sum_{i=1}^{N} \left( 
% \vec{x}_i - \vec{M}_0 \right) \cdot \left( \vec{x}_i - \vec{M}_0
% \right)^T$  
%
% $W := S_W^{-1} \cdot S_T$
%
%% Example
% 
% Example I: 

close all;

data= load('iris.dat');

data= [data(:, end) - 1, data(:, 2:end - 1)];

%%
% LDA transformed data

[TransMatnorm]= katz_lda(data, 2);

%%
% original data

A= cross(TransMatnorm(:,1), TransMatnorm(:,2));

%plot3views( @()testplot(data, A) );

plot3dLinConstraints(A', 5, [20, 10, 0], [50, 40, 25]);

%%

scatter3(data(:,2), data(:,3), data(:,4), [], ...
         data(:,1), 's', 'filled', 'LineWidth', 0.01, ...
         'MarkerEdgeColor', 'k');

%%

caxis([min(data(:,1)) max(data(:,1))])
xlim([20, 45]);

%%

rotate3d on

%%
% Example II: 

figure

scatter3(data(:,2), data(:,3), data(:,4), [], ...
         data(:,1), 's', 'filled', 'LineWidth', 0.01, ...
         'MarkerEdgeColor', 'k');

rotate3d on

%%
% Example III:


%%
% LDA transformed data

[TransMatnorm]= katz_lda(data(:,1:3), 1);

c= numerics.math.crossND(TransMatnorm);
 
%%
% original data

figure;

%%

plot2dLinConstraints(c', -12, [20, 10], [45, 70], [], 'b');

hold on;

%plot2dLinConstraints(TransMatnorm', -3, [20, 10], [45, 70]);

scatter(data(:,2), data(:,3), [], ...
        data(:,1), 's', 'filled', 'LineWidth', 0.01, ...
        'MarkerEdgeColor', 'k');

%%

caxis([min(data(:,1)) max(data(:,1))])
xlim([10, 45]);

hold off;

daspect([1 1 1]);

%%

figure;

arrow([0, 0], c');
hold on;
arrow([0, 0], TransMatnorm');
hold off;

daspect([1 1 1]);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc inv">
% matlab/inv</a>
% </html>
% ,
% <html>
% <a href="matlab:doc unique">
% matlab/unique</a>
% </html>
% ,
% <html>
% <a href="matlab:doc eig">
% matlab/eig</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc plot3">
% matlab/plot3</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="startlda.html">
% startLDA</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="lda_evaluation.html">
% LDA_evaluation</a>
% </html>
% ,
% <html>
% <a href="lda_lin_classifier.html">
% LDA_lin_classifier</a>
% </html>
%
%% TODOs
% # add and check some formulas in documentation
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>
% M. Katz, Düsseldorf
%
%% References
%
% # Duda, R.O., Hart, E., Stork, D.G.: Pattern Classification, John Wiley
% & Sons, Inc., (2000) 
%


