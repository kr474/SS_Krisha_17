clc;
clear;
close all;
s1 = [0,0,0,0,0,1,1,1,1,1,0,0,0,0,0];
s2 = [0,0,0,0,0,1,1,1,1,1,0,0,0,0,0];
y = conv(s1,s2);
subplot(3,1,1);
stem(s1);
title("rectangular signal 1");
subplot(3,1,2);
stem(s2);
title("rectangular signal 2");
subplot(3,1,3);
stem(y);
title("result of convolution");

% CODE WITH USER DEFINED FUNCTION:

clc;
clear;
close all;
s1 = [0,0,0,0,0,1,1,1,1,1,0,0,0,0,0];
s2 = [0,0,0,0,0,1,1,1,1,1,0,0,0,0,0];
y = conv(s1, s2);
subplot(3,1,1);
stem(s1);
title("rectangular signal 1");
subplot(3,1,2);
stem(s2);
title("rectangular signal 2");
subplot(3,1,3);
stem(y);
title("result of convolution");