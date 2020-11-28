import pandas as pd

length = 93
GEO = [0 for x in range(0,length)]

file_error_location = 'C:\\Users\\Giacomo\\Documents\\Università\\Magistrale\\Network Science (Mod. B)\\Interdisciplinary Project\\Elaborazione Dati\\UPDATED_DATASET.xlsx'
df = pd.read_excel(file_error_location)

#print(df)

for x in range(0,length):
    GEO[x] = df.loc[x]['GEO']

#print(num_followers)

out = ''
for x in range(0, length):
    out = out + str(GEO[x]) + '\n'
saveFile = open('GEO.txt', 'w')
saveFile.write(out)
saveFile.close()
