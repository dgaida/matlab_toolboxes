%% Syntax
% ARROW  Draw a line with an arrowhead.
%
%  ARROW(Start,Stop) draws a line with an arrow from Start to Stop (points
%        should be vectors of length 2 or 3, or matrices with 2 or 3
%        columns), and returns the graphics handle of the arrow(s).
%
%  ARROW uses the mouse (click-drag) to create an arrow.
%
%  ARROW DEMO & ARROW DEMO2 show 3-D & 2-D demos of the capabilities of ARROW.
%
%  ARROW may be called with a normal argument list or a property-based list.
%        ARROW(Start,Stop,Length,BaseAngle,TipAngle,Width,Page,CrossDir) is
%        the full normal argument list, where all but the Start and Stop
%        points are optional.  If you need to specify a later argument (e.g.,
%        Page) but want default values of earlier ones (e.g., TipAngle),
%        pass an empty matrix for the earlier ones (e.g., TipAngle=[]).
%
%  ARROW('Property1',PropVal1,'Property2',PropVal2,...) creates arrows with the
%        given properties, using default values for any unspecified or given as
%        'default' or NaN.  Some properties used for line and patch objects are
%        used in a modified fashion, others are passed directly to LINE, PATCH,
%        or SET.  For a detailed properties explanation, call ARROW PROPERTIES.
%
%        Start         The starting points.                     B
%        Stop          The end points.                         /|\           ^
%        Length        Length of the arrowhead in pixels.     /|||\          |
%        BaseAngle     Base angle in degrees (ADE).          //|||\\        L|
%        TipAngle      Tip angle in degrees (ABC).          ///|||\\\       e|
%        Width         Width of the base in pixels.        ////|||\\\\      n|
%        Page          Use hardcopy proportions.          /////|D|\\\\\     g|
%        CrossDir      Vector || to arrowhead plane.     ////  |||  \\\\    t|
%        NormalDir     Vector out of arrowhead plane.   ///    |||    \\\   h|
%        Ends          Which end has an arrowhead.     //<----->||      \\   |
%        ObjectHandles Vector of handles to update.   /   base |||        \  V
%                                                    E    angle||<-------->C
%  ARROW(H,'Prop1',PropVal1,...), where H is a                 |||tipangle
%        vector of handles to previously-created arrows        |||
%        and/or line objects, will update the previously-      |||
%        created arrows according to the current view       -->|A|<-- width
%        and any specified properties, and will convert
%        two-point line objects to corresponding arrows.  ARROW(H) will update
%        the arrows if the current view has changed.  Root, figure, or axes
%        handles included in H are replaced by all descendant Arrow objects.
%
%  A property list can follow any specified normal argument list, e.g.,
%  ARROW([1 2 3],[0 0 0],36,'BaseAngle',60) creates an arrow from (1,2,3) to
%  the origin, with an arrowhead of length 36 pixels and 60-degree base angle.
%
%  The basic arguments or properties can generally be vectorized to create
%  multiple arrows with the same call.  This is done by passing a property
%  with one row per arrow, or, if all arrows are to have the same property
%  value, just one row may be specified.
%
%  You may want to execute AXIS(AXIS) before calling ARROW so it doesn't change
%  the axes on you; ARROW determines the sizes of arrow components BEFORE the
%  arrow is plotted, so if ARROW changes axis limits, arrows may be malformed.
%
%  This version of ARROW uses features of MATLAB 6.x and is incompatible with
%  earlier MATLAB versions (ARROW for MATLAB 4.2c is available separately);
%  some problems with perspective plots still exist.
%
%% Example
%
%

arrow demo

%%
%

arrow demo2

%%
% Copyright (c)1995-2009, Dr. Erik A. Johnson <JohnsonE@usc.edu>, 5/20/2009
% http://www.usc.edu/civil_eng/johnsone/
%
%%
% Revision history:
%    5/20/09  EAJ  Fix view direction in (3D) demo.
%    6/26/08  EAJ  Replace eval('trycmd','catchcmd') with try, trycmd; catch,
%                    catchcmd; end; -- break's MATLAB 5 compatibility.
%    8/26/03  EAJ  Eliminate OpenGL attempted fix since it didn't fix anyway.
%   11/15/02  EAJ  Accomodate how MATLAB 6.5 handles NaN and logicals
%    7/28/02  EAJ  Tried (but failed) work-around for MATLAB 6.x / OpenGL bug
%                    if zero 'Width' or not double-ended
%   11/10/99  EAJ  Add logical() to eliminate zero index problem in MATLAB 5.3.
%   11/10/99  EAJ  Corrected warning if axis limits changed on multiple axes.
%   11/10/99  EAJ  Update e-mail address.
%    2/10/99  EAJ  Some documentation updating.
%    2/24/98  EAJ  Fixed bug if Start~=Stop but both colinear with viewpoint.
%    8/14/97  EAJ  Added workaround for MATLAB 5.1 scalar logical transpose bug.
%    7/21/97  EAJ  Fixed a few misc bugs.
%    7/14/97  EAJ  Make arrow([],'Prop',...) do nothing (no old handles)
%    6/23/97  EAJ  MATLAB 5 compatible version, release.
%    5/27/97  EAJ  Added Line Arrows back in.  Corrected a few bugs.
%    5/26/97  EAJ  Changed missing Start/Stop to mouse-selected arrows.
%    5/19/97  EAJ  MATLAB 5 compatible version, beta.
%    4/13/97  EAJ  MATLAB 5 compatible version, alpha.
%    1/31/97  EAJ  Fixed bug with multiple arrows and unspecified Z coords.
%   12/05/96  EAJ  Fixed one more bug with log plots and NormalDir specified
%   10/24/96  EAJ  Fixed bug with log plots and NormalDir specified
%   11/13/95  EAJ  Corrected handling for 'reverse' axis directions
%   10/06/95  EAJ  Corrected occasional conflict with SUBPLOT
%    4/24/95  EAJ  A major rewrite.
%    Fall 94  EAJ  Original code.
%
%%
% Things to be done:
%  - in the arrow_clicks section, prompt by printing to the screen so that
%    the user knows what's going on; also make sure the figure is brought
%    to the front.
%  - segment parsing, computing, and plotting into separate subfunctions
%  - change computing from Xform to Camera paradigms
%     + this will help especially with 3-D perspective plots
%     + if the WarpToFill section works right, remove warning code
%     + when perpsective works properly, remove perspective warning code
%  - add cell property values and struct property name/values (like get/set)
%  - get rid of NaN as the "default" data label
%     + perhaps change userdata to a struct and don't include (or leave
%       empty) the values specified as default; or use a cell containing
%       an empty matrix for a default value
%  - add functionality of GET to retrieve current values of ARROW properties
%
%%
% Many thanks to Keith Rogers <kerog@ai.mit.com> for his many excellent
% suggestions and beta testing.  Check out his shareware package MATDRAW
% (at ftp://ftp.mathworks.com/pub/contrib/v5/graphics/matdraw/) -- he has
% permission to distribute ARROW with MATDRAW.
%
%%
% Permission is granted to distribute ARROW with the toolboxes for the book
% "Solving Solid Mechanics Problems with MATLAB 5", by F. Golnaraghi et al.
% (Prentice Hall, 1999).
%
%%
% Permission is granted to Dr. Josef Bigun to distribute ARROW with his
% software to reproduce the figures in his image analysis text.
%
%% TODOs
% # do documentation
% # understand script
%


