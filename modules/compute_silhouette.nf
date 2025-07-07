#!/usr/bin/env nextflow

process compute_silhouette_process {

    tag "${h5ad_file}-${label_key}-${embedding_key}-${organism}-${disease}-${tissue}-${cell_count}"


    publishDir "${params.outdir}", mode: 'copy'
    
    input:
        tuple path(h5ad_file), val(label_key), val(embedding_key), val(organism), val(disease), val(tissue), val(cell_count)
        val  metric
        val  save_scores
        val  save_cluster_summary
        val  save_annotation

    output:
        path("silhouette_scores*.csv"), emit: silhouette_scores_ch
	path("cluster_summary*.csv"),   emit: cluster_summary_ch
        path("annotation*.csv"),        emit: annotations_ch

    script:
    """
    /opt/conda/bin/scsilhouette compute-silhouette \\
	--h5ad-path $h5ad_file \\
	--label-key $label_key \\
	--embedding-key $embedding_key \\
	--organism $organism \\
	--disease $disease \\
	--tissue $tissue \\
	--cell-count $cell_count \\
	--metric $metric \\
	--save-scores \\
	--save-cluster-summary \\
	--save-annotation
    """
}
