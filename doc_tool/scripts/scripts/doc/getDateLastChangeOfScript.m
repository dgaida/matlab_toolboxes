%% getDateLastChangeOfScript
% Get the date when the given script was changed last time
%
function date= getDateLastChangeOfScript(filename, varargin)
%% Release: 1.4

%%

error( nargchk(1, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(filename, 'filename', 'char', '1st');

if nargin >= 2 && ~isempty(varargin{1})
  dateformat= varargin{1};
  
  checkArgument(dateformat, 'dateformat', 'char', '2nd');
else
  dateformat= 'dd.mm.yyyy';
end


%%

dir_info= dir(filename);

if ~isempty(dir_info)
  date= dir_info.date;

  date= datestr(date, dateformat);
else
  error('Could not find the file %s! May be you forgot the file extension!?', ...
        filename);
end

%%


