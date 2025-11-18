import random # import ___  (HINT: lets us pick random choices)

options = ["rock", "paper", "scissors"]

print("Welcome to Rock–Paper–Scissors!")
player = input("Choose rock, paper, or scissors: ").lower()

computer = random.choice(options) # computer = ___.choice(___)  (HINT: pick from the list options)

print("The computer chose:", computer)

# decide who the is winner
if player == computer: # if player ___ computer: (HINT: what operator would make them get a tie)
    print("It's a tie!")
elif player == "rock" and computer == "scissors":
    print("You win!")
elif player == "paper" and computer == "rock":
    print("You win!")
elif player == "scissors" and computer == "paper":
    print("You win!")
else:
    print("The computer wins!")
