import subprocess

def main():
    while True:
        print("Welcome to terminal.shop\nWhat would you like to buy")
        print("1. Coffee Beans")
        print("2. Coffee Machine")
        print("3. Coffee Cup")
        print("4. Exit")


        userInput = int(input("Select (1 - 3): "))
        userQuantity = -1
        userChoice = ""

        if userInput == 4:
            print("Exiting...")
            subprocess.run(["pkill", "ssh"])

        if userInput == 1:
            userChoice = "Coffee Beans"
        elif userInput == 2:
            userChoie = "Coffee Machine"
        elif userInput == 3:
            userChoice = "Coffee Cup"

        print(f"You selected {userChoice}")
        userQuantity = int(input("How many would you like: "))

        if userInput == 1:
            c = input(f"Sure! That will be {round(userQuantity * 3, 2)} dollars. Press return to continue")
        elif userInput == 2:
            c = input(f"Sure! That will be {round(userQuantity * 600, 2)} dollars. Press return to continue")
        elif userInput == 3:
            c = input(f"Sure! That will be {round(userQuantity * 4, 2)} dollars. Press return to continue")

        print("Please come again!\n\n")

if __name__ == "__main__":
    main()
