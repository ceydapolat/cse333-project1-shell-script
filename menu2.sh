function Q1() {
	var=$1

	length=${#var}	#Get length of the string
	loc=$(echo $(( $length / 2 )))	#take half of string length

	if [ $# -eq 0 ]	#if there is no argument give error message
	then
		echo "Error - String missing from command line argument"
		echo "Syntax : $0 string"	

	else	
		if [ $var -eq $var 2>/dev/null ]
		then

			echo "Please enter string, not integer!"
		else	


			if test $(( $length % 2 )) -gt 0  #Check the string length is even or not
			then	
				fstr=${var:0:loc}	
				sstr=${var:loc+1}
			else 
				fstr=${var:0:loc}	
				sstr=${var:loc}
			fi

			j=$length #length of string
			palnd=1 #control variable for string is palindrome or not

			#Traverse string from its middle
			for (( i=0; i<$loc; i++ ))
			do 
				fstr_ascii=$(printf "%d" "'${var:i:1}") #first half of string
				sstr_ascii=$(printf "%d" "'${var:j-1:1}") #second half of string

				if [ $fstr_ascii -ge 65 ]
				then
					if [ $fstr_ascii -le 90 ]
					then
						fstr_ascii=$(( $fstr_ascii + 32 ))
					fi	
				fi

				if [ $sstr_ascii -ge 65 ]
				then
					if [ $sstr_ascii -le 90 ]
					then
						sstr_ascii=$(( $sstr_ascii + 32 ))
					fi	
				fi
				
				#Check first half and second half are same or not
				if [ $fstr_ascii != $sstr_ascii ]	 
				then
					echo "$var is not a palindrome"
					palnd=0
					break
				fi
				j=$j-1
			done

			if [ $palnd -eq 1 ]
			then 
				echo "$var is a palindrome"
			fi

				fi
			fi

	
}

function Q2() {
	dir_arg=$1
	file=( *.c ) #all .c files under current directory

	if [ $# -eq 0 ] #if there is no argument create a directory and move all files into it
	then
		if [ -f "$file" ] #check type of arguments
		then
			mkdir cprogs	#create directory
			mv *.c cprogs	#move all .c files into created directory
			echo "Files moved successfully"	
		else	
			echo "$file not found."
		fi
		
	else #if pathname is given create a directory under it and move all files into it
		if [ -d "$dir_arg" ]; then	#control given directory exist or not
		    if [ -f "$file" ]
		    then
			 mkdir cprogs	#create directory
			 mv *.c cprogs	#move all .c files into created directory
			 mv cprogs $dir_arg   #move created directory into given path
			 echo "Files moved successfully"
		    else
			 echo "$file not found."
		    fi
		else
		    echo "This path does not exist."
		fi
		
	fi
}

function Q3() {
	arg1=$1
	arg2=$2

	if [ $# -lt 2 -o $# -gt 2 ]	#if there is no argument give error message
	then
		echo "Error - You must give 2 integers."
		echo "Syntax : $0 number number"	
	else
		difference=$(( $arg1-$arg2 ))	#take difference of given parameter to control 							#the first number is greater than second number
		if [ $difference -ge 2 ]
		then 
			remain=$(( $difference%2 ))	#check that difference between numbers is even or not
			div=$(( $difference/2 ))	#take half of difference between numbers
			if [ $remain -eq 0 ]		
			then
			    #create squares
			    for (( i=0; i<$arg1; i++ ))	
			    do		
				for(( j=0; j<$arg1; j++ ))
				do
					if [ $i -ge $div -a $i -le $(($arg1-$div-1)) ]
					then	
						if [ $j -lt $div -o $j -gt $(($arg1-$div-1)) ]
						then
							
							echo -n "*"
						else 
							echo -n " "	
						fi				
					else 	
						echo -n "*"
					fi
				done
				echo 
			    done
			else
				echo "Error - The difference between the two arguments must be an even number."
			fi
		else
			echo "Error - The first number must be at least 2 more than the second number."

		fi
	fi
}

function Q4() {
	echo "NO4"
}

function Q5() {
	arg=$1
	arg2=$2

	function traverse() {	#function for traverse directories recursively
		for file in "$1"/*	#all files under given path
		do
		    if [ ! -d "${file}" ] ; #if current argument is file ask user to delete it or not
		    then
			if [ ! -s $file ] #check the file's size is zero or not
			then
				echo -n "Do you want to delete "
				echo -n $file
				echo "? (y/n): "
				read answer
				if [ $answer == 'y' ]
				then
					rm  $file  #remove file if user choose y answer
				fi
			fi
		    else  #if current argument is directory call recursive
			traverse "${file}"
		    fi
		done

	}

	if [ $# -eq 0 ]	#if there is no argument ask user to delete files just under current directory
	then
		array=( $( find . -maxdepth 1 -type f -size 0 ) )

		for i in ${array[@]}
		do
			filename=${i:2}
			echo -n "Do you want to delete "
			echo -n $filename
			echo "? (y/n): "
			read answer
			if [ $answer == 'y' ]
			then
				rm  $filename
			fi
		done
	elif [ $# -eq 1 -a $1 = "-R" ]	#if there is 1 argument and it is -R option ask user to delete all files
	then				#under current directory and under subdirectories recursively


		#arrange order directory and files, thus it will not ask to delete to directory because of alphabetic order

		for file in ./
		do
			
			declare -a dirlist
			dirlist=$(ls -d */)
			mkdir zzz
			echo ${dirlist}
			
			for dir in $dirlist
			do
			 	mv $dir zzz
			done

		done

		for file in ./
		do

		    if [ ! -d "${file}" ] ; 
		    then
			if [ ! -s $file ]
			then
				echo -n "Do you want to delete "
				echo -n $file
				echo "? (y/n): "
				read answer
				if [ $answer == 'y' ]
				then
					rm  $file
				fi
			fi
		    else
			traverse "${file}"
		    fi
		done
	elif [ $# -eq 1 -a $1 != "-R" ]	#if there is 1 argument and it is pathname ask user to delete 	
	then				#all files under just given directory
		array=( $( find $1 -maxdepth 1 -type f -size 0 ) )
		for i in ${array[@]}
		do
			filename=${i:2}
			echo -n "Do you want to delete "
			echo -n $filename
			echo "? (y/n): "
			read answer
			if [ $answer == 'y' ]
			then
				rm  $filename
			fi
		done
	elif [ $# -eq 2 -a $1 = "-R" ]	#if there is both -R option and pathname ask user to delete all files
	then				#under given directory and under subdirectories recursively
		#$1 = -R $2 = pathname

		#arrange order directory and files, thus it will not ask to delete to directory because of alphabetic order
		for file in ./   
		do
			
			declare -a dirlist
			dirlist=$(ls -d */)
			mkdir zzz
			echo ${dirlist}
			
			for dir in $dirlist
			do
			 	mv $dir zzz
			done

		done

		for file in $2 
		do
		    if [ ! -d "${file}" ] ; 
		    then
			if [ ! -s $file ]
			then
				echo -n "Do you want to delete "
				echo -n $file
				echo "? (y/n): "
				read answer
				if [ $answer == 'y' ]
				then
					rm  $file
				fi
			fi
		    else
			traverse "${file}"
		    fi
		done
	else 
		echo "Error"
		echo "You can give at most 2 arguments."
	fi
}

#Menu creation

if [ $# -eq 0 ]
then 
	selection=0
	while [ "$selection" -ne 6 ]
	do
		echo "1. Check for palindromes"
		echo "2. Move .c files"
		echo "3. Draw hollowed square"
		echo "4. Uppercase conversion"
		echo "5. Delete files"
		echo "6. Exit"
		
		read selection
	
		if [ $selection -eq 1 ]
		then	
			echo "Give argument"
			read arg
			Q1 $arg

		elif [ $selection -eq 2 ]
		then 
			echo "Give argument"
			read arg
			Q2 $arg

		elif [ $selection -eq 3 ]
		then 
			echo "Give argument"
			read arg1 arg2
			Q3 $arg1 $arg2

		elif [ $selection -eq 4 ]
		then 
			echo "Give argument"
			read arg
			Q4 $arg
		
		elif [ $selection -eq 5 ]
		then 
			echo "Give argument"
			read arg
			Q5 $arg

		elif [ $selection -eq 6 ]
		then 
			exit;
		
		else
			echo "input should be in range of [1-6]" 		

		fi
	done	
fi
