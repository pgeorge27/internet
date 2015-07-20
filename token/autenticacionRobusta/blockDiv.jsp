<div class="container">
    <div class="row">

        <div id="msgExito" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p class="bienvenida">Su dispositivo de seguridad se ha sincronizado exitosamente.</p>
            <p align="center"><input type="button" class="btn btn-default" id="yes" value="Continuar" /></p>
        </div>

        <div id="msgExitoReg" style="display:none; cursor: default">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p class="bienvenida">Su dispositivo de seguridad se ha registrado exitosamente.</p>
            <p align="center"><input type="button" class="btn btn-default" id="yes2" value="Continuar" onclick="exito();" /></p>

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
            <p align="center"><img src="<html:rewrite page='/images/bigrotation2.gif'/>" /></p>
        </div>

        <div id="registro1" style="display:none; cursor: default;">
            <img src="<html:rewrite page='/images/gancho02.gif'/>"/>
            <p class="bienvenida">Se ha registrado su clave. Ahora requerimos que genere una segunda clave siguiendo el mismo procedimiento para finalizar el proceso de registro.</p>
            <p align="center"><input type="button" class="btn btn-default" id="yes2" onclick="yes2Click();" value="OK" /></p>
        </div>

    </div>
</div>