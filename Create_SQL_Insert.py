# %%
import os
import pandas as pd
# %%
# read sheet in excel file
file_name = 'Sales bikes.xlsx'
data_base = 'db_sales_bikes'
list_sheets = [sheet for sheet in pd.ExcelFile(file_name).sheet_names if sheet != 'INFO']
# %%
# create a sql insert statement for each sheet
querys_container_folder = './querys_insert'
path_querys_container_folder = os.path.join(os.getcwd(), querys_container_folder)
os.makedirs(querys_container_folder, exist_ok=True)
for sheet in list_sheets:
    table_name = sheet
    df = pd.read_excel(file_name, sheet_name=sheet, skiprows=1)
    # create a list of columns
    list_columns = df.columns.tolist()
    # create a list of values
    list_values = df.values.tolist()
    # create a sql file 
    file_sql = open(f'{path_querys_container_folder}/{table_name}.sql', 'w')
    print(f'create file {table_name}.sql')
    file_sql.write(f'USE {data_base};\n')
    file_sql.write(f'INSERT INTO {table_name} ({", ".join(list_columns)}) VALUES \n')
    check_first_row = True
    for row in list_values:
        if check_first_row:
            row = ' '+str(row).replace('[','(').replace(']',')')+'\n'
            check_first_row = False
        else:
            row = ','+str(row).replace('[','(').replace(']',')')+'\n'
        file_sql.write(row)
    file_sql.close()
    
# %%
