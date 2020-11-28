import matplotlib.pyplot as plt
import numpy as np

data1 = [[326, 93, 211, 2], [81, 477, 3, 25], [0, 266, 4, 147]]
data2 = [[5, 24, 57, 11], [4, 12, 10, 5], [0, 4, 9, 7]]
lab = ['e+6', 'e+5', 'e+4', 'e+3']
x = np.arange(4)

fig, axs = plt.subplots(2, 1)
plt.subplots_adjust(hspace=0.25)

axs[0].bar(x + 0.00, data1[0], width=0.2, color='#89ABE8')
axs[0].bar(x + 0.25, data1[1], width=0.2, color='#63E188')
axs[0].bar(x + 0.5, data1[2], width=0.2, color='grey')

plt.gca().axes.get_xaxis().set_visible(False)
axs[0].set_xticklabels([])
axs[0].set_xlabel('Popularity')
axs[0].set_ylabel('Engagement')
axs[0].set_yscale('log')
axs[0].text(0.1, 340, '[e+3, e+4)', fontsize=9)
axs[0].text(1.1, 320, '[e+4, e+5)', fontsize=9)
axs[0].text(2.1, 320, '[e+5, e+6)', fontsize=9)
axs[0].text(3.1, 320, '[e+6, e+7)', fontsize=9)


axs[1].bar(x + 0.00, data2[0], width=0.2, color='#89ABE8', alpha=0.5)
axs[1].bar(x + 0.25, data2[1], width=0.2, color='#63E188', alpha=0.5)
axs[1].bar(x + 0.5, data2[2], width=0.2, color='grey', alpha=0.5)

axs[1].set_xticklabels([])
axs[1].set_ylabel('Accounts')
axs[1].set_yscale('log')
axs[1].text(0.1, 55, '[e+3, e+4)', fontsize=9)
axs[1].text(1.1, 55, '[e+4, e+5)', fontsize=9)
axs[1].text(2.1, 55, '[e+5, e+6)', fontsize=9)
axs[1].text(3.1, 55, '[e+6, e+7)', fontsize=9)


plt.gca().invert_yaxis()
plt.show()
