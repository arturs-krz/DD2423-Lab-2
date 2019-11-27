function [linepar acc] = houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose)
% Check if input appear to be valid
% Allocate accumulator space

%delta_theta = pi / ntheta; % quantization for theta
%delta_ro = 1; % quantization for rho

acc = zeros(nrho, ntheta);

% Define a coordinate system in the accumulator space
thetas = linspace(-pi/2, pi/2, ntheta); % ntheta points
cos_thetas = cos(thetas); % precompute
sin_thetas = sin(thetas);

[sx, sy] = size(magnitude);
img_diameter = sqrt(sx^2 + sy^2);
rhos = linspace(-img_diameter, img_diameter, nrho);

% Loop over all the input curves (cf. pixelplotcurves)
insize = size(curves, 2); % num columns
trypointer = 1;
numcurves = 0;

% C = [level1 x1 x2 x3 ... level2 x2 x2 x3 ...;
%      pairs1 y1 y2 y3 ... pairs2 y2 y2 y3 ...] swap x and y rows
while trypointer <= insize
    polylength = curves(2, trypointer); % num pairs in level
    numcurves = numcurves + 1;
    trypointer = trypointer + 1;
    for polyidx = 1:polylength
        x = curves(2, trypointer);
        y = curves(1, trypointer);   
        trypointer = trypointer + 1;
        
        % For each point on each curve (x,y)
        % Check if valid point with respect to threshold
        
        % Optionally, keep value from magnitude image
        % Loop over a set of theta values

        if magnitude(floor(x),floor(y)) > threshold
            for theta_i = 1:size(thetas, 2) 
                cos_theta = cos_thetas(theta_i);
                sin_theta = sin_thetas(theta_i);
                % Compute rho for each theta value
                rho = x*cos_theta + y*sin_theta;
                % Compute index values in the accumulator space
                [dif, rho_i] = min(abs(rhos - rho)); % find closest rho index
                % Update the accumulator
                acc(rho_i, theta_i) = acc(rho_i, theta_i) + 1;
            end
        end
    end
end

% accumulation done
% smooth accumulator histogram
acc = binsepsmoothiter(acc, 0.3, 10);

% Extract local maxima from the accumulator
[pos, value] = locmax8(acc);
[sorted, order] = sort(value);

nmaxima = size(value, 1); % number of retrieved maximum points

% if failed to retrieve the requested number of lines, return all maxima
if nmaxima < nlines
   nlines = nmaxima;
end

linepar = zeros(nlines, 2);
% Delimit the number of responses if necessary
% extract nlines top lines
for i = 1:nlines
    rho_idx = pos(order(nmaxima - i + 1), 1);
    theta_idx = pos(order(nmaxima - i + 1), 2);
    
    rho = rhos(1, rho_idx);
    theta = thetas(1, theta_idx);
    
    linepar(i, 1) = rho;
    linepar(i, 2) = theta;
end



% Compute a line for each one of the strongest responses in the accumulator
% Overlay these curves on the gradient magnitude image
% Return the output data
