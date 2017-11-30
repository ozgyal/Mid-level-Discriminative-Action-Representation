function [ data_apriori ] = prepareData( transactions )
%Prepares transactions data for Apriori algorithm

data_temp = cell(size(transactions, 1), 1);
for i=1:size(transactions, 1)
    data_temp{i, 1} = transactions(i, :);
end

item_no = max(max(transactions));
data_apriori = zeros(length(transactions), item_no);
for i=1:length(transactions)
    data_apriori(i, data_temp{i, 1}) = 1;
end


end

