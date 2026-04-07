package main

import (
	"fmt"
	"sort"
)

type Meeting struct {
	start int
	end   int
	id    int
}

func main() {
	var N int
	fmt.Scan(&N)
	meetings := make([]Meeting, N) // Создается срез из N элементов

	for i := 0; i < N; i++ {
		fmt.Scan(&meetings[i].start, &meetings[i].end)
		meetings[i].id = i + 1
	}

	// Сортировка для среза, пишем правило сравнения
	sort.SliceStable(meetings, func(i, j int) bool {
		if meetings[i].end != meetings[j].end {
			return meetings[i].end < meetings[j].end
		}
		return meetings[i].start < meetings[j].start
	})

	var selectId []int // Пустой массив для ID выбранных встреч
	freeTime := -1

	for i := 0; i < N; i++ {
		if meetings[i].start >= freeTime {
			selectId = append(selectId, meetings[i].id)
			freeTime = meetings[i].end
		}
	}

	fmt.Print(len(selectId), ",")

	// Сортировка по возрастанию
	sort.Ints(selectId)

	// Добавление пробела
	for _, id := range selectId {
		fmt.Printf(" %d", id)
	}
	fmt.Println() // Перенос строки
}
