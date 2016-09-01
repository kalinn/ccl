#' @title singleSlice
#'
#' @description internal function used by ccl
#' @param x a 2D binary matrix, e.g., single slice of lesion mask
#' @keywords
#' @seealso
#' @return matrix with labeled components
#' @aliases
#' @examples \dontrun{
#'
#'}
singleSlice <- function(x){
    # First pass through columns individually
	cpass = colPass(x)
    # Calculate equivalent classes of voxel indices
	ce = colEquivalence(cpass)
    # Second pass loops through rows sequentially
	rpass = rowPass(cpass, ce)
    # Relabel the components 1, 2, ...
	blobs = unique(c(rpass))
	counter = 1
	for(k in blobs[blobs!=0]){
		rpass[rpass==k] = counter
		counter = counter + 1
	}
	return(rpass)
}
