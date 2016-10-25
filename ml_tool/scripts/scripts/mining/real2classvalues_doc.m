%% Syntax
%       [data_classes, mini, maxi]= real2classvalues(data_real, bins)
%       [...]= real2classvalues(data_real, bins, min_y, max_y)
%       
%% Description
% |[data_classes, mini, maxi]= real2classvalues(data_real, bins)| scales
% real values in vector to class values. Needed for classification. 
%
%%
% @param |data_real| : double vector containing real data. 
%
%%
% @param |bins| : number of bins used to cluster the real data into
% different classes. 
%
%%
% @return |data_classes| : clustered data vector. The classes are between 0
% and |bins - 1|. Classes could also be below 0 and above |bins - 1|, see
% parameters |min_y| and |max_y| below. In that case a warning is thrown. 
%
%%
% @return |mini| : min value inside |data_real|.
%
%%
% @return |maxi| : max value inside |data_real|. 
%
%%
% @param |min_y| : If given, then a value of |min_y| inside |data_real| is
% mapped to 0. Smaller values become negative in |data_classes|, larger
% values positive. If it is not given or empty (default), then the minimum
% inside |data_real| is mapped to 0. 
%
%%
% @param |max_y| : If given, then a value of |max_y| inside |data_real| is
% mapped to 1. Smaller values become < |bins - 1| in |data_classes|, larger
% values > |bins - 1|. If it is not given or empty (default), then the maximum
% inside |data_real| is mapped to |bins - 1|. 
%
% If either |min_y| or (exclusive) |max_y| is empty, then none of them is
% used and a warning is thrown. 
%
%% Example
% 
%

data_real= 7 .* rand(1000, 1);

[data_classes, mini, maxi]= real2classvalues(data_real, 4);

plot(1:1000, sort(data_classes), 1:1000, sort(data_real));

figure, hist(data_real);

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href= matlab:doc('round')>
% matlab/round</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isr">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/scale_data')">
% data_tool/scale_Data</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_ml/getvectoroutofstream')">
% biogas_ml/getVectorOutOfStream</a>
% </html>
% 
%% See Also
%
% -
%
%% TODOs
% # check appearance of documentation
% # durch round ist die Aufteilung in Klassen nicht exakt gleich, s.
% Beispiel
% 
%% <<AuthorTag_DG/>>


