# Author: Abid H. Mujtaba
# Date: 2013-01-06
#
# This Makefile automates the building of the project using gradle. It also has functionality for sending the code to the EV3 and running it on it, using the Wifi connection (and SSH).

# This is the name of the Project as well as the main class (the class that contains the main() function where execution begins.
NAME=Lift

# We define the various files involved. We use $(NAME) wherever needed so that one need only change that one variable to change everything else.

SRC=$(wildcard src/*.java) $(wildcard src/*/*.java)		# All the Java source files in the project specified using globbing patterns
JAR=build/libs/$(NAME).jar		# .jar file generated by compiling the project

# Destination of compiled files on the EV3
DEST=/home/lejos/programs


# We define the PHONY Targets i.e. targets that do NOT correspond to actual files and so are run by being called explicitly along with make or as prerequisites for other targets.
.PHONY: default, build, run


# Since this is the first rule in the Makefile this will be run if one issues only "make" at the prompt.
default: build


# We define the output file .jar. "make" will study its timestamp to determine whether it needs to be recompiled.
build: $(JAR)

# We declare the prequisites of the .jar file. Any time the prerequisites are newer than the target the recipe is run.
$(JAR):	$(SRC) build.gradle
# Straight-forward recipe for recompiling the source code to get the .jar file
	gradle build		
	touch $(JAR)
# We touch the jar file because if the source code hasn't changed "gradle build" will NOT recreate the jar file

# EMPTY target for sending the .jar file to the EV3. This is the file that can be launched directly from the EV3.
sync: $(JAR)

	scp $(JAR) ev3:$(DEST)
	touch sync

# PHONY target to actually run the .jar file on the EV3 remotely. It will build and/or sync the .jar file to the EV3 before running if needed.
run: sync

	ssh ev3 "cd $(DEST) && jrun -jar $(NAME).jar"
