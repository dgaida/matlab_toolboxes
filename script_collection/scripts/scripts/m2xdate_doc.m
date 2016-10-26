%% Syntax
%       DateNumber = m2xdate(MATLABDateNumber, Convention)
%
%% Description
%   Summary: This function converts serial date numbers from the MATLAB
%            serial date number format to the Excel serial date number format.
%
%   Inputs: MATLABDateNumber - Nx1 or 1xN vector of serial date numbers in
%           MATLAB serial date number form
%           Convention - Nx1 or 1xN vector or scalar flag value indicating
%           which Excel serial date number convention should be used when
%           converting from MATLAB serial date numbers; possible values are:         
%           a) Convention = 0 - 1900 date system in which a serial date
%                number of one corresponds to the date 31-Dec-1899 (default)
%           b) Convention = 1 - 1904 date system in which a serial date
%                number of zero corresponds to the date 1-Jan-1904
%
%   Outputs: Nx1 or 1xN vector of serial date numbers in Excel serial date
%            number form.
%
%% Example
% 
% returns EndDate = 35746

StartDate = 729706;
Convention = 0;

m2xdate(StartDate, Convention)

%%     
%
%   NOTE: A BUG present in Excel (still present as of Excel 2003 SP1) causes
%         Excel to consider the year 1900 a leap year. As a result, all
%         DATEVALUE's reported by Excel between Jan. 1, 1900 and Feb. 28, 1900
%         (inclusive) differs from the values reported by M2XDATE by 1.
%
%         For example: 
%                     In Excel,  Jan. 1, 1900 = 1
%                     In MATLAB, Jan. 1, 1900 = 2   
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc find">
% matlab/find</a>
% </html>
% ,
% <html>
% <a href="matlab:doc datenum">
% matlab/datenum</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc data_tool/writetodatabase">
% data_tool/writetodatabase</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc finance/x2mdate">
% finance/x2mdate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc finance/m2xdate">
% finance/m2xdate</a>
% </html>
%
%%
%   Copyright 1995-2006 The MathWorks, Inc.
%   $Revision: 1.8.2.5 $   $Date: 2006/11/08 17:47:28 $ 
%
%% TODOs
% # check documentation
% # check code
%
%% <<AuthorTag_DG/>>


