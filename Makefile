run:
	cd src && love .

clean:
	rm -r build/*

build: build-osx build-linux build-windows

build-osx: build/tetris.love
	# FIXME

build-linux: build/tetris.love
	# FIXME

build-windows: build-win32 build-win64

build-win32: build/tetris.love
	rm -rf build/love-0.9.2-win32 build/tetris-win32

	unzip -q bin/love/love-0.9.2/love-0.9.2-win32.zip -d build/
	mv build/love-0.9.2-win32 build/tetris-win32

	cat build/tetris-win32/love.exe build/tetris.love > build/tetris-win32/tetris.exe
	rm build/tetris-win32/love.exe
	cp -r build/tetris/resources build/tetris-win32/

	jar -cvMf build/tetris-win32.zip -C build tetris-win32

build-win64:
	rm -rf build/love-0.9.2-win64 build/tetris-win64

	unzip -q bin/love/love-0.9.2/love-0.9.2-win64.zip -d build/
	mv build/love-0.9.2-win64 build/tetris-win64

	cat build/tetris-win64/love.exe build/tetris.love > build/tetris-win64/tetris.exe
	rm build/tetris-win64/love.exe
	cp -r build/tetris/resources build/tetris-win32/

	jar -cvMf build/tetris-win64.zip -C build tetris-win64

build/tetris.love: build/tetris.zip
	mv build/tetris.zip build/tetris.love


build/tetris.zip: src/*.lua src/resources/*
	mkdir -p build/tetris

	cp src/*.lua build/tetris
	cp -r src/resources build/tetris

	jar -cvMf build/tetris.zip -C build/tetris .
