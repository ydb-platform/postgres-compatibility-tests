package internal

import (
	"cmp"
	"slices"
)

func GetSortedKeys[K cmp.Ordered, V any](m map[K]V) []K {
	keys := make([]K, 0, len(m))
	for k := range m {
		keys = append(keys, k)
	}

	slices.Sort(keys)
	return keys
}
