%% getPublicationLocation
% Reads file |publish_location.txt| and returns where help of given |path|
% is published.
%
function pub_location= getPublicationLocation(path)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(path, 'path', 'char', '1st');

%%

try
  html_file= fopen(fullfile(path, 'publish_location.txt'), 'r');
catch ME
  pub_location= [];
  disp(ME.message);
  
  return;
end

if (html_file == -1)
  pub_location= [];
  
  return;
end

pub_location= '%';

%%
% return the first line after lines of comments finished

while ( strcmp(pub_location(1), '%') )
  pub_location= fgetl(html_file);
end

fclose(html_file);

%%


