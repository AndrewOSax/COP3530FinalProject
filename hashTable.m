classdef hashTable < handle
    properties
        theTable
    end
    methods
        function this = hashTable(tableSize)
            this.theTable = cell(tableSize,2);
        end
        function val = hash(this,key)
            val = 0;
            for ii = 1:3
                if ~isnan(str2double(key(ii)))
                    val = val + str2double(key(ii))*36^(3-ii);
                else
                    val = val + (key(ii)-55)*36^(3-ii);
                end
            end
        end
        function this = insert(this,key,value)
            hashedKey = this.hash(char(key));
            if isempty(this.theTable{hashedKey,1})
                this.theTable(hashedKey,1) = {key};
                this.theTable(hashedKey,2) = {value};
            else
                destinations = this.theTable{hashedKey,2};
                added = false;
                for ii = 1:size(destinations,1)
                    if destinations{ii,1} == value{1}
                        this.theTable{hashedKey,2}(ii,2) = {[this.theTable{hashedKey,2}{ii,2};value{2}]};
                        added = true;
                    end
                end
                if ~added
                    this.theTable(hashedKey,2) = {[this.theTable{hashedKey,2};value]};
                end
            end
        end
        function entry = get(this,key)
            hashedKey = this.hash(char(key));
            entry = this.theTable{hashedKey,2};
        end
    end
end