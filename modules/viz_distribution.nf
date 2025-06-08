#!/usr/bin/env nextflow

process viz_distribution_process {

    tag 'viz_distribution_process'

    publishDir "${params.outdir}", mode: 'copy'

    input:
        path cluster_summary_path
	tuple val(h5ad_ch), val(label_key_ch), val(embedding_key_ch)

    output:
        path ("*"), emit: viz_distribution_ch

    script:
    """
    scsilhouette viz-distribution \\
    --summary-csv $cluster_summary_path \\
    --label $label_key_ch
    """
}

