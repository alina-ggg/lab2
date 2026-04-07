import Foundation

// Создаем функцию для чтения всех чисел, сколько бы строк мы ни ввели
func readAllNumbers() -> [Int] {
    var allNumbers: [Int] = []
    // Читаем, пока есть что читать (до Ctrl+D) или пока не наберем числа
    while let line = readLine() {
        let parts = line.split(separator: " ").compactMap { Int($0) }
        allNumbers.append(contentsOf: parts)
        
        // Если уже считали N и достаточное количество чисел, выход
        if !allNumbers.isEmpty && allNumbers.count >= (allNumbers[0] + 1) {
            break
        }
    }
    return allNumbers
}

let nums = readAllNumbers()

// Проверка условий
if nums.count < 2 {
    print(0)
    exit(0)
}

let n = nums[0]
var count = 0

// Цикл сравнения
if n > 1 {
    let limit = min(nums.count, n + 1) // Чтобы не выйти за границы, если ввели меньше N чисел
    for i in 2..<limit {
        if nums[i] == nums[i-1] {
            count += 1
        }
    }
}

print(count)