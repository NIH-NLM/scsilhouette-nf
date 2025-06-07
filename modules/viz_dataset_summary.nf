#!/usr/bin/env nextflow
process viz_dataset_summary_process {

    tag 'viz_dataset_summary_process'

    publishDir "${params.outdir}", mode: 'copy'

    input:
        path cluster_summary_path
	tuple val(h5ad_ch), val(label_key_ch), val(embedding_key_ch)

    output:
        path ("*"), emit: viz_dataset_summary_ch 

    script:
    """
    scsilhouette viz-dataset-summary \\
    --cluster-summary-path $cluster_summary_path \\
    --label $label_key_ch
    """
}

