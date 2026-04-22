import streamlit as st

st.set_page_config(page_title="Perfil", page_icon="👤")

st.title("👤 Perfil")
st.write("Visualize e edite as informações do seu perfil acadêmico.")

st.subheader("Dados do Usuário")
st.write("**Nome:** João Silva")
st.write("**Curso:** Engenharia de Software")
st.write("**Período:** 5º semestre")

st.info("Em breve você poderá atualizar seu perfil com as informações reais do backend.")
