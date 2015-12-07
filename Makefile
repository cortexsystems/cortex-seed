lint:
	./node_modules/.bin/coffeelint src

dep:
	npm install

dist:
	gulp pack

clean:
	rm -rf ./build ./dist

.PHONY: doc
