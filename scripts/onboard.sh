#/bin/bash

echo "Moving templates over"
cd scripts/

echo "Copying all templates from current directory to Xcode Templates folder"
for template in *.xctemplate; do
    if [ -d "$template" ]; then
        echo "Copying $template"
        cp -r "$template" ~/Library/Developer/Xcode/Templates/
    fi
done
