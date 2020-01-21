# Molecular Data Organization for Publication (MDOP)
# Description:
The Molecular Data Organization for Publication (MDOP) R package has functions to assist researchers in uploading molecular sequence data and associated metadata to public databases.

# Functions:
**target_file_list()**<br/>
**recursive_copy()**<br/>
**max_packs()**<br/>
**copy_by_list()**<br/>
**degap()**<br/>
**rank_seq()**<br/>
**head_derep()**<br/>
**seq_derep()**<br/>
**multi_to_single_fasta()**<br/>

# Installation:
MDOP is not currently on Comprehensive R Archive Network (CRAN) and so you have three ways to use the package functions.

## 1. Install via GitHub
Run the following commands in your R terminal...<br/>

> install.packages("devtools")<br/>
> library(devtools)<br/>
> devtools::install_github("rgyoung6/MDOP")<br/>

**Note:** the first command to install the "devtools" may not be necessary if already installed.<br/>

## 2. Install through download from GitHub.

Navigate to the [MDOP](https://github.com/rgyoung6/MDOP) GitHub page. Download the files associated with this page to your local computer and place them somewhere in the main filefolder named MDOP. Then run the following command pointing to that location on your local computer by replacing the HERE with the path in the below command...<br/>
> library("MDOP", lib.loc="HERE")<br/>

## 3. Run without installation 
Alternatively you can run the functions with out installing the package by coping the contents of the [MDOP.R]( https://github.com/rgyoung6/MDOP/blob/master/R/MDOP.R) file and pasting it into your R terminal.  

# Function Descriptions:
## Upload tools
The following three sections describe scenarios where data or files need to be manipulated or obtained. The functions in this package can be initiated through use of one or more arguments when initiating the function. However, if so desired the user does have the option to initiate the function without arguments and will be prompted for the necessary information.

### Obtaining file lists
When preparing uploads to centralized databases, a list of all files is often needed with associated information (eg. Image file data, trace file data). These data can be obtained using DOS or IOS commands. However, the use of the command prompt is not always possible, particularly in places where security features limit this possibility such as government institutions and industry.

#### target_file_list() 
This function lists files with the extensions JPG, AB1, or FASTA/FAS for a chosen directory and all subdirectories. The list of file paths and file names will be saved as a text file in the chosen directory. The user can either choose to submit the file path and the file type as arguments when initiating the tool or alternatively can run the tool with no arguments and be prompted for the necessary information. If running without arguments the user will first be prompted to choose a file folder as a location to save the output file. Then it is necessary to input the type of file for which you would like to have a list (JPG, AB1, or FAS). The output for the script will appear in a text file with the naming convention YYYYMMDD_target_file_list_TYP.txt, where the first eight characters represent the date of running, the second section is in reference to the function name, and the final section with TYP is the file type chosen (JPG, AB1, or FAS).

### File Manipulation
Moving, copying, sorting, and subsetting large numbers of files is often necessary when preparing to upload data to shared databases. The organization of files for upload is made more difficult when processing files from multiple sources, research groups, and over time. These three functions can assist in the organization of diverse sets of files for upload.

#### recursive_copy()
Often, the submission numerous files, including image and chromatogram (trace) files, to a centralized data system is necessary. Bringing files into a central folder may be difficult when dealing with large numbers of files stored in cascading file structures. recursive_copy() is written to bring all files with a specific extension into a central location thereby making it easier to upload these files. The recursive_copy() function copies files with the extensions JPG, AB1, or FASTA/FAS in a directory and all subdirectories and places these files in a single destination folder. The user can either choose to submit the file path and the file type as arguments when initiating the tool or can run the tool with no arguments and be prompted for the necessary information. If running without arguments the user will first be prompted to choose a file folder where the new folder of copied files will be located. Then it is necessary to input the type of file for which you would like to copy the files (JPG, AB1, or FAS). The output for the script will appear in a file folder with the naming convention YYYYMMDD_ recursive_copy()_TYP, where the first eight characters represent the date of running, the second section is in reference to the function name, and the final section with TYP is the file type chosen (JPG, AB1, or FAS).

#### max_packs()
Uploads of image files to centralized databases are often limited to a particular size per upload. It can be time consuming and challenging to partition files into folders of target sizes. The max_packs() function can be utilized to create these partitioned folders quickly and easily. This function will take a single file folder (but not containing folders) with target files (JPG, AB1, or FAS) and place them into file folders based on a maximum file folder size. The user can either choose to submit the file path, file type, and maximum desired file folder size as arguments when initiating the tool or can run the tool with no arguments and be prompted for the necessary information. If running without arguments the user will first be prompted to choose a file folder with the target files of interest. Then it is necessary to input the type of file for which you would like to copy the files (JPG, AB1, or FAS). Finally, the user will be required to input an integer value for the maximum allowable size for the folders created with the copied files. The outputs for the script will appear in the target file folder location with the naming convention YYYYMMDD_ max_packs_TYP_# where the first eight characters represent the date of running, the second section is in reference to the function name, and third element TYP is the file type chosen (JPG, AB1, or FAS) and the final element # is an index for the folder number.

#### copy_by_list()
It is likely, after scrutiny, that some files associated with molecular records will not need to be uploaded to shared databases due to quality filtering. For example, if a DNA sequence was of poor quality it might be removed from the dataset for potential upload. This would then require the removal of associated metadata files. It is often time consuming to complete a point-and-click removal for all these records. In addition, the screening of these poor-quality records is often completed in fasta files and/or through the use of lists. copy_by_list() will assist in the copying of select files in a larger file folder and placing them into a new file folder based on a specified list. This tool will copy the files based on a list of file names in a target text file and place the copies in a file folder at the identified location. This script will not look at subdirectories in the target directory. To get the files of interest into a single file folder see recursive_copy(). When using copy_by_list() the user can either choose to submit the file path and target file list as arguments when initiating the function or can run the function with no arguments and be prompted for the necessary information. If running without arguments the user will first be prompted to choose a file folder where the files or interest are located. Then it is necessary to select the target file with the list of desired files. The output file folder name will follow the format YYYYMMDD_copy_by_list where the first eight characters represent the date of running, the second section is in reference to the function name. The text file with the list of target files which the user wants to be copied into a single folder needs to have one file name per line and a single blank line at the end of the list.

### Sequence Manipulation

The manipulation of sequence data can also be a challenge to get organized for upload to databases. This is especially true when dealing with large data sets containing multiple markers from different sources, researchers, or naming conventions. The following five R functions will help to manipulate multiple sequence fasta files. One note is that degap(), rank_seq(), head_derep(), and seq_derep() require a single line (not multiline) fasta input file for proper functioning. If the working file is in multiline format, the user can use multi_to_single_fasta() to convert it to single line format.

#### degap()
It is often desired to only upload unaligned data to public databases. To accomplish this easily we present the degap() tool. This function is designed to remove gaps (represented by "-") from all sequences in a selected fasta file. Users will need to select a file folder as a location to save the output file and an input fasta file. The user can either choose to submit the file path and the file they want to work on as arguments when initiating the tool or they can run the tool with no arguments and be prompted for the necessary information. The output file will follow the naming convention YYYYMMDD_degap.fas and be saved in the selected working directory.

#### rank_seq()
Often it is useful to screen out sequences of shorter length from further analyses. rank_seq() will take a multiple sequence fasta file and organize the sequences from shortest to longest. This will ease the visualisation of the fasta file in an alignment program and facilitate the selection of sequences over a given length and removal of sequence below a target length. This tool takes a select multiple sequence fasta file and organizes the sequences from shortest to longest and saves the output in a new fasta file. Users will need to select a file folder as a location to save the output file and an input fasta file. The user can either choose to submit the file path and the file they want to work on as arguments when initiating the tool or alternatively can run the tool with no arguments and be prompted for the necessary information. The new sorted file will be saved in the selected location with the naming convention YYYYMMDD_rank_seq.fas.

#### head_derep()
Removing duplicate records based on the fasta file header may be necessary to ensure no repetition of data. head_derep() addresses this need in an easily applicable. This function will reduce a select fasta file to all unique entries based on the headers. Users will need to select a file folder as a location to save the output file and an input fasta file. The user can either choose to submit the file path and the file they want to work on as arguments when initiating the tool or alternatively can run the tool with no arguments and be prompted for the necessary information. The output will be saved in the selected directory with the naming convention of YYYYMMDD_head_derep.fas.

#### seq_derep()
Removing duplicate records based on sequence may be necessary to ensure no repetition of data or when looking to determine the haplotype diversity in a multiple sequence file. This tool will reduce a select fasta file to all unique entries based on the sequences. Users will need to select a file folder as a location to save the output file and an input fasta file. The user can either choose to submit the file path and the file they want to work on as arguments when initiating the tool or alternatively can run the tool with no arguments and be prompted for the necessary information. The output will be saved in the selected directory with the naming convention of YYYYMMDD_seq_derep.fas.

#### multi_to_single_fasta()
Often multiline fasta files where the header is on the first line followed by one or more lines of up to 80 characters containing nucleotide sequence data can be problematic when using different programs or tools. multi_to_single_fasta() can be used to change a multiple line fasta file format to a single line format where each header has a single line of nucleotide sequence data associated with a header. This tool will accept a multi-line fasta file and convert it to a single line fasta file format. Users will need to select a file folder as a location to save the output file and an input fasta file. The user can either choose to submit the file path and the file they want to work on as arguments when initiating the tool or alternatively can run the tool with no arguments and be prompted for the necessary information. The output will be saved in the selected directory with the naming convention of YYYYMMDD_multi_to_single_fasta.fas

# Function Examples:
Each of the following examples use the files included in the folder "TEST" found on with the package on Github. Using these files will provide the same results as is described in this section. Download this ‘TEST’ file to your computer and follow the below examples with arguments when initiating the functions or when prompted after calling on the function. The examples below have been completed with the exampe files in the "TEST" folder located at the root directory for the computer. The following examples use the functions with argument input but each function outputs are the identical when selecting the arguments when prompted. These examples can be executed in either R or R studio.

## target_file_list()
Enter the following command in the R terminal...

  > target_file_list("C:/TEST",1)

The first argument is the target file folder and the second agrument indicates the selection of .JPG files (as opposed to 2 for .AB1 files and 3 for .FAS files). 

The terminal should display the message...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] "Task complete, look for output file YYYYMMDD_target_file_list_JPG.txt at this location C:/TEST"

If you navigate to the 'TEST' file folder you will find the file 'YYYYMMDD_target_file_list_JPG.txt'. The contents of this file should look like the following...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A.jpg &nbsp; C:\TEST\1\A.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.jpg &nbsp; C:\TEST\1\B.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.jpg &nbsp; C:\TEST\1\C.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D.jpg &nbsp; C:\TEST\1\D.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E.jpg &nbsp; C:\TEST\2\E.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F.jpg &nbsp; C:\TEST\2\F.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G.jpg &nbsp; C:\TEST\2\G.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H.jpg &nbsp; C:\TEST\2\H.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I.jpg &nbsp; C:\TEST\2\I.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J.jpg &nbsp; C:\TEST\2\J.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K.jpg &nbsp; C:\TEST\2\Subfolder_2_1\K.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L.jpg &nbsp; C:\TEST\2\Subfolder_2_1\L.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M.jpg &nbsp; C:\TEST\2\Subfolder_2_1\M.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N.jpg &nbsp; C:\TEST\3\N.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O.jpg &nbsp; C:\TEST\3\O.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P.jpg &nbsp; C:\TEST\3\P.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q.jpg &nbsp; C:\TEST\3\Subfolder_3_1\Q.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R.jpg &nbsp; C:\TEST\3\Subfolder_3_1\Subfloder_3_1_1\R.jpg<br/>

## recursive_copy()

Enter the following command in the R terminal...
  
  > recursive_copy("C:/TEST",1)

The first argument is the target file folder and the second agrument indicates the selection of .JPG files (as opposed to 2 for .AB1 files and 3 for .FAS files). 
  
The terminal should display the message...
  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] "Task complete, look for output file folder YYYYMMDD_recursive_copy_JPG at this location C:/TEST"
  
