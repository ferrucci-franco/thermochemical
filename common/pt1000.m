function T = pt1000(R)
% From https://www.openhacks.com/uploadsproductos/pt1000-temp-probe.pdf
T = -(sqrt(-0.00232 * R + 17.59246) - 3.908)/0.00116;