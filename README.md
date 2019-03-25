## What is this?

A ruby extention for String class with power of Wordnet Japanese.

```rb
require "./mywn"

"dog".to_jp
#=>
{
  :jpns=>[],
  :synonyms=>
    [
      {
        :eng=>"canis_familiaris",
        :jpn=>[
          "飼い犬", "ドッグ", "犬", "飼犬", "洋犬", "イヌ"]
      },
      {
        :eng=>"frump",
        :jpn=>["お婆ん"]
      },
      {
        :eng=>"hound",
        :jpn=>["卑劣漢"]
      },
      {
        :eng=>"frank",
        :jpn=>[
          "ウインナソーセージ", "フランクフルトソーセージ"
        ]
      },
      ...
```

## Setup

This tools is implemented as a library using sqlite3 and it requires
to install ruby-sqlite3 binding for using wordnet dictionary.
For Ubuntu, install `ruby-sqlite3` package.
You had better to use `pry` if you use mywn in REPL and get
well-formatted result.

```sh
$ sudo apt install ruby-sqlite3
$ sudo gem install pry  # optional
```

Download Wordnet DB file of sqlite3 with rake command.

```sh
$ rake init
```

## How to use

Load this library to make String class have additional attributes
of Wordnet semantics.

```rb
require "./mywn"
```

Now, you are ready to call additional methods of String class.
You can find that an object of String has methods `to_jp`, `to_en`
and started with `wn_`.

```rb
"dog".methods.sort
#=>
[:!, :!=, ...
:to_en, ..., :to_jp, ...,
:wn_also, :wn_ants, :wn_attr, :wn_caus, :wn_dmnc, :wn_dmnr, ...
]
```

`to_en` is for translating word from Japanese to English and `to_jp` is
vise versa.
The rest of methods started with `wn_` are for more lexical analystics.
For instance, `wn_hype` is a method for getting superordinate concept
of a word.

```rb
"dog".wn_hype
#=>
[
  "canid", "domestic_animal", "unpleasant_woman", "blighter", "villain",
  "sausage", "stop", "support", "follow"
]
```

What "canid" is ...

```rb
"canid".to_jp
#=>
{
  :jpns=>[
    ["イヌ科動物"]
  ],
  :synonyms=>[],
  :eng=>"canid",
  :jpn=>["イヌ科動物"]
}
```

## License

Wordnet is released under the MIT License.
