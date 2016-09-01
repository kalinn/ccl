#' @title slicePass
#'
#' @description internal function used by ccl
#' @param x a 3D binary matrix, e.g., lesion mask
#' @param verbose if TRUE prints progress bars
#' @importFrom utils setTxtProgressBar txtProgressBar
#' @keywords
#' @seealso
#' @return equi a list of voxel equivalencies defined by the labels
#' @aliases
#' @examples \dontrun{
#'
#'}
slicePass <- function(x, verbose=TRUE){
    voxelArr = array(1:length(c(x)), dim=dim(x))
    lInd = which(x==1, arr.ind=TRUE)
    slices = sort(unique(lInd[,3]))
    nclass = 0
    equi = list()
    if(verbose){
    	cat("# Finding components by slice\n")
    	pb = utils::txtProgressBar(min=0, max=max(slices), style=3)
    }
    for(s in slices){
    	if(verbose){
    		utils::setTxtProgressBar(pb, s)
    	}
        spass = singleSlice(x[,,s])
        x[c(voxelArr[,,s])] = (spass>0)*(spass + nclass)
        nclass = nclass + max(unique(c(spass)))
        ccs = sort(unique(c(x[voxelArr[,,s]])))
        ccs = ccs[ccs!=0]
        inds = lapply(ccs, function(y) voxelArr[,,s][which(x[,,s]==y)])
        equi = c(equi, inds)
    }
    if(verbose){
    	close(pb)
    }
    return(list('x'=x, 'equi'=equi))
}

