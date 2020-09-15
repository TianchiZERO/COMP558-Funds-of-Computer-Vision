N1 = 51;
N2 = 31;
sigma1 = 5;
sigma2 = 3;
M1 = (N1-1)/2;
M2 = (N2-1)/2;
[X1,Y1] = ndgrid(-M1:M1,-M1:M1);
[X2,Y2] = ndgrid(-M2:M2,-M2:M2);
gaussian1 = make2DGaussian(N1,sigma1);
gaussian2 = make2DGaussian(N2,sigma2);
%LOG1 = make2DLOG(N1,sigma1);
%LOG2 = make2DLOG(N2,sigma2);

%figure(1);	
%subplot(1,2,1);
%surf(X1,Y1,gaussian1);
%title({['N1=',num2str(N1)],['sigma1=',num2str(sigma1)]});
%subplot(1,2,2);
%surf(X2,Y2,gaussian2);
%title({['N2=',num2str(N2)],['sigma2=',num2str(sigma2)]});
%colorbar


%figure;
%h = fspecial('log',N1,sigma1);
%surf(X1,Y1,h);


% For Gabor Filter
lambda1 = 2;
lambda2 = 4;
lambda3 = 6;
angle1 = 0;
angle2 = 45;
angle3 = 90;
[GaborEven1,GaborOdd1] = make2DGabor(N1,lambda2,angle1);
[GaborEven2,GaborOdd2] = make2DGabor(N1,lambda2,angle2);
[GaborEven3,GaborOdd3] = make2DGabor(N1,lambda2,angle3);
subplot(2,3,1);
surf(X1,Y1,GaborEven1);
title({['lambda2=',num2str(lambda2)],['angle1=',num2str(angle1)],['Even Gabor Filter']});
subplot(2,3,2);
surf(X1,Y1,GaborEven2);
title({['lambda2=',num2str(lambda2)],['angle2=',num2str(angle2)],['Even Gabor Filter']});
subplot(2,3,3);
surf(X1,Y1,GaborEven3);
title({['lambda2=',num2str(lambda2)],['angle3=',num2str(angle3)],['Even Gabor Filter']});
subplot(2,3,4);
surf(X1,Y1,GaborOdd1);
title({['lambda2=',num2str(lambda2)],['angle1=',num2str(angle1)],['Odd Gabor Filter']});
subplot(2,3,5);
surf(X1,Y1,GaborOdd2);
title({['lambda2=',num2str(lambda2)],['angle2=',num2str(angle2)],['Odd Gabor Filter']});
subplot(2,3,6);
surf(X1,Y1,GaborOdd3);
title({['lambda2=',num2str(lambda2)],['angle3=',num2str(angle3)],['Odd Gabor Filter']});




