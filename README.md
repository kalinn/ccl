[![Travis-CI Build Status](https://travis-ci.org/kalinn/ccl.svg?branch=master)](https://travis-ci.org/kalinn/ccl)

# ccl: Connected Components Labeling

This is an implementation of a connected components labeling algorithm for 3D binary arrays (or nifti objects) in R. It was written with the purpose of labeling Multiple Sclerosis lesions based on a binary lesion mask. 

IMPORTANT NOTE: This code is not yet optimized or parallelized and there are likely other versions available that are more efficient (see, for example, the connComp3D function in R package 'neuroim'). It could be improved by paralellizing the labeling of individual slices and by employing Rcpp to speed up the loops. There also probably exist algorithms that are faster at finding the class equivalences or require only one pass through the 2D images. On a single test lesion mask (size 258x258x178), the ccl function took 53 seconds and connComp3D took 20 seconds.

### Method 

The algorithm uses 6-connectivity (i.e., two voxels are connected if and only if they share a complete side plane). It also assumes there are no 1s on the border of the array. If you suspect your array has 1s on the border, you should pad your array with 0s in all dimensions.

The algorithm starts by implementing a two-pass labeling step on each slice (i.e., index) in the 3rd dimension. The two-pass algorithm first assigns temporary labels to connected components column-wise. It also keeps track of column-wise equivalence classes, meaning which pixels are in the same group. The following figure demonstrates the result of a column pass.

![Column Pass](./images/colPass.png?raw=true "Column Pass Example")

Next, a row pass traverses through the rows and sequentially absorbs all row-wise connected components into the smallest label of the group. Additionally, it relabels any pixel from lower rows according to the column-wise equivalence classes and updates the equivalence classes. The following figure demonstrates the result of a row pass.

![Row Pass](./images/rowPass.png?raw=true "Row Pass Example")

Finally, the slice-wise components are connected across the 3rd dimension. To do this, I first rename the current labels so that each is a unique integer (1, 2, 3, ...) and the labels increase with the index of the 3rd dimension. Starting with the 2D group labeled 1, I update the equivalence classes by looking at the voxels in the next slice corresponding to my current location. I record the labels that appear there (excluding 0), and follow the indices of those new labels to the next slice. This proceeds until the next slice voxels corresponding to my current location are all 0. All labels in this equivalence class are assigned a 1. This continues for the remaining groups, starting with the smallest group that has not yet been absorbed. Whenever groups are merged, the minimum of the equivalence class is assigned as the new label.

