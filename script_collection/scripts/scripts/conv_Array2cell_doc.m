%% Syntax
%       cellarr= conv_Array2cell(arrayobj)
%       
%% Description
% |cellarr= conv_Array2cell(arrayobj)| converts a C# Array object to a
% MATLAB cell array. A Array<String> object is converted to a cellstr
% object, see the example below. C# integers and doubles are directly
% converted to MATLAB doubles (here a standard MATLAB array would be the
% better option, no need to create a cell array, see the example below).
% For more datatypes the function has to be extended. 
%
%%
% @param |arrayobj| : a C# Array<...> object
%
%%
% @return |cellarr| : cell array containing the content of the given C#
% array object |arrayobj|. 
%
%% Example
% 
% # Convert Array<String> to <matlab:doc('cellstr') cellstr>

d1 = NET.createArray('System.String',3);
d1.Set(0, 'one');
d1.Set(1, 'two');
d1.Set(2, 'three');

conv_Array2cell(d1)

%%
%
% # Convert Array<Int32> to cell array of doubles

d2 = NET.createArray('System.Int32',3);
d2(1) = 1;
d2(2) = 2;
d2(3) = 3;

conv_Array2cell(d2)

%%
% this is easier

int32(d2)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/cell">
% matlab/cell</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_blocks/get_sensorlist">
% biogas_blocks/get_sensorlist</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:docsearch('Using,.NET,Libraries,from,MATLAB')">
% Using .NET Libraries from MATLAB</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # maybe extend script and documentation
%
%% <<AuthorTag_DG/>>

    
    