#!/usr/bin/env nextflow

process viz_distribution_process {

    tag 'viz_distribution_process'

    publishDir "${params.outdir}", mode: 'copy'

    input:
        path silhouette_scores_path
	val  label

    output:
        path ("*"), emit: viz_distribution_ch

    script:
    """
    scsilhouette viz-distribution \\
    --silhouette-score-path ${silhouette_scores_path} \\
    --label ${label}
    """
}

