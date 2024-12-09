# Advanced Searching

## AND Searching

By default queries are parsed as AND searches so a search for `this that` looks for notes that include both `this` and `that`.

## OR Searching

To perform an OR search just separate your search terms using `OR` in UPPERCASE. For example, searching for `this OR that` looks for notes that include either `this` or `that`.

## Search for a Phrase

As mentioned above, searching for `this that` will look for any note that includes both `this` and `that` anywhere in the note. If you want to search for notes where these words are next to each other you can wrap them in quotes i.e. `"this that"`.

## Wildcards

You can use a `?` to represent any single character and a `*` to represent any number of characters.

## Field Searching

There are 4 fields that can be searched:

title
content
tags
last_modified
By default, if you don't specify a field to be searched, `title`, `content` and `tags` are searched. Alternatively you can search specific fields by prefixing the search term with the field name and a semi-colon. Examples:

`title:holiday`
`content:"project plan"`
`tags:personal AND title:holiday`
`tags:work AND project` < This is equivalent to `tags:work AND (title:project OR content:project OR tags:project)`
`last_modified:today`
`last_modified:20220131`
`tags:work AND last_modified:[20220101 to 20220131]`