#!/usr/bin/env nextflow

process viz_distribution_process {

    tag "${h5ad_file}-${label_key}-${embedding_key}-${organism}-${disease}-${filter},${metric}-${save_scores}-${save_cluster_summary}-${save_annotation}-${tissue}-${author}-${publication_date}-${publication}-${cell_count}"

    publishDir "${params.outdir}", mode: 'copy'

    input:
        tuple path(h5ad_file), val(label_key), val(embedding_key), val(organism),val(disease),
	      val(filter), val(metric), val(save_scores), val(save_cluster_summary),val(save_annotation),
	      val(tissue), val(author), val(publication_date), val(publication),val(cell_count)
	      path(silhouette_scores_csv),path(cluster_summary_csv),path(annotation_csv)

    output:
        path ("*"), emit: viz_distribution_ch

    script:
    """
    /opt/conda/bin/scsilhouette viz-distribution \\
    --cluster-summary-path $cluster_summary_csv \\
    --label-key $label_key
    """
}

