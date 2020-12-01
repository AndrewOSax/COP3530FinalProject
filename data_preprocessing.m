[~,~,airportCoords] = xlsread('111745943_T_MASTER_CORD.csv');
codes = string(airportCoords(2:end,1));
lats = str2double(string(airportCoords(2:end,8)));
longs = str2double(string(airportCoords(2:end,9)));
[~,states] = xlsread('states.xlsx');
theMap = hashTable(36*36*36);
airportCodes = codeTable(36*36*36);
count = 0;
for ii = 1:5
    fid = fopen(sprintf('flight_edges%i.tsv',ii), 'rt');
    textLine = fgetl(fid);
    count = count + 1;
    while ischar(textLine)
        dataVals = split(textLine,'	');
        mapValue = {string(dataVals(2)) str2double(dataVals(5:11))'};
        theMap.insert(string(dataVals(1)),mapValue);
        airportCodes.insert(string(dataVals(1)),string(dataVals(3)),mean(lats(codes == string(dataVals(1)))),mean(longs(codes == string(dataVals(1)))));
        airportCodes.insert(string(dataVals(2)),string(dataVals(4)),mean(lats(codes == string(dataVals(2)))),mean(longs(codes == string(dataVals(2)))));
        textLine = fgetl(fid);
        count = count + 1;
    end
end
save('processedData.mat','theMap','airportCodes','states')