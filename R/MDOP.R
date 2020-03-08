###### Molecular Data Organization for Publication (MBOT) ###### 

# Written by Rob Young and Jiaojia Yu at the University of Guelph in Ontario Canada, October 2019

#********************************************Main program section***********************************************

################################ GETTING WORKING INITAL WORKING DIRECTORY, SETTING WORKIGN DIRECTORY, AND GETTING TIME AND DATE ###########
  
wd_time_date <- function(target_dir)
{

  initial_wd<-getwd()

  # Set the target directory as the working directory
  setwd(target_dir)

  #set the format for the date for all operating systems
  Sys.setlocale("LC_TIME", "C")

  # Current Date - for file naming use
  date <- sub("-", "", sub("-", "", Sys.Date()))

  initial_wd_and_date<-c(initial_wd,date)
  return(initial_wd_and_date)
    
}



################################ SELECT TARGET DIRECTORY AND FLAGGING THE OPERATING SYSTEM FUNCTION ###########
  
readpath <- function()
{

  cmd_line_instruction_directory()  

  if (interactive() && .Platform$OS.type == "windows"){
    target_dir<-choose.dir(getwd(), "Choose a suitable folder")
  }else{
    system("osascript -e 'tell app \"R\" to POSIX path of (choose folder with prompt \"Choose Folder:\")' > /tmp/R_folder",
           intern = FALSE, ignore.stderr = TRUE)
    p <- system("cat /tmp/R_folder && rm -f /tmp/R_folder", intern = TRUE)
    target_dir<-ifelse(length(p), p, NA)
  }
    
  return(target_dir)
    
}

############################################## SELECTION OF THE FILE TYPE FUNCTION ############################
  
filetypeasinteger <- function()
{
    
  n=4
  
  while(!grepl("[0-3]",n)){
      
    n <- substr(readline(prompt="Enter a selection in the form of an integer, 0=cancel, 1=jpg, 2=ab1, 3=fas/fasta: "),1,1)
      
  }

    
  return(as.integer(n))
    
}


############################################## SELECTION OF THE MAX SIZE OF FILE FUNCTION ############################
  
readmaxfoldersize <- function()
{
  n <- readline(prompt="Enter an integer for max size of a file folder: ")
  if(!grepl("^[0-9]+$",n))
  {
    return(readmaxfoldersize())
  }
  
  return(as.integer(n))
}


############################################## INSTRUCTION FUNCTION FOLDER ############################
  
cmd_line_instruction_directory <- function()
{
  n <- substr(readline(prompt="Select the working directory in the next pop-up window. Hit enter key to continue..."),1,1)
}


############################################## INSTRUCTION FUNCTION FILE ############################
  
cmd_line_instruction_file <- function()
{
  n <- substr(readline(prompt="Select the file you would like to work with in the next pop-up window. Hit enter key to continue..."),1,1)  
}


#' @export
#This function creates a list of all JPG, AB1, or FASTA files in one directory (including sub-directories).
########################################### target_file_list FUNCTION #####################################################################

