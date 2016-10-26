%% Syntax
%       data= changeColorInRGB(data, colTo)
%       data= changeColorInRGB(data, colTo, colFrom)
%
%% Description
% |data= changeColorInRGB(data, colTo)| 
%
%%
% @return |data| : n x m x 3 dimensional array containing the data of the
% RGB image
%
%% Example
% 
%

figure;

data= imread('GECOC_final_small.png');
data= imread('bwelogo.jpg');

data= changeColorInRGB(data, get(gcf, 'Color'), [255, 255, 253]);

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
% <a href="matlab:doc biogas_gui/get_company_logo">
% biogas_gui/get_company_logo</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_gui/get_gecoc_logo">
% biogas_gui/get_gecoc_logo</a>
% </html>
% 
%% See Also
%
% <<html>
% <a href="matlab:doc biogas_gui/set_input_stream">
% biogas_gui/set_input_stream</a>
% </html>
%
%% TODOs
% # do documentation for script file
% # improve documentation
% # make todos
% # evtl. == colFrom auf >= ändern oder <= um mehr farben zu erhalten
%
%% <<AuthorTag_DG/>>


