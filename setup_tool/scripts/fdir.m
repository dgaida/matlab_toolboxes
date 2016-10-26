%% fdir
% List all (sub)folders in a directory and total bytes.
%
function S = fdir(varargin)
%% Release: 1.0

%FDIR  List all (sub)folders in a directory and total bytes.
%   S=fdir(varargin) returns a struct containing all folders and
%   subfolders within the specified directory, given by varargin,
%   and total bytes within each folder
%
%   The struct is sorted in descending order by total size in bytes
%
%   Syntex for varargin is the same for function 'rdir.m'
%
%   Example:
%
%   %Return ordered struct of all folders and subfolders within the current
%   %directory with only keeping track of .m files
%   S=fdir('**\*.m')
%
%   %Return ordered struct of all folders and subfolders containing .pdf
%   %files between a certain size, all within subdirectories C drive
%   S=fdir('C:\**\*.pdf','bytes>1024 & bytes<1048576')
%
%   %Return an ordered struct of all subdirectories within C and their sizes
%   S=fdir('C:\**\*')
%
%   Note: Required function 'rdir' is available on
%   Matlab File Exchange
%   (rdir  : File ID: #19550) Author: G. Brown

%
%   Mike Sheppard
%   MIT Lincoln Laboratory
%   michael.sheppard@ll.mit.edu
%   Original: 19-Jan-2011

%%

error( nargchk(0, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if ~exist('rdir', 'file')
  error('FDIR: rdir.m not found. Available as File ID: #19550 on File Exchange')
end

if nargin==1
  D=rdir(varargin{1});
else
  D=rdir(varargin{1},varargin{2:end});
end



%Extract bytes for each file
bytes=[D.bytes]';
%In some cases, especially for whole drive searches some files might have
%empty bytes (bytes=[]). If so, the line above removes those and dimensions
%won't match up. Detect index of empty bytes files and replace with zero.
if length(bytes)~=length(D)
  EmptyIndx=find(cellfun('isempty',{D.bytes}));
  for i=1:length(EmptyIndx), D(EmptyIndx(i)).bytes=0; end
  bytes=[D.bytes]';
end



%Initialize
ind=1;
inter=0;
name={D.name}';
AllFoldersTemp=[];
AllBytesTemp=[];



%Repeatedly remove final paths, summing up cumulative bytes within directories
while ind
  DirTemp=cellfun(@(c) c(1:-1+max(findstr(c,'\'))),name,'UniformOutput',false); %Extract previous directory
  [FoldersTemp,I,J]=unique(DirTemp);


  %%%%%%%%%%%%
  %% added by D. Gaida
  if isempty(J) && isempty(bytes)
    S.folders= [];
    S.bytes= [];
    return;
  end
  %%%%%%%%%%%%


  BytesTemp=accumarray(J, bytes);
  AllFoldersTemp=[AllFoldersTemp; FoldersTemp];
  AllBytesTemp=[AllBytesTemp; BytesTemp];
  name=FoldersTemp;
  bytes=BytesTemp;
  inter=inter+1;                   %Number of interations
  if length(name)==1, ind=0; end   %Stop when reached main folder
end



%Combined everything, taking care of repeats
[AllFolders,I,J]=unique(AllFoldersTemp);
AllBytes=accumarray(J, AllBytesTemp);
%Fix '' as special case, would be first entry and overall total bytes
if isempty(AllFolders{1}), AllBytes(1)=sum([D.bytes]); end



%Sort and put into struct
[AllBytes,indx]=sort(AllBytes,'descend');
AllFolders=AllFolders(indx);
S.folders=AllFolders;
S.bytes=AllBytes;

%%


