% Function that associates a word coming from the GEO.txt document to the
% related region. The index that I return depends on the position of the
% region on the document Regions.txt

function index = lookup_table(word)
index = 20;
if(isempty(setdiff('Almería',word)))
    index = 1;
    return;
end
if(isempty(setdiff('Andalucía',word)))
    index = 1;
    return;
end
if(isempty(setdiff('Aragon',word)))
    index = 2;
    return;
end
if(isempty(setdiff('Asturias',word)))
    index = 3;
    return;
end
if(isempty(setdiff('Barcelona',word)))
    index = 9;
    return;
end
if(isempty(setdiff('Bilbao',word)))
    index = 19;
    return;
end
if(isempty(setdiff('Biscaia',word)))
    index = 19;
    return;
end
if(isempty(setdiff('Brussels, Belgium',word)))
    index = 20;
    return;
end
if(isempty(setdiff('Burgos',word)))
    index = 8;
    return;
end
if(isempty(setdiff('Cadiz',word)))
    index = 1;
    return;
end
if(isempty(setdiff('Castellón',word)))
    index = 11;
    return;
end
if(isempty(setdiff('Castilla y León',word)))
    index = 8;
    return;
end
if(isempty(setdiff('Catalunya',word)))
    index = 9;
    return;
end
if(isempty(setdiff('Cataluña',word)))
    index = 9;
    return;
end
if(isempty(setdiff('Comunidad Valenciana',word)))
    index = 11;
    return;
end
if(isempty(setdiff('Cádiz',word)))
    index = 1;
    return;
end
if(isempty(setdiff('Córdoba',word)))
    index = 1;
    return;
end
if(isempty(setdiff('Galicia',word)))
    index = 13;
    return;
end
if(isempty(setdiff('Gerona',word)))
    index = 9;
    return;
end
if(isempty(setdiff('Granada',word)))
    index = 1;
    return;
end
if(isempty(setdiff('Guipúzcoa',word)))
    index = 19;
    return;
end
if(isempty(setdiff('Jaen',word)))
    index = 1;
    return;
end
if(isempty(setdiff('La Coruña',word)))
    index = 13;
    return;
end
if(isempty(setdiff('Las Palmas de Gran Canaria',word)))
    index = 5;
    return;
end
if(isempty(setdiff('León',word)))
    index = 8;
    return;
end
if(isempty(setdiff('Lugo',word)))
    index = 13;
    return;
end
if(isempty(setdiff('Madrid',word)))
    index = 15;
    return;
end
if(isempty(setdiff('Mallorca',word)))
    index = 4;
    return;
end
if(isempty(setdiff('Murcia',word)))
    index = 17;
    return;
end
if(isempty(setdiff('Málaga',word)))
    index = 1;
    return;
end
if(isempty(setdiff('Navarra',word)))
    index = 18;
    return;
end
if(isempty(setdiff('Ourense',word)))
    index = 13;
    return;
end
if(isempty(setdiff('Palencia',word)))
    index = 8;
    return;
end
if(isempty(setdiff('Palma',word)))
    index = 4;
    return;
end
if(isempty(setdiff('País Vasco',word)))
    index = 19;
    return;
end
if(isempty(setdiff('Salamanca',word)))
    index = 8;
    return;
end
if(isempty(setdiff('Santa Cruz de Tenerife',word)))
    index = 5;
    return;
end
if(isempty(setdiff('Sevilla',word)))
    index = 1;
    return;
end
if(isempty(setdiff('Spain',word)))
    index = 21;
    return;
end
if(isempty(setdiff('Valencia',word)))
    index = 11;
    return;
end
if(isempty(setdiff('Vigo',word)))
    index = 11;
    return;
end
if(isempty(setdiff('Zaragoza',word)))
    index = 2;
    return;
end
if(isempty(setdiff('madrid',word)))
    index = 15;
    return;
end
end