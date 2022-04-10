function [Status, Details] = createLicenseDatabase(UserName, RepoName, Token)
% Create a *.csv file to store all license keys and associated details
DatabaseHeader = {'LicenseKey', 'UserEmail', 'ValidUntil' ,'DeviceID'; '', '', '', ''};
AppName = 'MATLAB App License Manager';
FileName = 'license-database.csv';
FolderPath = fullfile(userpath, AppName);
mkdir(FolderPath);
FilePath = fullfile(FolderPath, FileName);
writecell(DatabaseHeader, FilePath);
try
    Details = githubPost(UserName, RepoName, FileName, FilePath, ...
        Token, CommitMessage = 'Create license database file');
    Status = true;
catch
    Status = false;
    Details = 'Error uploading file';
end
delete(FilePath);
end

