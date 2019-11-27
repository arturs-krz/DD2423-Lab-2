function [linepar acc] = houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose)
curves = extractedge(pic, scale, gradmagnthreshold, 'same');
L = discgaussfft(pic, scale);
gradmagn = sqrt(Lv(L, 'same'));

if verbose > 2
   figure;
   overlaycurves_fat(gradmagn, curves) 
end

[linepar, acc] = houghline(curves, gradmagn, nrho, ntheta, gradmagnthreshold, nlines, verbose);
if verbose > 0
   figure;
   linecurves = getlinecurves(linepar, 500);
   
   [sx, sy] = size(pic);
   overlaycurves_fat(pic, linecurves); 
   axis([0 sx 0 sy])
end
if verbose > 1
   figure;
   overlaycurves_fat(gradmagn, linecurves); 
   axis([0 sx 0 sy])
   
   figure;
   showgrey(acc);
end
