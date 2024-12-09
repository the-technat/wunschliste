# FAQs

## Where is the database?

There is no database, only a single folder of markdown files (and the .flatnotes sub-folder).

## What is the .flatnotes sub-folder for?

This stores a full text index of your note content allowing for rapid search times.

## Can I delete the .flatnotes sub-folder?

As long as flatnotes isn't running, sure! It'll just get rebuilt then next time flatnotes is run.

## Can I add, edit & delete the markdown files outside of flatnotes?

Yup. The only thing flatnotes caches is the search index and that's synced on every search (and when flatnotes first starts).

## Can I perform advanced searches?

Yes! See the [Advanced Searching](advanced_searching.md) wiki page.

## How do I get my notes out of flatnotes?

They're just markdown files. You're free to just move the files elsewhere and use another app.

## Is there an API?

Yes. The docs are available at the `/docs` endpoint.

## If there aren't any folders, how to I organise my notes?

The first option is to choose not to. This frees you from the burden of organisation. You can then rely on flatnotes' powerful search functionality to find the note you are looking for. Just think, the internet isn't neatly organised into folders and yet it's still easy to find what you're looking for.

Additionally, you are able to tag notes by using a hashtag anywhere in the note content e.g. #work. Tags are indexed separately from the rest of the content and so can be searched separately either by using the field prefix e.g. "tags:work" or using the hashtag shortcut e.g. "#work".

## What types of authentication are supported?

There are 4 types:

None = No authentication, the site is open to anyone with access.
Read Only = As above but note creation, modification and deletion is disabled. Useful if you want to use flatnotes as a blog or for documentation.
Password = The site is protected by a username and password.
TOTP = In addition to a username and password, the site is also protected by a time-based one-time-password.
See the [Environment Variables](config.md) article in the wiki for more information.

## Is there a mode whereby notes can be read by anyone but only created, modified or deleted by an authenticated user?

There isn't a single authentication mode for this but there's nothing stopping you from running 2 instances of flatnotes on the same directory of notes. One could be in Password/TOTP mode and the other in Read Only mode.

## What file extensions are supported?

flatnotes will store all new notes with the extension `.md`. For any existing files to be picked up by flatnotes they also need to use the extension `.md`. See [#50](https://github.com/Dullage/flatnotes/issues/50) for further detail.

## How can I link to other notes?

The easiest way is to use wikilink-styled links. To do this simply reference the note name in double square brackets e.g. `[[My Note]]` will render a link to a note called "My Note".