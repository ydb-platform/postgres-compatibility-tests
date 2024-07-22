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

func TestCutGreenplumSpecific(t *testing.T) {
	table := []struct {
		name string
		from string
		to   string
	}{
		{
			name: "CreateAs",
			from: `create table snb_eagle___hex_lavka_orders as
        select *
        from snb_geo_lavka___hex_lavka_orders;
`,
			to: `
        select *
        from snb_geo_lavka___hex_lavka_orders;
`,
		},
		{
			name: "CreateAndDistributedBy",
			from: `        CREATE TEMPORARY TABLE updated_tickets
        AS (
            SELECT DISTINCT chatterbox_ticket_id AS ticket_id
            FROM taxi_cdm_contactcenter___fct_chatterbox_ticket_event --fct_chatterbox_ticket_event
            WHERE utc_event_dttm BETWEEN ''2024-04-10 00:00:00''::timestamp AND ''2024-04-30 23:59:59''::timestamp
        )
            DISTRIBUTED BY (ticket_id);
`,
			to: `        SELECT DISTINCT chatterbox_ticket_id AS ticket_id
            FROM taxi_cdm_contactcenter___fct_chatterbox_ticket_event --fct_chatterbox_ticket_event
            WHERE utc_event_dttm BETWEEN ''2024-04-10 00:00:00''::timestamp AND ''2024-04-30 23:59:59''::timestamp
        ;
`,
		},
	}
	for _, test := range table {
		t.Run(test.name, func(t *testing.T) {
			res := cutGreenplumSpecific(test.from)
			require.Equal(t, test.to, res)
		})
	}
}
