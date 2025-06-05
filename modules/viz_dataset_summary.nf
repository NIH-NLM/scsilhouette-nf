#!/usr/bin/env nextflow
process viz_dataset_summary_process {

    tag 'viz_dataset_summary_process'

    publishDir "${params.outdir}", mode: 'copy'

    input:
        path cluster_summary_path
	val  label

    output:
        path ("*"), emit: viz_dataset_summary_ch 

    script:
    """
    scsilhouette viz-dataset-summary \\
    --cluster-summary-path ${cluster_summary_path} \\
    --label ${label}
    """
}

