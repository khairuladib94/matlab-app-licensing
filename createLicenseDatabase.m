function Response = createLicenseDatabase(inputArg2)
% Create a *.csv file to store all license keys and associated details
DatabaseHeader = {'LicenseKey', 'UserEmail', 'ValidUntil' ,'DeviceID'};
writecell(DatabaseHeader, 'license-database.csv');
Response = githubPost(UserName, RepoName, FileRelativePath, LocalFilePath, Token, CommitMessage = 'Create license database file.');

end

