#!/usr/bin/env nextflow

process viz_distribution_process {

    tag 'viz_distribution_process'

    publishDir "${params.outdir}", mode: 'copy'

    input:
        path cluster_summary_path
        tuple path(h5ad_file), val(label_key), val(embedding_key), val(organism), val(disease), val(tissue), val(cell_count)

    output:
        path ("*"), emit: viz_distribution_ch

    script:
    """
    /opt/conda/bin/scsilhouette viz-distribution \\
    --cluster-summary-path $cluster_summary_path \\
    --label-key $label_key
    """
}

