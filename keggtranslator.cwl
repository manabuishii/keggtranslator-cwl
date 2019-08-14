cwlVersion: v1.0
class: CommandLineTool
requirements:
    DockerRequirement:
        dockerPull: keggtranslator:2.5
# 実行するコマンド
baseCommand: [java, -jar, /KEGGtranslator_v2.5.jar]
# 引数、入力ファイルと出力ファイルを指定する
arguments:
    - --input
    - $(inputs.input)
    -  --output
    - $(inputs.output_name)
inputs:
    input: # xml
        type: File
        label: KGML # (ex. wget -O eco00020.xml http://rest.kegg.jp/get/eco00020/kgml)
        doc: Path and name of the source, KGML formatted, XML-file. Akzeptiert kGML-Dateien (*.xml).
    output_name:
        type: string
        label: Name of the output file
        doc: String for the output file name
    format:
        type: 
            type: enum
            symbols:
              - SBML
              - SBML_L2V4
              - SBML_L3V1
              - SBML_QUAL
              - SBML_CORE_AND_QUAL
              - SBGN
              - BioPAX_level2
              - BioPAX_level3
              - SIF
              - GraphML
              - GML
              - JPG
              - GIF
              - TGF
              - YGF
        default: SBML # --format オプションが指定されない場合、SBMLで実行される
        inputBinding:
            prefix: --format
        doc: Target file format for the translation.
# 出力ファイルを回収する。
outputs:
    output:
        type: File
        outputBinding:
            glob: $(inputs.output_name)