target_file_list <- function(target_dir="target_dir", file_type="file_type")
{

  # Using a shared function across multiple tools, obtain a target folder location  
  if(target_dir=="target_dir"){
    target_dir = readpath()
  }

  # Using a shared function across multiple tools, get the type of target file (.jpg, .ab1, or .fas)
  if(file_type=="file_type"){
    file_type <- filetypeasinteger()
  }  

  #***********  BIG IF STATEMENT FOR THE REST OF THE CODE TO NOT COMPLETE IF THE FILE TYPE RESPONSE IS 0 MEANING TO CANCEL ****

  if(file_type==0){

    print("Script aborted by user through selection of 0 = Cancel")
  
  }else{

    #************************* SETTING PATH AND GETTING TIME *******************

    initial_wd_and_date<-as.vector(wd_time_date(target_dir))

    #************************* GETTING DIR LIST AND GETTING ALL FILE NAMES UNDER THAT PATH *******************

    # Get a list of directories and sub directories at the specified location
    listofdirs <- list.dirs()

    # Create the file with every .jpg/.ab1/.fas in the parent folder and all subfolders.
    #Initializing the data frame used to write to the file
    target_file_list_final <- data.frame()

    for (i in 1:length(list.dirs())){

      if(file_type == "1") {

        #Initiating the list of files in the folders
        file_list <- list.files(listofdirs[i], pattern = "*[.][Jj][Pp][Gg]$")
        path_list <- normalizePath(list.files(listofdirs[i], pattern = "*[.][Jj][Pp][Gg]$", full.names=TRUE))
        file_name_for_output<-"_target_file_list_JPG.txt"

      } else if (file_type == "2") {

        #Initiating the list of files in the folders
        file_list <- list.files(listofdirs[i], pattern = "*[.][Aa][Bb]1$")
        path_list <- normalizePath(list.files(listofdirs[i], pattern = "*[.][Aa][Bb]1$", full.names=TRUE))
        file_name_for_output<-"_target_file_list_AB1.txt"

      } else if (file_type == "3") {

        #Initiating the list of files in the folders
        file_list <- list.files(listofdirs[i], pattern = "*[.]([Ff][Aa][Ss]$)|([Ff][Aa][Ss][Tt][Aa]$)")
        path_list <- normalizePath(list.files(listofdirs[i], pattern = "*[.]([Ff][Aa][Ss]$)|([Ff][Aa][Ss][Tt][Aa]$)", full.names=TRUE))
        file_name_for_output<-"_target_file_list_FAS.txt"

      } # end of the file type if

      combined <- cbind(file_list,path_list)
      target_file_list_final <- rbind(target_file_list_final, combined)

    } # end of the for loop
    setwd(target_dir)
    write.table(target_file_list_final, file = paste(initial_wd_and_date[2], file_name_for_output, sep = ""), quote = FALSE, col.names = FALSE, row.names = FALSE, sep = "\t")
    print(paste("Task complete, look for output file ", initial_wd_and_date[2], file_name_for_output, " at this location ",target_dir, sep=""))

  }# end of big if statement
  #Here I am making the working directory equal to the inital working directory
  setwd(initial_wd_and_date[1])
}

#' @export
# This function copies all files with specific extension (JPG, AB1, or FAS) into a new directory. [RECURSIVELY]
##################################### recursive_copy FUNCTION ##############################################################
recursive_copy <- function(target_dir="target_dir", file_type="file_type")
{

  # Using a shared function across multiple tools, obtain a target folder location  
  if(target_dir=="target_dir"){
    target_dir = readpath()
  }

  # Using a shared function across multiple tools, get the type of target file (.jpg, .ab1, or .fas)
  if(file_type=="file_type"){
    file_type <- filetypeasinteger()
  }  


  #********* BIG IF STATEMENT FOR THE REST OF THE CODE TO NOT COMPLETE IF THE FILE TYPE RESPONSE IS 0 MEANING TO CANCEL **********

  if(file_type==0){

    print("Script aborted by user through selection of 0 = Cancel")

  }else{

    #************************************** SETTING PATH AND GETTING TIME ********************************

    initial_wd_and_date<-as.vector(wd_time_date(target_dir))

    # Get a list of directories and sub directories at the specified location
    listofdirs <- normalizePath(list.dirs())

    #****************************************** CREATE FILE FOLDER **************************************

    if(file_type == "1") {

      # Path for JPG directory
      jpg_path <- paste(target_dir,"/", initial_wd_and_date[2], "_recursive_copy_JPG","/", sep = "")
      # Create a new directory for storing all the JPG files
      dir.create(jpg_path)

      # Loop for copy files to the JPG folder (All the JPG files will be saved in that folder)
      for (i in 1:length(listofdirs)) {

        path_from <- list.files(listofdirs[i], pattern = "*[.][Jj][Pp][Gg]$", full.names=TRUE)

        file.copy(path_from, jpg_path)

      }
      print(paste("Task complete, look for output file folder ", jpg_path, " at this location ",target_dir, sep=""))

    } else if (file_type == "2") {

      # Path for AB1 directory
      ab1_path <- paste(target_dir,"/", initial_wd_and_date[2], "_recursive_copy_AB1","/", sep = "")
      # Create a new directory for storing all the AB1 files
      dir.create(ab1_path)

      # Loop for copy files to the AB1 folder (All the AB1 files will be saved in that folder)
      for (i in 1:length(listofdirs)) {

        path_from <- list.files(listofdirs[i], pattern = "*[.][Aa][Bb]1$", full.names=TRUE)

        file.copy(path_from, ab1_path)

      }
      print(paste("Task complete, look for output file folder ", ab1_path, " at this location ",target_dir, sep=""))
    }  else if (file_type == "3") {

      # Path for FAS directory
      fas_path <- paste(target_dir,"/", initial_wd_and_date[2], "_recursive_copy_FAS","/", sep = "")
      # Create a new directory for storing all the FAS files
      dir.create(fas_path)

      # Loop for copy files to the FAS folder (All the FAS files will be saved in that folder)
      for (i in 1:length(listofdirs)) {

        path_from <- list.files(listofdirs[i], pattern = "*[.]([Ff][Aa][Ss]$)|([Ff][Aa][Ss][Tt][Aa]$)", full.names=TRUE)

        file.copy(path_from, fas_path)

      }
      print(paste("Task complete, look for output file folder ", fas_path, " at this location ",target_dir, sep=""))
    }
  }

  #Here I am making the working directory equal to the inital working directory
  setwd(initial_wd_and_date[1])

}

