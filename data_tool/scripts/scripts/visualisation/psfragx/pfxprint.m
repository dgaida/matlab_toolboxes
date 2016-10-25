%%% pfxprint [ -*- Matlab -*- ] Time-stamp: <2004-08-12 18:20:57 Pascal Kockaert>
%%%

function pfxprint(fig,name,varargin)
 deftxtint=get(0,'DefaultTextInterpreter');
 set(0,'DefaultTextInterpreter','none');

  laprint(fig,name,'options','laprpfx',varargin{:});
  psfragx(name);

 set(0,'DefaultTextInterpreter',deftxtint)

