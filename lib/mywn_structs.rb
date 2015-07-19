
MyWord = Struct.new(
  "MyWord",
  :wordid,  # 単語ID
  :lang,    # eng or jpn
  :lemma,   # 見出し語
  :pron,    # 発音
  :pos,     # 品詞
  :synsets  # 類義語
)

MySynset = Struct.new(
  "MySynset",
  :pos,     # 品詞
  :name,
  :def,
  :name_jp
)

Word = Struct.new(
  "Word",
  :wordid,
  :lang,
  :lemma,
  :pron,    # 発音
  :pos     # 品詞
)

Sense = Struct.new(
  "Sense",
  :synset,
  :wordid,
  :lang,
  :rank,
  :lexid,
  :freq,
  :src
)

Synset = Struct.new(
  "Synset",
  :synset,
  :pos,     # 品詞
  :name,
  :src
)

SynLink = Struct.new(
  "SynLink",
  :synset1,
  :synset2,
  :link,
  :src
)