#' @export
# This function packages multiple target files into folders of a maximum size value
##################################### max_packs FUNCTION ##############################################################
max_packs <- function(target_dir="target_dir", file_type="file_type", max_folder_size="max_folder_size")
{

  # Using a shared function across multiple tools, obtain a target folder location  
  if(target_dir=="target_dir"){
    target_dir = readpath()
  }

  # Using a shared function across multiple tools, get the type of target file (.jpg, .ab1, or .fas)
  if(file_type=="file_type"){
    file_type <- filetypeasinteger()
  }  

  # Using a shared function across multiple tools, get the maximum desired folder size
  if(max_folder_size=="max_folder_size"){
    max_folder_size <- readmaxfoldersize()
  }  

  initial_wd_and_date<-as.vector(wd_time_date(target_dir))

  # Obtain the total size of the target directory
  target_directory_size <- sum(file.info(list.files(".", all.files = TRUE, recursive = TRUE))$size)

  # If the target file folder is equal or less than the max size abort script
  if ((target_directory_size*0.000001) <= max_folder_size) {

    print ("The folder is smaller than the maximum upload size limit and this script is not needed.")

  } else {

    # Using the following if/else if/else if to obtain a list of files and their sizes from the target directory

    if(file_type == "1") {

    file_list <- list.files(pattern = "*[.][Jj][Pp][Gg]$")
    file_sizes <- file.info(list.files(".", pattern = "*[.][Jj][Pp][Gg]$", all.files = TRUE, recursive = TRUE))$size
    file_type <- "JPG"

    } else if (file_type == "2") {

    file_list <- list.files(pattern = "*[.][Aa][Bb]1$")
    file_sizes <- file.info(list.files(".", pattern = "*[.][Aa][Bb]1$", all.files = TRUE, recursive = TRUE))$size
    file_type <- "AB1"

    }  else if (file_type == "3") {

    file_list <- list.files(pattern = "*[.]([Ff][Aa][Ss]$)|([Ff][Aa][Ss][Tt][Aa]$)")
    file_sizes <- file.info(list.files(".", pattern = "*[.]([Ff][Aa][Ss]$)|([Ff][Aa][Ss][Tt][Aa]$)", all.files = TRUE, recursive = TRUE))$size
    file_type <- "FAS"

    }

    # Creating a single table with associated target names and file sizes
    total_file_info <- cbind(file_list,file_sizes)

    # Initializing the file folder naming counter
    file_folder_counter = 1

    # Create a directory for this fraction fo the files
    dir.create(paste( "./",initial_wd_and_date[2],"_max_packs_",file_type,"_", file_folder_counter, sep = ""))

    # Initializing the total size of the folder being filled
    total_file_size = 0

    # Looping through all files in the target folder to be copied and placed into multiple folders of maximum size
    for (i in 1:nrow(total_file_info)) {

      # This line takes current file size and converts it in to mb from bytes
      check_file_size <- as.numeric(total_file_info[i,2])*0.000001

      # This if will check to see if there is room left in the current folder or if a new folder needs to be created (based on the max value inputted)
      if ((total_file_size + check_file_size) < max_folder_size ) {

        # In the if indicating there is room remaining for this file in the current folder
        # create the copying elements the from file and to file strings
        from_file <- paste( "./", file_list[i], sep = "")
        to_file <- paste("./",initial_wd_and_date[2],"_max_packs_",file_type,"_", file_folder_counter,"/", total_file_info[i,1], sep = "")

        # Command to copy the file
        file.copy(from_file,to_file)

        # Update the total size of the file folder
        total_file_size = total_file_size + check_file_size

      } else {

        # In the else indicating there isn't room remaining for this file in the current folder

        # Add one to the file folder naming variable
        file_folder_counter = file_folder_counter + 1

        # Set the total size variable to the size of the current file
        total_file_size = check_file_size

        # Create a directory for this fraction fo the files
        dir.create(paste( "./",initial_wd_and_date[2],"_max_packs_",file_type,"_", file_folder_counter, sep = ""))

        # create the copying elements the from file and to file strings
        from_file <- paste( "./", file_list[i], sep = "")
        to_file <- paste("./",initial_wd_and_date[2],"_max_packs_",file_type,"_", file_folder_counter,"/", file_list[i], sep = "")

        # Command to copy the file
        file.copy(from_file,to_file)
      }
    }
    print(paste("Task complete. Find file folders with a max size of",max_folder_size, "MB at", target_dir), sep="")
  }

  #Here I am making the working directory equal to the inital working directory
  setwd(initial_wd_and_date[1])

}

