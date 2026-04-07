package main

import (
	"fmt"
)

func main() {
	var N int
	fmt.Scan(&N)
	if N <= 1 {
		fmt.Println(0)
		return
	}

	var now int
	var last int
	count := 0

	fmt.Scan(&last)

	for i := 0; i < N-1; i++ {
		fmt.Scan(&now)

		if now == last {
			count++
		}
		last = now
	}
	fmt.Println(count)
}
