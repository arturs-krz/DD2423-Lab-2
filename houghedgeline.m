function [linepar acc] = houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose, acc_dt, acc_k, weighted)
curves = extractedge(pic, scale, gradmagnthreshold, 'same');
L = discgaussfft(pic, scale);
gradmagn = sqrt(Lv(L, 'same'));

if verbose > 2
   figure;
   overlaycurves_fat(gradmagn, curves)
   title("Edges on gradient magnitude")
end

if nargin < 8
   acc_dt = 0.3;
end
if nargin < 9
   acc_k = 10; 
end
if nargin < 10
   weighted = false; 
end

[linepar, acc] = houghline(curves, gradmagn, nrho, ntheta, gradmagnthreshold, nlines, verbose, acc_dt, acc_k, weighted);
if verbose > 0
   figure;
   linecurves = getlinecurves(linepar, 500);
   
   [sx, sy] = size(pic);
   overlaycurves_fat(pic, linecurves); 
   axis([0 sx 0 sy])
   title("Hough lines on original")
end
if verbose > 1
   figure;
   overlaycurves_fat(gradmagn, linecurves); 
   axis([0 sx 0 sy])
   title("Hough lines on gradient magnitude")
   
   figure;
   showgrey(acc)
   title("Hough domain")
end
