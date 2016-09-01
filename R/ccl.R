#' @title ccl connected components labeling
#'
#' @description labels connected components in a 3D binary array
#' @param x 3D binary array or nifti object
#' @param verbose if TRUE will print progress bars
#' @export
#' @importFrom utils setTxtProgressBar txtProgressBar
#' @keywords
#' @seealso
#' @return 3D array or nifti object of labels
#' @aliases
#' @examples \dontrun{
#'  img = array(rbinom(1000, 1, .5), dim=c(10,10,10))
#'  img[,,1] = 0
#'  img[,,10] = 0
#'  img[1,,] = 0
#'  img[10,,] = 0
#'  img[,1,] = 0
#'  img[,10,] = 0
#'  labels = ccl(img)
#'}
ccl <- function(x, verbose=TRUE){
	if(verbose){
		cat("# Checking image\n")
	}
	if(!all(x==0 | x==1)){
		stop("x must be binary")
	}
	if(!length(dim(x))==3){
		stop("dim(x) must be 3")
	}
    bySlice = slicePass(x, verbose)
    labelImg = bySlice$x
    labelCopy = labelImg # will modify copy
    voxEqui = bySlice$equi
    voxCopy = voxEqui # will modify copy
    oneSlice = dim(x)[1]*dim(x)[2]
    lenEq = length(voxEqui)
    grps = getGroups(labelImg, voxEqui, lenEq, oneSlice)
    if(verbose){
    	cat("# Combining slices\n")
    	pb = utils::txtProgressBar(min=0, max=lenEq, style=3)
    }
	counter = 1
    for(i in 1:lenEq){
    	if(verbose){
    		utils::setTxtProgressBar(pb, i)
    	}
    	if(!any(is.na(voxCopy[[i]]))){
    		ccs = grps[[i]]
    		combineInd = unique(unlist(voxEqui[ccs]))
    		grpMin = min(labelCopy[combineInd])
    		voxCopy[ccs] = NA    		
    		if(grpMin<=counter){
    			labelCopy[combineInd] = grpMin
    		} else{
    			counter = counter + 1
    			labelCopy[combineInd] = counter
    		}
    	}
    }
    if(verbose){
    	close(pb)
    }
    return(labelCopy)
}

