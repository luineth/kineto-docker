# kineto

This is an [HTTP][http] to [Gemini][gemini] proxy designed to provide service
for a single domain, i.e. to make your Gemini site available over HTTP. It
can proxy to any domain in order to facilitate linking to the rest of
Geminispace, but it defaults to a specific domain.

[http]: https://en.wikipedia.org/wiki/Hypertext_Transfer_Protocol
[gemini]: https://geminiprotocol.net/

## Usage

```
$ go build
$ ./kineto [-P] [-b 127.0.0.1:8080] [-s style.css] [-e style.css] gemini://example.org
```

The -P argument is optional and allows you to completely disable proxying
and URL rewriting external gemini URLs. The user visiting your site will need
to have a browser or browser extension that understands how to handle
gemini:// links.

The -b argument is optional and allows you to bind to an arbitrary address; by
default kineto will bind to `:8080`. You should set up some external reverse
proxy like nginx to forward traffic to this port and add TLS.

The -s argument is optional and allows you to specify a custom CSS filename.
The given file will be loaded from the local disk and placed in a `<style>`
block. By default kineto will serve its built-in style.

The -e argument is optional and allows you to specify a custom CSS URL. If
provided, the style.css given will be treated as a link to be put in the href
of a `<link rel="stylesheet"...>` instead of being placed inline with the body
in a `<style>` block like with the -s flag. The given stylesheet can be a
relative link, for instance `-e /main.css` will serve `main.css` from the root
of the proxied Gemini capsule.

## "kineto"?

It's named after the Contraves-Goerz Kineto Tracking Mount, which is used by
NASA to watch rockets as they ascend to orbit.

![](https://l.sr.ht/_frS.jpeg)
