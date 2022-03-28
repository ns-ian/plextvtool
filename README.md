# plextvtool
A gem for formatting TV episode filenames for use with Plex Media Server.

### Installation and usage
Install the gem from your shell:
```
$ gem install plextvtool
```

To use the gem, you must first supply an OMDB API key, which can be [generated for free](https://www.omdbapi.com/apikey.aspx).
```
$ plextvtool config --key <YOUR API KEY>
```

Reformatting your filenames:
```
$ plextvtool fix <DIR> --title <SHOW TITLE> --season <SEASON>
```
Where `<DIR>` is the directory where your files live. The major caveats of this tool are the assumptions that 1) your directory contains only a single season's episodes, and 2) that the filenames are sortable such that the first lexicographically ordered file corresponds with the first episode of the season, and so on.

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### License

This project is released under the [MIT License](http://www.opensource.org/licenses/MIT).
