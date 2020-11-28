import pandas as pd

file_error_location = 'C:\\Users\\Giacomo\\Documents\\Università\\Magistrale\\Network Science (Mod. B)\\Interdisciplinary Project\\Elaborazione Dati\\elections results.xlsx'
df = pd.read_excel(file_error_location)

print(df['Unnamed: 3'])

regions = []
psoe = [0 for x in range(0,19)]
pp = [0 for x in range(0,19)]
cs = [0 for x in range(0,19)]
up = [0 for x in range(0,19)]
vox = [0 for x in range(0,19)]

#print(psoe)

for x in range(3,22):
    regions.append(df.loc[x]['Unnamed: 2'])

    psoe[x-3] = (df.loc[x]['Unnamed: 4'])

    pp[x-3] = (df.loc[x]['Unnamed: 7'])

    cs[x-3] = (df.loc[x]['Unnamed: 10'])

    up[x-3] = (df.loc[x]['Unnamed: 13'])

    vox[x-3] = (df.loc[x]['Unnamed: 16'])

#print(pp)

out = ''
for x in range(0, len(psoe)):
    out = out + str(regions[x]) + '\n'
saveFile = open('Regions.txt', 'w')
saveFile.write(out)
out = ''
for x in range(0, len(psoe)):
    out = out + str(psoe[x]) + '\n'
saveFile = open('PSOE_Votes.txt', 'w')
saveFile.write(out)
out = ''
for x in range(0, len(pp)):
    out = out + str(pp[x]) + '\n'
saveFile = open('PP_Votes.txt', 'w')
saveFile.write(out)
out = ''
for x in range(0, len(cs)):
    out = out + str(cs[x]) + '\n'
saveFile = open('CS_Votes.txt', 'w')
saveFile.write(out)
out = ''
for x in range(0, len(up)):
    out = out + str(up[x]) + '\n'
saveFile = open('UP_Votes.txt', 'w')
saveFile.write(out)
out = ''
for x in range(0, len(vox)):
    out = out + str(vox[x]) + '\n'
saveFile = open('VOX_Votes.txt', 'w')
saveFile.write(out)
saveFile.close()

#print(regions)