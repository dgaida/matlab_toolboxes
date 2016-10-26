%% display_selected_fermenter
% Display the selected fermenter on the block.
%
function display_selected_fermenter(id_fermenter, y_text_pos)
%% Release: 1.7

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% check input parameters

isN(id_fermenter, 'id_fermenter', 1);

validateattributes(y_text_pos, {'double'}, {'scalar', 'nonnegative', '<=', 1}, ...
                   mfilename, 'y_text_pos', 2);
        
%%
% set block display

% get current display, looks something like:
%   image(imread('icon_s6_digester','bmp'),'center')
%   port_label('input', 1, 'Qin', ...
%       'texmode', 'on')
%   port_label('output', 1, 'Gas [m^3/d]')
%   port_label('output', 2, 'Gas [%]')
%   port_label('output', 3, 'Qe')
%   port_label('output', 4, 'int.vars')
%   port_label('output', 5, 'pH')
%   text(0.5, 7.0e-001, '--- Bitte Fermenter wählen ---', 'horizontalAlignment', 'center')
old_display= get_param(gcb, 'MaskDisplay');

text_w_pos= ...
    sprintf('text(0.5, %.1d, ''.*?'', ''horizontalAlignment'', ''center''', ...
             y_text_pos);

% is there already something plotted at the position y_text_pos?
string= regexp(old_display, text_w_pos, 'once');


%%

% get chosen values, something like:
  % {'Hauptfermenter';'off';'on';'off';'off';}
values= get_param_error('MaskValues');

values= values(:);

if id_fermenter > numel(values)
  error('id_fermenter (%i) exceeds dimension of values (%i)!', ...
         id_fermenter, numel(values));
end

new_text= ...
    sprintf('text(0.5, %.1d, ''%s'', ''horizontalAlignment'', ''center''', ...
             y_text_pos, char(values(id_fermenter)));

%%

if isempty(string)
  % nothing plotted yet
  new_display= strcat(sprintf('%s\n%s', old_display, new_text), ')');
else
  % replace the existing string
  new_display= regexprep(old_display, text_w_pos, new_text);
end


%%

try
  set_param(gcb, 'MaskDisplay', new_display);
catch ME
  warning('Set:MaskDisplay', ['Could not set the parameter MaskDisplay of block ', ...
           gcb, '! The to be set value is ', new_display, '!']);

  if getMATLABVersion() < 711
    rethrow(ME);
  else
    disp('display_selected_fermenter: not throwing!');
  end
end
    
%%


    