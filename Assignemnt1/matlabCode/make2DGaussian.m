function g = make2DGaussian(N, sigma)
g = zeros(N,N);
M = (N-1)/2;
x = -M:M;
y = -M:M;
for i = 1:N
    for j = 1:N
        g(i,j) = exp((x(i)^2+y(j)^2)/(-2*sigma^2))/(2*pi*sigma^2);
    end
end
end