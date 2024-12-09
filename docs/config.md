# Config

## Port

Hardcoded to port 8080 for now.

## FLATNOTES_PATH

The path to the directory in which notes are/should be stored. Defaults to `/data`.

## FLATNOTES_AUTH_TYPE

There are currently 3 types of authentication supported:

`none` - No authentication.
`read_only` - As above but note creation, modification and deletion is disabled.
`password` - A username and password is required to access flatnotes. See `FLATNOTES_USERNAME` and `FLATNOTES_PASSWORD` below.
`totp` - In addition to a username and password, a time based one-time-password is also required to access flatnotes.
Defaults to `password` if not provided.

### totp

To use the `totp` authentication type you will also need to supply a `FLATNOTES_TOTP_KEY` (see below). Upon startup, flatnotes will print a QR code which can be used to add flatnotes to an authentication app such as Authy or Google Authenticator. Docker users can view this QR code by looking at the containers logs e.g. `docker logs flatnotes`.

If for any reason you are unable to scan the QR code, you can also manually enter the secret key into your authentication app. This will be printed underneath the QR code in the logs.

When using the API with totp enabled, you'll need to append the current totp code to your password (e.g. `changeMe!123456`) when calling the `/api/token` endpoint.

## FLATNOTES_USERNAME & FLATNOTES_PASSWORD

The username and password used to access flatnotes.

Required when `FLATNOTES_AUTH_TYPE` is set to `password` or `totp`. Not applicable when `FLATNOTES_AUTH_TYPE` is set to `none` or `read_only`.

## FLATNOTES_SECRET_KEY

The secret key used to generate access tokens. Changing this will invalidate all existing access tokens.

I recommend using a password generator to generate random 32 character string.

Required when `FLATNOTES_AUTH_TYPE` is set to `password` or `totp`. Not applicable when `FLATNOTES_AUTH_TYPE` is set to `none` or `read_only`.

## FLATNOTES_SESSION_EXPIRY_DAYS

Defines how many days an access token is valid for (before a username, password and (possibly) a totp code is required to login again).

Defaults to `30` if not provided.

## FLATNOTES_TOTP_KEY

The secret key used to generate totp codes. Changing this will invalidate the totp configuration.

I recommend using a password generator to generate random 32 character string.

Required when `FLATNOTES_AUTH_TYPE` is `totp`. Not applicable for other authentication types.

## FLATNOTES_PATH_PREFIX

Useful if you want to host flatnotes at a sub-path on your domain (e.g. www.example.com/flatnotes).

Value must start with a `/` but not end with one e.g. `/flatnotes`.

Defaults to no prefix if not provided.

## FLATNOTES_QUICK_ACCESS_HIDE

If set to `true`, hides the quick access notes on the home page.

Defaults to `false` (show quick access notes).

Note: This replaced the now deprecated `FLATNOTES_HIDE_RECENTLY_MODIFIED` environment variable.

## FLATNOTES_QUICK_ACCESS_TITLE

The title of the quick access notes section.

Defaults to `RECENTLY MODIFIED`.

## FLATNOTES_QUICK_ACCESS_TERM

The search term that defines which notes to show in the quick access notes section.

A good example is to set this to `#pinned` to show only notes that include the "#pinned" tag or `NOT tags:work` to exclude notes tagged with "#work".

Defaults to `*`.

## FLATNOTES_QUICK_ACCESS_SORT

The field by which to order the quick access notes section.

Value must be one of `score`, `title`, `lastModified`.

Defaults to `lastModified`.

## FLATNOTES_QUICK_ACCESS_LIMIT

The maximum number of notes to show in the quick access notes section.

Defaults to `4`.