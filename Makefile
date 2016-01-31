serve: install
	bundle exec jekyll serve

build site: install
	bundle exec jekyll build

install:
	bundle check || bundle install

upload: build
	aws s3 --region us-west-2 cp --recursive _site/ s3://gibbsdevops.com/
