% Extract k largest magnitudes (dimensions) of each patch feature. Then,
% create transactions for each category. Find mid-level visual elements.

clear
clc

addpath('lib')

% load your features for images
load('features.mat')

num_classes = 10;

train_data = cell(1, 1);
test_data = cell(1, 1);
% split train and test sets
for i=1:num_classes
	class = features{i, 1};
	train_indices = randperm(length(class), 100);
	train_data{i, 1} = class(train_indices);
	test_data{i, 1} = class(setdiff((1:length(class)), train_indices));
end

k = 20;
min_support = 0.3;
min_confidence = 0.7;
nRules = 500;

% for each category, find association rules an then determine discriminative
% and representative patches
rep_train_data = cell(1,1);
for i=1:length(train_data)
	class = train_data{i, 1};
		
	% get transactions
	[transactions, patch_names] = getTransactions(class, k, train_data, i);
	
	% prepare data for Apriori
	data_apriori = prepareData(transactions);
	
	% get rules with Apriori
	[rules, freqItemsets] = getRulesApriori(data_apriori, min_support, min_confidence, nRules);
	
	% find discriminative rules which have positive category item: 1025
	items = [];
	a = rules{1,1};
	b = rules{2,1};
	for j=1:length(a)
		item_set = [a{j,1} b{j,1}];
		if ~isempty(find(item_set == 1025))
			items = [items item_set];
		end
	end
	items = unique(items);
	
	% find repesentative and discriminative patches of images according to
	% determined rule with inverted index
	rep_patches = cell(400,1);
	cnt = 1;
	for j=1:length(transactions)
		inter = intersect(transactions(j,:), items);
		try
			if inter == items
				cnt = cnt + 1;
				patch =  patch_names{j, 1};
				name = patch.name;
				tokens = strsplit(name, '_');
				im_no = str2num(tokens{end-1});
				patches = rep_patches{im_no, 1};
				if isempty(patches)
					rep_patches{im_no, 1}{1, 1} = patch;
				else
					patch_no = length(patches);
					rep_patches{im_no, 1}{patch_no+1, 1} = patch;
				end
			end
		catch
			
		end
	end
		
	rep_patches = rep_patches(~cellfun('isempty',rep_patches));
	disp(['Total selected visual element number = ' num2str(cnt)])
	% add mid-level visual elements of related category to training data
	% cell array
	rep_train_data{i, 1} = rep_patches;
end
