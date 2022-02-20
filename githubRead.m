function Content = githubRead(UserName, RepoName, FilePath, Optn)
% Read contents in a file from a GitHub repo, even a private one. 
% Uses MATLAB built-in functions called webread that relies on RESTful API.
% 
% Required arguments
%     UserName (1,:) char : GitHub's username
%     RepoName (1,:) char : The repo name
%     FilePath (1,:) char : The file name or its relative path if it resides in a folder
% 
% Optional arguments    
%     Token (1,:) char    : Personal Access Token (PAT), generate from https://github.com/settings/tokens. Required for a private repo. 
% 
% Written by Adib Yusof (2022) | adib.yusof@upm.edu.my
arguments
    UserName (1,:) char
    RepoName (1,:) char
    FilePath (1,:) char
    Optn.Token (1,:) char = ''
end
BaseAPI = 'https://api.github.com';
URL = [BaseAPI, '/repos/', UserName, '/', RepoName, '/contents/', FilePath];
HeaderFields = {};
if ~isempty(Optn.Token)
    HeaderFields = {'Authorization', ['token ', Optn.Token]};
end
HeaderFields = [HeaderFields; {'Accept', 'application/vnd.github.v3+json'}];
Options = weboptions(HeaderFields = HeaderFields, ContentType = 'json' );
Data = webread(URL, Options);
HeaderFields = {'Accept', 'application/vnd.github.v3+json'};
Options = weboptions('HeaderFields', HeaderFields);
Content = webread(Data.download_url, Options);
end

