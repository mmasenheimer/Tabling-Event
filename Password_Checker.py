# ANSI color codes
RED = "\033[91m"
YELLOW = "\033[93m"
GREEN = "\033[92m"
CYAN = "\033[96m"
RESET = "\033[0m"

def estimate_time(password):
    length = len(password)
    charset = 0

    # Determine character set size
    if any(c.islower() for c in password):
        charset += 26
    if any(c.isupper() for c in password):
        charset += 26
    if any(c.isdigit() for c in password):
        charset += 10
    if any(not c.isalnum() for c in password):
        charset += 32

    if charset == 0:
        return None, None

    guesses_per_second = 1_000_000_000
    combinations = charset ** length
    seconds = combinations / guesses_per_second

    return seconds

def format_time(seconds):
    if seconds < 1:
        return "less than a second"
    elif seconds < 60:
        return f"{int(seconds)} seconds"
    elif seconds < 3600:
        return f"{int(seconds // 60)} minutes"
    elif seconds < 86400:
        return f"{int(seconds // 3600)} hours"
    elif seconds < 31536000:
        return f"{int(seconds // 86400)} days"
    else:
        return f"{int(seconds // 31536000)} years"

def get_strength(seconds):
    if seconds < 60:
        return RED + "Weak" + RESET
    elif seconds < 86400:
        return YELLOW + "Moderate" + RESET
    elif seconds < 31536000:
        return GREEN + "Strong" + RESET
    else:
        return CYAN + "Very Strong" + RESET

# Run program
password = input("Enter a password to test: ")

seconds = estimate_time(password)

if seconds is None:
    print("Invalid password.")
else:
    print("\nEstimated brute-force crack time:", format_time(seconds))
    print("Strength:", get_strength(seconds))
