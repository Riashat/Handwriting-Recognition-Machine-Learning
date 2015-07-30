% IN THIS SCRIPT, WE PRINT OUT THE 5 MOST DIFFICULT TO RECOGNIZE SCANNED
% DIGITS.

% FROM OUR KERNEL PERCEPTRON, FOR THE OPTIMUL VALUE OF THE DEGREE OF THE
% POLYNOMIA KERNEL, WE CONSTRUCTED A MATRIX THAT SHOWS THE NUMBER OF TIMES
% THESE TRAINING POINTS HAVE BEEN MOST MISCLASSIFIED.

% BASED ON THAT,WE GET THE FOLLOWING PLOTS

test = load('ziptest.dat');
figure(1);

fprintf('Printing scanned digit for value= %i\n\n', test(18,1))
subplot(2,3,1)
imagesc(reshape(test(18,2:end), 16, 16)'); colormap 'gray';
title('Scanned digit = 6')


subplot(2,3,2)
fprintf('Printing scanned digit for value= %i\n\n', test(28,1))
imagesc(reshape(test(28,2:end), 16, 16)'); colormap 'gray';
title('Scanned digit = 3')


subplot(2,3,3)
fprintf('Printing scanned digit for value= %i\n\n', test(63,1))
imagesc(reshape(test(54,2:end), 16, 16)'); colormap 'gray';
title('Scanned digit = 2')


subplot(2,3,4)
fprintf('Printing scanned digit for value= %i\n\n', test(123,1))
imagesc(reshape(test(123,2:end), 16, 16)'); colormap 'gray';
title('Scanned digit = 3')


subplot(2,3,5)
fprintf('Printing scanned digit for value= %i\n\n', test(132,1))
imagesc(reshape(test(131,2:end), 16, 16)'); colormap 'gray';
title('Scanned digit = 8')
