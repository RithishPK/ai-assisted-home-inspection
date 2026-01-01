import streamlit as st
from snowflake.snowpark.context import get_active_session

# Get Snowflake session
session = get_active_session()

st.set_page_config(page_title="AI-Assisted Building Inspection", layout="wide")

st.title("🏠 AI-Assisted Home & Building Inspection")
st.caption("Snowflake AI for Good – Prototype")

st.divider()

# Property Selector
properties = session.sql(
    "SELECT DISTINCT property_id FROM PROPERTY_RISK_CATEGORY"
).to_pandas()

property_id = st.selectbox(
    "Select Property",
    properties["PROPERTY_ID"]
)

st.divider()

# Property Risk Overview
st.subheader("📊 Property Risk Overview")

risk_df = session.sql(f"""
    SELECT property_id, avg_property_risk, risk_level
    FROM PROPERTY_RISK_CATEGORY
    WHERE property_id = '{property_id}'
""").to_pandas()

st.dataframe(risk_df, use_container_width=True)


# Room-Level Findings
st.subheader("🚪 Room-Level Inspection Findings")

room_df = session.sql(f"""
    SELECT room_type, finding_text
    FROM ROOM_FINDINGS_TEXT
    WHERE property_id = '{property_id}'
""").to_pandas()

st.table(room_df)


# Plain-Language AI Summary
st.subheader("🧠 AI-Generated Inspection Summary")

summary = session.sql(f"""
    SELECT final_report
    FROM FINAL_PROPERTY_REPORT
    WHERE property_id = '{property_id}'
""").collect()

if summary:
    st.success(summary[0][0])
else:
    st.info("No summary available.")

