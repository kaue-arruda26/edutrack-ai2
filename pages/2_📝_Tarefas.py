import streamlit as st

st.set_page_config(page_title="Tarefas", page_icon="📝")

st.title("📝 Tarefas")
st.write("Gerencie suas tarefas acadêmicas e acompanhe seu progresso.")

st.subheader("Tarefas Pendentes")
st.checkbox("Estudar para a prova de Matemática")
st.checkbox("Preparar apresentação de História")
st.checkbox("Revisar conteúdos de Ciências")

st.success("Use esta página para marcar tarefas como concluídas.")
