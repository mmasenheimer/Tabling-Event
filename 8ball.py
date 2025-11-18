# FILL IN THE BLANKS

import random # import ___   # (HINT: used for choosing a random item from a list)

# 1. create a list of possible magic 8 ball responses
responses = [
    "Yes, definitely!",
    "No way!",
    "Ask again later.",
    "It is certain.",
    "Very doubtful.",
    "Absolutely!",
    "I don't think so.",
    "Signs point to yes."
]

print("🎱 Welcome to the Magic 8 Ball!")
input("Ask a yes or no question: ")

# 2. choose a random response from the list
answer = random.choice(responses) # answer = ___.choice(___)   # (HINT: pick from the list 'responses')

# 3. print the answer
print("The Magic 8 Ball says:", answer)
