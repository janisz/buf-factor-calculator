import pandas as pd
import networkx as nx
%matplotlib inline

path = 'data/repos/apache/mesos'

def authors_full(path):
    authors = pd.read_csv(path + '/author-churn.csv', parse_dates=True, index_col='author')
    authors = authors / authors.sum()

    summary = pd.read_csv(path + '/summary.csv', parse_dates=True)
    main_dev = pd.read_csv(path + '/main-dev.csv', parse_dates=True)
    dev = main_dev[['main-dev', 'ownership']].groupby('main-dev').sum()  / summary['value'][2]
    dev = dev / dev.sum()
    dev = dev.reset_index()
    dev.columns = ['author', 'ownership']
    dev = dev.set_index('author')

    communication = pd.read_csv('data/communication.csv')
    G=nx.from_pandas_dataframe(communication, 'author', 'peer', ['shared'])
    page_rank = pd.DataFrame.from_dict(nx.pagerank(G, weight='shared'), orient='index')
    page_rank.columns = ['page_rank']

    summary = pd.read_csv(path + '/summary.csv', parse_dates=True)
    refactoring_main_dev = pd.read_csv(path + '/refactoring-main-dev.csv', parse_dates=True)
    refactoring_dev = refactoring_main_dev[['main-dev', 'ownership']].groupby('main-dev').sum()  / summary['value'][2]
    refactoring_dev = refactoring_dev / refactoring_dev.sum()
    refactoring_dev = refactoring_dev.reset_index()
    refactoring_dev.columns = ['author', 'refactoring_ownership']
    refactoring_dev = refactoring_dev.set_index('author')

    return pd.concat([dev, refactoring_dev, page_rank, authors], axis='author').fillna(0)
