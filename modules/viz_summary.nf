#!/usr/bin/env nextflow

process viz_summary_process {

    tag 'viz_summary_process'

    publishDir "${params.outdir}", mode: 'copy'
  
    input:
        path silhouette_scores_path
	tuple val(h5ad_ch), val(label_key_ch), val(embedding_key_ch)

    output:
        path("*"), emit: viz_summary_ch

    script:
    """
    /opt/conda/bin/scsilhouette viz-summary \\
        --silhouette-score-path $silhouette_scores_path \\
        --silhouette-score-col $params.silhouette_score \\
        --label-key $label_key_ch
    """
}


