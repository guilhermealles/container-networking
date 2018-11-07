import random
seed = 42
numbers = []
for exponent in range(0, 21):
    for i in range(0, 30):
        numbers.append(2**exponent)
random.seed(seed)
random.shuffle(numbers)
for i in numbers:
    print(str(i))
