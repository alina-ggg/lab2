package main

import "fmt"

func allSymvl(str string, t string) bool {
	var count [128]int

	for i := 0; i < len(str); i++ {
		c := str[i]
		count[c]++
	}

	for i := 0; i < len(t); i++ {
		c := t[i]
		count[c]--
		if count[c] < 0 {
			return false
		}
	}
	return true
}

func minStr(s string, t string) string {
	if len(t) > len(s) {
		return "Не найдено"
	}
	result := ""
	minLen := len(s) + 1

	for i := 0; i < len(s); i++ {
		for j := i; j < len(s); j++ {
			str := s[i : j+1]

			if allSymvl(str, t) {
				if len(str) < minLen {
					minLen = len(str)
					result = str
				}
				break
			}
		}
	}
	if len(result) == 0 {
		return "Не найдено"
	}
	return result
}

func main() {
	var s, t string
	fmt.Scan(&s)
	fmt.Scan(&t)
	fmt.Println(minStr(s, t))
}
