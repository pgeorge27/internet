<%@ taglib
	uri="http://jakarta.apache.org/struts/tags-bean"
	prefix="bean"%>
<%@ taglib
	uri="http://jakarta.apache.org/struts/tags-html"
	prefix="html"%>
<%@ taglib
	uri="http://jakarta.apache.org/struts/tags-logic"
	prefix="logic"%>
<%@ include file="include/jspfunciones.inc.jsp"%>
<%@ include file="/head.jsp"%>
<%try {
                session.setAttribute("{codigoPais}", GetList(application,
                        "DTPAIS"));
                //Cragano los datos de DTABLA7

                session.setAttribute("{codigoMoneda}", GetList(application,
                        "DTABLA7"));
                //Cragano los datos de DMUNICIPIO
                session.setAttribute("{codigoMunicipioBeneficiario}", GetList(
                        application, "DMUNICIPIO"));

                //Cragano los datos de DTPAGO
                session.setAttribute("{formaPago}", GetList(application,
                        "DTPAGO"));
                //Cragano los datos de DTABLA1
                session.setAttribute("{tipoNegociacion}", GetList(application,
                        "DTABLA1"));

                //Cragano los datos de DTABLA8
                session.setAttribute("{tipoDocumentoVendedor}", GetList(
                        application, "DTABLA8"));

            } catch (Exception e) {
            }

        %>
<%@ include file="/body.jsp"%>
<%@ include file="./templates/1099.jsp"%>
<%@ include file="/footer.jsp"%>