#' @export
# This function copies a group of selected files based on a supplied list by the user
##################################### copy_by_list FUNCTION ##############################################################
copy_by_list <- function(target_dir="target_dir", file_list="file_list" )
{

  # Using a shared function across multiple tools, obtain a target folder location  
  if(target_dir=="target_dir"){
    target_dir = readpath()
  }

  # Obtain a target file location 
  if(file_list=="file_list"){

    # This is giving terminal instructions to select the file wanting to be used
    cmd_line_instruction_file()

    # Choose the list file you would like to work on: 
    file_list<-file.choose()

  }

  initial_wd_and_date<-as.vector(wd_time_date(target_dir))

  # load in the data file into the data for the lines  
  file_list<-read.delim(file_list,header=F,sep="\t",dec=".")

  #Make a file folder to contain all results from the program
  dir.create(paste( "./", initial_wd_and_date[2], "_copy_by_list", "/", sep = ""))
      
  #Final location for the paste of the copied files for both Windows and MAC OS
  final_loc <- paste(target_dir, "/", initial_wd_and_date[2], "_copy_by_list", "/", sep = "")

  #Starting the loop to go through each of the items in the selected file to copy one at a time
  for (i in 1:nrow(file_list)) {

    # Copy each of the files in the list to the new folder
    path_from <- paste(target_dir,"/", file_list[i,], sep="")
    file.copy(path_from, final_loc)
  }
  print(paste("Task complete. Find the files in the folder ", date, "_copy_by_list at ", target_dir), sep="")

  #Here I am making the working directory equal to the inital working directory
  setwd(initial_wd_and_date[1])

}

