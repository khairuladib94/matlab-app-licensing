function IsCloseSelected = checkDeviceRegistration(MainApp, UserName, RepoName, Token)
arguments
    MainApp
    UserName
    RepoName
    Token
end
centerAppWindow(MainApp);
IsCloseSelected = false;
DeviceID = generateDeviceId;
MainAppUIFigure = findUIFigure(MainApp);
AppName = MainAppUIFigure.Name;
try Lic = delimited2table(githubGet(UserName, RepoName, 'license-database.csv', Token = Token));
    MatchedDeviceIdx = find(Lic.DeviceID == DeviceID);
    if ~isempty(MatchedDeviceIdx) && any(datetime(Lic.ValidUntil(MatchedDeviceIdx)) > datetime)
        return;     % License is registered and still valid
    end

    if isempty(MatchedDeviceIdx)    % License is not registered
        Selection = uiconfirm(MainAppUIFigure, 'App is not activated.', AppName, ...
            Options = {'Activate', 'Close'});
    elseif ~isempty(MatchedDeviceIdx) && ~any(datetime(Lic.ValidUntil(MatchedDeviceIdx)) > datetime)     % License is registered but not valid
            Selection = uiconfirm(MainAppUIFigure, 'The license has expired. Please activate a new license.', AppName, Options = {'Activate', 'Close'});
    end
   
    switch Selection
        case 'Activate'
            appactivation(MainApp, UserName, RepoName, Token);
        case 'Close'
            IsCloseSelected = true;
    end
catch Exception    % Catch Internet connection error
    if contains(Exception.identifier, 'connection', IgnoreCase = true)
        Selection = uiconfirm(MainAppUIFigure, 'Error connecting to the Internet.', AppName, ...
            Options = {'Try Again', 'Close'});
        switch Selection
            case 'Try Again'
                checkDeviceRegistration(MainApp, UserName, RepoName, Token);
            case 'Close'
                IsCloseSelected = true;
        end
    end
end
end