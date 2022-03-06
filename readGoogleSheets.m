function Table = readGoogleSheets(FileID, SheetName)
% Read contents from Google Sheets, but its access must be set to "Anyone with link can view"
arguments
    FileID      (1,:) char
    SheetName   (1,:) char = 'Sheet1'
end
AccessURL = sprintf('https://docs.google.com/spreadsheets/d/%s/gviz/tq?tqx=out:csv&sheet=%s',...
    FileID, SheetName);
Table = webread(AccessURL);
end