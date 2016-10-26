%% Syntax
%         send_email_wrnmsg(email)
%         send_email_wrnmsg(email, subject)
%         send_email_wrnmsg(email, subject, msg1)
%         send_email_wrnmsg(email, subject, msg1, attFile_name)
%         send_email_wrnmsg(email, subject, msg1, attFile_name, attFiles)
%         send_email_wrnmsg(email, subject, msg1, attFile_name, attFiles,
%         attFile_path) 
%
%% Description
% |send_email_wrnmsg(email)| sends an email to the given email address
% |email|. The subject will be 'Test from MATLAB' and the message 'Hello!
% This is a test from MATLAB!'. The mail will be send from a gmail account
% using <matlab:doc('sendmail') sendmail>. 
%
%%
% @param |email| : e-mail address to which the e-mail is sent to
% 
%%
% |send_email_wrnmsg(email, subject)| additionally sets the subject of the
% mail
%
%%
% @param |subject| : char with the subject of the e-mail
%
%%
% |send_email_wrnmsg(email, subject, msg1)| additionally sets the message
% to be sent
%
%%
% @param |msg1| : char with the message of the e-mail
%
%%
% |send_email_wrnmsg(email, subject, msg1, attFile_name)| attaches a zip
% file named |attFile_name| to the mail. The e-mail contains all *.m and
% *.mat file in the <matlab:doc('pwd') present working directory>. 
%
%%
% @param |attFile_name| : name of the zip file, without filetype extension
%
%%
% |send_email_wrnmsg(email, subject, msg1, attFile_name, attFiles)| puts
% all filetypes defined by the cell string |attFiles| inside the zip file. 
%
%%
% @param |attFiles| : array of cell strings defining filetypes. 
% Default: {'*.m','*.mat'} 
%
%%
% |send_email_wrnmsg(email, subject, msg1, attFile_name, attFiles,
% attFile_path)| adds the defined files in the given directory
% |attFile_path| to the mail. 
%
%%
% @param |attFile_path| : char defining a path. Default: <matlab:doc('pwd')
% pwd>. 
%
%% Example
%
% #: Send an empty e-mail

send_email_wrnmsg('daniel.gaida@fh-koeln.de');

%%
% #: Send an email and attach all m- and mat files to the mail
%

send_email_wrnmsg('daniel.gaida@fh-koeln.de', [], [], 'myzip');

% clean up afterwards

if exist('myzip.zip', 'file')
  delete('myzip.zip');
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc sendmail">
% matlab/sendmail</a>
% </html>
% ,
% <html>
% <a href="matlab:doc zip">
% matlab/zip</a>
% </html>
% ,
% <html>
% <a href="matlab:doc setpref">
% matlab/setpref</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_control/nonlinearmpc">
% biogas_control/nonlinearMPC</a>
% </html>
%
%% See Also
%
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_ALSB/>>
%% References
%
% <html>
% <a href="http://www.mathworks.com/support/solutions/en/data/1-3PRRDV/">
% http://www.mathworks.com/support/solutions
% </a>
% </html>
%


