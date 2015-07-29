<div class="container">
    <div class="row">
        <div id="msgExito" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p>Su dispositivo de seguridad se ha registrado exitosamente.</p>
            <p><input type="button" class="btn btn-default" id="yes" value="Continuar" onclick="exito();"/></p>
        </div>

        <div id="msgsync" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p>Su dispositivo de seguridad se ha sincronizado exitosamente.</p>
            <p><input type="button" class="btn btn-default" id="yes" value="Continuar" onclick="exito();"/></p>
        </div>


        <div id="msgExitoReg" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p>Su dispositivo de seguridad se ha registrado exitosamente.</p>
            <p><input type="button" class="btn btn-default" id="yes2" value="Continuar" onclick="exito();" /></p>
        </div>

        <div id="esperar" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p>Por favor espere que se complete el proceso de registro.</p>
            <p>
                <img src="<html:rewrite page='/images/bigrotation2.gif'/>" />
            </p>
        </div>

        <div id="finEspera" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p>Ahora requerimos que genere una segunda clave siguiendo el mismo procedimiento para
                finalizar el proceso de sincronizacion.
            </p>
        </div>

        <div id="espera2" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p>Por favor espere que se complete el proceso de registro.</p>
            <p><img src="<html:rewrite page='/images/bigrotation2.gif'/>" /></p>
        </div>

        <div id="registro1" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p>Se ha registrado su clave. Ahora requerimos que genere
                una segunda clave siguiendo el mismo procedimiento
                para finalizar el proceso de registro.</p>
            <p>
                <input type="button" class="btn btn-default" id="yes2" onclick="yes2Click();" value="OK" />
            </p>
        </div>
    </div>
</div>