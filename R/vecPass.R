#' @title vecPass
#'
#' @description internal function used by ccl
#' @param x a binary vector, i.e., a single column from a single lesion mask slice
#' @keywords
#' @seealso
#' @return vector of connected components labeled 1, 2, ...
#' @aliases
#' @examples \dontrun{
#'
#'}
vecPass <- function(x){
	l = length(x)
	# diff=1 is start of new component; the following
	# diff=-1 is the end of that component
	diff = x[2:l] - x[1:(l-1)]
	if(sum(x)>0){
		starts = which(diff==1) + 1
		ends = which(diff==-1) 
		counter = 1
		for(i in 1:length(starts)){
			x[starts[i]:ends[i]] = counter
			counter = counter + 1
		}
	}
	return(x)
}
