#' @title getGroups
#'
#' @description internal function used by ccl
#' @param li original slice-wise label image
#' @param ve voxel equivalence classes
#' @param l length of ve
#' @param os number of pixels in one slice
#' @keywords
#' @seealso
#' @return list of slice-wise groups and all lower connected slice groups
#' @aliases
#' @examples \dontrun{
#'
#'}
getGroups <- function(li, ve, l, os){
    grps = vector("list", l)
    grps[1:l] = 1:l
    for(i in 1:l){
    	currInds = ve[[i]]
    	nextInds = currInds + os
    	while(sum(li[nextInds])!=0){
    		newGrps = unique(c(li[nextInds]))
    		newGrps = newGrps[newGrps!=0]
    		grps[[i]] = unique(c(grps[[i]], newGrps))
    		nextInds = unique(unlist(ve[newGrps])) + os
    	}
    }
    return(grps)	
}
