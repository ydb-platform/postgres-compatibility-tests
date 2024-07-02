package cmd

func must0(err error) {
	if err != nil {
		panic(err)
	}
}

func must[R any](res R, err error) R {
	must0(err)
	return res
}
