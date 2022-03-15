function [FolderDir, Status] = makeAppFolder(FolderName)
%   Create a folder to store necessary files for the app
if isempty(char(FolderName))
    FolderName = 'matlabapptmp';
end
FolderName = matlab.lang.makeValidName(FolderName);
FolderDir = fullfile(userpath, FolderName);
Status = mkdir(FolderDir);
end