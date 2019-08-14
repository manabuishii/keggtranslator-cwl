[![CircleCI](https://circleci.com/gh/manabuishii/keggtranslator-cwl.svg?style=svg)](https://circleci.com/gh/manabuishii/keggtranslator-cwl)

# この文書は

- [KEGGtranslator](http://www.cogsys.cs.uni-tuebingen.de/software/KEGGtranslator/doc/index.html) 化の方法をのべています
  - KEGGからSBMLのコンバート
    - [KEGG: Kyoto Encyclopedia of Genes and Genomes](https://www.kegg.jp/)
    - [Main Page \- SBML\.caltech\.edu](http://sbml.org/Main_Page)
    - [SBML \- Wikipedia](https://en.wikipedia.org/wiki/SBML)

# Docker のインストールについて

- [Get Docker Engine \- Community for Ubuntu \| Docker Documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

# KEGGtranslatorの使い方

```
To use the command-line capabilities, please use the following syntax:
java -jar KEGGtranslator.jar --version
java -jar KEGGtranslator.jar --input [in_file.xml] --output [out_file] --format [out_format]
```

# KGMLの取得方法 (入力に使うファイル)
hsa05130 (Pathogenic Escherichia coli infection - Homo sapiens (human)) というpathwayの場合

```console
$ wget -O eco00020.xml http://rest.kegg.jp/get/eco00020/kgml
```

# cwl のインストールについて

今日は、python3 とvenvを使いました。

環境は

```console
$ python3 -m venv wfenv
```

activate する。

```console
$ source wfenv/bin/activate
```

cwltool をインストールする。
今回はlatestを使うことにした。

```console
$ apt install -y build-essential
$ pip3 install -U pip wheel setuptools  # これしてからのほうが早いパターンあります(あと時々落ちることも)
$ pip3 install cwltool
```

# コンテナがあるかを調べる

[BioContainers Community](https://biocontainers.pro/#/registry)

ここで、 `KEGGtranslator` と入れて調べる。

結果ない。

# 作業予定項目
- コンテナ作成
- CWL ファイル作成
- テストを書く

# コンテナを作る

build した。

```console
$ docker build -t keggtranslator:2.5.0 .
```

## コンテナの動作確認(バージョン)

```console
$ docker run --rm -v $PWD/workdir:/workdir --workdir=/workdir --name wfuserkeggtrans1 keggtranslator:2.5.0 java -jar /KEGGtranslator_v2.5.jar --version
```

```console
$ docker run --rm -v $PWD/workdir:/workdir --workdir=/workdir --name wfuserkeggtrans1 keggtranslator:2.5.0 java -jar /KEGGtranslator_v2.5.jar --input /workdir/eco00020.xml --output /workdir/eco00020.output.xml --format SBML
```

# CWL化

- 雑方式

# テストを書く

- `cwltest` をインストールする
- テスト用のデータを `data` におく
- cwltest用のファイルをつくる。  `test.yml`
  - 書き方がわからないときは、conformance test からもってくる
  - またはこのレポジトリにある `test.yml`
- パラメータファイルを作る

# cwltestをインストールする

```console
$ pip3 install cwltest
```

# テスト用データを data に置く

```console
$ wget -O data/eco00020.xml http://rest.kegg.jp/get/eco00020/kgml
```

# 実行する

```console
$ cwltest --test test.yml
```

# cwltest用のファイルをつくる。  `test.yml`

今回は、実行するたびに、生成されるファイルの内容がかわることがわかり
- チェックサム
- ファイルサイズ
の２つのチェックは行わなかった。


# ローカルで CircleCI を動かす



```console
$ circleci local execute --job buildlocal
```

# 参考リンク
- [雑に始める CWL！](https://qiita.com/tm_tn/items/4956f5ca523f7f49f386)
