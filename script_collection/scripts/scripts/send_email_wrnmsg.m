%% send_email_wrnmsg
% Send eMail to an e-Mail address with attachments
%
function  send_email_wrnmsg(varargin)
%% Release: 1.9

%%

error( nargchk(1, 6, nargin, 'struct') );
error( nargchk(0, 0, nargout, 'struct') );

%% 
% Input Initialization

if nargin >= 1 && ~isempty(varargin{1})
  email= varargin{1};         % e-mail to be sent to
  
  checkArgument(email, 'email', 'char', '1st');
else
  error('Set an e-mail account for the warning message be sent to!');
end

if nargin >= 2 && ~isempty(varargin{2})
  subject= varargin{2};       % subject of the e-mail
  
  checkArgument(subject, 'subject', 'char', '2nd');
else
  subject= 'Test from MATLAB';
end

if nargin >= 3 && ~isempty(varargin{3})
  msg1= varargin{3};          % message of the email
  
  checkArgument(msg1, 'msg1', 'char', '3rd');
else
  msg1= 'Hello! This is a test from MATLAB!';
end

if nargin >= 4 && ~isempty(varargin{4})
  attFile_name= varargin{4}; 	% Attach file name, this is the name of the zip
  
  checkArgument(attFile_name, 'attFile_name', 'char', '4th');
else
  attFile_name= [];
end

if nargin >= 5 && ~isempty(varargin{5})
  attFiles= varargin{5};      % Attach files
  
  checkArgument(attFiles, 'attFiles', 'cellstr', '5th');
else
  attFiles= {'*.m','*.mat','*.txt'};
end

if nargin >= 6 && ~isempty(varargin{6})
  attFile_path= varargin{6}; 	% Attach file path
  
  checkArgument(attFile_path, 'attFile_path', 'char', '6th');
else
  attFile_path= pwd;
end


%%
% Define Pop Email Server credencials:

mail=     'wrnmsg.gecoc@googlemail.com'; % Your GMail email address
password= 'warningmsg';                  % Your GMail password


%%
% Set up the e-mail preferences properly:

setpref('Internet', 'E_mail',        mail);
setpref('Internet', 'SMTP_Server',   'smtp.gmail.com');
setpref('Internet', 'SMTP_Username', mail);
setpref('Internet', 'SMTP_Password', password);

props= java.lang.System.getProperties;
props.setProperty('mail.smtp.auth', 'true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port', '465');


%% 
% Attach file
% attached file is saved in the current folder
% All files insed the current folder are saved
if ~isempty(attFile_name)
  zip( attFile_name , attFiles , attFile_path )
  attFile_name= [ attFile_name, '.zip' ];
end


%% 
% Send the email. Note that the first input is the address you are sending
% the email to 

try
  
  if ~isempty(attFile_name)
    sendmail( email, subject, msg1, attFile_name );
  else
    sendmail( email, subject, msg1 );
  end
  
  %%
  
  dispMessage(sprintf('Successfully send mail to %s!', email), mfilename);

catch me

  try
    sendmail( email, subject, [ msg1 10 'attachment failed to be sent!' ] );
  catch me2
    disp('ERROR! : Could not send the e-mail, check the internet settings!')
    disp(me2.message)
  end

  disp(me.message)
    
end

%%


