function GeneratedKey = licenseKeygen(CharNum, Optn)
% Generates a random key of numbers or letters or both.
arguments
    CharNum         (1,:) {mustBeInteger, mustBePositive} = 16
    Optn.UseNumber  (1,1) logical = true
    Optn.UseLetter  (1,1) logical = true
    Optn.PartLength (1,1) {mustBeInteger, mustBeNonnegative} = 4;
end
Mixture = Optn.UseNumber + Optn.UseLetter;
assert(Mixture > 0, "UseNumber and UseLetter cannot both be false.");
if Optn.PartLength > 0
    assert(rem(CharNum, Optn.PartLength) == 0, "CharNum must be a multiple of PartLength, or set PartLength to 0.")
end
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
if Optn.PartLength == 0
    return;
end
GeneratedKey = reshape(GeneratedKey, Optn.PartLength, []);
GeneratedKey = [GeneratedKey; repmat('-', [1, width(GeneratedKey)])];
GeneratedKey = reshape(GeneratedKey, 1, []);
GeneratedKey(end) = [];