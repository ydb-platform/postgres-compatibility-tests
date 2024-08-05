package internal

import (
	"context"
	"log"
	"sync"

	"github.com/ydb-platform/ydb-go-sdk/v3"
)

type YdbPool struct {
	m       sync.Mutex
	drivers []driverInflight
}

type driverInflight struct {
	driver   *ydb.Driver
	inflyght int
}

func OpenYdbPool(ctx context.Context, connectionStrings []string, options []ydb.Option) *YdbPool {
	var m sync.Mutex
	drivers := make([]*ydb.Driver, 0, len(connectionStrings))

	var wg sync.WaitGroup
	for i := range connectionStrings {
		cs := connectionStrings[i]
		wg.Add(1)
		go func() {
			defer wg.Done()

			driver, err := ydb.Open(ctx, cs, options...)
			if err == nil {
				m.Lock()
				drivers = append(drivers, driver)
				m.Unlock()
			} else {
				log.Printf("Failed connection to %q: %v", cs, err)
			}
		}()
	}
	wg.Wait()

	if len(drivers) == 0 {
		log.Fatalf("failed to connect for all endpoints")
	}

	return NewYdbPool(drivers)
}

func NewYdbPool(drivers []*ydb.Driver) *YdbPool {
	if len(drivers) == 0 {
		panic("can't create pool without drivers")
	}
	res := &YdbPool{
		drivers: make([]driverInflight, len(drivers)),
	}
	for i, driver := range drivers {
		res.drivers[i] = driverInflight{
			driver:   driver,
			inflyght: 0,
		}
	}
	return res
}

// Get return driver with minimal current inflight
func (p *YdbPool) Get() *ydb.Driver {
	p.m.Lock()
	defer p.m.Unlock()

	minInflyght := &p.drivers[0]
	for i := range p.drivers {
		if p.drivers[i].inflyght < minInflyght.inflyght {
			minInflyght = &p.drivers[i]
		}
	}

	minInflyght.inflyght++
	return minInflyght.driver
}

func (p *YdbPool) Release(driver *ydb.Driver) {
	p.m.Lock()
	defer p.m.Unlock()

	for i := range p.drivers {
		if p.drivers[i].driver == driver {
			p.drivers[i].inflyght--
			if p.drivers[i].inflyght < 0 {
				panic("the ydb driver released more times, then get")
			}
			return
		}
	}

	panic("the driver doesn't exists in the pool")
}
