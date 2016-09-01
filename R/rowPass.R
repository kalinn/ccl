#' @title rowPass
#'
#' @description internal function used by ccl
#' @param x the 2D binary matrix output by colPass
#' @param eq the list of voxel equivalences output by colEquivalence
#' @keywords
#' @seealso
#' @return 2D binary matrix of connected component labels
#' @aliases
#' @examples \dontrun{
#'
#'}
rowPass <- function(x, eq){
    vInds = matrix(1:length(c(x)), nrow=dim(x)[1])
    notEmpty = apply(x, 1, function(y) sum(y)>0)
    rp = c(1:nrow(x))[notEmpty]
	l = ncol(x)
	for(i in rp){
        diff = (x[i,2:l]>0) - (x[i,1:(l-1)]>0)
        starts = which(diff==1) + 1
        ends = which(diff==-1)
        ns = length(starts)
        for(j in 1:ns){
            grps = unique(x[i,starts[j]:ends[j]])
            gInds = unique(unlist(eq[grps]))
            gMin = min(grps)
            x[gInds] = gMin
            eq[[gMin]] = gInds
        }
    }
    return(x)
}
