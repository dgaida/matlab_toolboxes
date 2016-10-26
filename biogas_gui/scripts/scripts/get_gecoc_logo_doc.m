%% Syntax
%       logo= get_gecoc_logo()
%       logo= get_gecoc_logo(color)
%
%% Description
% |logo= get_gecoc_logo()| 
%
%%
% @param |color| : 3dimensional double vector with color, normalized
% between 0 and 1
%
%%
% @return |logo| : n x m x 3 dimensional array containing the data of the
% RGB image
%
%% Example
% 
%

figure;

data= get_gecoc_logo(get(gcf, 'Color'));

image(data);

clear data;

axis('off');

%%

figure;

data= get_gecoc_logo();

image(data);

clear data;

axis('off');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc uint8">
% matlab/uint8</a>
% </html>
% ,
% <html>
% <a href="matlab:doc imread">
% matlab/imread</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_gui/set_input_stream">
% biogas_gui/set_input_stream</a>
% </html>
% 
%% See Also
%
% -
%
%% TODOs
% # do documentation for script file
% # improve documentation
% # make todos
%
%% <<AuthorTag_DG/>>


