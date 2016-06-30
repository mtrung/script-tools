#!/bin/bash
# Assume your code is in lambda folder
# $1 (optional): zip filename you want to archive. Use index.zip if not provided.

# must change to yours
function_name=your-lambda-function-name

zip_filename=index.zip
rm *.zip
cd lambda

# cannot use zip -j due name in zip file repeated
zip -r ../$zip_filename * -X -i \*.js \*.json -x *test* *example*
# you can add more exclude pattern such as *browser*
# zip -r ../$zip_filename * -X -i \*.js \*.json -x *test* *example* *browser*

cd ..
aws lambda update-function-code --function-name $function_name --zip-file fileb://$zip_filename

if [ -n "$1" ]; then
	mv $zip_filename $1.zip
	echo "=> $1.zip"
fi
