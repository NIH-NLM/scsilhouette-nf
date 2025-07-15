#!/usr/bin/env nextflow

process compute_silhouette_process {

    tag "${h5ad_file}-${label_key}-${embedding_key}-${organism}-${disease}-${filter},${metric}-${save_scores}-${save_cluster_summary}-${save-annotation}-${tissue}-${author}-${publication_date}-${publication}-${cell_count}"

    publishDir "${params.outdir}", mode: 'copy'
    
    input:
        tuple path(h5ad_file), val(label_key), val(embedding_key), val(organism),val(disease),
	      val(filter), val(metric), val(save_scores), val(save_cluster_summary),val(save_annotation),
	      val(tissue), val(author), val(publication_date), val(publication),val(cell_count)

output:
        tuple path(h5ad_file), val(label_key), val(embedding_key), val(organism),val(disease),
	      val(filter), val(metric), val(save_scores), val(save_cluster_summary),val(save_annotation),
	      val(tissue), val(author), val(publication_date), val(publication),val(cell_count),
	      path("silhouette_scores*.csv"),path("cluster_summary*.csv"),path("annotation*.csv"), emit: compute_silhouette_output_ch

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
	--filter-normal $filter \\
	--metric $metric \\
	--save-scores \\
	--save-cluster-summary \\
	--save-annotation
    """
}
