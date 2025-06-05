#!/usr/bin/env nextflow

process compute_silhouette_process {

    tag 'compute_silhouette_process'

    publishDir "${params.outdir}", mode: 'copy'
    
    input:
        path h5ad_file
        val  label_key
        val  embedding_key
        val  metric
        val  save_scores
        val  save_cluster_summary
        val  save_annotation

    output:
        path("silhouette_scores*.csv"), emit: silhouette_scores_ch
	path("cluster_summary*.csv"),   emit: cluster_summary_ch

    script:
    """
    scsilhouette compute-silhouette \\
	--h5ad_path ${h5ad_file} \\
	--label_key ${label_key} \\
	--embedding_key ${embedding_key} \\
	--metric ${metric} \\
	--save-scores \\
	--save-cluster-summary \\
	--save-annotation
    """
}
