function [linepar acc] = houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose)
% Check if input appear to be valid
% Allocate accumulator space
% Define a coordinate system in the accumulator space
% Loop over all the input curves (cf. pixelplotcurves)
% For each point on each curve
% Check if valid point with respect to threshold
% Optionally, keep value from magnitude image
% Loop over a set of theta values
% Compute rho for each theta value
% Compute index values in the accumulator space
% Update the accumulator
% Extract local maxima from the accumulator
% Delimit the number of responses if necessary
% Compute a line for each one of the strongest responses in the accumulator
% Overlay these curves on the gradient magnitude image
% Return the output data
