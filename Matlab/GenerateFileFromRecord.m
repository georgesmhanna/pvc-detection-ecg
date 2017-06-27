function [] = GenerateFileFromRecord(recordNumber)

recs = 106;
% for ind = 1:length(recs)
% rec = recs(ind);
[qrs_pos,filt_dat,int_data,testdata, ANNOTD, TIME, ATRTIMED] = Process(num2str(recordNumber));

filename = strcat('A',num2str(recordNumber),'.txt');
save(filename, testdata,'-ASCII');
end

clear all;
recs = [100, 101, 103, 105:109, 111:113, 115:119, 121:124, 200:203, 205, 207:210, 212:215, 217, 219:223, 228, 230, 231, 234];% 111:119, 121:124, 200, 201, 202, 203];

for ind = 1:length(recs)
    [qrs_pos,filt_dat,int_data,testdata, ANNOTD, TIME, ATRTIMED] = Process(num2str(recs(ind)));
    filename = strcat('A',num2str(recs(ind)),'.txt');
    save(filename, 'testdata','-ASCII');
end