\name{recursive_copy}
\alias{recursive_copy}
\title{
Copy JPG/AB1/FASTA files from a target directory
}
\description{
This function copies all files with specific extension (JPG, AB1, or FAS) into a new directory. [RECURSIVELY]
}
\usage{
recursive_copy(target_dir, file_type)
}
\arguments{
  \item{target_dir}{ A string with a path for a target file folder. ie. "C:/A_file"}
  \item{file_type}{ An integer with a value between 0 and 4 to indicate the selected file type. 0=cancel, 1=jpg, 2=ab1, 3=fas/fasta}
}
\details{
The function will operate with or without an argument in a Windows or Apple OS environment.
}
\value{
There are no values returned and results of recursive_copy are printed to screen and are evident through the creation of a file folder containing copies of the target files.
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
