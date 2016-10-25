%% gecoc_tool
% doc gecoc_tool
%
%% Toolbox
% |gecoc_tool| belongs to the _GECO-C MATLAB Tools Definition_ Toolbox and
% is a handle class.  
%
%% Release
% Approval for Release 1.9, to get the approval for Release 2.0 make the
% TODOs and a thorough review, Daniel Gaida 
%
%% Syntax
%       gecoc_tool()
%
%% Description
%
% Definition of the class gecoc_tool
%
% In this file the gecoc_tool class is defined. 
%
% This class is a handle class.
%
%%
% |gecoc_tool| 
%
%% Example
%
%
%% Dependencies
% 
% Methods of this class call:
%
% -
%
% and are called by:
%
% -
%
%% See Also
%
% -
%
%% TODOs
% # 
%
%% Author
% Daniel Gaida, M.Sc.EE.IT
%
% Cologne University of Applied Sciences (Campus Gummersbach)
%
% Department of Automation & Industrial IT
%
% GECO-C Group
%
% daniel.gaida@fh-koeln.de
%
% Copyright 2012-2012
%
% Last Update: 04.02.2012
%
%% Function
%
classdef gecoc_tool < handle

    
  %% Properties
  %
  properties (Access= public)

    

  end


  %% Methods
  %
  methods (Access= public)

    
    
  end
  
  %% Methods
  %
  methods (Static, Abstract)

    %% getHelpPath
    % Get path to the folder in which the help of the Toolbox is located
    %
    help_path= getHelpPath()

    %% getToolboxID
    % Get ID of the toolbox
    %
    toolboxID= getToolboxID()

    %% getToolboxName
    % Get name of the toolbox
    %
    toolboxName= getToolboxName()

    %% getToolboxPath
    % Get entry path of the Toolbox
    %
    toolbox_path= getToolboxPath()
    
    %% getHTMLsubfolder
    % Get subfolder where the html help files are located, usually 'html'
    %
    html_subfolder= getHTMLsubfolder()
    
    %%
    %
    

  end % end methods

  %% Methods
  %
  methods (Static, Access= private)

    

  end

  %%
  %
    
end % end class

%%


