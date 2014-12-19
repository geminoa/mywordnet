require 'rubygems'
require 'sqlite3'

class String
  $SQLITE3_DB = File.dirname(__FILE__) + "/wnjpn.db"

  MyWord = Struct.new(
    "MyWord",
    :wordid,  # 単語ID
    :lang,    # eng or jpn
    :lemma,   # 見出し語
    :pron,    # 発音
    :pos,     # 品詞
    :synsets 
  )

  MySynset = Struct.new(
    "MySynset",
    :pos,
    :name,
    :def,
    :name_jp
  )

  Word = Struct.new(
    "Word",
    :wordid,
    :lang,
    :lemma,
    :pron,
    :pos
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
    :pos,
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

  # 英語から日本語への変換
  # 元の英語、日本語訳、類義語を返す
  # # 結果の構造
  #     {
  #       eng: "Japanese",
  #       jpn: ["日本語の意味1", "日本語の意味2",...],
  #       jpns: [
  #         ["日本語の意味1", "日本語の意味2", ...] ,
  #         ...
  #       ],
  #       synonyms: [ 
  #         {eng: "one", jpn: ["一", "いち", ...]},
  #         {eng: "two", jpn: ["二", "に", ...]},
  #         ...
  #       ]
  #     }   
  def to_jpn
    ret_hash = {}
    ret_hash[:jpns] = []
    ret_hash[:synonyms] = []
    get_mywords(self).each do |myword|
      #MyWord#wordidからsynsetを取得し、synsetごとに日本語を取得する
      get_synset_from_sense(wordid=myword.wordid).each do |syns|
        # synsetから同義語を取得する
        @conn.execute("select synset, name from synset where synset=?", syns[0]).each do |sos|
          word_hash = {}
          word_hash[:eng] = sos[1]
          tmp_jpn_ary = []
          # 英語から日本語を取得
          get_sense_in_jpn(synset=sos[0]).each do |sen|
            words_jp = @conn.execute("select * from word where wordid=?", sen[1])
            tmp_jpn_ary << words_jp[0][2]
          end
          word_hash[:jpn] = tmp_jpn_ary

          if sos[1] == self  # 元の単語の場合
            ret_hash[:eng] = myword.lemma 
            ret_hash[:jpns] << word_hash[:jpn] if word_hash[:jpn].size > 0  # synsetで異なる
            ret_hash[:jpn] = ret_hash[:jpns].flatten.uniq  # 全てのsynsetをまとめて格納
          else  # 同義語の場合
            ret_hash[:synonyms] << word_hash
          end
        end
      end
    end
    return ret_hash
  end

  # 日本語から英語への変換
  # # 結果の構造
  #     {
  #       jpn: "日本語",
  #       eng: ["Japanese1", "Japanese2", ...],
  #       engs: [
  #         ["word1", "word2", ...] ,
  #         ...
  #       ],
  #       synonyms: [ 
  #         {jpn: "いち", :eng: ["one", ...]},
  #         {jpn: "に"}, :eng: ["two", ...]},
  #         ...
  #       ]
  #     }   
  def to_eng
    ret_hash = {}
    ret_hash[:eng] = []
    ret_hash[:engs] = []
    ret_hash[:synonyms] = []
    get_mywords(self).each do |myword|
      #MyWord#wordidからsynsetを取得し、synsetごとに英語を取得する
      get_synset_from_sense(wordid=myword.wordid).each do |syns|
        @conn.execute("select synset, name from synset where synset=?", syns[0]).each do |sos|
          tmp_hash = {:synset => nil, :eng => [], :jpn => []}
          tmp_hash[:synset] = sos[0]
          @conn.execute("select * from sense where synset='#{sos[0]}'").each do |sns|
            @conn.execute("select * from word where wordid=#{sns[1]}").each{|w|
              if w[1] == "eng"
                tmp_hash[:eng] << w[2]
              else
                tmp_hash[:jpn] << w[2]
              end
            }
          end

          tmp_hash[:eng].each do |e|
            ret_hash[:eng] << e
          end
          ret_hash[:engs] << tmp_hash[:eng].dup

          # 同義語を返り値に格納する
          tmp_hash[:jpn].each do |j|
            if self != j
              tmp = {}
              tmp[:jpn] = j
              tmp[:eng] = tmp_hash[:eng].dup
              ret_hash[:synonyms] << tmp
            end
          end
        end
      end
    end
    ret_hash[:jpn] = self
    ret_hash[:eng].uniq!
    ret_hash[:engs].uniq!
    return ret_hash
  end

  # link_def "See also".
  def wn_also
    get_link(link='also')
  end

  # link_def "Synonyms".
  def wn_syns
    get_link(link='syns')
  end

  # link_def "Hypernyms".
  def wn_hype
    get_link(link='hype')
  end

  # link_def "Instances".
  def wn_inst
    get_link(link='inst')
  end

  # link_def "Hyponyms".
  def wn_hypo
    get_link(link='hypo')
  end

  # link_def "Has Instance".
  def wn_hasi
    get_link(link='hasi')
  end

  # link_def "Meronyms".
  def wn_mero
    get_link(link='mero')
  end

  # link_def "Meronyms --- Member".
  def wn_mmem
    get_link(link='mmem')
  end

  # link_def "Meronyms --- Substance".
  def wn_msub
    get_link(link='msub')
  end

  # link_def "Meronyms -- Part".
  def wn_mprt
    get_link(link='mprt')
  end

  # link_def "Holonyms".
  def wn_holo
    get_link(link='holo')
  end

  # link_def "Holonyms -- Member".
  def wn_hmem
    get_link(link='hmem')
  end

  # link_def "Holonyms -- Substance".
  def wn_hsub
    get_link(link='hsub')
  end

  # link_def "Holonyms -- Part".
  def wn_hprt
    get_link(link='hprt')
  end

  # link_def "Attributes".
  def wn_attr
    get_link(link='attr')
  end

  # link_def "Similar to".
  def wn_sim
    get_link(link='sim')
  end

  # link_def "Entails".
  def wn_enta
    get_link(link='enta')
  end

  # link_def "Causes".
  def wn_caus
    get_link(link='caus')
  end

  # link_def "Domain --- Category".
  def wn_dmnc
    get_link(link='dmnc')
  end

  # link_def "Domain --- Usage".
  def wn_dmnu
    get_link(link='dmnu')
  end

  # link_def "Domain --- Region".
  def wn_dmnr
    get_link(link='dmnr')
  end

  # link_def "In Domain --- Category".
  def wn_dmtc
    get_link(link='dmtc')
  end

  # link_def "In Domain --- Usage".
  def wn_dmtu
    get_link(link='dmtu')
  end

  # link_def "In Domain --- Region".
  def wn_dmtr
    get_link(link='dmtr')
  end

  # link_def "Antonyms".
  def wn_ants
    get_link(link='ants')
  end

  #
  # Wordnetのversionを返す
  # 単語数にてversionを判定
  #
  def wn_version
    version_info = [
      {:ver => 1.1,  :words => 249121},
      {:ver => 1.0,  :words => 247528},
      {:ver => 0.92, :words => 242420},
      {:ver => 0.91, :words => 243433},
      {:ver => 0.90, :words => 241253}
    ]

    # 単語数を取得
    if !@conn
      connect_db
    end
    cnt = nil
    @conn.execute("select count(*) from word") {|r|
      cnt = r[0]
    }

    version_info.each do |ent|
      p cnt, ent
      if (cnt == ent[:words])
        return ent[:ver] 
      end
    end
    return "unknown"
  end

  private
  def connect_db()
    dbfile = $SQLITE3_DB
    @conn = SQLite3::Database.new(dbfile)
    return nil
  end

  # lemma(該当単語)から単語の情報を取得し、MyWordの配列として返す
  def get_mywords(lemma)
    if !@conn
      connect_db
    end
    my_words = []
    @conn.execute("select * from word where lemma=?",lemma).map{|row|
      mwd = MyWord.new
      mwd.wordid = row[0]
      mwd.lang = row[1]
      mwd.lemma = row[2]
      mwd.pron = row[3]
      mwd.pos = row[4]
      mwd.synsets = []
      my_words << mwd
    }
    return my_words
  end

  def get_mysynset(synset)
    if !@conn
      connect_db
    end
    row = @conn.get_first_row("select * from synset where synset=?",synset)
    msy = MySynset.new
    msy.pos = row[1]
    msy.name = row[2]
    msy.def = get_syn_def(synset)
    mysense = get_sense(synset)
    if mysense
      name_jp = get_word(mysense.wordid).lemma
      msy.name_jp = name_jp if name_jp
    end
    return msy
  end

  # Get synset which matches wordid.
  def get_synset_from_sense(wordid=nil)
    if wordid
      return @conn.execute("select synset from sense where wordid=?", wordid)
    end
    return []
  end

  def get_sense_in_jpn(synset=nil)
    if synset
      return @conn.execute("select * from sense where synset=? and lang=?", synset, 'jpn')
    end
    return []
  end

  def get_sense_in_eng(synset=nil)
    if synset
      return @conn.execute("select * from sense where synset=? and lang=?", synset, 'eng')
    end
    return []
  end

  def get_link(link='hype')
    ret_ary = []
    get_mywords(self).each do |myword|
      get_synset_from_sense(wordid=myword.wordid).each do |syns|
        @conn.execute("select synset, name from synset where synset=?", syns[0]).each do |sos|
          word_ary = [sos[1]]
          get_synlink(sos[0], link).each do |synlink|
            @conn.execute("select name from synset where synset=?", synlink[0]).each do |name|
              ret_ary << name[0]
            end
          end	
        end
      end
    end
    if ret_ary.size > 0
      return ret_ary
    end
    return [] 
  end

  def get_synlink(synset1=nil, link='hype')
    if synset1
      return @conn.execute("select synset2 from synlink where synset1=? and link=?", synset1, link)
    end
    return []
  end

  def get_syn_def(synset)
    @conn.execute("select def from synset_def where synset=?",synset)[0][0]
  end
end
