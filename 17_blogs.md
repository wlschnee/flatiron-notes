Regex
-----
@kevin.r.webster on Medium

#### Common Methods

##### .match

- The most common method, evaluates whether there is a match between a pattern and a string

- Returns a MatchData object with lots of methods

##### =~

- Can be used to match a string against a regular expression.
- Returns the starting position of the match, otherwise returns `nil`

##### .scan() & .split()

- Both string methods. Scan will collect all matches into an array
- Split collects all strings that do not match the regex

#### Special Characters

`.match(/\?/)`

Special characters that require escaping (use `\` to escape):

`^, $, ?, ., /, \, [ ], { }, ( ), +, *`
