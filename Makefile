BUILD_NUMBER ?= dev+$(shell date -u '+%Y%m%d%H%M%S')
GO111MODULE = on
export GO111MODULE

LDFLAGS = -w -s -X main.Build=$(BUILD_NUMBER)
BINARY_NAME=bonk

ALL = linux-amd64

bin:
	go build -ldflags "$(LDFLAGS)"

build:
	mkdir -p bin/
	rm ./bin/*
	GOARCH=amd64 GOOS=linux go build -ldflags "$(LDFLAGS)" -o bin/$(BINARY_NAME)-linux .
	GOARCH=arm GOOS=linux go build -ldflags "$(LDFLAGS)" -o bin/$(BINARY_NAME)-linux .


# test:
# 	go test -v

# test-cov-html:
# 	go test -coverprofile=coverage.out
# 	go tool cover -html=coverage.out

# bench:
# 	go test -bench=.

# bench-cpu:
# 	go test -bench=. -benchtime=5s -cpuprofile=cpu.pprof
# 	go tool pprof go-audit.test cpu.pprof

# bench-cpu-long:
# 	go test -bench=. -benchtime=60s -cpuprofile=cpu.pprof
# 	go tool pprof go-audit.test cpu.pprof

# release: $(ALL:%=build/go-audit-%.tar.gz)

# build/%/go-audit: .FORCE
# 	GOOS=$(firstword $(subst -, , $*)) \
# 		GOARCH=$(word 2, $(subst -, ,$*)) \
# 		go build -trimpath -ldflags "$(LDFLAGS)" -o $@ .

# build/go-audit-%.tar.gz: build/%/go-audit
# 	tar -zcv -C build/$* -f $@ go-audit

# .FORCE:
# .PHONY: test test-cov-html bench bench-cpu bench-cpu-long bin release
# .DEFAULT_GOAL := bin
