#!/usr/bin/env nextflow

include { compute_silhouette_process }  from './modules/compute_silhouette.nf'
include { viz_dataset_summary_process } from './modules/viz_dataset_summary.nf'
include { viz_distribution_process }    from './modules/viz_distribution.nf' 
include { viz_dotplot_process }         from './modules/viz_dotplot.nf'
include { viz_summary_process }         from './modules/viz_summary.nf'
include { merge_report_process }        from './modules/merge_report.nf'

workflow {

//  csv_rows_ch = Channel
//    .fromPath(params.datasets_csv)
//    .splitCsv(header: true)

//  h5ad_ch          = csv_rows_ch.map { row -> file(row.h5ad) }
//  label_key_ch     = csv_rows_ch.map { row -> row.label_key }
//  embedding_key_ch = csv_rows_ch.map { row -> row.embedding_key }

  h5ad_ch          = params.h5ad_ch
  label_key_ch     = params.label_key_ch
  embedding_key_ch = params.embedding_key_ch
  
  ( silhouette_scores_ch, cluster_summary_ch ) =
      compute_silhouette_process (
        h5ad_ch,
        label_key_ch,
        embedding_key_ch,
        params.metric,
        params.save_scores,
        params.save_cluster_summary,
        params.save_annotation )

  ( viz_dataset_summary_ch )  =
      viz_dataset_summary_process (
        cluster_summary_ch,
        label_key_ch )
				 
  ( viz_distribution_ch ) =
      viz_distribution_process (
        silhouette_scores_ch,
      	label_key_ch )

  ( viz_dotplot_ch ) =
      viz_dotplot_process (
        h5ad_ch,
        label_key_ch,
      	embedding_key_ch )

  ( viz_summary_ch ) =
       viz_summary_process (
         silhouette_scores_ch,
         label_key_ch,
         params.score_col,
         params.sort_by )

       def report_name = "h5ad_quality_summary_report"
       merge_report_process (
         viz_summary_ch,
	 viz_dotplot_ch,
	 viz_distribution_ch,
	 viz_dataset_summary_ch,
         report_name )	 

}