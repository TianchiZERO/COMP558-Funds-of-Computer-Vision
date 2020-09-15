function [even, odd] = make2DGabor(N, lambda, angle)
even = zeros(N,N);
odd = zeros(N,N);
M = (N-1)/2;
x = -M:M;
y = -M:M;
sigma = lambda;
for i = 1:N
    for j = 1:N
        even(i,j) = (1/(2*pi*sigma^2))*exp((x(i)^2+y(j)^2)/(-2*sigma^2))*cos(2*pi/lambda*(x(i)*cosd(angle)+y(j)*sind(angle)));
        odd(i,j) = (1/(2*pi*sigma^2))*exp((x(i)^2+y(j)^2)/(-2*sigma^2))*sin(2*pi/lambda*(x(i)*cosd(angle)+y(j)*sind(angle)));
    end
end
end