function centerAppWindow(App)
% Position the app window to the center of the screen
App = findUIFigure(App);
OriginalUnit = App.Units;
App.Units = 'normalized';
App.Position(1:2) = 0.5 - App.Position(3:4) ./ 2;
App.Units = OriginalUnit;
end

