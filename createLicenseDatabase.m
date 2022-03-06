function Response = createLicenseDatabase(UserName, RepoName, Token)
% Create a *.csv file to store all license keys and associated details
DatabaseHeader = {'LicenseKey', 'UserEmail', 'ValidUntil' ,'DeviceID'};
FileName = 'license-database.csv';
writecell(DatabaseHeader, FileName);
try
    Response = githubPost(UserName, RepoName, FileName, FileName, ...
        Token, CommitMessage = 'Create license database file');
    delete(FileName);
    disp('File successfully created and uploaded to the repo at %s', Response.commit.url);
catch ME
    delete(FileName);
    error('Failed uploading the file. File with the same name possibly already exists in the repo.\n\n%s',  ME.message);
end
end