If you navigate to the 'TEST' file folder you will find the folder 'YYYYMMDD_recursive_copy_JPG'. The contents of this folder should have the following files...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R.jpg<br/>

## max_packs()

NOTE: To complete this example you first need to run recursive_copy() as described above.

Enter the following command in the R terminal...
  
  > max_packs("C:/TEST/YYYYMMDD_recursive_copy_JPG",1,20)
  
The first argument is the target file folder, the second agrument indicates the selection of .JPG files (as opposed to 2 for .AB1 files and 3 for .FAS files), and the third argument is for the maximum file folder size of 20 MB.

The terminal should display the message...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] "Task complete. Find file folders with a max size of 20 MB at C:/TEST/YYYMMDD_recursive_copy_JPG"

If you navigate to the 'TEST/YYYYMMDD_recursive_copy_JPG' you will have three new folders each containing image files as shown in the following list...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;YYYYMMDD_max_packs_JPG_1<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;B.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;C.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;D.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;E.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;F.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;G.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;H.jpg<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;YYYYMMDD_max_packs_JPG_2<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;I.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;J.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;K.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;L.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;M.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;N.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O.jpg<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;YYYYMMDD_max_packs_JPG_3<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;P.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Q.jpg<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;R.jpg<br/>
    
## copy_by_list()

