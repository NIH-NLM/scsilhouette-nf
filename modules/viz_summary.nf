#!/usr/bin/env nextflow

process viz_summary_process {

    tag 'viz_summary_process'

    publishDir "${params.outdir}", mode: 'copy'
  
    input:
        path silhouette_scores_path
	tuple val(h5ad_ch), val(label_key_ch), val(embedding_key_ch)
        val  score_col
        val  sort_by

    output:
        path("*"), emit: viz_summary_ch

    script:
    """
    scsilhouette viz-summary \\
        --silhouette-score-path $silhouette_scores_path \\
        --label $label_key_ch \\
        --score-col $score_col \\
        --sort-by $sort_by
    """
}