#' @export
# This function removes gaps from all sequences in the selected file. 
##################################### degap FUNCTION ##############################################################
degap <- function(target_dir="target_dir", Seq_file="Seq_file")
{

  # Using a shared function across multiple tools, obtain a target folder location  
  if(target_dir=="target_dir"){
    target_dir = readpath()
  }

  # Obtain a target folder location 
  if(Seq_file=="Seq_file"){

    # This is giving terminal instructions to select the file wanting to be used
    cmd_line_instruction_file()

    # Choose the fasta file you would like to work on: 
    Seq_file<-file.choose()

  }

  initial_wd_and_date<-as.vector(wd_time_date(target_dir))

  # load in the data file in
  Seq_file<-data.frame(read.table(Seq_file))


  #******************************************************************************************
  #This section is taking the fasta file and formatting it in to columns to create the input file for the rates iteration program

  #taking the read in file and changing from Fasta to tab delimited
  Header0 <- Seq_file[seq(from = 1, to = nrow(Seq_file), by = 2), 1]
  Sequence <- Seq_file[seq(from = 2, to = nrow(Seq_file), by = 2), 1]

  #*******************************************************************************************

  #Taking the sequences and removing the gap characters
  New_Seq_file <- data.frame(Header0,as.character(gsub("-", "", Sequence)))

  #**************************************CHANGE TO FASTA FORMAT******************************

  #Flag to enter in the first addition to the matrix to make the fasta file
  fasta_flag=0	

  for (j in 1:nrow(New_Seq_file)){
	
    #This is setting up a flag so the first time we initialize the matrix and then the second time we rbind to the matrix for the fasta file format
    if (fasta_flag==0){
      final_matrix_for_file<-paste(New_Seq_file[j,1],sep="")
      x<-as.character(New_Seq_file[j,2])
      final_matrix_for_file<-rbind(final_matrix_for_file,x)
      fasta_flag=1
    }else{
      x<-paste(New_Seq_file[j,1],sep="")
      final_matrix_for_file<-rbind(final_matrix_for_file,x)
      x<-as.character(New_Seq_file[j,2])
      final_matrix_for_file<-rbind(final_matrix_for_file,x)
    }
  }

  #**********************OUTPUT THE FILE ************************************************************
  # Providing the name and the location where the output files will be located
  Write_to_file_out_str <- paste(target_dir,"/", initial_wd_and_date[2], "_degap.fas", sep="")

  # write the file
  write.table(final_matrix_for_file,file=Write_to_file_out_str,append=FALSE, na="", row.names=FALSE, col.names=FALSE, quote = FALSE,sep="\n")

  # Print the completion message
  print(paste("Task complete, look for output file ", date, "_degap.fas at this location ",target_dir, sep=""))

  #Here I am making the working directory equal to the inital working directory
  setwd(initial_wd_and_date[1])

}

#' @export
# This function ranks sequences by length in a fasta formatted file. 
##################################### rank_seq FUNCTION ##############################################################
rank_seq <- function(target_dir="target_dir", Seq_file="Seq_file")
{

  # Using a shared function across multiple tools, obtain a target folder location  
  if(target_dir=="target_dir"){
    target_dir = readpath()
  }

  # Obtain a target file location 
  if(Seq_file=="Seq_file"){

    # This is giving terminal instructions to select the file wanting to be used
    cmd_line_instruction_file()

    # Choose the fasta file you would like to work on: 
    Seq_file<-file.choose()

  }

  initial_wd_and_date<-as.vector(wd_time_date(target_dir))
							
  # load in the data file in
  Seq_file<-data.frame(read.table(Seq_file))				

  #********************************************************************************************************************************
  #This section is taking the fasta file and formatting it in to columns to create the input file for the rates iteration program

  #taking the read in file and changing from Fasta to tab delimited
  Header0 <- Seq_file[seq(from = 1, to = nrow(Seq_file), by = 2), 1]
  Sequence <- Seq_file[seq(from = 2, to = nrow(Seq_file), by = 2), 1]

  #********************************************************************************************************************************

  #Taking the sequences and removing the gap characters
  Sequence1 <- as.character(gsub("-", "", Sequence))

  #Getting the length of the sequences so we can sort by that length
  Seq_len <- as.integer(nchar(Sequence1))

  #Adding the lengths to the dataframe
  New_Seq_file <- data.frame(Header0,Sequence,Seq_len)

  #*********************************************************************************************************************************

  #Now with the three column data frame we will sort by the length file and place the results in a temp data frame 
  New_Seq_file<-New_Seq_file[order(New_Seq_file$Seq_len),]

  a<-New_Seq_file

  #Taking the sorted dataframe and pulling out the header and sequences and rewriting the original data frame for output
  New_Seq_file<-data.frame(New_Seq_file[,-3])

  #**************************************CHANGE TO FASTA FORMAT**************************************

  #Flag to enter in the first addition to the matrix to make the fasta file
  fasta_flag=0	

  for (j in 1:nrow(New_Seq_file)){
    #This is setting up a flag so the first time we initialize the matrix and then the second time we rbind to the matrix for the fasta file format
    if (fasta_flag==0){
      final_matrix_for_file<-paste(New_Seq_file[j,1],sep="")
      x<-as.character(New_Seq_file[j,2])
      final_matrix_for_file<-rbind(final_matrix_for_file,x)
      fasta_flag=1
    }else{
      x<-paste(New_Seq_file[j,1],sep="")
      final_matrix_for_file<-rbind(final_matrix_for_file,x)
      x<-as.character(New_Seq_file[j,2])
      final_matrix_for_file<-rbind(final_matrix_for_file,x)
    }
  }

  #**********************OUTPUT THE FILE ************************************************************
  # Providing the name and the location where the output files will be located
  Write_to_file_out_str <- paste(target_dir,"/", initial_wd_and_date[2], "_rank_seq.fas", sep="")
  write.table(final_matrix_for_file,file=Write_to_file_out_str,append=FALSE, na="", row.names=FALSE, col.names=FALSE, quote = FALSE,sep="\n")
  print(paste("Task complete, look for output file ", initial_wd_and_date[2], "_rank_seq.fas at this location ",target_dir, sep=""))

  #Here I am making the working directory equal to the inital working directory
  setwd(initial_wd_and_date[1])

}

