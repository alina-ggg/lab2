import java.util.Scanner // Чтение ввода
//Структура
data class Meeting(val start: Int, val end: Int, val id: Int)

fun main() {
    val sc = Scanner(System.`in`)
    val N = sc.nextInt() // считываем N
    
    val meetings = mutableListOf<Meeting>() // Создание динамического массива

    for (i in 1..N) { // цикл от 1 до N
        val start = sc.nextInt()
        val end = sc.nextInt()
        meetings.add(Meeting(start, end, i))
    }

    val sortedMeetings = meetings.sortedWith(compareBy({ it.end }, { it.start }))
    // sortedWith — когда нужно применить сложное правило (компаратор). Этот метод создает новый — sortedMeetings
    // compareBy — «фабрика» компараторов. Она строит логику сравнения двух встреч.
    // it — означает «текущий объект»
    // Сначала он смотрит на первое правило: { it.end }. Он сравнивает время окончания двух встреч.
    // Если время окончания разное, он сразу расставляет их (кто меньше, тот раньше).
    // Если время окончания одинаковое, он переходит ко второму правилу: { it.start } и сравнивает время начала.
     
    val selectId = mutableListOf<Int>() // Список для Id выбранных встреч
    var freeTime = -1 // var чтобы менять значение

    for (m in sortedMeetings) {
        if (m.start >= freeTime) {
            selectId.add(m.id)
            freeTime = m.end
        }
    }

    print("${selectId.size},")

    // sorted() сортирует ID, joinToString склеивает их в строку через пробел
    val result = selectId.sorted().joinToString(" ")
    println(" $result")
}