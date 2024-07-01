package internal

type SessionLogRecord struct {
	ProcessID          int    `json:"pid"`
	SessionID          int    `json:"sess_id"`
	QueryCount         int    `json:"query_count"`
	Query              string `json:"query"`
	TransactionCount   int    `json:"transaction_count"`
	TransactionSuccess bool   `json:"transaction_success"`
}

type Session struct {
	ID           string
	Success      bool
	Transactions []Transaction
}

type Transaction struct {
	Number  int
	Success bool
	Queries []Query
}

type Query struct {
	Number int
	Text   string
}