#' @export
# This function dereplicates sequences based on headers. 
##################################### head_derep FUNCTION ##############################################################
head_derep <- function(target_dir="target_dir", Seq_file="Seq_file")
{

  # Using a shared function across multiple tools, obtain a target folder location  
  if(target_dir=="target_dir"){

    target_dir = readpath()

  }

  # Obtain a target file location 
  if(Seq_file=="Seq_file"){

    # This is giving terminal instructions to select the file wanting to be used
    cmd_line_instruction_file()

    # Choose the fasta file you would like to work on: 
    Seq_file<-file.choose()

  }

  initial_wd_and_date<-as.vector(wd_time_date(target_dir))

  # load in the data file in
  Seq_file<-data.frame(read.table(Seq_file))				

  #******************************************************************************************************************************
  #This section is taking the fasta file and formatting it in to columns to create the input file for the rates iteration program

  #taking the read in file and changing from Fasta to tab delimited
  Header0 <- Seq_file[seq(from = 1, to = nrow(Seq_file), by = 2), 1]
  Sequence <- Seq_file[seq(from = 2, to = nrow(Seq_file), by = 2), 1]

  New_Seq_file <- data.frame(Header0,Sequence)

  #****************************************************************************************************************************
  #dereplicate based on Header
  New_Seq_file<-as.data.frame(subset(New_Seq_file, !duplicated(Header0)))

  #**********************OUTPUT THE FILE **************************************************************************************
  # Providing the name and the location where the output files will be located
  Write_to_file_out_str <- paste(target_dir,"/", initial_wd_and_date[2], "_head_derep.fas", sep="")

  # write the file
  write.table(New_Seq_file,file=Write_to_file_out_str,append=FALSE, na="", row.names=FALSE, col.names=FALSE, quote = FALSE,sep="\n")

  # Print the completion message
  print(paste("Task complete, look for output file ", initial_wd_and_date[2], "_head_derep.fas at this location ",target_dir, sep=""))

  #Here I am making the working directory equal to the inital working directory
  setwd(initial_wd_and_date[1])

}

