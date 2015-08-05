<div class="container">
    <div class="row" style="padding-right: 3%; padding-left: 3%;">

        <div id="msgExito" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p class="bienvenida">Su dispositivo de seguridad se ha sincronizado exitosamente.</p>
            <input type="button" class="btn btn-default" id="yes" value="Continuar" onclick="exito();"/>
        </div>

        <div id="msgExitoReg" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p class="bienvenida">Su dispositivo de seguridad se ha registrado exitosamente.</p>
            <input type="button" class="btn btn-default" id="yes2" value="Continuar" onclick="exito();" />
        </div>

        <div id="esperar" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p class="bienvenida">Por favor espere que se complete el proceso de registro.</p>
            <img src="<html:rewrite page='/images/bigrotation2.gif'/>" />
        </div>

        <div id="finEspera" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p class="bienvenida">Ahora requerimos que genere una segunda clave siguiendo el mismo procedimiento para finalizar el proceso de sincronizacion.</p>
        </div>

        <div id="espera2" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p class="bienvenida">Por favor espere que se complete el proceso de registro.</p>
            <img src="<html:rewrite page='/images/bigrotation2.gif'/>" />
        </div>

        <div id="registro1" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p class="bienvenida">Se ha registrado su clave. Ahora requerimos que genere una segunda clave siguiendo el mismo procedimiento para finalizar el proceso de registro.</p>
            <input type="button" class="btn btn-default" id="yes2" onclick="yes2Click();" value="OK" />
        </div>

    </div>
</div>