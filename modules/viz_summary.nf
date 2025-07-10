#!/usr/bin/env nextflow

process viz_summary_process {

    tag "${h5ad_file}-${label_key}-${embedding_key}-${organism}-${disease}-${tissue}-${author}-${publication_date}-${publication}-${cell_count}"

    publishDir "${params.outdir}", mode: 'copy'
  
    input:
        tuple path(h5ad_file), val(label_key), val(embedding_key), val(organism),
	      val(disease), val(tissue), val(author), val(publication_date), val(publication),
	      val(cell_count), path(silhouette_scores_csv),
              path(cluster_summary_csv),path(annotation_csv)

    output:
        path("*"), emit: viz_summary_ch

    script:
    """
    /opt/conda/bin/scsilhouette viz-summary \\
        --silhouette-score-path $silhouette_scores_csv \\
        --silhouette-score-col $params.silhouette_score \\
        --label-key $label_key 
    """
}


