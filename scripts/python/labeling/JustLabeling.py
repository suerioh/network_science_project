# init
import pandas as pd
import math
d1 = []
d0 = []
lookuptable = []
delimiter = '\t'
lenght_document = 4224
#length_document = 1307
num_of_profiles = 159

#df è un dato di tipo DataFrame
file_errors_location = 'C:\\Users\\Giacomo\\Documents\\Università\\Magistrale\\Network Science (Mod. B)\\Interdisciplinary Project\\Elaborazione Dati\\DATASET.xlsx'
df = pd.read_excel(file_errors_location)

for x in range(0,num_of_profiles):
    lookuptable.append(df.loc[x]['ID'])


with open('M_cernita.txt') as f:
    for c in range(0, lenght_document):
        d0.append(f.readline().split(delimiter)[0])
        c = c + 1
with open('M_cernita.txt') as f:
    for c in range(0, lenght_document):
        d1.append(f.readline().split(delimiter)[1][:-1])
        c = c + 1

'''with open('RT_cernita.txt') as f:
    for c in range(0, length_document):
        d0.append(f.readline().split(delimiter)[0])
        c = c + 1
with open('RT_cernita.txt') as f:
    for c in range(0, length_document):
        d1.append(f.readline().split(delimiter)[1][:-1])
        c = c + 1'''

# label first column
l0 = [0 for x in range(len(d0))]
l1 = [0 for x in range(len(d0))]
l0[0] = 1


initial = d0[0]
#sommo 1 perché il vettore parte da 0, invece l'excel parte da 2
index = lookuptable.index(int(initial)) + 1
l0[0] = index

print(lookuptable)

for x in range(1, len(d0)):
    if d0[x] == d0[x-1]:
        l0[x] = index
    else:
        index = lookuptable.index(d0[x]) + 1
        l0[x] = index


l1[0] = lookuptable.index(int(d1[0])) + 1

# label second column
for x in range(1, len(d1)):
    if d1[x]==d1[x-1]:
        l1[x] = l1[x-1]
    else:
        l1[x] = lookuptable.index(int(d1[x])) + 1


# writing
out = ''
for x in range(0, len(l0)):
    out = out + str(l0[x]) + '\t' + str(l1[x]) + '\n'
saveFile = open('M_labeled.txt', 'w')
saveFile.write(out)
saveFile.close()

'''out = ''
for x in range(0, len(l0)):
    out = out + str(l0[x]) + '\t' + str(l1[x]) + '\n'
saveFile = open('RT_labeled.txt', 'w')
saveFile.write(out)
saveFile.close()'''



#------------------
#Stampe che possono essere utili nel debug
#print(df)
#print(d0)
#print(lookuptable)
#print(lookuptable.index(int(initial)))
#print(l0)
#print(l1)