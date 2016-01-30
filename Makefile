serve: install
	bundle exec jekyll serve

build: install
	bundle exec jekyll build

install:
	bundle check || bundle install
