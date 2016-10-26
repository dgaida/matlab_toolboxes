%% Syntax
%       logo= get_company_logo()
%       logo= get_company_logo(color)
%
%% Description
% |logo= get_company_logo()| 
%
% Uses global constant |COMPANY| which is set in 'setpath_biogaslibrary.m'.
% 
%
%%
% @return |logo| : n x m x 3 dimensional array containing the data of the
% RGB image
%
%% Example
% 
%

figure;

data= get_company_logo();

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
% <html>
% <a href="matlab:doc biogas_gui/get_gecoc_logo">
% biogas_gui/get_gecoc_logo</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # improve documentation
% # make todos
%
%% <<AuthorTag_DG/>>


