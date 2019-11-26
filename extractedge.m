function edgecurves = extractedge(inpic, scale, threshold, shape)

if (nargin < 4)
    shape = 'same';
end
if (nargin < 3)
	threshold = 0;
end

L = discgaussfft(inpic, scale);
gradmagn = sqrt(Lv(L, shape));
Lvv = Lvvtilde(L, shape);
Lvvv = Lvvvtilde(L, shape);

thresholded = (gradmagn - threshold) > 0;

edgecurves = zerocrosscurves(Lvv, (Lvvv < 0) - 1); % non negative preserved
edgecurves = thresholdcurves(edgecurves, thresholded - 1);
