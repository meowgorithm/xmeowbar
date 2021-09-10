.PHONY: install restart

install:
	cabal install -j32 --overwrite-policy=always

restart: install
	$(HOME)/.xmonad/xmonad-x86_64-linux --restart
