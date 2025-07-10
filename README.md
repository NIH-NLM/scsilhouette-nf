
## Nextflow Workflow

**Overview**

This repository includes a modular Nextflow pipeline that performs silhouette scoring and quality control visualizations for .h5ad files. Each computational step is implemented as an individual Nextflow module in the modules/ directory. The master workflow is defined in main.nf.

The Nextflow workflow uses the [scsilhouette package](https://github/NIH-NLM/scsilhouette).  This single cell silhouette score package generates silhouette scores on a cell-by-cell basis, then creates summary statistics that captures cluster level information.   Using the cell type which is populated by the cellxgene program upon submission, cell type specific statistics (median, min and max plus Q1 to Q3 box) are displayed for the user to explore, as well as dataset level statistics, especially the median of medians.

This statistics tests the tightness of the cluster.

## input

The nextflow begins by parsing the input file formated as below:

```bash
h5ad_file,label_key,embedding_key,organism,disease,tissue,author,year,pub,cell_count
https://datasets.cellxgene.cziscience.com/39d93cac-f79e-4f38-bd2a-2e8ad701ba14.h5ad,cell_type,X_umap,Homo_sapiens,normal,kidney,Reck,2025,Nat Comm,46957
https://datasets.cellxgene.cziscience.com/0d2431dd-f185-47e1-be06-255f84304559.h5ad,cell_type,X_umap,Homo_sapiens,normal,kidney,Acera-Mateos,2025,bioRxiv,97125
https://datasets.cellxgene.cziscience.com/4e6cf682-3aa0-4c79-a6e1-8abc21a85146.h5ad,cell_type,X_umap,Homo_sapiens,normal,kidney,Xu,2023,Cell,194504
```

It has a header file that contains:

* h5ad_file location
* label_key - this is the clustering label
* embedding_key - mostly X_umap but ocassionaly not supported so could be X_tsne or other
* organism (e.g. Homo sapiens)
* disease (e.g. normal, neoplasm, etc)
* tissue (e.g. kidney -- actually an organ level specification)
* author (first author of a publication associated with the submitted dataset)
* year (publication year)
* publication (name of publication)
* cell_count (number of cells submitted in the dataset)

## Usage

The execution has been conducted on [Lifebit's free NF-Copilot](cloudos.lifebit.ai)

1. There you select this Nextflow workflow [scsilhouette-nf](https://github.com/nih-nlm/scsilhouette-nf)
2. Add your parameter *'dataset_csv'*, upload from your computer or use from the dataset selected with File Explorer
3. Select a low-cost, low memory, low cpu master node as your execution node
4. Select your job queue
5. Select resumable
6. Then Run Analysis.

## Outputs

Each dataset produces the following under results/{dataset_name}/:

* Annotations, Silhouette scores and cluster summaries

* Visualization summary as an interactive html of silhouette scores and cluster summaries as well as a dotplot


## Modular Design

Each pipeline process is defined in a separate module in modules/:

```bash
modules/
├── compute_silhouette.nf
├── viz_summary.nf
├── viz_dotplot.nf
├── viz_distribution.nf
```


