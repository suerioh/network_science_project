import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rc
import pandas as pd


r = [0, 1, 2]
names = ['pol', 'news', 'fake']
data1 = {'greenBars': [94.31, 57.81, 29.69], 'orangeBars': [5.18, 42.18, 1.39], 'blueBars': [0.49, 0, 68.90]}
# data2 = {'greenBars': [77.60, 22.91, 5.45], 'orangeBars': [19.47, 76.34, 0], 'blueBars': [2.91, 0.73, 94.54]}
df = pd.DataFrame(data1)


totals = [i + j + k for i, j, k in zip(df['greenBars'], df['orangeBars'], df['blueBars'])]
greenBars = [i / j * 100 for i, j in zip(df['greenBars'], totals)]
orangeBars = [i / j * 100 for i, j in zip(df['orangeBars'], totals)]
blueBars = [i / j * 100 for i, j in zip(df['blueBars'], totals)]


barWidth = 0.5
plt.bar(r, greenBars, color='#89ABE8', edgecolor='white', width=barWidth)
plt.bar(r, orangeBars, bottom=greenBars, color='#63E188', edgecolor='white', width=barWidth)
plt.bar(r, blueBars, bottom=[i + j for i, j in zip(greenBars, orangeBars)], color='grey', edgecolor='white',
        width=barWidth)

plt.title("Outgoing Links")
plt.xticks(r, names)
plt.show()
