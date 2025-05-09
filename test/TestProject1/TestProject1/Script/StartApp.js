function Main() {
  var paramCount = BuiltIn.ParamCount();
  if (paramCount > 0) {
    var ruta = BuiltIn.ParamStr(paramCount);
    Log.Message("Ruta recibida: " + ruta);

    // Creamos el comando con cambio de directorio y npm install
    var command = 'cmd.exe /c cd /d "' + ruta + '" && npm install && npm run start';

    // Ejecutamos el comando
    var shell = Sys.OleObject("WScript.Shell");
    shell.Run(command, 1, false); // 1 es para mostrar la ventana de CMD, true para esperar que termine
  } else {
    Log.Error("No se recibió ruta desde la línea de comando.");
  }
}
