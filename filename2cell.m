%   %REVISION HISTORY:
%   1 Sep 2015: Hyunglok Kim; Initial Specification ;Matlab version 2015a >
%    hyunglokkim@gmail.com

function y=filename2cell(folderpath, filespec)

% folderpath='F:\NDVI\WA\';
% filespec='.hdf';

path=[folderpath,'&dir/b *',filespec,'>','list.txt'];
path1='&cd';
path2=path(3:end);
path(3:5)=path1;
path(6:end+3)=path2;
system(path);

filename=[folderpath,'list.txt']; delimiter = ''; formatSpec = '%s%[^\n\r]';
fileID = fopen(filename,'r'); dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
y= [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans path path1 path2 folderpath filespec;