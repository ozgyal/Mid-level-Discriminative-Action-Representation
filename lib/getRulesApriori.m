function [ rules, freqItemsets ] = getRulesApriori( data_apriori, min_support, min_confidence, nRules )
%Returns the rules which are computed with Apriori implementattion

% Get attribute-value names for item numbers
temp = num2str((1:1026));
tokens = strsplit(temp, ' ');
att_names = containers.Map((1:1026), tokens);

sortFlag = 1;
fname = 'dimension_rules';
[rules freqItemsets] = findRules(data_apriori, min_support, min_confidence, nRules, sortFlag, att_names, fname);

end

