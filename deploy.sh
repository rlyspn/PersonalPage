#!/bin/bash

# Author: Riley Spahn
# Date: June, 2014

# The tile of the webpage
TITLE="Riley Spahn"

# Script files that will be used in the webpage.
SCRIPT_FILE="analytics.js"

# CSS Files
STYLE="style.css"

# Directory of markdown pages.
INPUT_DIR="pages"

# Directory where the webpages are placed
OUTPUT_DIR="site"

# Assets Directory
ASSET_DIR="assets"

# Markdown Command
MARKDOWN=markdown_py

# Creates the header of the file including 
create_header() {
    echo "<html><head><title>$TITLE</title><style>" > $1
    cat $STYLE >> $1
    echo "</style></head>" >> $1
}

# Create the footer with scripts.
create_footer() {
    echo '<script type="text/javascript">' >> $1
    cat $SCRIPT_FILE >> $1
    echo '</script>' >> $1
}

handle_assets() {
    cp -r $ASSET_DIR $1
}

for i in $( ls -1 pages | grep "md$"); do
    echo "Processing $i."
    input="$INPUT_DIR/$i"
    output="$OUTPUT_DIR/$(echo $i | sed s/md$/html/g)"
    create_header $output
    echo "output = $output"
    $MARKDOWN $input >> $output
    create_footer $output
    echo "</html>" >> $output
done
handle_assets $OUTPUT_DIR
