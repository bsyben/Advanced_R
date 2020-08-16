#include <Rcpp.h>
using namespace Rcpp;

//[[Rcpp::export]]
/* function f1C calculates the mean of numeric vector x*/
double f1C(NumericVector x){
    int n = x.size(); /* n is the length of x*/
    double y = 0;
    
    for(int i = 0; i < n; ++i){
        y += x[i]/n; /* y is the mean value of vecto x*/
    }
    
    return y;
}

//[[Rcpp::export]]
/* function f2C calculate the cumulative sum of x*/
NumericVector f2C(NumericVector x){
    int n = x.size();
    NumericVector out(n);
    
    out[0] = x[0];
    for(int i = 0; i < n; ++i){
        out[i] = out[i-1] + x[i];
    }
    return out;
}

/* function f3C check all logical conditions in x. If anyone of it is true, then return
 * true. Otherwise return false 
 */

//[[Rcpp::export]]
bool f3C(LogicalVector x){
    int n = x.size();
    
    for(int i = 0; i < n; ++i){
        if(x[i]) return true;
    }
    
    return false;
}

/*
 * List is a doubly linked cpp sequence container. It keeps record of an element by the 
 * association to each element of a link to the element preceding it and a link to the 
 * element following it. However, as a result of the association, elements in list cannot
 * be accessed directly by their positions. It always need to be traced from a known 
 * position, such as the beginning or ending.
 * 
 * pred: Predicate function in std namespace. It takes in a vector, iterate from the first
 * element, and check if conditions are met.
 */
//[[Rcpp::export]]
int f4(Function pred, List x){
   int n = x.size();
    
    for(int i = 0; i < n; ++i){
        LogicalVector res = pred(x[i]);
        if(res[0]) return i+1;
    }
    return 0;
    

}


/*** R

*/