classdef codeTable < handle
    properties
        airportNameTable
        airportCodeTable
    end
    methods
        function this = codeTable(tableSize)
            this.airportNameTable = strings(tableSize,2);
            this.airportCodeTable = strings(tableSize,2);
        end
        function val = hashAirport(this,key)
            val = 0;
            for ii = 1:length(key)
                val = val+key(ii);
            end
            val = mod(val,size(this.airportNameTable,1))+1;
            while this.airportNameTable(val,1) ~= "" && this.airportNameTable(val,1) ~= key
                val = val + 1;
                if val > size(this.airportNameTable,1)
                    val = 1;
                end
            end
        end
        function val = hashCode(this,key)
            val = 0;
            for ii = 1:3
                if ~isnan(str2double(key(ii)))
                    val = val + str2double(key(ii))*36^(3-ii);
                else
                    val = val + (key(ii)-55)*36^(3-ii);
                end
            end
        end
        function this = insert(this,airport,code)
            hashedAirport = this.hashAirport(char(airport));
            if this.airportNameTable(hashedAirport,1) == ""
                this.airportNameTable(hashedAirport,1) = airport;
                this.airportNameTable(hashedAirport,2) = code;
            end
            hashedCode = this.hashCode(char(code));
            if this.airportCodeTable(hashedCode,1) == ""
                this.airportCodeTable(hashedCode,1) = code;
                this.airportCodeTable(hashedCode,2) = airport;
            end
        end
        function entry = getCode(this,airport)
            hashedAirport = this.hashAirport(char(airport));
            entry = this.airportNameTable(hashedAirport,2);
        end
        function entry = getAirport(this,code)
            hashedCode = this.hashCode(char(code));
            entry = this.airportCodeTable(hashedCode,2);
        end
    end
end