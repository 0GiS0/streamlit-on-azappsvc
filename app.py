# Create a web with streamlit

import streamlit as st
import pandas as pd

# Title
st.title('Streamlit on Azure App Service 🥳')

# Create some mock data
df = pd.DataFrame({
    'first column': [1, 2, 3, 4],
    'second column': [10, 20, 30, 40]
})

# Create a table
st.table(df)

