# init
length = 5531
length2 = 148
length3 = 33
delimiter = '\t'

# prendo id di input
id_in = []
with open('MRT_cernita.txt') as f:
    for c in range(0, length):
        id_in.append(f.readline().split(delimiter)[0])
        c = c + 1
id_out = []
with open('MRT_cernita.txt') as f:
    for c in range(0, length):
        id_out.append(f.readline().split(delimiter)[1][:-1])
        c = c + 1

# prendo valori della lookup table
geo_table_in = []
f = open('geo_lookup.txt', encoding="utf8")
for c in range(0, length2):
    geo_table_in.append(f.readline().split(delimiter)[0])
    c = c + 1
geo_table_out = []
f = open('geo_lookup.txt', encoding="utf8")
for c in range(0, length2):
    geo_table_out.append(f.readline().split(delimiter)[1][:-1])
    c = c + 1

# prendo valori della lookup table per le coordinate
lat_table = []
f = open('lat_table.txt', encoding="utf8")
for c in range(0, length3):
    lat_table.append(f.readline().split(delimiter)[0][:-1])
    c = c + 1
lon_table = []
f = open('lon_table.txt', encoding="utf8")
for c in range(0, length3):
    lon_table.append(f.readline().split(delimiter)[0][:-1])
    c = c + 1
cities_table = []
f = open('cities_table.txt', encoding="utf8")
for c in range(0, length3):
    cities_table.append(f.readline().split(delimiter)[0][:-1])
    c = c + 1


# filtro MRT con id che appartengono alla categoria che mi interessa:
def id_filter_class(index_from, index_to):
    tmp_in = []
    tmp_out = []
    for x in range(len(id_in)):
        for k in range(index_from, index_to):
            if id_in[x] == geo_table_in[k]:
                for j in range(index_from, index_to):
                    if id_out[x] == geo_table_in[j]:
                        tmp_in.append(id_in[x])
                        tmp_out.append(id_out[x])
    return tmp_in, tmp_out


# prendo le geo dei rispettivi id
def get_geo(arr1):
    geo_id = []
    for x in range(len(arr1)):
        for k in range(len(geo_table_in)):
            if arr1[x] == geo_table_in[k]:
                geo_id.append(geo_table_out[k])
                break
    return geo_id


# tolgo i self loop relativi a due valori geo identici
def no_geo_self_loop(arr1, arr2, geo1, geo2):
    tmp1 = []
    tmp2 = []
    tmp3 = []
    tmp4 = []
    for x in range(len(arr1)):
        if not geo1[x] == geo2[x]:
            tmp1.append(arr1[x])
            tmp2.append(arr2[x])
            tmp3.append(geo1[x])
            tmp4.append(geo2[x])
    return tmp1, tmp2, tmp3, tmp4


# trovo la classe per ogni id
def class_label(arr):
    label = []
    for x in range(len(arr)):
        for k in range(len(geo_table_in)):
            if str(arr[x]) == str(geo_table_in[k]):
                if 0 <= k <= 99:
                    label.append('pol')
                elif 100 <= k <= 137:
                    label.append('news')
                else:
                    label.append('fnp')
                break
    return label


# iserisco lat e lon per ogni luogo del vettore, usando la apposita lookuptable
def add_lat_lon(geo_arr):
    tmp_lat = []
    tmp_lon = []
    for x in range(len(geo_arr)):
        for k in range(len(cities_table)):
            if str(geo_arr[x]) == str(cities_table[k]):
                tmp_lat.append(lat_table[k])
                tmp_lon.append(lon_table[k])
    return tmp_lat, tmp_lon


# stampo tutti gli id che fanno parte dell'intevallo di filtaggio, ma che non hanno link
def get_lonely(index_from, index_to):
    tmp = []
    for x in range(index_from, index_to):
        if not geo_table_in[x] in id_in and not geo_table_in[x] in id_out:
            tmp.append(geo_table_in[x])
    return tmp


# printo i miei valori da mettere nella rappresentazione, ricordando che:
# pol -> 0 to 99
# news -> 100 to 137
# fnp -> 138 to 148
def get_data(index_from, index_to):
    fil_in, fil_out = id_filter_class(index_from, index_to)
    geo_in = get_geo(fil_in)
    geo_out = get_geo(fil_out)
    fil_in, fil_out, geo_in, geo_out = no_geo_self_loop(fil_in, fil_out, geo_in, geo_out)
    label_in = class_label(fil_in)
    label_out = class_label(fil_out)
    lat_in, lon_in = add_lat_lon(geo_in)
    lat_out, lon_out = add_lat_lon(geo_out)

    lone = get_lonely(index_from, index_to)
    geo_lone = get_geo(lone)
    label_lone = class_label(lone)
    lat_lone, lon_lone = add_lat_lon(geo_lone)

    out = ''
    for x in range(len(fil_in)):
        out = out + str(fil_in[x]) + '\t' + str(label_in[x]) + '\t' + str(geo_in[x]) + '\t' + str(lat_in[x]) + '\t' \
              + str(lon_in[x]) + '\t' + str(fil_out[x]) + '\t' + str(label_out[x]) + '\t' + str(geo_out[x]) + '\t' \
              + str(lat_out[x]) + '\t' + str(lon_out[x]) + '\n'
    saveFile = open('data_for_geo_fnp.txt', 'w')
    saveFile.write(out)
    saveFile.close()

    out2 = ''
    for x in range(len(lone)):
        out2 = out2 + str(lone[x]) + '\t' + str(label_lone[x]) + '\t' + str(geo_lone[x]) + '\t' + str(lat_lone[x])\
               + '\t' + str(lon_lone[x]) + '\n'

    saveFile = open('data_for_geo_fnp_lonely.txt', 'w')
    saveFile.write(out2)
    saveFile.close()


# utilizzo la funzione, anche se devo cambiare gli index e anche i valori
get_data(138, 148)
