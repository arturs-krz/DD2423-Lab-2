function curves = getlinecurves(linepar, deltalength)
if (nargin < 2)
	deltalength = 50;
end
curves = zeros(2, size(linepar,1)*4);

for i = 1:size(linepar,1)
    rho = linepar(i, 1);
    theta = linepar(i, 2);
    x0 = rho * cos(theta);
    y0 = rho * sin(theta);
    dx = deltalength * cos(theta + (pi / 2));
    dy = deltalength * sin(theta + (pi / 2));
    
    curves(1, 4*(i-1) + 1) = 0; % level
    curves(2, 4*(i-1) + 1) = 3; % num points
    
    curves(2, 4*(i-1) + 2) = x0 - dx; % x
    curves(1, 4*(i-1) + 2) = y0 - dy; % y
    
    curves(2, 4*(i-1) + 3) = x0; % x
    curves(1, 4*(i-1) + 3) = y0; % y
    
    curves(2, 4*(i-1) + 4) = x0 + dx; % x
    curves(1, 4*(i-1) + 4) = y0 + dy; % y
end