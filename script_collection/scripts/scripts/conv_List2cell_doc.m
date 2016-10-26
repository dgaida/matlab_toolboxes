%% Syntax
%       cellarr= conv_List2cell(listobj)
%       
%% Description
% |cellarr= conv_List2cell(listobj)| converts a C# List<> object to a
% MATLAB cell array. A List<String> object is converted to a cellstr
% object, see the example below. C# integers and doubles are directly
% converted to MATLAB doubles. For more datatypes the function has to be
% extended. 
%
%%
% @param |listobj| : a C# List<...> object
%
%%
% @return |cellarr| : cell array containing the content of the given C#
% list object |listobj|. 
%
%% Example
% 
% # Convert List<String> to <matlab:doc('cellstr') cellstr>

substrate= load_biogas_mat_files('koeln');

% this is a C# List<String> object
substrate.ids

conv_List2cell(substrate.ids)

%%
%
% # Convert List<Int32> to cell array of doubles

myvars= NET.createGeneric('System.Collections.Generic.List', {'System.Int32'}, 3);

myvars.Add(1);
myvars.Add(2);
myvars.Add(3);

disp(myvars)

conv_List2cell(myvars)


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
% <a href="matlab:doc biogas_blocks/init_biogas_plant_mdl">
% biogas_blocks/init_biogas_plant_mdl</a>
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

    
    