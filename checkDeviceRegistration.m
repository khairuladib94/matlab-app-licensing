function IsDeviceRegistered = checkDeviceRegistration(AppObj, AppUIFigure, AppName, UserName, RepoName, Token)
arguments
    AppObj
    AppUIFigure     matlab.ui.Figure
    AppName
    UserName
    RepoName
    Token
end
%   Check whether the device has been registered and is associated to a valid license
DeviceID = generateDeviceId;
try Lic = delimited2table(githubGet(UserName, RepoName, 'license-database.csv', Token = Token));

catch ME

end
MatchedDeviceIdx = find(Lic.DeviceID == DeviceID); %#ok<EFIND>
if isempty(MatchedDeviceIdx)
    Selection = uiconfirm(AppUIFigure, 'App is not activated.', AppName, Options = {'Activate', 'Close'});
    switch Selection
        case 'Activate'
            appactivation(AppUIFigure, AppName, UserName, RepoName, Token);
        case 'Close'
            delete(AppObj);
    end
end
end