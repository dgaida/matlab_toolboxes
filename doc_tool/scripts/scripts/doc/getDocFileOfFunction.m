%% getDocFileOfFunction
% Returns the doc file '..._doc.m' for the given file or function
%
function doc_file= getDocFileOfFunction(filename)
%% Release: 1.4

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(filename, 'filename', 'char', '1st');


%%

% just look inside the last 6 digits
if numel(filename) > 6
  possible_doc= filename(end - 6:end);
else 
  possible_doc= filename;
end

pos= strfind(possible_doc, '_doc');

if isempty(pos) % no doc found
  pos= strfind(possible_doc, '.m');
  
  if ~isempty(pos) % add _doc and file extension
    if numel(filename) > 6
      doc_file= [filename(1:end - 6 + pos - 2), '_doc.m'];
    else
      doc_file= [filename(1:end - 2), '_doc.m'];
    end
  else
    doc_file= [filename, '_doc'];
  end
else
  pos= strfind(possible_doc, '.m');
  
  if isempty(pos) % add file extension
    doc_file= [filename, '.m'];
  else % just return given filename
    doc_file= filename;
  end
end

%%


