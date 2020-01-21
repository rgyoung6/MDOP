\name{head_derep}
\alias{head_derep}
\title{
Dereplicate fasta file based on fasta headers
}
\description{
# This function dereplicates sequences in a fasta file based on headers. 
}
\usage{
head_derep(target_dir, Seq_file)
}
\arguments{
  \item{target_dir}{ A string with a path for a target file folder. ie. "C:/A_file"}
  \item{Seq_file}{ A srting with the pat for the target file. ie. "C:/seqfile.fas"}
}
\details{
The function will operate with or without an argument in a Windows or Apple OS environment.
}
\value{
There are no values returned and results of head_derep are printed to screen and are evident through the creation of a file with unique records based on header.
}
\references{
https://github.com/HannerLab
Young, R. G., Yu, J., Cote, M. J., Hanner, R. H. (Submitted January 2020). Introducing MDOP: an R package to aid Molecular Data Organization for Publication to shared databases. Biodiversity Data Journal.

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
