import pandas as pd

length = 93
num_followers = []

file_error_location = 'C:\\Users\\Giacomo\\Documents\\Università\\Magistrale\\Network Science (Mod. B)\\Interdisciplinary Project\\Elaborazione Dati\\UPDATED_DATASET.xlsx'
df = pd.read_excel(file_error_location)

#print(df)

for x in range(0,length):
    num_followers.append(int(df.loc[x]['FOLLOWERS']))

#print(num_followers)

out = ''
for x in range(0, length):
    out = out + str(num_followers[x]) + '\n'
saveFile = open('Num_Followers.txt', 'w')
saveFile.write(out)
saveFile.close()
