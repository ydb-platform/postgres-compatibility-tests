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
FROM "asd"."sss" t
USING "kkk" AS base
WHERE`,
			result: `DELETE
FROM asd___sss t
USING "kkk" AS base
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

func TestCutGreenplumSpecific(t *testing.T) {
	table := []struct {
		name string
		from string
		to   string
	}{
		{
			name: "CreateAs",
			from: `create table aaa as
        select *
        from bbb;
`,
			to: `SELECT *
        from bbb;
`,
		},
		{
			name: "CreateAndDistributedBy",
			from: `        CREATE TEMPORARY TABLE t
        AS (
            SELECT DISTINCT b AS ticket_id
            FROM t2 --comment
            WHERE mytime BETWEEN ''2024-04-10 00:00:00''::timestamp AND ''2024-04-30 23:59:59''::timestamp
        ) DISTRIBUTED BY (ticket_id);
`,
			to: `        SELECT DISTINCT b AS ticket_id
            FROM t2 --comment
            WHERE mytime BETWEEN ''2024-04-10 00:00:00''::timestamp AND ''2024-04-30 23:59:59''::timestamp
        ;
`,
		},
		{
			name: "CreateAndDistributedSomething",
			from: `        CREATE TEMPORARY TABLE result_table
            ON COMMIT DROP AS
        SELECT dt AS utc_dt
            , diff_a
            , diff_b
        FROM t
        DISTRIBUTED REPLICATED;
`,
			to: `        SELECT dt AS utc_dt
            , diff_a
            , diff_b
        FROM t
        ;
`,
		},
	}
	for _, test := range table {
		t.Run(test.name, func(t *testing.T) {
			res := cutUnsupportedConstructions(test.from)
			require.Equal(t, test.to, res)
		})
	}
}
