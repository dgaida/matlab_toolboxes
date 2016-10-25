%% <<toolbox_id/>>/getHTMLsubfolder
% Get subfolder where the html help files are located, usually 'html'
%
function html_subfolder= getHTMLsubfolder()
%% Release: 1.9

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

html_subfolder= 'html';


%%


