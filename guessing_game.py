# Creates a random number and guess variable. Don't need to modify this!
import random
random_number = random.randint(1,50)
user_guess = -1


# This while loop allows the user to guess while guess is not the random numer
while (random_number != user_guess):

    user_guess = int(input("\nEnter your guess:\n"))

    ###########################################################################
    #    COMPLETE THIS IF STATEMENT (USER_GUESS IS EQUAL TO RANDOM_NUMBER)    #
    #           HINT: USE == (TWO EQUAL SIGNS!) INSIDE THE EMPTY ()           #
    ###########################################################################
    if ():
        print("YOU WON!\n")
        exit()

    ###########################################################################
    #    COMPLETE THIS IF STATEMENT (USER_GUESS IS LESS THAN RANDOM_NUMBER)   #
    #                  HINT: USE < INSIDE THE EMPTY ()                        #
    ###########################################################################
    if ():
        print("Too low!\n")

    ###########################################################################
    #  COMPLETE THIS IF STATEMENT (USER_GUESS IS GREATER THAN RANDOM_NUMBER)  #
    #                    HINT: USE > INSIDE THE EMPTY ()                      #
    ###########################################################################
    if ():
        print("Too high!\n")
