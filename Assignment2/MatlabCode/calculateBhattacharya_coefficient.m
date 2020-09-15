function Bhattacharya_coefficient = calculateBhattacharya_coefficient(Vector1, Vector2)
sumVector1 = 0;
sumVector2 = 0;
for i = 1:length(Vector1)
    sumVector1 = sumVector1 + Vector1(i);
end
for i = 1:length(Vector2)
    sumVector2 = sumVector2 + Vector2(i);
end
NormalVector1 = Vector1;
NormalVector2 = Vector2;
for i = 1:length(Vector1)
    NormalVector1(i) = Vector1(i)/sumVector1;
end

for i = 1:length(Vector2)
    NormalVector2(i) = Vector2(i)/sumVector2;
end

a = 0;

for i = 1:length(Vector1)
    a = a + sqrt(NormalVector1(i)*NormalVector2(i));
    
end

Bhattacharya_coefficient = sqrt(1-a);
end