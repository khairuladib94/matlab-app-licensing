function Response = githubPut(UserName, RepoName, OriginalFilePath, UpdatedFilePath, Token, Optn)
% Update the contents of an existing file on a GitHub repo, even a private one.
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
    OriginalFilePath (1,:) char
    UpdatedFilePath (1,:) char
    Token (1,:) char
    Optn.Branch (1,:) char = ''
    Optn.CommitMessage (1,:) char = 'Unknown commit.'
end
if isempty(Optn.Branch)
    [~, GetRequest] = githubGet(UserName, RepoName, OriginalFilePath, Token = Token);
else
    [~, GetRequest] = githubGet(UserName, RepoName, OriginalFilePath, Branch = Optn.Branch, Token = Token);
    Body.branch = Optn.Branch;
end
try
    Content = fileread(UpdatedFilePath);
catch ME
    error(ME.message);
end
EncodedContent = matlab.net.base64encode(Content);
HeaderFields = {'Authorization', ['token ', Token];...
    'Accept', 'application/vnd.github.v3+json'};
Body.message = Optn.CommitMessage;
Body.sha = GetRequest.sha;
Body.content = EncodedContent;
Options = weboptions(HeaderFields = HeaderFields, RequestMethod = 'put');
Response = webwrite(GetRequest.url, Body, Options);
end

