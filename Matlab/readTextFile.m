function [qrs_pos,int_dat] = readTextFile(loadstr, fs)

fid = fopen(loadstr);
 
readin = textscan(fid, '%f', 'delimiter', '\n');
fclose(fid);
testdata = readin{1,1};
clear('readin');
testdata = testdata';


close all;

[qrs_pos,filt_dat,int_dat,thF1,thI1] = pantompkins_qrs(testdata,fs);
end