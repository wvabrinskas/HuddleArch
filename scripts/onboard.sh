#/bin/bash

echo "Moving templates over"
cd scripts/
cp -r ./Module.xctemplate ~/Library/Developer/Xcode/Templates/
cp -r ./ModuleHolder.xctemplate ~/Library/Developer/Xcode/Templates/