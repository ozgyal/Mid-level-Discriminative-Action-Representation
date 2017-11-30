% create image patches of Action40 dataset
clear
clc

images = dir('stanford40');
patch_size = 128;
stride = 32;

for i=3:length(images)
	im = imread(['stanford40/' images(i).name]);
	im = imresize(im, [256, 256]);
	folder_name = ['patch_folder/' images(i).name];
	mkdir(folder_name)
	patch_no = 1;
	for j=1:stride:128
		for k=1:stride:128
			patch = imcrop(im, [j, k, patch_size, patch_size]);
			tokens = strsplit(images(i).name, '.');
			patch_name = [tokens{1} '_' num2str(patch_no) '.jpg'];
			imwrite(patch, [folder_name '/' patch_name]);
			patch_no = patch_no + 1;
		end
	end
	disp(['In image: ' num2str(i-2)])
end