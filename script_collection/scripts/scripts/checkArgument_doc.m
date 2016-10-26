%% Syntax
%       checkArgument(argument, argument_name, argument_class,
%       ordinal_number) 
%       checkArgument(argument, argument_name, argument_class,
%       ordinal_number, onlycheckifnotempty) 
%
%% Description
% |checkArgument(argument, argument_name, argument_class, ordinal_number)|
% checks the given |argument| whether it is an object of the correct class
% |argument_class|. If there is a mismatch between the classes an error is
% thrown. Useful to check the arguments of functions and methods.
% Alternative MATLAB internal methods are <matlab:doc('validateattributes')
% validateattributes> and <matlab:doc('validatestring') validatestring>. 
%
%%
% @param |argument| : The argument that will be checked.
%
%%
% @param |argument_name| : char with the name of the argument. 
%
%%
% @param |argument_class| : char with the class of the |argument|, that the
% |argument| should have. This function checks for the following classes:
%
% * 'char', 'double', 'cellstr', 'cell', 'numeric', 'logical', 'struct' and uses
% <matlab:doc('isa') isa> to check for other classes. 
%
% |argument_class| may also contain more than one class, if the given
% |argument| may be of different classes. Then provide the classes splittet
% by the or symbol '||'. E.g.: 'char || cell' or 'char||cell'. 
%
%%
% @param |ordinal_number| : char with the ordinal number of the given
% argument, so its position in the calling function. Should be in between
% '1st' and '15th'. May also be a positive integer value. If it is, then
% during output a 'th' is appended after the number. 
%
%%
% |checkArgument(argument, argument_name, argument_class, ordinal_number,
% onlycheckifnotempty)| does the same, except if |onlycheckifnotempty| is
% 'on', then only check function argument when it is not empty. 
%
%%
% @param |onlycheckifnotempty| : char: 'on' or 'off'. 
%
% * 'on' : If 'on' then only check function argument if it is not empty. 
% * 'off' : Always check function argument. Default: 'off'.
%
%% Example
% 
% All of the following examples are going to throw an error.
%
% Expect a char, but got a double. 

try
  checkArgument(1, 'myNumber', 'char', '1st');
catch ME
  disp(ME.message);
end

%%
% Expect a double but got a cell of chars. 

try
  checkArgument({'Q1', 'Q2'}, 'myCellStr', 'double', '1st');
catch ME
  disp(ME.message);
end

%%
% This example does not throw an error. A cell is given and a
% <matlab:doc('cellstr') cellstr> is given, which is a cell. You could also
% write 'cellstr' as third argument to make the specification more
% accurate. 

checkArgument({'Q1', 'Q2'}, 'myCellStr', 'cell', 5);

%%
% This example does not throw an error as well: If the last parameter is
% omitted, then an error would be thrown. 
%

checkArgument([], 'myCellStr', 'char', '1st', 'on');

%%
% check if cellstr or char

checkArgument('Q1', 'mychar', 'cellstr || char', 5);

%%
% check if double or char

try
  checkArgument({'Q1', 'Q2'}, 'mycell', 'double||char', 4);
catch ME
  disp(ME.message);
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc validatestring">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc error">
% matlab/error</a>
% </html>
% ,
% <html>
% <a href="matlab:doc isa">
% matlab/isa</a>
% </html>
% ,
% <html>
% <a href="matlab:doc ischar">
% matlab/ischar</a>
% </html>
% ,
% <html>
% <a href="matlab:doc iscell">
% matlab/iscell</a>
% </html>
% ,
% <html>
% <a href="matlab:doc iscellstr">
% matlab/iscellstr</a>
% </html>
% ,
% <html>
% <a href="matlab:doc islogical">
% matlab/islogical</a>
% </html>
%
% and is called by:
%
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/isn0">
% script_collection/isN0</a>
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
% <a href="matlab:doc script_collection/isz">
% script_collection/isZ</a>
% </html>
%
%% TODOs
% # check links and appearance of documentation
% # using <matlab:doc('inputname') inputname> the 2nd argument actually
% could be omitted. maybe overload function using inputname. 
%
%% <<AuthorTag_DG/>>


