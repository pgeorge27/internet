<script type="text/javascript" src="../scripts/jquery.min.js"></script>
<script type="text/javascript" src="../scripts/jquery.blockUI.js?v2.38"></script>

<script type="text/javascript">
    $(document).ready(function() {

        $('#continuar').click(function() {
            $.blockUI({ message: $('#msgExito'), css: { width: '350px' } });
        });

        $('#continuarReg').click(function() {
            $.blockUI({ message: $('#msgExitoReg'), css: { width: '350px' } });
        });

        $('#espera').click(function() {
		    $.blockUI({ message: $('#espera2'), timeout: 2000, css: { width: '350px' } });
        });

        $('#yes').click(function() {
            // update the block message
        	$.unblockUI(); 
            return false; 
        });

        $('#yes2').click(function() {
            // update the block message
        	$.unblockUI(); 
        	document.forma.submit(); 
        });

        $('#espera30s').click(function() {
            $.blockUI({ message: $('#esperar'), css: { width: '400px' } });
            setTimeout(function() {
                $.unblockUI({
                    onUnblock: function(){
                        $.blockUI({ message: $('#finEspera'), css: { width: '400px' } })
                        setTimeout($.unblockUI, 3000);
                    }
                });
            }, 30000);
        });

        $('#registro30s').click(function() {
            $.blockUI({ message: $('#esperar'), css: { width: '400px' } });
            setTimeout(function() {
                $.unblockUI({
                    onUnblock: function(){
                        $.blockUI({ message: $('#registro1'), css: { width: '400px' } })
                    }
                });
            }, 30000);
        });

        $('#demo11').click(function() {
            $.blockUI({
                message: $('div.growlUI'),
                fadeIn: 700,
                fadeOut: 700,
                timeout: 2000,
                showOverlay: false,
                centerY: false,
                css: {
                    width: '350px',
                    top: '10px',
                    left: '',
                    right: '10px',
                    border: 'none',
                    padding: '5px',
                    backgroundColor: '#000',
                    '-webkit-border-radius': '10px',
                    '-moz-border-radius': '10px',
                    opacity: .6,
                    color: '#fff'
                }
            });
        });
    });
</script>