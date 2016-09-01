#' @title colEquivalence
#'
#' @description internal function used by ccl
#' @param x a 2D matrix of column-wise component labels that is returned by colPass
#' @keywords
#' @seealso
#' @return list containing voxel indices (arr.ind=FALSE type) of connected components resulting from the first pass (column-wise) of the algorithm on a single slice
#' @aliases
#' @examples \dontrun{
#'
#'}
colEquivalence <- function(x){
    vInds = matrix(1:length(c(x)), nrow=dim(x)[1])
	lc = c(x[x>0])
	vi = c(vInds[x>0])
	l = length(lc)
	equi = lapply(1:l, function(y) vi[which(lc==lc[y])])
	return(unique(equi))
}
