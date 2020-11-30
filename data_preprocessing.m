[~,~,airportCoords] = xlsread('111745943_T_MASTER_CORD.csv');
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
        airportCodes.insert(string(dataVals(3)),string(dataVals(1)));
        airportCodes.insert(string(dataVals(4)),string(dataVals(2)));
        textLine = fgetl(fid);
        count = count + 1;
    end
end
save('processedData.mat','theMap','airportCodes','airportCoords','states')