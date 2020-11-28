import numpy as np
import matplotlib.pyplot as plt

# init
id_in = []
rts = []
id_data = []
length = 31688
delimiter = '\t'

# prendo id di input
with open('output_user_id_tweetid_RTs_mentions.txt') as f:
    for c in range(0, length):
        id_in.append(f.readline().split(delimiter)[1])
        c = c + 1

with open('output_user_id_tweetid_RTs_mentions.txt') as f:
    for c in range(0, length):
        rts.append(f.readline().split(delimiter)[3])
        c = c + 1

# prendo id dei nodi del dataset
with open('output_id_only.txt', 'r') as f:
    for line in f:
        line = line[:-1]
        id_data.append(line)

# CLASSI
# politici -> 0 to 5665 compresi
# news -> 5666 to 28316 compresi
# fnp -> 28317 to 31688 compresi
rts_pol = []
for x in range(0, 5665):
    rts_pol.append(rts[x])

rts_news = []
for x in range(5666, 28316):
    rts_news.append(rts[x])

rts_fnp = []
for x in range(28317, 31688):
    rts_fnp.append(rts[x])

rts_pol = np.asarray(rts_pol, dtype=np.int32)
rts_news = np.asarray(rts_news, dtype=np.int32)
rts_fnp = np.asarray(rts_fnp, dtype=np.int32)


'''
# prendo input relativi all secondo punto dell engagement
length = 7442
sorted_rts = []

with open('output_id_RTs_sorted.txt') as f:
    for c in range(0, length):
        sorted_rts.append(f.readline().split(delimiter)[1][:-1])
        c = c + 1


# do alla funzione le linee non gli indici!
def get_avg_rt(index_from, index_to, arr):
    s = 0
    for x in range(index_from - 1, index_to):
        s = s + int(arr[x])
    avg = s / (index_to - index_from + 1)
    return avg


print('RESULTS RELATIVE ENGAGEMENT:')
print('order 6 -> avg RT pol: ' + str(get_avg_rt(1, 177, sorted_rts)))
print('order 6 -> avg RT news: ' + str(get_avg_rt(178, 256, sorted_rts)))

print('order 5 -> avg RT pol: ' + str(get_avg_rt(257, 1498, sorted_rts)))
print('order 5 -> avg RT news: ' + str(get_avg_rt(1499, 2047, sorted_rts)))
print('order 5 -> avg RT fnp: ' + str(get_avg_rt(2048, 2230, sorted_rts)))

print('order 4 -> avg RT pol: ' + str(get_avg_rt(2231, 4864, sorted_rts)))
print('order 4 -> avg RT news: ' + str(get_avg_rt(4865, 5770, sorted_rts)))
print('order 4 -> avg RT fnp: ' + str(get_avg_rt(5771, 5935, sorted_rts)))

print('order 3 -> avg RT pol: ' + str(get_avg_rt(5936, 6700, sorted_rts)))
print('order 3 -> avg RT news: ' + str(get_avg_rt(6701, 7068, sorted_rts)))
print('order 3 -> avg RT fnp: ' + str(get_avg_rt(7069, 7442, sorted_rts)))
'''


# funzioni per fare le pdf
def remove_zeros(arr, relative_to=None):
    assert (relative_to is None) or (type(relative_to) == np.ndarray)
    if relative_to is None: 
        relative_to = arr
    return arr[relative_to != 0]


def get_neighbours_pdf(degrees):
    degrees = remove_zeros(degrees)
    unique, counts = np.unique(degrees, return_counts=True)
    pdf = counts / np.sum(counts)
    return unique, pdf


uniques_pol, pdf_pol = get_neighbours_pdf(rts_pol)
uniques_news, pdf_news = get_neighbours_pdf(rts_news)
uniques_fnp, pdf_fnp = get_neighbours_pdf(rts_fnp)

# rappresnto
fig, axs = plt.subplots(1, 2, figsize=(12, 5))
plt.subplots_adjust(wspace=0.5)

axs[0].loglog(uniques_pol, pdf_pol, marker='.', linestyle='None', ms=3, color='#89ABE8')
axs[0].loglog(uniques_fnp, pdf_fnp, marker='.', linestyle='None', ms=3, color='grey')
axs[0].set_xlabel('Frequency')
axs[0].set_ylabel('Engagment')
axs[0].grid(which='minor', alpha=0.2)
axs[0].grid(which='major', alpha=0.5)

axs[1].loglog(uniques_news, pdf_news, marker='.', linestyle='None', ms=3, color='#63E188')
axs[1].loglog(uniques_fnp, pdf_fnp, marker='.', linestyle='None', ms=3, color='grey')
axs[1].set_xlabel('Frequency')
axs[1].set_ylabel('Engagement')
axs[1].grid(which='minor', alpha=0.2)
axs[1].grid(which='major', alpha=0.5)


# fig.tight_layout()
plt.show()