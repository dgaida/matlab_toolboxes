%% psfragx.m [2012/05/02 v0.4 Pascal Kockaert]
%%
%% function psfragx(TeXname,EPSname,Outname)
%% nargin=1 -> EPSname=TeXname
%% nargin=2 -> Outname=EPSname
%%
%% Interleaves lines of TeXname.tex and EPSname.eps
%% so that all the lines of EPSname.eps are copied in Outname.tex and
%% lines from TeXname.tex starting with
%% \psfrag
%% and
%% %<pfx>
%% are written in Outname.eps, as a comment following the
%% %%BoundigBox
%% line.

%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This file is currently maintained by Pascal Kockaert

function psfragx(TeXname,EPSname,Outname)
TMPname='psfragx_tmp';
if nargin<2, EPSname=TeXname; end
if nargin<3, Outname=EPSname; end
if Outname==EPSname,
   eval(['!rm ',TMPname,'.eps'])
   eval(['!mv ',EPSname,'.eps ',TMPname,'.eps'])
   EPSname=TMPname;
end
TeXName=([TeXname,'.tex']);
EPSName=([EPSname,'.eps']);
OutName=([Outname,'.eps']);

%% Uncomment for debugging purposes
%% eval(['ls ',TeXName])
%% eval(['ls ',EPSName])
%% eval(['ls ',OutName])

BeginInput ='%%BoundingBox:';
BeginPSFRAG='%<pfx>\pfxbegin[1.0]{laprint}%';
EndPSFRAG  ='%<pfx>\pfxend';
StartPFX   ='%<*pfx> Inserted where \begin{psfrags}% occured';
StopPFX    ='%</pfx> Inserted where \end{psfrags}% occured';
EndInput  ='%\endinput';
EndOfFile ='%%EOF';
ResizeBox ='%<pfx>\def\naturalwidth';
StopOn    ={'\psfrag{','<pfx>','\begin{psfrags}','\end{psfrags}','\resizebox'};

TeXFile=fopen(TeXName,'r');
if (TeXFile==-1)
        error(['I was not able to open ',TeXName,'!']);
end
EPSFile=fopen(EPSName,'r');
if (EPSFile==-1)
        error(['I was not able to open ',EPSName,'!']);
end
OutFile=fopen(OutName,'w');
if (OutFile==-1)
        error(['I was not able to open ',OutName,'!']);
end

[sEPS,llEPS,iEPS]=CopyUntil(EPSFile,OutFile,{BeginInput});
       if sEPS~=1, error(['No line contains ',BeginInput]);
       else
                 fprintf(OutFile,'%s\n',llEPS);
       end

%%%
%%% Write preamble
%%%
fprintf(OutFile,'%%<*pfx> Begin Preamble\n');
fprintf(OutFile,'%%\\providecommand*{\\pfxbegin}[2][]{}%%\n');
fprintf(OutFile,'%%\\providecommand{\\pfxend}{}%%\n');
fprintf(OutFile,'%%</pfx> End Preamble\n');
%%%
%%% Copy interesting lines
%%%
while 1
       [sTeX,llTeX,iTeX]=ReadUntil(TeXFile,StopOn);
              if sTeX~=1, break; end
       switch iTeX
          case 1,    %   \psfrag
                 fprintf(OutFile,'%%%s\n',llTeX);
          case 2,    %   %<pfx>
                 fprintf(OutFile,'%s\n',llTeX);
          case 3,    %   \begin{psfrags}
                 fprintf(OutFile,'%s\n',BeginPSFRAG);
                 fprintf(OutFile,'%s\n',StartPFX);
          case 4,    %   \end{psfrags}
                 fprintf(OutFile,'%s\n',StopPFX);
                 fprintf(OutFile,'%s\n',EndPSFRAG);
          case 5,    %   \resizebox
                 tmpbeg=findstr(llTeX,'{');
                 tmpend=findstr(llTeX,'}');
                 if (length(tmpbeg)>0)&(length(tmpend)>0)
                     if (tmpbeg(1)<tmpend(1))
                        fprintf(OutFile,'%s%s%%\n',ResizeBox,llTeX(tmpbeg(1):tmpend(1)));
                     end
                 end
       otherwise
              error('Otherwise should never happen !')
       end
end
%%%
%%% Write postamble
%%%
fprintf(OutFile,'%s\n',EndInput);
%%%
%%% Copy to the end of file
%%%
[sEPS,llEPS,iEPS]=CopyUntil(EPSFile,OutFile,{''});
%%%
%%% Close files
%%%
fclose(OutFile);
fclose(TeXFile);
fclose(EPSFile);
return

function [OK,lastline,elt]=CopyUntil(fidIn,fidOut,linebeg);
sl=length(linebeg);
if sl==0, OK=-2; return, end
llb=zeros(sl);
for ii=1:sl
       llb(ii)=length(linebeg{ii});
end
lastline='';
OK=0;
elt=0;
while 1
       Line=fgetl(fidIn);
       if ~isstr(Line),
              OK=-1;
              return,
       end  %EndOfFile
       for ii=1:sl
%%%              fprintf('Seeking for line starting with %s.\n',linebeg{ii});
              if llb==0,    %%% Copying to the end of file
              else
                     if length(Line)>=llb(ii)
%%%                            fprintf('This line counts more than %i chars.\n',llb(ii));
                            if Line(1:llb(ii))==linebeg{ii},
                                   OK=1;
                                   elt=ii;
                                   lastline=Line;
                                   break
                            end
                     end
              end
       end    %%% No matching string
       if OK==1, break, end
       if ~isempty(fidOut)
              fprintf(fidOut,'%s\n',Line);
       end
end
return

function [OK,lastline,elt]=ReadUntil(fidIn,linebeg);
         [OK,lastline,elt]=CopyUntil(fidIn,[],linebeg);
return
