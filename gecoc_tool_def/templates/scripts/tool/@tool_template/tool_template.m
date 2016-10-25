%% <<toolbox_id/>>
% doc <<toolbox_id/>>
%
%% Toolbox
% |<<toolbox_id/>>| belongs to the _<<toolbox_name/>>_ Toolbox and
% is a handle class.  
%
%% Release
% Approval for Release 1.9, to get the approval for Release 2.0 make the
% TODOs and a thorough review, Daniel Gaida 
%
%% Syntax
%       <<toolbox_id/>>()
%
%% Description
%
% Definition of the class <<toolbox_id/>>
%
% In this file the <<toolbox_id/>> class is defined. 
%
% This class is a handle class.
%
%%
% |<<toolbox_id/>>| 
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
% Copyright 2009-2012
%
% Last Update: <<now/>>
%
%% Function
%
classdef <<toolbox_id/>> < gecoc_tool

    
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
  methods (Static)

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


