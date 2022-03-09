function AppUIFigure = findUIFigure(App)
% Find matlab.ui.Figure object from the properties of an App object
 AppProperties = properties(App);
for p = 1 : numel(AppProperties)
    Property = App.(AppProperties{p});
    IsUIFigure = isa(Property, 'matlab.ui.Figure');
    if IsUIFigure
        AppUIFigure = Property;
        break;
    end
end
end

