function Response = githubPost(UserName, RepoName, FileRelativePath, LocalFilePath, Token, Optn)
% Upload a new file to a GitHub repo, even a private one.
% Uses MATLAB built-in functions called webread and webwrite that rely on REST API.
%
% Required arguments
%     UserName (1,:) char           : GitHub's username
%     RepoName (1,:) char           : The repo name
%     OriginalFilePath (1,:) char   : The file name (or its relative path) on the GitHub repo
%     UpdatedFilePath (1,:) char    : The local file name (or its relative path) of which the content is to replace the original one on GitHub
%     Token (1,:) char              : Personal Access Token (PAT), generate from https://github.com/settings/tokens. Required for a private repo
%
% Optional arguments (name-value pair)   
%     Branch (1,:) char             : If left blank, the default branch will be used (main or master)
%     CommitMessage (1,:)           : Commit message
%
% Written by Adib Yusof (2022) | adib.yusof@upm.edu.my
arguments
    UserName (1,:) char
    RepoName (1,:) char
    FileRelativePath (1,:) char
    LocalFilePath (1,:) char
    Token (1,:) char
    Optn.Branch (1,:) char = ''
    Optn.CommitMessage (1,:) char = ''
end
BaseAPI = 'https://api.github.com';
URL = [BaseAPI, '/repos/', UserName, '/', RepoName, '/contents/', FileRelativePath];
try
    Content = fileread(LocalFilePath);
catch ME
    error(ME.message);
end
EncodedContent = matlab.net.base64encode(Content);
HeaderFields = {'Authorization', ['token ', Token];...
    'Accept', 'application/vnd.github.v3+json'};
if ~isempty(Optn.Branch)   
    Body.branch = Optn.Branch;
end
Body.content = EncodedContent;
Options = weboptions(HeaderFields = HeaderFields, RequestMethod = 'put');
if isempty(Optn.CommitMessage)
    Body.message = ['Commited from ', Options.UserAgent];
else
    Body.message = Optn.CommitMessage;
end
Response = webwrite(URL, Body, Options);
end

