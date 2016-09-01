# @fn colPass
# @input x a 2D binary matrix, e.g., single slice from lesion mask
# @return matrix of connected components labeled 1, 2, ..., where each component has a unique label
#' @title colPass
#'
#' @description internal function used by ccl
#' @param x a 2D binary matrix, e.g., single slice from lesion mask
#' @keywords
#' @seealso
#' @return matrix of connected components labeled 1, 2, ..., where each component has a unique label
#' @aliases
#' @examples \dontrun{
#'
#'}
colPass <- function(x){
    cp = apply(x, 2, vecPass)
    numComp = apply(cp, 2, max)
    nc = length(numComp)
    # Cumulative sum of components
    cs = c(0, cumsum(numComp)[-nc])
    relabel = t(apply(cp, 1, function(x, y) (x>0)*(x+y), y=cs))
    return(relabel)
}
