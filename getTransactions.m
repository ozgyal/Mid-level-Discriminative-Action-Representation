function [ transactions, patch_names, im_names] = getTransactions( class, k, train_data, i )
%Creates transactions for given category and returns related image patch
%names as well.

transactions = [];
patch_names = cell(1,1);
im_names = cell(1,1);
patch_no = 1;

% Create transactions for positive data (add pos item as 1025)
for j=1:length(class)
	im_patches = class{j, 1};
	
	for m=1:length(im_patches)
		patch = im_patches{m, 1};
		feature = patch.feature;
		[~, order] = sort(feature, 'descend');
		t = order(1:k);
		transactions = [transactions; [t 1025]];
		patch_names{patch_no, 1} = patch;
		patch_no = patch_no + 1;
	end
	
end

% Create transactions for negative data (add neg item as 1026)
%62400
neg_transactions = zeros(14400, k+1);
cnt = 1;
for n=1:length(train_data)
	if n ~= i
		class = train_data{n, 1};
		for j=1:length(class)
			im_patches = class{j, 1};

			for m=1:length(im_patches)
				patch = im_patches{m, 1};
				feature = patch.feature;
				[~, order] = sort(feature, 'descend');
				t = order(1:k);				
				neg_transactions(cnt, :) = [t 1026];
				cnt = cnt + 1;
			end

		end
	end
end

indices = randperm(length(neg_transactions), 1600);
transactions = [transactions;neg_transactions(indices,:)];

end

