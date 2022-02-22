function [Output, GetRequest] = githubGet(UserName, RepoName, FilePath, OutputType, Optn)
% Reads or downloads a file from a GitHub repo, even a private one. 
% Uses MATLAB built-in functions called webread and websave that rely on REST API.
% 
% Required arguments
%     UserName (1,:) char   : GitHub's username
%     RepoName (1,:) char   : The repo name
%     FilePath (1,:) char   : The file name or its relative path if it resides in a folder
%     OutputType (1,:) char : 'read' (default) or 'save'; 'read' returns contents of the file, 'save' downloads the file.
% 
% Optional arguments (name-value pair)   
%     Token (1,:) char      : Personal Access Token (PAT), generate from https://github.com/settings/tokens. Required for a private repo. 
%     Branch (1,:) char     : Branch name (default = 'main')
% Written by Adib Yusof (2022) | adib.yusof@upm.edu.my
arguments
    UserName (1,:) char
    RepoName (1,:) char
    FilePath (1,:) char
    OutputType (1,:) char {mustBeMember(OutputType, {'save', 'read'})} = 'read'
    Optn.Token (1,:) char = ''
    Optn.Branch (1,:) char = ''
end
BaseAPI = 'https://api.github.com';
URL = [BaseAPI, '/repos/', UserName, '/', RepoName, '/contents/', FilePath];
if ~isempty(Optn.Branch)
    URL = [URL, '?ref=', Optn.Branch];
end
HeaderFields = {};
if ~isempty(Optn.Token)
    HeaderFields = {'Authorization', ['token ', Optn.Token]};
end
HeaderFields = [HeaderFields; {'Accept', 'application/vnd.github.v3+json'}];
Options = weboptions(HeaderFields = HeaderFields);
GetRequest = webread(URL, Options);
switch OutputType
    case 'read'
        Output = char(matlab.net.base64decode(GetRequest.content));
    case 'save'
        Output = websave(FilePath, GetRequest.download_url, Options);
end
end

