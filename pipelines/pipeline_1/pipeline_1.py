from kfp import dsl
from kfp import compiler
from components import load_from_bigquery
from components import column_selection
from components import feature_normalization

@dsl.pipeline(name='pipeline-1',
             description='Pipeline de exemplo para MLOps, rodando um regressor linear.')
def pipeline_1(project_id: str, dataset_id:str, table_id:str):
    """
    Pipeline de exemplo para MLOps, rodando um regressor linear.
    """
    output_dataframe = load_from_bigquery(project_id, dataset_id, table_id)
    sliced_dataframe = column_selection(output_dataframe)
    normalized_dataframe = feature_normalization(sliced_dataframe)

compiler.Compiler().compile(
    pipeline_func=pipeline_1,
    package_path='pipeline_1.yaml'
)