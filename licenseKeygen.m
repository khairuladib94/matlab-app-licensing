function GeneratedKey = licenseKeygen(CharNum, Optn)
% Generates a random key of numbers or letters or both.
arguments
    CharNum (1,:) double = 16
    Optn.UseNumber (1,1) logical = true
    Optn.UseLetter (1,1) logical = true
end
Mixture = Optn.UseNumber + Optn.UseLetter;
assert(Mixture > 0, "UseNumber and UseLetter cannot both be false.")
Letters = []; 
Numbers = [];
if Optn.UseLetter
    Letters = char(randi([65, 90], [1, ceil(CharNum/Mixture)]));
end
if Optn.UseNumber
    Numbers = strrep(num2str(randi([0, 9], [1, floor(CharNum/Mixture)])), ' ', '');
end
RandIdx = randperm(CharNum);
Key = [Letters, Numbers];
GeneratedKey = Key(RandIdx);

