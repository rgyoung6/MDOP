\name{copy_by_list}
\alias{copy_by_list}
\title{
Move files based on a list
}
\description{
# This function moves a group of selected files based on a nsupplied list by the user.
}
\usage{
copy_by_list(target_dir, file_list)
}
\arguments{
  \item{target_dir}{ A string with a path for a target file folder. ie. "C:/A_file"}
  \item{file_list}{ A string with a path for a target file containing . ie. "C:/A_file"}
}
\details{
The function will operate with or without an argument in a Windows or Apple OS environment.
}
\value{
There are no values returned and results of move_by_list are printed to screen and are evident through the creation of a file containing files based on the selected list.
}
\references{
https://github.com/HannerLab
Young, R. G., Yu, J., Cote, M. J., Hanner, R. H. (Submitted January 2020). The Molecular Data Organization for Publication (MDOP) R package to aid the upload of data to shared databases. Biodiversity Data Journal.

}
\author{
Written by Rob Young and Jiaojia Yu at the University of Guelph in Ontario Canada, October 2019
}
\note{
This function was created and tested using Ver. 3.5.1; R Core Team 2018
It was tested on the operating systems Windows 7 and 10, Mac OS Mojave Version 10.14.6
Aside from base functions for this R version no other packages were utilizied
}

\section{Warning }{
}

\seealso{
target_file_list()
recursive_copy()
max_packs()
copy_by_list()
degap()
rank_seq()
head_derep()
seq_derep()
multi_to_single_fasta()
}
\examples{
}
\keyword{ datasets }
\keyword{ data }
\keyword{ manip }
