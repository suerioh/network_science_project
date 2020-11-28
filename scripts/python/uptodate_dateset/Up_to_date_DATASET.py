import pandas as pd

length = 159
num_followers = []

file_error_location = 'C:\\Users\\Giacomo\\Documents\\Università\\Magistrale\\Network Science (Mod. B)\\Interdisciplinary Project\\Elaborazione Dati\\DATASET.xlsx'
df = pd.read_excel(file_error_location)
indexes0 = [69,73,75,110,132,133,140,147,153,154] #indexes coming from Matlab
indexes = [2,4,7,8,17,27,31,39,41,53,54,56,57,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,97,100,104,105,109,110,115,117,120,125,126,127,130,131,132,133,136,140,141,142,143,144,145,146,148,149]
for x in range(0,len(indexes0)):            #shift all the indexes to remove the right nodes
    indexes0[x] = indexes0[x] - 1 

for x in range(0,len(indexes)):
    indexes[x] = indexes[x] - 1

new_df = pd.DataFrame.drop(df, index = indexes0)
df2 = pd.DataFrame(columns = ['USERNAME','ID','CLASS','PARTY','FOLLOWERS','GEO'])
row_iterator = new_df.iterrows()


for i,row in row_iterator:
    row_df = pd.DataFrame(data={'USERNAME': [row['USERNAME']],'ID': [row['ID']],'CLASS': [row['CLASS']],'PARTY': [row['PARTY']],'FOLLOWERS': [row['FOLLOWERS']],'GEO': [row['GEO']]})
    df2 = df2.append(row_df,ignore_index=True)

new_df = pd.DataFrame.drop(df2, index = indexes)
final_df = pd.DataFrame(columns = ['USERNAME','ID','CLASS','PARTY','FOLLOWERS','GEO'])
row_iterator = new_df.iterrows()

for i,row in row_iterator:
    row_df = pd.DataFrame(data={'USERNAME': [row['USERNAME']],'ID': [row['ID']],'CLASS': [row['CLASS']],'PARTY': [row['PARTY']],'FOLLOWERS': [row['FOLLOWERS']],'GEO': [row['GEO']]})
    final_df = final_df.append(row_df,ignore_index=True)

#print(final_df)

writer = pd.ExcelWriter('UPDATED_DATASET2.xlsx',engine='xlsxwriter')
final_df.to_excel(writer, sheet_name='Sheet1', index=False)
writer.save()