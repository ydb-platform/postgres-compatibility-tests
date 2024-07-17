package cmd

import (
	"strconv"
	"testing"

	"github.com/stretchr/testify/require"
)

func TestFixSchemaName(t *testing.T) {
	table := []struct {
		from   string
		result string
	}{
		{
			from: `DELETE
FROM "eda_dds_partner"."a__item__item_name__h2" t
USING "for_delete_extend" AS base
WHERE`,
			result: `DELETE
FROM eda_dds_partner___a__item__item_name__h2 t
USING "for_delete_extend" AS base
WHERE`,
		},
	}

	for i, test := range table {
		t.Run(strconv.Itoa(i), func(t *testing.T) {
			res := fixSchemaNames(test.from)
			require.Equal(t, test.result, res)
		})
	}
}
