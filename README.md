# Mid-level-Discriminative-Action-Representation

This is an implementation of finding mid-level representations for still actions by using association rule mining which is proposed in ["Mid-level Deep Pattern Mining"](http://ieeexplore.ieee.org/stamp/stamp.jsp?arnumber=7298699). The code can be used with prepared features of image patches in a dataset. Patches can be obtained by using "extractPatches.m". After extracting and loading related features for each patch (in the code the dimension of the feature is 1x1024), "run.m" can be used to find representative patches of the actions. A sample result is given below:

<img src="https://raw.githubusercontent.com/ozgyal/Mid-level-Discriminative-Action-Representation/master/result.png" width="500" height="500"/>

While applying association rule mining, Narine Manukyan's [Apriori implementation](https://www.mathworks.com/matlabcentral/fileexchange/42541-association-rules) is used.

The implementation details and experiments are reported in [this paper](https://ozgeyalcinkaya.com/wp-content/uploads/2017/11/Mid-level-Action-Representation-with-Association-Rule-Mining-for-Still-Images.pdf).