Enter the following command in the R terminal...
  
  > copy_by_list("C:/TEST/2","C:/TEST/List_to_select_specific_files_for_copy_by_list.txt")
  
The first argument is the target file folder with files you want to have extracted, the second agrument indicates the text file with the list of files to be extracted.

The terminal should display the message...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] "Task complete. Find the files in the folder  YYYYMMDD_copy_by_list at  C:/TEST/2"

If you navigate to the 'TEST/2/YYYYMMDD _copy_by_list' folder you will have all of the files from the List_to_select_specific_files_for_copy_by_list.txt 

## degap()

Enter the following command in the R terminal...
  
  > degap("C:/TEST","C:/TEST/fasta.fas")
  
The first argument is the target file folder for the output file, the second agrument is the target fasta file to have the gaps removed.

The terminal should display the message...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] "Task complete, look for output file YYYYMMDD_degap.fas at this location C:/TEST"

If you navigate to the 'C:/TEST/' folder you will find the output file YYYYMMDD_degap.fas for comparison to the file with gaps fasta.fas at the same location. 

## rank_seq()

Enter the following command in the R terminal...
  
  > rank_seq("C:/TEST","C:/TEST/fasta.fas")
  
The first argument is the target file folder for the output file, the second agrument is the target fasta file to have the sequences ordered based on nucleotide length.