#' @export
# This function dereplicates a fasta file based on sequences
##################################### seq_derep FUNCTION ##############################################################
seq_derep <- function(target_dir="target_dir", Seq_file="Seq_file")
{

  # Using a shared function across multiple tools, obtain a target folder location  
  if(target_dir=="target_dir"){
    target_dir = readpath()
  }

  # Obtain a target file location 
  if(Seq_file=="Seq_file"){

    # This is giving terminal instructions to select the file wanting to be used
    cmd_line_instruction_file()

    # Choose the fasta file you would like to work on: 
    Seq_file<-file.choose()

  }

  initial_wd_and_date<-as.vector(wd_time_date(target_dir))

  # load in the data file in
  Seq_file<-data.frame(read.table(Seq_file))					

  #***********************************************************************************************************************
  #This section is taking the fasta file and formatting it in to columns

  #taking the read in file and changing from Fasta to tab delimited
  Header0 <- Seq_file[seq(from = 1, to = nrow(Seq_file), by = 2), 1]
  Sequence <- Seq_file[seq(from = 2, to = nrow(Seq_file), by = 2), 1]

  New_Seq_file <- data.frame(Header0,Sequence)

  #***********************************************************************************************************************
  #dereplicate based on sequences
  New_Seq_file<-as.data.frame(subset(New_Seq_file, !duplicated(Sequence)))

  #**********************OUTPUT THE FILE *********************************************************************************
  # Providing the name and the location where the output files will be located
  Write_to_file_out_str <- paste(target_dir,"/", initial_wd_and_date[2], "_seq_derep.fas", sep="")
  write.table(New_Seq_file,file=Write_to_file_out_str,append=FALSE, na="", row.names=FALSE, col.names=FALSE, quote = FALSE,sep="\n")
  print(paste("Task complete, look for output file ", initial_wd_and_date[2], "_seq_derep.fas at this location ",target_dir, sep=""))

  #Here I am making the working directory equal to the inital working directory
  setwd(initial_wd_and_date[1])

}

#' @export
# This function changes a multi-line fasta file into a single line fasta format
##################################### multi_to_single_fasta FUNCTION ##############################################################
multi_to_single_fasta <- function(target_dir="target_dir", Seq_file ="Seq_file")
{			

  # Using a shared function across multiple tools, obtain a target folder location  
  if(target_dir=="target_dir"){
    target_dir = readpath()
  }

  # Obtain a target file location 
  if(Seq_file=="Seq_file"){

    # This is giving terminal instructions to select the file wanting to be used
    cmd_line_instruction_file()

    # Choose the fasta file you would like to work on: 
    Seq_file<-file.choose()

  }

  initial_wd_and_date<-as.vector(wd_time_date(target_dir))

  # load in the data file in
  Seq_file<-data.frame(read.table(Seq_file))	

  #Initializing the flag
  fasta_flag=0
  #************************************************************************************************************************
  for (j in 1:nrow(Seq_file)){
	
    #This is setting up a flag so the first time we initialize the matrix and then the second time we rbind to the matrix for the fasta file format
    if (fasta_flag==0){
      if(grepl(">",Seq_file[1,1])==TRUE){
        final_matrix_for_file<-as.vector(Seq_file[j,1])
        seq_concate<-""
        fasta_flag=1
      }
    }else{
      if(grepl(">",Seq_file[j,1])==TRUE){
        final_matrix_for_file<-rbind(final_matrix_for_file,seq_concate,as.vector(Seq_file[j,1]))
        seq_concate<-""
      }else{
        seq_concate<-paste(seq_concate,Seq_file[j,1],sep="")
      }
    }
  }
  final_matrix_for_file<-rbind(final_matrix_for_file,seq_concate)
  #**********************OUTPUT THE FILE **************************************************************************************
  #Providing the name and the location where the output files will be located
  Write_to_file_out_str <- paste(target_dir,"/", initial_wd_and_date[2], "_multi_to_single.fas", sep="")

  write.table(final_matrix_for_file,file=Write_to_file_out_str,append=FALSE,na="",row.names = FALSE, col.names=FALSE, quote = FALSE,sep="\n") 				
  print(paste("Task complete, look for output file ", initial_wd_and_date[2], "_multi_to_single.fas at this location ",target_dir, sep=""))

  #Here I am making the working directory equal to the inital working directory
  setwd(initial_wd_and_date[1])

}
