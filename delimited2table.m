function Table = delimited2table(String)
% Convert delimeted text (or comma-seperated value) into table
String = deblank(splitlines(String));
String(String == "") = [];
String = split(String, ",");
Header = String(1, :);
String(1,:) = [];
Table = splitvars(table(String));
Table = varfun(@(x) deblank(string(x)), Table);
Table.Properties.VariableNames = Header;
end