The terminal should display the message...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] "Task complete, look for output file YYYYMMDD_rank_seq.fas at this location C:/TEST"

## head_derep()

Enter the following command in the R terminal...
  
  > head_derep("C:/TEST","C:/TEST/fasta_duplicate_names.fas")
  
The first argument is the target file folder for the output file, the second agrument is the target fasta file to have the sequences reduced based on the headers of the sequences.

The terminal should display the message...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] "Task complete, look for output file YYYYMMDD_head_derep.fas at this location C:/TEST"

## seq_derep()

Enter the following command in the R terminal...
  
  > seq_derep("C:/TEST","C:/TEST/fasta_duplicate_sequences.fas")
  
The first argument is the target file folder for the output file, the second agrument is the target fasta file to have the sequences reduced based on the comparison of the full length sequences.

The terminal should display the message...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] "Task complete, look for output file YYYYMMDD_seq_derep.fas at this location C:/TEST"

## multi_to_single_fasta()

Enter the following command in the R terminal...
  
  > multi_to_single_fasta("C:/TEST","C:/TEST/fasta_multiple_line_format.fas")
  
The first argument is the target file folder for the output file, the second agrument is the target fasta file in multiline fasta file format.

The terminal should display the message...

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[1] "Task complete, look for output file YYYYMMDD_multi_to_single.fas at this location C:/TEST"
