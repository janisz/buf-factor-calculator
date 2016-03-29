import pandas as pd
import networkx as nx
import os

repo = os.environ['repo']
authors = pd.read_csv(os.environ['REPO_DATA_DIR'] + '/summary.csv')['value'][3]

communication = pd.read_csv(os.environ['REPO_DATA_DIR'] + '/communication.csv')

G=nx.from_pandas_dataframe(communication, 'author', 'peer', ['strength'])
d = nx.pagerank(G, weight='strength')

data = pd.DataFrame(d.items()).sort_values(by=1, ascending=False)[1]
sum = 0
bus_factor = 0
for x in data:
    sum += x
    bus_factor += 1
    if (sum >= 0.5):
        break

print("%s,%d,%d" % (repo, bus_factor, authors))
